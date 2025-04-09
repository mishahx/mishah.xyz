# mishahx

![](https://github.com/mishahx/mishahx.xyz/workflows/website-ci/badge.svg)

👋 Welcome to **mishahx** — a quiet forge of ideas, experiments, and engineering craftsmanship.

This is my the portfolio website. You can reach me on below contact info.

## Building

**Pipeline**: <https://github.com/mishahx/mishahx.xyz/actions/new>

### Targets

- `$ make build`

  It generates the `build/` directory with below structure.
    ```shell script
        build/
          |- *.tf
          |- website/
    ```

- `$ make plan`

  Execute command `$ terraform init && terraform plan`.

- `make apply`

  Execute command `$ terraform apply`.

- `make clean`

  It will delete the `build/` directory.



## Contact

- **Maintainer**: mishalshah92@gmail.com