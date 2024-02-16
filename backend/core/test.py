import requests
import json
rq = requests.get('http://localhost:8000/update/1')
rq1 = requests.get('http://localhost:8000/get')
data = rq.text
data = json.loads(data)
print(type(data))
print(data['id'])
print(data['name'])

data = json.loads(rq1.text)

for i in data:
    print(i)
