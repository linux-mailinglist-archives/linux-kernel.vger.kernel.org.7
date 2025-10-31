Return-Path: <linux-kernel+bounces-879334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78ACC22DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66FA1A28145
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D5236A8B;
	Fri, 31 Oct 2025 01:23:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7D22D7B0;
	Fri, 31 Oct 2025 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873790; cv=none; b=JNvXwLCPPll937QrUML3S++bgMUqVHYeAumBbGnT3mPbxA+4qqzax5YkZuNQDnJtksqtyQin2NrNiJpEiE+rwqVYT76INQgxc2eocsC9ZJKh8B4HYFRb1rbulZ8hxrUq1cIJuFFgQReS0iP/Aco3waQhqcugafkFIJjX5/eNa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873790; c=relaxed/simple;
	bh=jlmxFQimafhqBmUJkzBJtgtW68QKJSyDSZXPPeuZ/wY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbb0JnkMpWCvwBhoG4gxQFztBVZhtk09yWN0eVv6vh0dioO839Fr7ZqqUS6CP8sPp919NK+c97ExL/6MKW89ti4+f7JW3inEw+38K7KBkdE+fNfLOiVu3KJ6Ifapnih7/mYpiy9KNDRinxsWOni1oB1iQzm4cS17GI8KU2q2pvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7370D15A1;
	Thu, 30 Oct 2025 18:22:59 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D013F63F;
	Thu, 30 Oct 2025 18:23:05 -0700 (PDT)
Date: Fri, 31 Oct 2025 01:22:18 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel
 Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: axp20x: add support for the AXP318W
Message-ID: <20251031012218.7cc86801@minigeek.lan>
In-Reply-To: <20251022075816-GYC1522542@gentoo.org>
References: <20251021112013.2710903-1-andre.przywara@arm.com>
	<20251021112013.2710903-4-andre.przywara@arm.com>
	<20251022001420-GYA1522542@gentoo.org>
	<20251022014706.2475539d@minigeek.lan>
	<20251022075816-GYC1522542@gentoo.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 15:58:16 +0800
Yixun Lan <dlan@gentoo.org> wrote:

Hi,

> Hi Andre,
> 
> On 01:47 Wed 22 Oct     , Andre Przywara wrote:
> > On Wed, 22 Oct 2025 08:14:20 +0800
> > Yixun Lan <dlan@gentoo.org> wrote:
> > 
> > Hi,
> > 
> > thanks for having a look!
> >   
> > > Hi Andre,
> > > 
> > > On 12:20 Tue 21 Oct     , Andre Przywara wrote:  
> > > > The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
> > > > DC/DC converters and 28 LDOs, on the regulator side.
> > > > 
> > > > Describe the chip's voltage settings and switch registers, how the
> > > > voltages are encoded, and connect this to the MFD device via its
> > > > regulator ID.
> > > > We use just "318" for the internal identifiers, for easier typing and
> > > > less churn. If something else other than the "AXP318W" shows up, that's
> > > > an easy change, externally visible strings carry the additional letter
> > > > already.
> > > > 
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > >  drivers/regulator/axp20x-regulator.c | 170 ++++++++++++++++++++++++++-
> > > >  include/linux/mfd/axp20x.h           |  43 +++++++
> > > >  2 files changed, 211 insertions(+), 2 deletions(-)
> > > >   
> ..
> > > > +
> > > > +static const struct linear_range axp318_dcdc8_ranges[] = {
> > > > +	REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
> > > > +	REGULATOR_LINEAR_RANGE(1220000,  71, 102,  20000),
> > > > +	REGULATOR_LINEAR_RANGE(1900000, 103, 118, 100000),
> > > > +};    
> > > 
> > > In the AXP318W datasheet, it says:
> > > section 7.1 DCDC/LCO desgin
> > >  8. DCDC6/7/8/9 only able to tune at two voltage ranges which are
> > >  <1.54v and >1.54v, the tuning voltage should not step cross 1.54v
> > >  (I translate the original doc into english)  
> > 
> > Thanks, I now read something similar in my Google translated copy of the
> > datasheet. But I don't understand what this is supposed to mean? That
> > exactly 1.54V does not work, so the value of 87 is invalid? But any
> > other value can be set?  
> I did a hard chinese - english translation..
> 
> No, I think it's probably a mistake that if user interpret value 87 as invalid,
> from my understanding, DCDC6-9 only able to tune the voltage in two ranges:
> (if user need to adjust the voltage dynamically)
> 
> a) range 0.5v - 1.54v (probably include 1.54v)
> b) range 1.54v - 1.9v (probably also include 1.54v)
> 
> but can not tune in this case, example from range 1.5v - 1.6v which will
> cross 1.54v point.

I am not sure I fully understand: as far is this driver is concerned,
these are just translations from target voltages to register values,
there is no notion of some transition or slope. The upper layer is
free to program any value it wants. So I don't know what the
restriction is, really: is it that the first value programmed to this
register sets a limit? So if you set something below 1.54V, you
cannot program anything higher than that later? And how do you get out
of this, by disabling the output, and re-programming? And do we really
know that, or has someone verified that, or is that just what written
in the manual?

And if that's the case, I don't see how we can model this with the
current driver. It's highly irrelevant anyway, since most voltages
programmed are fixed anyways, and for instance on the Radxa A7E are all
well below 1.54V.

So long story short: I would ignore this until someone reports an
actual issue. For the boards at hand I don't expect any.

> I don't understand the logic behind but guess it's up to the HW/SoC
> restriction in the design perspective..
> >   
> > > 
> > > so, with this restricition, should we split the range into two?
> > > one is dcdc6_lo_range, another dcdc6_hi_range
> > > 
> > > or what do you think?
> > > 
> > > ..  
> > > > +	AXP_DESC(AXP318, ELDO1, "eldo1", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO1_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL3, BIT(6)),
> > > > +	AXP_DESC(AXP318, ELDO2, "eldo2", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO2_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL3, BIT(7)),
> > > > +	AXP_DESC(AXP318, ELDO3, "eldo3", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO3_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(0)),
> > > > +	AXP_DESC(AXP318, ELDO4, "eldo4", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO4_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(1)),
> > > > +	AXP_DESC(AXP318, ELDO5, "eldo5", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO5_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(2)),
> > > > +	AXP_DESC(AXP318, ELDO6, "eldo6", "eldoin", 500, 1500, 25,
> > > > +		 AXP318_ELDO6_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(3)),    
> > > 
> > > also, in section 7.1 DCDC/LCO desgin
> > >  3. ELDOIN can use DCDC's output as the voltage input, once in this case,
> > >  the LDO (output?) config voltage should lower than DCDC input voltage.
> > > 
> > > Note: ELDOIN can use PS(Power Supply, should be equal to DCIN) or DCDC as input
> > > 
> > > in case of Radxa A7A (A733) board, it use DCDC9 as ELDOIN,
> > > Should we do something in the driver level? or leave up to user  
> > 
> > "User" really means board vendor here, right? As the actual board  
> could be user from software level perspective, who use or design this

No actual *user* on the software side would program those voltages,
those are all described in the DT. Again, if the board designer didn't
consider this, it's a major fault, and it just wouldn't work.

> > user is not meant to adjust those voltages anyway, and any range
> > limitations should be considered during the board design phase.  
> I'd be fine if push these up to designer, and blame them for wrong usage

Yes.

> > So yes, DCDC9 is at 1.24V on the Radxa, and ELDOIN is connected to
> > that, but only ELDO1 and ELDO6 are used, and they are fixed to 900mV
> > and 800mV, respectively, and connected to SoC pins that require exactly
> > those voltages. So there is no room for change or to adjust things
> > here, and the requirements are met.  
> for this single case, right, we shouldn't worry about..
> 
> > If board designers/people ignore that, that it just won't work, and
> > they get to keep the pieces. Nothing the driver can do here.
> >   
> from a driver level, at least we can emit an error message to alert 
> user of the wrong voltage value set..

But where would you do that? Is there a callback or hook, where we
could check this? I don't see any.

Cheers,
Andre

