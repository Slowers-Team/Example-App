FROM registry.access.redhat.com/ubi9/go-toolset

ENV TZ="Europe/Helsinki"

WORKDIR /opt/app-root/src

ARG BASE_PATH
ENV BASE_PATH=$BASE_PATH

ARG STAGING
ENV STAGING=$STAGING

ARG E2E
ENV E2E=$E2E

COPY . .

WORKDIR /opt/app-root/src/frontend
RUN \
    ls -lR && \
    npm install --unsafe-perm && \
    npm run build && \
    mkdir ../backend/client && \
    mv dist ../backend/client/

WORKDIR /opt/app-root/src/backend

EXPOSE 5001

CMD ["go", "run", "main.go"]
