"""
All constants specific to weeve
"""
from app.utils.env import env
from pprint import pprint

assert env("MODULE_NAME")
assert env("EGRESS_API_HOST")
assert env("HANDLER_HOST")
assert env("HANDLER_PORT")
WEEVE = {
    "MODULE_NAME": env("MODULE_NAME"),
    "EGRESS_API_HOST": env("EGRESS_API_HOST"),
    "HANDLER_HOST": env("HANDLER_HOST"),
    "HANDLER_PORT": env("HANDLER_PORT"),
}

pprint(WEEVE)