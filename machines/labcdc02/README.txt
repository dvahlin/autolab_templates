#Work in progress

Recomended setup, labafw01, labcdc02


This server generates a random populated Active Directory. There is a high possibility that it is exploitable, but not a gurantee, due to the factor of random.
This is a template that is depending on two projects.

You need to first install Autolab, (you need to run Centos on your host machine)
https://gitlab.com/mon/autolab
Download iso form microsoft eval center, 17763.253.190108-0006.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso , place under /var/lib/libvirt/images.

For the random populated AD, there is a modified version of badblood in the installation process.
https://github.com/davidprowe/BadBlood

For adjustments in number of users and computers, check out data-iso/stages/5-populate-badblood-ad/Invoke-BadBlood.ps1, adjust for your usecase

To add your own passwords adjust the following file:
data-iso/stages/5-populate-badblood-ad/AD_Users_Create/Passwords/test.txt

All users get a password with the function get-random from the file above. 

SPN accounts gets passwords from:
data-iso/stages/5-populate-badblood-ad/AD_SPN_Create/passwords.txt

