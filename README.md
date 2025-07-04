# try-marp-plantuml-mermaid

This project provides a dev container for building slides using [Marp](https://marp.app/) for slides, [Mermaid](https://mermaid.js.org/) and [PlantUML](https://plantuml.com/) for diagrams, and [Jinja](https://jinja.palletsprojects.com/en/stable/) for templating/modularization.

This project is currently experimental.


## Try it!

1. Open this project in Codespace (or a local dev container).
2. Open a termainal (`CTRL+SHIFT+~`) and run `build.bash`.
3. Open "Go Live"  (`CTRL+L` then `CRTL+O`) and browse `build/`.


## Question or suggestion?

Chat with us on [Discord](https://discord.gg/x2Hn4BFFnW)


## Start a project based on this project

The easy way on GitHub...

1. Use this repository as a template to create a new repository on GitHub.
2. Start working in `src/`

The harder way:

1. Create a new repository.
2. Copy this repository's `.devcontainer` into its root.
3. Create a `.gitignore` into its root and add `build/` (or copy this repository's `.gitignore`).
4. Create a `src/` and put your content in it.


## `build.bash`

It's important to know how build.bash builds the project. Specifically, you need to know (1) what files are generated by each tool, and (2) the order tools are ran so that you know what files are available when a tool is ran.

`build.bash` does the following in order.

```mermaid
flowchart LR
    Reset --> Jinja --> Mermaid --> PlantUML --> Marp
```

1. **Reset:** Empty `build/` and then copy the contents of `src/` into `build/`.
2. **Jinja:** Run jinja on `*.j2` files in `build/`. Each file produces a file whose name is the same as the original file with the `.j2` extension removed. For example, `file.md.j2` produces `file.md`.
3. **Mermaid:** Run mermaid on `*.md` files that contain `mermaid: true`. Each diagram block in `file.md` produces a PNG file: `file.md-1.png`, `file.md-2.png`, etc.
4. **PlantUML:** Run plantuml on `*.md` files that contain `plantuml: true`. Each diagram block in `file.md` produces an SVG file. PlantUML has a vaguely defined number sequence for output file names (<https://plantuml.com/sources#:~:text=File%20naming,t%20match%20the%20output%20format.>). Instead of releying on those, we recommend naming each diagram: e.g., `@startuml name` produces `name.svg`.
5. **Marp:** Run marp on `*.md` files that contain `marp: true`. For each `file.md` produces `file.html`.


## Quick PlantUML

Given the file `hello_world.md` with contents

```markdown
---
plantuml: true      # Tell build to process this file with plantuml.
---

    ```plantuml
    @startuml hello
    ' This generates `hello.svg`
    class A {
    }
    @enduml
    ```

    ```plantuml
    @startuml world
    ' This generates `world.svg`
    A -> A
    @enduml
    ```
```

## Quick Mermaid

Given a file `hello_world.md` with contents

```markdown
---
mermaid: true      # Tell build to process this file with mermaid.
---

    ```mermaid
    %% Genaertes `hello_world.md-1.png`
    gitGraph
        commit
    ```

    ```mermaid
    %% Generates `hello_world.md-2.png`
    flowchart LR
        id
    ```
```

Notice Mermaid diagrams generate PNGs instead of SVGs. That's because we intend to include them inside of PlantUML diagrams. And right now PlantUML does not parse SVGs generated by Mermaid correctly.

## Quick Marp

Given the file `hi.md` with the contents

```markdown
---
marp: true          # Tell build to process this file with mermaid.
---

# Hello from PlantUML

![](hello.svg)

![](world.svg)

---

# Hello from Mermaid

![](hello_world.md-1.png)

![](hello_world.md-2.png)
```

Generates `hi.html`.

Place themes anywhere in src/.

## Quick Jinja

Given the file `hello.jinja` with contents

```jinja
{% macro hello(name) %}
Hello, {{name}}
{% endmacro %}
```

and the file `world.md.j2` with the contents

```jinja
{% import "hello.jinja" as world %}
---
marp: true
---

# Say hello

{{ hello("World") }}
```

Generates `world.md` with contents

```markdown
---
marp: true
---

# Say hello

Hello, World
```

Only `*.j2` files are processed. Other Jinja file types (e.g., `.jinja` and `jinja2`) are not directly processed. Use these extensions for libraries (e.g., macros, base templates, etc.)
