Return-Path: <linux-kernel+bounces-864834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6ABFBA92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDDB19C8938
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359A33DED1;
	Wed, 22 Oct 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhVgqssI"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A33DEDD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132907; cv=none; b=GiVaJA0bewVk0zvTxlZ491awYAp0FT+pe5ODc0j3+jT0KRDagjTM1xnIe+kP/QBM+9Z2dDwdGwChiOi7TWbuheBrYi2MmZcu7hAATy22AAdkoIg3gYhc5kdD5AMTIxJzLDaBST5j2Zz0hadQODXc5JQLBlyCDUbNF8iqW+/M/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132907; c=relaxed/simple;
	bh=+1jzj1FdbPB3v8jHy8/PMSpKosEhgj1bHkqnLiEO5sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK/nLGssU35btUkjxzV905VqNXZIYA++iPadwa9saT+UFbQiuEP2L4JpIaYk690EhkpywCk/LTQF8OQMM+k4L4axpQpyQ5xtUa0wyrVLCSAUYZcc6voKWdNnuPTaOK7izvYFLY3wYA4CyDtrsHYvy9oLJks9bG4eiiTeL3onMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhVgqssI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso1209995966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761132903; x=1761737703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO34qPsn7QHCTVDfDKcQas0jsSh3wLko8YufcBfx8as=;
        b=jhVgqssI2ahk4Mi1fx3tWr2Gdz4nrLrxm7NjUwiGCgWCzxnSecnj2k9i4D8X71uX2f
         7JW53WO5RJE4wxttW1XJnk2jLncrgB5O67k/iH/05KKnZhVMqZQtz4/rHb31WDbl4/IV
         tfaEOk3VPlthvvwNCOzel7WIPMSYE97gEh+TPd6BpNxx5d3pfnM5A8xlFCLVb+spnbxz
         hwa7reTtNXzEXD1dd6Cb7C777T3r+++OrVSzvL3/6Kxn4hRUR9/xYgW+OoqSngOOTji4
         O2muijnz/HU4BVPRFEPIg9zCxicHrmBSNCpcDvn0+1gQDN6GsM7Bb5OyPm4m894c/3IO
         mFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132903; x=1761737703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO34qPsn7QHCTVDfDKcQas0jsSh3wLko8YufcBfx8as=;
        b=BpAIsQcJct2LeSCm9QK15ESA1yLaLRY2HLAnZo/+4W41ZMSUXTxVvV5C7c8QSqK3yS
         MrZDwGKhOT1CCZ8Kw7+seC/qkTn2lYVvJcRXvD+od6voiRukpuBQ0OESmQZFD99vPY9g
         OZT2R4rSkP+hW4ZYtRpq8clEC/qTtnhWQYEwHXQh4n0WMwlrl1uTHxPLBOyk3K0z3Sy2
         wGeZhc0fMtVC6gEGKEhsS+FvZmtNYCl2Uw5MONouNeAIS3eEM+yqT38eauT4KsIHH3m9
         FXZeXMJ6w+C0Tipuw4oypLuwDZoLIoEq5NjOF2u7id0FdsVAKDHIDOWWYPHlG/eJEaj3
         rjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZi+ML4BR5SbmmUDtHZRDO/MWVH8oVoXCIKr+U9QNCrQUtHxPpcvtcV1D+3adbfPJY9QN3d5bgq/HBe1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Akd7Jb6rq3FevrF7neu9UP/x0o82O/a5p588gj1WtMC5YYlQ
	X4t/Et2uTKvW/6IHvwvU5yRQHEIbv3JKIXfPHPHH7KZaUWuzSVnnP1v3
X-Gm-Gg: ASbGncvi+erKJW86LC6qqmJODYIBBUkggUpNhf9LouzxqrCiaj57b92rJr7MNFpPYBT
	1iMpBBSh68CPC2l7ewhz7bC4SxeFup32wcCqPGfzOGMqej6/tioaJynABEFHwN4/FNN/03A/rFy
	gzIxuLdaa1oP3nsXuAuSUoKpK3Xjh9Up4jausj7TFpzo5l/q/yRdIJtAjjzXP5ZWMH6mU/VBoJk
	jcrkCAPdRKvh1cc64TLr6A4vz7UQf6dFtdkOpe80eG8WB1JzCoC5luyj1qq8xbYsvY1p9sbWEUy
	069gTjdMxD/1s+PDNGo2j5pA06nBILEEkuB0ZIROeqH4enSp2aVEY69jvsrCXFbWnlgUOLJpyf8
	u039xbOuitOX1gj9BkWTp5mS0ZVFvM+VkJRkSJgJhfkT0WQicf7gsgdPWMmb9guDPTD9+8LblHB
	WZ0It8agyimWdtvhnojBi2eBLgglvGANyoVT5BKTDP8B4=
X-Google-Smtp-Source: AGHT+IHfqiWBy7zfGoCqLQpI11jm6dwQ/WE7NiaPb8Gr8GzjB9HYaKJgVjiXf/jFs4wJwPRiCS9gYA==
X-Received: by 2002:a17:907:1c82:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b6472a6a145mr2430377866b.17.1761132902443;
        Wed, 22 Oct 2025 04:35:02 -0700 (PDT)
Received: from [10.25.209.134] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4dcf2sm1303250766b.75.2025.10.22.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:35:02 -0700 (PDT)
Message-ID: <804dd1f5-7e79-4bfa-b777-c97bb89a713a@gmail.com>
Date: Wed, 22 Oct 2025 04:35:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] reset: imx8mp-audiomix: Switch to using regmap API
To: Frank Li <Frank.li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-6-laurentiumihalcea111@gmail.com>
 <aPJXdPVrofYGQgIP@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aPJXdPVrofYGQgIP@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/17/2025 7:49 AM, Frank Li wrote:
> On Fri, Oct 17, 2025 at 04:20:22AM -0700, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> As far as the Linux kernel is concerned, block devices such as i.MX8MP's
>> AUDIOMIX block control or i.MX8ULP's SIM LPAV can simultaneously act as
>> clock controllers, reset controllers or mux controllers. Since these IPs
>> offer different functionalities through different subsystem APIs, it's
>> important to make sure that the register R-M-W cycles are performed under
>> the same lock across all subsystem APIs. This will ensure that registers
>> will not end up with the wrong values because of race conditions (e.g.
>> clock consumer tries to update block control register A, while, at the
>> same time, reset consumer tries to update the same block control register).
>>
>> However, the aforementioned race conditions will only impact block control
>> IPs which use the same register for multiple functionalities. For example,
>> i.MX8MP's AUDIOMIX block control IP provides clock gating functionalities
>> and reset control functionalities through different registers. This is why
>> the current approach (i.e. clock control and reset control work using
>> different locks) has worked well so far.
>>
>> Since we want to extend this driver to be usable for i.MX8ULP's SIM LPAV
>> block control IP, we need to make sure that clock control, reset control,
>> and mux control APIs use the same lock since all of these functionalities
>> are performed using the SYSCTRL0 register.
>>
>> To do so, we need to switch to the regmap API and, if possible, use the
>> parent device's regmap, which, in the case of i.MX8ULP, will be the clock
>> controller. This way, we can make sure that the clock gates and the reset
>> controller will use the same lock to perform the register R-M-W cycles.
>>
>> This change will also work fine for cases where we don't really need to
>> share the lock across multiple APIs (e.g. i.MX8MP's AUDIOMIX block
>> control) since regmap will take care of the locking we were previously
>> explicitly performing in the driver.
>>
>> The transition to the regmap API also involves some cleanup. Specifically,
>> we can make use of devres to unmap the device's memory and get rid of the
>> memory mapping-related error paths and the remove() function altogether.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  drivers/reset/reset-imx8mp-audiomix.c | 95 +++++++++++++++++----------
>>  1 file changed, 61 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
>> index e9643365a62c..c74ce6e04177 100644
>> --- a/drivers/reset/reset-imx8mp-audiomix.c
>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> +#include <linux/regmap.h>
>>  #include <linux/reset-controller.h>
>>
>>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
>> @@ -19,6 +20,7 @@
>>  struct imx8mp_reset_map {
>>  	unsigned int offset;
>>  	unsigned int mask;
>> +	unsigned int shift;
>>  	bool active_low;
>>  };
>>
>> @@ -26,24 +28,27 @@ static const struct imx8mp_reset_map reset_map[] = {
>>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>>  		.mask = BIT(0),
>> +		.shift = 0,
>>  		.active_low = true,
>>  	},
>>  	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
>>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>>  		.mask = BIT(1),
>> +		.shift = 1,
>>  		.active_low = true,
>>  	},
>>  	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
>>  		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
>>  		.mask = BIT(5),
>> +		.shift = 5,
> why need shift?  you can use ffs(mask) to get shift.
>
>>  		.active_low = false,
>>  	},
>>  };
>>
>>  struct imx8mp_audiomix_reset {
>>  	struct reset_controller_dev rcdev;
>> -	spinlock_t lock; /* protect register read-modify-write cycle */
>>  	void __iomem *base;
>> +	struct regmap *regmap;
>>  };
>>
>>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
>> @@ -55,26 +60,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>>  				  unsigned long id, bool assert)
>>  {
>>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
>> -	void __iomem *reg_addr = priv->base;
>> -	unsigned int mask, offset, active_low;
>> -	unsigned long reg, flags;
>> +	unsigned int mask, offset, active_low, shift, val;
>>
>>  	mask = reset_map[id].mask;
>>  	offset = reset_map[id].offset;
>>  	active_low = reset_map[id].active_low;
>> +	shift = reset_map[id].shift;
>> +	val = (active_low ^ assert) << shift;
>>
>> -	spin_lock_irqsave(&priv->lock, flags);
>> -
>> -	reg = readl(reg_addr + offset);
>> -	if (active_low ^ assert)
>> -		reg |= mask;
>> -	else
>> -		reg &= ~mask;
>> -	writel(reg, reg_addr + offset);
>> -
>> -	spin_unlock_irqrestore(&priv->lock, flags);
>> -
>> -	return 0;
>> +	return regmap_update_bits(priv->regmap, offset, mask, val);
>>  }
>>
>>  static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
>> @@ -94,6 +88,50 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
>>  	.deassert = imx8mp_audiomix_reset_deassert,
>>  };
>>
>> +static const struct regmap_config regmap_config = {
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +};
>> +
>> +/* assumption: registered only if not using parent regmap */
>> +static void imx8mp_audiomix_reset_iounmap(void *data)
>> +{
>> +	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(data);
>> +
>> +	iounmap(priv->base);
>> +}
>> +
>> +/* assumption: dev_set_drvdata() is called before this */
>> +static int imx8mp_audiomix_reset_get_regmap(struct device *dev)
>> +{
>> +	struct imx8mp_audiomix_reset *priv;
>> +	int ret;
>> +
>> +	priv = dev_get_drvdata(dev);
>> +
>> +	/* try to use the parent's regmap */
>> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (priv->regmap)
>> +		return 0;
>> +
>> +	/* ... if that's not possible then initialize the regmap right now */
>> +	priv->base = of_iomap(dev->parent->of_node, 0);
>> +	if (!priv->base)
>> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, imx8mp_audiomix_reset_iounmap, dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to register action\n");
>> +
>> +	priv->regmap = devm_regmap_init_mmio(dev, priv->base, &regmap_config);
>> +	if (IS_ERR(priv->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
>> +				     "failed to initialize regmap\n");
>> +
>> +	return 0;
>> +}
>> +
>>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>>  				       const struct auxiliary_device_id *id)
>>  {
>> @@ -105,36 +143,26 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>>  	if (!priv)
>>  		return -ENOMEM;
>>
>> -	spin_lock_init(&priv->lock);
>> -
>>  	priv->rcdev.owner     = THIS_MODULE;
>>  	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
>>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>>  	priv->rcdev.of_node   = dev->parent->of_node;
>>  	priv->rcdev.dev	      = dev;
>>  	priv->rcdev.of_reset_n_cells = 1;
>> -	priv->base            = of_iomap(dev->parent->of_node, 0);
>> -	if (!priv->base)
>> -		return -ENOMEM;
>>
>> +	/* keep before call to imx8mp_audiomix_reset_init_regmap() */
>>  	dev_set_drvdata(dev, priv);
>>
>> +	ret = imx8mp_audiomix_reset_get_regmap(dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get regmap\n");
>> +
>>  	ret = devm_reset_controller_register(dev, &priv->rcdev);
>>  	if (ret)
>> -		goto out_unmap;
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to register reset controller\n");
>>
>>  	return 0;
>> -
>> -out_unmap:
>> -	iounmap(priv->base);
>> -	return ret;
>> -}
>> -
>> -static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
>> -{
>> -	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
>> -
>> -	iounmap(priv->base);
>>  }
>>
>>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>> @@ -147,7 +175,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>>
>>  static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
>>  	.probe		= imx8mp_audiomix_reset_probe,
>> -	.remove		= imx8mp_audiomix_reset_remove,
> cleanup imx8mp_audiomix_reset_remove need seperate patch.


as things stand now, this bit belongs in the same patch as the switch to the regmap

API because of the introduction of imx8mp_audiomix_reset_get_regmap(), which

uses devres. This makes the remove() function incorrect and, thus, needs to be dropped.


since the cleanup is quite trivial, I don't think this would justify purposely

making imx8mp_audiomix_reset_get_regmap() not use devres in this patch

and then transitioning to it in a subsequent patch.


>
> Frank
>
>>  	.id_table	= imx8mp_audiomix_reset_ids,
>>  };
>>
>> --
>> 2.43.0
>>

