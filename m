Return-Path: <linux-kernel+bounces-770126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262AEB27710
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA42F5E7860
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD014A8B;
	Fri, 15 Aug 2025 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0HnJXWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8D1A9F8D;
	Fri, 15 Aug 2025 03:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229720; cv=none; b=cGAHtJ60u+5Pj0fHFget7ern9ZdRO0KPjjwOFDBcjc9o9Rq4YfFbO4lAmtx7JAx3oKE89UlJ6H7ZKYlnZq+HB7LPTcheBYf1ns4odi7jL3BEOUkeMth/ZusXnf0RPvG39PLK4YWJ/Bqoept8EOCux3ZTwT/L9kGYQJ+YyH4+6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229720; c=relaxed/simple;
	bh=7ZvPQE2Tk/BmvEi7qJOyCFeaGxT4/yzj3ZM/wpuyf6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywehu4j3FyxFOR6dtojBZwEXvd970PBxZBnDzlCvn7ZQA1O/TO8dufs27BlulNrEaM3P6bC3kUC9Rt3DGIiIWCxyeWw40P7sg18y/ewSAAmg7wu04jBMQN12DB/YbFFY37qJquagwdfEdulohbpFzuaqyt9klWQ7GjMweRM3PZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0HnJXWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE1DC4CEEB;
	Fri, 15 Aug 2025 03:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755229718;
	bh=7ZvPQE2Tk/BmvEi7qJOyCFeaGxT4/yzj3ZM/wpuyf6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0HnJXWNZsP7K/L4kLEZqqVmelL87bCorBCVx+h5uzwfdxJdcvjQtD8PF1FNFxCjU
	 e4t76juY3j3N5imuNrIXxAaTKjyoSRHWt+toTN8Op3ZDM0BgQ9dyXFLRUGGbEZ//B7
	 wuNR4xjnpdov57RoZjiuZEAsbczy8NjEIYsB9VpGJZgZKrzHvQqIqAdk9FbW/vGqTc
	 4Kv+1lddt93bqyICk9f9t/Vd6oHg7m9XXakTy2NuW5eljiq6MvdXYLIyGz/9gMIpuc
	 9y6Q1Nyi5Zf0yKpYgGWvHb7LOGTUzmm8HQ1COAPp0gZW2f2+xgkQPSsuwrJY83HQbL
	 YIcmNUlCzT+9Q==
Date: Fri, 15 Aug 2025 11:31:26 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: usb251xb: support usage case without I2C control
Message-ID: <aJ6qDlumTAwwLMpN@xhacker>
References: <20250815025540.30575-1-jszhang@kernel.org>
 <20250815025540.30575-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815025540.30575-3-jszhang@kernel.org>

On Fri, Aug 15, 2025 at 10:55:40AM +0800, Jisheng Zhang wrote:
> Refactor so that register writes for configuration are only performed if
> the device has a i2c_client provided and also register as a platform
> driver. This allows the driver to be used to manage GPIO based control
> of the device.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/usb/misc/usb251xb.c | 108 +++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 4fb453ca5450..ef5873009599 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/nls.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -242,15 +243,19 @@ static int usb251xb_check_dev_children(struct device *dev, void *child)
>  static int usb251x_check_gpio_chip(struct usb251xb *hub)
>  {
>  	struct gpio_chip *gc = gpiod_to_chip(hub->gpio_reset);
> -	struct i2c_adapter *adap = hub->i2c->adapter;
> +	struct i2c_adapter *adap;
>  	int ret;
>  
> +	if (!hub->i2c)
> +		return 0;
> +
>  	if (!hub->gpio_reset)
>  		return 0;
>  
>  	if (!gc)
>  		return -EINVAL;
>  
> +	adap = hub->i2c->adapter;
>  	ret = usb251xb_check_dev_children(&adap->dev, gc->parent);
>  	if (ret) {
>  		dev_err(hub->dev, "Reset GPIO chip is at the same i2c-bus\n");
> @@ -271,7 +276,8 @@ static void usb251xb_reset(struct usb251xb *hub)
>  	if (!hub->gpio_reset)
>  		return;
>  
> -	i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
> +	if (hub->i2c)
> +		i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
>  
>  	gpiod_set_value_cansleep(hub->gpio_reset, 1);
>  	usleep_range(1, 10);	/* >=1us RESET_N asserted */
> @@ -280,7 +286,8 @@ static void usb251xb_reset(struct usb251xb *hub)
>  	/* wait for hub recovery/stabilization */
>  	usleep_range(500, 750);	/* >=500us after RESET_N deasserted */
>  
> -	i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
> +	if (hub->i2c)
> +		i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
>  }
>  
>  static int usb251xb_connect(struct usb251xb *hub)
> @@ -289,7 +296,11 @@ static int usb251xb_connect(struct usb251xb *hub)
>  	int err, i;
>  	char i2c_wb[USB251XB_I2C_REG_SZ];
>  
> -	memset(i2c_wb, 0, USB251XB_I2C_REG_SZ);
> +	if (!hub->i2c) {
> +		usb251xb_reset(hub);
> +		dev_info(dev, "hub is put in default configuration.\n");
> +		return 0;
> +	}
>  
>  	if (hub->skip_config) {
>  		dev_info(dev, "Skip hub configuration, only attach.\n");
> @@ -698,18 +709,13 @@ static int usb251xb_i2c_probe(struct i2c_client *i2c)
>  	return usb251xb_probe(hub);
>  }
>  
> -static int __maybe_unused usb251xb_suspend(struct device *dev)
> +static int usb251xb_suspend(struct usb251xb *hub)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct usb251xb *hub = i2c_get_clientdata(client);
> -
>  	return regulator_disable(hub->vdd);
>  }
>  
> -static int __maybe_unused usb251xb_resume(struct device *dev)
> +static int usb251xb_resume(struct usb251xb *hub)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct usb251xb *hub = i2c_get_clientdata(client);
>  	int err;
>  
>  	err = regulator_enable(hub->vdd);
> @@ -719,7 +725,23 @@ static int __maybe_unused usb251xb_resume(struct device *dev)
>  	return usb251xb_connect(hub);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(usb251xb_pm_ops, usb251xb_suspend, usb251xb_resume);
> +static int usb251xb_i2c_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct usb251xb *hub = i2c_get_clientdata(client);
> +
> +	return usb251xb_suspend(hub);
> +}
> +
> +static int usb251xb_i2c_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct usb251xb *hub = i2c_get_clientdata(client);
> +
> +	return usb251xb_resume(hub);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_i2c_pm_ops, usb251xb_i2c_suspend, usb251xb_i2c_resume);

It seems this PM macros usage should be in a seperate patch. I will send a v2 this
night.

>  
>  static const struct i2c_device_id usb251xb_id[] = {
>  	{ "usb2422" },
> @@ -739,13 +761,71 @@ static struct i2c_driver usb251xb_i2c_driver = {
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.of_match_table = usb251xb_of_match,
> -		.pm = &usb251xb_pm_ops,
> +		.pm = pm_sleep_ptr(&usb251xb_i2c_pm_ops),
>  	},
>  	.probe = usb251xb_i2c_probe,
>  	.id_table = usb251xb_id,
>  };
>  
> -module_i2c_driver(usb251xb_i2c_driver);
> +static int usb251xb_plat_probe(struct platform_device *pdev)
> +{
> +	struct usb251xb *hub;
> +
> +	hub = devm_kzalloc(&pdev->dev, sizeof(*hub), GFP_KERNEL);
> +	if (!hub)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, hub);
> +	hub->dev = &pdev->dev;
> +
> +	return usb251xb_probe(hub);
> +}
> +
> +static int usb251xb_plat_suspend(struct device *dev)
> +{
> +	return usb251xb_suspend(dev_get_drvdata(dev));
> +}
> +
> +static int usb251xb_plat_resume(struct device *dev)
> +{
> +	return usb251xb_resume(dev_get_drvdata(dev));
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_plat_pm_ops, usb251xb_plat_suspend, usb251xb_plat_resume);
> +
> +static struct platform_driver usb251xb_plat_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = of_match_ptr(usb251xb_of_match),
> +		.pm = pm_ptr(&usb251xb_plat_pm_ops),
> +	},
> +	.probe		= usb251xb_plat_probe,
> +};
> +
> +static int __init usb251xb_init(void)
> +{
> +	int err;
> +
> +	err = i2c_add_driver(&usb251xb_i2c_driver);
> +	if (err)
> +		return err;
> +
> +	err = platform_driver_register(&usb251xb_plat_driver);
> +	if (err) {
> +		i2c_del_driver(&usb251xb_i2c_driver);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +module_init(usb251xb_init);
> +
> +static void __exit usb251xb_exit(void)
> +{
> +	platform_driver_unregister(&usb251xb_plat_driver);
> +	i2c_del_driver(&usb251xb_i2c_driver);
> +}
> +module_exit(usb251xb_exit);
>  
>  MODULE_AUTHOR("Richard Leitner <richard.leitner@skidata.com>");
>  MODULE_DESCRIPTION("USB251x/xBi USB 2.0 Hub Controller Driver");
> -- 
> 2.50.0
> 

