Return-Path: <linux-kernel+bounces-863768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5BBF9103
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75B974ED1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F429D265;
	Tue, 21 Oct 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NwVzHpcr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27272199EAD;
	Tue, 21 Oct 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086127; cv=none; b=B6lVDuqwdBohuynM4ObfuhedegSKW5aSOBR7HCrsIzgLhdEaiQo22N3C8TEIS4Zv1VsPlyvWpI4vh3IuoekDNJcs7K3ZXAw7RevRSX5crukCmYbY0mzc/tpbc3C6Wa18dP+nu53NkHYuN5YvhObUAjo4ldsNjYIpmSr3KW4WSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086127; c=relaxed/simple;
	bh=EbH8QsdMoy2u3j62vooEOCAT3w9TJPTiDCf+eFU2NIw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXXwkqny1xZxXvEOG3DxkMjl4L7O8mMDnwicR8y5RJi9g2ASy5HiUvyGtMcidRTNQ6KRgj+e2bctSRnr3aIaIZ+7zvwrTyvI0f3KJy6Ouok/ryroQmXCWuavb5UISRSPV72LXcEVTwkRqQWHRtTZuetz7RYsegwxnmDLR0DsWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NwVzHpcr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761086116;
	bh=j6Z5RyFXrHpvFc4eRiFbkrrxzN6WfAoXMcnq2pqicfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NwVzHpcr0vkIJvUKi4uJ0cl729CK2k58bT2Z9Ridpa0BoeNFzr4MFJoyHmGl5fbzL
	 gYMCighc5YVlazpkf8da3p75/KNSwBfP0ZG2KsCPTB4YLtUh+alrSexKuCyr7nNRkG
	 LBhYY6ftXBx6U6YFmeKdl+dzpeEh+kIivnR6uYPC9VMKf6dBXAzF4L4vdCQqKHRTaV
	 8lolNXRaQ+P5jNzfc7yWl5ErfUyvSn6RrmZIMqxg3QnMC9O13/h/SYXQQVE1VE1Hbw
	 L0da78AKJ5pE5O8L81Bkf01EzxTShIlzcfSiZFAkH2K4nmMtgdASu2tgLNzHs+f6IQ
	 QTIbNS/9CZZpg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C76C57406C;
	Wed, 22 Oct 2025 06:35:13 +0800 (AWST)
Message-ID: <4aa22124cefc6bd23d75bdb0d5a85a2f38c22a77.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from
 round_rate() to determine_rate()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>, 
 "gregkh@linuxfoundation.org"
	 <gregkh@linuxfoundation.org>, "bmasney@redhat.com" <bmasney@redhat.com>
Cc: "joel@jms.id.au" <joel@jms.id.au>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "sboyd@kernel.org" <sboyd@kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	 <linux-clk@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, "mripard@kernel.org" <mripard@kernel.org>
Date: Wed, 22 Oct 2025 09:05:13 +1030
In-Reply-To: <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
			 <aMatZAX6eFI1RmDH@redhat.com>
			 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
			 <aPEZSY6RC-UVclxN@redhat.com>
			 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
			 <2025101759-runner-landing-374b@gregkh>
			 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
			 <2025101721-twiddling-huskiness-4852@gregkh>
		 <13566a08eeaed313ad789abcae1920d9b00483b0.camel@codeconstruct.com.au>
	 <d53256b35ee7089607463c66bb4a8c3420faf058.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 21:01 +0000, Winiarska, Iwona wrote:
> On Mon, 2025-10-20 at 09:30 +1030, Andrew Jeffery wrote:
> > On Fri, 2025-10-17 at 09:43 +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 17, 2025 at 05:57:44PM +1030, Andrew Jeffery wrote:
> > > > On Fri, 2025-10-17 at 08:41 +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> > > > > > Hi Greg,
> > > > > >=20
> > > > > > On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > > > > > > Hi Andrew and Iwona,
> > > > > > >=20
> > > > > > > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrot=
e:
> > > > > > > > Hi Brian,
> > > > > > > >=20
> > > > > > > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > > > > > > Hi Iwona, Joel, and Andrew,
> > > > > > > > >=20
> > > > > > > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wr=
ote:
> > > > > > > > > > The round_rate() clk ops is deprecated, so migrate this
> > > > > > > > > > driver from
> > > > > > > > > > round_rate() to determine_rate() using the Coccinelle
> > > > > > > > > > semantic patch
> > > > > > > > > > appended to the "under-the-cut" portion of the patch.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > > > > > >=20
> > > > > > > > > Would it be possible to get this picked up for v6.18? I'd
> > > > > > > > > like to remove
> > > > > > > > > this API from drivers/clk in v6.19.
> > > > > > > >=20
> > > > > > > > My (strong) preference is that Iwona applies it, but I'll k=
eep
> > > > > > > > an eye
> > > > > > > > out for any unusual delays.
> > > > > > >=20
> > > > > > > This patch wasn't picked up for v6.18. Any chance this can ge=
t
> > > > > > > picked up
> > > > > > > now for v6.19?
> > > > > > >=20
> > > > > > > I'm hoping to get this merged so that we can remove the
> > > > > > > round_rate() clk
> > > > > > > op from the clk core. The clk maintainer (Stephen) mentioned =
this
> > > > > > > work
> > > > > > > in his last pull to Linus.
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboy=
d@kernel.org/
> > > > > >=20
> > > > > > Are you happy to pick this up directly in Iwona's absence?
> > > > >=20
> > > > > Why me?
> > > >=20
> > > > I figured that would be sensible since Iwona historically sent you =
PRs
> > > > for the PECI subsystem.
> > >=20
> > > I did not remember that, sorry.
> > >=20
> >=20
> > No worries.
> >=20
> > > =C2=A0 The MAINTAINERS file does not mention
> > > this at all, and it lists many other maintainers that should be able =
to
> > > take this patch:
> > > 	$ ./scripts/get_maintainer.pl=C2=A0 drivers/peci/controller/peci-
> > > aspeed.c
> > > 	Iwona Winiarska <iwona.winiarska@intel.com> (maintainer:ASPEED PECI
> > > CONTROLLER)
> > > 	Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE
> > > SUPPORT)
> > > 	Andrew Jeffery <andrew@codeconstruct.com.au> (maintainer:ARM/ASPEED
> > > MACHINE SUPPORT)
> >=20
> > Iwona currently appears unresponsive, as mentioned. Joel's stepped back
> > from maintaining the ASPEED bits as of earlier this year; I worked with
> > him to add myself as a maintainer there, hence the last entry, and now
> > getting in touch with you.
> >=20
> > I can apply the patch and send you a PR if that helps, if Iwona doesn't
> > respond in the mean time.
>=20
> Hi!
>=20
> Sorry for the delay - for some reason this entire thread didn't land in m=
y inbox
> and I just found it now, randomly browsing mailing list :/
>=20
> I will sent it as a PR for v6.19.

Ah, super! Thanks Iwona.

Andrew

