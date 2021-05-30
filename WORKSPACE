load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rust_rules {
# You *must* import the Rust rules before setting up the rust_image rules.
http_archive(
    name = "rules_rust",
    sha256 = "18c0a02a007cd26c3f5b4d21dc26a80af776ef755460028a796bc61c649fdf3f",
    strip_prefix = "rules_rust-467a301fd665db344803c1d8a2401ec2bf8c74ce",
    urls = [
        # Master branch as of 2021-04-23
        "https://github.com/bazelbuild/rules_rust/archive/467a301fd665db344803c1d8a2401ec2bf8c74ce.tar.gz",
    ],
)

load("@rules_rust//rust:repositories.bzl", "rust_repositories")

rust_repositories()
#}

http_archive(
    # Get copy paste instructions for the http_archive attributes from the
    # release notes at https://github.com/bazelbuild/rules_docker/releases
    name = "io_bazel_rules_docker",
    sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
    strip_prefix = "rules_docker-0.17.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
)

# OPTIONAL: Call this to override the default docker toolchain configuration.
# This call should be placed BEFORE the call to "container_repositories" below
# to actually override the default toolchain configuration.
# Note this is only required if you actually want to call
# docker_toolchain_configure with a custom attr; please read the toolchains
# docs in /toolchains/docker/ before blindly adding this to your WORKSPACE.
# BEGIN OPTIONAL segment:
# load(
#     "@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
#     docker_toolchain_configure = "toolchain_configure",
# )
# docker_toolchain_configure(
#   name = "docker_config",
#   # OPTIONAL: Path to a directory which has a custom docker client config.json.
#   # See https://docs.docker.com/engine/reference/commandline/cli/#configuration-files
#   # for more details.
#   client_config="<enter absolute path to your docker config directory here>",
#   # OPTIONAL: Path to the docker binary.
#   # Should be set explicitly for remote execution.
#   docker_path="<enter absolute path to the docker binary (in the remote exec env) here>",
#   # OPTIONAL: Path to the gzip binary.
#   gzip_path="<enter absolute path to the gzip binary (in the remote exec env) here>",
#   # OPTIONAL: Bazel target for the gzip tool.
#   gzip_target="<enter absolute path (i.e., must start with repo name @...//:...) to an executable gzip target>",
#   # OPTIONAL: Path to the xz binary.
#   # Should be set explicitly for remote execution.
#   xz_path="<enter absolute path to the xz binary (in the remote exec env) here>",
#   # OPTIONAL: List of additional flags to pass to the docker command.
#   docker_flags = [
#     "--tls",
#     "--log-level=info",
#   ],

# )
# # End of OPTIONAL segment.

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)
load(
    "@io_bazel_rules_docker//rust:image.bzl",
    _rust_image_repos = "repositories",
)

_rust_image_repos()

# https://kerkour.com/blog/rust-small-docker-image/

# container_pull(
#     # 'tag' is supported, but digest is encouraged for reproducibility.
#     name = "java_base",
#     # registry = "registry.hub.docker.com",
#     registry = "index.docker.io",
#     repository = "library/python",
#     tag = "3.9.5-buster",
#     # tag = "3.9.5-slim-buster",
#     # digest = "sha256:9fa920a5e22c494e2c879fee24f72ba0bb842b8e8e7376accd46b9b94e5fb7f1"
# )

# all the distroless image: https://console.cloud.google.com/gcr/images/distroless/GLOBAL
container_pull(
    name = "rust_base",
    digest = "sha256:c33fbcd3f924892f2177792bebc11f7a7e88ccbc247f0d0a01a812692259503a",
    registry = "gcr.io",
    repository = "distroless/cc",
    #tag = "latest",
)

load("//cargo:crates.bzl", "raze_fetch_remote_crates")

raze_fetch_remote_crates()
