Return-Path: <linux-kernel+bounces-864406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA7BFAB88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF7F4F4612
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DE2F28F2;
	Wed, 22 Oct 2025 07:58:24 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E22F363B;
	Wed, 22 Oct 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119903; cv=none; b=pFK2fReWI5lCRh3Nd6Rk4y/NOdikn6fqJCajX3DoXXVyAI84YmZz/MqMQXB3P4Dn4T7PXFWr1g7+xFMz6Vd+bvAaVtpeznfxSd1ATzAN9Zx4PRhjZqkVNbFqrDcoOuai/SHJQY8YSCsWPjuMavfjAb7WxhpmlQJJdIfSwU5KTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119903; c=relaxed/simple;
	bh=4UGFq1170WVAIkupsDNq6rGzRNKdY+KUwaehb3h3gFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQLdMOiX5uUyJYZKOt0Dt+2Q5dNLG2QODGSqR1OCMQYgkbs0ht8jFdMnNkzggI9uO8Tvi+Vh29ORCWjqQjv350LTn8xDEEHaNy8O1ANcZTevGLq1bHTBHx5lUKsp1hj3qrbviAKKtpfIiWf+eXrAnl1hWh9Dut/2decFAWS9v4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 86374340D20;
	Wed, 22 Oct 2025 07:58:20 +0000 (UTC)
Date: Wed, 22 Oct 2025 15:58:16 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: axp20x: add support for the AXP318W
Message-ID: <20251022075816-GYC1522542@gentoo.org>
References: <20251021112013.2710903-1-andre.przywara@arm.com>
 <20251021112013.2710903-4-andre.przywara@arm.com>
 <20251022001420-GYA1522542@gentoo.org>
 <20251022014706.2475539d@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022014706.2475539d@minigeek.lan>

Hi Andre,

On 01:47 Wed 22 Oct     , Andre Przywara wrote:
> On Wed, 22 Oct 2025 08:14:20 +0800
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi,
> 
> thanks for having a look!
> 
> > Hi Andre,
> > 
> > On 12:20 Tue 21 Oct     , Andre Przywara wrote:
> > > The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
> > > DC/DC converters and 28 LDOs, on the regulator side.
> > > 
> > > Describe the chip's voltage settings and switch registers, how the
> > > voltages are encoded, and connect this to the MFD device via its
> > > regulator ID.
> > > We use just "318" for the internal identifiers, for easier typing and
> > > less churn. If something else other than the "AXP318W" shows up, that's
> > > an easy change, externally visible strings carry the additional letter
> > > already.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  drivers/regulator/axp20x-regulator.c | 170 ++++++++++++++++++++++++++-
> > >  include/linux/mfd/axp20x.h           |  43 +++++++
> > >  2 files changed, 211 insertions(+), 2 deletions(-)
> > > 
..
> > > +
> > > +static const struct linear_range axp318_dcdc8_ranges[] = {
> > > +	REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
> > > +	REGULATOR_LINEAR_RANGE(1220000,  71, 102,  20000),
> > > +	REGULATOR_LINEAR_RANGE(1900000, 103, 118, 100000),
> > > +};  
> > 
> > In the AXP318W datasheet, it says:
> > section 7.1 DCDC/LCO desgin
> >  8. DCDC6/7/8/9 only able to tune at two voltage ranges which are
> >  <1.54v and >1.54v, the tuning voltage should not step cross 1.54v
> >  (I translate the original doc into english)
> 
> Thanks, I now read something similar in my Google translated copy of the
> datasheet. But I don't understand what this is supposed to mean? That
> exactly 1.54V does not work, so the value of 87 is invalid? But any
> other value can be set?
I did a hard chinese - english translation..

No, I think it's probably a mistake that if user interpret value 87 as invalid,
from my understanding, DCDC6-9 only able to tune the voltage in two ranges:
(if user need to adjust the voltage dynamically)

a) range 0.5v - 1.54v (probably include 1.54v)
b) range 1.54v - 1.9v (probably also include 1.54v)

but can not tune in this case, example from range 1.5v - 1.6v which will
cross 1.54v point

I don't understand the logic behind but guess it's up to the HW/SoC
restriction in the design perspective..
> 
> > 
> > so, with this restricition, should we split the range into two?
> > one is dcdc6_lo_range, another dcdc6_hi_range
> > 
> > or what do you think?
> > 
> > ..
> > > +	AXP_DESC(AXP318, ELDO1, "eldo1", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO1_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL3, BIT(6)),
> > > +	AXP_DESC(AXP318, ELDO2, "eldo2", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO2_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL3, BIT(7)),
> > > +	AXP_DESC(AXP318, ELDO3, "eldo3", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO3_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(0)),
> > > +	AXP_DESC(AXP318, ELDO4, "eldo4", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO4_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(1)),
> > > +	AXP_DESC(AXP318, ELDO5, "eldo5", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO5_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(2)),
> > > +	AXP_DESC(AXP318, ELDO6, "eldo6", "eldoin", 500, 1500, 25,
> > > +		 AXP318_ELDO6_CONTROL, AXP318_ELDO_V_OUT_MASK,
> > > +		 AXP318_LDO_OUTPUT_CONTROL4, BIT(3)),  
> > 
> > also, in section 7.1 DCDC/LCO desgin
> >  3. ELDOIN can use DCDC's output as the voltage input, once in this case,
> >  the LDO (output?) config voltage should lower than DCDC input voltage.
> > 
> > Note: ELDOIN can use PS(Power Supply, should be equal to DCIN) or DCDC as input
> > 
> > in case of Radxa A7A (A733) board, it use DCDC9 as ELDOIN,
> > Should we do something in the driver level? or leave up to user
> 
> "User" really means board vendor here, right? As the actual board
could be user from software level perspective, who use or design this

> user is not meant to adjust those voltages anyway, and any range
> limitations should be considered during the board design phase.
I'd be fine if push these up to designer, and blame them for wrong usage

> So yes, DCDC9 is at 1.24V on the Radxa, and ELDOIN is connected to
> that, but only ELDO1 and ELDO6 are used, and they are fixed to 900mV
> and 800mV, respectively, and connected to SoC pins that require exactly
> those voltages. So there is no room for change or to adjust things
> here, and the requirements are met.
for this single case, right, we shouldn't worry about..

> If board designers/people ignore that, that it just won't work, and
> they get to keep the pieces. Nothing the driver can do here.
> 
from a driver level, at least we can emit an error message to alert 
user of the wrong voltage value set..

> Cheers,
> Andre
> 

-- 
Yixun Lan (dlan)

