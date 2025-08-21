Return-Path: <linux-kernel+bounces-779853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F057B2FA48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9C1C87760
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E232C335;
	Thu, 21 Aug 2025 13:21:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395532BF5F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782507; cv=none; b=KaIHx/ItaOiVO1O3eDa9e1gMVuTAoCyKuAXoB7uBoPIWBDaVmVXLEGygqhDC4vwuOVK4SatwdAtbSfj5M5E+E6HeCZYabAok6ZCtTuXhEhi/sSBl4VnYyX+4LaKWnzE3yDYzd5yfZzlAyMnvAg0sCOWNGUd2zebLEnjC9kTPG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782507; c=relaxed/simple;
	bh=W8oIlS2h1YPSW2RCaPjV5TA/bkt4+gglZE1HOsmlJjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqSAGvem038B5kuno4x+DaXsNnL0RYC6whcrK40Q7/Cz5gyfmZC2Au3OWmEApRh0f7Mf76PAQYboDYPXl6+5ipE2s+ymiMEGZV+3nofw3orUPIqqKXQvqBe9nrREBdvgwXQ6/XM7S8TcXxrTVGo3ZcYy6RGGWFM01tCt3wfCh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1up5ER-0000UN-IZ; Thu, 21 Aug 2025 15:21:31 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up5EP-001Q3r-0n;
	Thu, 21 Aug 2025 15:21:29 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up5EP-0082gA-0L;
	Thu, 21 Aug 2025 15:21:29 +0200
Date: Thu, 21 Aug 2025 15:21:29 +0200
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Varun Sethi <V.Sethi@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>
Subject: Re: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <20250821132129.hwnnqdagalvxw2uk@pengutronix.de>
References: <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250714094124.e6fnkrocnqagbm22@pengutronix.de>
 <AM9PR04MB8604EFCC5400DEBB7DF0CF49952DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250806132701.fouikyuqtzdsxqwh@pengutronix.de>
 <AM9PR04MB8604A636762E81DF9EA9A9B89532A@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604A636762E81DF9EA9A9B89532A@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-08-21, Pankaj Gupta wrote:
> 
> 
> > On 25-08-06, Pankaj Gupta wrote:
> > > > On 25-07-09, Pankaj Gupta wrote:
> > > > > > Am 30.06.25 um 14:17 schrieb Marco Felsch:
> > 
> > ...
> > 
> > > > Lockdown: For a verified boot setup you need to burn an eFuse at
> > > > some
> > > point,
> > > > to tell the bootROM to boot only correct verified firmware images.
> > > >
> > > > After this lockdown it's no longer possible to burn eFuses from the
> > > > REE
> > > albeit
> > > > the production line setup still requires the support.
> > > >
> > > Understood. ELE access from both secure and non-secure world is fixed
> > > in Q3 release.
> > > User can be able to modify eFuses via OPTEE.
> > 
> > Splitting the read and write between two drivers is even worse.
> 
> This could be use-case dependent. Depends on how customer will deploy its
> solution.

I don't get this. You introduce even more segmentation if the read-path
uses another driver than the write-path and if this is optional.

> > Can you please point out why you can't just move the driver parts into the
> > tee? I do see many advantages if only op-tee is used:
> 
> The ELE's KEY derivation function takes account of world from where, the
> operations are requested.
> - The key derived from secure world and from non-secure world will be
> different.

Which is correct and no reason for not having an OP-TEE only solution.

> There are different use-case for ELE accesses from both the worlds.
>
> Using OPTEE ELE driver for Linux specific ELE-HSM requests, it will add
> significant overhead.
>
> Usecases like Transparent TLS offload while securing the secrets in HSM,
> would incur additional overhead.

Of course, the ELE communication itself will be faster if Linux
communicates directly with the ELE instead of going through OP-TEE.

But to be honest I don't think that the ELE usage itself is much faster
than using OP-TEE and the ARMv8 Crypto-Extensions.

For the ELE you need to:
 - setup the context (incl. the message and all mailbox mechanism)
 - wait for the ELE to be accessible (only one ELE, only one
   normal-world MU).
 - transfered the messages to/from the ELE
 - the ELE processing should be equal to the CPU processing time

(Side note: What is the ELE behavior if the secure-world stresses the
ELE? Is there a MU priority so the normal-world MU may get blocked
(never addressed) or are both MUs scheduled in round-robin?)

For OP-TEE you need to:
 - setup the context
 - switch the CPU mode
 - make use of ARMv8 Crypte-Extensions

On i.MX8M, which uses the CAAM (the ELE predecessor), we can verify that
the ARMv8 crypto extensions are much faster than the crypto-engine
itself. Therefore the CAAM is mostly unused.

Are there measurements/application-notes that show that the usage of the
ELE is more performant than using the crypto-extensions?

> IOT-cases where real-time encrypted feed from sensors, will take latency
> hit.

Does the ELE support inline en-/decryption? If not, I don't think so.

The data needs to be read from the CPU first, afterwards it needs to be
prepared for the ELE and transfered to/from the ELE. Also there is just
a single ELE with a single normal-world MU, so you need to handle
concurrent access if there are multiple ELE-users
(sensor+tls-offloading).

If CPU is used, the data still needs to be read from the communication
interface but afterwards doesn't need to be passed to another IP. Also
there are multiple CPUs.

Regards,
  Marco

