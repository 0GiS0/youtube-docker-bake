# Demos de Bake

¡Hola developer 👋🏻! Este repositorio contiene las demos de mi vídeo **15. Docker Builds como código**. Se trata de una herramienta, por ahora en fase experimental, que nos permite usar archivos para definir la configuración, o los parámetros, que tendrá nuestro comando `docker build` haciendo que incluso podamos lanzar múltiples build de forma concurrente con una sola invocación.


## 1. Configuración básica

Así sería el comando si no tuvieramos esta configuración:

```bash
docker build -t tour-of-heroes-api:v1 tour-of-heroes-api
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
docker buildx bake --file bake-multiple-images.hcl
```

## 3. Generar imágen multiplataforma

```bash
docker build --platform linux/arm64,linux/amd64,linux/386 -t tour-of-heroes-api:v1 tour-of-heroes-api
```

La configuración equivalente a este comando sería `bake-multiple-platforms.hcl`. En este caso como no estamos utilizando el nombre `docker-bake.hcl`para el archivo de configuración habría que llamarlo de la siguiente forma:

```bash
docker buildx bake --file bake-multiple-platforms.hcl
```

### 4. Imágenes con múltiples contextos

Otra de las opciones avanzadas que podemos utilizar con BuildKit es la de poder tener múltiples contextos. En este caso, por ejemplo, podríamos tener un contexto local y otro remoto:

```bash
docker build \
--build-context app=./halloween-content \
--build-context config=https://github.com/0GiS0/youtube-docker-buildx.git#main \
-t halloween:multicontext-remote \
-f Dockerfile.multicontext.remote .
```

En el archivo bake-multicontext.hcl se muestra cómo sería la configuración para este caso.

```bash
docker buildx bake --file bake-multicontext.hcl
```

Para probar el resultado puedes lanzar el siguiente comando:

```bash
docker run --name halloween -p 8080:80 -d halloween:multicontext-remote 
docker rm -f halloween
```


## 5. Usar otros builders que no sea el por defecto

Si por ejemplo queremos usar un builder de Docker Build Cloud lo hacemos así:

```bash
docker build --builder 0gis0-cloud-returngis -t tour-of-heroes-api:v1 tour-of-heroes-api
```

Y lo equivalente en bake estaría en el archivo `bake-other-builders.hcl`.


## 6. Exportar e importar caché

Y ya por último, si quisieramos exportar/importar la cache, el comando sería:

```bash
docker build --build-arg BUILDKIT_INLINE_CACHE=1 --cache-to type=local,dest=./cache -t tour-of-heroes-angular .
```

Y la configuración equivalente en bake estaría en el archivo `bake-cache.hcl`.

```bash
docker buildx bake --file bake-cache.hcl
```

## 5. Comprobar que un archivo bake está bien definido

Puedes usar el parámetro `--check` para comprobar que el archivo bake está bien definido:

```bash
# Check that the configuration is correct
docker buildx bake --call check --file bake-cache.hcl
```

## 5. Monstruo final

Y si juntamos todos los ejemplos en algo que pudiera ser un ejemplo real, tendríamos algo así:

```bash
docker buildx bake --file bake-final.hcl
```

¡No te olvides de darle una estrella 🌟 al repositorio si te ha gustado el contenido! Y de suscribirte a mi canal de YouTube ❤️

¡Nos vemos! 👋🏻