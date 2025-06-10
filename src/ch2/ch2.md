---
marp: true
theme: jobs
style: |
    :root p {
        font-size: 32px;
    }
    ul ul {
        font-size: 0.75em;
    }
    section {
        padding: 28px;
        align-content: start;
    }
---

# GitKit Chapter 2

---


# GitHub

- GitHub
  - Stores Git repositories in the cloud.
  - Manages access (e.g., accounts, permissions)
- Upstream
  - An existing repository you want to contribute to.
  - You don't own it; you can't change it.
- Goal
  - Need a copy that you can change.


![bg right:60% width:100%](fork-clone-1-github.svg)

---

# Fork

- Fork
  - GitHub operation
  - Makes a copy on GitHub
- Origin
  - The new copy on GitHub.
  - You control; you can change.
  - Why "origin"? Coming soon.
- Challenge
  - GitHub is not a dev environment

![bg right:60% width:100%](fork-clone-2-fork.svg)

---

# Dev Environment

- Contains development tools
  - Editors, compilers, testers, debuggers
- On a machine under your control
  - PC/Laptop
  - Remote server
  - Virtual machine
    - Docker, VirtualBox, VMWare
  - Remote virtual machine
    - Codespace, GitPod
- Goal:
  - Copy repo into dev environment.

![bg right:60% width:100%](fork-clone-3-devenv.svg)

---

# Clone

- **Clone**
  - A Git operation.
  - Copies repo into dev environment.
  - Git calls the cloned repo the **origin** of the clone.
- **IMPORTANT**
  - Do not clone **upstream**.
  - You cannot save your changes there.
  - Clone your **origin**.
  - You CAN save your changes there.

![bg right:60% width:100%](fork-clone-4-clone.svg)

---

# Ready

You're ready to find something to work on!

![bg right:60% width:100%](fork-clone-5-ready.svg)
