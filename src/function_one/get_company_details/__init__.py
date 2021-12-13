import logging
import json

import azure.functions as func
from contoso import get_company_address, get_company_name


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    return func.HttpResponse(
        json.dumps({
            "name": get_company_name(),
            "address": get_company_address()
        }),
        status_code=200
    )
