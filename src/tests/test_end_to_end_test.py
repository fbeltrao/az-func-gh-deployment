import pytest
import requests

@pytest.fixture(scope="session")
def function_one_url():    
    function_name = "func-fbrfunc-one-stage"
    function_code = "fqyToaWNOHORPxWxVsjA3IaPkYQMhwEMZwmoQkvEx/K/9aIch4uoAQ=="
    return f"https://{function_name}.azurewebsites.net/api/get_company_details?code={function_code}"

def test_can_call_function_one(function_one_url: str) -> None:

    if not function_one_url:
        pytest.skip("No function_one_url provided")

    # Act
    res = requests.get(url=function_one_url)
    
    # Assert
    assert res.status_code == 200
    assert res.json() == {
        "name": "Contoso",
        "address": "Contosostrasse 1, Zurich, Switzerland"
        }
    