target "default" {

    cache-to = [
        "type=local,dest=./cache"
    ]

    cache-from = [
        "type=local,src=./cache"
    ]

    context = "./tour-of-heroes-angular"
    dockerfile = "Dockerfile.gh-copilot"

    tags = ["tour-of-heroes-web:cache"]
}