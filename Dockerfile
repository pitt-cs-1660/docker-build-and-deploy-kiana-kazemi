FROM golang:1.23 AS build
WORKDIR /app
COPY go.mod . 
COPY main.go . 
COPY templates/ ./templates/


RUN CGO_ENABLED=0 go build -o /app/binary .


FROM scratch AS final
WORKDIR /app
COPY --from=build /app/binary ./binary
COPY --from=build /app/templates ./templates
CMD ["/app/binary"]