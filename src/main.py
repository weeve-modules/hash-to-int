"""
Entrypoint file that sets up and starts REST API server for the module.
"""

from os import getenv
from logging import getLogger
from bottle import run
from api.log import setup_logging
from api.request_handler import request_handler

setup_logging()
log = getLogger("main")


def main():
    log.info(
        "%s running on %s at port %s with end-point set to %s",
        getenv("MODULE_NAME"),
        getenv("HOST_NAME"),
        getenv("HOST_PORT"),
        getenv("EGRESS_URLS"),
    )

    # start the server
    run(
        host=getenv("HOST_NAME"),
        port=getenv("HOST_PORT"),
        quiet=True,
    )


if __name__ == "__main__":
    main()
