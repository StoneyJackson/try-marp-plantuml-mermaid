---
marp: true
style: |
  .columns {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
  }
  img {
    min-width: 650px;
    max-width: 960px;
    min-height: 360px;
    max-height: 600px;
  }
  section {
    font-size: 20px;
  }
---

## Context

<div class="columns">
<div>

**GitHub**

Stores Git repositories in the cloud.

**Your Computer**

- Under your control.
- Physical, virtual, or remote.

</div>
<div>

<img src="canister-1-init.svg" style="width: 100px;">

</div>
</div>

---

## Upstream

<div class="columns">
<div>

- An existing project.
- Owned by someone else.
- You want to contribute to it.

</div>
<div>

<img src="canister-2-upstream.svg" style="width: 100px;">

</div>
</div>

---

## Fork

<div class="columns">
<div>

* Need a copy that you can change.
* **Fork**
  - GitHub operation
  - Creates a copy under your control
  - Your copy also lives on GitHub.
* We'll call your copy on GitHub **origin**. (Clarification comming.)

</div>
<div>

<img src="canister-3-fork.svg" style="width: 100px;">

</div>
</div>

---

## Clone

<div class="columns">
<div>

* Need a copy in your development environment.
* **Clone**
  - A Git operation.
  - Creates a copy of a repository on your local machine.
  - Git calls the cloned repository the **origin** of the clone.
* **WARNING**
  - Do not clone the **upstream** repository
  - Clone your **origin**.
  - You CANNOT save your changes to **upstream**.
  - You CAN save your changes to **origin**.

</div>
<div>

<img src="canister-4-clone.svg" style="width: 100px;">

</div>

---

## Ready

<div class="columns">
<div>

You're ready to find something to work on!

</div>
<div>

<img src="canister-5-ready.svg" style="width: 100px;">

</div>