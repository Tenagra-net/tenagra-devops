# DevOps Toolkit.

---

The DevOps Toolkit (TDK) is a toolchain that includes everything needed to bootstrap and develop a production
environmen.

## Quick Start

### Prerequisites

- Git (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Docker (https://docs.docker.com/engine/install/)
- Powershell (Windows) or Bash (Linux / MacOS)

### Running

1. Clone this repository: `git clone <git repo url>`
2. Enter the repo directory: `cd tenagra-devops`
3. Verify the build script (`build.sh` or `build.ps1`) is executable.
4. Run the executable `./build`

After running the build script, it will drop you into a development shell. To verify this you should see:

```bash
root@TDKShell:/source#
```

### Options

The build script has several options that enable and disable certain features:

> - If you are using Powershell, prefix your option with `-` (IE: `noshell` -> `-noshell`)
> - If you are using Bash, prefix your option with `--` (IE: `noshell` -> `--noshell`)


| Option    | Description                                                               |
|-----------|---------------------------------------------------------------------------|
| `noshell` | Starts up the services in the background, does not open foreground shell. |
| `http`    | Starts up an NGINX instance, used as an image/config source.              |
| `tftp`    | Starts up a HPA TFTP instance, used as an image/config source.            |
| `dnsmasq` | Starts a DNSMASQ instance. Used for bootstrapping.                        |
