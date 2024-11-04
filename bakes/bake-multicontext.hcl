target "default" {
  
  dockerfile = "Dockerfile.multicontext.remote"
  
  tags = ["halloween:v6"]
  
  contexts = {
    app = "halloween-content"
    config = "https://github.com/0GiS0/youtube-docker-buildx.git#main"
  }
  
}