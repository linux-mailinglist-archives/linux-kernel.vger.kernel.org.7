Return-Path: <linux-kernel+bounces-837240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE4BABC23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FDB7A8557
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0682BDC16;
	Tue, 30 Sep 2025 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aphjo0ME"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF221494C3;
	Tue, 30 Sep 2025 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216184; cv=none; b=R4h9DWgkgF8CN6rNu4r221TedeSiWq1lTffoW4p/bYU+OCuHHGb8ySJ7cBcAZbMpkwtSHHFMvalD93PuJ+rfXIAN9HvyiSCijeR191v64dIAA7xT9M7V8ygcieB66NAQIm6ixQ3ixRDUIROJ89qS3QrrqP2wPAqis8t68R/W6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216184; c=relaxed/simple;
	bh=NI78X0vkxVcPeiH8F3i5aaFKnTiGHjAqH0QVO1HeQEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qa3Bjsz5mJ8WUpVRCAtO8xmO1c1zZ8WbQxdeptKD3rfj8p/QTsQm7mcQ9ZQiSmFgDAXAPsq4OERpOmJA44sdZaGJDdZdq2qs2jCnbqH2yECQQLLYWJ/lsXk1DVuNDFYw9rtw9pUf+Qio48LhDzLWjUCYZgK8Nzsj8K9DXz6r4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aphjo0ME; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A7E551A100F;
	Tue, 30 Sep 2025 07:09:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75FDA606E4;
	Tue, 30 Sep 2025 07:09:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 899AC102F1760;
	Tue, 30 Sep 2025 09:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759216176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Pr2fwh74vGkx9cj7ksefwre+SXb8wauBsJ6yuvEOiDM=;
	b=aphjo0ME8MyM3FQNiBjEfGZJ0cTJokftC3bxuGJ1RixJpVhyNKDfPklEwpGCjX3m7BZUO0
	3qcyfv/2DPMTvTAyZ8Qscctd6PR3zllIZVXgsujNg+ycxMOr9COUhzwMtzRnWqabaRPNFz
	Sg++UVOD+qKCr5qztNnxRS/VhB4H56jNVIj89YQzpOSPeK+By1/3gzJJLuzNd395TOXjuR
	XdFXCf8wRmE9CpvrFqDsPpUhfVSQXY6ho0xl/s/iiJFx3G1W0ArrL9GNbYj5t9wI3DSG0c
	VyKy0yqANR9DhlgCgP2cgh2xje+yf7/K19nLYqIo+J02CS3Lm8SK56UnCxjZjg==
Date: Tue, 30 Sep 2025 09:09:24 +0200
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
Message-ID: <20250930090924.1bfc8730@bootlin.com>
In-Reply-To: <aNpQCboQimgwIkJw@zatzit>
References: <aMebXe-yJy34kST8@zatzit>
	<20250916084631.77127e29@bootlin.com>
	<aMt5kEI_WRDOf-Hw@zatzit>
	<20250918094409.0d5f92ec@bootlin.com>
	<aMzhgDYOuG4qNcc0@zatzit>
	<dcbeaff2-0147-4a27-bb46-e247e42810d7@beagleboard.org>
	<aNJVqSpdAJzGliNx@zatzit>
	<20250923114849.2385736d@bootlin.com>
	<aNNrbmZfZU-1xJFm@zatzit>
	<20250924143130.0a34badb@bootlin.com>
	<aNpQCboQimgwIkJw@zatzit>
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

On Mon, 29 Sep 2025 19:23:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Sep 24, 2025 at 02:31:30PM +0200, Herve Codina wrote:
> > Hi David,
> > 
> > On Wed, 24 Sep 2025 13:54:22 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > ...
> >   
> > > > 
> > > > IMHO, no extra rules are needed in DT addon rules to constraint i2c devices
> > > > to be added in a connector node, a connector sub-node or an i2c controller
> > > > node.
> > > > 
> > > > This will be constrained by the connector itself (out of DT addon rules).    
> > > 
> > > At this point I'm just considering the end-to-end rules we want to
> > > enforce.  Exactly what stage of the process enforces each rule is
> > > another question.
> > >   
> > > > I mean, according to rule b), the connector will allow some destination
> > > > places. Either it will allow the i2c controller node or a connector sub-node.    
> > > 
> > > Sure.
> > >   
> > > > This is specific to the connector definition and it should be out of
> > > > generic DT addon rules.    
> > > 
> > > Hang on... what distinction are you seeing between the "connector
> > > definition" and "generic DT addon rules".  As I see it we're trying to
> > > create a protocol that defines both the base rules and what a
> > > "connector" even means.
> > >   
> > 
> > The "generic DT addon rules" give rules related to addon from a DT
> > perspective. In other word "What an addon DT can do"
> >  - export symbols
> >  - import symbols
> >  - Add full node only
> >  - Don't allow to modify existing node
> >  - ...
> > 
> > The way addon are used is what I put behind "connector definition".
> > The connector is a specific node in a DT with a specific comptible string.
> > The definition of this node will tell "how to use it". For instance:
> >   - There is 2 gpios available and an addon can use it with <&connector 0> and
> >     <&connector 1>.
> >   - There is an i2c bus available and an addon can use if with <&i2c-a>
> >   - The hotplug mecanism used for this specific connector (gpio, eeprom, ...)
> >     is also part of the "connector definition".
> > 
> > An external board DT supposed to be connected to this connector should
> >   - a) Provide its description using an addon DT (compliant with "generic DT
> >        addon rules")
> > and
> > 
> >   - b) Use resources from connector the board is connected to (compliant with
> >        "connector definition").
> > 
> > "generic DT addon rules": DT specification
> > "connector definition": Connector binding  
> 
> Ok.  I think there are some further possible distinctions here between:
> 
>  a. Rules for connectors in general
>  b. Rules for a specific connector type (defined by the connector type
>     binding)
>  c. Rules for a specific connector instance (defined by the property
>     values in that instance).
> 
> Possible we can avoid using one or more of those categories, but we
> need to consider them and do so conciously.
> 
> > Today, connectors are going to use the addon feature but I didn't want to
> > restrict addon feature to connectors.  
> 
> Hmm.  I'm not sure this is a good idea.  I had been envisaging this
> new "addon" support as explicitly tied to connectors - you can't
> addon, except in a way the base board allows, and connectors are the
> way it allows.

I agree with that.

I think we just need to clarify what is the definition of "connector" in
this context.

I have the feeling that a "connector" for you is where an addon is going to
be applied.

In my mind a connector was the piece of hardware where the addon board is
connected.

Most of the time, this piece of hardware will be represented as a node in the
DT and the addon DT will be applied to this node.

I made the distinction in case of PMOD use case (Geert's use case with
multiple connector). In that case we need to find, probably with external help,
connectors connected to the addon board.

I have the feeling that in that case the description will be:
   /* Base board DT */
   pmod-group {
      pmod-connector1 {
        ...
      };
      pmod-connector2 {
        ...
      };
      pmod-connector3 {
        ...
      };
   };

The addon DT will be applied to pmod-group and the pmod-group driver
selects multiple connectors (pmod-connector1 and/or pmod-connector2
and/or pmod-connector3) according to the addon needs and some external
help in order to applied the addon DT.
   https://lore.kernel.org/all/20250911121103.40ccb112@bootlin.com/

> 
> > For instance, a FPGA driver could use the addon feature with an addon DT
> > to describe the internal part of the FPGA related to the FPGA bitstream
> > loaded by the FPGA driver. That might make sense, right ?  
> 
> With the distinction from the connector case being that the driver
> defines how to interpret the addon at runtime, rather than the base DT
> defining it statically?

Yes

> 
> > Also upstream in the kernel, PCI boards can be described using DT.
> >   https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.c
> >   https://elixir.bootlin.com/linux/v6.16/source/drivers/misc/lan966x_pci.dtso
> > 
> > Using addon DT in that case makes sense too even if a "connector" is not present.  
> 
> Ok.  So I think the model you're suggesting is this:
> 
>  * A bus/port driver (let's call it an "addon driver") can allow addon
>    DTs to be plugged in and removed, under constraints defined by that
>    driver at runtime.
> 
>  * The connector driver would be one specific addon driver, that can
>    handle a pretty broad range of not-too-complex addons.  The
>    constraints for the addon DT are defined by the properties of the
>    connector in the base DT, rather than by runtime logic in the
>    driver.
> 
> Is that correct?

Both properties of the connector and runtime logic.

In multiple connector cases, some runtime logic will be needed.

Also, in my use case, several steps are required:
1) Apply an addon DT to describe EEPROM available on all addon boards
   we supports.
2) Read the eeprom to identify the board
3) Select the right full addon DT based on the board idendified
4) Apply the full addon DT

> 
> A few observations
> 
>  - This effectively makes an addon driver a special case of a
>    discoverable bus/port driver.  Or even DT addons as a library that
>    a bus/port driver can use.  Rather than directly updating the Linux
>    device model, the driver selects an addon DT and uses that to
>    update the Linux device model.
> 
>  - The distinction between a connector and a general addon driver, is
>    a bit like that between the simple-bus driver and a PCI host bridge
>    driver.  The former handles a fairly wide range of relatively
>    simple cases, the latter handles a more complex and specialized
>    case.
> 
> I don't dislike this model, but it does raise some questions (these
> are not rhetorical):
> 
> 1) Is DT a good way of describing the addon?
> 
> After all, the addon driver could make updates directly to the Linux
> device model from whatever format is convenient.

The DT goal is to describe hardware and we are describing hardware available
on an addon board. DT description seems perfectly legit for this use case.

Let's try as an exercise. Now we have device tree (DT), let's say we want
to describe addons using the new "Another Representation of Generic
Hardware" (ARGH) syntax.

We need to:
 * implement arghc (similar to dtc)
 * write argh-bindings for chips that already have dt-bindings
 * write new argh_*() functions similar to of_*() functions
 * write new toooling like `make argh_binding_check` and
   `make arghs_check`
 * etc

Or we could look for an existing format and decide to use the device
tree format, which is maybe not perfect, but it works well for a lot of
things and has all these and more implemented already.

> 
> 2) Does it make sense to use the addon to alter the global DT?
> 
> Even if the addon is described by a DT, the addon/connector driver
> could read that DT and the system DT and make corresponding updates to
> the Linux device model without altering the system DT first.
> 

May I missed something but I think we already discussed this and you appeared
to agree with my arguments in favor of letting the addon alter very specific
nodes in the base tree that are explicitly marked as suitable in the connector
description.
  https://lore.kernel.org/all/aMebXe-yJy34kST8@zatzit/

Best regards,
Hervé

