from bs4 import BeautifulSoup
import time
import requests

url = 'https://www.blockchain.com/btc/unconfirmed-transactions'
r = requests.get(url)
soup = BeautifulSoup(r.content, 'lxml')

table = soup.findAll('div', attrs={'class': "sc-1g6z4xm-0"})
hash_list = [0] * 4
max_amount = 0

for tr in table:
	row = tr.findAll('div', attrs={'class': 'sc-6nt7oh-0 kduRNF'})

	current_USD = float(row[3].text.strip('$').replace(",", ""))

	if current_USD >= max_amount:
		max_amount = current_USD
		hash_list[0] = row[0].text
		hash_list[1] = row[1].text
		hash_list[2] = row[2].text
		hash_list[3] = str(current_USD)

	if max_amount > 0:
		log_file = "logfile.txt"
		line = '\t' .join(hash_list)
		f = open(log_file, "a+")
		f.write(line + "\n")

	while True:
		os.system("main.py")
		time.sleep(60)
