Return-Path: <linux-kernel+bounces-824835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684EB8A3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE2B7BB89A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067631771E;
	Fri, 19 Sep 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H5+ogntH"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CE2F83BA;
	Fri, 19 Sep 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295257; cv=none; b=d6nZFwHk8imtNmM7som4/GVCTiWQHM6s+/P8Q/kqXqCO+DcuBN5vAfPKkCsDZ2lWrPg8u4pjFpqw1dTmgNlSWZUB/6csTlTkuK71+PEJKnaRj5GuKU3wXa/fn1tuMXmWUM7vVSiWYjfabO3CSu1do+8pnVuI8d0IwJSobb6S1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295257; c=relaxed/simple;
	bh=MViMuuNgZD7sjfNlh6TXFukLjkEGvIaxt16zUzYp7VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BviNfcxoN/VtcWau+iL+2oe8BdOs04ebeCJaJDRDc73Cb8I56d3Hw1wpWuu297rHQgAxa99WQi5CM8LGqy4I8Fm8C8hmvup7UUA9mZVkvApWIW8wdwVVpRdVwhIQbFZwpyLeB8yzeZC94v9l7VwlxgwUFMfpAaP8Psc4XUvuAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H5+ogntH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 217B11A0F07;
	Fri, 19 Sep 2025 15:20:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE3DE606A8;
	Fri, 19 Sep 2025 15:20:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8C86102F183B;
	Fri, 19 Sep 2025 17:20:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758295252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x7trutKtRuIY9robPMYlNj2akoLusmpHD27Z0lZC8tk=;
	b=H5+ogntHioAoI7eXHmQ7xbwiOO313ybPdTlIEeK2ime/ZF5ufYpUG32BVjrJErXLa25CR5
	mSnjtqxLydWAOZ4c4HWzRke6om15K2aJbXQiS5k7EXtIFBlmNuLMairpT9brl6D/bSR4b8
	EM7QgsrZ+bxaY8GJe3SCRRLZ62x+kSs3TBQCDuPrspQf86pv9twFAQFzpC/4i889SKdFbt
	GEljet7948QPH4Ek4B8/1aTW8PSq+0FL0ig+PCzFl0JiwfDnLc2m/JjXD2nQOD/uZ+n2Os
	nfAyGyVxi0UCPq/dmLBb/vNFOW7+WNUwPFDsGGplyRBEl+eHeWWHBkEpKaORTg==
Date: Fri, 19 Sep 2025 17:20:36 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Ayush Singh <ayush@beagleboard.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Herve Codina
 <herve.codina@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Andrew Davis <afd@ti.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, Jason
 Kridner <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree-compiler@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250919172036.2f2b4bab@booty>
In-Reply-To: <dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
References: <aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
	<20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 19 Sep 2025 10:47:17 +0530
Ayush Singh <ayush@beagleboard.org> wrote:

> On 9/19/25 10:22, David Gibson wrote:
> 
> > On Thu, Sep 18, 2025 at 09:44:09AM +0200, Herve Codina wrote:  
> >> Hi David,
> >>
> >> On Thu, 18 Sep 2025 13:16:32 +1000
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>
> >> ...
> >>  
> >>>>> Thoughts above suggest a different direction, but here's what I was
> >>>>> thinking before:
> >>>>>
> >>>>> base board:
> >>>>>
> >>>>> 	connector {
> >>>>> 		/export/ "i2c" &i2c0;
> >>>>> 	};
> >>>>>
> >>>>> addon:
> >>>>> 	eeprom@10 {
> >>>>> 		compatible = "foo,eeprom";
> >>>>> 		bus-reg = <&i2c 0x10>;
> >>>>> 	}
> >>>>>
> >>>>> Or, if the addon had multiple i2c devices, maybe something like:
> >>>>>
> >>>>> 	board-i2c {
> >>>>> 		compatible = "i2c-simple-bridge";
> >>>>> 		bus-ranges = <&i2c 0 0x3ff>; /* Whole addr space */
> >>>>> 		eeprom@10 {
> >>>>> 			compatible = "foo,eeprom";
> >>>>> 			reg = <0x10>;
> >>>>> 		}
> >>>>> 		widget@20 {
> >>>>> 			compatible = "vendor,widget";
> >>>>> 			reg = <0x20>;
> >>>>> 		}
> >>>>> 	}
> >>>>>
> >>>>> Writing that, I realise I2C introduces some complications for this.
> >>>>> Because it has #size-cells = <0>, ranges doesn't really work (without
> >>>>> listing every single address to be translated).  Likewise, because we
> >>>>> always need the parent bus phandle, we can't use the trick of an empty
> >>>>> 'ranges' to mean an identity mapping.
> >>>>>
> >>>>> We could invent encodings to address those, but given the addon with
> >>>>> multiple connectors case provides another incentive for a single
> >>>>> connector to allow adding nodes in multiple (but strictly enumerated)
> >>>>> places in the base device tree provides a better approach.  
> >>>> and the "place in base device tree" is the goal of the extension bus.
> >>>>
> >>>> The strict enumeration of nodes enumerated is done by two means:
> >>>>   - extension busses at connector level
> >>>>     Those extensions are described as connector sub-nodes.
> >>>>     The addon DT can only add nodes in those sub-nodes to describe devices
> >>>>     connected to the relared extension bus.
> >>>>   - export symbols
> >>>>     An addon DT can only use symbols exported to reference symbols outside
> >>>>     the addon DT itself.
> >>>>
> >>>> Can I assume that bus extensions we proposed (i2c-bus-extension and
> >>>> spi-bus-extension) could be a correct solution ?  
> >>> Maybe?  I prefer the idea of a universal mechanism, not one that's
> >>> defined per-bus-type.
> >>>
> >>>
> >>> Also, IIUC the way bus extension operates is a bit different - nodes
> >>> would be "physically" added under the bus extension node, but treated
> >>> logically as if they go under the main bus.  What I'm proposing here
> >>> is something at the actualy overlay application layer that allows
> >>> nodes to be added to different parts of the base device tree - so you
> >>> could add your i2c device under the main i2c bus.  
> >> I think we should avoid this kind of node dispatching here and there in
> >> the base DT.  
> > Until I saw Geert's multi-connector case, I would have agreed.  That
> > case makes me thing differently: in order to support that case we
> > already have to handle adding information in multiple places (under
> > all of the connectors the addon uses).  Given we have to handle that
> > anyway, I wonder if it makes more sense to lean into that, and allow
> > updates to multiple (strictly enumerated) places.  
> 
> Well, I don't love this idea. Here are my main qalms about the approach 
> of adding devices directly to the actual i2c/spi etc nodes.
> 
> 1. In boards with multiple connectors, they sometimes share the same 
> i2c. Now assume that someone decided to connect the same i2c device to 
> both the connectors. If we are using something like bus extension, while 
> the node would be added, it will fail in the registration since you 
> cannot add the same address device a second time. However, if we are 
> adding the device directly to the `main_i2c`, the overlay application 
> will just end up modifying the exact same device node. There is no 
> error, or even a 2nd device node in this case. It is just lost.

Thinking out loud: what about preventing loading any overlay that does
more than just adding nodes? IOW forbidding to create properties in
nodes already in the live tree, and modifying existing properties.

I think being very restrictive in terms of overlays the implementation
can accept is a good idea in general. A requirement can be relaxed in
the future, but forbidding what used to be allowed would be a nightmare.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

