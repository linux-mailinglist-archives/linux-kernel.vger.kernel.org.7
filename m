Return-Path: <linux-kernel+bounces-897011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5CC51C43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C81896302
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268530ACE6;
	Wed, 12 Nov 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emfend.at header.i=@emfend.at header.b="Z63585R9"
Received: from lx20.hoststar.hosting (lx20.hoststar.hosting [168.119.41.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B252F9980;
	Wed, 12 Nov 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.41.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944586; cv=none; b=KNcx0JGcxAb48TiLgRYjLRnWk2ahNc4cQ4IRHQhvWssE6ozyd0S1VF/4ENfSkSF4akn1qDgHKoA0QtOy/HgFJXColQsM51wRfu8rhFb1iIORudBnoLMKNWhFiGwompRKhioABiw0wfRntyyi1Cdb/jPuKJ11KVtKU/DvmTX1G8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944586; c=relaxed/simple;
	bh=lJ0uNLhfLrA7LHCPlWiozKKuJyTV2jcZ9On951jTW9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBlsppMVXfHSoRj0Bha8KDKJORGzysM/mbCIPsj7dtnKwAvD9v3fusmLEHXCMJlW0rDvnzqDfhfGzToOmgl5WpmfCTJDvy4Pn6/BK2lj3bIQs/L7EWkNK/bIWg7tuyuBObbcSA9e0NOlM9g5dKt5sGBqmBEulaWwbmNMXEVMLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at; spf=pass smtp.mailfrom=emfend.at; dkim=pass (1024-bit key) header.d=emfend.at header.i=@emfend.at header.b=Z63585R9; arc=none smtp.client-ip=168.119.41.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emfend.at
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=emfend.at;
	 s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dgGZ0Ls2Qnd1LKBBXRPbg7oJE3pekXxFEUky5palhQ4=; b=Z63585R9x3gpxZljpA0+0iAyGk
	siMmnTMjKVHW0KKIig8MHRviCPehflbVqkSS21Fk6I9N7ZXVty9SPCegpSLpO6QgO1MpKFDqAlsDI
	ZM9P6rdppInIwWAFFAbbQW1FIf9tFdBf6CTN3DEkOAmXkQDuezscNtg9UojsGOx0whNI=;
Received: from 194-208-208-245.tele.net ([194.208.208.245]:57612 helo=[192.168.0.207])
	by lx20.hoststar.hosting with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.93)
	(envelope-from <matthias.fend.oss@emfend.at>)
	id 1vJ8Aa-000uap-Ks; Wed, 12 Nov 2025 11:33:45 +0100
Message-ID: <85e049db-f7b6-4609-949d-3d93d2f3bb1e@emfend.at>
Date: Wed, 12 Nov 2025 11:33:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Fend <matthias.fend@emfend.at>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>,
 =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
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
References: <20251104-hm1246-v5-0-97c8f25b5419@emfend.at>
 <20251104-hm1246-v5-2-97c8f25b5419@emfend.at>
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com> <aRMqw_yGMatKS5mY@kekkonen.localdomain>
Content-Language: de-DE
From: Matthias Fend <matthias.fend.oss@emfend.at>
In-Reply-To: <aRMqw_yGMatKS5mY@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 
X-Spam-Bar: 
X-Spam-Report: 

Hi Sakari,

Am 11.11.2025 um 13:23 schrieb Sakari Ailus:
> Hi Andy, Matthias,
> 
> On Tue, Nov 04, 2025 at 03:28:54PM +0200, Andy Shevchenko wrote:
>> On Tue, Nov 04, 2025 at 11:31:34AM +0100, Matthias Fend wrote:
>>> Add a V4L2 sub-device driver for Himax HM1246 image sensor.
>>>
>>> The Himax HM1246-AWD is a 1/3.7-Inch CMOS image sensor SoC with an active
>>> array size of 1296 x 976. It is programmable through an I2C interface and
>>> connected via parallel bus.
>>>
>>> The sensor has an internal ISP with a complete image processing pipeline
>>> including control loops. However, this driver uses the sensor in raw mode
>>> and the entire ISP is bypassed.
>>

...

>>
>>> +static int hm1246_calc_pll(struct hm1246 *hm1246, u32 xclk, u32 link_freq,
>>> +			   u32 clocks_per_pixel, u8 *pll1, u8 *pll2, u8 *pll3)
>>> +{
>>> +	const u8 pclk_div_table[] = { 4, 5, 6, 7, 8, 12, 14, 16 };
>>> +	const u8 sysclk_div_table[] = { 1, 2, 3, 4 };
>>> +	const u8 post_div_table[] = { 1, 2, 4, 8 };
>>> +	const int sysclk_pclk_ratio = 3; /* Recommended value */
>>> +	u32 pclk, vco_out, best_vco_diff;
>>> +	int pclk_div_index, sysclk_div_index, post_div_index;
>>> +	u8 pre_div = 0, multiplier_h = 0, multiplier_l = 0;
>>> +
>>> +	if (link_freq < HM1246_PCLK_MIN || link_freq > HM1246_PCLK_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * In raw mode (1 pixel per clock) the pixel clock is internally
>>> +	 * divided by two.
>>> +	 */
>>> +	pclk = 2 * link_freq / clocks_per_pixel;
>>> +
>>> +	/* Find suitable PCLK and SYSCLK dividers. */
>>> +	for (pclk_div_index = 0; pclk_div_index < ARRAY_SIZE(pclk_div_table);
>>> +	     pclk_div_index++) {
>>> +		for (sysclk_div_index = 0;
>>> +		     sysclk_div_index < ARRAY_SIZE(sysclk_div_table);
>>> +		     sysclk_div_index++) {
>>> +			if (sysclk_div_table[sysclk_div_index] *
>>> +				    sysclk_pclk_ratio ==
>>> +			    pclk_div_table[pclk_div_index])
>>
>>> +				goto sysclk_pclk_ratio_found;
>>
>>> +		}
>>> +	}
>>
>> And instead of this goto mess, factor out to a helper.
> 
> I think the above looks fine as-is: it's easier to understand what it does
> when it's all in a single location. This isn't overly complicated, which
> would be another reason to do that.
> 
>>
>>> +	return -EINVAL;
> 
> I'd do:
> 
> 	if (sysclk_div_index == ARRAY_SIZE(sysclk_div_table))
> 		return -EINVAL;
> 
> instead of using a goto.

I don't think that will work. Once the matching divisors are found, the 
inner and outer loop must break immediately. Otherwise, the 
corresponding indices will be overwritten.

In the initial version [1], I used a variable to terminate the outer 
loop and check for success. I changed that to a goto statement, as you 
suggested.
Perhaps I should revert to the original version, which I don't consider 
overly complicated either?

Thanks
  ~Matthias

[1] https://lore.kernel.org/all/20250403-hm1246-v1-2-30990d71bc42@emfend.at/

> 
>>
>>> +sysclk_pclk_ratio_found:
>>> +
>>> +	/* Determine an appropriate post divider. */
>>> +	for (post_div_index = 0; post_div_index < ARRAY_SIZE(post_div_table);
>>> +	     post_div_index++) {
>>> +		vco_out = pclk * pclk_div_table[pclk_div_index] *
>>> +			  post_div_table[post_div_index];
>>> +
>>> +		if (vco_out >= HM1246_PLL_VCO_MIN &&
>>> +		    vco_out <= HM1246_PLL_VCO_MAX)
>>> +			break;
>>> +	}
>>> +	if (post_div_index >= ARRAY_SIZE(post_div_table))
>>> +		return -EINVAL;
>>> +
>>> +	/* Find best pre-divider and multiplier values. */
>>> +	best_vco_diff = U32_MAX;
>>> +	for (u32 div = DIV_ROUND_UP(xclk, HM1246_PLL_INCLK_MAX);
>>> +	     div <= xclk / HM1246_PLL_INCLK_MIN; div++) {
>>> +		u32 multi, multi_h, multi_l, vco, diff;
>>> +
>>> +		multi = DIV_ROUND_CLOSEST_ULL((u64)vco_out * div, xclk);
>>> +		if (multi < HM1246_PLL_MULTI_MIN ||
>>> +		    multi > HM1246_PLL_MULTI_MAX)
>>> +			continue;
>>> +
>>> +		multi_h = multi / (HM1246_PLL_MULTI_H_MIN *
>>> +				   HM1246_PLL_MULTI_L_MAX) +
>>> +			  2;
>>> +		multi_l = multi / multi_h;
>>> +		vco = div_u64((u64)xclk * multi_h * multi_l, div);
>>> +
>>> +		diff = abs_diff(vco_out, vco);
>>> +
>>> +		if (diff < best_vco_diff) {
>>> +			best_vco_diff = diff;
>>> +			pre_div = div;
>>> +			multiplier_h = multi_h;
>>> +			multiplier_l = multi_l;
>>> +		}
>>> +
>>> +		if (!diff)
>>> +			break;
>>> +	}
>>> +
>>> +	if (best_vco_diff == U32_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	*pll1 = HM1246_PLL1CFG_MULTIPLIER(multiplier_l - 1);
>>> +	*pll2 = HM1246_PLL2CFG_PRE_DIV(pre_div - 1) |
>>> +		HM1246_PLL2CFG_MULTIPLIER(multiplier_h - 2);
>>> +	*pll3 = HM1246_PLL3CFG_POST_DIV(post_div_index) |
>>> +		HM1246_PLL3CFG_SYSCLK_DIV(sysclk_div_index) |
>>> +		HM1246_PLL3CFG_PCLK_DIV(pclk_div_index);
>>> +
>>> +	return 0;
>>> +}
>>
>> ...
>>
>>> +static int hm1246_cci_write_pll(struct hm1246 *hm1246, u8 pll1, u8 pll2,
>>> +				u8 pll3)
>>> +{
>>> +	const struct cci_reg_sequence pll_regs[] = {
>>
>> static ?
>>
>>> +		{ HM1246_PLL1CFG_REG, pll1 },
>>> +		{ HM1246_PLL2CFG_REG, pll2 },
>>> +		{ HM1246_PLL3CFG_REG, pll3 },
>>> +		{ HM1246_SBC_CTRL_REG, HM1246_SBC_CTRL_PLL_EN },
>>> +	};
>>
>> I would even move it outside the function. Note, static const maybe located in
>> ro memory while w/o static it's just a guarantee that compiler doesn't change
>> the values. Hence there is no guarantee it will be in ro memory.
>>
>>> +	return cci_multi_reg_write(hm1246->regmap, pll_regs,
>>> +				   ARRAY_SIZE(pll_regs), NULL);
>>> +}
>>> +
>>> +static int hm1246_pll_check_locked(struct hm1246 *hm1246)
>>> +{
>>> +	u64 boot_ref2;
>>> +	int ret;
>>> +
>>> +	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2,
>>> +		       NULL);
>>
>> Despite being longer 80 I still would put it on one line. It will increase readability.
> 
> I prefer it as-is.
> 
>>
>> 	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
>>
>> Another option is to define local regmap:
>>
>> 	struct regmap *map = hm1246->regmap;
>> 	...
>> 	ret = cci_read(map, HM1246_SBC_BOOT_REF2_REG, &boot_ref2, NULL);
>>
>> which will be most readable and satisfy 80 limit.
>>
>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return (boot_ref2 & HM1246_SBC_BOOT_REF2_PLL_LOCK) ? 0 : -EIO;
>>
>> Think about similar improvements elsewhere in this driver.
>>
>>> +}
>>
>> ...
>>
>>> +	/* PLL lock time: tpll typ. 100us */
>>
>> It's not a variable name, use proper English.
>>
>>> +	fsleep(200);
>>
>> ...
>>
>>> +static int hm1246_cci_write_test_pattern(struct hm1246 *hm1246, u8 mode, u16 r,
>>> +					 u16 g, u16 b)
>>
>> Use logical split.
>>
>> static int hm1246_cci_write_test_pattern(struct hm1246 *hm1246, u8 mode,
>> 					 u16 r, u16 g, u16 b)
>>
>> This applies to other similar places in the code.
>>
>> ...
>>
>>> +static int hm1246_test_pattern(struct hm1246 *hm1246, u32 index)
>>> +{
>>> +	const u16 RGBMIN = 0x0, RGBMAX = 0x3ff;
>>
>> 0 is enough (no need 0x).
>>
>>
>> So, the MAX is 10-bit, Can we use rather (BIT(10) - 1) to show this?
> 
> The above value likely comes from a sensor datasheet; I think 0x3ff is fine
> as-is. If this was a bitmask with a row of bits set, I'd use GENMASK(), but
> not BIT(10) - 1.
> 
>>
>>> +	const struct tp {
>>> +		int pattern;
>>> +		u16 r, g, b;
>>> +	} tps[] = {
>>> +		/* 0 - Disabled */
>>
>> Instead of indices in the comment, make the code robust
>>
>>> +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>
>> 		[0] = { .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>
>> It even fit 80 characters.
>>
>>> +		/* 1 - Checkboard pattern */
>>> +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 2 - Ramp */
>>> +		{ .pattern = 1, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 3 - Moving ones */
>>> +		{ .pattern = 2, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 4 - Blending color bars */
>>> +		{ .pattern = 3, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 5 - Color bars */
>>> +		{ .pattern = 4, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 6 - Solid white */
>>> +		{ .pattern = 15, .r = RGBMAX, .g = RGBMAX, .b = RGBMAX },
>>> +		/* 7 - Solid black */
>>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 8 - Solid red */
>>> +		{ .pattern = 15, .r = RGBMAX, .g = RGBMIN, .b = RGBMIN },
>>> +		/* 9 - Solid green */
>>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMAX, .b = RGBMIN },
>>> +		/* 10- Solid blue */
>>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMAX },
>>> +	};
>>> +	u8 mode;
>>> +
>>> +	if (index >= ARRAY_SIZE(tps))
>>> +		return -EINVAL;
>>> +
>>> +	mode = HM1246_TEST_PATTERN_MODE_MODE(tps[index].pattern);
>>> +	if (index)
>>> +		mode |= HM1246_TEST_PATTERN_MODE_ENABLE;
>>> +
>>> +	return hm1246_cci_write_test_pattern(hm1246, mode, tps[index].r,
>>> +					     tps[index].g, tps[index].b);
>>> +}
>>
>> ...
>>
>>> +static int hm1246_set_ctrl(struct v4l2_ctrl *ctrl)
>>> +{
>>> +	struct hm1246 *hm1246 = container_of_const(ctrl->handler, struct hm1246,
>>> +						   ctrls);
>>
>> Why _const()?
>> Why not split it between lines like:
>>
>> 	struct hm1246 *hm1246 =
>> 		container_of_const(ctrl->handler, struct hm1246, ctrls);
>>
>>> +	struct v4l2_subdev_state *state;
>>> +	const struct v4l2_mbus_framefmt *format;
>>> +	u32 val;
>>> +	bool needs_cmu_update = true;
>>> +	int ret = 0;
>>> +
>>> +	state = v4l2_subdev_get_locked_active_state(&hm1246->sd);
>>> +	format = v4l2_subdev_state_get_format(state, 0);
>>> +
>>> +	if (ctrl->id == V4L2_CID_VBLANK) {
>>> +		s64 exposure_max;
>>> +
>>> +		exposure_max =
>>> +			format->height + ctrl->val - HM1246_COARSE_INTG_MARGIN;
>>> +		ret = __v4l2_ctrl_modify_range(hm1246->exposure_ctrl,
>>> +					       hm1246->exposure_ctrl->minimum,
>>> +					       exposure_max,
>>> +					       hm1246->exposure_ctrl->step,
>>> +					       exposure_max);
>>> +
>>> +		if (ret) {
>>> +			dev_err(hm1246->dev, "exposure ctrl range update failed\n");
>>> +			return ret;
>>> +		}
>>> +	}
>>
>>> +	if (!pm_runtime_get_if_active(hm1246->dev))
>>> +		return 0;
>>
>> Use ACQUIRE() and return directly where it makes sense.
> 
> That's interesting.
> 
>>
>>> +	switch (ctrl->id) {
>>> +	case V4L2_CID_EXPOSURE:
>>> +		cci_write(hm1246->regmap, HM1246_COARSE_INTG_REG, ctrl->val,
>>> +			  &ret);
>>> +		break;
>>> +
>>> +	case V4L2_CID_ANALOGUE_GAIN:
>>> +		cci_write(hm1246->regmap, HM1246_ANALOG_GLOBAL_GAIN_REG,
>>> +			  ctrl->val, &ret);
>>> +		break;
>>> +
>>> +	case V4L2_CID_VBLANK:
>>> +		val = format->height + ctrl->val;
>>> +		cci_write(hm1246->regmap, HM1246_FRAME_LENGTH_LINES_REG, val,
>>> +			  &ret);
>>> +		break;
>>> +
>>> +	case V4L2_CID_HFLIP:
>>> +	case V4L2_CID_VFLIP:
>>> +		val = 0;
>>> +		if (hm1246->hflip_ctrl->val)
>>> +			val |= HM1246_IMAGE_ORIENTATION_HFLIP;
>>> +		if (hm1246->vflip_ctrl->val)
>>> +			val |= HM1246_IMAGE_ORIENTATION_VFLIP;
>>> +
>>> +		cci_write(hm1246->regmap, HM1246_IMAGE_ORIENTATION_REG, val,
>>> +			  &ret);
>>> +		break;
>>> +
>>> +	case V4L2_CID_TEST_PATTERN:
>>> +		ret = hm1246_test_pattern(hm1246, ctrl->val);
>>> +		needs_cmu_update = false;
>>
>> Like here, and you won't need needs_cmu_update anymore.
>>
>>> +		break;
>>> +
>>> +	default:
>>> +		ret = -EINVAL;
>>> +		needs_cmu_update = false;
>>> +		break;
>>> +	}
>>> +
>>> +	if (needs_cmu_update)
>>> +		cci_write(hm1246->regmap, HM1246_CMU_UPDATE_REG, 0, &ret);
>>> +
>>> +	pm_runtime_put(hm1246->dev);
>>> +
>>> +	return ret;
>>> +}
>>
>> ...
>>
>>> +static int hm1246_identify_module(struct hm1246 *hm1246)
>>
>> This is a singleton function, right?
>>
>> Check what once.h (or even once_lite.h) provides for you for such a case,
>> and drop unneeded "identified" variable.
> 
> Once for every device, so I don't think this applies.
> 
>>
>>> +{
>>> +	u64 model_id;
>>> +	int ret;
>>> +
>>> +	if (hm1246->identified)
>>> +		return 0;
>>> +
>>> +	ret = cci_read(hm1246->regmap, HM1246_MODEL_ID_REG, &model_id, NULL);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (model_id != HM1246_MODEL_ID) {
>>> +		dev_err(hm1246->dev, "model id mismatch: 0x%llx!=0x%x\n",
>>> +			model_id, HM1246_MODEL_ID);
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	hm1246->identified = true;
>>> +
>>> +	return 0;
>>> +}
> 


