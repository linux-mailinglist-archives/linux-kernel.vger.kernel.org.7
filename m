Return-Path: <linux-kernel+bounces-883586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BEC2DCDB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644D43B941B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92B02CCC5;
	Mon,  3 Nov 2025 19:08:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3131B87C0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196929; cv=none; b=WlbLa/XhCfQgZ3n42No8riVudrItFre6+ZUx2X7BzlnedE0qb986z2+vwgAfPjwcGcdZvjaDMnV7FFi7G4qbvtLKdND7LSotRpTxgqU+tWf2XtMLMJQmG5DafJ6iZEo5sWY2Gs5rBbu6wu8hh3bkRimQSY5I+Q2pJZC0nMCJqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196929; c=relaxed/simple;
	bh=822mfqDqtZsDE5JjprSZ30+DzSrzKwyi84lemenXZ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ0X6l7paCr+hFe+9yhYfd37xErTOG6T3s2PSUnvsQ+RywdvGCQkcoMtBDztUHB5HY1IdjCvZq09/6LygIjCiaetrz/HIdnQbcb1WO5C63V9Sy7QiCuV0lUkIVJ/8emFwdrIM+DICSXrNKJlev0cXK+oG4/rlufUF6S0+VNbkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vFzuV-0005Ix-Sm; Mon, 03 Nov 2025 20:08:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vFzuV-006uSu-0X;
	Mon, 03 Nov 2025 20:08:11 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vFzuV-00Gl3y-0A;
	Mon, 03 Nov 2025 20:08:11 +0100
Date: Mon, 3 Nov 2025 20:08:11 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Message-ID: <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-10-27, Pankaj Gupta wrote:
> On 25-09-27, Pankaj Gupta wrote:
> >> Highlight:
> >>
> >> There are long discussion at V18 with Marco Felsch.
> >> https://lore.kernel.org/imx/AM9PR04MB8604F5A7DD8B1E41FDAD09039501A@AM9PR04MB
> >> 8604.eurprd04.prod.outlook.com/
> >>
> >> The key point is about using OP-TEE OS.
> >>
> >> Marco's questions:
> >> =================
> >> Q1. Both MU(s) from each world - Secure & Non-secure, cannot be used
> >>     simultaneously. Why?
> >> A1. ELE FW fix is available, where concurrent access to ELE from both the
> >>     world is working. This fix is not required for the current patch-set for
> >>     i.MX8ULP.
> > According https://github.com/OP-TEE/optee_os/pull/7268/commits/83b516edc0270ca8300ce524a0c3d560e67a0f48#r1955899462
> > there is no fix yet. Can you please point me to the fixed version?
> 
> It is not yet up-streamed to OPTEE-OS repo.

My intention of adding the above OP-TEE discussion link was to point out
that an ELE-FW bug exists which needs to be fixed.

> Fix version is part of NXP LF Q3 released on 30 September.
> Commit can be found on this URL: https://github.com/nxp-imx/imx-optee-os/commits/lf-6.12.34_2.1.0/.

I assume you meant the following commit:
 - https://github.com/nxp-imx/imx-optee-os/commit/039f15017cea38c401f908e0e1662ba8806ed4e3

This adapts the timeout value to 100ms and seems more like an
workaround.

However, can NXP confirm that the ELE concurrent access is possible
without a previous ELE FW update?

> One more fix is coming in LF Q4. After that, these patches will
> up-streamed to OP-TEE-OS.
>
> Then you will be able locate it in OPTEE-OS git repo.

Thanks for the sharing the links :)

> Since the current Patch-set is for i.MX8ULP, where concurrent access
> from both the world is not possible.

> In context to i.MX93, for OPTEE-OS patches, request you to please
> discuss in OPTEE community. Not here.

Sure, as said above, my intention was to point out that concurrent
access is not possible with the current ELE-FW. At least my knowledge
was that it was/is a ELE FW issue and not an OP-TEE issue.

> > Also, can you please outline why the fix is not required for i.MX8ULP?
> > Unfortunately I can't remember.
>
> There is no Trust-MU for OPTEE-OS in i.MX8ULP. The ELE driver in
> OPTEE, is disabled for i.MX8ULP.

Hm.. I thought there will be always two communication MUs one for the
secure-world and one for the non-secure world? Or what did you mean by:

"""
From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for each
world - Linux(one or more) and OPTEE-OS (one or more).
"""

(ref.:https://lore.kernel.org/all/AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com/)

Does this mean that all i.MX9x, i.MX10x and so on do have the the
secure and non-secure MU setup? Or is it based on the SoC release date?
Because regarding the datasheet the i.MX8ULP is newer than the i.MX93,
therefore I assumed that the i.MX8ULP has two MUs as well.

I checked the the NXP OP-TEE source code and found the following commit:

8<----------------
commit 44388d37e68000ee50a9b1d656e0a60ae6614977
Author: Sahil Malhotra <sahil.malhotra@nxp.com>
Date:   Tue Apr 1 20:04:44 2025 +0200

    core: imx: disable ELE on i.MX8ULP by default
    
    On i.MX8ULP, there is only one MU to communicate with ELE,
    which cannot be dedicated on OP-TEE side all the time.
    There may be ELE services running on Linux side, which can
    cause conflict with OP-TEE, So disabling ELE by default.
    Moreover i.MX8ULP also has CAAM, so HUK and Random number
    are coming from CAAM.
    
    Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
    Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
8<----------------

So it's possible to configure the XRDC (configured in the TF-A) in a way
to map the ELE access to the secure world. If I got the TF-A and OP-TEE
commits right.

To me this sound more like a NXP design decision to move the ELE to the
non-secure and the CAAM to the secure world.

> Moreover, there is CAAM in i.MX8ULP, which is used for security
> services, in OPTEE-OS.

i.MX8ULP is getting really interesting, though.

May I ask what RoT is used by this SoC if there are two?


> >> Q2. How is the secure and non-secure world talk to the ELE if there is only
> >>     one MU?
> >> A2. From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for
> >>     each world - Linux(one or more) and OP-TEE OS (one or more). Has updated
> >>     the commit message of 3/7.
> 
> > Does apply to the i.MX8ULP SoC as well?
>
> No. Since there is no trust-MU for OPTEE-OS, on i.MX8ULP, to
> communicate with ELE.

As said above it would be possible to move the ELE communication to the
secure world.

> > The NXP name scheme isn't very easy to follow.
> 
> >> Q3. How exactly do the eFuse write access after the device was locked down,
> >>     will be provided with single path; for the following case?
> >>     - For a verified boot setup, you need to burn an eFuse at some point,
> >>     to tell the bootROM to boot only correct verified firmware images.
> >>     - After this lockdown, it's no longer possible to burn eFuses from the
> >>     REE, while the production line setup still requires the support.
> >> A3. OP-TEE OS supports read fuses, currently as part of our quarterly release.
> >>     Write fuse will be in coming release. Please note that the current patch-
> >>     set does not contain any read/write eFuse feature.
> 
> > But one of your patches is mention it, right? So there will be still two
> > paths.
> Due to lack of trusted-mu, there is no way to read/write fuse on i.MX8ULP, from OPTEE-OS.
> For current patch-set, it is the single path.

How does the i.MX8ULP fuse flow work, after the LOCK_DOWN fuse is blown?

This was one of my main concers why having OP-TEE required in the first
place, because the i.MX93 requires the that the fuse-request comes from
the secure-world if the device is in LOCK_DOWN state.

Is this also the case for the i.MX8ULP?

> > Also according your IOCTL docuementation you want to expose the whole
> > device to the user-space?
> 
> > | What:          /dev/<se>_mu[0-9]+_ch[0-9]+
> > | Date:          Mar 2025
> > | KernelVersion: 6.8
> > | Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
> > | Description:
> > |                NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
> > |                Enclave(ELE), SECO. The character device file descriptors
> > |                /dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
> > |                enclave shared library and the kernel driver.
> > |
> > |                The ioctl(2)-based ABI is defined and documented in
> > |                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > |                ioctl(s) are used primarily for:
> > |                        - shared memory management
> > |                        - allocation of I/O buffers
> > |                        - getting mu info
> > |                        - setting a dev-ctx as receiver to receive all the commands from FW
> > |                        - getting SoC info
> > |                        - send command and receive command response
>                                 ^
> > This is a rather uncommon approach. The kernel has interfaces to
> > abstract hardware. You completely bypass this if you expose everything
> > to the userspace.
> 
> It is in-correct.
> Not everything, just exposed file-operation. and ioctl(s) for DMA(eable) buffer allocation from reserved lower memory region.
> Things managed by Kernel:
> * Send/receive path to ELE, is managed by Kernel.
> * Receive/send patch to the ELE's slave NVM-manager, is managed by kernel.
> * Low power management handled by kernel driver. In case of low-power state, ELE driver re-init the V2X IP as part of resume.
> * Other kernel management layers like NVMEM, kernel HWRNG, will use the api(s) exposed by this driver.

But you also expose an uAPI which allows the user to bypass everything
via sending arbitrary commands, right?

> * Loading the runtime FW.
> >
> >> Q4. What is the ELE behavior if the secure-world stresses the ELE? Is there
> >>     a MU priority so the normal-world MU may get blocked (never addressed)
> >>     or are both MUs scheduled in round-robin?
> >> A4. ELE will pick the message from Both MU(s), based on FIFO.
> 
> > This doesn't answer my question. How gets the FIFO filled? If the one of
> > both worlds aways keep the MU busy?
> 
> If both the world is keeping the MU busy. ELE will pick the first incoming message, let's say on MU#1,
> While acknowledge and queueing the incoming message on the other MU#2, to be picked once
> the handling of the current message at hand is completed. Despite the MU#1, is bombarded
> With next message, but it will process the message from MU#2, while acking the incoming message
> from MU#1. And add it to its queue. This way FIFO is maintained by ELE.

:) Thanks for the explanation.

> >> Q5. Why ELE performance matters?
> >>     - On i.MX8M, which uses the CAAM (the ELE predecessor), It can be
> >>     verified that the ARMv8 CE are much faster than the crypto-engine itself.
> >>     Therefore the CAAM is mostly unused.
> >> A5. User looks for both type of implementation based on their usecase:
> >>     - Certain users still offload to CAAM, to save their ARM CPU cycles for
> >>     other priority tasks.
> 
> > I have never seen such designs but okay.
> I assure you, there are several such cases with our system-engineering team.
> 
> >>     - While certain customer choose ARM-CE for the crypto offloads for better
> >>     performance.
> >>     As far as ELE is concerned, it is not a crypto accelerator like CAAM.
> >>     Performance hungry crypto-ops are not recommended to be offloaded to ELE.
> 
> > I don't get this point. So NXP doesn't recommend to use the ELE for
> > crypt-ops?
> NXP does not recommend to offload the Crypto-Op to ELE, for performance cases.

Good to know, thanks.

> >> Q6. For the IOT-cases where real-time encrypted feed from sensors, will take
> >>     latency hit, Does the ELE support inline en-/decryption?
> >> A6. Yes, ELE support Inline Encryption Engine (IEE), starting i.MX95 onwards.
> 
> > May I ask, how is this connected and which interfaces are connected to
> > the IEE? I would have checked it by myself but unfortunately NXP doesn't
> > provide a TRM for the i.MX95 yet.
> We can discuss this in greater depth on one-one email, where I will touch upon the IEE and its interfaces.
> But, like to inform that there is not IEE on i.MX8ULP or even on i.Mx93.

Sure, thanks.

> >> Marco's Suggestions/NXP response:
> >> ================================
> >> S1. Below listed ELE access requirements, can be done from OP-TEE OS in all
> >>     the Life-Cycle states. then Why to use Linux?
> >>     - eFuse access (done via  OP-TEE OS i.MX specific PTA): OTP eFuse R/W access
> >>     after doing the LOCK_DOWN fuse is no longer possible without  OP-TEE OS. This
> >>     involves general purpose (GP) eFuses too.
> >>     - ELE ping every 1 day (kernel SMC WDG driver, OP-TEE OS wd driver).
> >>     - HW-RNG (kernel HWRNG driver + OP-TEE OS HWRNG PTA).
> >> R1. There are i.MX9* users, that are not using OP-TEE OS, but still want
> >>     to use ELE features from Linux. So, these users are requesting for this
> >>     driver in Linux.
> 
> > Which ELE features?
> All the features from Linux, when OPTEE-OS is not present like:
> * Read/write efuses. (eg NVMEM Kernel driver). Where there is no requirement to chenge the eFuse, during SoC in provision lifecycle.

Some features require the device to be in LOCK_DOWN mode, which requires
secure-world eFuse write path only afterwards. But it seems like NXP
really wants to maintain two write paths.

> * Low power management at Linux driver.

The power-modes are selected via the ELE?

> * Linux HWRNG.
> * Loading the secondary runtime fw.

What is a secondary runtime-fw?

> >>     As suggested by you, writing to eFuse after life-cycle closed state, the
> >>     driver in OP-TEE OS is needed.
> >>     Though there are other OP-TEE OS features too, that needs to be offloaded
> >>     to HSM, for security reasons, like:
> >>     - Hardware Unique Key(HUK) getting generated.
> >>     - OP-TEE OS's ASLR seed generation.
> 
> > We're talking about features the normal world wants to have access too,
> > since you said ".. but still want to use ELE feature from Linux ..". The
> > HUK and the TEE ASLR seed is clearly not something Linux wants to have
> > access too.
> You misunderstood my point. I was stressing that there is a need for two paths,
> each from Linux and OPTEE-OS, in order to expose different feature-set required
> by respective worlds, where 1 or 2 overlaps, while maximum are utilized by respective
> worlds.
> 
> >> S2. Having one implementation is beneficial in the following ways:
> >>     - Multiple paths also requires more maintain- and testing effort.
> >>     - FW files with having +1 FW for the new i.MX9*, where there are plenty
> >>       already eg.: bootloader, TF-A, ele-fw, scu-fw (i.MX95), increases the
> >>       maintenance on both the paths.
> >>     - TEE code could be reused by other OSes.
> >>     - TEE is used anyway for new projects due to CRA and friends
> >> R2. As conveyed in R1, there are Linux only users, that are dependent on SE
> >>     Linux kernel driver.
> 
> > What difference does it make if these Linux-only users get the ELE
> > access via OP-TEE? It's just one binary more.
> If the User does not choose to include optional OPTEE-OS, then ELE access
> must be from Linux driver.

Okay, I think we're going in circles here.

> >> S3. Having one implementation is beneficial in the following ways:
> >>     - Adding the support for it to  OP-TEE OS do not requires ELE-FW.
> 
> > I never said that this requires no ELE FW! I said it requires no ELE-FW
> > update! Was the update already rolled out?
> Yes, the updated FW is already release part of LF Q3 released on September 30, 2025.
> It is not released as part any open repo.

So there is no ELE-FW update required to have both worlds running
concurrently.

> >>     - Concurrent access handling is done by the TEE core.
> >> R3. As already mentioned that ELE FW fix is available, for concurrent access.
> >>     Please note that FW fix is not required for the current patch-set.
> 
> > Can you provide us a link to the fix please? The fix should fix the
> > concurrent normal-world <-> secure-world MU access issue. Why is this
> > fix not required if I have a running OP-TEE?
> The fix is very much required to run concurrent access for i.XM93 and onwards.
> But not for i.MX8ULP and current patch-set is based on i.MX8ULP.

I see, the i.MX8ULP has only on MU. As said above my assumption was that
all ELE SoCs do have at least 2-MUs.

> >> S4. This series causes more confusions till the ELE FW fix is available to
> >>     allow concurrent access to ELE from both the worlds.
> >> R4. FW fix is already available, and concurrent access is enabled by default
> >>     in LF Q3'25, release. Please note that FW fix is not required for the
> >>     current patch-set.
> 
> > Please provide a link to the new FW and why is the fix nor required for
> > this patchset?
> Again. The fix is very much required to run concurrent access for i.XM93 and onwards.
> But not for i.MX8ULP and current patch-set is based on i.MX8ULP.

My bad, as said: my assumption was that all ELE SoCs do have at least
two MUs.

> >> S5. Suggesting to add the  OP-TEE OS support for the required features e.g. eFuses,
> >>     watchdog, HWRNG. The whole Linux part is mostly in place.
> >> R5. Yes, the secure world features like eFuse read/write will be added
> >>     to OP-TEE OS. Please note that this patch-set does not contain any read/write
> >>     eFuse feature.
> 
> > I see, instead it expose the whole ELE to the userspace if I got it
> > correct according to your IOCTL documentation. This would be even worse.
> No, it is not a correct interpretation. As mentioned above, ELE driver abstract
> all the hw interaction to have easy and simple file bases operations.

But still, the user can send arbitrary commands to the ELE right?

To conclude this longly discussion:

My main concern was the concurrent access for the 2-MUs cases. This can
be closed, as it turns out NXP fixed/workarounded this by increasing the
ELE communication timeout to 100ms.

I still have mixed feeling about the fusing (including the 1-MU case),
since it requires a secure-world OS in place once the LOCK_DOWN fuse was
burned. It's fine by me if NXP wants to have and wants to maintain a
multi-path here.

Last but least, the uAPI which can be used to send arbitrary ELE
commands seems unusual. But I don't know how secure-enclaves are
abstracted within the kernel, so these are just my two cents.

I'm looking forward to the maintainers feedback.

Regards,
  Marco


> 
> > Regards,
> > Marco
> 
> Regards,
> Pankaj
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

