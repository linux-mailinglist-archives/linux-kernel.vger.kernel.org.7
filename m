Return-Path: <linux-kernel+bounces-891501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D3C42CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 13:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BD73AEF17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249DF2727FC;
	Sat,  8 Nov 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmHlUETd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DA1AB6F1;
	Sat,  8 Nov 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762604520; cv=none; b=i0ilC89Y+mA+svpqls/P8V4/H6CiYu2+2Phjq++eV7xWghAhl52atNirHsMnbAnIkrfAkaBqu593MMUVzzPGVymtJ9NR+YPTGHXDhRDjVIS0YduIzwAxxgkE+XTtd7wCTEbjXEWkbGvLC7XAEXTugkpl6wzeKxj6VQcCSddc4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762604520; c=relaxed/simple;
	bh=aRkrwHVAt4LiXOdamNP4if92d1A4vzcDb7Oq05C4vrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVKVihXTYwJxQFx72U2NjbA9RGHqkBTPDOA9A+cT0nM76wMDFqqmM+OwwbmgWVD1tfbs91o6zaQ/qmH1b6c+/+vihxvrbzFlz2ZXVzDxy5+B36sSZ8nJcHBw/J1ZPrsrjweao9pZGcyTVg5UncqbRxSAXyQh3wiDPjjjIP2rgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmHlUETd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0AC4CEF5;
	Sat,  8 Nov 2025 12:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762604519;
	bh=aRkrwHVAt4LiXOdamNP4if92d1A4vzcDb7Oq05C4vrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmHlUETdAeugNDvV7MQsAk5jdwMTQWy0nQfc6BPOokaU9ARhOljuMIVwReNwqrxNO
	 l6hJsAgFmznkB8yBqSZWbUiJSVjHD10Cjotd5rdi1sH3x7knpSR8MDIItVF+1r3ceV
	 pdNGsc3JXn0rjyYF975OE8c/XOU2A2PooORcHXomzVzRRbdw+VOmjD0MDTkhgYSl3D
	 CCNCwjI8VuYaliVHBDT9sEKwcXn8jSAGOur9ilLuOKk4JfrUMbbJilnpL34hiMh2b2
	 4kk6EaTVC6m0Gox+OPZskdrgMSmPYB+oIMqtDd51eRZWsDctPyAd5vXV3rgvLpdYuK
	 pLapu5OD/hRNQ==
Date: Sat, 8 Nov 2025 13:21:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: Add FP9931/JD9930 driver
Message-ID: <20251108-nebulous-cheetah-of-prowess-964be6@kuoka>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
 <20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-fp9931-submit-v1-3-aa7b79d9abb6@kemnade.info>

On Fri, Nov 07, 2025 at 09:06:46PM +0100, Andreas Kemnade wrote:
> +
> +static int fp9931_probe(struct i2c_client *client)
> +{
> +	struct fp9931_data *data;
> +	struct regulator_config config = { };
> +	struct regulator_dev *rdev;
> +	int ret = 0;
> +	int i;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct fp9931_data), GFP_KERNEL);

sizeof(*)

> +	data->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "failed to allocate regmap!\n");
> +
> +	data->vin_reg = devm_regulator_get_optional(&client->dev, "vin");
> +	if (IS_ERR(data->vin_reg))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vin_reg),
> +				     "failid to get vin regulator\n");
> +
> +	data->pgood_gpio = devm_gpiod_get(&client->dev, "pg",
> +					  GPIOD_IN);

Please wrap at 80, not 60. See Linux coding style.

> +	if (IS_ERR(data->pgood_gpio))
> +		return dev_err_probe(&client->dev,
> +				     PTR_ERR(data->pgood_gpio),
> +				     "failed to get power good gpio\n");
> +
> +	data->pgood_irq = gpiod_to_irq(data->pgood_gpio);
> +	if (data->pgood_irq < 0)
> +		return data->pgood_irq;
> +
> +	data->en_gpio = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->en_gpio))
> +		return dev_err_probe(&client->dev,
> +				     PTR_ERR(data->en_gpio),

No need to break line.

> +				     "failed to get en gpio\n");
> +
> +	data->ts_en_gpio = devm_gpiod_get_optional(&client->dev, "ts-en", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->ts_en_gpio))
> +		return dev_err_probe(&client->dev,
> +				     PTR_ERR(data->ts_en_gpio),
> +				     "failed to get en gpio\n");
> +
> +	data->dev = &client->dev;
> +	i2c_set_clientdata(client, data);
> +
> +	init_completion(&data->pgood_completion);
> +
> +	ret = devm_request_threaded_irq(&client->dev, data->pgood_irq, NULL,
> +					pgood_handler,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"PGOOD", data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to request irq\n");
> +
> +	if (IS_ENABLED(CONFIG_PM)) {
> +		devm_pm_runtime_enable(&client->dev);
> +		pm_runtime_set_autosuspend_delay(&client->dev, 4000);
> +		pm_runtime_use_autosuspend(&client->dev);
> +	} else {
> +		ret = fp9931_runtime_resume(&client->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		devm_add_action_or_reset(&client->dev, disable_nopm, data);
> +	}
> +
> +	ret = setup_timings(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "failed to setup timings\n");
> +
> +	config.driver_data = data;
> +	config.dev = &client->dev;
> +	config.regmap = data->regmap;
> +
> +	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
> +		rdev = devm_regulator_register(&client->dev,
> +					       &regulators[i],
> +					       &config);

Please wrap according to Linux coding style.

> +		if (IS_ERR(rdev))
> +			return dev_err_probe(&client->dev, PTR_ERR(rdev),
> +					     "failed to register %s regulator\n",
> +					     regulators[i].name);
> +	}
> +
> +	if (IS_REACHABLE(CONFIG_HWMON)) {
> +		struct device *hwmon_dev;
> +
> +		hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, "fp9931", data,
> +								 &fp9931_chip_info, NULL);

So you use hwmon, then why binding said this is a thermal zone sensor?

> +		if (IS_ERR(hwmon_dev))
> +			dev_err(&client->dev, "failed to register hwmon\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops fp9931_pm_ops = {
> +	SET_RUNTIME_PM_OPS(fp9931_runtime_suspend, fp9931_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id fp9931_dt_ids[] = {
> +	{
> +		.compatible = "fiti,fp9931",
> +	}, {
> +		.compatible = "fiti,fp9931", /* no night mode */

Drop, it's the same compatible.

> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, fp9931_dt_ids);
> +
> +static struct i2c_driver fp9931_i2c_driver = {
> +	.driver = {
> +		   .name = "fp9931",
> +		   .owner = THIS_MODULE,

Please do not send us 12 year old code... Drop and runstandard tools
(smatch, sparse, cocci) at minimum.

> +		   .of_match_table = fp9931_dt_ids,
> +		   .pm = (&fp9931_pm_ops),

No need for ()

Best regards,
Krzysztof


