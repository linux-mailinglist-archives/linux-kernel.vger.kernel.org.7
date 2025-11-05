Return-Path: <linux-kernel+bounces-887086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE5C373F5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317EF3B7E96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDC33033E;
	Wed,  5 Nov 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXQohAJU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBC338912;
	Wed,  5 Nov 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365417; cv=none; b=c33kW1CurMvLDU023In3NwSLf6KwZ3slC3memIqag8XcxKoaGQ2fbsCGj/q9b/Xh71uSLRzajc64r2SNPq+SXApn/w6sPFJ3ryQSEPh28tVNe6uNoaLEufPVNHItzxC4O1swlFqFV9+frnNWxFH7ZFJk1S0cvkk0TV/KCf5Ifa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365417; c=relaxed/simple;
	bh=mdjCpaLHOnfBMY0V32LZXfaf4sqf252MebKl/iKpt3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrYXzun+7E4X65vfvvEeNYIH7F3A/e/WtsNQUPi7rvcmwAb/mbEmQ6aNOihVh3G/gRsbX3NoY5KLduxB4tFi22ezhAuTCq26Y+kkmIfmG/iS9kM1xyY/9CH6q/NuLBHH1cZrimzJICb+mENTxxpTLGJZC+ueMk1l3l+zVvY/tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXQohAJU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762365414; x=1793901414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mdjCpaLHOnfBMY0V32LZXfaf4sqf252MebKl/iKpt3A=;
  b=fXQohAJUD045szFOgS66ibiSKxYR/NgKcfS7RdvFV7+kMBd4y2KLFT66
   JLtp2jGx4VetLY7CLeWdUXNcxBSdWFjVal6ChFLUXG2opHiqmKqeetSOJ
   kru/PPlF+d8QKTQs2lAPAoCQOMrPSSECS+Rqb/oQT6u7wXiNyIyP+dGDC
   UeB1S/kitrdhNwWeoT02/yzLMovZae8UhlZ0mt/iE9GxwEG2vZykRzXr1
   I9t2JD364V5dQqVL8E5meDTTcP21y+j1w61thhXn5GKAplEPORtiPEuVh
   dEkviyl/hHaLuiAAgoiUSkdanNrnIsGZykgLi8pL6X5LXuQUJUr8t2vdY
   w==;
X-CSE-ConnectionGUID: oXz+8R0cQIOtZmLlRkhxKA==
X-CSE-MsgGUID: yR4iMjLBR4StekwoSPXaxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64523530"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64523530"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:56:52 -0800
X-CSE-ConnectionGUID: RflwgjiTRRCjkUs4o6QVow==
X-CSE-MsgGUID: a2Dr2VHfSdydemmugokb7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187187998"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:56:47 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vGhkN-00000005rTL-39rZ;
	Wed, 05 Nov 2025 19:56:39 +0200
Date: Wed, 5 Nov 2025 19:56:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matthias Fend <matthias.fend@emfend.at>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Tarang Raval <tarang.raval@siliconsignals.io>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jingjing Xiong <jingjing.xiong@intel.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao Yao <hao.yao@intel.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
Message-ID: <aQuP1uNRP7vOiYKT@smile.fi.intel.com>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
 <69d3396a-98a4-4f19-b2c9-de66a6b29b1d@emfend.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d3396a-98a4-4f19-b2c9-de66a6b29b1d@emfend.at>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 05, 2025 at 05:59:20PM +0100, Matthias Fend wrote:
> Am 04.11.2025 um 14:28 schrieb Andy Shevchenko:
> > On Tue, Nov 04, 2025 at 11:31:34AM +0100, Matthias Fend wrote:

...

> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/units.h>
> > 
> > This block is semi-random.
> > First of all, no new code must use gpio.h, use the proper one.
> > Second, many are missing, e.g., bits.h, regmap.h, types.h.
> > Please, follow IWYU principle (Include What You Use).
> 
> I've noticed that you've already modified the include statements in many
> source files. I assume you've automated this somehow. May I ask how you did
> that, or is there a reliable process for verifying the include statements?

No automation is available so far (the iwyu tool needs a lot of tuning for
Linux kernel). I did it by simply reading the code. Since you are the author
you should know how to fill the inclusions much better than me.

...

> > > +	const struct cci_reg_sequence pll_regs[] = {
> > 
> > static ?
> > 
> > > +		{ HM1246_PLL1CFG_REG, pll1 },
> > > +		{ HM1246_PLL2CFG_REG, pll2 },
> > > +		{ HM1246_PLL3CFG_REG, pll3 },
> > > +		{ HM1246_SBC_CTRL_REG, HM1246_SBC_CTRL_PLL_EN },
> > > +	};
> > 
> > I would even move it outside the function. Note, static const maybe located in
> > ro memory while w/o static it's just a guarantee that compiler doesn't change
> > the values. Hence there is no guarantee it will be in ro memory.
> 
> The sequence is initialized with values ​​from the arguments, which are not
> constant. Therefore, the sequence cannot be put into a `ro` section.

Ah, indeed, you are right. It can, but it will be an intermediate (unnecessary)
step.

...

> > > +static int hm1246_pll_check_locked(struct hm1246 *hm1246)
> > > +{
> > > +	u64 boot_ref2;
> > > +	int ret;
> > > +
> > > +	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2,
> > > +		       NULL);
> > 
> > Despite being longer 80 I still would put it on one line. It will increase readability.
> > 
> > 	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
> > 
> > Another option is to define local regmap:
> > 
> > 	struct regmap *map = hm1246->regmap;
> > 	...
> > 	ret = cci_read(map, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
> > 
> > which will be most readable and satisfy 80 limit.
> 
> Doing things differently is kind of a dilemma.
> Compliance with the 80-line limit is required, and local variables that are
> only used once are also undesirable.

Why? If it increases readability than it _is_ desirable change.

> The unsightly line break seems to be the most acceptable option, right?
> Or rename the local variable to 'bref2'.

Making variable cryptic wouldn't help readability.

> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return (boot_ref2 & HM1246_SBC_BOOT_REF2_PLL_LOCK) ? 0 : -EIO;
> > 
> > Think about similar improvements elsewhere in this driver.
> > 
> > > +}

...

> > > +	/* PLL lock time: tpll typ. 100us */
> > 
> > It's not a variable name, use proper English.
> 
> I think you refer to "tpll typ."? I intentionally wanted to use the same
> symbols as in the datasheet. I also used them for the other delays:
> 
> /*
>  * XSHUTDOWN to crystal clock oscillation:  tcrystal typ.  650us
>  * Sample bootstrap pin:                    tsample  max. 2000us
>  * Built in self test:                      tbist    max. 3000us
>  */
> 
> Is this acceptable from this perspective?

This is unfortunate. When it goes with max/min is much more understandable than
standalone. Try to find a compromise. Datasheet is not a golden standard, it's
just good to have something close enough to it, but it doesn't mean we have to
follow it _literally_.

> > > +	fsleep(200);

...

> > > +	const u16 RGBMIN = 0x0, RGBMAX = 0x3ff;
> > 
> > 0 is enough (no need 0x).
> > 
> > So, the MAX is 10-bit, Can we use rather (BIT(10) - 1) to show this?
> 
> Sure, I can write it that way too, even though the hexadecimal number seems
> easier for me to read.

The hexadecimal sometimes too abstract and writing the same in a slightly
different form may give a useful additional information.

...

> > > +	if (!pm_runtime_get_if_active(hm1246->dev))
> > > +		return 0;
> > 
> > Use ACQUIRE() and return directly where it makes sense.
> 
> That would indeed be a great solution. However, I haven't found any guard
> definitions for pm_runtime_get_if_active and therefore don't know how to
> adapt this functionality (increase usage only if already enabled) to use
> ACQUIRE.
> Any clue on this?

Add a patch to add this conditional guard to pm_runtime.h.

...

> > > +static int hm1246_identify_module(struct hm1246 *hm1246)
> > 
> > This is a singleton function, right?
> > 
> > Check what once.h (or even once_lite.h) provides for you for such a case,
> > and drop unneeded "identified" variable.
> 
> As I understand it, the ONCE macros create a static variable in the driver
> module. This means the function would only be called once in total, but the
> function should be called once per device.
> Therefore, I don't think that's an option here.

Good point.

...

> > > +static int __maybe_unused hm1246_g_register(struct v4l2_subdev *sd,
> > > +					    struct v4l2_dbg_register *reg)
> > 
> > If v4l2.h doesn't provide a ptr_*() macro for these cases, I recommend to add and drop these __maybe_unused.
> 
> I'm not aware of anything like that.
> Currently, it's common practice to use '#ifdef CONFIG_VIDEO_ADV_DEBUG', and
> a macro that would simplify that would probably be worthwhile.
> But I think that's for something outside the scope of this patch.

This one may be out of scope, so up to you. But just note that using
__maybe_unused is discouraged.

-- 
With Best Regards,
Andy Shevchenko



