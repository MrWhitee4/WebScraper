# Web Scraping JavaScript with Python

The code shows how to do web scraping dynamic content pages generated from Javascript using Python.

We use as data the Blockchain site to extract stats information and generate a text file .

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

## Prerequisites

What things you need to install the software and how to install them

* Python 3.x
* Time
* BeautifulSoup
* Selenium
* bs4
* Request
* Ubuntu
* Geckodriver - necessary for Firefox :)
* Firefox

### User Guide:

Run the script <b>InstallandRun.sh</b> from the WebScraperMongoDB folder. This will automatically run the InstallMongoDB.sh and main.py.

### InstallMongoDB.sh

Installs MongoDB and creates a user "admin" with password "admin".

### InstallandRun.sh

Runs InstallMongoDB then installs necessary python libraries if not already installed. Then it starts main.py.

### main.py

Creates and writes the material to MongoDB database. There is a constant log of transactions with the transaction details for highest sum of the transaction of Bitcoin listed on https://www.blockchain.com/btc/unconfirmed-transactions.
