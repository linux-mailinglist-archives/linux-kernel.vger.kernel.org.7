Return-Path: <linux-kernel+bounces-729753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DAB03B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4443B17DAED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01F1242D82;
	Mon, 14 Jul 2025 09:41:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB99CA6B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486108; cv=none; b=BRcJRLi3VxgkGgSBL8hy/h8E0Uy5sMCxezubtNRiDGU7TnCACpZkQmr7ixX2y5X8Y92SDP2zyrN3kdYhYG2bzjrkA0vgXfb3YMRypuZ05EptJ4UFMdQvruoWhgpMPP8qai92q9pJd1L8oCrJijSC5chKnWDBUEIPucIumz9YtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486108; c=relaxed/simple;
	bh=6mRCvjwCfLagynd1sjkcntn7eKszJwBRLGvb55f1L8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufrEoJcLHr7GNV+HuFdkbbt5S09O3Ujlayuvx8Dhvm72JdXYFJvbbryxFTA40hzbTLH4dxj0r9z20hPssRcOJxmpdCbOHbfCm5V+t+ddJ9ihLczvXiZIjufY4dkCy65qwTtONbqWoK4UfTbWZyelLXPjZ4/qfGMJlvUJTKCFwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1ubFgb-0007Iu-0P; Mon, 14 Jul 2025 11:41:25 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ubFga-008OJ7-1b;
	Mon, 14 Jul 2025 11:41:24 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1ubFga-0006RZ-1F;
	Mon, 14 Jul 2025 11:41:24 +0200
Date: Mon, 14 Jul 2025 11:41:24 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <20250714094124.e6fnkrocnqagbm22@pengutronix.de>
References: <20250619-imx-se-if-v18-0-c98391ba446d@nxp.com>
 <20250619-imx-se-if-v18-3-c98391ba446d@nxp.com>
 <20250625105546.pxuatcnfpe7mssgs@pengutronix.de>
 <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-07-09, Pankaj Gupta wrote:
> > Am 30.06.25 um 14:17 schrieb Marco Felsch:
> >> Hi Frieder,
> >>
> >> On 25-06-30, Frieder Schrempf wrote:
> >>> Hi Marco,
> >>>
> >>> Am 27.06.25 um 10:46 schrieb Marco Felsch:
> >>>> Hi,
> >>>>
> >>>> your e-mail configuration mixed my e-mail with your answer, which 
> >>>> makes it hard to read. Can you please check the quoting next time :)
> >>>>
> >>>> On 25-06-27, Pankaj Gupta wrote:
> >>>>>>> Add driver for enabling MU based communication interface to
> >>>>> secure-enclave.
> >>>>>>
> >>>>>>> NXP hardware IP(s) for secure-enclaves like Edgelock 
> >>>>>>> Enclave(ELE), are embedded in the SoC to support the features 
> >>>>>>> like HSM, SHE & V2X, using message based communication interface.
> >>>>>>>
> >>>>>>> The secure enclave FW communicates with Linux over single or 
> >>>>>>> multiple dedicated messaging unit(MU) based interface(s).
> >>>>>>> Exists on i.MX SoC(s) like i.MX8ULP, i.MX93, i.MX95 etc.
> >>>>>
> >>>>>> You write single or multiple MUs are possible. I'm aware that the 
> >>>>>> i.MX93 has two MUs one for the secure and one for the non-secure 
> >>>>>> world. But I'm really concerned about the fact that both MUs can't 
> >>>>>> be used at the same time from both world:
> >>>>>
> >>>>> Yes, you are correct.
> >>>>>
> >>>>> Fix is still work in progress.
> >>>>
> .>>> So after ~6 months no fix is available :(
> >>>>
> >>>>>> Also how is the secure and non-secure world talking to the ELE if 
> >>>>>> there is only one MU as you have written?
> >>>>>
> >>>>> Till the fix is WIP, either Linux or OPTEE can use the ELE, at one 
> >>>>> point in time.
> >>>>
> >>>> That has nothing to do with the fix. The fix is for platforms/SoCs 
> >>>> which do have 2-MUs, but you also have written that there are 
> >>>> platforms with only 1-MU.
> >>>>
> >>>> This MU can't be shared between secure and non-secure world.
> >>>>
> >>>>>> IMHO it makes much more sense to put the complete ELE 
> >>>>>> communication into (OP-)TEE and let the secure OS taking care of 
> >>>>>> it. All non-secure world requests are passed via (OP-)TEE to the ELE.
> >>>>>> This involves:
> >>>>>> - eFuse access (done via OP-TEE i.MX specific PTA)
> >>>>>> - ELE 23h59m ping (kernel SMC WDG driver, requires OP-TEE watchdog 
> >>>>>> driver)
> >>>>>> - HW-RNG (kernel OP-TEE HWRNG driver + OP-TEE HWRNG PTA)
> >>>>>
> >>>>> There is a dedicated MU "trusted-MU" for OPTEE-OS. The idea to 
> >>>>> converge to a
> >>>>
> >>>> Yes for systems with 2-MUs there is a "trusted-MU" and a 
> >>>> "non-trusted-MU". As of now, there is no fix available for using 
> >>>> both MUs at the same time. Furhtermore there are platforms/SoCs with 
> >>>> only 1-MU, as you have written in your commit message. This 1-MU 
> >>>> system can have the MU either trusted or non-trusted.
> >>>>
> >>>>> single path via OPTEE-OS, is good. But it will impact the 
> >>>>> performance of the features at Linux side.
> >>>>
> >>>> Performance? We are talking about a ping every 23h59m (I still don't 
> >>>> know if this is a feature or bug), eFuse write/read, and the HW-RNG 
> >>>> which can seed the Linux PRNG.
> >>>>
> >>>>> Since the fix is still WIP. Let's wait till then.
> >>>>
> >>>> The fix is for the 2-MUs SoCs but not the 1-MU case.
> >>>>
> >>>> I would like to have a system design which doesn't differ too much 
> >>>> between SoCs which are equipped with the ELE engine.
> >>>
> >>> Do we really want to depend on OP-TEE to be available for having 
> >>> things like OTP fuse access and HWRNG? Personally I'd like to be able 
> >>> to build systems with OTP access and HWRNG but without OP-TEE. 
> >>> Requiring OP-TEE only to make the ELE available to the kernel in 
> >>> cases where the secure world isn't used for anything else seems to be
> >>> unnecessarily complex.
> >>
> >> I understand your point. I don't like pulling in more FW neither but 
> >> we need to the face the following facts:
> >>
> >>  - OTP eFuse R/W access after doing the LOCK_DOWN fuse is no longer
> >>    possible without OP-TEE. This involves general purpose (GP) eFuses
> >>    too. We faced this limitation in a current project.
> 
> > Ok, interesting. Where do find information about the LOCK_DOWN fuse? I
> > don't see it mentioned in the (Security) Reference Manual of the i.MX93.
> 
> From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for each
> world - Linux(one or more) and OPTEE-OS (one or more).

Okay, please re-phrase your commit message than, since this wasn't clear
to me.

> As mentioned earlier, the fix for the issue of using OPTEE-OS dedicated MU
> on i.MX93, is identified & under testing.

I get this but there is still no fix available after ~6 months, so it's
still no possible to use a TEE and REE in parallel.

> Other point on whether OTP effuse are R/W access, after LOCK_DOWN fuse?
> Not sure about how "doing the LOCK_DOWN fuse"?
> Please elaborate more on this.

Lockdown: For a verified boot setup you need to burn an eFuse at some
point, to tell the bootROM to boot only correct verified firmware
images.

After this lockdown it's no longer possible to burn eFuses from the REE
albeit the production line setup still requires the support.

> >>  - With new regulations like the EU CRA I think we need some sort of
> >>    secure-enclave anyway.
> 
> > Probably some sort of, yes. But not necessarily in the form of TEE or
> > TrustZone, I guess.
> To use ELE features through Linux, there is no dependency on OPTEE-OS.

Once again, still no fix available and if your system requires a TEE
you're forced to move the ELE communication into the TEE (at least until
now).

Also the eFuse R/W access is not possible from the REE/Linux after doing
the device lockdown.

> >>  - Making it optional cause more paths of potential errors e.g. by not
> >>    including the correct "secure.dtsi". Multiple paths also require more
> >>    maintain- and testing effort. IMHO I do think that one of the paths
> >>    get unmaintened at some point but we would need to keep it for
> >>    backward compatibility.
> >>
> >>    Having one implementation eliminates this since.
> >>
> >>  - All above points assume that the ELE-FW and -HW is capable of talking
> >>    to both world, which is not the case. As we learned NXP doesn't have
> >>    a fix for the 2-MUs ELE yet and even more important there are 1-MU
> >>    ELE-IPs.
>
> For i.MX9x SoC(s) there is at least one dedicated ELE MU(s) for each world -
> Linux(one or more) and OPTEE-OS (one or more), that needs to be shared
> between them.

Please mention this within your commit message.

> As mentioned earlier, there is an issue of using MUs simultaneously, from
> both worlds. Fix is in progress.

So until now no fix available and i.MX93 based products which do use a
TEE are forced to move the communication into OP-TEE.

> >> I do see the (minimal) drawback of having +1 FW but I think this is 
> >> more an integration problem.
> >> Speaking of FW files, for the new i.MX9* you already have plenty fo
> >> them: bootloader, TF-A, ele-fw, scu-fw (i.MX95). So your integation 
> >> needs to handle multiple firmware files already.
> 
> > Sure, but I really like to keep the complexity and therefore the number of
> > FW files as low as possible. I'm not sure what has more weight in terms of
> > security: shipping an additional firmware and therefore increasing the
> > attack surface or maintaining an additional code-path.
> 
> There is no +1 firmware in case of i.MX93.
> 
> >>
> >>> Anyway, I see your point of having a single implementation for the 
> >>> ELE API in the "right" place. But as far as I know other platforms 
> >>> like
> >>> STM32MP1 also implement both ways for the HWRNG, secure access via 
> >>> OPTEE and non-secure access via kernel directly.
> >>
> >> I'm not a STM32MP1 expert but here you have this setup with the 
> >> *-scmi.dtsi. So you have two code paths which needs to be maintained 
> >> and tested. Also if one customer of yours want to use OP-TEE you need 
> >> the integration anyway, so you (Kontron) needs to maintain multiple 
> >> configuration as well. I don't see the added value.
> >>
> >> I think for STM32MP1 the *-scmi.dtsi support was added later because 
> >> it required a lot effort to support it. This is not the case for the 
> >> i.MX9* series.
> 
> > Anyway, thanks for elaborating. Your points are all valid and basically I
> agree. I'm fine with either way. But I'm afraid that implementing the ELE
> API in OP-TEE only will cause another tremendous delay for having ELE access
> in the kernel, especially seeing how slow NXP seems to be working on these
> topics right now.
> 
> To use ELE features through Linux, there is no dependency on OPTEE-OS.

How exactly do you provide the eFuse write access after the device was
locked down?

Regards,
  Marco

