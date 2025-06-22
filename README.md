From <https://gist.github.com/talmo/353c4bf86d5ceb89c1b873b486fad3cf>:

```bash
mkdir tensorflow && cd tensorflow
doas docker pull tensorflow/build:2.19-python3.12
doas docker run -it -w /tensorflow_src -v $PWD:/mnt -e HOST_PERMS="$(id -u):$(id -g)" tensorflow/build:2.19-python3.12 bash

# Inside the container
git clone https://github.com/tensorflow/tensorflow.git .
git checkout v2.19.0

# use python location: /usr/local/lib/python3.12/dist-packages
# use compile flags: -Wno-sign-compare -mno-avx2 -mno-avx -march=x86-64 -Wno-gnu-offsetof-extensions
# default for rest
./configure

bazel build //tensorflow/tools/pip_package:wheel --repo_env=WHEEL_NAME=tensorflow_cpu --config=opt

chown $HOST_PERMS bazel-bin/tensorflow/tools/pip_package/wheel_house/tensorflow_cpu-2.19.0-cp312-cp312-linux_x86_64.whl
cp bazel-bin/tensorflow/tools/pip_package/wheel_house/tensorflow_cpu-2.19.0-cp312-cp312-linux_x86_64.whl /mnt
```

To get the hash:

```bash
$ nix-hash --type sha256 --flat --base32 tensorflow_cpu-2.19.0-cp312-cp312-linux_x86_64.whl
12qz7lwf2knhxxn6yw3xvljahn8gz0zfl2kil9hkxm6mzp22xx40
```
