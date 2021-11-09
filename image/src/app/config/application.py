"""
All constants specific to the application
"""
from app.utils.env import env


APPLICATION = {
    # "INPUT_LABEL": env("INPUT_LABEL", "temperature"),
    "OUTPUT_LABEL": 'integer',
    "OUTPUT_UNIT": 'integer',
}
