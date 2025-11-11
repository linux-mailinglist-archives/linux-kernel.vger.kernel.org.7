Return-Path: <linux-kernel+bounces-895485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465FC4E12E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0164C3A698C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AE331219;
	Tue, 11 Nov 2025 13:15:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337E3AA1A0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866902; cv=none; b=ZpCer0kRxZlbpYZH95teA0FzPsEzWlHQtBivL6ZWSsQ2zNoWFD/XB/tcocydTyPy9LlpZvo3bpO/j8VzYgPsvGpzgGA/l1ntXyMEuNyRyIva5wqyjhD9bs2PMrf/ESVy4KaO2RCTkCs7U6zcwGwVs0hEVxIrrGiKBMu7aKtrDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866902; c=relaxed/simple;
	bh=GN7fmS+BcfMHnCm95PcqkbpgkBF9dqX4+guaCrRt7vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoYPazCOjcftWpQM22k9+5N/zQVzTKcVQZ4b5Ec2c/4nN5c1AgMzZrCNfb+NhEx9l5kE/d3SeISh6O1gClglq2PHIX+22+RhRt/WbVxmwUOIWzm7CM75mGKjG3cNWQMj+oiN/ZOZCFK525Hf9qOsA+QqISk059kGKWem9Jua/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIoCo-00019I-NP; Tue, 11 Nov 2025 14:14:42 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIoCo-008CyB-0n;
	Tue, 11 Nov 2025 14:14:42 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIoCo-00EV9P-0M;
	Tue, 11 Nov 2025 14:14:42 +0100
Date: Tue, 11 Nov 2025 14:14:42 +0100
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
Message-ID: <20251111131442.nddhk3475oapf2zh@pengutronix.de>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
 <AM9PR04MB8604AA80EC97E06AADBF334695C3A@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604AA80EC97E06AADBF334695C3A@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-11-07, Pankaj Gupta wrote:
> >> On 25-10-27, Pankaj Gupta wrote:
> >>> On 25-09-27, Pankaj Gupta wrote:

...

> > > It is not yet up-streamed to OPTEE-OS repo.
> > 
> > My intention of adding the above OP-TEE discussion link was to point 
> > out that an ELE-FW bug exists which needs to be fixed.

...

> > This adapts the timeout value to 100ms and seems more like an workaround.
> > 
> There are additional fixes in OPTEE-OS, that will be part of LF Q4'25.

Thanks for this info.

> > However, can NXP confirm that the ELE concurrent access is possible 
> > without a previous ELE FW update?
> 
> Fix in the ELE FW, released as part of LF Q3 2025,  is a must to
> include. OPTEE fixes are also needed.  OPTEE fixes will be up-streamed
> soon.

Okay, so there are ELE-FW fixes too, thanks.

...

> > Does this mean that all i.MX9x, i.MX10x and so on do have the the 
> > secure and non-secure MU setup? Or is it based on the SoC release date?
> > Because regarding the datasheet the i.MX8ULP is newer than the i.MX93, 
> > therefore I assumed that the i.MX8ULP has two MUs as well.
> 
> From i.MX93 and onward, there is only one RoT. Hence , it is designed
> to have dedicated MU for each world.

Okay.

> > I checked the the NXP OP-TEE source code and found the following commit:
> > 
> > 8<----------------
> > commit 44388d37e68000ee50a9b1d656e0a60ae6614977
> > Author: Sahil Malhotra <sahil.malhotra@nxp.com>
> > Date:   Tue Apr 1 20:04:44 2025 +0200
> > 
> >     core: imx: disable ELE on i.MX8ULP by default
> > 
> >     On i.MX8ULP, there is only one MU to communicate with ELE,
> >     which cannot be dedicated on OP-TEE side all the time.
> >     There may be ELE services running on Linux side, which can
> >     cause conflict with OP-TEE, So disabling ELE by default.
> >     Moreover i.MX8ULP also has CAAM, so HUK and Random number
> >     are coming from CAAM.
> > 
> >     Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> >     Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> > 8<----------------
> > 
> > So it's possible to configure the XRDC (configured in the TF-A) in a 
> > way to map the ELE access to the secure world. If I got the TF-A and OP-TEE commits right.
> > 
> > To me this sound more like a NXP design decision to move the ELE to 
> > the non- secure and the CAAM to the secure world.
>
> As per the i.MX8ULP boot-up sequence and ELE's initial role in
> boot-up, with CAAM co-exists, ELE is logical to be with Linux.
>
> Another point here that CAAM has 4 JR(s) and hence CAAM can be shared
> between Linux and OPTEE-OS.

Please see my answer below where you explained the ELE functions.

...

> > i.MX8ULP is getting really interesting, though.
> > 
> > May I ask what RoT is used by this SoC if there are two?
> > 
> ELE is Root of Trust during secure boot.
> For OPTEE-OS, CAAM is RoT.

The i.MX8ULP is very interesting, since you also need to handle the
SoC secure-state twice, right? However, this topic alone is worth it a
standalone discussion thread, therefore no further comments.

...

> > How does the i.MX8ULP fuse flow work, after the LOCK_DOWN fuse is blown?
> There is no such issue on i.MX8ULP
> > 
> > This was one of my main concers why having OP-TEE required in the 
> > first place, because the i.MX93 requires the that the fuse-request 
> > comes from the secure-world if the device is in LOCK_DOWN state.
> > 
> > Is this also the case for the i.MX8ULP?
> > 
> 
> No, this is not a valid case for i.MX8ULP.

Thanks for the input.

> > > > Also according your IOCTL docuementation you want to expose the 
> > > > whole device to the user-space?
> > >
> > > > | What:          /dev/<se>_mu[0-9]+_ch[0-9]+
> > > > | Date:          Mar 2025
> > > > | KernelVersion: 6.8
> > > > | Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
> > > > | Description:
> > > > |                NXP offers multiple hardware IP(s) for secure 
> > > > | enclaves like
> > EdgeLock-
> > > > |                Enclave(ELE), SECO. The character device file descriptors
> > > > |                /dev/<se>_mu*_ch* are the interface between 
> > > > | userspace NXP's
> > secure-
> > > > |                enclave shared library and the kernel driver.
> > > > |
> > > > |                The ioctl(2)-based ABI is defined and documented in
> > > > |                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > > > |                ioctl(s) are used primarily for:
> > > > |                        - shared memory management
> > > > |                        - allocation of I/O buffers
> > > > |                        - getting mu info
> > > > |                        - setting a dev-ctx as receiver to 
> > > > | receive all the commands
> > from FW
> > > > |                        - getting SoC info
> > > > |                        - send command and receive command 
> > > > | response
> > >                                 ^
> > > > This is a rather uncommon approach. The kernel has interfaces to 
> > > > abstract hardware. You completely bypass this if you expose 
> > > > everything to the userspace.
> > >
> > > It is in-correct.
> > > Not everything, just exposed file-operation. and ioctl(s) for 
> > > DMA(eable)
> > buffer allocation from reserved lower memory region.
> > > Things managed by Kernel:
> > > * Send/receive path to ELE, is managed by Kernel.
> > > * Receive/send patch to the ELE's slave NVM-manager, is managed by kernel.
> > > * Low power management handled by kernel driver. In case of 
> > > low-power
> > state, ELE driver re-init the V2X IP as part of resume.
> > > * Other kernel management layers like NVMEM, kernel HWRNG, will use 
> > > the
> > api(s) exposed by this driver.
> > 
> > But you also expose an uAPI which allows the user to bypass everything 
> > via sending arbitrary commands, right?
> 
> Yes. But it's not unusual at all. The pattern of userspace sending
> commands directly to the kernel, is quite common

Please see below.

...

> > Some features require the device to be in LOCK_DOWN mode, which 
> > requires secure-world eFuse write path only afterwards. But it seems 
> > like NXP really wants to maintain two write paths.
> > 
> > > * Low power management at Linux driver.
> > 
> > The power-modes are selected via the ELE?
> 
>
> Voltage regulation for i.MX93 in Linux kernel, is done by ELE.
>
> During Linux suspend-resume, Secure-enclave (V2X on i.MX95) part of
> wake-up domain, will be managed by secure-enclaves(ELE) part of
> always-on domain.

So to sum-up, please correct me if I got it wrong:

 - NXP puts the ELE into the non-secure world, in case only one MU
   exists. The reason for this is that the ELE is also used to handle
   power-management.

 - NXP exposes an uAPI which can be used to send arbitrary commands from
   userspace to the ELE. (no filtering done yet)

 --> Sounds to me that the userpace can influence the system behavior
     very badly.

> > > * Linux HWRNG.
> > > * Loading the secondary runtime fw.
> > 
> > What is a secondary runtime-fw?
> ELE FW size is larger than the size of ELE internal secure memory.
> Hence FW is split into two.
> 
> Primary FW, is the FW, that enables features that helps for SoC boot-up.
> Secondary runtime FW, is the FW, that enables features like HSM.

Ah okay, thanks for the input.

> > To conclude this longly discussion:

...

> > I still have mixed feeling about the fusing (including the 1-MU case), 
> > since it requires a secure-world OS in place once the LOCK_DOWN fuse was burned.
> > It's fine by me if NXP wants to have and wants to maintain a multi-path here.
>
> Write fuse API will be added, to allow writing fuses from secure world
> too.

This is a device life-cycle problem and if NXP decides to maintain
multiple write paths, depending on the runtime-SoC state, this is fine
by me.

What needs to be ensured is, that the fuse-issue doesn't exist for the
1-MU case (i.MX8ULP) as you said.

> > Last but least, the uAPI which can be used to send arbitrary ELE 
> > commands seems unusual. But I don't know how secure-enclaves are 
> > abstracted within the kernel, so these are just my two cents.
> 
> it's not unusual at all. The pattern of userspace sending commands
> directly to the kernel via a queue is quite common like:
>
> GPUs: As you mentioned, userspace drivers (like those in Vulkan or
> CUDA) often build command buffers and submit them directly to the
> kernel or hardware.

That's right, but these drivers do at least some filtering on the OPs
and check if they are allowed. According your patchset, you just write
(se_if_fops_write()) the provided userspace buffer.

> Secure Enclaves: In systems like Intel SGX or AMD SEV, userspace
> applications interact with enclaves via ioctl or mmap interfaces,
> often sending structured commands or messages.

What I'm aware of is, that most secure-enclaves are switching to the
standard TPM API. 

Regards,
  Marco

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

