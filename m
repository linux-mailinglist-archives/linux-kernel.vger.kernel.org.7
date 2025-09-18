Return-Path: <linux-kernel+bounces-823177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DDB85C00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927EF188AEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0450230F541;
	Thu, 18 Sep 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJHA+iXf"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE023B616
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210187; cv=none; b=aJQga2uyJzYSTu3gHJ1BSIGrc+4ve+lKIjqa6TlWcELLDWh0aN/xE+qEEvUktjNtci4JmvCf7f7ltMIOZgvGGmTWSniC2rGK/7E1PWX7jNKrzuQHQpcbWnuuPwze4AwP6QvVOkFQpdJRtZlMbn099O/Qvoio1RAKTxl0zleSGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210187; c=relaxed/simple;
	bh=Xxz4IXooe5mBWocvSsUEAv+Dhe1tDxTJF7E5NsaVoX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQw4uz9ESPOI8J4N4b/3gQ6IeKkgS5PyCCK1Jx9Qg1JwDwUn6inmJkkRr83PvkAOsnwZ9PjRjU5D9A3grQjatP0NIePANXdhXcByDw+ZvmDG9Lvgt6XZL6hIA4JBOCfC/fJ4bw23WTZCNhbGO4m+7vQen9fBaP3GveRSRnpz81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJHA+iXf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54abd46747so1148801a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210185; x=1758814985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gjNw5Q6/63Ow1siMVKcV2BtH5CC+iH7vZq4ngjjGbM=;
        b=YJHA+iXfDSa2JR2nmB1FoNAHpj/LZq4ZUPUIJ3BCbw/pQpbzYAXII+q6lxu3iYIMkZ
         MH2tGiX/z95KNY68pGFpL/VoKxG8DoC1LN/Aq9dHQnXMTTXxilTMX9oP9yfThnDqhE/+
         VOV+9/7+XI76PK/LTJtX0dLeL4zqYHjV5V6wjR9XXCb63j3fWNErwvtQ6idk6MykwRZT
         XW1WKVaTLPZzcQjKya4DVQyowU/DM5Big9sJFtGCWyEjAn80fobW2vfJkTG5OEMkXQtM
         4TpEJfekaIC548wOumNw0Mj3HFNXsY7IR0IFEWtcrmrw26Eud97GT4qyAHpE7aE4nsX/
         vzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210185; x=1758814985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gjNw5Q6/63Ow1siMVKcV2BtH5CC+iH7vZq4ngjjGbM=;
        b=h7TFv8ki9TODwuYnHzfHgi+FyHNyHxq+O+56ECsP8TJiWV5WiOuA74kBBe6iPaMKLS
         6ZHRU7EbkEY+SDfr42CUC6eZAENuOf00jBcjVQmejxxi4AcUNvRjCx7Po9stNGNxnEwc
         muQwIl80rZH/qouIncvQ2xnLZnERrOqwZs15MaXx0twqlyiq8S9IAxsk+pELmTm+WD2S
         BkWMhKQeWX7qjl4sDEoJC6xR/wUrS6zb6OiL5rgoc4jJp3mTpex8vQhss5FiE/n0C9rs
         wKMoi9yDzca95sQaqD4VOvIRkmgaRn9Q7xhJWAv/bzI4WhsjnSYcGH6n/g77x3JE5zFS
         70Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXkD4OyFnGz5Ok9hUNqtsQpt3sJ9ZXAG0Eln1waU/XRP/KIdyFKEarLNhm3lWBesFJUNhKcssiMXBc9O7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhmXbgjokJVdGO2AygchRVJ8/PKneSZ2bgiPCHosGj3ukGM/y
	yIYatO2JXbWQu4NFnlyHyuTKhIvXdifS/hkIQSC3I/R8qk75tmTyqL/n
X-Gm-Gg: ASbGncvxWxSFFCfT1ghJvwS3CxDtjFMopZ+VMaESQ2+vsbdXNam+kHR8NSKjgaikkyU
	ylH8Q2Gq29DNStx4JLlcw9ZYmnNT52NWegv0CPSfONCHgJGN+RwEuskOJbO6RmEIXmFw4P7fZBA
	tivQmHGst47W4fmlXMk40MtHgWqenJH7i1VIsbJMtJ/xQ3pS+lJJZEvdX6SSBF+oTNhdkLxEE+M
	IKIkt0OpjzwFOQu3NQ9CyR16Hmyh9uZb5FNqNPpJlPA4mRcjwN9S1krNly0XOVLeP7uICQtr7BX
	BWJs2lbCCMtS3y/UwXeDxLycJkYyEyvprKPDF2GlaO4z5A6iLmTSt9fcNGbkg6CoUbgVwVQTwEX
	6S/BXlLQubbUh5xy2Jlx9rgtBiZ7Vc32iJyKsKDf7aw==
X-Google-Smtp-Source: AGHT+IG4CoYqNRp5Q8x2Ea0KJkAe37Y39DWQfQsjp9OIDirKIMhxdteAxsv0SXaDUXmPDdUOoq6G5Q==
X-Received: by 2002:a17:902:ef48:b0:269:805c:943a with SMTP id d9443c01a7336-269ba402246mr367145ad.2.1758210184915;
        Thu, 18 Sep 2025 08:43:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:194b:8358:5c91:3d3d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980339764sm29072045ad.129.2025.09.18.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:43:04 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:43:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexander Kurz <akurz@blala.de>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dzmitry Sankouski <dsankouski@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Heiko Stuebner <heiko@sntech.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] Input: mc13783-pwrbutton: add OF support
Message-ID: <7jfkewvtya3rkyfomnqvkbjdhqd5mqcgch3l354pu6gewlxkkj@lktpcyhvyt5q>
References: <20250914193723.10544-1-akurz@blala.de>
 <20250914193723.10544-9-akurz@blala.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914193723.10544-9-akurz@blala.de>

Hi Alexander,

On Sun, Sep 14, 2025 at 07:37:23PM +0000, Alexander Kurz wrote:
> Add OF support for the mc13783-pwrbutton so that it can be used with
> modern DT based systems.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  drivers/input/misc/mc13783-pwrbutton.c | 82 ++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
> index 08618c59197f..46bef0af46ee 100644
> --- a/drivers/input/misc/mc13783-pwrbutton.c
> +++ b/drivers/input/misc/mc13783-pwrbutton.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/mc13783.h>
> +#include <linux/property.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  
> @@ -88,8 +89,74 @@ static irqreturn_t button_irq(int irq, void *_priv)
>  	return IRQ_HANDLED;
>  }
>  
> -static int mc13783_pwrbutton_probe(struct platform_device *pdev)
> +static struct mc13xxx_buttons_platform_data __init *mc13xxx_pwrbutton_probe_dt(
> +	struct platform_device *pdev)
>  {
> +	struct mc13xxx_buttons_platform_data *pdata;
> +	struct fwnode_handle *child;
> +	struct device *dev = &pdev->dev;
> +	struct mc13xxx_button_devtype *devtype =
> +		(struct mc13xxx_button_devtype *)platform_get_device_id(pdev)->driver_data;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);

Since device properties is the only way to configure the device now you
do not need to have mc13xxx_buttons_platform_data anymore, you can parse
directly into "flags" and "keymap" of the mc13783_pwrb structure.

> +
> +	struct fwnode_handle *parent __free(fwnode_handle) =
> +		device_get_named_child_node(dev->parent, "buttons");
> +	if (!parent)
> +		return ERR_PTR(-ENODATA);
> +
> +	fwnode_for_each_named_child_node(parent, child, "onkey") {
> +		u32 idx;
> +		u8 dbnc = MC13783_BUTTON_DBNC_30MS;
> +		u16 dbnc_ms;
> +
> +		if (fwnode_property_read_u32(child, "reg", &idx))
> +			continue;
> +
> +		if (idx > devtype->button_id_max) {
> +			dev_warn(dev, "reg out of range\n");
> +			continue;
> +		}
> +
> +		fwnode_property_read_u16(child, "debounce-delay-ms", &dbnc_ms);
> +		switch (dbnc_ms) {
> +		case 0:
> +			dbnc = MC13783_BUTTON_DBNC_0MS;
> +			break;
> +		case 30:
> +			dbnc = MC13783_BUTTON_DBNC_30MS;
> +			break;
> +		case 150:
> +			dbnc = MC13783_BUTTON_DBNC_150MS;
> +			break;
> +		case 750:
> +			dbnc = MC13783_BUTTON_DBNC_750MS;
> +			break;
> +		default:
> +			dev_warn(dev, "invalid debounce-delay-ms value\n");
> +			continue;
> +		}
> +
> +		if (fwnode_property_read_u32(child, "linux,code", &pdata->b_on_key[idx]))
> +			continue;
> +
> +		if (fwnode_property_read_bool(child, "active-low"))
> +			pdata->b_on_flags[idx] |= MC13783_BUTTON_POL_INVERT;
> +
> +		if (fwnode_property_read_bool(child, "fsl,enable-reset"))
> +			pdata->b_on_flags[idx] |= MC13783_BUTTON_RESET_EN;
> +
> +		pdata->b_on_flags[idx] |= MC13783_BUTTON_ENABLE | dbnc;
> +	}
> +
> +	return pdata;
> +}
> +
> +static int __init mc13783_pwrbutton_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
>  	const struct mc13xxx_buttons_platform_data *pdata;
>  	struct mc13xxx *mc13783 = dev_get_drvdata(pdev->dev.parent);
>  	struct mc13xxx_button_devtype *devtype =
> @@ -101,9 +168,13 @@ static int mc13783_pwrbutton_probe(struct platform_device *pdev)
>  	int irq = 0;
>  
>  	pdata = dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "missing platform data\n");
> -		return -ENODEV;
> +	if (dev->parent->of_node) {
> +		pdata = mc13xxx_pwrbutton_probe_dt(pdev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	} else if (!pdata) {
> +		dev_err(dev, "missing platform data\n");
> +		return -ENODATA;
>  	}

No, just say

	error = mc13xxx_pwrbutton_parse_properties(...);
	if (error)
		return error;

(assuming the "parse properties" function will simply return error
code).
	
> +		pdata = mc13xxx_pwrbutton_probe_dt(pdev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
>  
>  	pwr = devm_input_allocate_device(&pdev->dev);
> @@ -214,13 +285,12 @@ static const struct platform_device_id mc13xxx_pwrbutton_idtable[] = {
>  
>  static struct platform_driver mc13783_pwrbutton_driver = {
>  	.id_table	= mc13xxx_pwrbutton_idtable,
> -	.probe		= mc13783_pwrbutton_probe,
>  	.driver		= {
>  		.name	= "mc13783-pwrbutton",
>  	},
>  };
>  
> -module_platform_driver(mc13783_pwrbutton_driver);
> +module_platform_driver_probe(mc13783_pwrbutton_driver, mc13783_pwrbutton_probe);

This seems unrelated (and probably unwanted) change.

Thanks.

-- 
Dmitry

