Return-Path: <linux-kernel+bounces-762823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15297B20B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456183A4086
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD41DF252;
	Mon, 11 Aug 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRRPUhjf"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075B149C51;
	Mon, 11 Aug 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920990; cv=none; b=jacREwYE4AYFNVQQ0B4i10UbzoJE8ViXTrwhTwaNkpwnntBgv4LL7+gSxdXt/gZqaOXiuAAWDKJr4oWRNorktQ4KxZ9COOGU5PjGw/ZnBzYkZB6pk7nWQJ9j/5JpiEvxBrbwAlXawicg4f10A5YFLUQRJkKs6TfvPpxhECyvjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920990; c=relaxed/simple;
	bh=VOKuOI0+Bq5dn9PO9KpLJlyxvc2ZdvZgTYp12XumcoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBphY5jo0IW57s8LCzmCj4OOfT3ObLR7wzfO0f2lxtOByFgL5nr3XLG4sCGItXWPIvEtGX9q4/SC20q58aHNLqFgKKJqDLB8bI4i4ZOs6jMe+LwZwph2uT4cbYcRBLyhbIyJftNUf99yjxBG2qKuHOhcibWg9AH5WURpPqHxdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRRPUhjf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4233978326so2412939a12.1;
        Mon, 11 Aug 2025 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920988; x=1755525788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cTKwuk+ky1tP6QdSXxJoy9Pjmm3zZoEMRCsmkMtZ3Tg=;
        b=XRRPUhjfConjGXPn0ZOt5Jx3LiVQwfOeVlwElNrey+ObFSrW/WH1Br1hPUUWaHp7wd
         q3aq+X750VbJO5Q6FBWD13qquZxFyZL1wE/4KmjlpDJp7zpYSmyp8qOtZmyZrrb4aPCZ
         p6DAN0M2nLywzPb60ItUKR4P5RA/vzfrFYvQaqopXopMbrZDXhGmK5xKua1gFm8qlt++
         mnRDSs+AWpXUcb7LDPpVr3ou9zXolm9MeoUEwXzGhAL3+o06ZabFNzR66Uh/L+gg4mOU
         ob+6FpP51xoOO2wldU969l5yD8sXR4YxemQxwkbStXxEYAGuu1+Ow09KUZJyVYoUIhn1
         qbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920988; x=1755525788;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTKwuk+ky1tP6QdSXxJoy9Pjmm3zZoEMRCsmkMtZ3Tg=;
        b=kXDAJYe1DNOiyGejPSlSKN5Jti+iFcqawBfWAoE6Pa2fZjG16qDywptfrtuH+4kDuh
         NFCE23vDqi+q/TY+KDNmQprYNl189paoLw+ZzNBBgEemoKdLSSlIBTKjql6HaU5ROLuO
         KjMDTi59qKUJm3LRnmDfCZFgrL3EvpoYeAl3sjzUEXaPyk4KduEu+cOO8JsJ2Nb3oYob
         v+xF8JePtnHApoIaVFswPnBWPjxBxkIy5Jj6WCwhazSq2IDBOgVCTDr1MDkUUyp55WTp
         vguWhMHENppwFG5k2CllFiHKvF6jef5uNSghqwYS1D2LdRxiDio2KChY8ytj4x8djZ8/
         fOmA==
X-Forwarded-Encrypted: i=1; AJvYcCUw/WRmWNENJA5Tjfpqo7AJ2329g4EqH9rkY6Rr4MN8A3Qv4qjpUWYSMMJJ7+Npe3AX6IWhZcFH3TGYHm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrP4EYb3DjgLQTu6B3WCcqTQJhe2GF4+y4sSNBD3VD2/srWn9E
	p1jql7ui77TzKNPjQqQaw5s5ocT5c+vUBZMfXUI/T5fEB6YaTbI17btP
X-Gm-Gg: ASbGnctYsrKDU9zPJpT+5gZcYRYZ7/ZEwBOWmKHxjz3WYQkesck7sFyIJ0bjtLo+xzE
	mbB87wnVIhnaGZd4jjsmxAeC8NjcbxUQ3W0oR9qlAWNvktYpxUiB1zsKb3wcyQ7gnoOJPkAAzk6
	AJmM3deY84cMbUPtu6ftVLjfohAOO5uPv4YhEgEkPrY8kd6pYgWC/m47HJFGaN+SxnWdYn5AgHv
	8m2BzD2tvxWZDKuDFBtmzVXxhm4zKmpTubPaVijG3ko4VKU+WnAjBrpzp59fP3gFtHgNfVwPRpw
	wKS33DXHVoAAdjO/UK754yJkSmA1rwUPth8FPk6MJjNgciqMYT/FP1XhuO9I01uTRE22bm/1ypw
	Hw11zT3RYvo2LwCpGiHtJy0mdeJKX5SBvnoDKvvxoIHj2uuAmpmEQw1eBXQ2UxE4EM+N8BlM=
X-Google-Smtp-Source: AGHT+IFebwNmWsMWA395liEmgOq15RRumiqJ7n7+f9kRMMWhvLIFjBYA+Y0C7sBHfLhwcEUfQdcWbQ==
X-Received: by 2002:a17:903:15c3:b0:240:770f:72d1 with SMTP id d9443c01a7336-242c2052cacmr203963915ad.24.1754920987673;
        Mon, 11 Aug 2025 07:03:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cbdsm276252615ad.75.2025.08.11.07.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:03:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b89a62f-adc0-4eef-8e49-638371fbadf0@roeck-us.net>
Date: Mon, 11 Aug 2025 07:03:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hwmon: sbtsi_temp: AMD CPU extended temperature
 range support
To: Chuande Chen <chenchuande@gmail.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 chuachen@cisco.com, groeck7@gmail.com
References: <20250810084307.41243-1-chenchuande@gmail.com>
 <20250811050752.76030-1-chenchuande@gmail.com>
 <20250811050752.76030-2-chenchuande@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250811050752.76030-2-chenchuande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 22:07, Chuande Chen wrote:
> From: Chuande Chen <chuachen@cisco.com>
> 
Any reason for not sending this from your Cisco e-mail address ?

> Many AMD CPUs can support this feature now.
> We would get a wrong CPU DIE temp if don't consider this.

temperature.

> In low-temperature environments, the CPU die temperature
> can drop below zero.
> So many platform would like to make extended temperature range
> as their default configuration.
> Default temperature range (0C to 255.875C) degree celsius.
> Extended temperature range (-49C to +206.875C) degree celsius.

Celsius. But then "C" and "degree celsius" is redundant and "degree celsius"
can be dropped.

> Ref Doc: AMD V3000 PPR (Doc ID #56558).
> 

The document is not available to the public. You will need to find someone
from AMD to provide an Acked-by: or Reviewed-by: tag to show me that the
V3000 hardware really uses this bit.

The column limit for patch descriptions is 75 characters. Please use it.

> Signed-off-by: Chuande Chen <chuachen@cisco.com>
> ---
> V1 -> V2: addressed review comments, also save READ_ORDER bit into sbtsi_data
> ---
>   drivers/hwmon/sbtsi_temp.c | 46 +++++++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> index 3c839f56c..32d6a7162 100644
> --- a/drivers/hwmon/sbtsi_temp.c
> +++ b/drivers/hwmon/sbtsi_temp.c
> @@ -5,6 +5,7 @@
>    *
>    * Copyright (c) 2020, Google Inc.
>    * Copyright (c) 2020, Kun Yi <kunyi@google.com>
> + * Copyright (c) 2025, Chuande Chen <chuachen@cisco.com>

For adding a few lines of code ? If everyone would do that, the Linux kernel
code would consist of 50% or more copyright lines. If you insist on this,
I'll have to try and find official guidelines about if and when it is appropriate
to add copyrights.

Plus this made me suspicious: How do I know that you are really a Cisco employee
and not someone who tries to sneak in some code that isn't even supported
by real hardware ?

>    */
>   
>   #include <linux/err.h>
> @@ -14,6 +15,7 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/of.h>
> +#include <linux/bitfield.h>
>   
>   /*
>    * SB-TSI registers only support SMBus byte data access. "_INT" registers are
> @@ -29,8 +31,23 @@
>   #define SBTSI_REG_TEMP_HIGH_DEC		0x13 /* RW */
>   #define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
>   
> +/*
> + * Bit for reporting value with temperature measurement range.
> + * bit == 0: Use default temperature range (0C to 255.875C).
> + * bit == 1: Use extended temperature range (-49C to +206.875C).
> + */
> +#define SBTSI_CONFIG_EXT_RANGE_SHIFT	2
> +/*
> + * ReadOrder bit specifies the reading order of integer and
> + * decimal part of CPU temp for atomic reads. If bit == 0,
> + * reading integer part triggers latching of the decimal part,
> + * so integer part should be read first. If bit == 1, read
> + * order should be reversed.
> + */

Too many line splits. Extend lines to 80 characters. Yes, I see this is copied
from below, but that doesn't mean it can not be adjusted.


>   #define SBTSI_CONFIG_READ_ORDER_SHIFT	5
>   
> +#define SBTSI_TEMP_EXT_RANGE_ADJ	49000
> +
>   #define SBTSI_TEMP_MIN	0
>   #define SBTSI_TEMP_MAX	255875
>   
> @@ -38,6 +55,8 @@
>   struct sbtsi_data {
>   	struct i2c_client *client;
>   	struct mutex lock;
> +	bool ext_range_mode;
> +	bool read_order;
>   };
>   
>   /*
> @@ -74,23 +93,11 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
>   {
>   	struct sbtsi_data *data = dev_get_drvdata(dev);
>   	s32 temp_int, temp_dec;
> -	int err;
>   
>   	switch (attr) {
>   	case hwmon_temp_input:
> -		/*
> -		 * ReadOrder bit specifies the reading order of integer and
> -		 * decimal part of CPU temp for atomic reads. If bit == 0,
> -		 * reading integer part triggers latching of the decimal part,
> -		 * so integer part should be read first. If bit == 1, read
> -		 * order should be reversed.
> -		 */
> -		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> -		if (err < 0)
> -			return err;
> -
>   		mutex_lock(&data->lock);
> -		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
> +		if (data->read_order) {
>   			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
>   			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
>   		} else {
> @@ -122,6 +129,8 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
>   		return temp_dec;
>   
>   	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
> +	if (data->ext_range_mode)
> +		*val -= SBTSI_TEMP_EXT_RANGE_ADJ;
>   
>   	return 0;
>   }
> @@ -146,6 +155,8 @@ static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
>   		return -EINVAL;
>   	}
>   
> +	if (data->ext_range_mode)
> +		val += SBTSI_TEMP_EXT_RANGE_ADJ;
>   	val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX);
>   	sbtsi_mc_to_reg(val, &temp_int, &temp_dec);
>   
> @@ -203,6 +214,7 @@ static int sbtsi_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct device *hwmon_dev;
>   	struct sbtsi_data *data;
> +	int err;
>   
>   	data = devm_kzalloc(dev, sizeof(struct sbtsi_data), GFP_KERNEL);
>   	if (!data)
> @@ -214,6 +226,14 @@ static int sbtsi_probe(struct i2c_client *client)
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data, &sbtsi_chip_info,
>   							 NULL);
>   
> +	mutex_lock(&data->lock);
> +	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> +	mutex_unlock(&data->lock);

Unnecessary lock. First, this is in the probe function, where a lock is not needed
in the first place. Second, it is a single I2C operation, which does not need
a lock either case.

On top of that, this needs to be called before the call to
devm_hwmon_device_register_with_info() because otherwise the first read can
happen before the bits are set.

Guenter

> +	if (err < 0)
> +		return err;
> +	data->ext_range_mode = FIELD_GET(BIT(SBTSI_CONFIG_EXT_RANGE_SHIFT), err);
> +	data->read_order = FIELD_GET(BIT(SBTSI_CONFIG_READ_ORDER_SHIFT), err);
> +
>   	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>   


