Return-Path: <linux-kernel+bounces-783766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011FB33221
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE3817952B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC792264B1;
	Sun, 24 Aug 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtEZ7X24"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5D14A0B5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061727; cv=none; b=mS2K5mAKltqWELMvxePsblncPxV7mXi6cBbWNv3O3Z8QTE8rLorwpfHxCnTJCoxf7Ugquf3/73+NEYSTn7Rbb7mEAHEhwy8ZTd24X4SkEDlhEGZivm03Zfx//paSzIBP75vLQFyEYv103Q48bp3WewAfLceQifA1q76z6D2vi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061727; c=relaxed/simple;
	bh=xlHnB57X/FCigx/pBb9mIcuNxBwxcq2igWb/TL042Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL8opOP1QXtpqC+dlk0lCoifuJro6oJ1YFxRXhmft0K5xgwhzWua2Lw8DXGVKDPgJX6kM/Lrxx8F+7O9ne5omfoy5YDam/0vIe1Ft+2bRx+7XLypJMila0R5Camr7T67/fywzYIr9hi47KYNBFGO+hvKm3b7auYTO0GtUIoQMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtEZ7X24; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 24 Aug 2025 20:55:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756061713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUZVVw0Pq9GsvwinTFbSvs3bi3AOi/nPiV4+slRTxWQ=;
	b=KtEZ7X24udgtLzxQHYyhNJC7B01mgqDy+G3CGURZmqiwbNaaWEloYnFcJYdCaSjXAzV1Ce
	ALz6/Zh4FShE1LUaM3ymcPUdmp4f6OicEn9oFn0wuDh0wyBXzzKO4tnHpfMPr6w/lErMlS
	U/VWbUUOdC/Ilt97dU10xxdETyjWqJs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Richard Leitner <richard.leitner@linux.dev>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] usb: usb251xb: support usage case without I2C
 control
Message-ID: <qhfmvqjxad3ngk3azdkyxhw6ka7ijxccl6d2ylu26zlmovmeg3@3f2r4f6ksr6s>
References: <20250820161743.23458-1-jszhang@kernel.org>
 <20250820161743.23458-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820161743.23458-4-jszhang@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Jisheng,

On Thu, Aug 21, 2025 at 12:17:43AM +0800, Jisheng Zhang wrote:
> Currently, the usb251xb assumes i2c control. But from HW point of
> view, the hub supports usage case without any i2c, we only want the
> gpio controls.
> 
> Refactor the code so that register writes for configuration are only
> performed if the device has a i2c_client provided and also register as
> a platform driver. This allows the driver to be used to manage GPIO
> based control of the device.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/usb/misc/usb251xb.c | 108 +++++++++++++++++++++++++++++++-----
>  1 file changed, 94 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index cb2f946de42c..e9a9404d17b2 100644
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

You dropped the memset of write buffer. Are you sure this doesn't cause
any issues? (Sorry, I'm currently travelling, so I wasn't able to test
the series on real hw)

Apart from that the patch LGTM. Thanks! :-)

>  
>  	if (hub->skip_config) {
>  		dev_info(dev, "Skip hub configuration, only attach.\n");
> @@ -698,18 +709,13 @@ static int usb251xb_i2c_probe(struct i2c_client *i2c)
>  	return usb251xb_probe(hub);
>  }
>  
> -static int usb251xb_suspend(struct device *dev)
> +static int usb251xb_suspend(struct usb251xb *hub)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct usb251xb *hub = i2c_get_clientdata(client);
> -
>  	return regulator_disable(hub->vdd);
>  }
>  
> -static int usb251xb_resume(struct device *dev)
> +static int usb251xb_resume(struct usb251xb *hub)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct usb251xb *hub = i2c_get_clientdata(client);
>  	int err;
>  
>  	err = regulator_enable(hub->vdd);
> @@ -719,7 +725,23 @@ static int usb251xb_resume(struct device *dev)
>  	return usb251xb_connect(hub);
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_pm_ops, usb251xb_suspend, usb251xb_resume);
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
>  
>  static const struct i2c_device_id usb251xb_id[] = {
>  	{ "usb2422" },
> @@ -739,13 +761,71 @@ static struct i2c_driver usb251xb_i2c_driver = {
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.of_match_table = usb251xb_of_match,
> -		.pm = pm_sleep_ptr(&usb251xb_pm_ops),
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
> +		.of_match_table = usb251xb_of_match,
> +		.pm = pm_sleep_ptr(&usb251xb_plat_pm_ops),
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

regards;rl

