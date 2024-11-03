variable "TAG" {
    default = "v1"
}

target "default" {

    context = "./tour-of-heroes-api"
    
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:${TAG}"]
}