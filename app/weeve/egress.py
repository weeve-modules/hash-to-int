""" Egress to the next module
"""
import json
import time
from requests import post
from app.config import APPLICATION, WEEVE

from logging import getLogger
log = getLogger(__name__)


def send_data(data: json, timestamp=time.time()) -> bool:
    """Sends data to the next module

    Args:
        data (json): [description]
        timestamp ([float], optional): [description]. Defaults to time.time().

    Returns:
        bool: If the data was sent properly
    """

    return_body = {
        APPLICATION['OUTPUT_LABEL']: data,
        "outputUnit": APPLICATION['OUTPUT_UNIT'],
        f"{WEEVE['MODULE_NAME']}Time": timestamp
    }
    egress_path = f"{WEEVE['EGRESS_API_PROTOCOL']}://{WEEVE['EGRESS_API_HOST']}:{WEEVE['EGRESS_PORT']}"
    log.info(f"Sending payload to {egress_path}")
    log.info(f"Payload: {return_body}")

    try:
        post(url=egress_path, json=return_body)
        return True
    except Exception as e:
        log.error(e)
        return False
