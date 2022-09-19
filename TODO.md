# Pr message

The freeform option `services.lemmy.settings` generates a json configuration filefor lemmy. For some unknown reason, `services.lemmy.settings.database.createLocally` which is a typical idiom for creating a local database and is put inside of the generated json file, despite not having any meaning for the lemmy program.

We are not aware of a way to safely deprecate an option inside of a freeform attribute either with an alias, or deprecation.
