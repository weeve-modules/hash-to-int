"""
All logic related to the module's main application
Mostly only this file requires changes
"""

from logging import error, getLogger
log = getLogger(__name__)

def module_main(parsed_data):
    """implement module logic here

    Args:
        parsed_data ([JSON Object]): [The output of data_validation function]

    Returns:
        [string, string]: [data, error]
    """
    hash_value = parsed_data['random hash']
    try:
        integer = int(hash_value, 16)
        log.info(f"Converted {hash_value} into {integer}")
        return integer, None
    except Exception as e:
        log.error(e)
        print(e)
        return None, "Unable to perform the module logic"
