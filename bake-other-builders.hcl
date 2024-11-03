variable "TAG" {
    default = "v3"
}

target "default" {

    context = "./tour-of-heroes-api"
    
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:${TAG}"]

    builder = "0gis0-cloud-returngis"
}