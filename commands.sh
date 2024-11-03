# Call bake
docker buildx bake

# If you want to use a diferent configuration file
docker buildx bake --file bake-multiple-platforms.hcl

# Check if an image is built for multiple platforms
docker inspect 


# If you want to use a diferent configuration file
docker buildx bake --file bake-remote-repos.hcl





