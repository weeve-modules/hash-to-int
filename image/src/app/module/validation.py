"""
All logic related to the module's incoming data validation
Mostly this file requires changes
"""

from app.config import APPLICATION

from logging import getLogger

import re

log = getLogger(__name__)


def data_validation(data):
    """Validates the incoming JSON data

    Args:
        data ([JSON Object]): [This is the request body in json format]

    Returns:
        [str, str]: [data, error]
    """

    if not isinstance(data, dict):
        return None, 'Expected data type dict (from JSON)'
    if len(data) != 1:
        return None, 'Only 1 JSON record expected'
    if 'random hash' not in data.keys():
        return None, 'Strictly expect "random hash" as JSON key'
    if not (isinstance(data['random hash'], str)):
        return None, '"random hash" expected as string'
    if not len(data['random hash']) == 64:
        return None, 'Expected 64 characters in string'

    regex = r"^[a-fA-F0-9]+$"
    # print(re.match(regex, data['random hash']))
    if not re.match(regex, data['random hash']):
        return None, 'Non-hexadecimal characters found in string'

    return data, None
    # try:
    #     return float(data), None
    # except Exception as e:
    #     log.error(e)
    #     return None, 'Invalid INPUT_LABEL'
