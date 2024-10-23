group "default" {
    targets = ["frontend", "backend"]
}

target "frontend" {

    context = "./tour-of-heroes-angular"
    dockerfile = "Dockerfile.gh-copilot"

    tags = ["tour-of-heroes-web:v1"]

    no-cache = true
    platforms = ["linux/amd64", "linux/arm64"]
}

target "backend" {

    context = "./tour-of-heroes-api"
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:v1"]

    no-cache = true
    platforms = ["linux/amd64", "linux/arm64"]
}