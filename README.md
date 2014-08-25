The Arb
=======

Summer 2014

This is the iOS version of the application for the Lillian Anderson Arboretum at Kalamazoo College. The app is intended to enhance the experiences of Arb visitors through a familiar platform. With a live trail guide and seasonally appropriate information, the app may assist users in having the most enjoyable and educational experience possible.


Map
---

The main view for the application is a map (from Google Maps SDK), zoomed so that the Arb’s property fills the width of the screen. The viewable area of the map (scrolling and zooming) is limited to the Arb and its immediate surroundings. The first thing the user should see when the app is opened is this screen with the trails displayed. More information can be added to this map, such as benches, trail markers, and points of interest.

A button in the top left corner of the map page discloses a menu with map options and actions for the user to take. There are options to add or remove trails, benches, and trail markers on the map, reset the map’s position, and clear the map’s drawings. Also from this menu, the user can navigate to a “Things to See” page, a History page, and a Contact page.


Things to See
-------------

On the “Things to See” page, a list of points of interest, specific species, etc. appropriate to the time of year the app is being used is displayed. The app sends an HTTP GET request to server_address/main.php?type=arb_items and parses the returned XML to dynamically create this list. This is started on a background thread after the app is launched.

The list displayed shows the name of the item, an image (which is found at server_address/Arb/images/[image_name]), and the beginning of its description (similar to what would be shown in the inbox of an email client). When the user touches an item, a detail page showing the full description is opened. This detail page has a button in the top right corner to display the items location on the main map, if appropriate.


History
-------

The History page gives a description of the history of the Arboretum.


Contact
-------

From the Contact page, the user can send comments, questions, requests, etc. to arboretum{at}kzoo{dot}edu through an email-like form. The user must input a valid email address, a subject, and a message. The app also logs the user’s location (provided it has access), and appends it to the message. This could be useful for area-specific comments and trail maintenance related information.

The app sends an HTTP POST request to server_address/mail.php with the parameters email=[input email address], subject=[input subject], message=[input message with appended location].

After the server has sent the message to the Arb, the user will receive a confirmation email indicating the message has been received.
