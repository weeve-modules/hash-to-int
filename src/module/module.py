"""
This file implements module's main logic.
Data processing should happen here.

Edit this file to implement your module.
"""

from logging import getLogger
from typing import Tuple

log = getLogger("module")


def module_main(received_data: any) -> Tuple[int, str]:
    """
    Process received data by implementing module's main logic.
    Function description should not be modified.

    Args:
        received_data (any): Data received by module and validated.

    Returns:
        any: Processed data that are ready to be sent to the next module or None if error occurs.
        str: Error message if error occurred, otherwise None.

    """

    log.debug("Processing ...")

    hash_value = received_data["random hash"]

    try:
        integer = int(hash_value, 16)
        log.info(f"Converted {hash_value} into {integer}")

        return integer, None
    except Exception as e:
        log.error(e)
        return None, "Unable to perform the module logic"
