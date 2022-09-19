# Pr message

The freeform option `services.lemmy.settings` generates a json configuration file for lemmy.
The option set for lemmy, includes a typical `database.createLocally`, which creates a database locally.
One would expect this option to be at the path `services.lemmy.database.createLocally` or similar.
However, it is currently at `services.lemmy.settings.database.createLocally`.
Its current path means that it ends up as part of the json configuration file that is passed into lemmy.
This was probably unintentional. Lemmy does not have  such an option.



We are not aware of a way to safely deprecate an option inside of a freeform attribute either with an alias, or deprecation.
