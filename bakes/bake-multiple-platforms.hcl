target "default" {  

    context = "."
    
    dockerfile = "Dockerfile"

    tags = ["halloween:v4"]

    no-cache = true

    platforms = ["linux/amd64", "linux/arm64", "linux/386"]
}