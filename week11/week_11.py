from pymongo import MongoClient
import datetime
client = MongoClient("mongodb://localhost")
Exercise 1
db = client['test']

list(db.restaurants.find({"cuisine": "Indian"}))
list(db.restaurants.find({"$or": [{"cuisine": "Indian"}, {"cuisine": "Thai"}]}))
list(db.restaurants.find({'address.street': 'Rogers Avenue', 'address.building': '1115'}))

Exercise 2
res=db.restaurants.insert_one({'address': {'building': '1480', 'street': '2 Avenue', 'zipcode': '10075', 'coord': [ -73.9557413, 40.7720266]}, 'borough': 'Manhatten', 'cuisine': 'Italian', 'name': 'Vella', 'restaurant_id': '41704620', 'grades': [{'date': '01 Oct, 2014', 'grade': 'A', 'score': 11}]})
res.inserted_id

Exercise 3
ex3_1=db.restaurants.delete_one({'borough': 'Manhatten'})
ex3_1
ex3_1.deleted_count
--1

ex3_2=db.restaurants.delete_many({'cuisine': 'Thai'})
ex3_2
ex3_2.deleted_count
--285

Exercise 4
def gradeCount(arr):
	Ct = 0
	for i in arr['grades']:
		if i['grade'] == 'C':
			Ct = Ct + 1
	return Ct
	
ex4 = list(db.restaurants.find({'address.street': 'Rogers Avenue'}))

for i in ex4:
	print(i['grades'])
	if (gradeCount(i) > 1):
		db.restaurants.delete_one({'_id': i['_id']})
	else :
        temp = i
        temp['grades'].append({'date': datetime.datetime(2015, 9, 27, 0, 0), 'grade': 'C', 'score': 11})
        db.restaurants.update_one({'_id': i['_id']}, {'$set': temp})
