import pytest
import requests
from requests.adapters import HTTPAdapter
from urllib3 import Retry

@pytest.fixture(scope="session")
def function_one_url():    
    function_name = "<get-the-function-name>"
    function_code = "<get-the-function-code>"
    return f"https://{function_name}.azurewebsites.net/api/get_company_details?code={function_code}"

def test_can_call_function_one(function_one_url: str) -> None:

    if not function_one_url:
        pytest.skip("No function_one_url provided")

    # Act
    retry_strategy = Retry(
        total=3,
        status_forcelist=[429, 500, 502, 503, 504],
        allowed_methods=["HEAD", "GET", "OPTIONS"]
    )
    adapter = HTTPAdapter(max_retries=retry_strategy)
    http = requests.Session()
    http.mount("https://", adapter)
    http.mount("http://", adapter)

    res = http.get(url=function_one_url)
    
    # Assert
    assert res.status_code == 200
    assert res.json() == {
        "name": "Contoso",
        "address": "Contosostrasse 1, Zurich, Switzerland"
        }
    