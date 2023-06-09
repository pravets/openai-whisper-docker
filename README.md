# OpenAI Whisper in a Docker container

Whisper is a (set of) pre-trained, deep-learning model(s) released by OpenAI that transcribes audio in many languages to text (aka speech-to-text), including optional translation to English. It works incredibly well.

https://github.com/openai/whisper

This container works locally on your computer with full privacy (no communication with the internet) using the Python code from OpenAI. By using a Docker container, there is no need to install and setup Python and other dependencies on your computer. These are big machine learning models and it could take some time to do the transcription using the larger models depending on your hardware.



## Preliminaries

* [Install Docker Desktop](https://docs.docker.com/get-docker/) for Windows, Mac, or Linux.
* Optionally clone or copy this Git repository to your computer.



## Build the Docker image

Open a terminal and navigate to the cloned/copied directory containing the file `Dockerfile`, which contains the build instructions. Build the Docker image with:

```shell
docker build --tag whisper:latest .
```

Be sure to include the `.` character at the end (which tells Docker to look in the current directory for `Dockerfile`). Alternatively, if you don't want to clone or copy the repository you can build directly from GitHub like so (this command is all on one line):

```shell
docker build --tag whisper:latest https://github.com/brettmelbourne/openai-whisper-docker
```
The resulting image is about 16 GB in size:

```shell
docker images
```

The `Dockerfile` preloads all the models to the image. For a smaller image you can load a smaller set of models by commenting out those lines. If a model is not built into the Docker image you can still use it but it will be first downloaded from the Python repositories, taking some extra time each time you use it.

Manage images and containers using Docker Desktop.



## Process an audio file

Place the audio or video file (e.g. `test.wav`) you want to process in a directory on your computer. Files can be audio files such as `.flac`, `.wav`, `.mp3`, `.m4a` etc, or video files such as `.mp4`, `.mov`. Open a terminal (on Windows use [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install) or Powershell, not Command Prompt) and navigate to the directory, then:

```shell
docker run --rm --mount type=bind,src=$(pwd),target=/files --workdir /files whisper test.wav --model tiny.en
```

This will run a container using a [bind mount](https://docs.docker.com/get-started/06_bind_mounts/) to pass files from the directory on your computer through to the container, attaching the directory to the location `/files` within the container. The container will automatically be deleted after use (`--rm`). This example uses the `tiny.en` English specific model, which is the smallest and fastest model (but also the least accurate). The extracted text will be output to the screen and to the directory in various file formats.

The above Docker command should work on modern Linux, Mac, and Windows. If you have an older Windows Powershell, you might need a slightly different syntax (mind the quotes):

```powershell
docker run --rm --mount "type=bind,src=$pwd,target=/files" --workdir /files whisper test.wav --model tiny.en
```



## Variations

If you don't specify the model, the default `small` multilingual model will be used, which is a good compromise of accuracy and speed:

```shell
docker run --rm --mount type=bind,src=$(pwd),target=/files --workdir /files whisper test.wav
```

You can specify the input language and translate to English:

```shell
docker run --rm --mount type=bind,src=$(pwd),target=/files --workdir /files whisper test_sp.wav --language Spanish --task translate
```

See [whisper](https://github.com/openai/whisper) for more variations and/or print the help for the `whisper` command:

```shell
docker run --rm whisper --help
```



## Working within the container

You can also work from a bash prompt by starting the container like so (`-it` gives an interactive container;  `--entrypoint` sets to start in `bash`):

```shell
docker run -it --rm --mount type=bind,src=$(pwd),target=/files --workdir /files --entrypoint bash whisper
```

Then you can run whisper from the bash command line, as well as other Linux commands, e.g., here we'll transcribe a video and then add the subtitle text to the video:

```bash
whisper test.mp4 --model tiny.en
ffmpeg -i test.mp4 -hide_banner -loglevel error -i "test.srt" -c copy -c:s mov_text -y test_subtitled.mp4
```

When you're done, type `exit` to quit bash and close the container.



## Working with Python

Alternatively, start a bash container as above, then transcription can be performed within Python. Start Python from the bash prompt:

```bash
python
```

Then at the Python prompt enter Python code, e.g.

```python
import whisper

model = whisper.load_model("base")
result = model.transcribe("test.wav")
print(result["text"])
```

Type `quit()` to quit Python and return to the bash prompt then type `exit` to quit bash and close the container.
