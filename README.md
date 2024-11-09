# Demos de Bake

¡Hola developer 👋🏻! Este repositorio contiene las demos de mi vídeo **15. Docker Builds como código**. Se trata de una herramienta, por ahora en fase experimental, que nos permite usar archivos para definir la configuración y los parámetros que tendrá nuestro comando `docker build` haciendo que incluso podamos lanzar múltiples build de forma concurrente con una sola invocación.


## 1. Configuración básica

Así sería el comando si no tuvieramos esta configuración:

```bash
docker build -t halloween:v1 .
```
El archivo `docker-bake.hcl`contiene la configuración para este caso. Para lanzarlo hay que usar este comando:

```bash
docker buildx bake
```

## 2. Construir más de una imagen a la vez

Imagínate que tienes que construir más de una imagen a la vez. Con Bake puedes hacerlo de forma sencilla. En lugar de lanzar estos dos comandos:

```bash
docker build -t tour-of-heroes-api:v1 tour-of-heroes-api
docker build -t tour-of-heroes-web:v1 -f tour-of-heroes-angular/Dockerfile.gh-copilot tour-of-heroes-angular
```

En el archivo `bake-multiple-images.hcl` se muestra cómo sería la configuración para este caso.

Para lanzarlo hay que usar este comando:

```bash
docker buildx bake --file bakes/bake-multiple-images.hcl
```

## 3. Generar imágen multiplataforma

Una de las ventajas de usar BuildKit es que podemos generar imágenes multiplataforma:

```bash
docker build --platform linux/arm64,linux/amd64,linux/386 -t halloween:v3 .

docker images --tree
```

Si quisieramos hacer esto mismo con Bake, la configuración sería la que se muestra en el archivo `bake-multiple-platforms.hcl`.

```bash
docker buildx create --name mybuilder --use 

docker buildx bake --file bakes/bake-multiple-platforms.hcl --load # --load does not work in ARM machines

docker images --tree
```

### 4. Imágenes con múltiples contextos

Otra de las opciones avanzadas que podemos utilizar con BuildKit es la de poder tener múltiples contextos. En este caso, por ejemplo, podríamos tener un contexto local y otro remoto:

```bash
docker build \
--build-context app=./halloween-content \
--build-context config=https://github.com/0GiS0/youtube-docker-buildx.git#main \
-t halloween:v5 \
-f Dockerfile.multicontext.remote .
```

En el archivo bake-multicontext.hcl se muestra cómo sería la configuración para este caso.

```bash
docker buildx bake --file bakes/bake-multicontext.hcl
```

Para probar el resultado puedes lanzar el siguiente comando:

```bash
docker run --name halloween -p 8080:80 -d halloween:v6
docker rm -f halloween
```


## 5. Usar otros builders que no sea el por defecto

Si por ejemplo queremos usar un builder de Docker Build Cloud lo hacemos así:

```bash
docker buildx create --driver cloud 0gis0/returngis

docker build --builder cloud-0gis0-returngis -t tour-of-heroes-api:v3 tour-of-heroes-api
```

Y lo equivalente en bake estaría en el archivo `bake-other-builders.hcl`.

```bash
docker buildx bake --file bakes/bake-other-builders.hcl --builder cloud-0gis0-returngis
```


## 6. Exportar e importar caché

Y ya por último, si quisieramos exportar/importar la cache, el comando sería:

```bash
docker build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-to type=local,dest=./cache --cache-from type=local,src=./cache -t tour-of-heroes-web:v3 .
```

Y la configuración equivalente en bake estaría en el archivo `bake-cache.hcl`.

```bash
docker buildx bake --file bakes/bake-cache.hcl --load
```

## 5. Comprobar que un archivo bake está bien definido

Puedes usar el parámetro `--check` para comprobar que el archivo bake está bien definido:

```bash
docker buildx bake --file bakes/bake-cache.hcl --check
```

## 6. Combinación de todos los ejemplos

Y si juntamos todos los ejemplos en algo que pudiera ser un ejemplo real, tendríamos algo así:

```bash
docker buildx bake --file bakes/bake-final.hcl
```

























ect
docker buildx bake --call check --file bakes/bake-cache.hcl
```

## 5. Monstruo final

Y si juntamos todos los ejemplos en algo que pudiera ser un ejemplo real, tendríamos algo así:

```bash
docker buildx bake --file bakes/bake-final.hcl
```

¡No te olvides de darle una estrella 🌟 al repositorio si te ha gustado el contenido! Y de suscribirte a mi canal de YouTube ❤️

¡Nos vemos! 👋🏻