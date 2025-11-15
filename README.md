# Trimui Smart Pro Build System

A build system for creating applications for the Trimui Smart Pro. This build system provides a Dockerfile and a Makefile for building your application and necessary configuration files.

## Mac ARM (Apple Silicon) Support

This fork has been modified to work natively on Mac ARM (Apple Silicon) machines. Unlike the original x86-based build system that used the Linaro toolchain binaries, this version uses the native ARM cross-compiler (`aarch64-linux-gnu-g++`) available in Ubuntu's package repositories. 

**Key differences from the original:**
- Uses native `aarch64-linux-gnu-gcc/g++` from Ubuntu packages instead of the x86 Linaro toolchain
- The Linaro toolchain's `bin/` directory is disabled (renamed to `bin.disabled`)
- Compatible with Docker on Mac ARM without platform emulation overhead
- Maintains the same sysroot and libraries from the official Trimui SDK

## How to Build

This project uses a Docker-based build system.

### 1. Enter the Build Environment

Run the following command from the root of the project. This will build the Docker image if it doesn't exist and then drop you into a shell inside the container.

```bash
make run
```

### 2. Compile the Application

Once you are inside the Docker container's shell, you can compile the desired application. For example, to build the `Trimui-App`:

```bash
cd apps/Trimui-App && make
```

After building, the output will be located in the `build` directory on your host machine.

## Deploying to the Trimui Smart Pro

After building, the complete application will be in  `build/[APP_FOLDER]`. Copy the entire app folder to the `/SDCARD/Apps` folder on your Trimui Smart Pro.

## App Structure
```
build/[APP_FOLDER]/
├── Your_Compiled_App   # Your compiled app
├── icon.png            # Your app's icon
├── config.json         # App metadata
├── launch.sh           # Launch script
└── res/                # Resources
    └── arial.ttf       # App font
```

## Customizing Your Application

1. Edit the `APP_LABEL` and `APP_DESCRIPTION` variables in the Makefile
2. Replace the icon.png with your own app icon

## Controller Tester Application
The included `main.cpp` file is a controller testing app that allows you to visualize all the controller inputs for your device.
![Controller Tester Screenshot](readme/capture.png)
## License
Distributed under the MIT License. See `LICENSE` for more information.