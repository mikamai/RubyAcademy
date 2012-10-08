# TODO list!

## Usage

```bash
ruby bin/todo [TODO CONTENTS]
```


The list is stored in `~/.ra-todos`, it can be overridden by setting the `TODOLIST` environment variable:

```bash
TODOLIST="~/.ruby-academy.todos" ruby bin/todo [TODO CONTENTS]
```




## `todo`

```bash
$ todo
☐ prendi il latte
☐ lava i piatti
☐ leggi _why
```

```bash
$ todo fai la spesa
☐ fai la spesa
☐ prendi il latte
☐ lava i piatti
☐ leggi _why
```


## `done`
```bash
$ done
☑ fai la spesa

☐ prendi il latte
☐ lava i piatti
☐ leggi _why
```

```bash
$ done --list
☑ prendi il latte
☑ lava i piatti
☑ leggi _why
```

