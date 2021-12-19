"""Tests for get_company_details function"""
import json
import azure.functions as func
from get_company_details import main


def test_get_company_details():
    """Test get_company_details function"""
    # Arrange
    req = func.HttpRequest(
        method="GET",
        url="/api/get-company-details",
        body=None,
    )

    # Act
    res = main(req)

    # Assert
    assert res.status_code == 200
    assert json.loads(str(res.get_body(), "utf-8")) == {
        "name": "Contoso",
        "address": "Contosostrasse 1, Zurich, Switzerland",
    }
