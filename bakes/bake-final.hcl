variable "TAG" {
    default = "final"
}


group "default" {
    targets = ["backend","frontend"]
}

target "backend" {

    context = "https://github.com/0GiS0/youtube-docker-bake.git#main"
    dockerfile = "tour-of-heroes-api/Dockerfile.remote"

    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "tour-of-heroes-api:${TAG}",
        "internalcodespacesimages.azurecr.io/tour-of-heroes-api:${TAG}"
    ]    
}

target "frontend" {

    context = "./tour-of-heroes-angular"
    dockerfile = "Dockerfile.gh-copilot"

    args = {        
        "NGINX_VERSION" = "otel"
    }

    cache-to = [
        "type=local,dest=./cache"
    ]

    cache-from = [
        "type=local,src=./cache"
    ]

    platforms = ["linux/amd64", "linux/arm64"]
   
    tags = ["tour-of-heroes-web:${TAG}"]

}