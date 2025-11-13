Return-Path: <linux-kernel+bounces-899417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A00C57A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F7154E715B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C035292D;
	Thu, 13 Nov 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7xX8AZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA6351FC1;
	Thu, 13 Nov 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040412; cv=none; b=XGd8Gqg/FJl8xZPF+uS0mWdeEBbg4YHKeRcKaXmec1xjDvsnFhwVg9hCkAEmMkgtu2RPeZJiT2JRAUCcegmz4jTGSDEEeTFRWEfMQm0frPjAJAAFbENplrDBkcaOPnezYM9uZ8Vxbx2BDcbDyvfarFQDxTAoR+tHxLaR2NTUl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040412; c=relaxed/simple;
	bh=YsSWLV8vBSY4DDYcpolN8qsPMCj2Pn3CnBgTIOuCk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5koMHj6MbQiDZR5agtORNty76Vbmmjqz1jXMQ0HHG9h2YuP6b2E8dlclw0YPTQhmBSZrxrG/QOzkXk6O9ve6UKBC5ImrvzUnpnUV2JnN52OSqtwO2KyIPtc89MbBMBlRPr9Or+qrBlas//Nv2oF1PQV6eC+6hErnY+jSRGcvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7xX8AZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42359C2BC87;
	Thu, 13 Nov 2025 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040412;
	bh=YsSWLV8vBSY4DDYcpolN8qsPMCj2Pn3CnBgTIOuCk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7xX8AZYC7TeYFP47BxYfARY0zHy/hq3oaHOmk4H9t0SJoRNm335CDEgREZ3ToG7z
	 +s1EvuEs8/IYUwamzMeP9s+QA5LshygsQ4PP8vklnybiaYVEUrYIuS9yuiGUvb1u5N
	 DwpSKW/jkVQlx6CBH9MaNBZSCcqkjWyHCIi34G1FoG/VAf2RR5F2t/C1nzWe1N1OcF
	 jHVoovWLxGagO0c6V2HW57SXjoDzbvcz/TJESRDntRPLoLQUMbeaU8wnwmHFPTsE80
	 PfYASnrLzUG8/8jfaHw4wdZUOFGmS9MmsiUql06L74t2ftoinWioBwlk+paIMLT3Vq
	 8EB10CKduT3FA==
Date: Thu, 13 Nov 2025 13:26:48 +0000
From: Lee Jones <lee@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v3] mfd: bcm590xx: Add support for interrupt handling
Message-ID: <20251113132648.GG1949330@google.com>
References: <20251013-bcm590xx-irq-v3-1-0ceb060d2ee8@gmail.com>
 <20251023130335.GM475031@google.com>
 <b0cffa2f-6ad2-40a3-a5ee-5df6b2918524@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0cffa2f-6ad2-40a3-a5ee-5df6b2918524@gmail.com>

On Wed, 29 Oct 2025, Artur Weber wrote:

> On 23.10.2025 15:03, Lee Jones wrote:
> > On Mon, 13 Oct 2025, Artur Weber wrote:
> > 
> > > The BCM590XX supports up to 128 internal interrupts, which are used by
> > > various parts of the chip. Add regmap_irq-based interrupt handling and
> > > helper functions to allow subdevice drivers to easily use the interrupts.
> > > 
> > > Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> > > 
> > > (...)>>
> > > diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> > > index 5a8456bbd63f..fb6afe277ebf 100644
> > > --- a/drivers/mfd/bcm590xx.c
> > > +++ b/drivers/mfd/bcm590xx.c
> > > @@ -26,16 +26,29 @@
> > >   #define BCM590XX_PMUREV_ANA_MASK	0xF0
> > >   #define BCM590XX_PMUREV_ANA_SHIFT	4
> > > +#define BCM590XX_REG_IRQ1		0x20
> > > +#define BCM590XX_REG_IRQ1MASK		0x30
> > 
> > This isn't better.
> > 
> > And now the nomenclature is inconsistent with the one above.
> > 
> > What is a mask register?  I don't understand.
> 
> The IRQxMASK registers store the interrupt masks for each interrupt. To
> explain this more clearly:
> 
> The BCM590xx chips have up to 128 internal interrupts (the exact number
> is different between the BCM59054 and BCM59056, but both reserve the
> exact same amount of registers for them).
> 
> The status of each interrupt is stored in the IRQx registers
> (0x20-0x2f), and each bit represents a single interrupt.
> 
> The interrupt masks (that is, whether the interrupt is enabled or
> disabled) are stored in the IRQx_MASK registers (0x30-0x3f), and each
> bit represents the mask for a single interrupt, in the same order as the
> IRQx registers. (...would IRQMASKx be more consistent?)
> 
> Each register stores 8 bits of data, meaning the {status, mask} for 8
> interrupts can fit into one {status, mask} register.

Okay, so the "MASK" thing is just silly naming by the H/W designers?

STATUS or ENABLE sounds like it would be better, since a "mask" to me is
a software term which describes the methods for manipulating these kinds
of groups of bits.

> > > +{
> > > +	/*
> > > +	 * IRQ registers are clear-on-read, make sure we don't cache them
> > > +	 * so that they get read/cleared correctly
> > > +	 */
> > > +	return (reg >= BCM590XX_REG_IRQ1 && reg <= (BCM590XX_REG_IRQ1 + 15));
> > > +}
> > > +
> > >   static const struct regmap_config bcm590xx_regmap_config_pri = {
> > >   	.reg_bits	= 8,
> > >   	.val_bits	= 8,
> > >   	.max_register	= BCM590XX_MAX_REGISTER_PRI,
> > > +	.volatile_reg	= bcm590xx_volatile_pri,
> > >   	.cache_type	= REGCACHE_MAPLE,
> > >   };
> > > @@ -46,6 +59,258 @@ static const struct regmap_config bcm590xx_regmap_config_sec = {
> > >   	.cache_type	= REGCACHE_MAPLE,
> > >   };
> > > +#define BCM590XX_REGMAP_IRQ_REG(id)	REGMAP_IRQ_REG_LINE(id, 8)
> > 
> > It looks like this may benefit more than just this driver.
> > 
> > Please create a generic helper in include/linux/regmap.h.
> > 
> > Perhaps REGMAP_IRQ_REG_LINE_BYTE, or whatever the 8 represents.
> 
> I would rather avoid modifying the regmap code if possible.

Why not?

> I've seen another driver (drivers/power/supply/max77705_charger.c) use
> REGMAP_IRQ_REG_LINE(id, BITS_PER_BYTE), which is more descriptive than
> just leaving the raw number of bits. Would that be a good alternative?

Sounds fine to me.

-- 
Lee Jones [李琼斯]

