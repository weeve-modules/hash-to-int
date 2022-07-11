"""
All constants specific to weeve
"""
from app.utils.env import env
from pprint import pprint

# assert env("MODULE_NAME")
# assert env("INGRESS_HOST")
# assert env("INGRESS_PORT")
# assert env("EGRESS_SCHEME")
assert env("EGRESS_URL")
# assert env("EGRESS_PORT")

WEEVE = {
    "MODULE_NAME": env("MODULE_NAME", "sha-256-to-integer"),
    "MODULE_TYPE": env("MODULE_TYPE", "PROCESS"),
    "INGRESS_HOST": env("INGRESS_HOST", "0.0.0.0"),
    "INGRESS_PORT": env("INGRESS_PORT", "80"),
    "INGRESS_PATH": env("INGRESS_PATH", "/"),
    "EGRESS_URL": env("EGRESS_URL", "http")
}

pprint(WEEVE)
