# Hash to Int

|              |                                                                                           |
| ------------ | ----------------------------------------------------------------------------------------- |
| name         | hash-to-int                                                                         |
| version      | v1.0.1                                                                                    |
| docker image | [weevenetwork/hash-to-int](https://hub.docker.com/r/weevenetwork/hash-to-int) |
| tags         | Python, Flask, Docker, Weeve                                                              |
| authors      | Marcus Jones                                                                              |

# Developers

Run the dev-container.

Inside the container, run `make dev`.

The makefile loads the environment variables contained in `config.env` and `deploy.env`.

The makefile executes `nodemon main.py`.

# Testing manually

A manual test environment can be created using the simulated environment of a data service.

For manual testing, it is recommended to run the test in TMUX with 3 panes.

```
(                        Host Machine                                  )
                              (          Docker network               )
 [curl POST] --port-forward-> ( ->  [MODULE] -> [listening container] )

```

A processing module is only attached to a docker network and therefore has visibility / is visible only within that network. Create a docker network with `docker network create dtestnet`.

The egress side of the container is simulated with a simple webserver which echo the response and prints to the terminal.

Start the listening container to listen on the egress target port. Logging is enabled for debugging.

```bash
docker network create dtestnet
docker run --rm \
     --network=dtestnet \
     -e PORT=8000 \
     -e LOG_HTTP_BODY=true \
     -e LOG_HTTP_HEADERS=true \
     --name echo \
     jmalloc/echo-server
```

In a second terminal, run the module inside the same docker network. The module is exposed through port 9001 to the host machine.

```bash
docker run --rm \
     --network=dtestnet \
     -p 9001:9001 \
     -e EGRESS_URL="http://echo:8000" \
     -e MODULE_NAME=sha256-to-integer \
     -e MODULE_TYPE=PROCESS \
     -e INGRESS_PORT=9001 \
     -e INGRESS_PATH="/" \
     --name sha256-to-integer \
     weevenetwork/sha256-to-integer
```

In the third terminal, simulate the ingress side of the container by sending a hash value from the host into the docker network forwarded port;

```bash
curl --header "Content-Type: application/json" \
     --request POST \
     --data '{"random hash":"f36940fb3203f6e1b232f84eb3f796049c9cf1761a9297845e5f2453eb036f01"}' \
     localhost:9001
```

# Notes

This module strictly enforces the input data to be exactly of the form;

`{'random hash': '<sha 256 hash>'}`

Where `<sha 256 hash>` is a SHA 256 hash represented by a hex string such as;

`f36940fb3203f6e1b232f84eb3f796049c9cf1761a9297845e5f2453eb036f01`

`7080736e138ff40d7809467bf330be8f66e2a04deb0876c50ea04945dc13327c`

The module will return the integer representation of this byte string in the following form;

`{'256 byte integer':'<int>'}`
