# stm32-vscode-simple

a simple setup for hacking the stm32l476g with assembly in vscode.

## setup instructions

1. download xpack'd arm-none-eabi from [here](https://github.com/xpack-dev-tools/arm-none-eabi-gcc-xpack/releases/tag/v10.2.1-1.1). put it in ~/.comp2300/arm-non-eabi
2. download xpack'd openocd from [here](https://github.com/xpack-dev-tools/openocd-xpack/releases/tag/v0.10.0-15). put it in ~/.comp2300/openocd
3. (optional, if you want to use emulator) [build](https://gitlab.cecs.anu.edu.au/comp2300/2020/comp2300-disco-emulator) or otherwise acquire the discoserver binary, and put it at ~/.comp2300/discoserver
4. (if you're on windows) install the st-link drivers from [here](https://cs.anu.edu.au/courses/comp2300/v_media/resources/stlink-windows-driver.zip)
4. open this repo in VSCode!
