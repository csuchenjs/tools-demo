FROM golang:1.9.2

WORKDIR /go/src/app
# Copies only "main.go" file
COPY main.go .

RUN go-wrapper download
RUN go-wrapper install

EXPOSE 3000

CMD [ "app" ]
