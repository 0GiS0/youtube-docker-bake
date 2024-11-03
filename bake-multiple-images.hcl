group "default" {
    targets = ["backend","frontend"]
}

target "backend" {

    context = "./tour-of-heroes-api"
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:v2"]
}

target "frontend" {

    context = "./tour-of-heroes-angular"
    dockerfile = "Dockerfile.gh-copilot"

    args = {        
        "NGINX_VERSION" = "otel"
    }

    tags = ["tour-of-heroes-web:${add(123,1)}"]
}