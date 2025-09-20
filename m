Return-Path: <linux-kernel+bounces-825737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA27B8CB2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C4E6234BF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB542FA0F0;
	Sat, 20 Sep 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f7btD9Bc"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01C2F7AAF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380744; cv=none; b=b5w3gunCodRdRj1Q/HJHmESiVI8X8VBrJW3qPzDO8z3Y9ICw8MQTe9yCznOrEOrqTIWSMywXnI73/owojGKZzO1jwSTbQ/eqaui0KL+7bVThB/wqpAA6bC/UTcNOoGraAnwgWCDdOekHnpvn/AmK8JPAQ3LcGoBDhhnQf8Cp1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380744; c=relaxed/simple;
	bh=aWayvqL3VDfszikMhDxl8W1TgKxHXMgXHh6mTuD+Pk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRKHCAQWqviC7Dwou6IjXFOgYq/ctU/G6MxdZn70NVhioMaLxP0keS3ivR+JT5GF2fpo7Ev8dwrpfOV4aFJcRH883VXnsViWvZB3Vnz/a2xlaWlZM4Tu8DFbfOdHSMcnhLUOuYy3ioldIiwD9/CKHOd/j9hS3hPEbTwekCsXbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f7btD9Bc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381df387fso1599048a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758380742; x=1758985542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApPm9TrFpXMEdiMfo67L+FcuF5N4ixQDCyPBv1VUDxI=;
        b=f7btD9Bc/p2IJpCz3JU4pDTlcwTXA7+lb+iE9Jxu+DjwQ0efBA+DFNsfR8R2261ePi
         5K+cmGUsn4emmz7hNbr6PLGTSzeXkbNKe25Bi77VaYBhVd+DKcPoa3jjMCO6o05ayQye
         iPEu83EYVxRr1gzVAxZxPmTF6WN3ieWQvuVYpQXH5HFYa89W6WUp8Ud/E3GeOTLUNInS
         DAOLfPJbMqMXHsR6owyToe8TjWcOEPl2+SMWnzzEWuXqZoPtCU5RgKy39AmLDrcVroZR
         QzXaaJfyZgJZNuJVXkXRCLMpsMZ/fuWhDYCvcECjhnBa0rig0Eh1zC9dh795vxHXr8q5
         gnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380742; x=1758985542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApPm9TrFpXMEdiMfo67L+FcuF5N4ixQDCyPBv1VUDxI=;
        b=b/gF94dH0Tw1ZLO0uOxxsqgwIVExmp0zCoS3VjC8kG5caO2mrrC9tlzoUVFHKiWJGg
         1ypHnFeH85K5UXWJ5hjUzkKpAokcBcM1t3vUXjHHtySZyRBmcV7LzUpThUUGKUBB4E1n
         u4G0P/+xKMhJvRvu9XvF4WtKn4zYBmTHVnowGi/TeUHPx31ArY7rFcsu81k0IXjdGzDU
         6ktd3e9Y45Fa6gxo7vBvxNUfgK63Tl45JsWEADsU+FkmDyBeYCnZWXXlDPSNi776w3uQ
         pHe/PF4wj92rA/L53BRq00uMz3YiRGEcLA4q1oPRvzq3qFC0qnsbJ7eP3LVzvacZbLys
         cAaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb7elxxotyFi+Ud+vnjy8SH5ZNqO5h3F6CSoYoRCLpSEgkmdOh2HvyvyGZKJzOXwAht20K/rOiPO1irKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0IEvq4hgo+CfLmSSvl8UHajdqpmiW7emQE53AoKbAcOOiSdW
	qaGVyHdqcvvOGeFovHtn8GOK+LkoE0Vg0HF/lwtZOWJOLCHbOkdz0L82o6vaZYzApVkdVjgElnJ
	ij43jy+8=
X-Gm-Gg: ASbGncuE0vOGd9dljHZup5R6benwfI103hCJ892FNBONvmLlvxxC8th1omMmIfi2iCA
	bYrCohwvjbhrqqMbRilaN1inuZp3EKSH7H9RwLpsbxWfnvotlahSVxJ+PCVGTULAvHqkVXQhSop
	2CMBCQpl5AIZDdzQ2N3qAiKxe3lzVTT/OrHdus3OSsoR9R1Lr/IklB6ilGcsEnFWkUNXyU2bATI
	aQ/eP6nHarKFrFD/j0unHKq5Nqof70GZoP4kLS05GXrPJHInJwUrSYyFydCElgs6q0aAEfXo4zh
	cubgX2zR/Q/BKGihSFD1kN+FzRxIro3dArlqPTiOzRCjih60V5T2ygBZd2wb58sO4ZyZKrUNhYm
	bjtYLcSQ+wLI6aCPK6X79vqcYAzu64jI7DWO6YSJjIyHQeHhCVTeqB133AXv2Wp8Ay5EtgiJJPH
	4=
X-Google-Smtp-Source: AGHT+IF5DOCsFnmXWBk4EFUMe3TaSuHUTrmx8iC4wB7mmSr96ueHoL1IQtk8a+YwSVn8HW8dh3oXUA==
X-Received: by 2002:a05:6830:6687:b0:758:9be6:b5b9 with SMTP id 46e09a7af769-76f81bbd71emr3753044a34.32.1758380741945;
        Sat, 20 Sep 2025 08:05:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d5d22e21sm2630056eaf.0.2025.09.20.08.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 08:05:40 -0700 (PDT)
Message-ID: <5420e895-fcd4-4632-81d3-389c6439afde@baylibre.com>
Date: Sat, 20 Sep 2025 10:05:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: temperature: add support for EMC1812
To: Jonathan Cameron <jic23@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>
 <20250920125144.41f70a1f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920125144.41f70a1f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 6:51 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 15:21:58 +0300
> Marius Cristea <marius.cristea@microchip.com> wrote:
> 

...

>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_CONSEC_ALERT_ADDR, 0x70);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_FILTER_SEL_ADDR, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_HOTTEST_CFG_ADDR, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set beta1 and beta2 compensation parameters */
>> +	for (i = 0; i < ARRAY_SIZE(priv->beta_values); i++) {
>> +		ret = regmap_write(priv->regmap, EMC1812_BETA_CFG_ADDR(i),
>> +				   priv->beta_values[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Set ideality factor for all external channels */
>> +	ret = regmap_write(priv->regmap, EMC1812_EXT1_IDEALITY_FACTOR_ADDR,
> 
> Perhaps a look up table for the registers and a loop?
> 
> 

Also see regmap_multi_reg_write() and regmap_register_patch().


