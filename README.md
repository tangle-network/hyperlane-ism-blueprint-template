# <h1 align="center"> Hyperlane ISM Blueprint 🌐 </h1>

**A Blueprint Template for Deploying Hyperlane Interchain Security Modules (ISMs) on Tangle Network**

## 📚 Overview

This blueprint is a template for deploying Hyperlane Interchain Security Modules (ISMs) on the Tangle network. It provides a starting point for developers to create and deploy their own ISMs on the Tangle network.

Hyperlane's ISM can be built to leverage any method to validate messages sent through Hyperlane, using multi-sigs, MPCs, zero-knowledge, and more. This template provides a starting place for developers to create their own ISMs using the Tangle Network's operator set.

The features included in this blueprint are:
- Multi-sig ISM support
- MPC ISM support

## 📚 Prerequisites

Before you can run this project, you will need to have the following software installed on your machine:

- [Rust](https://www.rust-lang.org/tools/install)
- [Forge](https://getfoundry.sh)
- [Tangle](https://github.com/tangle-network/tangle?tab=readme-ov-file#-getting-started-)

You will also need to install [cargo-tangle](https://crates.io/crates/cargo-tangle), our CLI tool for creating and
deploying Tangle Blueprints:

To install the Tangle CLI, run the following command:

> Supported on Linux, MacOS, and Windows (WSL2)

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/tangle-network/gadget/releases/download/cargo-tangle-v0.1.2/cargo-tangle-installer.sh | sh
```

Or, if you prefer to install the CLI from crates.io:

```bash
cargo install cargo-tangle --force # to get the latest version.
```

## 🚀 Getting Started

Once `cargo-tangle` is installed, you can create a new project with the following command:

```sh
cargo tangle blueprint create --name <project-name>
```

and follow the instructions to create a new project.

## 🛠️ Development

Once you have created a new project, you can run the following command to start the project:

```sh
cargo build
```

to build the project, and

```sh
cargo tangle blueprint deploy
```

to deploy the blueprint to the Tangle network.

For more details, please refer to the [project documentation](https://docs.tangle.tools/developers/blueprints).

## 📜 License

Licensed under either of

* Apache License, Version 2.0
  ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
* MIT license
  ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

## 📬 Feedback and Contributions

We welcome feedback and contributions to improve this blueprint.
Please open an issue or submit a pull request on
our [GitHub repository](https://github.com/tangle-network/blueprint-template/issues).

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
