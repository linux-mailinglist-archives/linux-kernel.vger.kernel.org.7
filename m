Return-Path: <linux-kernel+bounces-828739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE3B95511
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71B219071B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339428850B;
	Tue, 23 Sep 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w1fbwhvU"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44E3191B4;
	Tue, 23 Sep 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620951; cv=none; b=Md23K0PgzCkDpv22f+hMxLwrKG4JPpG969SRatancPvmez1Pg/Rxh1c3r1AdB+2oqmI+lPIv+MCcmKTr0YAHVb/rQvVys/FqXECPLegHL2ZBhFhaY1nGLeZlZpdtWIlyY9jbo1IW705hi/O+fDKLlghz9lUu/1i2LUOkYieJy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620951; c=relaxed/simple;
	bh=K7Go3Zb41kDTIPFuHJgNpyDjdTIFfmy1NrivFmMAVhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2Yl/X9ms8/8wpZ14zdqN2uw9gnPlCFdkMmwFfAhfCSD5TKv8JWjt+rllea4KMtjrACcG024IbwEkwWa5BvKSMqoI6skmZ4vjpQOksszbrR/YXRtn1/Q/DRf34QFx3tvRHys2CLjm34Pu7mnXsIChSEl+ntwefoZpyFzLpeT3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w1fbwhvU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 18DAA4E40CE7;
	Tue, 23 Sep 2025 09:49:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF68860690;
	Tue, 23 Sep 2025 09:49:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A089A102F191F;
	Tue, 23 Sep 2025 11:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758620946; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oQdA3IhF8x6QV4Q+oe5g4Z11KyDX/FE9ZNABZWhzNS8=;
	b=w1fbwhvUG8SIV47BCgNLDEtldw2HWYyrM/a/Rs3NLQnzt+FYvuhYN8ktGiEtH4yinTDNy4
	fhN0Ai+Lt+yXu/DfU8kDw+cfkPi3p4gxojRICBOlEAqfNJu86sONY2SKds/Dgoz262W4aS
	NbX0p3gbHquIKlBrMzC5evPsefA7iYSj3PF+EM1wl6JgKAHJKe3XfiRmmgid1WQqo4itPH
	t5fGLsDtYItbNZsaB7KUyElXz0+0GAmrkU7RMeORXrPIPIZ3XLlPK0V5xIC5LgQWXavzNF
	2ansrkkWoWpQrMxQI+BL+Blg0lp+rQeDnzKOjEzYdYn3ui+XVcgBLG/64yHtXw==
Date: Tue, 23 Sep 2025 11:48:49 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Ayush Singh <ayush@beagleboard.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Andrew Davis
 <afd@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, Jason
 Kridner <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250923114849.2385736d@bootlin.com>
In-Reply-To: <aNJVqSpdAJzGliNx@zatzit>
References: <aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
	<20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
	<aNJVqSpdAJzGliNx@zatzit>
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

Hi David,

On Tue, 23 Sep 2025 18:09:13 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Sep 19, 2025 at 10:47:17AM +0530, Ayush Singh wrote:
> > On 9/19/25 10:22, David Gibson wrote:
> >   
> > > On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote:  
> > > > Hi David,
> > > > 
> > > > On Thu, 18 Sep 2025 13:16:32 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > 
> > > > ...
> > > >   
> > > > > > > Thoughts above suggest a different direction, but here's what I was
> > > > > > > thinking before:
> > > > > > > 
> > > > > > > base board:
> > > > > > > 
> > > > > > > 	connector {
> > > > > > > 		/export/ "i2c" &i2c0;
> > > > > > > 	};
> > > > > > > 
> > > > > > > addon:
> > > > > > > 	eeprom@10 {
> > > > > > > 		compatible = "foo,eeprom";
> > > > > > > 		bus-reg = <&i2c 0x10>;
> > > > > > > 	}
> > > > > > > 
> > > > > > > Or, if the addon had multiple i2c devices, maybe something like:
> > > > > > > 
> > > > > > > 	board-i2c {
> > > > > > > 		compatible = "i2c-simple-bridge";
> > > > > > > 		bus-ranges = <&i2c 0 0x3ff>; /* Whole addr space */
> > > > > > > 		eeprom@10 {
> > > > > > > 			compatible = "foo,eeprom";
> > > > > > > 			reg = <0x10>;
> > > > > > > 		}
> > > > > > > 		widget@20 {
> > > > > > > 			compatible = "vendor,widget";
> > > > > > > 			reg = <0x20>;
> > > > > > > 		}
> > > > > > > 	}
> > > > > > > 
> > > > > > > Writing that, I realise I2C introduces some complications for this.
> > > > > > > Because it has #size-cells = <0>, ranges doesn't really work (without
> > > > > > > listing every single address to be translated).  Likewise, because we
> > > > > > > always need the parent bus phandle, we can't use the trick of an empty
> > > > > > > 'ranges' to mean an identity mapping.
> > > > > > > 
> > > > > > > We could invent encodings to address those, but given the addon with
> > > > > > > multiple connectors case provides another incentive for a single
> > > > > > > connector to allow adding nodes in multiple (but strictly enumerated)
> > > > > > > places in the base device tree provides a better approach.  
> > > > > > and the "place in base device tree" is the goal of the extension bus.
> > > > > > 
> > > > > > The strict enumeration of nodes enumerated is done by two means:
> > > > > >   - extension busses at connector level
> > > > > >     Those extensions are described as connector sub-nodes.
> > > > > >     The addon DT can only add nodes in those sub-nodes to describe devices
> > > > > >     connected to the relared extension bus.
> > > > > >   - export symbols
> > > > > >     An addon DT can only use symbols exported to reference symbols outside
> > > > > >     the addon DT itself.
> > > > > > 
> > > > > > Can I assume that bus extensions we proposed (i2c-bus-extension and
> > > > > > spi-bus-extension) could be a correct solution ?  
> > > > > Maybe?  I prefer the idea of a universal mechanism, not one that's
> > > > > defined per-bus-type.
> > > > > 
> > > > > 
> > > > > Also, IIUC the way bus extension operates is a bit different - nodes
> > > > > would be "physically" added under the bus extension node, but treated
> > > > > logically as if they go under the main bus.  What I'm proposing here
> > > > > is something at the actualy overlay application layer that allows
> > > > > nodes to be added to different parts of the base device tree - so you
> > > > > could add your i2c device under the main i2c bus.  
> > > > I think we should avoid this kind of node dispatching here and there in
> > > > the base DT.  
> > > Until I saw Geert's multi-connector case, I would have agreed.  That
> > > case makes me thing differently: in order to support that case we
> > > already have to handle adding information in multiple places (under
> > > all of the connectors the addon uses).  Given we have to handle that
> > > anyway, I wonder if it makes more sense to lean into that, and allow
> > > updates to multiple (strictly enumerated) places.  
> > 
> > Well, I don't love this idea. Here are my main qalms about the approach of
> > adding devices directly to the actual i2c/spi etc nodes.
> > 
> > 1. In boards with multiple connectors, they sometimes share the same i2c.
> > Now assume that someone decided to connect the same i2c device to both the
> > connectors. If we are using something like bus extension, while the node
> > would be added, it will fail in the registration since you cannot add the
> > same address device a second time. However, if we are adding the device
> > directly to the `main_i2c`, the overlay application will just end up
> > modifying the exact same device node. There is no error, or even a 2nd
> > device node in this case. It is just lost.
> > 
> > 2. How well will overlay adding and removing work when the same tree nodes
> > are modified by multiple connectors? I have not looked at the internals of
> > overlay resolution so not sure, but I don't want dynamic addition and
> > removal of devices in independent connectors to somehow become coupled.  
> 
> Ah, right.  To be clear: we absolutely don't want multiple addons
> altering the same nodes.  But I think we could do that in ways other
> than putting everything under a connector.  This is exactly why I
> think we should think this through as an end-to-end problem, rather
> trying to do it as a tweak to the existing (crap) overlay system.
> 
> So, if we're thinking of this as an entirely new way of updating the
> base dt - not "an overlay" - we can decide on the rules to ensure that
> addition and removal is sane.  Two obvious ones I think we should
> definitely have are:
> 
> a) Addons can only add completely new nodes, never modify existing
>    ones.  This means that whatever addons are present at runtime,
>    every node has a single well defined owner (either base board or
>    addon).

In this rule I suppose that "never modify existing ones" should be understood
as "never modify, add or remove properties in existing ones". Because, of course
adding a full node in a existing one is allowed (rule b).

> 
> b) Addons can only add nodes in places that are explicitly allowed by
>    the connectors they're connecting to.

I fully agree with those both a) and b) rules.

> 
> We could consider further rules as well though.  For example, we could
> say that i2c devices in an addon shouldn't be added directly under the
> base board's i2c controller, but under a subnode of that i2c
> controller assigned to that connector (which would likely have an
> empty 'ranges' property meaning addresses are mapped without
> translation).  Not really sure if that rule has more benefits or
> drawbacks, but it's worth contemplating.

IMHO, no extra rules are needed in DT addon rules to constraint i2c devices
to be added in a connector node, a connector sub-node or an i2c controller
node.

This will be constrained by the connector itself (out of DT addon rules).

I mean, according to rule b), the connector will allow some destination
places. Either it will allow the i2c controller node or a connector sub-node.

This is specific to the connector definition and it should be out of
generic DT addon rules.

Best regards,
Hervé

