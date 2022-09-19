# Pr message

The freeform option `services.lemmy.settings` generates a json configuration file for lemmy.
The option set for lemmy, includes a typical `database.createLocally`, which creates a database locally.
One would expect this option to be at the path `services.lemmy.database.createLocally` or similar.
However, it is currently at `services.lemmy.settings.database.createLocally`.
Its current path means that it ends up as part of the json configuration file that is passed into lemmy.
This was probably unintentional. Lemmy does not have such an option.

We noticed that `mkRenamedOptionModule` fails in this case. We figured it was because `services.lemmy.settings` is a freeform option module. We assume that `mkRemovedOptionModule` would fail as well. Can we receive confirmation on these assumptions?
