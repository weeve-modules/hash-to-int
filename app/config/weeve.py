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
assert env("EGRESS_API_PORT")

WEEVE = {
    "MODULE_NAME": env("MODULE_NAME"),
    "HANDLER_HOST": env("HANDLER_HOST", "0.0.0.0"),
    "HANDLER_PORT": env("HANDLER_PORT", "80"),
    "EGRESS_API_PROTOCOL": env("EGRESS_API_PROTOCOL", "http"),
    "EGRESS_API_HOST": env("EGRESS_API_HOST"),
    "EGRESS_API_PORT": env("EGRESS_API_PORT", "80")
}

pprint(WEEVE)
