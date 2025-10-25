Return-Path: <linux-kernel+bounces-869951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D3C09189
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A8A1B2460D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846CF2FDC44;
	Sat, 25 Oct 2025 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BkHLfcxk"
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0926290;
	Sat, 25 Oct 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761401687; cv=none; b=CsPTLY8l7UigfZOqn/yeY4g6goYz9IYb3jvA8mrpr6qZJkywGylmJ/hvBdlxjk++cTITBZH2zIYYnOPPsE0w1LTfKlPZpYj6ZLgUuQnwAr5kzsErx5sGw7YMhb1SRAx7yyq74Ne7W+CK2+xRz8eZcQmWg3ucMAwBGH79vKte7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761401687; c=relaxed/simple;
	bh=ggXg7tpSRfPSWwgDDEc0Mi4dgvu2t7qPfbblFCUWpjc=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=Atd79vJo0BYfQWjOV0vrGtKQHYd6X6aZhp+lO0A8bML7qIyGSYGzw+BHfmUPTcaOc/9HbjIxvO7NdfOxdv3bFICMho0pyiQvUSDNi5TnYlgKLwvKcCPWpdjNM3NFmMoiqHIv3oWChDzrdUrlOwJZTwqbPHonr0WLVQBznGWvskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BkHLfcxk; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Cf2UvEzW5B8skCf2VvuYL3; Sat, 25 Oct 2025 16:14:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761401681;
	bh=hNXgE5EPV7K9LPWtHEU6p5h+Ujg/qjo4e+CAbzOghM8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=BkHLfcxkxkyKAyDzQCjwZ6q+4U0UK/ufwXpHiUGFp5q7j8xhnzrw+N2pGpHHUKopE
	 NGoGbRHxxuUbi9bqYILTWgEuq0H0dnNED16eFhJl1l7icPHWT+4OBrbykN8RwiOFTm
	 6NZQYdGSocDTWHBiW/38B1yAOX2suAiwXeR1xWM5kD1Yh5/PB23KwHGdjm9dMBYm4d
	 P0ig2i6ZnUAACVWt8Guxym4AesqejMLM9OI3Md8ZBdKqvNipF0hrP8KehgmnlGjJ1V
	 puIL6Nijnbi3coM2eDAQBqJhhCydlD2htJ1ZwaPn2NwJAlaXrN88G7cCVD77gnYWtb
	 SAF/DOPDjPjWA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 25 Oct 2025 16:14:41 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <9b059848-1512-457c-8437-8172e3726992@wanadoo.fr>
Date: Sat, 25 Oct 2025 16:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
References: <20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com>
 <20251025122854.1163275-3-krishna.kurapati@oss.qualcomm.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
To: krishna.kurapati@oss.qualcomm.com
Cc: biju.das.jz@bp.renesas.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 robh@kernel.org
In-Reply-To: <20251025122854.1163275-3-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/10/2025 à 14:28, Krishna Kurapati a écrit :
> There is a ID pin present on HD3SS3220 controller that can be routed
> to SoC. As per the datasheet:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
> low. This is done to enforce Type-C requirement that VBUS must be at
> VSafe0V before re-enabling VBUS"
> 
> Add support to read the ID pin state and enable VBUS accordingly.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati-5oFBVzJwu8Ry9aJCnZT0Uw@public.gmane.org>
> ---
>   drivers/usb/typec/hd3ss3220.c | 79 +++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
> index 3ecc688dda82..970c0ca8f8d4 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -15,6 +15,9 @@
>   #include <linux/usb/typec.h>
>   #include <linux/delay.h>
>   #include <linux/workqueue.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_graph.h>
>   
>   #define HD3SS3220_REG_CN_STAT		0x08
>   #define HD3SS3220_REG_CN_STAT_CTRL	0x09
> @@ -54,6 +57,11 @@ struct hd3ss3220 {
>   	struct delayed_work output_poll_work;
>   	enum usb_role role_state;
>   	bool poll;
> +
> +	struct gpio_desc *id_gpiod;
> +	int id_irq;
> +
> +	struct regulator *vbus;
>   };
>   
>   static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int power_opmode)
> @@ -319,6 +327,49 @@ static const struct regmap_config config = {
>   	.max_register = 0x0A,
>   };
>   
> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id)
> +{
> +	struct hd3ss3220 *hd3ss3220 = dev_id;
> +	int ret;
> +	int id;
> +
> +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))

I don't think it can be ERR. hd3ss3220_get_vbus_supply() forces it to 
NULL in such a case.

> +		return IRQ_HANDLED;
> +
> +	id = hd3ss3220->id_gpiod ? gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
> +
> +	if (!id) {
> +		ret = regulator_enable(hd3ss3220->vbus);
> +		if (ret)
> +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
> +	} else {
> +		regulator_disable(hd3ss3220->vbus);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
> +{
> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
> +	if (!np) {
> +		dev_err(hd3ss3220->dev, "failed to get device node");
> +		return -ENODEV;
> +	}
> +
> +	hd3ss3220->vbus = of_regulator_get_optional(hd3ss3220->dev, np, "vbus");
> +	if (IS_ERR(hd3ss3220->vbus))
> +		hd3ss3220->vbus = NULL;
> +
> +	of_node_put(np);
> +
> +	return ret;

return 0 and avoid 'ret'?

> +}
> +
>   static int hd3ss3220_probe(struct i2c_client *client)
>   {
>   	struct typec_capability typec_cap = { };
> @@ -354,6 +405,34 @@ static int hd3ss3220_probe(struct i2c_client *client)
>   		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>   	}
>   
> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
> +	if (IS_ERR(hd3ss3220->id_gpiod))
> +		return PTR_ERR(hd3ss3220->id_gpiod);
> +
> +	if (hd3ss3220->id_gpiod) {
> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
> +		if (hd3ss3220->id_irq < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");

Maybe return dev_err_probe() to log the error and simplify code?

> +			return hd3ss3220->id_irq;
> +		}
> +
> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
> +						hd3ss3220->id_irq, NULL,
> +						hd3ss3220_id_isr,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						dev_name(hd3ss3220->dev), hd3ss3220);
> +		if (ret < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");

Maybe return dev_err_probe() to log the error and simplify code?

Above, you use "ID IRQ" and here "id irq". Maybe keep the case case? Or 
change the 2nd message that looks a copy'n'paste error to me.

> +			return ret;
> +		}
> +	}
> +
> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
> +	if (ret)
> +		return dev_err_probe(hd3ss3220->dev,
> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");

Why PTR_ERR(hd3ss3220->vbus)? Should this be 'ret'?

If hd3ss3220_get_vbus_supply() fails, vbus will be NULL in all cases.

In hd3ss3220_get_vbus_supply(), if -ENODEV is returned, it is not 
initialized yet, and if of_regulator_get_optional() fails, it is set to 
NULL.

> +
>   	if (IS_ERR(hd3ss3220->role_sw)) {
>   		ret = PTR_ERR(hd3ss3220->role_sw);
>   		goto err_put_fwnode;

CJ

