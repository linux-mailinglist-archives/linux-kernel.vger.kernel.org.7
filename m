Return-Path: <linux-kernel+bounces-897517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E3C52F65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CECC34FE55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5A344031;
	Wed, 12 Nov 2025 15:05:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99D3431FD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959924; cv=none; b=EtA2UtzvVnM+43Q5QCEFFYl9S5XQEy+gdBPtCFLqmRcJUWqP3QdBjRdyXH7xhVh9YV9eIi2TluQOj+pNmfmhSzmd+rlx2tZy8iGYreZrGanLIEPq2Qb+I7E5QxFM8lQc2b7Ozw72oxO6gnExqW7w65CVRiMTJp4RHppVj3HT/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959924; c=relaxed/simple;
	bh=Oiw3CxTvM1cncQ+TriE+d0MVdoOZK0B04yT6liE6dN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLrlR4KtfCJNH1mtU+6hwUPdm3dDTumNODsaB1yYm/QKDGDQTudPpeyIxpxWbJVQaQzVA6kcym40daBAMsuWKhJ5SF5SmIozq3ty1k7qyBgSppsXESBJgOT2HHcMB1LwHD+8dEwN9+bSAea5I2wXRYZlTVeNMFDCV6yzqNkfPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJCP7-0005AM-QV; Wed, 12 Nov 2025 16:05:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJCP7-0006PJ-14;
	Wed, 12 Nov 2025 16:05:01 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vJCP7-00GVCq-0g;
	Wed, 12 Nov 2025 16:05:01 +0100
Date: Wed, 12 Nov 2025 16:05:01 +0100
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
Message-ID: <20251112150501.qkjclsoq2bg75ed5@pengutronix.de>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
 <AM9PR04MB8604AA80EC97E06AADBF334695C3A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251111131442.nddhk3475oapf2zh@pengutronix.de>
 <AM9PR04MB86047231B5320C01759BFCAE95CCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86047231B5320C01759BFCAE95CCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-11-12, Pankaj Gupta wrote:

...

> > > Voltage regulation for i.MX93 in Linux kernel, is done by ELE.
> > >
> > > During Linux suspend-resume, Secure-enclave (V2X on i.MX95) part of
> > > wake-up domain, will be managed by secure-enclaves(ELE) part of
> > > always-on domain.
> > 
> > So to sum-up, please correct me if I got it wrong:
> > 
> >  - NXP puts the ELE into the non-secure world, in case only one MU
> >    exists. The reason for this is that the ELE is also used to handle
> >    power-management.
>
> For NXP SoCs with multi-MU(s) too, NXP proposes to put ELE driver into
> non-secure world.

With the ELE-FW and OP-TEE OS fix applied both worlds can communicate.
Therefore it doesn't matter and I didn't mentioned it explicit above.

That beeing said, with both worlds capable to talk to ELE and the ELE
beeing very system critical, both worlds have to agree to the
responsibilities, e.g. OP-TEE OS is not allow to manipulate the
power-state behind the back of Linux.

> >  - NXP exposes an uAPI which can be used to send arbitrary commands from
> >    userspace to the ELE. (no filtering done yet)
>
> It is not correct to say that no filtering is done.
> Before sending as well as after receiving the message, the message header of the buffers
> are parsed to check:
> - TX-buffer with Command-tag is allowed to be sent, RX-buffer with response-tag is allowed to be received, without logging errors.

I really don't want to step to deep into this, but that beeing said. If
you refer to cmd_tag, than this tag is used by your below mentioned
library also for NVM access. NVM is clearly something we do have a
linux-framework and uAPI for.

> - TX buffer size & Rx-Buffer size should match the size mentioned in the buffer.
> - FW version from the header is checked, if required secondary or runtime FW Is loaded, before forwarding the request to ELE.
> - In certain cases especially for exceptions, the message IDs are also compared.
> 
> > 
> >  --> Sounds to me that the userpace can influence the system behavior
> >      very badly.
> > 
>
> Messages created and sent by User-space
> library(https://github.com/nxp-imx/imx-secure-enclave), are
> scrutinized as stated above in the kernel driver.

This is uAPI which can be used by everyone and because your library may
not implement access to power-managment calls doesn't mean that other
libs do. I'm not sure if your proposed driver will block such attempts
from userspace.

> Moreover,
> As part of this library, message creation, send-receive, IOCTLS etc.
> kernel interface implementation logic, is not exposed to users of this
> library.

Your library is not the interface, the interface is the uAPI exposed by
the kernel. This interface/your driver needs to handle valid and invalid
access, e.g. hsm -> valid, nvm -> not valid since it is abstracted via
NVMEM.

> With the help of secure-boot and IMA-EVM, rootfs can be restricted to
> not allow any new application or modified userspace library, to
> execute.
>
> This way bad impact to the system behavior can be prevented.

Sorry but I really have to say that I have to NACK. Your interface is
the kernel uAPI and not some NXP userspace library.

An attacker could gain runtime system access and poke the ELE with
arbitrary commands till he finds a fw-bug using the kernel uAPI (not
your library of course).

> > > > > * Linux HWRNG.
> > > > > * Loading the secondary runtime fw.
> > > >
> > > > What is a secondary runtime-fw?
> > > ELE FW size is larger than the size of ELE internal secure memory.
> > > Hence FW is split into two.
> > >
> > > Primary FW, is the FW, that enables features that helps for SoC boot-up.
> > > Secondary runtime FW, is the FW, that enables features like HSM.
> > 
> > Ah okay, thanks for the input.
> > 
> > > > To conclude this longly discussion:
> > 
> > ...
> > 
> > > > I still have mixed feeling about the fusing (including the 1-MU
> > > > case), since it requires a secure-world OS in place once the LOCK_DOWN
> > fuse was burned.
> > > > It's fine by me if NXP wants to have and wants to maintain a multi-path
> > here.
> > >
> > > Write fuse API will be added, to allow writing fuses from secure world
> > > too.
> > 
> > This is a device life-cycle problem and if NXP decides to maintain multiple write
> > paths, depending on the runtime-SoC state, this is fine by me.
> > 
> > What needs to be ensured is, that the fuse-issue doesn't exist for the 1-MU
> > case (i.MX8ULP) as you said.
>
> As said above "Write fuse API will be added, to allow writing fuses
> from secure world too."
> This will be true for 1 MU or multi-MU.

In your previous mail you just said that there is no such issue with the
write path. Now you say that the single-MU case needs the same
workaround.. At least I have read it that way.

> > > > Last but least, the uAPI which can be used to send arbitrary ELE
> > > > commands seems unusual. But I don't know how secure-enclaves are
> > > > abstracted within the kernel, so these are just my two cents.
> > >
> > > it's not unusual at all. The pattern of userspace sending commands
> > > directly to the kernel via a queue is quite common like:
> > >
> > > GPUs: As you mentioned, userspace drivers (like those in Vulkan or
> > > CUDA) often build command buffers and submit them directly to the
> > > kernel or hardware.
> > 
> > That's right, but these drivers do at least some filtering on the OPs and check if
> > they are allowed. According your patchset, you just write
> > (se_if_fops_write()) the provided userspace buffer.
> 
> We are validating the buffer size against the size mentioned in the
> buffer header.
> Refer above comments for more details.
> 
> > > Secure Enclaves: In systems like Intel SGX or AMD SEV, userspace
> > > applications interact with enclaves via ioctl or mmap interfaces,
> > > often sending structured commands or messages.
> > 
> > What I'm aware of is, that most secure-enclaves are switching to the standard
> > TPM API.
>
> In case of NXP SoC with ELE HW IP, ELE is considered as on-SoC TPM. No
> additional or external TPM is needed, if ELE is present on SoC.

I said "TPM API" not "TPM device", may it be fTPM or dTPM. I think AMD
switched to fTPM, so no special userspace-requirements must be
fulfilled. However, this is also off-topic.

Regards,
  Marco


> 
> > 
> > Regards,
> >   Marco
> > 
> 
> Regards
> Pankaj
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

