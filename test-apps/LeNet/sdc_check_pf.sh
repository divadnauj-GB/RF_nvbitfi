#!/bin/bash
#read -n 1
diff /home/juancho/Documents/GitHub/Ampere_NVBit/nvbit_release/tools/RF_nvbitfi/test-apps/LeNet/stdout.txt /home/juancho/Documents/GitHub/Ampere_NVBit/nvbit_release/tools/RF_nvbitfi/test-apps/LeNet/golden_stdout.txt > stdout_diff.log
diff /home/juancho/Documents/GitHub/Ampere_NVBit/nvbit_release/tools/RF_nvbitfi/test-apps/LeNet/stderr.txt /home/juancho/Documents/GitHub/Ampere_NVBit/nvbit_release/tools/RF_nvbitfi/test-apps/LeNet/golden_stderr.txt > stderr_diff.log
