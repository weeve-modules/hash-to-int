"""
Validates whether the incoming data has an acceptable type and structure.
"""

import re
from logging import getLogger

log = getLogger("validator")


def data_validation(data: any) -> str:
    """
    Validate incoming data i.e. by checking if it is of type dict or list.
    Function description should not be modified.

    Args:
        data (any): Data to validate.

    Returns:
        str: Error message if error is encountered. Otherwise returns None.

    """

    log.debug("Validating ...")

    if not isinstance(data, dict):
        "Expected data type dict (from JSON)"
    if len(data) != 1:
        "Only 1 JSON record expected"
    if "random hash" not in data.keys():
        'Strictly expect "random hash" as JSON key'
    if not (isinstance(data["random hash"], str)):
        '"random hash" expected as string'
    if not len(data["random hash"]) == 64:
        "Expected 64 characters in string"

    regex = r"^[a-fA-F0-9]+$"
    # print(re.match(regex, data['random hash']))
    if not re.match(regex, data["random hash"]):
        return "Non-hexadecimal characters found in string"
    return None
