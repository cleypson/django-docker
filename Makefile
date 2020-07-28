migrate:
	docker-compose exec web python manage.py makemigrations
	docker-compose exec web python manage.py migrate

build:
	docker-compose build db
	docker-compose build web

run:
	docker-compose up -d db
	sleep 10
	docker-compose up web

stop:
	docker-compose stop web
	docker-compose stop db

test:
	docker-compose exec web python manage.py test