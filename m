Return-Path: <linux-kernel+bounces-723428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED72AFE68C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17FC17B54E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174428EC1C;
	Wed,  9 Jul 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSV6Atjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73328DB46;
	Wed,  9 Jul 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058515; cv=none; b=N/0qsaKUNQxjrK2WRqoCm9J5VrEbqStLWQiut3y9Nd7cm3HoV2oc0WjWdx7EMX3L5wkDHrZTS7cbRCt4xOSPSyVPrCHsIFvkyb5Xc+FIrY7MDjHmBYbjQaKmfyMolVgV8bg8eYCCvFrstd9OONW41Y8OEy+giGzpG9tRs0dYEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058515; c=relaxed/simple;
	bh=BoZZrPLdNLvkgaovB8uoVdZbL+TNCUitBGKqXu2vz7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGvt8WQ6xMrL3pMP+uNNxdf8fieRdLdgChUdp7whg4IybVGR6Ii/ivt/4ptQMwfuxlhRDr5gdkZp8J2fviWDjY0HBbA7adoXoijlHjWp96AAoi1J+i4XUjFbeAgxFsgTRNCLspTS8zr+ynpL/qs02Fnd7rdRCyI5A+7ZVA3Z3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSV6Atjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D7C4CEEF;
	Wed,  9 Jul 2025 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058514;
	bh=BoZZrPLdNLvkgaovB8uoVdZbL+TNCUitBGKqXu2vz7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSV6AtjkZAOb7T9bGx8VJQ8g3ItXVr41MU10uYDiFeHaMb2BVVVxKdafWhRaL21LG
	 wusskcNZlL3zRVNumJOO7KkI5++agQvK/vWPVNws+Yd7eeAmeNc5Nrs3NP2wP3AhpZ
	 uA50hKPrac/Ykb/efGTT/9hBhCrln65OgI5KCD22rT6XgWCp9iVCNz8+M2rdkWSD5r
	 SY9AfjDyUv/dCofoSOzCRVO1KQxkxr8QgFy7dt+vuvA32cAy97pL9NHsQ5KGt1wEGX
	 2BZ034Fq5NJmaejA9AvTXTVHvsYCL8xGO3e3teINEx+fdxXb2H2EyUd52IE7Dnj5M2
	 QR3iO9+edv4tw==
Date: Wed, 9 Jul 2025 12:55:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, like.xy@foxmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <20250709-elated-cat-of-variation-2d0bd1@krzk-bin>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708112901.25228-5-nick.li@foursemi.com>

On Tue, Jul 08, 2025 at 07:29:01PM +0800, Nick Li wrote:
> @@ -564,6 +565,7 @@ obj-$(CONFIG_SND_SOC_ES8375)    += snd-soc-es8375.o
>  obj-$(CONFIG_SND_SOC_ES8389)    += snd-soc-es8389.o
>  obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
>  obj-$(CONFIG_SND_SOC_FS_AMP_LIB)+= snd-soc-fs-amp-lib.o
> +obj-$(CONFIG_SND_SOC_FS210X)	+= snd-soc-fs210x.o
>  obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
>  obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
>  obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
> diff --git a/sound/soc/codecs/fs210x.c b/sound/soc/codecs/fs210x.c
> new file mode 100644
> index 000000000..5176b3399
> --- /dev/null
> +++ b/sound/soc/codecs/fs210x.c
> @@ -0,0 +1,1610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * fs210x.c -- Driver for the FS2104/5S Audio Amplifier
> + *
> + * Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>

Where do you use it?

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +
> +#include "fs210x.h"
> +#include "fs-amp-lib.h"
> +
> +#define FS210X_DRV_VERSION		"v1.0.6"
> +#define FS210X_DEFAULT_FWM_NAME		"fs210x_fwm.bin"
> +#define FS210X_DEFAULT_DAI_NAME		"fs210x-aif"
> +#define FS2105S_DEVICE_ID		0x20 /* FS2105S */
> +#define FS210X_DEVICE_ID		0x45 /* FS2104 */
> +#define FS210X_REG_MAX			0xF8
> +#define FS210X_VOLUME_MIN		0
> +#define FS210X_VOLUME_MAX		511
> +#define FS210X_INIT_SCENE		0
> +#define FS210X_DEFAULT_SCENE		1
> +#define FS210X_START_DELAY_MS		5
> +#define FS210X_FAULT_CHECK_INTERVAL_MS	2000
> +#define FS2105S_RATES			(SNDRV_PCM_RATE_32000 | \
> +					 SNDRV_PCM_RATE_44100 | \
> +					 SNDRV_PCM_RATE_48000 | \
> +					 SNDRV_PCM_RATE_88200 | \
> +					 SNDRV_PCM_RATE_96000)
> +#define FS210X_RATES			(SNDRV_PCM_RATE_16000 | FS2105S_RATES)
> +#define FS210X_FORMATS			(SNDRV_PCM_FMTBIT_S16_LE | \
> +					 SNDRV_PCM_FMTBIT_S24_LE | \
> +					 SNDRV_PCM_FMTBIT_S24_3LE | \
> +					 SNDRV_PCM_FMTBIT_S32_LE)
> +#define FS210X_NUM_SUPPLIES		ARRAY_SIZE(fs210x_supply_names)
> +
> +static const char *const fs210x_supply_names[] = {
> +	"pvdd",
> +	"dvdd",
> +};
> +
> +struct fs210x_platform_data {
> +	const char *fwm_name;
> +};
> +
> +struct fs210x_priv {
> +	struct i2c_client *i2c;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct fs210x_platform_data pdata;
> +	struct regulator_bulk_data supplies[FS210X_NUM_SUPPLIES];
> +	struct gpio_desc *gpio_sdz;
> +	struct delayed_work start_work;
> +	struct delayed_work fault_check_work;
> +	struct fs_amp_lib amp_lib;
> +	const struct fs_amp_scene *cur_scene;
> +	struct clk *clk_bclk;
> +	unsigned int bclk;
> +	unsigned int srate;
> +	int scene_id;
> +	u16 devid;
> +	u16 vol[2]; /* L/R channels volume */
> +	bool is_inited;
> +	bool is_suspended;
> +	bool is_bclk_on;
> +	bool is_playing;
> +};
> +
> +static DEFINE_MUTEX(fs210x_mutex);

Why is this file-scope? Why two independent codecs cannot work in parallel?

> +
> +static const struct fs_pll_div fs210x_pll_div[] = {
> +	/*    bclk,   pll1,   pll2,   pll3 */
> +	{   512000, 0x006C, 0x0120, 0x0001 },
> +	{   768000, 0x016C, 0x00C0, 0x0001 },
> +	{  1024000, 0x016C, 0x0090, 0x0001 },
> +	{  1536000, 0x016C, 0x0060, 0x0001 },
> +	{  2048000, 0x016C, 0x0090, 0x0002 },
> +	{  2304000, 0x016C, 0x0080, 0x0002 },
> +	{  3072000, 0x016C, 0x0090, 0x0003 },
> +	{  4096000, 0x016C, 0x0090, 0x0004 },
> +	{  4608000, 0x016C, 0x0080, 0x0004 },
> +	{  6144000, 0x016C, 0x0090, 0x0006 },
> +	{  8192000, 0x016C, 0x0090, 0x0008 },
> +	{  9216000, 0x016C, 0x0090, 0x0009 },
> +	{ 12288000, 0x016C, 0x0090, 0x000C },
> +	{ 16384000, 0x016C, 0x0090, 0x0010 },
> +	{ 18432000, 0x016C, 0x0090, 0x0012 },
> +	{ 24576000, 0x016C, 0x0090, 0x0018 },
> +	{  1411200, 0x016C, 0x0060, 0x0001 },
> +	{  2116800, 0x016C, 0x0080, 0x0002 },
> +	{  2822400, 0x016C, 0x0090, 0x0003 },
> +	{  4233600, 0x016C, 0x0080, 0x0004 },
> +	{  5644800, 0x016C, 0x0090, 0x0006 },
> +	{  8467200, 0x016C, 0x0090, 0x0009 },
> +	{ 11289600, 0x016C, 0x0090, 0x000C },
> +	{ 16934400, 0x016C, 0x0090, 0x0012 },
> +	{ 22579200, 0x016C, 0x0090, 0x0018 },
> +	{  2000000, 0x017C, 0x0093, 0x0002 },
> +};
> +
> +static int fs210x_bclk_set(struct fs210x_priv *fs210x, bool on)
> +{
> +	int ret = 0;
> +
> +	if (!fs210x || !fs210x->dev)
> +		return -EINVAL;
> +
> +	if (!fs210x->clk_bclk)
> +		return 0;
> +
> +	if ((fs210x->is_bclk_on ^ on) == 0)
> +		return 0;
> +
> +	dev_dbg(fs210x->dev, "bclk switch %s\n", on ? "on" : "off");
> +
> +	if (on) {
> +		clk_set_rate(fs210x->clk_bclk, fs210x->bclk);
> +		ret = clk_prepare_enable(fs210x->clk_bclk);
> +		fs210x->is_bclk_on = true;
> +		usleep_range(2000, 2050); /* >= 2ms */
> +	} else {
> +		clk_disable_unprepare(fs210x->clk_bclk);
> +		fs210x->is_bclk_on = false;
> +	}
> +
> +	return ret;
> +}
> +
> +static int fs210x_reg_write(struct fs210x_priv *fs210x,
> +			    u8 reg, u16 val)
> +{
> +	int ret;
> +
> +	ret = regmap_write(fs210x->regmap, reg, val);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to write %02Xh: %d\n", reg, ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(fs210x->dev, "RW: %02x %04x\n", reg, val);
> +
> +	return 0;
> +}

...

> +
> +static int fs210x_add_optional_controls(struct fs210x_priv *fs210x,
> +					struct snd_soc_component *cmpnt)
> +{
> +	int count;
> +
> +	if (!fs210x || !cmpnt)
> +		return -EINVAL;
> +
> +	/*
> +	 * If the firmware has no scene or only init scene,
> +	 * we skip adding this mixer control.
> +	 */
> +	if (fs210x->amp_lib.scene_count < 2)
> +		return 0;
> +
> +	count = ARRAY_SIZE(fs210x_scene_control);
> +
> +	return snd_soc_add_component_controls(cmpnt,
> +					      fs210x_scene_control,
> +					      count);
> +}
> +
> +static int fs210x_get_bclk(struct fs210x_priv *fs210x,
> +			   struct snd_soc_component *cmpnt)
> +{
> +	struct clk *bclk;
> +	int ret;
> +
> +	bclk = devm_clk_get(fs210x->dev, "bclk");
> +	if (IS_ERR_OR_NULL(bclk)) {
> +		ret = bclk ? PTR_ERR(bclk) : -ENODATA;

Same pattern as regulators, eh...

> +		if (ret == -EPROBE_DEFER)

No. Stop handling own probe deferrals. Look how other drivers do it.

> +			return ret;
> +		/*
> +		 * If the SOC doesn't have the bclk clock source,
> +		 * we skip setting the bclk clock.
> +		 */
> +		return 0;

What is the point of this entire code? You got NULL, so assign NULL. Can
clk API handle NULLs? Answer this to yourself and write obvious, simple
code.

> +	}
> +
> +	fs210x->clk_bclk = bclk;
> +	dev_dbg(fs210x->dev, "Got I2S bclk clock\n");

Drop. Really, your debugs here and further are meaningless. You debug
static, well know, things - DTB. No, debug unexpected pieces, not
something which is 100% predictable because DT schema told you this
already.

> +
> +	return 0;
> +}
> +
> +static int fs210x_probe(struct snd_soc_component *cmpnt)
> +{
> +	struct fs210x_priv *fs210x;
> +	int ret;
> +
> +	fs210x = snd_soc_component_get_drvdata(cmpnt);
> +	if (!fs210x || !fs210x->dev)
> +		return -EINVAL;
> +
> +	fs210x->amp_lib.dev   = fs210x->dev;
> +	fs210x->amp_lib.devid = fs210x->devid;
> +
> +	ret = fs_amp_load_firmware(&fs210x->amp_lib, fs210x->pdata.fwm_name);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to load firmware: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = fs210x_add_optional_controls(fs210x, cmpnt);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to add opt-ctrl: %d\n", ret);
> +		return ret;
> +	}
> +
> +	INIT_DELAYED_WORK(&fs210x->fault_check_work, fs210x_fault_check_work);
> +	INIT_DELAYED_WORK(&fs210x->start_work, fs210x_start_work);
> +
> +	fs210x_get_bclk(fs210x, cmpnt);
> +
> +	mutex_lock(&fs210x_mutex);
> +	ret = fs210x_init_chip(fs210x);
> +	mutex_unlock(&fs210x_mutex);
> +	if (ret)
> +		dev_err(fs210x->dev, "Failed to probe: %d\n", ret);

Oh wait, it is the FOURTH time you print same error message. Sorry, this
error handling is terrible. Obfuscated and overcomplicated. Error should
be printed only once. Look at other recent codecs.

> +
> +	return ret;
> +}
> +
> +static void fs210x_remove(struct snd_soc_component *cmpnt)
> +{
> +	struct fs210x_priv *fs210x;
> +
> +	fs210x = snd_soc_component_get_drvdata(cmpnt);
> +	if (!fs210x || !fs210x->dev)
> +		return;
> +
> +	cancel_delayed_work_sync(&fs210x->start_work);
> +	cancel_delayed_work_sync(&fs210x->fault_check_work);
> +
> +	dev_dbg(fs210x->dev, "Codec removed\n");

No, drop all such simple probe enter/exit debugs. This is really useless
debug.

> +}
> +
> +#ifdef CONFIG_PM
> +static int fs210x_suspend(struct snd_soc_component *cmpnt)
> +{
> +	struct fs210x_priv *fs210x;
> +	int ret;
> +
> +	fs210x = snd_soc_component_get_drvdata(cmpnt);
> +	if (!fs210x || !fs210x->dev)
> +		return -EINVAL;
> +
> +	cancel_delayed_work_sync(&fs210x->start_work);
> +	cancel_delayed_work_sync(&fs210x->fault_check_work);
> +
> +	mutex_lock(&fs210x_mutex);
> +	fs210x->cur_scene = NULL;
> +	fs210x->is_inited = false;
> +	fs210x->is_playing = false;
> +	fs210x->is_suspended = true;
> +
> +	fs210x_sdz_pin_set(fs210x, true);
> +	mutex_unlock(&fs210x_mutex);
> +
> +	ret = regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to suspend: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(fs210x->dev, "pm suspended\n");

No, drop all such simple probe enter/exit debugs.

> +
> +	return 0;
> +}
> +
> +static int fs210x_resume(struct snd_soc_component *cmpnt)
> +{
> +	struct fs210x_priv *fs210x;
> +	int ret;
> +
> +	fs210x = snd_soc_component_get_drvdata(cmpnt);
> +	if (!fs210x || !fs210x->dev)
> +		return -EINVAL;
> +
> +	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_lock(&fs210x_mutex);
> +	fs210x_sdz_pin_set(fs210x, false);
> +
> +	fs210x->is_suspended = false;
> +	ret = fs210x_init_chip(fs210x);
> +	mutex_unlock(&fs210x_mutex);
> +
> +	dev_info(fs210x->dev, "pm resumed\n");

No, drop.

> +
> +	return ret;
> +}
> +#else
> +#define fs210x_suspend NULL
> +#define fs210x_resume NULL
> +#endif // CONFIG_PM
> +
> +static const struct snd_soc_component_driver fs210x_soc_component_dev = {
> +	.probe			= fs210x_probe,
> +	.remove			= fs210x_remove,
> +	.suspend		= fs210x_suspend,
> +	.resume			= fs210x_resume,
> +	.controls		= fs210x_controls,
> +	.num_controls		= ARRAY_SIZE(fs210x_controls),
> +	.dapm_widgets		= fs210x_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(fs210x_dapm_widgets),
> +	.dapm_routes		= fs210x_dapm_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(fs210x_dapm_routes),
> +	.use_pmdown_time	= 1,
> +};
> +
> +static const struct regmap_config fs210x_regmap = {
> +	.reg_bits		= 8,
> +	.val_bits		= 16,
> +	.max_register		= FS210X_REG_MAX,
> +	.val_format_endian	= REGMAP_ENDIAN_BIG,
> +	.cache_type		= REGCACHE_NONE,
> +};
> +
> +static int fs210x_detect_device(struct fs210x_priv *fs210x)
> +{
> +	u16 devid;
> +	int ret;
> +
> +	ret = fs210x_reg_read(fs210x, FS210X_03H_DEVID, &devid);
> +	if (ret)
> +		return ret;
> +
> +	fs210x->devid = HI_U16(devid);
> +
> +	switch (fs210x->devid) {
> +	case FS210X_DEVICE_ID:
> +		dev_info(fs210x->dev, "FS2104 detected\n");
> +		break;
> +	case FS2105S_DEVICE_ID:
> +		dev_info(fs210x->dev, "FS2105S detected\n");
> +		break;
> +	default:
> +		dev_err(fs210x->dev, "DEVID: 0x%04X dismatch\n", devid);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fs210x_parse_dts(struct fs210x_priv *fs210x,
> +			    struct fs210x_platform_data *pdata)
> +{
> +	struct device_node *node = fs210x->dev->of_node;
> +	int i, ret;
> +
> +	if (!node)
> +		return 0;
> +
> +	ret = of_property_read_string(node, "firmware-name", &pdata->fwm_name);
> +	if (ret)
> +		pdata->fwm_name = FS210X_DEFAULT_FWM_NAME;
> +
> +	fs210x->gpio_sdz = devm_gpiod_get_optional(fs210x->dev,
> +						   "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR_OR_NULL(fs210x->gpio_sdz)) {
> +		ret = fs210x->gpio_sdz ? PTR_ERR(fs210x->gpio_sdz) : -ENODATA;


Weird dance. Why assigning to ret enodata?

> +		fs210x->gpio_sdz = NULL;
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		dev_dbg(fs210x->dev, "Assuming reset-gpios is unused\n");
> +	} else {
> +		dev_dbg(fs210x->dev, "reset-gpios: %d\n",
> +			desc_to_gpio(fs210x->gpio_sdz));
> +	}

This is over-complicated way of getting simple optional gpio.

> +
> +	for (i = 0; i < FS210X_NUM_SUPPLIES; i++)
> +		fs210x->supplies[i].supply = fs210x_supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(fs210x->dev,
> +				      ARRAY_SIZE(fs210x->supplies),
> +				      fs210x->supplies);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to get supplies: %d\n", ret);

Syntax is return dev_err_probe.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fs210x_parse_platdata(struct fs210x_priv *fs210x)

I do not understand why you have so many functions doing simple OF
parsing. fs210x_init, fs210x_parse_platdata, fs210x_parse_dts... and
this one here does nothing.

> +{
> +	struct fs210x_platform_data *pdata;
> +	int ret;
> +
> +	pdata = &fs210x->pdata;
> +	ret = fs210x_parse_dts(fs210x, pdata);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to parse dts: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fs210x_deinit(struct fs210x_priv *fs210x)
> +{
> +	fs210x_sdz_pin_set(fs210x, true);
> +	regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> +}
> +
> +static int fs210x_init(struct fs210x_priv *fs210x)
> +{
> +	int ret;
> +
> +	ret = fs210x_parse_platdata(fs210x);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to parse platdata: %d\n", ret);

So you print SAME ERROR three times?

> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> +	if (ret) {
> +		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Make sure the SDZ pin is pulled down enough time. */
> +	usleep_range(10000, 10050); /* >= 10ms */
> +	fs210x_sdz_pin_set(fs210x, false);
> +
> +	ret = fs210x_detect_device(fs210x);
> +	if (ret) {
> +		fs210x_deinit(fs210x);
> +		return ret;
> +	}
> +
> +	fs210x->scene_id     = -1; /* Invalid scene */
> +	fs210x->cur_scene    = NULL;
> +	fs210x->is_playing   = false;
> +	fs210x->is_inited    = false;
> +	fs210x->is_suspended = false;
> +	fs210x->vol[0]       = FS210X_VOLUME_MAX;
> +	fs210x->vol[1]       = FS210X_VOLUME_MAX;
> +
> +	return 0;
> +}
> +
> +static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
> +{
> +	struct snd_soc_dai_driver *dai_drv;
> +	int ret;
> +
> +	dai_drv = devm_kmemdup(fs210x->dev, &fs210x_dai,
> +			       sizeof(fs210x_dai), GFP_KERNEL);
> +	if (!dai_drv)
> +		return -ENOMEM;
> +
> +	if (fs210x->devid == FS2105S_DEVICE_ID) {
> +		dai_drv->playback.rates = FS2105S_RATES;
> +		dai_drv->capture.rates  = FS2105S_RATES;
> +	}
> +
> +	ret = snd_soc_register_component(fs210x->dev,
> +					 &fs210x_soc_component_dev,
> +					 dai_drv, 1);
> +	return ret;
> +}
> +
> +static int fs210x_i2c_probe(struct i2c_client *client)
> +{
> +	struct fs210x_priv *fs210x;
> +	int ret;
> +
> +	dev_info(&client->dev, "version: %s\n", FS210X_DRV_VERSION);
> +
> +	fs210x = devm_kzalloc(&client->dev, sizeof(*fs210x), GFP_KERNEL);
> +	if (!fs210x)
> +		return -ENOMEM;
> +
> +	fs210x->i2c = client;
> +	fs210x->dev = &client->dev;
> +	i2c_set_clientdata(client, fs210x);
> +
> +	fs210x->regmap = devm_regmap_init_i2c(client, &fs210x_regmap);
> +	if (IS_ERR_OR_NULL(fs210x->regmap)) {

Can devm_regmap_init_i2c() return NULL? No, it cannot.

> +		dev_err(fs210x->dev, "Failed to get regmap\n");
> +		ret = fs210x->regmap ? PTR_ERR(fs210x->regmap) : -ENODATA;

Syntax is return dev_err_probe and drop NULL check.

> +		return ret;
> +	}
> +
> +	mutex_lock(&fs210x_mutex);
> +	ret = fs210x_init(fs210x);
> +	mutex_unlock(&fs210x_mutex);

Why do you need to lock it? Who and how can access device at this point?

> +	if (ret)
> +		return ret;
> +
> +	ret = fs210x_register_snd_component(fs210x);
> +	if (ret) {
> +		fs210x_deinit(fs210x);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fs210x_i2c_remove(struct i2c_client *client)
> +{
> +	struct fs210x_priv *fs210x = i2c_get_clientdata(client);
> +
> +	snd_soc_unregister_component(fs210x->dev);
> +	fs210x_deinit(fs210x);
> +}
> +
> +static const struct i2c_device_id fs210x_i2c_id[] = {
> +	{ "fs2104" },
> +	{ "fs2105s" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, fs210x_i2c_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id fs210x_of_match[] = {
> +	{ .compatible = "foursemi,fs2104", },

I asked to express the fallback. Drop this, it is complete redundant.

> +	{ .compatible = "foursemi,fs2105s", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fs210x_of_match);
> +#endif // CONFIG_OF

All these ifdefs and of_match_ptr should be dropped, not really helpful.

Best regards,
Krzysztof


