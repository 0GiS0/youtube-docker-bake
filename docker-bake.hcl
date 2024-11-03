target "default" {

    context = "./tour-of-heroes-api"
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:latest"]
}