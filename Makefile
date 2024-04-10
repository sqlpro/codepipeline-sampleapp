app-name := "member-app"

run:
	./gradlew bootRun

build.application:
	@./gradlew bootJar

build.docker: build.application
	@docker build -t ${app-name}:latest .

.PHONY: build
build: build.docker

.PHONY: guard-%
guard-%:
	@#$(or ${$*}, $(error $* is not set))
