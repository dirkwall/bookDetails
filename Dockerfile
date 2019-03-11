FROM golang:stretch as builder
WORKDIR /go/src/github.com/dirkwall/bookDetails
RUN go get -d -v github.com/gorilla/mux
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-linkmode=external' -o bookDetails main.go 
#CMD ["./bookDetails"]

FROM golang:alpine
COPY --from=builder /go/src/github.com/dirkwall/bookDetails/bookDetails /usr/bin/
CMD ["/usr/bin/bookDetails"]
EXPOSE 8000
