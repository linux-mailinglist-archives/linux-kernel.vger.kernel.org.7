Return-Path: <linux-kernel+bounces-725229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705FAFFC32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5A75A6A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4D28C842;
	Thu, 10 Jul 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkfBLtfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F728C5A5;
	Thu, 10 Jul 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136042; cv=none; b=auy67qPoFcOTh56MkUvboE5POsc0wFvfMpGiROUL47pwr1s+Yw7EO2K1gSrON0Qx+G2DcGQiyiC1K66wUgndtR/Jjyn5vOFbA/WaXdC3ZR9xuKYlOwQvviypeORbfrLdX8yUFWjQDwiCq7WrXXYXeSc6eVZyazUk+6rxIyfQatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136042; c=relaxed/simple;
	bh=lDbXdTJtnBLNa9TlerZHDPGtzJXAiU72CYrFJ1PH7rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8dbYpQUcxMu3K1s+edjbwsQdBqsmSjqafiff4vjzWThO8SeVKnSYDTXLqEuhaBHcz9JIUmAxfCKEF3V+6xqTXtKx08U34cAmgc6kzrT0xbUERqfKxn4BAIMH8iQm6K82Uq0B+SPxwENpd75R1jf4K1AYcj4UTjmNzne4W5Uv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkfBLtfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C8C4CEE3;
	Thu, 10 Jul 2025 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752136042;
	bh=lDbXdTJtnBLNa9TlerZHDPGtzJXAiU72CYrFJ1PH7rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HkfBLtfJx5rbxGg3qLBwsTlipbbrB/gEZqO3zZ3TwoHPkZjRTg15Ct9zN5lbVHMUP
	 H9Xyhl/MO3kCQ2AW5AVapX9nBHZHnLLoKvLvNw0owrhDQ0Ic84IvyQawob33qpR7Wa
	 wCBAWTBjGvxRG0nz8AL+qiQMvNFcMKz9/2rW9pYgzMHRiJ1tLfNadS51U3LPtzVzBR
	 z1tdR5KjTlqvA/bQNeMMtg+y9vlhxFXhpvmpZ9vhRlOxAc+RU+3/SJQdSt5v70eEAz
	 dne2XWcaRdlu+CexWWQjKt5AmB3v9dE3AYxsNCrcJAViBQHP4/7rzOT8/fTykLtwXn
	 8roQDQyywipEw==
Message-ID: <142742f6-14a4-4a82-9197-7a4a02027b84@kernel.org>
Date: Thu, 10 Jul 2025 10:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
 xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, like.xy@foxmail.com,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-5-nick.li@foursemi.com>
 <20250709-elated-cat-of-variation-2d0bd1@krzk-bin>
 <DD9901EBC735C56D+aG9yEl9LItzYJVDB@foursemi.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <DD9901EBC735C56D+aG9yEl9LItzYJVDB@foursemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/2025 09:56, Nick Li wrote:
>>> +};
>>> +
>>> +static DEFINE_MUTEX(fs210x_mutex);
>>
>> Why is this file-scope? Why two independent codecs cannot work in parallel?
> 
> The driver module may be loaded asynchronously,
> if the reset pin/supplies are shared by the devices,
> we should protect the process of detecting devices.

No, that's not the job of this driver. Your driver must not protect from
imaginary resource conflicts, because it will not even solve it
properly. It is impossible. What if foo,AS9911 codec also shares these
pins supplies?

And supplies needs synchronization? About pins you got point, but here
clearly you are wrong.

So no, drop all this global mutex, move it to device state container and
DOCUMENT what it exactly protects (see checkpatch).


> We tend to have each device is configured in a continuous manner.

No. That's wrong assumption and wrong idea. We want the async.

> 
>>
>>> +
>>> +static const struct fs_pll_div fs210x_pll_div[] = {
>>> +	/*    bclk,   pll1,   pll2,   pll3 */
>>> +	{   512000, 0x006C, 0x0120, 0x0001 },
>>> +	{   768000, 0x016C, 0x00C0, 0x0001 },
>>> +	{  1024000, 0x016C, 0x0090, 0x0001 },
>>> +	{  1536000, 0x016C, 0x0060, 0x0001 },
>>> +	{  2048000, 0x016C, 0x0090, 0x0002 },
>>> +	{  2304000, 0x016C, 0x0080, 0x0002 },
>>> +	{  3072000, 0x016C, 0x0090, 0x0003 },
>>> +	{  4096000, 0x016C, 0x0090, 0x0004 },
>>> +	{  4608000, 0x016C, 0x0080, 0x0004 },
>>> +	{  6144000, 0x016C, 0x0090, 0x0006 },
>>> +	{  8192000, 0x016C, 0x0090, 0x0008 },
>>> +	{  9216000, 0x016C, 0x0090, 0x0009 },
>>> +	{ 12288000, 0x016C, 0x0090, 0x000C },
>>> +	{ 16384000, 0x016C, 0x0090, 0x0010 },
>>> +	{ 18432000, 0x016C, 0x0090, 0x0012 },
>>> +	{ 24576000, 0x016C, 0x0090, 0x0018 },
>>> +	{  1411200, 0x016C, 0x0060, 0x0001 },
>>> +	{  2116800, 0x016C, 0x0080, 0x0002 },
>>> +	{  2822400, 0x016C, 0x0090, 0x0003 },
>>> +	{  4233600, 0x016C, 0x0080, 0x0004 },
>>> +	{  5644800, 0x016C, 0x0090, 0x0006 },
>>> +	{  8467200, 0x016C, 0x0090, 0x0009 },
>>> +	{ 11289600, 0x016C, 0x0090, 0x000C },
>>> +	{ 16934400, 0x016C, 0x0090, 0x0012 },
>>> +	{ 22579200, 0x016C, 0x0090, 0x0018 },
>>> +	{  2000000, 0x017C, 0x0093, 0x0002 },
>>> +};
>>> +


...

>>> +
>>> +	/*
>>> +	 * If the firmware has no scene or only init scene,
>>> +	 * we skip adding this mixer control.
>>> +	 */
>>> +	if (fs210x->amp_lib.scene_count < 2)
>>> +		return 0;
>>> +
>>> +	count = ARRAY_SIZE(fs210x_scene_control);
>>> +
>>> +	return snd_soc_add_component_controls(cmpnt,
>>> +					      fs210x_scene_control,
>>> +					      count);
>>> +}
>>> +
>>> +static int fs210x_get_bclk(struct fs210x_priv *fs210x,
>>> +			   struct snd_soc_component *cmpnt)
>>> +{
>>> +	struct clk *bclk;
>>> +	int ret;
>>> +
>>> +	bclk = devm_clk_get(fs210x->dev, "bclk");
>>> +	if (IS_ERR_OR_NULL(bclk)) {
>>> +		ret = bclk ? PTR_ERR(bclk) : -ENODATA;
>>
>> Same pattern as regulators, eh...
> 
> Ok, we will update it.
> 
>>
>>> +		if (ret == -EPROBE_DEFER)
>>
>> No. Stop handling own probe deferrals. Look how other drivers do it.
> 
> Broonie recommanded to get clock in bus probe before,
> and we will call it in i2c probe,
> is it possible the clock isn't ready when we get it in bus probe?
> we found some drivers do the probe deferral after getting clock.

Look how others drivers do it. You should not handle it differently -
you always return. The core handles deferred probe.

> 
>>
>>> +			return ret;
>>> +		/*
>>> +		 * If the SOC doesn't have the bclk clock source,
>>> +		 * we skip setting the bclk clock.
>>> +		 */
>>> +		return 0;
>>
>> What is the point of this entire code? You got NULL, so assign NULL. Can
>> clk API handle NULLs? Answer this to yourself and write obvious, simple
>> code.
> 
> Before we calling clk API in fs210x_bclk_set, we check the clk_bclk is NULL or not firstly,

But it makes no sense. Clock core does it.

> In clk_set_rate/clk_prepare_enable/clk_disable_prepare, they will check it:
> if (!clk) or if (IS_ERR_OR_NULL(clk))

? What does it mean?

...

>>> +
>>> +static int fs210x_parse_dts(struct fs210x_priv *fs210x,
>>> +			    struct fs210x_platform_data *pdata)
>>> +{
>>> +	struct device_node *node = fs210x->dev->of_node;
>>> +	int i, ret;
>>> +
>>> +	if (!node)
>>> +		return 0;
>>> +
>>> +	ret = of_property_read_string(node, "firmware-name", &pdata->fwm_name);
>>> +	if (ret)
>>> +		pdata->fwm_name = FS210X_DEFAULT_FWM_NAME;
>>> +
>>> +	fs210x->gpio_sdz = devm_gpiod_get_optional(fs210x->dev,
>>> +						   "reset", GPIOD_OUT_HIGH);
>>> +	if (IS_ERR_OR_NULL(fs210x->gpio_sdz)) {
>>> +		ret = fs210x->gpio_sdz ? PTR_ERR(fs210x->gpio_sdz) : -ENODATA;
>>
>>
>> Weird dance. Why assigning to ret enodata?
> 
> If we get the gpio_sdz and it's NULL, we assume it's unused.
> If the error code is unbefitting, which one should we use?

No error code. You requested optional for a reason.

> 
>>
>>> +		fs210x->gpio_sdz = NULL;
>>> +		if (ret == -EPROBE_DEFER)
>>> +			return ret;
>>> +		dev_dbg(fs210x->dev, "Assuming reset-gpios is unused\n");
>>> +	} else {
>>> +		dev_dbg(fs210x->dev, "reset-gpios: %d\n",
>>> +			desc_to_gpio(fs210x->gpio_sdz));
>>> +	}
>>
>> This is over-complicated way of getting simple optional gpio.
> 
> We want to cover the following possibilities:
> 1. The reset gpio is unused

And simple optional call is all you need.

> 2. The reset pin is shared by multiple deivces

You cannot. They cannot be shared, try by yourself. It is not a
supported setup.

You can switch to reset gpio driver, see my slides from last year OSSNA.

> 3. The reset pins are independent

I don't understand that.

> 4. The gpio pin is unready

There is no such thing.

The only thing you need to do is devm_gpiod_get_optional(), if IS_ERR()
return dev_err_probe.

ONLY.

For shared GPIOs, you cannot use it at all, see reset gpios driver
usecases in some Qcom WSA codecs.

> 
>>
>>> +
>>> +	for (i = 0; i < FS210X_NUM_SUPPLIES; i++)
>>> +		fs210x->supplies[i].supply = fs210x_supply_names[i];
>>> +
>>> +	ret = devm_regulator_bulk_get(fs210x->dev,
>>> +				      ARRAY_SIZE(fs210x->supplies),
>>> +				      fs210x->supplies);
>>> +	if (ret) {
>>> +		dev_err(fs210x->dev, "Failed to get supplies: %d\n", ret);
>>
>> Syntax is return dev_err_probe.
> 
> We can port the driver into older kernel easily without dev_err_probe,

But we don't want that. We work only on upstream.

> the older kernel may not have this API.

No, we must not accept poor code because you have customer who wants to
work on obsolete and buggy and vulnerable kernel.

> If it is recommended, we will update it.

It is really, really a strong requirement. Actually, it is beneficial
that it won't be possible to port to ancient kernels, because you won't
be tempted to use some 10 year old patterns in other places.

> 
>>
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int fs210x_parse_platdata(struct fs210x_priv *fs210x)
>>
>> I do not understand why you have so many functions doing simple OF
>> parsing. fs210x_init, fs210x_parse_platdata, fs210x_parse_dts... and
>> this one here does nothing.
> 
> We parsed the acpi table in parse_platdata before v1,
> but we didn't have the environment to check, then we removed the code.
> If it's possible, we will add it in the future.
> Also we tend to implment the functions shortly to reduce the complexity.
> 
>>
>>> +{
>>> +	struct fs210x_platform_data *pdata;
>>> +	int ret;
>>> +
>>> +	pdata = &fs210x->pdata;
>>> +	ret = fs210x_parse_dts(fs210x, pdata);
>>> +	if (ret) {
>>> +		dev_err(fs210x->dev, "Failed to parse dts: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void fs210x_deinit(struct fs210x_priv *fs210x)
>>> +{
>>> +	fs210x_sdz_pin_set(fs210x, true);
>>> +	regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
>>> +}
>>> +
>>> +static int fs210x_init(struct fs210x_priv *fs210x)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = fs210x_parse_platdata(fs210x);
>>> +	if (ret) {
>>> +		dev_err(fs210x->dev, "Failed to parse platdata: %d\n", ret);
>>
>> So you print SAME ERROR three times?
> 
> We will check and reduce the logs when the api has logs.
> 
>>
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
>>> +	if (ret) {
>>> +		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	/* Make sure the SDZ pin is pulled down enough time. */
>>> +	usleep_range(10000, 10050); /* >= 10ms */
>>> +	fs210x_sdz_pin_set(fs210x, false);
>>> +
>>> +	ret = fs210x_detect_device(fs210x);
>>> +	if (ret) {
>>> +		fs210x_deinit(fs210x);
>>> +		return ret;
>>> +	}
>>> +
>>> +	fs210x->scene_id     = -1; /* Invalid scene */
>>> +	fs210x->cur_scene    = NULL;
>>> +	fs210x->is_playing   = false;
>>> +	fs210x->is_inited    = false;
>>> +	fs210x->is_suspended = false;
>>> +	fs210x->vol[0]       = FS210X_VOLUME_MAX;
>>> +	fs210x->vol[1]       = FS210X_VOLUME_MAX;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
>>> +{
>>> +	struct snd_soc_dai_driver *dai_drv;
>>> +	int ret;
>>> +
>>> +	dai_drv = devm_kmemdup(fs210x->dev, &fs210x_dai,
>>> +			       sizeof(fs210x_dai), GFP_KERNEL);
>>> +	if (!dai_drv)
>>> +		return -ENOMEM;
>>> +
>>> +	if (fs210x->devid == FS2105S_DEVICE_ID) {
>>> +		dai_drv->playback.rates = FS2105S_RATES;
>>> +		dai_drv->capture.rates  = FS2105S_RATES;
>>> +	}
>>> +
>>> +	ret = snd_soc_register_component(fs210x->dev,
>>> +					 &fs210x_soc_component_dev,
>>> +					 dai_drv, 1);
>>> +	return ret;
>>> +}
>>> +
>>> +static int fs210x_i2c_probe(struct i2c_client *client)
>>> +{
>>> +	struct fs210x_priv *fs210x;
>>> +	int ret;
>>> +
>>> +	dev_info(&client->dev, "version: %s\n", FS210X_DRV_VERSION);
>>> +
>>> +	fs210x = devm_kzalloc(&client->dev, sizeof(*fs210x), GFP_KERNEL);
>>> +	if (!fs210x)
>>> +		return -ENOMEM;
>>> +
>>> +	fs210x->i2c = client;
>>> +	fs210x->dev = &client->dev;
>>> +	i2c_set_clientdata(client, fs210x);
>>> +
>>> +	fs210x->regmap = devm_regmap_init_i2c(client, &fs210x_regmap);
>>> +	if (IS_ERR_OR_NULL(fs210x->regmap)) {
>>
>> Can devm_regmap_init_i2c() return NULL? No, it cannot.
> 
> OK, we will remove the judgment of NULL pointor
> 
>>
>>> +		dev_err(fs210x->dev, "Failed to get regmap\n");
>>> +		ret = fs210x->regmap ? PTR_ERR(fs210x->regmap) : -ENODATA;
>>
>> Syntax is return dev_err_probe and drop NULL check.
> 
> Refer to the reply in regulator get.
> 
>>
>>> +		return ret;
>>> +	}
>>> +
>>> +	mutex_lock(&fs210x_mutex);
>>> +	ret = fs210x_init(fs210x);
>>> +	mutex_unlock(&fs210x_mutex);
>>
>> Why do you need to lock it? Who and how can access device at this point?
> 
> If the system has more than 1 devices:
> the module may be loaded asynchronously, if the gpio/supplies are shared,

What? No. It's just cannot happen. Core handles it.

> it's better to protect the detection with lock?

You protected here nothing.
1. Concurrent SHARED GPIO reset: you replaced concurrent into
step-by-step-breaking-your-device-because-other-just-probed-and-reset-you
2. supplies: core handles it.

Do you see such needs anywhere in other recent codecs who share pins? I
understand it might be tricky to find it... but trust me, there is no
except legacy poor choices...

Best regards,
Krzysztof

