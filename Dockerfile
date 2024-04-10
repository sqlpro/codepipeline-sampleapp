FROM public.ecr.aws/amazoncorretto/amazoncorretto:17 as builder
WORKDIR application
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM public.ecr.aws/amazoncorretto/amazoncorretto:17
WORKDIR application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./

ARG FEATURE_DB
RUN echo $FEATURE_DB
ENV FEATURE_DB=$FEATURE_DB

EXPOSE 8080
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
