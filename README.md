#ddns-beacon

Simple bash script for free DDNS using a subdomain if you have a domain name through a major registrar (DigitalOcean, GoDaddy, etc.)  Currently only works with DigitalOcean because that's what I use, but easily adapted for other registrars' APIs (and I'll likely do that with this project in the near future.)  WAN IP is detected using OpenDNS; accuracy may vary with more complex setups, so be careful!  Open to changing this behavior in the future, but it works fine for my purposes.

##installing

```bash
mkdir ddns-beacon
cd ddns-beacon
git clone https://github.com/modestmark/ddns-beacon.git
```

##usage

run ddns-beacon.sh once on the host you want the DNS record pointing to, which will run you through the config script; after that just set it up as a cron job.  I run it every 15 minutes; don't worry, it only calls your registrar API if it detects a change in IP.
