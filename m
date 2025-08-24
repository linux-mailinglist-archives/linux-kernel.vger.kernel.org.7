Return-Path: <linux-kernel+bounces-783641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5420B3300E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECE848185D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B7A41;
	Sun, 24 Aug 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="dY0Fki/U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezBPRlDE"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4871DA60D;
	Sun, 24 Aug 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756041529; cv=none; b=cLSsfqTix3KJh6UFeh1m+7oJdhbNV36nffMfGz6EXo4aBjSDSwJrRruXM8nXIRfFnMdMFoL/pPiSDbUjhNV1jexoYvjHRMfSr9DVl1U0HWwUF4Q4rRRaOcsFOw3qylxlj58YeiGTOohB6JHxW+mkBJh9y5MW7m//xlR38EANZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756041529; c=relaxed/simple;
	bh=Y3HaksNBo3DV7bLbSC3M7I7b4eJP4LGWu6gpDI/98EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hshm3H3Y2V58kVAP3Sm9/OhyCAVin5L0rukBH9jxR6dKQbJuvki3iBspNvNi7s9nJ4BHeHMDfs+//YCuuU1vc32qqYRlu+/cBlzXV/xe1gOK/FunIzNCIicgv1b8p1n6+F8H64fylSo0WZGRL6+ct/4rpD9qLUCbV8s/ATe4Ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=dY0Fki/U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezBPRlDE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BE2501D00095;
	Sun, 24 Aug 2025 09:18:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 09:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756041525; x=1756127925; bh=3prZoZB8qt
	UY6cMZZ2NVeXAFCSeqIEGUhlmdlNJvu3c=; b=dY0Fki/UXlewD9rNROFjTngj5X
	j4+oBWxM5/68hjgRw0rcab6Qjc532yYJs1TwVwAALlBwai8sqbS7sVOjHRwn4ZGL
	nCFZ5bsAW1TeIVDCk5pJwtw0bqiAao7H1tC1Nxq/qTkdfuK4Fj9bu9qY5YBTJxPE
	0rPSm5MbTZ1OpAzjQDzqkd8aDh+7WhnsvkFyRPk/Y4iU4O+wI41/fAclQXJlsN9A
	57jsxzBOvas0e/BmUe8jX61e7Hph2QSKZzJpBNq6uV+8QTqb5PzXHTzFQljcyAhN
	/TtbwKKJiTBScVxdTaXMRRwSgkjAImipuLumyQCJ/Os/RshRNzf8KvcuU9Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756041525; x=1756127925; bh=3prZoZB8qtUY6cMZZ2NVeXAFCSeqIEGUhlm
	dlNJvu3c=; b=ezBPRlDERXj9t162ceFYHGaikmaDdpwRVQPtjblaCgeHZj42Y2U
	+Wlr3l2OIwFHpJRz+7bINCxDMy8nu/u7mTGwIE5aP7RH3DnZ7+qusBNlJuRPug5j
	0fF45hIPYMvLYV+i/mo0kMXFPwnPa1CXiu2kak97SBvR9BPjPMyj2LaEkjEWZeWL
	0e4R5JTOdV6z9yJ5geKX5hytpx3l97WGe4sVu8vF9XLjcex6Z2GfCx++zdo733kY
	FXClxJ1MFdYTVB4m2QfafjDe9d+m7BKLhXVRlXMXhaJOkWRtCSbA25n22dwwMr4B
	TobLERzrHFBFuptb43LGjpnq088M3Gy/P+A==
X-ME-Sender: <xms:NBGraIKCqo-GFIKftdCgEmK2UwGG5cg-SEkjE40So6oWlqn3gmgIqA>
    <xme:NBGraF1ExnEVCFABdybfg36CZCNsM0bymCUDrPdpPRcAeq7xEI50wKmIMb-iZezDn
    Ah3dHiSd0BHnI-bvEs>
X-ME-Received: <xmr:NBGraKeTBZKmc6v9HXIv4n_mjzCXbUjpPfcp72k12dL81XuqNHe1RVN8GeNRByYn0rTDur5fQO8SqEYTdpRzl465jvWT5dhXMx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehthhhinhhhrdhnghhuhigvnhesshihnhhophhshihsrdgtohhmpdhrtghpthhtoh
    epshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghlsghise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhg
    rdhiohdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvh
X-ME-Proxy: <xmx:NBGraB6hZ5q-Svkbm2ty2CCEP_CAbOL495fy91yKgR8Wq7eaHVgzvw>
    <xmx:NBGraF8k5CTxPZAkjPP5BMWybAClWCipgkqeV3tw6ZVKNCpH_N_Mag>
    <xmx:NBGraAL4LqFl6Tm4RJuOqEqtUcF6E8g_MkxVJLNkQqXN-hRnzOLXPQ>
    <xmx:NBGraAgZuPu3S5haJ24eHA7YcubO9p9kyHm7-tbxABj9KjuFjLgRFA>
    <xmx:NRGraDmBjBJnwCIeb4-lr5-V1cpi2gSP19-8yGyHidyMMe0wHDHneZkU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 09:18:43 -0400 (EDT)
Date: Sun, 24 Aug 2025 15:18:41 +0200
From: Janne Grunau <j@jannau.net>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Sven Peter <sven@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH RFC 04/22] usb: dwc3: apple: Reset dwc3 during role
 switches
Message-ID: <20250824131841.GG1270980@robin.jannau.net>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-4-172beda182b8@kernel.org>
 <20250821232547.qzplkafogsacnbti@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821232547.qzplkafogsacnbti@synopsys.com>

On Thu, Aug 21, 2025 at 11:25:51PM +0000, Thinh Nguyen wrote:
> On Thu, Aug 21, 2025, Sven Peter wrote:
> > As mad as it sounds, the dwc3 controller present on the Apple M1 must be
> > reset and reinitialized whenever a device is unplugged from the root
> > port or when the PHY mode is changed.
> > 
> > This is required for at least the following reasons:
> > 
> >   - The USB2 D+/D- lines are connected through a stateful eUSB2 repeater
> >     which in turn is controlled by a variant of the TI TPS6598x USB PD
> >     chip. When the USB PD controller detects a hotplug event it resets
> >     the eUSB2 repeater. Afterwards, no new device is recognized before
> >     the DWC3 core and PHY are reset as well because the eUSB2 repeater
> >     and the PHY/dwc3 block disagree about the current state.
> > 
> >   - It's possible to completely break the dwc3 controller by switching
> >     it to device mode and unplugging the cable at just the wrong time.
> >     If this happens dwc3 behaves as if no device is connected.
> >     CORESOFTRESET will also never clear after it has been set. The only
> >     workaround is to trigger a hard reset of the entire dwc3 core with
> >     its external reset line.
> > 
> >   - Whenever the PHY mode is changed (to e.g. transition to DisplayPort
> >     alternate mode or USB4) dwc3 has to be shutdown and reinitialized.
> >     Otherwise the Type-C port will not be usable until the entire SoC
> >     has been reset.
> > 
> > All of this can be easily worked around by respecting transitions to
> > USB_ROLE_NONE and making sure the external reset line is asserted when
> > switching roles. We additionally have to ensure that the PHY is
> > suspended during init.
> > 
> > Signed-off-by: Sven Peter <sven@kernel.org>
> > ---
> >  drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/usb/dwc3/core.h |  3 +++
> >  drivers/usb/dwc3/drd.c  | 11 ++++++++-
> >  drivers/usb/dwc3/host.c |  3 ++-
> >  4 files changed, 72 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 8002c23a5a02acb8f3e87b2662a53998a4cf4f5c..26aa507a738f001409a97ef563c6561433a1cac5 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c

...

> >  	/*
> >  	 * When current_dr_role is not set, there's no role switching.
> >  	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
> >  	 */
> > -	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
> > +	if (dwc->role_switch_reset_quirk ||
> 
> Don't override the use of GCTL.CoreSoftReset with this quirk. Not all
> controller versions should use GCTL.CoreSoftReset, the new controller
> version don't even have it. What version is this vendor using?

It reports DWC31, revision 190A and the unlisted version_types
0x736f3035 (M1), 0x736f3039 (M1 Pro/Max/Ultra) and 0x736f3130 (M2, M2
Pro/Max/Ultra).

> I'm concern how this condition is needed...
> 
> > +		(dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
> >  			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
> > -			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
> > +			desired_dr_role != DWC3_GCTL_PRTCAP_OTG))) {
> >  		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> >  		reg |= DWC3_GCTL_CORESOFTRESET;
> >  		dwc3_writel(dwc->regs, DWC3_GCTL, reg);

Janne

