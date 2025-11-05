Return-Path: <linux-kernel+bounces-886992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF7C36E97
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB8A134F68D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFA33C513;
	Wed,  5 Nov 2025 16:59:33 +0000 (UTC)
Received: from rmisp-mx-out1.tele.net (rmisp-mx-out1.tele.net [194.208.23.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EE33C51B;
	Wed,  5 Nov 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.208.23.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361973; cv=none; b=Dg8QOhv30St73ZzflcrGRk/VUzhShQ49ijHc5ULxg7sTGKzJa2g9Z0H5Qdtw6d6lWbLPUPnbohKla41twUL7jlqhqy21sLSO6roLlM7duPQrvzHVCbVrdCd1TMJFApCzOV6wciV5+gJpL9RXyzFZktu5FQEPQO1OAVHhu597qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361973; c=relaxed/simple;
	bh=TXoVAzG7Y7AL/yBbd47OJsY3ZR6swOismhW35Qxufa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klIDuUWIPwh6HwVEKopnoC0DFm4mVg7vJxXOvIzwvBUFUmhtj2NMx4VLa53TO6bYLkILFyVtIEN5mulr4/nAXVVP8t2ugQdckJq6/YHWvIpXZfNzqPai36HIC1+sooCaXycwMAWwKgJPWswEewOM6xFHUc6edbH/5/RUq4IJEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at; spf=fail smtp.mailfrom=emfend.at; arc=none smtp.client-ip=194.208.23.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=emfend.at
Received: from [192.168.0.207] (194-208-208-245.tele.net [194.208.208.245])
	by rmisp-mx-out1.tele.net (Postfix) with ESMTPA id B1D2310DE9D1;
	Wed,  5 Nov 2025 17:59:20 +0100 (CET)
Message-ID: <69d3396a-98a4-4f19-b2c9-de66a6b29b1d@emfend.at>
Date: Wed, 5 Nov 2025 17:59:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] media: i2c: add Himax HM1246 image sensor driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Hans de Goede
 <hansg@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>,
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
 <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
Content-Language: de-DE
From: Matthias Fend <matthias.fend@emfend.at>
In-Reply-To: <aQn_lguAdP-ZwCzK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

thank you for your feedback and suggestions for improvement.
I have some questions about a few points.

Am 04.11.2025 um 14:28 schrieb Andy Shevchenko:
> On Tue, Nov 04, 2025 at 11:31:34AM +0100, Matthias Fend wrote:
>> Add a V4L2 sub-device driver for Himax HM1246 image sensor.
>>
>> The Himax HM1246-AWD is a 1/3.7-Inch CMOS image sensor SoC with an active
>> array size of 1296 x 976. It is programmable through an I2C interface and
>> connected via parallel bus.
>>
>> The sensor has an internal ISP with a complete image processing pipeline
>> including control loops. However, this driver uses the sensor in raw mode
>> and the entire ISP is bypassed.
> 
> ...
> 
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/units.h>
> 
> This block is semi-random.
> First of all, no new code must use gpio.h, use the proper one.
> Second, many are missing, e.g., bits.h, regmap.h, types.h.
> Please, follow IWYU principle (Include What You Use).

I've noticed that you've already modified the include statements in many 
source files. I assume you've automated this somehow. May I ask how you 
did that, or is there a reliable process for verifying the include 
statements?

...

> 
>> +static int hm1246_cci_write_pll(struct hm1246 *hm1246, u8 pll1, u8 pll2,
>> +				u8 pll3)
>> +{
>> +	const struct cci_reg_sequence pll_regs[] = {
> 
> static ?
> 
>> +		{ HM1246_PLL1CFG_REG, pll1 },
>> +		{ HM1246_PLL2CFG_REG, pll2 },
>> +		{ HM1246_PLL3CFG_REG, pll3 },
>> +		{ HM1246_SBC_CTRL_REG, HM1246_SBC_CTRL_PLL_EN },
>> +	};
> 
> I would even move it outside the function. Note, static const maybe located in
> ro memory while w/o static it's just a guarantee that compiler doesn't change
> the values. Hence there is no guarantee it will be in ro memory.

The sequence is initialized with values ​​from the arguments, which are 
not constant. Therefore, the sequence cannot be put into a `ro` section.

> 
>> +	return cci_multi_reg_write(hm1246->regmap, pll_regs,
>> +				   ARRAY_SIZE(pll_regs), NULL);
>> +}
>> +
>> +static int hm1246_pll_check_locked(struct hm1246 *hm1246)
>> +{
>> +	u64 boot_ref2;
>> +	int ret;
>> +
>> +	ret = cci_read(hm1246->regmap, HM1246_SBC_BOOT_REF2_REG, &boot_ref2,
>> +		       NULL);
> 
> Despite being longer 80 I still would put it on one line. It will increase readability.
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

Doing things differently is kind of a dilemma.
Compliance with the 80-line limit is required, and local variables that 
are only used once are also undesirable.
The unsightly line break seems to be the most acceptable option, right?
Or rename the local variable to 'bref2'.

> 
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	return (boot_ref2 & HM1246_SBC_BOOT_REF2_PLL_LOCK) ? 0 : -EIO;
> 
> Think about similar improvements elsewhere in this driver.
> 
>> +}
> 
> ...
> 
>> +	/* PLL lock time: tpll typ. 100us */
> 
> It's not a variable name, use proper English.

I think you refer to "tpll typ."? I intentionally wanted to use the same 
symbols as in the datasheet. I also used them for the other delays:

/*
  * XSHUTDOWN to crystal clock oscillation:  tcrystal typ.  650us
  * Sample bootstrap pin:                    tsample  max. 2000us
  * Built in self test:                      tbist    max. 3000us
  */

Is this acceptable from this perspective?
> 
>> +	fsleep(200);
> 
> ...
> 
>> +static int hm1246_cci_write_test_pattern(struct hm1246 *hm1246, u8 mode, u16 r,
>> +					 u16 g, u16 b)
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
>> +static int hm1246_test_pattern(struct hm1246 *hm1246, u32 index)
>> +{
>> +	const u16 RGBMIN = 0x0, RGBMAX = 0x3ff;
> 
> 0 is enough (no need 0x).
> 
> 
> So, the MAX is 10-bit, Can we use rather (BIT(10) - 1) to show this?

Sure, I can write it that way too, even though the hexadecimal number 
seems easier for me to read.

> 
>> +	const struct tp {
>> +		int pattern;
>> +		u16 r, g, b;
>> +	} tps[] = {
>> +		/* 0 - Disabled */
> 
> Instead of indices in the comment, make the code robust
> 
>> +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> 
> 		[0] = { .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
> 
> It even fit 80 characters.
> 
>> +		/* 1 - Checkboard pattern */
>> +		{ .pattern = 0, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 2 - Ramp */
>> +		{ .pattern = 1, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 3 - Moving ones */
>> +		{ .pattern = 2, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 4 - Blending color bars */
>> +		{ .pattern = 3, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 5 - Color bars */
>> +		{ .pattern = 4, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 6 - Solid white */
>> +		{ .pattern = 15, .r = RGBMAX, .g = RGBMAX, .b = RGBMAX },
>> +		/* 7 - Solid black */
>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMIN },
>> +		/* 8 - Solid red */
>> +		{ .pattern = 15, .r = RGBMAX, .g = RGBMIN, .b = RGBMIN },
>> +		/* 9 - Solid green */
>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMAX, .b = RGBMIN },
>> +		/* 10- Solid blue */
>> +		{ .pattern = 15, .r = RGBMIN, .g = RGBMIN, .b = RGBMAX },
>> +	};
>> +	u8 mode;
>> +
>> +	if (index >= ARRAY_SIZE(tps))
>> +		return -EINVAL;
>> +
>> +	mode = HM1246_TEST_PATTERN_MODE_MODE(tps[index].pattern);
>> +	if (index)
>> +		mode |= HM1246_TEST_PATTERN_MODE_ENABLE;
>> +
>> +	return hm1246_cci_write_test_pattern(hm1246, mode, tps[index].r,
>> +					     tps[index].g, tps[index].b);
>> +}
> 
> ...
> 
>> +static int hm1246_set_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +	struct hm1246 *hm1246 = container_of_const(ctrl->handler, struct hm1246,
>> +						   ctrls);
> 
> Why _const()?
> Why not split it between lines like:
> 
> 	struct hm1246 *hm1246 =
> 		container_of_const(ctrl->handler, struct hm1246, ctrls);
> 
>> +	struct v4l2_subdev_state *state;
>> +	const struct v4l2_mbus_framefmt *format;
>> +	u32 val;
>> +	bool needs_cmu_update = true;
>> +	int ret = 0;
>> +
>> +	state = v4l2_subdev_get_locked_active_state(&hm1246->sd);
>> +	format = v4l2_subdev_state_get_format(state, 0);
>> +
>> +	if (ctrl->id == V4L2_CID_VBLANK) {
>> +		s64 exposure_max;
>> +
>> +		exposure_max =
>> +			format->height + ctrl->val - HM1246_COARSE_INTG_MARGIN;
>> +		ret = __v4l2_ctrl_modify_range(hm1246->exposure_ctrl,
>> +					       hm1246->exposure_ctrl->minimum,
>> +					       exposure_max,
>> +					       hm1246->exposure_ctrl->step,
>> +					       exposure_max);
>> +
>> +		if (ret) {
>> +			dev_err(hm1246->dev, "exposure ctrl range update failed\n");
>> +			return ret;
>> +		}
>> +	}
> 
>> +	if (!pm_runtime_get_if_active(hm1246->dev))
>> +		return 0;
> 
> Use ACQUIRE() and return directly where it makes sense.

That would indeed be a great solution. However, I haven't found any 
guard definitions for pm_runtime_get_if_active and therefore don't know 
how to adapt this functionality (increase usage only if already enabled) 
to use ACQUIRE.
Any clue on this?

> 
>> +	switch (ctrl->id) {
>> +	case V4L2_CID_EXPOSURE:
>> +		cci_write(hm1246->regmap, HM1246_COARSE_INTG_REG, ctrl->val,
>> +			  &ret);
>> +		break;
>> +
>> +	case V4L2_CID_ANALOGUE_GAIN:
>> +		cci_write(hm1246->regmap, HM1246_ANALOG_GLOBAL_GAIN_REG,
>> +			  ctrl->val, &ret);
>> +		break;
>> +
>> +	case V4L2_CID_VBLANK:
>> +		val = format->height + ctrl->val;
>> +		cci_write(hm1246->regmap, HM1246_FRAME_LENGTH_LINES_REG, val,
>> +			  &ret);
>> +		break;
>> +
>> +	case V4L2_CID_HFLIP:
>> +	case V4L2_CID_VFLIP:
>> +		val = 0;
>> +		if (hm1246->hflip_ctrl->val)
>> +			val |= HM1246_IMAGE_ORIENTATION_HFLIP;
>> +		if (hm1246->vflip_ctrl->val)
>> +			val |= HM1246_IMAGE_ORIENTATION_VFLIP;
>> +
>> +		cci_write(hm1246->regmap, HM1246_IMAGE_ORIENTATION_REG, val,
>> +			  &ret);
>> +		break;
>> +
>> +	case V4L2_CID_TEST_PATTERN:
>> +		ret = hm1246_test_pattern(hm1246, ctrl->val);
>> +		needs_cmu_update = false;
> 
> Like here, and you won't need needs_cmu_update anymore.
> 
>> +		break;
>> +
>> +	default:
>> +		ret = -EINVAL;
>> +		needs_cmu_update = false;
>> +		break;
>> +	}
>> +
>> +	if (needs_cmu_update)
>> +		cci_write(hm1246->regmap, HM1246_CMU_UPDATE_REG, 0, &ret);
>> +
>> +	pm_runtime_put(hm1246->dev);
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +static int hm1246_identify_module(struct hm1246 *hm1246)
> 
> This is a singleton function, right?
> 
> Check what once.h (or even once_lite.h) provides for you for such a case,
> and drop unneeded "identified" variable.

As I understand it, the ONCE macros create a static variable in the 
driver module. This means the function would only be called once in 
total, but the function should be called once per device.
Therefore, I don't think that's an option here.

> 
>> +{
>> +	u64 model_id;
>> +	int ret;
>> +
>> +	if (hm1246->identified)
>> +		return 0;
>> +
>> +	ret = cci_read(hm1246->regmap, HM1246_MODEL_ID_REG, &model_id, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (model_id != HM1246_MODEL_ID) {
>> +		dev_err(hm1246->dev, "model id mismatch: 0x%llx!=0x%x\n",
>> +			model_id, HM1246_MODEL_ID);
>> +		return -ENXIO;
>> +	}
>> +
>> +	hm1246->identified = true;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int __maybe_unused hm1246_g_register(struct v4l2_subdev *sd,
>> +					    struct v4l2_dbg_register *reg)
> 
> If v4l2.h doesn't provide a ptr_*() macro for these cases, I recommend to add and drop these __maybe_unused.

I'm not aware of anything like that.
Currently, it's common practice to use '#ifdef CONFIG_VIDEO_ADV_DEBUG', 
and a macro that would simplify that would probably be worthwhile.
But I think that's for something outside the scope of this patch.

Thanks
  ~Matthias


