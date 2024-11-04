variable "TAG" {
    default = "final"
}


group "default" {
    targets = ["backend","frontend"]
}

target "backend" {

    context = "./tour-of-heroes-api"
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:${TAG}"]
}

target "frontend" {

    context = "https://github.com/0GiS0/youtube-docker-bake.git#main"
    dockerfile = "tour-of-heroes-angular/Dockerfile.remote"

    args = {        
        "NGINX_VERSION" = "otel"
    }

    tags = ["tour-of-heroes-web:${TAG}"]
}