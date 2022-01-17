#!/bin/bash
cd /home/jetson/nvbit_release/tools/nvbitfi/pf_injector/
LD_PRELOAD=/home/jetson/nvbit_release/tools/nvbitfi/pf_injector/pf_injector.so /home/jetson/darknet/darknet classifier predict /home/jetson/darknet/LeNet/cfg/mnist.data /home/jetson/darknet/LeNet/cfg/mnist_lenet.cfg /home/jetson/darknet/LeNet/mnist_lenet.weights /home/jetson/darknet/LeNet/mnist_images/test/0_Five.png -t 10 > /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/stdout.txt 2> /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/stderr.txt cat nvbitfi-injection-log-temp.txt 

