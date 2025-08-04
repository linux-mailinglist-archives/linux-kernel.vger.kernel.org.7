Return-Path: <linux-kernel+bounces-755656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D7B1A9FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C111897530
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEF2264D5;
	Mon,  4 Aug 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzHcTOkF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F651DF269;
	Mon,  4 Aug 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754337883; cv=none; b=o88mL4hRbqPyrBT91jXmsC/1ecPXKBlWc08N8vuVXIF6WxxCc4roXQZmCuD/7w5QiHAPLt+gxlqH53t2ZaPpjp9vw/5ZCbo18kSyZjB9idagbLKxU4VVDn/asd/cKGSBqMW/AT2s9LzVqdSVEUS+e5PUAK4sCb8ABC2h7SOX6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754337883; c=relaxed/simple;
	bh=3JnDN78WrfnZWJWtSIV7R9SRd17J/zoR9Ql27uVe750=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSGw2lun0YZsUX0UPxFSf5PL+yHAGrJ7R5bNOgDSs3lGsg8i2hBGJ23YtgrYaptz0JwUhEIWl0NBJ1B4HMmlJKNWQPSXyuCGrsp8aHKpUqaicKhD5EcGxHGCMQspeDt5woAGoR8fKhA3iO7lxzI1dzLhBVWqNEELx0BZh7zgzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzHcTOkF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76be6f0557aso3767391b3a.1;
        Mon, 04 Aug 2025 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754337880; x=1754942680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNURBeCZRtjyUOF4LcRm0B/3/jOgkj+XXz6sErzrek=;
        b=RzHcTOkFSC+cY3FA7PyfFBqucXRrnvkI1v4y/Doua/C1JKUfeFem3Yk95aRnn8Pl/0
         +mGkqTs77yUKKVhMX/BilVuRD3wKX7T4/M9h+3NnT0hKGr0qw7u0l7wNK3W+cE1qAzY2
         XlERRsjfh7C1XR+qfwYbDGig7m7ATmYZYi/12mMRVyBsQ1Tsv4IpqI0b97yb9cDstsph
         NFtZLLzek27lTKpjZDgkOHaNCDCjG83MSqRE8/UuSmnGPMAYw6cvv+M5TUO5fZAOVh5n
         gor/VT4PlW9ruG8Hf3qjAEEypVTxj6FuKy81hWdX+b5ZT5IdZ7h7Kmg+qD2q7kTX5I08
         XYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754337880; x=1754942680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiNURBeCZRtjyUOF4LcRm0B/3/jOgkj+XXz6sErzrek=;
        b=QOsnSyQ5PFMxgMBbqrbTbrTEp0zZ/Pi0voVqaDxdeWFY13kDjrGaogd2FT5CHHNDd4
         MS62nZcrDXoz2NW05V2Ls2JI53z4LmGW1KwpySP7dCWyja0GkHtgc+VdWbPwc7cQ0tOS
         VJYxbFz0xX2cDXOo9Wt98hCPPwAhde0EiCTYnH7T6ZtJwUCmB5GnTtl6f2Cxv7KKeYyg
         zeSuaBHcSiy7VRufqshgJHweBJ8NxvBcW5glA0GEqDJseKEx8HWW5WCVbHynIJ/tBsdR
         qVEVuk15rm916UXhn/U+lKIAh7NkL3HjwHk7V53aeUkCQqTSlYBEedt6BM+RU32aOQ6x
         3BkA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Mvf/6E9hF4nYqIxvQoV/VE6Tznxbx0JnatLxwYaq1XNVX/UKQpuRkaSv1Z0fag8AQYz5fgaQpWMk@vger.kernel.org, AJvYcCVMOVqDbUrQEYrOfdqLrZ0pAIQ5k7welkMZYJhF6w9hM+9CzVKpnIStV1fSAb+Ebpiv/mmkitpCRTMBiuE=@vger.kernel.org, AJvYcCWHQzaP3FzevXYv8qWYe1q9NFkQNwakiL0F7WLHsyLuGLVHqw7+zym28ehmRy5wVSs/+9wlVqM1sUGJ@vger.kernel.org, AJvYcCWM+L3BRebkhVS97Nv2vyw6u+ZwoiXffMxzUfxwbzDB28ycJUS1giEO5JU1dSGo5CS+xPZmPpAWkzPA8PNo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/UKLXeX7zu74hba1R2Jub5mqVTG0PFglCsjsJHKe2rTh1U3t
	SLJDIgzTIlXAi3sKZKIOoy3Yx6P6d0QHqnbFQuufEJmN8PdwprvEIuou
X-Gm-Gg: ASbGncuJ4wCAkynWVirUs1QRBYd+Jq+xIANQMM6RLm7IS8cajYUJe11b10PsrWlrFuN
	w4ohk0q4Fuxo1hwSVEEhl5DZgbOJn6eoHQeG7+LO8/kD5PHXlMpU2QOZvS1nDJcxXN2m/OXAyVG
	4Cb71r9oGf38I6Ru07GCwB0rV/m30FV3ELUh5TYdMBneO73Ad2qKNa/EfbQ2Cu/SH5EGcasKi80
	14lfgAUlf//7uiVyGGJ1eL/aTPw9jNTpktW+/vs1fEWcbb0aLmQsl8fmDICTagm/tlE82NZyQIt
	I0n35tteUVueo/Sb4SMGjIkPmTh1B9ch8NQNJZDgSp+jpUwoYRtb1SP/ZLj9EKOxTZ3sZqbUnOK
	MN4eO0zhpATXjnZVVSquZw1uEQH0wTmCj/yxH2PdGs6bzk+f1keGSzuXsVgBngKDjulMXPKM=
X-Google-Smtp-Source: AGHT+IH//JQtMHwA4N4hGM4nrXBP60Uld/nm+3iZkbP/di+mf6/ZQfZ8q+Q3IC2oGGytuewUCbu/Sw==
X-Received: by 2002:a05:6a20:a11f:b0:240:75c:6f40 with SMTP id adf61e73a8af0-240075c7f41mr9526027637.14.1754337880107;
        Mon, 04 Aug 2025 13:04:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfc270514sm4451375b3a.12.2025.08.04.13.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 13:04:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <65d6635c-dc16-4462-96f7-9b82c49f5673@roeck-us.net>
Date: Mon, 4 Aug 2025 13:04:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (pmbus/adm1275) add sq24905c support
To: ChiShih Tsai <tomtsai764@gmail.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, t630619@gmail.com
References: <20250804124806.540-1-tomtsai764@gmail.com>
 <20250804124806.540-3-tomtsai764@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250804124806.540-3-tomtsai764@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/25 05:48, ChiShih Tsai wrote:
> Add support for sq24905c which is similar to adm1275 and other chips
> of the series.
> 
> Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
> ---
>   Documentation/hwmon/adm1275.rst | 24 ++++++++++++++++--------
>   drivers/hwmon/pmbus/Kconfig     |  5 +++--
>   drivers/hwmon/pmbus/adm1275.c   | 27 +++++++++++++++++++--------
>   3 files changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/hwmon/adm1275.rst b/Documentation/hwmon/adm1275.rst
> index 57bd7a850558..914f009f34e0 100644
> --- a/Documentation/hwmon/adm1275.rst
> +++ b/Documentation/hwmon/adm1275.rst
> @@ -67,6 +67,14 @@ Supported chips:
>   
>       Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
>   
> +  * Silergy SQ24905C
> +
> +    Prefix: 'sq24905c'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://www.silergy.com/download/downloadFile?id=5669&type=product&ftype=note
> +
>   Author: Guenter Roeck <linux@roeck-us.net>
>   
>   
> @@ -74,14 +82,14 @@ Description
>   -----------
>   
>   This driver supports hardware monitoring for Analog Devices ADM1075, ADM1272,
> -ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, and ADM1294 Hot-Swap
> -Controller and Digital Power Monitors.
> +ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, ADM1294, and SQ24905C
> +Hot-Swap Controller and Digital Power Monitors.
>   
> -ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, and
> -ADM1294 are hot-swap controllers that allow a circuit board to be removed from
> -or inserted into a live backplane. They also feature current and voltage
> -readback via an integrated 12 bit analog-to-digital converter (ADC), accessed
> -using a PMBus interface.
> +ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293,
> +ADM1294 and SQ24905C are hot-swap controllers that allow a circuit board to be
> +removed from or inserted into a live backplane. They also feature current and
> +voltage readback via an integrated 12 bit analog-to-digital converter (ADC),
> +accessed using a PMBus interface.
>   
>   The driver is a client driver to the core PMBus driver. Please see
>   Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> @@ -160,5 +168,5 @@ temp1_highest		Highest observed temperature.
>   temp1_reset_history	Write any value to reset history.
>   
>   			Temperature attributes are supported on ADM1272,
> -			ADM1273, ADM1278, and ADM1281.
> +			ADM1273, ADM1278, ADM1281 and SQ24905C.
>   ======================= =======================================================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 55e492452ce8..7485bc6b2e8a 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -51,8 +51,9 @@ config SENSORS_ADM1275
>   	tristate "Analog Devices ADM1275 and compatibles"
>   	help
>   	  If you say yes here you get hardware monitoring support for Analog
> -	  Devices ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281,
> -	  ADM1293, and ADM1294 Hot-Swap Controller and Digital Power Monitors.
> +	  Devices ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278,
> +	  ADM1281, ADM1293, ADM1294 and SQ24905C Hot-Swap Controller and
> +	  Digital Power Monitors.
>   
>   	  This driver can also be built as a module. If so, the module will
>   	  be called adm1275.
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 7d175baa5de2..1c032aaac379 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -18,7 +18,8 @@
>   #include <linux/log2.h>
>   #include "pmbus.h"
>   
> -enum chips { adm1075, adm1272, adm1273, adm1275, adm1276, adm1278, adm1281, adm1293, adm1294 };
> +enum chips { adm1075, adm1272, adm1273, adm1275, adm1276, adm1278, adm1281,
> +	 adm1293, adm1294, sq24905c };
>   
>   #define ADM1275_MFR_STATUS_IOUT_WARN2	BIT(0)
>   #define ADM1293_MFR_STATUS_VAUX_UV_WARN	BIT(5)
> @@ -486,6 +487,7 @@ static const struct i2c_device_id adm1275_id[] = {
>   	{ "adm1281", adm1281 },
>   	{ "adm1293", adm1293 },
>   	{ "adm1294", adm1294 },
> +	{ "MC09C", sq24905c },

mc09c (lower case). But how did you test this ? This seems to be intended to match
PMBUS_MFR_MODEL, but it is not the ID suggested in devicetree properties
(silergy,sq24905c). It seems to me that the match code in the probe function needs
to be modified to handle situations where PMBUS_MFR_MODEL does not match the
device id.

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, adm1275_id);
> @@ -533,8 +535,10 @@ static int adm1275_probe(struct i2c_client *client)
>   		return ret;
>   	}
>   	if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
> -		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
> -		return -ENODEV;
> +		if (ret != 2 || strncmp(block_buffer, "SY", 2)) {
> +			dev_err(&client->dev, "Unsupported Manufacturer ID\n");
> +			return -ENODEV;
> +		}

Combine to a single if statement.

	if ((ret != 3 || strncmp(block_buffer, "ADI", 3)) &&
	    (ret != 2 || strncmp(block_buffer, "SY", 2))) {
		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
		return -ENODEV;
	}


>   	}
>   
>   	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, block_buffer);
> @@ -558,7 +562,8 @@ static int adm1275_probe(struct i2c_client *client)
>   
>   	if (mid->driver_data == adm1272 || mid->driver_data == adm1273 ||
>   	    mid->driver_data == adm1278 || mid->driver_data == adm1281 ||
> -	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
> +	    mid->driver_data == adm1293 || mid->driver_data == adm1294 ||
> +	    mid->driver_data == sq24905c)
>   		config_read_fn = i2c_smbus_read_word_data;
>   	else
>   		config_read_fn = i2c_smbus_read_byte_data;
> @@ -708,6 +713,7 @@ static int adm1275_probe(struct i2c_client *client)
>   		break;
>   	case adm1278:
>   	case adm1281:
> +	case sq24905c:

That suggests compatibility to ADM1278 and ADM1281, not ADM1275.
That should be mentioned in the description.

>   		data->have_vout = true;
>   		data->have_pin_max = true;
>   		data->have_temp_max = true;
> @@ -786,9 +792,12 @@ static int adm1275_probe(struct i2c_client *client)
>   		return -ENODEV;
>   	}
>   
> -	if (data->have_power_sampling &&
> +	if ((data->have_power_sampling &&
>   	    of_property_read_u32(client->dev.of_node,
> -				 "adi,power-sample-average", &avg) == 0) {
> +				 "adi,power-sample-average", &avg) == 0) ||
> +	    (data->have_power_sampling &&
> +	    of_property_read_u32(client->dev.of_node,
> +				 "silergy,power-sample-average", &avg) == 0)) {

Checking for have_power_sampling twice just makes the code unnecessarily complex.

Also, if it is really even acceptable to have two properties for the same
function, there will need to be a validation to ensure that only the
"correct" one, based on the chip type, is used.

>   		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
>   		    BIT(__fls(avg)) != avg) {
>   			dev_err(&client->dev,
> @@ -804,8 +813,10 @@ static int adm1275_probe(struct i2c_client *client)
>   		}
>   	}
>   
> -	if (of_property_read_u32(client->dev.of_node,
> -				"adi,volt-curr-sample-average", &avg) == 0) {
> +	if ((of_property_read_u32(client->dev.of_node,
> +				"adi,volt-curr-sample-average", &avg) == 0) ||
> +	    (of_property_read_u32(client->dev.of_node,
> +				"silergy,volt-curr-sample-average", &avg) == 0)) {
>   		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
>   		    BIT(__fls(avg)) != avg) {
>   			dev_err(&client->dev,


