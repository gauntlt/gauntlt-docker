# gauntlt-docker
the docker for gauntlt


## Setup

1. Clone this repo
  ```
  git clone https://github.com/gauntlt/gauntlt-docker.git 
  ```

2. Build the docker container

  ```
  $ cd /path/to/cloned/repo/gauntlt-docker
  $ make build
  ```

2. Copy binary stub to somewhere in your $PATH (like `/usr/local/bin`)`
  ```
  $ make install
  ```

3. Test it out with a `gauntlt-docker --help`

