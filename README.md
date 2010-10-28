# PingMon: A stupid local-networking host 'ping' monitoring tool

One day at work I needed to periodically ping a host on our local network. Then I
thought it would be great (well... just nice) that if the pings were being unsuccessful be notified by email.

I was learning Ruby by the time and, instead of writing a simple shell script and set a cron job 
I thought... *maybe I could write a script in Ruby for this*, *maybe I could practice
TDD and write some tests*, *I could even create a gem and learn how it's done*, etc.

And this is the result: A *stupid* monitoring tool which periodically pings a host at your reach.

### Installation

  gem install pingmon

### Usage

More blah, blah

### External Dependencies

PingMon depends on the following gems:

- [eventmachine](http://github.com/eventmachine/eventmachine) ~> 0.12.10
- [rufus-scheduler](http://github.com/jmettraux/rufus-scheduler) ~> 2.0.6
- [pony](http://github.com/adamwiggins/pony) ~> 1.0.1

Notes:

- [eventmachine](http://github.com/eventmachine/eventmachine) and [rufus-scheduler](http://github.com/jmettraux/rufus-scheduler) are used when doing "pings" in monitor mode.
- Pony adds the mail sending logic
- This requirements are specified in the gemspec as well.

---

Coded by Estanislau Trepat, released under the MIT License: [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)

