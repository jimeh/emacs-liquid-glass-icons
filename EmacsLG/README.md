# EmacsLG App

Currently it looks like only Xcode 26 is capable of producing the `Assets.car`
file which is required for applications on macOS to use the new Liquid Glass
icon format.

Hence, this is a blank macOS app Xcode project, with only the LG icons added.

We extract the `Assets.car` file by building the application and grabbing it
from `Contents/Resources` within the built EmacsLG application.
