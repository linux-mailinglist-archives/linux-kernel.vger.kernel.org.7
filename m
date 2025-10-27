Return-Path: <linux-kernel+bounces-871121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD8C0C7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F4F3BC7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BA2F744D;
	Mon, 27 Oct 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJLxEgRN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C92F3C3E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554756; cv=none; b=VsSsnB7VYsV0p7DkNE3yAb9o0a7t7yYuTOWpdaaVCfDAzjCNsqoJWQ69p2L/UaGdfnioqxzg5ImvQwkv8JA73dAAsMhOsykkGuDX4UdE5QjtVRBSabOjY8RFKo6A0rWVGBtl/1i1WGqMYMUbSOVko53TBDPmpCs9Z5KOPnJEBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554756; c=relaxed/simple;
	bh=JnvYIzFF8xkW5zsRS2PaJem3tZc10+qWM0MkrbTS5N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDKHJGkNWQxIz4JetFJOVaFOFiYaDWk1kVfeY7GeyIyqmQ/jEcrfRq2sQcvInD7rNmY4JKQv/TzllWyIQDLGq4jFD6MbdiJ1pv6JGUczSZh2kpk6WFD5orPAA8HWGyENbnCC47N5EQERHngQKBj8g5o+jI56gchEkR5nFB+9I2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJLxEgRN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761554753; x=1793090753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnvYIzFF8xkW5zsRS2PaJem3tZc10+qWM0MkrbTS5N0=;
  b=dJLxEgRNQ7cyE4kAw/LXsboUCc4bXF3HJlbT2dv55umifotU5Llm2BzJ
   Wz/argB1UVEjQZ66BkywkMgBnhLYkG11aagbwslXqd3SfpHGd2JirYfk/
   cS60Hn80nvLxbX9nXlFaFxfZg81DTUtWIHjsT5JNgImbic22kAVCbpwgv
   LTyo46RKZ9DNO5TFfbO4WfOsfm/hN4EzAZY9Q4F9iqwQL8yxTCmqvRrI1
   oXKfl6blwNrQB9hJFqaTJnWbLpfMavUUAggsAx68WfC2HzejzID7IrBpJ
   bhx3PcuHNuseahOsIv4g+mbqlVzAqy+fmxI9mAuxaUvpxr12Kia4f8iPA
   A==;
X-CSE-ConnectionGUID: CHTsDtN3S2KSmwV0SvuYlA==
X-CSE-MsgGUID: EJa9o/N7TJOS+NvrVoFCLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74747918"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74747918"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:45:53 -0700
X-CSE-ConnectionGUID: lG5Oj1X/Rfup9winklnxpQ==
X-CSE-MsgGUID: e/cg+KneT5qzqnivI7IJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="190122935"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:45:52 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDIrM-00000002x29-2xyM;
	Mon, 27 Oct 2025 10:45:48 +0200
Date: Mon, 27 Oct 2025 10:45:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Eggers <ceggers@arri.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: regmap: Modeling a shared page selection register
Message-ID: <aP8xPOG68qL2IQ-A@smile.fi.intel.com>
References: <2241758.yiUUSuA9gR@n9w6sw14>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2241758.yiUUSuA9gR@n9w6sw14>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 25, 2025 at 06:22:26PM +0200, Christian Eggers wrote:
> Hi,
> 
> I try to develop a driver for the JLSemi JL5104 Ethernet switch (no public
> documentation  available, sorry).  The device is attached via the MDIO bus 
> and offers different register accesses (it occupies 8 PHY addresses):
> 
> 1. Direct access (on each PHY address for the first 16 registers)
> 2. Paged access (only on PHY address 0, last 16 registers are paged, 
>    register 31 is used for page selection)
> 
> There are also 'indirectly' accessed registers, but that is not part of
> this question.
> 
> I would like to build regmap for this like the following:
> 
> ---------------------------------------8<---------------------------------------------------
> /* Regmap addresses are built from the phy address, the page number and the register address */
> #define JL51XX_PHY_PHY_MASK		GENMASK(25, 21)  /* PHY address, 5 bit */
> #define JL51XX_PHY_PAGE_MASK		GENMASK(20,  5)  /* Page address within PHY, 16 bit */
> #define JL51XX_PHY_REG_MASK		GENMASK( 4,  0)  /* Register within page, 5 bit */
> 
> 
> #define JL51XX_PHY0_BASE		0x00000000U
> #define JL51XX_PHY_BLOCK_SIZE		0x00200000U
> #define JL51XX_PHY_BASE(PHY)		(JL51XX_PHY0_BASE + (PHY) * JL51XX_PHY_BLOCK_SIZE)
> #define JL51XX_PHY_END(PHY)		(JL51XX_PHY_BASE(PHY) + JL51XX_PHY_BLOCK_SIZE - 1)
> 
> /* Page selection register, shared between all PHYs !!! */
> #define JL51XX_PHY_PAGE_SEL			31

Ranges are sets of virtual (subject to page select) registers. If you have a
common subset of the register with paging available, it should be a _single_
range. I.o.w. _a_ range per set of the registers with a unique selector.

See, for example, drivers/pinctrl/pinctrl-cy8c95x0.c how it does it.
The HW has more selectors (i.e. PWM settings) than what is currently
implemented, but you can get an idea.

> #define JL51XX_PAGED_REGMAP_RANGE(PHY) \
> {									\
> 	.name = "JL51xx PHY" __stringify(PHY) " paged registers", 	\
> 	.range_min	= JL51XX_PHY_BASE(PHY), 			\
> 	.range_max	= JL51XX_PHY_END(PHY), 				\
> 	/*.selector_reg	= JL51XX_PHY_BASE(PHY) + JL51XX_PHY_PAGE_SEL, */				\
> 	.selector_reg	= JL51XX_PHY_PAGE_SEL, 				\
> 	.selector_mask	= GENMASK(15, 0), 				\
> 	.selector_shift	= 0,						\
> 	.window_start	= JL51XX_PHY_BASE(PHY),				\
> 	.window_len	= 32,						\
> }

> static const struct regmap_range_cfg jl51xx_paged_regmap_ranges[] = {
> 	JL51XX_PAGED_REGMAP_RANGE(0),
> 	JL51XX_PAGED_REGMAP_RANGE(1),
> 	JL51XX_PAGED_REGMAP_RANGE(2),
> 	JL51XX_PAGED_REGMAP_RANGE(3),
> 	JL51XX_PAGED_REGMAP_RANGE(4),
> 	JL51XX_PAGED_REGMAP_RANGE(5),
> 	JL51XX_PAGED_REGMAP_RANGE(6),
> 	JL51XX_PAGED_REGMAP_RANGE(7),
> };
> 
> static const struct regmap_config jl51xx_paged_regmap_config = {
> 	.name = "JL51xx direct accessible (paged) registers",
> 
> 	.reg_bits	= 32,  // roundup(phy[5] + page[8] + reg[5], 8)
> 	.reg_stride	= 1,
> 	.val_bits	= 16,
> 	.readable_reg	= jl51xx_paged_regmap_readable_reg,
> 	.volatile_reg	= jl51xx_paged_regmap_volatile_reg,
> 	.lock 		= jl51xx_regmap_lock,
> 	.unlock		= jl51xx_regmap_unlock,
> 	.max_register	= JL51XX_PHY0_BASE
> 			  + JL51XX_NUM_PHYS * JL51XX_PHY_BLOCK_SIZE - 1,
> 	.cache_type	= REGCACHE_MAPLE,
> 	.ranges 	= jl51xx_paged_regmap_ranges,
> 	.num_ranges 	= ARRAY_SIZE(jl51xx_paged_regmap_ranges),
> };
> 
> ...
> 	jl51xx->regmap_paged = devm_regmap_init(dev,
> 						&jl51xx_regmap_mdio_c22_bus,
> 						jl51xx, &jl51xx_paged_regmap_config);
> 
> --------------------------------------->8---------------------------------------------------
> 
> The problem is, that devm_regmap_init() prints the following error:
> 
> > jl51xx 2188000.ethernet-1:00: Range 0: selector for 1 in window
> 
> So, regmap complains because the selector_reg (JL51XX_PHY_PAGE_SEL) of one
> range appears within the range_min..rage_max area of another/all ranges 
> (PHYs in my case). But this is how the hardware actually works.

Of course, the idea of paging is that you have a single address space which
maps on per-page base. Also consider leaving the default page address be
untouched (meaning that most likely you will have direct access to the
registers _and_ via virtual address space to the "default" page).

> Of course, I could access the JL51XX_PHY_PAGE_SEL also via unique aliases
> which lay inside the individual ranges (see the line which is commented out). 
> But this would break caching (as all aliases of the PAGE_SEL register share
> the same resource in hardware). Caching this particular register is the 
> most significant speedup I can imagine for this device, as it has to be 
> accessed for almost every other register access.
> 
> On the other hand, the PAGE_SEL register is not meaningful for the first
> 16 registers of each PHY.  So, coding individual cached page selection logic
> (within the driver, without using regmap ranges at all) could avoid
> writing the PAGE_SEL register when accessing registers which are
> not dependent on the page selection logic.
> 
> I have also tried to model this using only a single regmap_range (for
> all PHYs). But then, the 'PHY address' part of the regmap_adress gets
> lost within regmap's page selection logic (the PHY address becomes
> part of the page address, until it is by the masked out by the 
> 'selector_mask').

Perhaps it's due to the detail I just described in the previous paragraph
(of my answer).

> After commenting out the "selector / range" checking logic in __regmap_init(),
> everything seems to work fine:
> 
> #if 0
> 			if (range_cfg->range_min <= sel_reg &&
> 			    sel_reg <= range_cfg->range_max) {
> 				dev_err(map->dev,
> 					"Range %d: selector for %d in window\n",
> 					i, j);
> 				goto err_range;
> 			}
> #endif
> 
> This check dates back since 2012, so it feels wrong to me to simply remove it:
> 6863ca622759 ("regmap: Add support for register indirect addressing.")

Right, the logic behind paging implementation in regmap is a bit tricky
(and has some known non-critical bugs, FWIW). There is no documentation
and it appears that most of the drivers using it, do it wrongly.

I am a bit lazy to spend time for googling, but you may try to exercise the
lore.kernel.org search with my name and things related to the regmap paging /
selector and find some discussions in the past.

> So should I better open coding the page selection stuff into my driver?

-- 
With Best Regards,
Andy Shevchenko



