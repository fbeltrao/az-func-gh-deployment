from setuptools import setup, find_packages


setup(
    name="contoso",
    version="0.1",
    description="Contoso library",
    url="https://contoso.com",
    author="Contoso",
    maintainer="Contoso",
    install_requires=[],
    author_email="",
    packages=find_packages(exclude=["tests"]),
    zip_safe=False,
)
