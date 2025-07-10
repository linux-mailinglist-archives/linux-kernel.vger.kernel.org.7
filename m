Return-Path: <linux-kernel+bounces-725536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437EB00070
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AE35A1D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21892E541E;
	Thu, 10 Jul 2025 11:21:23 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CFA2951D3;
	Thu, 10 Jul 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146483; cv=none; b=JwvPPyn37I6GT6LAdj8B93vN4w5g6VgZ7IzmrOouXx2V/lOyWCPaY+hYohzgEDMTAT91bRtIhNwJdLbwvGdO8OsycEBSq0P2n5ju2yw2uf/vLHpXv0NSHNANVnkjNxaqSlhqKl3hGcebdQnrrNNBreYlj9RFIRMe/1uVCx5jAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146483; c=relaxed/simple;
	bh=b9FivpI1UGCg9Rmq77/Nsdn33Ko8LIsYCvikZSBCy5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKkqNwWbfTo3RclVwxjCytyuAdaALVv+ckGIuzoqDjqWacG++JydCcwXx8ZT7C3qIUNjmr3HzXv6wrFDIPOFThsfPD20MHwCT/7us7LgxR/zb9h+HpED2w27Rm+QTCzcb/xwrFTErnC3za/zZRexGzWD/ge+0KERXZAmwMc7zSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpsz20t1752146437t84630f89
X-QQ-Originating-IP: GkDp17EAXMk4h+M1iVkVMkM0FrkYYXQHAiVyItn9/QM=
Received: from localhost ( [183.17.231.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 19:20:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14652591898918451816
EX-QQ-RecipientCnt: 14
Date: Thu, 10 Jul 2025 19:20:35 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <C772CBD8D1BD5ED2+aG-iAyDd9qj8Di3g@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
 <20250709-elated-cat-of-variation-2d0bd1@krzk-bin>
 <DD9901EBC735C56D+aG9yEl9LItzYJVDB@foursemi.com>
 <142742f6-14a4-4a82-9197-7a4a02027b84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <142742f6-14a4-4a82-9197-7a4a02027b84@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MSYKsNRlZrmM5ufJI9O2qwf37CCkcaAGIksie6w6hIR/6bU2X0wtnMM4
	+Uj9JI3S7/Ia63uWQZClHyTvLkxBpTTs9eLWHMacRi9158N7ZtLHeUSDh+lc9Ey8iVKd4ld
	cgQx91BQAsjTOCBZO1rPUMACL9PQ8uB48V5fSPN63dJk72P6i9hK/TtCJs65rqjWnxucjMU
	WsBygPjxveqxvj/hVDuwNwpDSzaNZUtNMrkUsPEo5hsxu1xbZ94PDP7hEQ/FxUk2l502LE7
	7ZByYxCXBsj3mWQwNLRhUlMfabbsxHIv4bI+l3USG4puPPhM1Q/SY1ZjDC+KQLdmrVH454Z
	qekKnu13hD3OTTgELuvtq1AZWpFa94PncUO9IYl62MLKZLgA4BP8cQpHd8X7rA0oAWw0Bbt
	LrlzS8yYNJFA6LSMItsC5Xj4bI+7yXppbkt+X78gSvWAWDgmaRrMgqgI8gwy47nivSrOh3+
	UeINPUGSXP1d+dZaIOtMbcbX+AaGJuU1ZhJHz+cXKkUarZyGOr7V8TtSYHwXK8vbFMjsMzo
	5QeCOuOOzLM9QJqevNaX30paROHD7NHpI/qsXVCBGYS+IGozo1VmxIuP3lRRHqVlUsaIA4J
	Rrbwo3goR9qJrrJYY70beJHBS/NSiJyf629O8UJa5TcHGEMuAzkCz6BzznzYwrjh+eo/5IR
	7ALV6Zr9epWhYBRSSavsDbB6pieFGvFNKdFoQ5GsszGP7fksL+ZBR7z61Rc4NixDoBAQZNe
	WnOKFKtRleLdqdrgPzTZZViJrRHMjzJeCuJu3RfZ/b7Z/RCCvMhEE8w3tdR5VVOQty2X0bO
	79q0nDQPk5mJD6ozGnfzt5EuTUjQNoxx1aHUfzQbFdhQGQk+3gw7FrAKHJpoLZ6vjTCl9zw
	Gx7kbxTUIxuKDGyxPoyoMY7rv+wbdeV3M79L7fwwBDqWYPYAGcWlthcoFQjEF2RYBibkaKG
	Az1EpZY8UnXeAXWAAIyV/gsKBjqUNZGw6PiOVr1gfguHR92XzYZPfJ5dn6iSl+m8Dm9MGSr
	d+1jHJpbM9GYw0ha4gPl4/x2jTvksvIx4qqiTpgl32dnNYHPun
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On Thu, Jul 10, 2025 at 10:27:15AM +0200, Krzysztof Kozlowski wrote:
> On 10/07/2025 09:56, Nick Li wrote:
> >>> +};
> >>> +
> >>> +static DEFINE_MUTEX(fs210x_mutex);
> >>
> >> Why is this file-scope? Why two independent codecs cannot work in parallel?
> > 
> > The driver module may be loaded asynchronously,
> > if the reset pin/supplies are shared by the devices,
> > we should protect the process of detecting devices.
> 
> No, that's not the job of this driver. Your driver must not protect from
> imaginary resource conflicts, because it will not even solve it
> properly. It is impossible. What if foo,AS9911 codec also shares these
> pins supplies?
> 
> And supplies needs synchronization? About pins you got point, but here
> clearly you are wrong.
> 
> So no, drop all this global mutex, move it to device state container and
> DOCUMENT what it exactly protects (see checkpatch).

OK, we will use a private lock for mutual exclusion with work queues/mixers/...

> 
> 
> > We tend to have each device is configured in a continuous manner.
> 
> No. That's wrong assumption and wrong idea. We want the async.

OK.

> 
> > 
> >>
> >>> +
> >>> +static const struct fs_pll_div fs210x_pll_div[] = {
> >>> +	/*    bclk,   pll1,   pll2,   pll3 */
> >>> +	{   512000, 0x006C, 0x0120, 0x0001 },
> >>> +	{   768000, 0x016C, 0x00C0, 0x0001 },
> >>> +	{  1024000, 0x016C, 0x0090, 0x0001 },
> >>> +	{  1536000, 0x016C, 0x0060, 0x0001 },
> >>> +	{  2048000, 0x016C, 0x0090, 0x0002 },
> >>> +	{  2304000, 0x016C, 0x0080, 0x0002 },
> >>> +	{  3072000, 0x016C, 0x0090, 0x0003 },
> >>> +	{  4096000, 0x016C, 0x0090, 0x0004 },
> >>> +	{  4608000, 0x016C, 0x0080, 0x0004 },
> >>> +	{  6144000, 0x016C, 0x0090, 0x0006 },
> >>> +	{  8192000, 0x016C, 0x0090, 0x0008 },
> >>> +	{  9216000, 0x016C, 0x0090, 0x0009 },
> >>> +	{ 12288000, 0x016C, 0x0090, 0x000C },
> >>> +	{ 16384000, 0x016C, 0x0090, 0x0010 },
> >>> +	{ 18432000, 0x016C, 0x0090, 0x0012 },
> >>> +	{ 24576000, 0x016C, 0x0090, 0x0018 },
> >>> +	{  1411200, 0x016C, 0x0060, 0x0001 },
> >>> +	{  2116800, 0x016C, 0x0080, 0x0002 },
> >>> +	{  2822400, 0x016C, 0x0090, 0x0003 },
> >>> +	{  4233600, 0x016C, 0x0080, 0x0004 },
> >>> +	{  5644800, 0x016C, 0x0090, 0x0006 },
> >>> +	{  8467200, 0x016C, 0x0090, 0x0009 },
> >>> +	{ 11289600, 0x016C, 0x0090, 0x000C },
> >>> +	{ 16934400, 0x016C, 0x0090, 0x0012 },
> >>> +	{ 22579200, 0x016C, 0x0090, 0x0018 },
> >>> +	{  2000000, 0x017C, 0x0093, 0x0002 },
> >>> +};
> >>> +
> 
> 
> ...
> 
> >>> +
> >>> +	/*
> >>> +	 * If the firmware has no scene or only init scene,
> >>> +	 * we skip adding this mixer control.
> >>> +	 */
> >>> +	if (fs210x->amp_lib.scene_count < 2)
> >>> +		return 0;
> >>> +
> >>> +	count = ARRAY_SIZE(fs210x_scene_control);
> >>> +
> >>> +	return snd_soc_add_component_controls(cmpnt,
> >>> +					      fs210x_scene_control,
> >>> +					      count);
> >>> +}
> >>> +
> >>> +static int fs210x_get_bclk(struct fs210x_priv *fs210x,
> >>> +			   struct snd_soc_component *cmpnt)
> >>> +{
> >>> +	struct clk *bclk;
> >>> +	int ret;
> >>> +
> >>> +	bclk = devm_clk_get(fs210x->dev, "bclk");
> >>> +	if (IS_ERR_OR_NULL(bclk)) {
> >>> +		ret = bclk ? PTR_ERR(bclk) : -ENODATA;
> >>
> >> Same pattern as regulators, eh...
> > 
> > Ok, we will update it.
> > 
> >>
> >>> +		if (ret == -EPROBE_DEFER)
> >>
> >> No. Stop handling own probe deferrals. Look how other drivers do it.
> > 
> > Broonie recommanded to get clock in bus probe before,
> > and we will call it in i2c probe,
> > is it possible the clock isn't ready when we get it in bus probe?
> > we found some drivers do the probe deferral after getting clock.
> 
> Look how others drivers do it. You should not handle it differently -
> you always return. The core handles deferred probe.

OK, the core will handle it, we don't need to do. 

> 
> > 
> >>
> >>> +			return ret;
> >>> +		/*
> >>> +		 * If the SOC doesn't have the bclk clock source,
> >>> +		 * we skip setting the bclk clock.
> >>> +		 */
> >>> +		return 0;
> >>
> >> What is the point of this entire code? You got NULL, so assign NULL. Can
> >> clk API handle NULLs? Answer this to yourself and write obvious, simple
> >> code.
> > 
> > Before we calling clk API in fs210x_bclk_set, we check the clk_bclk is NULL or not firstly,
> 
> But it makes no sense. Clock core does it.
> 
> > In clk_set_rate/clk_prepare_enable/clk_disable_prepare, they will check it:
> > if (!clk) or if (IS_ERR_OR_NULL(clk))
> 
> ? What does it mean?

Uh, I got it.
The clock core does the checking.

> 
> ...
> 
> >>> +
> >>> +static int fs210x_parse_dts(struct fs210x_priv *fs210x,
> >>> +			    struct fs210x_platform_data *pdata)
> >>> +{
> >>> +	struct device_node *node = fs210x->dev->of_node;
> >>> +	int i, ret;
> >>> +
> >>> +	if (!node)
> >>> +		return 0;
> >>> +
> >>> +	ret = of_property_read_string(node, "firmware-name", &pdata->fwm_name);
> >>> +	if (ret)
> >>> +		pdata->fwm_name = FS210X_DEFAULT_FWM_NAME;
> >>> +
> >>> +	fs210x->gpio_sdz = devm_gpiod_get_optional(fs210x->dev,
> >>> +						   "reset", GPIOD_OUT_HIGH);
> >>> +	if (IS_ERR_OR_NULL(fs210x->gpio_sdz)) {
> >>> +		ret = fs210x->gpio_sdz ? PTR_ERR(fs210x->gpio_sdz) : -ENODATA;
> >>
> >>
> >> Weird dance. Why assigning to ret enodata?
> > 
> > If we get the gpio_sdz and it's NULL, we assume it's unused.
> > If the error code is unbefitting, which one should we use?
> 
> No error code. You requested optional for a reason.

OK, just assign the PTR_ERR(xxx) to ret

> 
> > 
> >>
> >>> +		fs210x->gpio_sdz = NULL;
> >>> +		if (ret == -EPROBE_DEFER)
> >>> +			return ret;
> >>> +		dev_dbg(fs210x->dev, "Assuming reset-gpios is unused\n");
> >>> +	} else {
> >>> +		dev_dbg(fs210x->dev, "reset-gpios: %d\n",
> >>> +			desc_to_gpio(fs210x->gpio_sdz));
> >>> +	}
> >>
> >> This is over-complicated way of getting simple optional gpio.
> > 
> > We want to cover the following possibilities:
> > 1. The reset gpio is unused
> 
> And simple optional call is all you need.

OK.

> 
> > 2. The reset pin is shared by multiple deivces
> 
> You cannot. They cannot be shared, try by yourself. It is not a
> supported setup.

It will report -EBUSY when we request the same gpio.

> 
> You can switch to reset gpio driver, see my slides from last year OSSNA.

OK, I have the honour to read it.

> 
> > 3. The reset pins are independent
> 
> I don't understand that.

Each device has its own reset pin, it's a general case.

> 
> > 4. The gpio pin is unready
> 
> There is no such thing.

OK.

> 
> The only thing you need to do is devm_gpiod_get_optional(), if IS_ERR()
> return dev_err_probe.
> 
> ONLY.

OK.

> 
> For shared GPIOs, you cannot use it at all, see reset gpios driver
> usecases in some Qcom WSA codecs.

OK, I have found the driver and will learn about it later.

> 
> > 
> >>
> >>> +
> >>> +	for (i = 0; i < FS210X_NUM_SUPPLIES; i++)
> >>> +		fs210x->supplies[i].supply = fs210x_supply_names[i];
> >>> +
> >>> +	ret = devm_regulator_bulk_get(fs210x->dev,
> >>> +				      ARRAY_SIZE(fs210x->supplies),
> >>> +				      fs210x->supplies);
> >>> +	if (ret) {
> >>> +		dev_err(fs210x->dev, "Failed to get supplies: %d\n", ret);
> >>
> >> Syntax is return dev_err_probe.
> > 
> > We can port the driver into older kernel easily without dev_err_probe,
> 
> But we don't want that. We work only on upstream.

OK.

> 
> > the older kernel may not have this API.
> 
> No, we must not accept poor code because you have customer who wants to
> work on obsolete and buggy and vulnerable kernel.

OK.

> 
> > If it is recommended, we will update it.
> 
> It is really, really a strong requirement. Actually, it is beneficial
> that it won't be possible to port to ancient kernels, because you won't
> be tempted to use some 10 year old patterns in other places.

OK.

> 
> > 
> >>
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int fs210x_parse_platdata(struct fs210x_priv *fs210x)
> >>
> >> I do not understand why you have so many functions doing simple OF
> >> parsing. fs210x_init, fs210x_parse_platdata, fs210x_parse_dts... and
> >> this one here does nothing.
> > 
> > We parsed the acpi table in parse_platdata before v1,
> > but we didn't have the environment to check, then we removed the code.
> > If it's possible, we will add it in the future.
> > Also we tend to implment the functions shortly to reduce the complexity.
> > 
> >>
> >>> +{
> >>> +	struct fs210x_platform_data *pdata;
> >>> +	int ret;
> >>> +
> >>> +	pdata = &fs210x->pdata;
> >>> +	ret = fs210x_parse_dts(fs210x, pdata);
> >>> +	if (ret) {
> >>> +		dev_err(fs210x->dev, "Failed to parse dts: %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void fs210x_deinit(struct fs210x_priv *fs210x)
> >>> +{
> >>> +	fs210x_sdz_pin_set(fs210x, true);
> >>> +	regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> >>> +}
> >>> +
> >>> +static int fs210x_init(struct fs210x_priv *fs210x)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = fs210x_parse_platdata(fs210x);
> >>> +	if (ret) {
> >>> +		dev_err(fs210x->dev, "Failed to parse platdata: %d\n", ret);
> >>
> >> So you print SAME ERROR three times?
> > 
> > We will check and reduce the logs when the api has logs.
> > 
> >>
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
> >>> +	if (ret) {
> >>> +		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	/* Make sure the SDZ pin is pulled down enough time. */
> >>> +	usleep_range(10000, 10050); /* >= 10ms */
> >>> +	fs210x_sdz_pin_set(fs210x, false);
> >>> +
> >>> +	ret = fs210x_detect_device(fs210x);
> >>> +	if (ret) {
> >>> +		fs210x_deinit(fs210x);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	fs210x->scene_id     = -1; /* Invalid scene */
> >>> +	fs210x->cur_scene    = NULL;
> >>> +	fs210x->is_playing   = false;
> >>> +	fs210x->is_inited    = false;
> >>> +	fs210x->is_suspended = false;
> >>> +	fs210x->vol[0]       = FS210X_VOLUME_MAX;
> >>> +	fs210x->vol[1]       = FS210X_VOLUME_MAX;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
> >>> +{
> >>> +	struct snd_soc_dai_driver *dai_drv;
> >>> +	int ret;
> >>> +
> >>> +	dai_drv = devm_kmemdup(fs210x->dev, &fs210x_dai,
> >>> +			       sizeof(fs210x_dai), GFP_KERNEL);
> >>> +	if (!dai_drv)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	if (fs210x->devid == FS2105S_DEVICE_ID) {
> >>> +		dai_drv->playback.rates = FS2105S_RATES;
> >>> +		dai_drv->capture.rates  = FS2105S_RATES;
> >>> +	}
> >>> +
> >>> +	ret = snd_soc_register_component(fs210x->dev,
> >>> +					 &fs210x_soc_component_dev,
> >>> +					 dai_drv, 1);
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +static int fs210x_i2c_probe(struct i2c_client *client)
> >>> +{
> >>> +	struct fs210x_priv *fs210x;
> >>> +	int ret;
> >>> +
> >>> +	dev_info(&client->dev, "version: %s\n", FS210X_DRV_VERSION);
> >>> +
> >>> +	fs210x = devm_kzalloc(&client->dev, sizeof(*fs210x), GFP_KERNEL);
> >>> +	if (!fs210x)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	fs210x->i2c = client;
> >>> +	fs210x->dev = &client->dev;
> >>> +	i2c_set_clientdata(client, fs210x);
> >>> +
> >>> +	fs210x->regmap = devm_regmap_init_i2c(client, &fs210x_regmap);
> >>> +	if (IS_ERR_OR_NULL(fs210x->regmap)) {
> >>
> >> Can devm_regmap_init_i2c() return NULL? No, it cannot.
> > 
> > OK, we will remove the judgment of NULL pointor
> > 
> >>
> >>> +		dev_err(fs210x->dev, "Failed to get regmap\n");
> >>> +		ret = fs210x->regmap ? PTR_ERR(fs210x->regmap) : -ENODATA;
> >>
> >> Syntax is return dev_err_probe and drop NULL check.
> > 
> > Refer to the reply in regulator get.
> > 
> >>
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	mutex_lock(&fs210x_mutex);
> >>> +	ret = fs210x_init(fs210x);
> >>> +	mutex_unlock(&fs210x_mutex);
> >>
> >> Why do you need to lock it? Who and how can access device at this point?
> > 
> > If the system has more than 1 devices:
> > the module may be loaded asynchronously, if the gpio/supplies are shared,
> 
> What? No. It's just cannot happen. Core handles it.

OK.

> 
> > it's better to protect the detection with lock?
> 
> You protected here nothing.
> 1. Concurrent SHARED GPIO reset: you replaced concurrent into
> step-by-step-breaking-your-device-because-other-just-probed-and-reset-you
> 2. supplies: core handles it.
> 
> Do you see such needs anywhere in other recent codecs who share pins? I
> understand it might be tricky to find it... but trust me, there is no
> except legacy poor choices...

Hardware engineer wants all the reset(or irq) pins are shared,
they explain the soc has not enough gpio pins to be used,
especially when we use 4~8 audio amplifiers in a system,
if we use the separate reset & interrupt pins, they're too much pins.

We try to drop the related logic of shared pins.

Thank you very much.

Best regards,
Nick

> 
> Best regards,
> Krzysztof
> 

