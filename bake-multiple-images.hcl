group "default" {
    targets = ["frontend", "backend"]
}

target "frontend" {

    context = "./tour-of-heroes-angular"
    dockerfile = "Dockerfile.gh-copilot"

    args = {
        "NODE_ENV" = "production"
        "NGINX_VERSION" = "otel"
    }

    tags = ["tour-of-heroes-web:latest"]
}

target "backend" {

    context = "./tour-of-heroes-api"
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:latest"]
}