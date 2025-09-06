Return-Path: <linux-kernel+bounces-804243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356FB46E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E781C2508E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BE2F0C44;
	Sat,  6 Sep 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzVqOoIP"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46A14A0B5;
	Sat,  6 Sep 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165287; cv=none; b=gYq96gtwzo8adWiiSFmU8YZSHpoiZ1b4w/U5xCmcZzZD6YcSyLBs88QmCyvu5QrcVpnPGMYpg4JTcxOl6R6kSpP18NLtHKPw1JGt1tPD7U1jZYgw1jfVT3P0gF0Uw+z3CzeRIbRhOmXO6/K4m7BCcKS3IdKhN9v/tzCrHgmMdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165287; c=relaxed/simple;
	bh=tWWgkxzjjDxrHp+7hWZd5QtL3pvHOBVwSvdOHkvH86k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UjEkg8kyW5oN0MS2LEj/DskPI80dopd5n/EDAdgqes5GzOBTIpRmHVJyQb42bevKx9a1VEknW215d5399Sarw/HCV5cIa27Xm6HTiMvPUreHMYKWlkzjbEjpuOFMdk65eS6XYXqQIENwm1OBJfPjwYW6/w69XxqDyqlL0IQCVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzVqOoIP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-772679eb358so2803936b3a.1;
        Sat, 06 Sep 2025 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757165284; x=1757770084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4lhR8DFhserIpo0K3degliX7Gw6DGQOQ2PCb0uNrjOM=;
        b=kzVqOoIPqiPbfwE6SfiDMqYBsXQroOEGtXVuJHhnz63OM2U1rtN9eaOmckAlvyb7vQ
         FjuXdmoBLuf18DTXJqAv+kCycVuPJKkpJVLDDpUCiRxFUu/bWnSnxFHpNWwbzm+hjvOa
         6UtoyfHSgYUGAAAhXmBp/BgSiRlLWV6ZARRg/1nas5FsS1XOTcvUAUBgDWazEzuRQden
         SBlRjuuab5O2W6LysV7T5lnb3HE2oFpcqSvAV3z9ScQrJ2QPpMHxFmESOtKhFApuAX3f
         u/lEs+fIiuPxBuz/AxA02iG5TvQBXSGcDf7WDhUxWM3zr7Ndc0wizILjUUcFKO8XOpBK
         FOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757165284; x=1757770084;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lhR8DFhserIpo0K3degliX7Gw6DGQOQ2PCb0uNrjOM=;
        b=CWX2XpKbK4WCeh0+Hu2+XUSwHmFWAqWrDrBGyNCopv53pYnMI+5u5nlba48c8ufCZZ
         ZSrIwxpRLD4WS7U27lV2cZwkPCj6IRHmb7ei53cQaitdF5XAN4BxrHvPqDeSCFc8nVLk
         kMuCxsG/OmnAhNFfM8y2PtNkKwl/OmUg5DBQymcDf9ZrZkrX3o4U5evCIkZ25Q+tBSbE
         lV877jMM0EPrThqlWT9KUgi+36vFaMN6QWJTaQ1sIhApLQMWh3ksFMXbZN9ostjmew6f
         VJVcMz42RxSiKybmcUJYH7ad/OVIZUs/6vPwSCu/s2FUkGHi0laQ/ppH8L+5VrPnxVcF
         OgtA==
X-Forwarded-Encrypted: i=1; AJvYcCU2i00fxA7QUyMXqdvtdUFeZ40nXd7ZEH/gD9MRjr0b0R+qdMALNUF/SqVu2JJQlbO3HNSq+ZNl8x8rCg==@vger.kernel.org, AJvYcCVBY5SyDRhplZw1Bh8pKhXdi0zgt0+V2loLQt1UQXgYno/6b8g12D2Pau18FxIsKVYEfcf4fa0XWmRA6Qz5@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdJiZ8P7HmwwumW83d7Y+MZ7VwdmCFqQ+Mq39N7VUE/N4oYYP
	4ATWO461/NF6fWeNGcYBWoaYEWtK99EhafwW/X1xa3mI8Refj2F9Kz34
X-Gm-Gg: ASbGnctj5fhJSQ8joM+NpMnfN07wNQFlXLE2q278zr1GLwhzlSDTrD73tZysc6oJL6w
	eXzaQS1fU+rPjzaFWVwJVL4NatmwK3e5eXdmXpnfWnPzQAXXRCMhjGnxMXz1Vq75qxS3qZUDhqw
	NjTwqnEEfYy2jAYx1qPzZ/KiefmhKKpsQlgsQJqThRvhwo36f2oB2QQNITR5MqitD9aGCEXCwun
	piAZ1iEDi49JB4o0EifF1jNmtuekCQ9aBtPaCWycV6ppUgjQgLF9ojvlEOmoZT2ucTHSTD8Keno
	TB1yfHdy0Us/WCqBXuGgv1BYfNJzt02NVmuX3s5jQtcEHkRIy+FSGn+s+fOZON0CvSSFkTLWKiy
	NQBijNwfy/ra3iANLYUx9mkOM2uMd0z6vf1+epIJ5mT3+wh2jvGF10lpOSHJ4ibdfSTRmEr7i2k
	XaTt+iTg==
X-Google-Smtp-Source: AGHT+IEDj+uNuXSaEPwNs/atNgjZd8fNN5GdmsrDEoufJ3GtdAkZ59ShPEcwtqAhVfSb524ZVSR1/w==
X-Received: by 2002:a05:6a20:7d9f:b0:243:c274:1a7f with SMTP id adf61e73a8af0-25344eb94f3mr3378216637.46.1757165284422;
        Sat, 06 Sep 2025 06:28:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b555b9d83sm11223268a91.17.2025.09.06.06.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 06:28:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b402929-f637-426f-8d18-634a29b95b42@roeck-us.net>
Date: Sat, 6 Sep 2025 06:28:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: sy7636a: add aliases
To: Andreas Kemnade <andreas@kemnade.info>, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250906094308.11129-1-andreas@kemnade.info>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250906094308.11129-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/25 02:43, Andreas Kemnade wrote:
> Add module aliases via module devicetable to have it autoloaded.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/hwmon/sy7636a-hwmon.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
> index ed110884786b4..74ee0e756ffdc 100644
> --- a/drivers/hwmon/sy7636a-hwmon.c
> +++ b/drivers/hwmon/sy7636a-hwmon.c
> @@ -12,6 +12,7 @@
>   #include <linux/hwmon.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/machine.h>
> @@ -94,11 +95,18 @@ static int sy7636a_sensor_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct platform_device_id sy7636a_sensor_idtable[] = {
> +	{ "sy7636a-temperature" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, sy7636a_sensor_idtable);
> +
>   static struct platform_driver sy7636a_sensor_driver = {
>   	.probe = sy7636a_sensor_probe,
>   	.driver = {
>   		.name = "sy7636a-temperature",
>   	},
> +	.id_table = sy7636a_sensor_idtable,
>   };
>   module_platform_driver(sy7636a_sensor_driver);
>   

I would suggest to just add

MODULE_ALIAS("platform:sy7636a-temperature");

instead.

Guenter


