init-dev: venv-setup gen-keys db-setup


gen-keys:
	openssl genrsa -out privkey.pem 2048
	openssl rsa -in privkey.pem -pubout -out pubkey.pem

venv-setup:
	virtualenv venv && source venv/bin/activate && pip install -r requirements.txt

db-setup:
	rm -f db.sqlite3
	./venv/bin/python manage.py migrate
	echo "from django.contrib.auth.models import User; User.objects.filter(email='admin@example.com').delete(); User.objects.create_superuser(email='admin@example.com', username='admin', password='password123')" | ./venv/bin/python manage.py shell

runserver:
	./venv/bin/python manage.py runserver