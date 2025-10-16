Return-Path: <linux-kernel+bounces-856116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D520BE3203
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6BD7357B34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEF31AF21;
	Thu, 16 Oct 2025 11:42:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556421C9F9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614937; cv=none; b=iyM732am+zFnitQw2dYdX3gm2nWhrTm4dxafXIuDQcynrEo7a3mZXxXyXZz3Rt1KQobWMh+xKc0871U4naoE2FQDPMM/n8baG7Xte8AT5YtDsf4AwNfaTjuHwvfWN8S5j0eeFjhNJ/5y6QyO5jzdP32iWkSh4q1jeDyuKzlSBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614937; c=relaxed/simple;
	bh=ZH8anoDC/o0kaWH5bDY8yFuiOz5ptPX33dTSuj/Zqs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NquvVBloJaDkY8LbtoRmB8N4qyFKrAHkC+Mry0Wi8hMRsaLnE7dkj3mKrG1BReHNDN0g/yQTrI+9c/uzxpmIJ8o3HQdevVzGE9fp+P5FlGdBLV1PMbmNqEeWQWsMiIn7AQxM78rOUyBlvAU9sNOF2/EJhIaCpuHuR4jSXfaj9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1v9MMi-0002oB-Us; Thu, 16 Oct 2025 13:41:52 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1v9MMi-003sq4-06;
	Thu, 16 Oct 2025 13:41:52 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1v9MMh-00HQPu-2x;
	Thu, 16 Oct 2025 13:41:51 +0200
Date: Thu, 16 Oct 2025 13:41:51 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-doc@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] firmware: imx: driver for NXP secure-enclave
Message-ID: <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 25-09-27, Pankaj Gupta wrote:
> Highlight:
> 
> There are long discussion at V18 with Marco Felsch.
> https://lore.kernel.org/imx/AM9PR04MB8604F5A7DD8B1E41FDAD09039501A@AM9PR04MB
> 8604.eurprd04.prod.outlook.com/
> 
> The key point is about using OP-TEE OS. 
> 
> Marco's questions:
> =================
> Q1. Both MU(s) from each world - Secure & Non-secure, cannot be used
>     simultaneously. Why?
> A1. ELE FW fix is available, where concurrent access to ELE from both the
>     world is working. This fix is not required for the current patch-set for
>     i.MX8ULP.

According https://github.com/OP-TEE/optee_os/pull/7268/commits/83b516edc0270ca8300ce524a0c3d560e67a0f48#r1955899462
there is no fix yet. Can you please point me to the fixed version?

Also can you please outline why the fix is not required for i.MX8ULP?
Unfortunately I can't remember.

> Q2. How is the secure and non-secure world talk to the ELE if there is only
>     one MU?
> A2. From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for
>     each world - Linux(one or more) and OP-TEE OS (one or more). Has updated
>     the commit message of 3/7.

Does apply to the i.MX8ULP SoC as well? The NXP name scheme isn't very
easy to follow.

> Q3. How exactly do the eFuse write access after the device was locked down,
>     will be provided with single path; for the following case? 
>     - For a verified boot setup, you need to burn an eFuse at some point,
>     to tell the bootROM to boot only correct verified firmware images.
>     - After this lockdown, it's no longer possible to burn eFuses from the
>     REE, while the production line setup still requires the support.
> A3. OP-TEE OS supports read fuses, currently as part of our quarterly release.
>     Write fuse will be in coming release. Please note that the current patch-
>     set does not contain any read/write eFuse feature.

But one of your patches is mention it, right? So there will be still two
paths.

Also according your IOCTL docuementation you want to expose the whole
device to the user-space?

| What:          /dev/<se>_mu[0-9]+_ch[0-9]+
| Date:          Mar 2025
| KernelVersion: 6.8
| Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
| Description:
|                NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
|                Enclave(ELE), SECO. The character device file descriptors
|                /dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
|                enclave shared library and the kernel driver.
| 
|                The ioctl(2)-based ABI is defined and documented in
|                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
|                ioctl(s) are used primarily for:
|                        - shared memory management
|                        - allocation of I/O buffers
|                        - getting mu info
|                        - setting a dev-ctx as receiver to receive all the commands from FW
|                        - getting SoC info
|                        - send command and receive command response
				^
This is a rather uncommon approach. The kernel has interfaces to
abstract hardware. You completely bypass this if you expose everything
to the userspace.

> Q4. What is the ELE behavior if the secure-world stresses the ELE? Is there
>     a MU priority so the normal-world MU may get blocked (never addressed)
>     or are both MUs scheduled in round-robin?
> A4. ELE will pick the message from Both MU(s), based on FIFO.

This doesn't answer my question. How gets the FIFO filled? If the one of
both worlds aways keep the MU busy?

> Q5. Why ELE performance matters?
>     - On i.MX8M, which uses the CAAM (the ELE predecessor), It can be
>     verified that the ARMv8 CE are much faster than the crypto-engine itself.
>     Therefore the CAAM is mostly unused.
> A5. User looks for both type of implementation based on their usecase:
>     - Certain users still offload to CAAM, to save their ARM CPU cycles for
>     other priority tasks.

I have never seen such designs but okay.

>     - While certain customer choose ARM-CE for the crypto offloads for better
>     performance.
>     As far as ELE is concerned, it is not a crypto accelerator like CAAM.
>     Performance hungry crypto-ops are not recommended to be offloaded to ELE.

I don't get this point. So NXP doesn't recommend to use the ELE for
crypt-ops?

> Q6. For the IOT-cases where real-time encrypted feed from sensors, will take
>     latency hit, Does the ELE support inline en-/decryption?
> A6. Yes, ELE support Inline Encryption Engine (IEE), starting i.MX95 onwards.

May I ask, how is this connected and which interfaces are connected to
the IEE? I would have checked it by myself but unfortunately NXP doesn't
provide a TRM for the i.MX95 yet.

> Marco's Suggestions/NXP response:
> ================================
> S1. Below listed ELE access requirements, can be done from OP-TEE OS in all
>     the Life-Cycle states. then Why to use Linux?
>     - eFuse access (done via  OP-TEE OS i.MX specific PTA): OTP eFuse R/W access
>     after doing the LOCK_DOWN fuse is no longer possible without  OP-TEE OS. This
>     involves general purpose (GP) eFuses too.
>     - ELE ping every 1 day (kernel SMC WDG driver, OP-TEE OS wd driver).
>     - HW-RNG (kernel HWRNG driver + OP-TEE OS HWRNG PTA).
> R1. There are i.MX9* users, that are not using OP-TEE OS, but still want
>     to use ELE features from Linux. So, these users are requesting for this
>     driver in Linux.

Which ELE features?

>     As suggested by you, writing to eFuse after life-cycle closed state, the
>     driver in OP-TEE OS is needed.
>     Though there are other OP-TEE OS features too, that needs to be offloaded
>     to HSM, for security reasons, like:
>     - Hardware Unique Key(HUK) getting generated.
>     - OP-TEE OS's ASLR seed generation.

We're talking about features the normal world wants to have access too,
since you said ".. but still want to use ELE feature from Linux ..". The
HUK and the TEE ASLR seed is clearly not something Linux wants to have
access too.

> S2. Having one implementation is beneficial in the following ways:
>     - Multiple paths also requires more maintain- and testing effort.
>     - FW files with having +1 FW for the new i.MX9*, where there are plenty
>       already eg.: bootloader, TF-A, ele-fw, scu-fw (i.MX95), increases the
>       maintenance on both the paths.
>     - TEE code could be reused by other OSes.
>     - TEE is used anyway for new projects due to CRA and friends
> R2. As conveyed in R1, there are Linux only users, that are dependent on SE
>     Linux kernel driver.

What difference does it make if these Linux-only users get the ELE
access via OP-TEE? It's just one binary more.

> S3. Having one implementation is beneficial in the following ways:
>     - Adding the support for it to  OP-TEE OS do not requires ELE-FW.

I never said that this requires no ELE FW! I said it requires no ELE-FW
update! Was the update already rolled out?

>     - Concurrent access handling is done by the TEE core.
> R3. As already mentioned that ELE FW fix is available, for concurrent access.
>     Please note that FW fix is not required for the current patch-set.

Can you provide us a link to the fix please? The fix should fix the
concurrent normal-world <-> secure-world MU access issue. Why is this
fix not required if I have a running OP-TEE?

> S4. This series causes more confusions till the ELE FW fix is available to
>     allow concurrent access to ELE from both the worlds.
> R4. FW fix is already available, and concurrent access is enabled by default
>     in LF Q3'25, release. Please note that FW fix is not required for the
>     current patch-set.

Please provide a link to the new FW and why is the fix nor required for
this patchset?

> S5. Suggesting to add the  OP-TEE OS support for the required features e.g. eFuses,
>     watchdog, HWRNG. The whole Linux part is mostly in place.
> R5. Yes, the secure world features like eFuse read/write will be added
>     to OP-TEE OS. Please note that this patch-set does not contain any read/write
>     eFuse feature.

I see, instead it expose the whole ELE to the userspace if I got it
correct according your IOCTL documentation. This would be even worse.

Regards,
  Marco

