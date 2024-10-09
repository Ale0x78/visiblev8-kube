ENGINE=docker
REPO=example.com

flower_image:
	cd flower; $(ENGINE) build . -t $(REPO)/insecure_flower:latest ; $(ENGINE) push $(REPO)/insecure_flower:latest
celery_workers_image:
	cd celery_workers; $(ENGINE) build -f vv8_worker.dockerfile -t $(REPO)/vv8_crawler_worker:latest .; $(ENGINE) push $(REPO)/vv8_crawler_worker:latest; $(ENGINE) build -f log_parser.dockerfile -t $(REPO)/log-parser-worker:latest .; $(ENGINE) push $(REPO)/log-parser-worker:latest
backend_image:
	cd backend; $(ENGINE) build . -t $(REPO)/vv8_backend:latest; $(ENGINE) push $(REPO)/vv8_backend:latest
vv8_backend_database_image:
	cd vv8_backend_database; $(ENGINE) build . -t $(REPO)/vv8_database:latest; $(ENGINE) push $(REPO)/vv8_database:latest 

all: flower_image celery_workers_image backend_image vv8_backend_database_image
