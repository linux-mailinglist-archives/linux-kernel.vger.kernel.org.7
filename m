Return-Path: <linux-kernel+bounces-848527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62231BCDF74
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 100223565A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA962FBE0B;
	Fri, 10 Oct 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kwc9QkyR"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB9266B52
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113940; cv=none; b=H2JztN5O6QIqqt0bS9hDc2wSZt8JajHEkvo9alxz9b7GIaEKLrTejLCSTweZ02lU4defl6GuHn6e+KBo6s2sdzBlHHXBVcvn4NZ1BTGZCuKgK6MMfYbJt8ywXyuBG5HjbSCdnp2jQ6641hj87t57tOEDv6qAingQo0BV2gONZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113940; c=relaxed/simple;
	bh=5kwuV8eNnA83Ato1cZbhy9+x6tIprPRIWS08vVYojKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8OgAi9bkxDeKoVmhITmZg45x40j8mUvUtt+FgmarKzWE/saB+jXNdc0YlrGY3J5laKy9eSgB/n6wCfY8JpxyMR6Nd5mSjO34Eluf21iOISjGHc/kbokflHEg/DEKlCGyB7fH+KdGxXpc5LGS/96suW5POLrGkH2UUvsMmo1WDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kwc9QkyR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7187A4E40FCF;
	Fri, 10 Oct 2025 16:32:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 374E160667;
	Fri, 10 Oct 2025 16:32:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7D3D102F21B3;
	Fri, 10 Oct 2025 18:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760113929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pBVjYyQaOHn9Ik1fDoHu9eZ8SXCQAudCG8yjKEp/G2Y=;
	b=kwc9QkyRkyaJaPEi2u4+QXJ4WKJT3ztIEJ6MP8BcqI8b5CXFsY+HtAwBDIHmzPV+GpR2cJ
	dAPQNauShMHVcfjXIZS3a9NnEFcb/620JNuPeZBoH5hdhecEIfV6V/ylMQvfE1wgE2cmIZ
	RIHM1/bu9PvBOqdAC25qyRcsUvLfI/7txZf60bODlcFg9vP1hb5/fxpLf0AaNozidbqQjV
	VZrB/TYaXJf9+yWx7LPQKt5KWVMAeHrypCNVR+3IAgOLrbnPGBk7lxTrTyeI39r2GRKwO6
	Mh6VuGUxVM/9SOrWPMzhiq9XvQXtFjif8OQjBmgexugctEgkkxAo0vP31HoHpA==
Date: Fri, 10 Oct 2025 18:31:52 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ayush Singh
 <ayush@beagleboard.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
 <robh@kernel.org>, Andrew Davis <afd@ti.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, Jason Kridner
 <jkridner@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20251010183152.1530f5ab@bootlin.com>
In-Reply-To: <aOi8oLGYVckesJSb@zatzit>
References: <20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
	<aNJVqSpdAJzGliNx@zatzit>
	<20250923114849.2385736d@bootlin.com>
	<CAMuHMdWmDwedyPnBERs-tSYEG15nMUuh9u1Q+W_FdquHpUC0-A@mail.gmail.com>
	<aNNvaN4xJtKBFmWT@zatzit>
	<cd9763b7-919a-4b44-a347-f1491d9584b9@beagleboard.org>
	<aNtXnAeLj3xNwkyE@zatzit>
	<CAMuHMdV+sUZpMtbCtWqJMiL_JC_nFEJcFDOoZJZPhhzhY8zQJQ@mail.gmail.com>
	<aOi8oLGYVckesJSb@zatzit>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 10 Oct 2025 18:58:24 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Sep 30, 2025 at 09:52:44AM +0200, Geert Uytterhoeven wrote:
> > Hi David,
> > 
> > On Tue, 30 Sept 2025 at 06:34, David Gibson <david@gibson.dropbear.id.au> wrote:  
> > > On Wed, Sep 24, 2025 at 10:33:50PM +0530, Ayush Singh wrote:  
> > > > On 9/24/25 09:41, David Gibson wrote:  
> [snip]
> > > > > > > > a) Addons can only add completely new nodes, never modify existing
> > > > > > > >     ones.  This means that whatever addons are present at runtime,
> > > > > > > >     every node has a single well defined owner (either base board or
> > > > > > > >     addon).  
> > > > > > > In this rule I suppose that "never modify existing ones" should be understood
> > > > > > > as "never modify, add or remove properties in existing ones". Because, of course
> > > > > > > adding a full node in a existing one is allowed (rule b).  
> > > > > > What if the add-on board contains a provider for the base board.
> > > > > > E.g. the connector has a clock input, fed by an optional clock generator
> > > > > > on the add-on board.  Hooking that into the system requires modifying
> > > > > > a clocks property in the base board, cfr. [1].
> > > > > > Or is there some other solution?  
> > > > > Hmm.  My first inclination would be that this case is not in scope for
> > > > > the protocol we're trying to design now.  If the widget provides
> > > > > things to the base board as well as the other way around, it's no
> > > > > longer an "addon" for the purposes of this spec.
> > > > >
> > > > > But it's possible I've underestimated how common / useful such a case
> > > > > is.
> > > > >
> > > > > Note that I'd expect the existing overlay mechanism to still be
> > > > > around.  It may be ugly and not very well thought out, but its
> > > > > drawbacks are much less severe if you're not dealing with hot unplug.  
> > > >
> > > > Well, while that was not an initial use-case in my mind, external clock
> > > > inputs are a valid use-case when talking about connectors for board headers
> > > > specifically (e.g. pocketbeagle connector).  
> > >
> > > I guess I'm not familiar enough with modern embedded hardware.  I'm
> > > having a hard time wrapping my head around what's going on here.  If
> > > the external clock input is optional (hence under a connector), how is
> > > anything on the base board dependent on it?  If nothing on the base
> > > board is dependent, why do we need to modify its properties to
> > > represent it?
> > >
> > > Is this a design flaw in the clocks binding?  
> > 
> > In my example, the external clock input is indeed optional, and not
> > used by the base board itself.  Still, it is a clock input to the SoC,
> > and may be used as a reference clock when an add-on board is connected
> > that needs to use the exact clock frequency of that reference clock.
> > 
> > https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/boot/dts/renesas/white-hawk-ard-audio-da7212.dtso
> > AUDIO_CLKIN_V is the optional clock input to the SoC.
> > GP1_25/SL_SW2_V/TPU is the reference clock (actually it is not
> > generated on the add-on board, but by a PWM controller on the base
> > board, but it could just be a crystal oscillator on the add-on board
> > instead)
> > 
> > I hope this makes it clearer.  
> 
> I think so.
> 
> IIUC, the problem is that while both the producer and the consumer of
> the clock are addons, it's routed through the SoC, which is why it
> requires some representation there.
> 
> What seems like the logical approach to me is for the base board to
> have essentially an unresolved pointer to the clock input.  I'm not
> really sure how that could be sensibly encoded, though.
> 

I don't think that having unresolved symbols in the base DT is the right
direction. This base DT is used and so all symbols have to be resolved.
If any symbols are not resolved (either in addon DT or base DT), this DT
should not be used. For the base DT, "not used" means no boot.

Do we really want to support DT used in runtime with some "invalid" parts ?

IMHO, if the base DT need a resource wired at the connector and provided by
the addon, the base DT need to reference the connector. From the base DT
point of view, the consumed resource is the one provided at the connector.

if a clock is wired at the connector the connector can be seen as a clock
controller. This clock controller should be a kind of "bridge" between the
base DT clock consumer and the addon board provider and it should perform
the link without having any unresolved symbols in the base DT side.

Best regards,
Hervé

