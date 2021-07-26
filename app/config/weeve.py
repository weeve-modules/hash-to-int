"""
All constants specific to weeve
"""
from app.utils.env import env
from pprint import pprint

assert env("MODULE_NAME")
assert env("HANDLER_HOST")
assert env("HANDLER_PORT")
assert env("EGRESS_API_PROTOCOL")
assert env("EGRESS_API_HOST")
assert env("EGRESS_PORT")

WEEVE = {
    "MODULE_NAME": env("MODULE_NAME"),
    "HANDLER_HOST": env("HANDLER_HOST"),
    "HANDLER_PORT": env("HANDLER_PORT"),
    "EGRESS_API_PROTOCOL": env("EGRESS_API_PROTOCOL"),
    "EGRESS_API_HOST": env("EGRESS_API_HOST"),
    "EGRESS_PORT": env("EGRESS_PORT")
}

pprint(WEEVE)