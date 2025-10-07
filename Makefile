build-image:
	docker build -t alma-emcc:latest .

run-image:
	docker run -it --rm alma-emcc:latest
