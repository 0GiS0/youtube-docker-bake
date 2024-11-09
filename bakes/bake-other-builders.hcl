variable "TAG" {
    default = "v5"
}

target "default" {

    context = "./tour-of-heroes-api"
    
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:${TAG}"]
}