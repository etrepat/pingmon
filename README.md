# PingMon: A stupid local-networking host 'ping' monitoring tool

One day at work I needed to periodically ping a host on our local network. Then I
thought it would be great (well... just nice) that when the pings were unsuccessful
I would get notified by email.

I was learning Ruby at that time and, instead of writing a simple shell script and set a cron job
I thought... *Maybe I could write a script in Ruby for this*, *Maybe I could practice
writing some tests*, *I could even create a gem and learn how it's done*, etc.

And this is the result:

A *stupid* monitoring tool which periodically pings a host and sends an email
notification when it becomes unavailable.

*It's been done merely for learning purposes so don't be too harsh on the code.*

### Installation & Usage

1. Install the gem as usual by entering:
        $ gem install pingmon

2. PingMon needs a *YAML configuration file* to operate, which is usually:
`~/.pingmon.yml`. To make PingMon create that file for you, type:
        $ pingmon build-config

3. Edit `~/.pingmon.yml` to suit your needs.

4. Finally, type `pingmon` on your prompt and have fun! ;)

#### .pingmon.yml options

There are a number of options you can tweak in the `.pingmon.yml` config file. They
are pretty self-explanatory but I'll explain some of them here:

- **host:** specifies the host to 'ping' to.
- **mode:** PingMon operation mode which should be one of `monitor` or `ping`. In
`ping` mode, PingMon will ping the host specified one time only (for testing
purposes). When in `monitor` mode, PingMon will ping the host specified periodically
following the `monitor_interval` option.
- **monitor_interval:** when set to `monitor` mode it specifies the delay between
*pings* to check the host status. ex: Setting it to `15m` will ping the `host`
*every* 15 minutes.
- **notify_when_down:** `true` or `false`. Tells PingMon to send an email notification
when host can't be reached.
- **notify_to:** whom to notify (if more than one, comma separated). ex: `user@domain.com`
- **transport:** `:sendmail` or `:smtp`. `:sendmail` may only work on unix/linux OS
variants.
- **smtp_options:** when `transport:` is set to `:smtp` you should specify this
options. They are passed *as is* to `Pony.mail` method.

For more help, please take a look at the sample config file `config/pingmon.yml` or
at the one PingMon generates for you when you type `pingmon build-config` which is
usually located at: `$HOME/.pingmon.yml`.

### External Dependencies

PingMon depends on the following gems:

- [eventmachine](http://github.com/eventmachine/eventmachine) ~> 0.12.10
- [rufus-scheduler](http://github.com/jmettraux/rufus-scheduler) ~> 2.0.6
- [pony](http://github.com/adamwiggins/pony) ~> 1.0.1

Notes:

- [eventmachine](http://github.com/eventmachine/eventmachine) and [rufus-scheduler](http://github.com/jmettraux/rufus-scheduler) are used when doing "pings" in monitor mode.
- [Pony](http://github.com/adamwiggins/pony) adds the mail sending logic
- This requirements are specified in the gemspec as well.

---

Coded by Estanislau Trepat, released under the MIT License: [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)

