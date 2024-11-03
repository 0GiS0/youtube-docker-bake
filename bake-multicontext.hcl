target "default" {
  dockerfile = "Dockerfile.multicontext.remote"
  tags = ["halloween:multicontext-remote"]
  contexts = {
    app = "halloween-content"
    config = "https://github.com/0GiS0/youtube-docker-buildx.git#main"
  }
}