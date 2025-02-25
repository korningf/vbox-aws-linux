
═══════════════════════════════════════════════════════════════════════
# Manufakture vbox-aws-linux
═══════════════════════════════════════════════════════════════════════

<code> 

	#=============================================================================#
	# Manufakture vbox-aws-linux - Vagrant-provisioned AWS-provided linux
	#-----------------------------------------------------------------------------#

                                  _____        __      __                        
      _____ _____    ____  __ ___/ ____\____  |  | ___/  |_ __ _________   ____  
     /     \\__  \  /    \|  |  \   __\\__  \ |  |/ /\   __\  |  \_  __ \_/ __ \ 
    |  Y Y  \/ __ \|   |  \  |  /|  |   / __ \|    <  |  | |  |  /|  | \/\  ___/ 
    |__|_|  (____  /___|  /____/ |__|  (____  /__|_ \ |__| |____/ |__|    \___  >
          \/     \/     \/                  \/     \/                         \/ 


	#-----------------------------------------------------------------------------#
	# (c) Francis Korning 2025.
	#=============================================================================#
 	                                                                              
</code>		
	

# Ubuntu 22 Jammy, Vagrant provisioner, AWS EC2 machine, x64 arch.


This works as a 3-step process. 

First a dummy baremetal bootstrap dummy.box is bundled for a chosen AMI.

The bootstrap dummy.box is then manually added and launched via vagrant.

We then use vagrant to re-provision the dumy box with this Vagrantfile.

WARNING: The AMI and dummy.box must match - bundle a new dummy per AMI.


───────────────────────────────────────────────────────────────────────
# Preparation
───────────────────────────────────────────────────────────────────────
	
An AWS IAM user with an API access-key

  AWS VPC and IGW
  AWS EC2 routes 
  AWS SG allowing SSH
  

A baremetal AMI and a boostrap dummy.box bundled using bundler.

see: [https://github.com/korningf/vbox-aws-dummy]
 

───────────────────────────────────────────────────────────────────────
# Installation
───────────────────────────────────────────────────────────────────────

Install the vagrant-aws plugin

  vagrant plugin install vagrant-aws



───────────────────────────────────────────────────────────────────────
# Configuration
───────────────────────────────────────────────────────────────────────

```
 Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "YOUR ACCESS KEY ID"
    aws.secret_access_key = "YOUR SECRET KEY"
    aws.session_token = "SESSION TOKEN"
    aws.keypair_name = "KEYPAIR NAME"

    # ubuntu 12.04.2 LTS (precise pangolin)
    aws.ami = "ami-7747d01e"

    # ubuntu 24 LTS (noble numbat)
    # aws.ami = "ami-04b4f1a9cf54c11d0"
    
    # ubuntu 22 LTS (jammy jellyfish)
    # aws.ami = "ami-0e1bed4f06a3b463d"

    # aws-linux 2023
    # aws.ami = "ami-05b10e08d247fb927"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "PATH TO YOUR PRIVATE KEY"
  end
end
```
	

───────────────────────────────────────────────────────────────────────
# Operation
───────────────────────────────────────────────────────────────────────

 
First launch a bootstrap dummy.box

  vagrant box add dummy dummy.box


Re-provision the machine

	vagrant up -- provider=aws	
 
	vagrant ssh
	
	
───────────────────────────────────────────────────────────────────────
# Destruction
───────────────────────────────────────────────────────────────────────
	
	vagrant box remove  
	

───────────────────────────────────────────────────────────────────────
# Attribution
───────────────────────────────────────────────────────────────────────

  All the credit goes to Mitchel Hashimoto.
  
	see:  https://github.com/mitchellh/vagrant-aws
 
	
═══════════════════════════════════════════════════════════════════════
# (c) Francis Korning 2025.
═══════════════════════════════════════════════════════════════════════
