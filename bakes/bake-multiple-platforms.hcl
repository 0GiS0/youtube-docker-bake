target "default" {  

    context = "."
    
    dockerfile = "Dockerfile"

    tags = ["halloween:multi-platforms"]

    platforms = ["linux/amd64", "linux/arm64", "linux/386"]
}



£