{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "localai";

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/scripts/
  scripts.up.exec = "devenv up";

  enterShell = ''
    [ ! -d .venv] && uv venv
    source .venv/bin/activate
    uv pip install jinja2 mlx-lm chainlit openai
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep "2.42.0"
  '';

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/languages/
  languages.python.enable = true;
  languages.python.uv.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  processes = {
    server.exec = "python -m mlx_lm.server --model mlx-community/Meta-Llama-3-8B-Instruct-4bit --log-level DEBUG";
    ui.exec = "chainlit run ui.py";
  };

  # See full reference at https://devenv.sh/reference/options/
}
