target "default" {  

    context = "./tour-of-heroes-api"
    
    dockerfile = "Dockerfile"

    tags = ["tour-of-heroes-api:v1"]

    no-cache = true

    platforms = ["linux/amd64", "linux/arm64"]
}