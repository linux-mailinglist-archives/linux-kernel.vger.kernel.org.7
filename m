Return-Path: <linux-kernel+bounces-895400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75346C4DB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03964FC768
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A9223DD6;
	Tue, 11 Nov 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdhIPBVK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047452737E7;
	Tue, 11 Nov 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863824; cv=none; b=fqH/I0ve6qsHS8DjvW7OQCHqO823UAxANAXlY6Ne/l3J7asWpJ+wPThN/5Rp0az0SFNE/fWwtnlVDP9GNO9Y1Y52y1Ht9Kdka/52AHT6mlCsfE08Bw8bu929x7KoJdF/W0950NEbXf7IsQHKGn7U0eTsaPzLKBW3GyYmAb6hkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863824; c=relaxed/simple;
	bh=6EpV0VAnroljRKERj3Z2h5E1lc7vc1uC0tnqJCxs/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSJaU99osQaQW64QFsWq3pTXd9hZcg4rz16HOVheRKEnkfRzq3HwWzNLfLtrxsmWcrJ7fELITZPdxuEbE9QZcXzUptj5FbuiB6scbW3Oyfd3zsppoYRK/8ToqLTBAAmx5DkFVhhW/F52V2+wif6jF55KGn6WGb93qkWKkx4QvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdhIPBVK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762863821; x=1794399821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EpV0VAnroljRKERj3Z2h5E1lc7vc1uC0tnqJCxs/Es=;
  b=kdhIPBVKmSMGCcrkPaG0iQP2qkmyrSRK+6GV4DbaLn0CxOz8eJnMLSd3
   Mydg30SMAr36ZkmuvCKi/0XbTqjiTObnScWotgILD6aqg/hkg60TYZCGB
   AXZQaDyHMEyMjkw3qmFAR/n3AiHJ2hRqOxUwuudT9oT5G+MIfHh3oNi3r
   u+JV8H6QxYVkXBzD6Rb1ALFzSdBAdL/aGX6QEgUtC2H8iaZwoq1zBPg0X
   zo2Ts0YuhbLlgMX/i/cRIRIfdIzaeG1nyp0ktOA+jHrPttQA7QVU/7XlO
   /ox+LfTcldgSK7/69oxjvfPAyZi4DE/bsv/lAsIg6w5wfdJA6lsBFilh8
   w==;
X-CSE-ConnectionGUID: HXzZvTqAQQ2KswWG9jB98g==
X-CSE-MsgGUID: LiItNI5cRk6oVNEnhJGoIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64957760"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64957760"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:23:40 -0800
X-CSE-ConnectionGUID: weIIScanQSar5TscP8ewSg==
X-CSE-MsgGUID: +CZy5Gu6SiGJHJRCy6UfXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188716718"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.96])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 04:23:34 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 06B8711F983;
	Tue, 11 Nov 2025 14:23:32 +0200 (EET)
Date: Tue, 11 Nov 2025 14:23:31 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Fend <matthias.fend@emfend.at>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
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
Message-ID: <aRMqw_yGMatKS5mY@kekkonen.localdomain>
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQn_lguAdP-ZwCzK@smile.fi.intel.com>

Hi Andy, Matthias,

On Tue, Nov 04, 2025 at 03:28:54PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 11:31:34AM +0100, Matthias Fend wrote:
> > Add a V4L2 sub-device driver for Himax HM1246 image sensor.
> > 
> > The Himax HM1246-AWD is a 1/3.7-Inch CMOS image sensor SoC with an active
> > array size of 1296 x 976. It is programmable through an I2C interface and
> > connected via parallel bus.
> > 
> > The sensor has an internal ISP with a complete image processing pipeline
> > including control loops. However, this driver uses the sensor in raw mode
> > and the entire ISP is bypassed.
> 
> ...
> 
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/units.h>
> 
> This block is semi-random.
> First of all, no new code must use gpio.h, use the proper one.
> Second, many are missing, e.g., bits.h, regmap.h, types.h.
> Please, follow IWYU principle (Include What You Use).
> 
> ...
> 
> > +static inline struct hm1246 *to_hm1246(struct v4l2_subdev *sd)
> > +{
> > +	return container_of_const(sd, struct hm1246, sd);
> 
> It's unclear and confusing that _const() variant is used here.
> Either const qualifier is missed somewhere, or _const is redundant.
> 
> > +}
> 
> ...
> 
> > +	/*
> > +	 * XSHUTDOWN to crystal clock oscillation:  tcrystal typ.  650us
> > +	 * Sample bootstrap pin:                    tsample  max. 2000us
> > +	 * Built in self test:                      tbist    max. 3000us
> > +	 */
> > +	fsleep(6000);
> 
> Also possible to write as 6 * USEC_PER_MSEC
> 
> ...
> 
> > +	format = v4l2_subdev_state_get_format(state, 0);
> > +	mode = v4l2_find_nearest_size(hm1246_modes, ARRAY_SIZE(hm1246_modes),
> > +				      width, height, format->width,
> > +				      format->height);
> > +
> > +	switch (sel->target) {
> > +	case V4L2_SEL_TGT_CROP:
> > +		sel->r = *v4l2_subdev_state_get_crop(state, 0);
> > +		return 0;
> > +
> > +	case V4L2_SEL_TGT_NATIVE_SIZE:
> > +		sel->r.top = 0;
> > +		sel->r.left = 0;
> > +		sel->r.width = HM1246_NATIVE_WIDTH;
> > +		sel->r.height = HM1246_NATIVE_HEIGHT;
> > +		return 0;
> > +
> > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > +		sel->r.top = mode->top;
> > +		sel->r.left = mode->left;
> > +		sel->r.width = mode->width;
> > +		sel->r.height = mode->height;
> > +		return 0;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> > +	return 0;
> 
> Do we need this line?
> 
> ...
> 
> > +static int hm1246_calc_pll(struct hm1246 *hm1246, u32 xclk, u32 link_freq,
> > +			   u32 clocks_per_pixel, u8 *pll1, u8 *pll2, u8 *pll3)
> > +{
> > +	const u8 pclk_div_table[] = { 4, 5, 6, 7, 8, 12, 14, 16 };
> > +	const u8 sysclk_div_table[] = { 1, 2, 3, 4 };
> > +	const u8 post_div_table[] = { 1, 2, 4, 8 };
> > +	const int sysclk_pclk_ratio = 3; /* Recommended value */
> > +	u32 pclk, vco_out, best_vco_diff;
> > +	int pclk_div_index, sysclk_div_index, post_div_index;
> > +	u8 pre_div = 0, multiplier_h = 0, multiplier_l = 0;
> > +
> > +	if (link_freq < HM1246_PCLK_MIN || link_freq > HM1246_PCLK_MAX)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * In raw mode (1 pixel per clock) the pixel clock is internally
> > +	 * divided by two.
> > +	 */
> > +	pclk = 2 * link_freq / clocks_per_pixel;
> > +
> > +	/* Find suitable PCLK and SYSCLK dividers. */
> > +	for (pclk_div_index = 0; pclk_div_index < ARRAY_SIZE(pclk_div_table);
> > +	     pclk_div_index++) {
> > +		for (sysclk_div_index = 0;
> > +		     sysclk_div_index < ARRAY_SIZE(sysclk_div_table);
> > +		     sysclk_div_index++) {
> > +			if (sysclk_div_table[sysclk_div_index] *
> > +				    sysclk_pclk_ratio ==
> > +			    pclk_div_table[pclk_div_index])
> 
> > +				goto sysclk_pclk_ratio_found;
> 
> > +		}
> > +	}
> 
> And instead of this goto mess, factor out to a helper.

I think the above looks fine as-is: it's easier to understand what it does
when it's all in a single location. This isn't overly complicated, which
would be another reason to do that.

> 
> > +	return -EINVAL;

I'd do:

	if (sysclk_div_index == ARRAY_SIZE(sysclk_div_table))
		return -EINVAL;

instead of using a goto.

> 
> > +sysclk_pclk_ratio_found:
> > +
> > +	/* Determine an appropriate post divider. */
> > +	for (post_div_index = 0; post_div_index < ARRAY_SIZE(post_div_table);
> > +	     post_div_index++) {
> > +		vco_out = pclk * pclk_div_table[pclk_div_index] *
> > +			  post_div_table[post_div_index];
> > +
> > +		if (vco_out >= HM1246_PLL_VCO_MIN &&
> > +		    vco_out <= HM1246_PLL_VCO_MAX)
> > +			break;
> > +	}
> > +	if (post_div_index >= ARRAY_SIZE(post_div_table))
> > +		return -EINVAL;
> > +
> > +	/* Find best pre-divider and multiplier values. */
> > +	best_vco_diff = U32_MAX;
> > +	for (u32 div = DIV_ROUND_UP(xclk, HM1246_PLL_INCLK_MAX);
> > +	     div <= xclk / HM1246_PLL_INCLK_MIN; div++) {
> > +		u32 multi, multi_h, multi_l, vco, diff;
> > +
> > +		multi = DIV_ROUND_CLOSEST_ULL((u64)vco_out * div, xclk);
> > +		if (multi < HM1246_PLL_MULTI_MIN ||
> > +		    multi > HM1246_PLL_MULTI_MAX)
> > +			continue;
> > +
> > +		multi_h = multi / (HM1246_PLL_MULTI_H_MIN *
> > +				   HM1246_PLL_MULTI_L_MAX) +
> > +			  2;
> > +		multi_l = multi / multi_h;
> > +		vco = div_u64((u64)xclk * multi_h * multi_l, div);
> > +
> > +		diff = abs_diff(vco_out, vco);
> > +
> > +		if (diff < best_vco_diff) {
> > +			best_vco_diff = diff;
> > +			pre_div = div;
> > +			multiplier_h = multi_h;
> > +			multiplier_l = multi_l;
> > +		}
> > +
> > +		if (!diff)
> > +			break;
> > +	}
> > +
> > +	if (best_vco_diff == U32_MAX)
> > +		return -EINVAL;
> > +
> > +	*pll1 = HM1246_PLL1CFG_MULTIPLIER(multiplier_l - 1);
> > +	*pll2 = HM1246_PLL2CFG_PRE_DIV(pre_div - 1) |
> > +		HM1246_PLL2CFG_MULTIPLIER(multiplier_h - 2);
> > +	*pll3 = HM1246_PLL3CFG_POST_DIV(post_div_index) |
> > +		HM1246_PLL3CFG_SYSCLK_DIV(sysclk_div_index) |
> > +		HM1246_PLL3CFG_PCLK_DIV(pclk_div_index);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int hm1246_cci_write_pll(struct hm1246 *hm1246, u8 pll1, u8 pll2,
> > +				u8 pll3)
> > +{
> > +	const struct cci_reg_sequence pll_regs[] = {
> 
> static ?
> 
> > +		{ HM1246_PLL1CFG_REG, pll1 },
> > +		{ HM1246_PLL2CFG_REG, pll2 },
> > +		{ HM1246_PLL3CFG_REG, pll3 },
> > +		{ HM1246_SBC_CTRL_REG, HM1246_SBC_CTRL_PLL_EN },
> > +	};
> 
> I would even move it outside the function. Note, static const maybe located in
> ro memory while w/o static it's just a guarantee that compiler doesn't change
> the values. Hence there is no guarantee it will be in ro memory.
> 
> > +	return cci_multi_reg_write(hm1246->regmap, pll_regs,
> > +				   ARRAY_SIZE(pll_regs), NULL);
> > +}
> > +
> > +static int hm1246_pll_check_locked(struct hm1246 *hm1246)
> > +{
> > +	u64 boot_ref2;
> > +	int ret;
> > +
> > +	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2,
> > +		       NULL);
> 
> Despite being longer 80 I still would put it on one line. It will increase readability.

I prefer it as-is.

> 
> 	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
> 
> Another option is to define local regmap:
> 
> 	struct regmap *map = hm1246->regmap;
> 	...
> 	ret = cci_read(map, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
> 
> which will be most readable and satisfy 80 limit.
> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return (boot_ref2 & HM1246_SBC_BOOT_REF2_PLL_LOCK) ? 0 : -EIO;
> 
> Think about similar improvements elsewhere in this driver.
> 
> > +}
> 
> ...
> 
> > +	/* PLL lock time: tpll typ. 100us */
> 
> It's not a variable name, use proper English.
> 
> > +	fsleep(200);
> 
> ...
> 
> > +static int hm1246_cci_write_test_pattern(struct hm1246 *hm1246, u8 mode, u16 r,
> > +					 u16 g, u16 b)
> 
> Use logical split.
> 
> static int hm1246_cci_write_test_pattern(struct hm1246 *hm1246, u8 mode,
> 					 u16 r, u16 g, u16 b)
> 
> This applies to other similar places in the code.
> 
> ...
> 
> > +static int hm1246_test_pattern(struct hm1246 *hm1246, u32 index)
> > +{
> > +	const u16 RGBMIN = 0x0, RGBMAX = 0x3ff;
> 
> 0 is enough (no need 0x).
> 
> 
> So, the MAX is 10-bit, Can we use rather (BIT(10) - 1) to show this?

The above value likely comes from a sensor datasheet; I think 0x3ff is fine
as-is. If this was a bitmask with a row of bits set, I'd use GENMASK(), but
not BIT(10) - 1.

> 
> > +	const struct tp {
> > +		int pattern;
> > +		u16 r, g, b;
> > +	} tps[] = {
> > +		/* 0 - Disabled */
> 
> Instead of indices in the comment, make the code robust
> 
> > +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> 
> 		[0] = { .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> 
> It even fit 80 characters.
> 
> > +		/* 1 - Checkboard pattern */
> > +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 2 - Ramp */
> > +		{ .pattern = 1, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 3 - Moving ones */
> > +		{ .pattern = 2, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 4 - Blending color bars */
> > +		{ .pattern = 3, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 5 - Color bars */
> > +		{ .pattern = 4, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 6 - Solid white */
> > +		{ .pattern = 15, .r = RGBMAX, .g = RGBMAX, .b = RGBMAX },
> > +		/* 7 - Solid black */
> > +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> > +		/* 8 - Solid red */
> > +		{ .pattern = 15, .r = RGBMAX, .g = RGBMIN, .b = RGBMIN },
> > +		/* 9 - Solid green */
> > +		{ .pattern = 15, .r = RGBMIN, .g = RGBMAX, .b = RGBMIN },
> > +		/* 10- Solid blue */
> > +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMAX },
> > +	};
> > +	u8 mode;
> > +
> > +	if (index >= ARRAY_SIZE(tps))
> > +		return -EINVAL;
> > +
> > +	mode = HM1246_TEST_PATTERN_MODE_MODE(tps[index].pattern);
> > +	if (index)
> > +		mode |= HM1246_TEST_PATTERN_MODE_ENABLE;
> > +
> > +	return hm1246_cci_write_test_pattern(hm1246, mode, tps[index].r,
> > +					     tps[index].g, tps[index].b);
> > +}
> 
> ...
> 
> > +static int hm1246_set_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct hm1246 *hm1246 = container_of_const(ctrl->handler, struct hm1246,
> > +						   ctrls);
> 
> Why _const()?
> Why not split it between lines like:
> 
> 	struct hm1246 *hm1246 =
> 		container_of_const(ctrl->handler, struct hm1246, ctrls);
> 
> > +	struct v4l2_subdev_state *state;
> > +	const struct v4l2_mbus_framefmt *format;
> > +	u32 val;
> > +	bool needs_cmu_update = true;
> > +	int ret = 0;
> > +
> > +	state = v4l2_subdev_get_locked_active_state(&hm1246->sd);
> > +	format = v4l2_subdev_state_get_format(state, 0);
> > +
> > +	if (ctrl->id == V4L2_CID_VBLANK) {
> > +		s64 exposure_max;
> > +
> > +		exposure_max =
> > +			format->height + ctrl->val - HM1246_COARSE_INTG_MARGIN;
> > +		ret = __v4l2_ctrl_modify_range(hm1246->exposure_ctrl,
> > +					       hm1246->exposure_ctrl->minimum,
> > +					       exposure_max,
> > +					       hm1246->exposure_ctrl->step,
> > +					       exposure_max);
> > +
> > +		if (ret) {
> > +			dev_err(hm1246->dev, "exposure ctrl range update failed\n");
> > +			return ret;
> > +		}
> > +	}
> 
> > +	if (!pm_runtime_get_if_active(hm1246->dev))
> > +		return 0;
> 
> Use ACQUIRE() and return directly where it makes sense.

That's interesting.

> 
> > +	switch (ctrl->id) {
> > +	case V4L2_CID_EXPOSURE:
> > +		cci_write(hm1246->regmap, HM1246_COARSE_INTG_REG, ctrl->val,
> > +			  &ret);
> > +		break;
> > +
> > +	case V4L2_CID_ANALOGUE_GAIN:
> > +		cci_write(hm1246->regmap, HM1246_ANALOG_GLOBAL_GAIN_REG,
> > +			  ctrl->val, &ret);
> > +		break;
> > +
> > +	case V4L2_CID_VBLANK:
> > +		val = format->height + ctrl->val;
> > +		cci_write(hm1246->regmap, HM1246_FRAME_LENGTH_LINES_REG, val,
> > +			  &ret);
> > +		break;
> > +
> > +	case V4L2_CID_HFLIP:
> > +	case V4L2_CID_VFLIP:
> > +		val = 0;
> > +		if (hm1246->hflip_ctrl->val)
> > +			val |= HM1246_IMAGE_ORIENTATION_HFLIP;
> > +		if (hm1246->vflip_ctrl->val)
> > +			val |= HM1246_IMAGE_ORIENTATION_VFLIP;
> > +
> > +		cci_write(hm1246->regmap, HM1246_IMAGE_ORIENTATION_REG, val,
> > +			  &ret);
> > +		break;
> > +
> > +	case V4L2_CID_TEST_PATTERN:
> > +		ret = hm1246_test_pattern(hm1246, ctrl->val);
> > +		needs_cmu_update = false;
> 
> Like here, and you won't need needs_cmu_update anymore.
> 
> > +		break;
> > +
> > +	default:
> > +		ret = -EINVAL;
> > +		needs_cmu_update = false;
> > +		break;
> > +	}
> > +
> > +	if (needs_cmu_update)
> > +		cci_write(hm1246->regmap, HM1246_CMU_UPDATE_REG, 0, &ret);
> > +
> > +	pm_runtime_put(hm1246->dev);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +static int hm1246_identify_module(struct hm1246 *hm1246)
> 
> This is a singleton function, right?
> 
> Check what once.h (or even once_lite.h) provides for you for such a case,
> and drop unneeded "identified" variable.

Once for every device, so I don't think this applies.

> 
> > +{
> > +	u64 model_id;
> > +	int ret;
> > +
> > +	if (hm1246->identified)
> > +		return 0;
> > +
> > +	ret = cci_read(hm1246->regmap, HM1246_MODEL_ID_REG, &model_id, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (model_id != HM1246_MODEL_ID) {
> > +		dev_err(hm1246->dev, "model id mismatch: 0x%llx!=0x%x\n",
> > +			model_id, HM1246_MODEL_ID);
> > +		return -ENXIO;
> > +	}
> > +
> > +	hm1246->identified = true;
> > +
> > +	return 0;
> > +}

-- 
Kind regards,

Sakari Ailus

