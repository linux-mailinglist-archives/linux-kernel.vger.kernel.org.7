Return-Path: <linux-kernel+bounces-822247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFB3B83616
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC6B18908A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB262EC0BF;
	Thu, 18 Sep 2025 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i7U7V58u"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A72E7F0B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181474; cv=none; b=SoXlcfn9HjLWjQz1a22NvliiQGmK8Jan6d/NKUbBdhYNhUJxcMgK4jKwRgtrivSswt6+d345bBNXSQWQsfRLNnlQHIdpysRG5Dlxfx5+bS3nz/FnX5K5mTrjZYEsL+EwPBstbLNMkFUZeTcVvKAkg8dxgsQ/L7ZUyEf2+0Nns0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181474; c=relaxed/simple;
	bh=YBR6J/xTT+tYNygOucvrzlv1Sf553Gi0K8EeE+pFDo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJqi2BzYFsW+TGnNKaUJUp/Uwc2Zy2rTuMnql8O+kY0Rz4U3YRjgMA7iCWcXSy7kQ8TNisq5tbzZoz3tLiWn7UPFJ+TKQRrbbRG2fEaDH1khiC+eHEYhb/wrkIrZz4P9uOlqEN9ihZ1SbsvKArVEhy7wruBIqJh62onHD+1weSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i7U7V58u; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8FE24C007B9;
	Thu, 18 Sep 2025 07:44:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25BCB60630;
	Thu, 18 Sep 2025 07:44:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A98F102F1870;
	Thu, 18 Sep 2025 09:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758181463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MvkDMRbtxk6Ydf/U3xFip5NWPIJs2Mr0IzgXuY8pS/I=;
	b=i7U7V58u50duMZyYG7RVH6Cpusk/ncywT8GAqowoE0tzvLbjffXsfeGJmxl6ipD+uAzL/X
	nLI+65+W7Ix6xvSBAbBilnyPGd5FnGVxVJ71sCgos7OUvK1r2nRcv4w6870qb5IeAgQFPB
	jI1YwuGqpMlUej9rJo10wYviKATweJ+j+tlo/gY7gzuyQq7goOmmL0ZrwXQpGEeiGNecMe
	nB9EGUrjf1sJnVzRfZTRbWb6roG5vTQ48SMToyQnk72oek8lVzc7qWEFOYZB93B5rbjcc9
	b5eqY4wEbZZS0qn61YoTkBIJo/O6gtKWjqH/sbTlLRT0HnYZU3rkFXpqwo5FZQ==
Date: Thu, 18 Sep 2025 09:44:09 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: David Gibson <david@gibson.dropbear.id.au>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Andrew Davis
 <afd@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ayush Singh <ayush@beagleboard.org>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, devicetree@vger.kernel.org, Jason Kridner
 <jkridner@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Device tree representation of (hotplug) connectors: discussion
 at ELCE
Message-ID: <20250918094409.0d5f92ec@bootlin.com>
In-Reply-To: <aMt5kEI_WRDOf-Hw@zatzit>
References: <aLkiNdGIXsogC6Rr@zatzit>
	<337281a8-77f9-4158-beef-ae0eda5000e4@beagleboard.org>
	<aL5dNtzwiinq_geg@zatzit>
	<20250908145155.4f130aec@bootlin.com>
	<aL-2fmYsbexEtpNp@zatzit>
	<20250909114126.219c57b8@bootlin.com>
	<aMD_qYx4ZEASD9A1@zatzit>
	<20250911104828.48ef2c0e@bootlin.com>
	<aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
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

On Thu, 18 Sep 2025 13:16:32 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

...

> > > Thoughts above suggest a different direction, but here's what I was
> > > thinking before:
> > > 
> > > base board:
> > > 
> > > 	connector {
> > > 		/export/ "i2c" &i2c0;
> > > 	};
> > > 
> > > addon:
> > > 	eeprom@10 {
> > > 		compatible = "foo,eeprom";
> > > 		bus-reg = <&i2c 0x10>;
> > > 	}
> > > 
> > > Or, if the addon had multiple i2c devices, maybe something like:
> > > 
> > > 	board-i2c {
> > > 		compatible = "i2c-simple-bridge";
> > > 		bus-ranges = <&i2c 0 0x3ff>; /* Whole addr space */
> > > 		eeprom@10 {
> > > 			compatible = "foo,eeprom";
> > > 			reg = <0x10>;
> > > 		}
> > > 		widget@20 {
> > > 			compatible = "vendor,widget";
> > > 			reg = <0x20>;
> > > 		}
> > > 	}
> > > 
> > > Writing that, I realise I2C introduces some complications for this.
> > > Because it has #size-cells = <0>, ranges doesn't really work (without
> > > listing every single address to be translated).  Likewise, because we
> > > always need the parent bus phandle, we can't use the trick of an empty
> > > 'ranges' to mean an identity mapping.
> > > 
> > > We could invent encodings to address those, but given the addon with
> > > multiple connectors case provides another incentive for a single
> > > connector to allow adding nodes in multiple (but strictly enumerated)
> > > places in the base device tree provides a better approach.  
> > 
> > and the "place in base device tree" is the goal of the extension bus.
> > 
> > The strict enumeration of nodes enumerated is done by two means:
> >  - extension busses at connector level
> >    Those extensions are described as connector sub-nodes.
> >    The addon DT can only add nodes in those sub-nodes to describe devices
> >    connected to the relared extension bus.
> >  - export symbols
> >    An addon DT can only use symbols exported to reference symbols outside
> >    the addon DT itself.
> > 
> > Can I assume that bus extensions we proposed (i2c-bus-extension and
> > spi-bus-extension) could be a correct solution ?  
> 
> Maybe?  I prefer the idea of a universal mechanism, not one that's
> defined per-bus-type.
> 
> 
> Also, IIUC the way bus extension operates is a bit different - nodes
> would be "physically" added under the bus extension node, but treated
> logically as if they go under the main bus.  What I'm proposing here
> is something at the actualy overlay application layer that allows
> nodes to be added to different parts of the base device tree - so you
> could add your i2c device under the main i2c bus.

I think we should avoid this kind of node dispatching here and there in
the base DT.

We work on decoupling busses wired to a connector and dispatching nodes
looks like this decoupling is ignored.

IMHO, keeping devices available on an addon board as nodes under the
connector is a real hardware representation.

Also, at runtime, once an addon board DT is applied, when you look at
your current DT either using /proc/device-tree or some links such as
/sys/bus/devices/.../of_node, the connector and extension bus appear
and clearly identify devices behind the connector.

> 
> That approach does complicate removal, but its not as bad as overlays
> at the moment, because a) it could be limited to adding new nodes, not
> modifying existing ones and b) the connector would specify exactly the
> places that additions are allowed.
> 

I think bus extensions comply with a) and b).

Yes, bus extensions need to be handled per-bus types but they have the
advantage of keeping the hardware reality well described and visible at
runtime in term of "wiring" topology.

Whatever the solution, this will already be handled per-bus types.
Only busses that support runtime DT node addition/removal (OF_RECONFIG_*
notifications in the kernel implementation) will support adding or
removing nodes.

Your approach is more complex, dispatch node here and there and actually
is also a per-bus types solution.

I think, in order to choose between both solutions, the main question is:
Do we want to dispatch nodes provided by an addon DT everywhere in the base
DT ?

IMHO, the answer is no.

Rob, others, any opinion ?

Best regards,
Hervé

