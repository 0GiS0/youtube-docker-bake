variable "TAG" {
    default = "v2"
}

target "default" {

    context = "."
    
    dockerfile = "Dockerfile"

    tags = ["halloween:${TAG}"]
}