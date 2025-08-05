Return-Path: <linux-kernel+bounces-756470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F1B1B4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE83AB823
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6302A2749CF;
	Tue,  5 Aug 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ7AXG6l"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EA272E71;
	Tue,  5 Aug 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400043; cv=none; b=lOfTgCBBT4XMAiNVrk/GYc66ZHhkKBuxw3JIHO6t8mfX8g1P4KBR96KIYaaTv+EUdfz+7gnWoc66SNbKAtZ5v3r/sUdWnPHwWpCtW03YMJlG/J54nO9qRYDNv5PfnT/AOlXeeF0rnnXMtAgat+nvXLJuuYlVPcDU/UHikop0gYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400043; c=relaxed/simple;
	bh=f2oUCbqKyACDTvfI6aRRJ4397O6cpbDSNgyl63y/SCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6Z0cfgIdqb/Ge5aZRf+VPf/rh7ZdLN1rPJvVIIJEyDDH5a5TW90ZzRbhLGttMzGQtLLOgb9BqDjvoS9mSCza1MYfyGmC7EuV5idEyRrS7Tf3CPCOA8harVED+BvMjw2ru/AQ8t+kTlsPrk0lqUi3V55vu9jh6LtQFtJaw6H/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ7AXG6l; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30babf43ddaso508719fac.3;
        Tue, 05 Aug 2025 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754400041; x=1755004841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BqcyL3J5oVJ03FcYsY7PLN5zR3sKNMIBVpLffwjquzY=;
        b=KJ7AXG6lza1nWDmVCjpWsaZOE1wJACtXqQ2afR3LEeo4ecDXHRhjCXKqtN8GlMZID9
         IY7nG5cmQ2omO/MiOEGlnwFyVZWaoQQ0KbKY2sn6jszsm344tDAa2zdmwqC6SsL+h8rq
         E1s8gmzfY4nZEZcoMtAnw6dc/eFPxB/YM92xjOp4Q86/yCE9HrZZjSU7vkknvJLQMwfZ
         bQ7lnlb1qPIhClpu+QJevx9op75xazUW4Lp3GiIHKBwKtMjujtSeWkK0I4XFgy7bQpok
         qW2+t/iYS2e2hcnAiyURmazAa3pldTuBZDkyV7ovqL8OfD58bZ4TC/Be2ds/27JmqgeO
         ymLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754400041; x=1755004841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqcyL3J5oVJ03FcYsY7PLN5zR3sKNMIBVpLffwjquzY=;
        b=Th+4gtG1mx87SUj2XyFuN3mi1Q7i2SZKP018B3rVyhC8nddee2v47NuAga2GgFxWvD
         o0LxKPjMftZ+iXPsJ8QTfjhZ1ikJZcDhwlXTKJmNwu5QrHu+HRnKP05XrC1M6DZsJbcE
         oie9rPNzEZ7kAZ5h5HotS27fXp+LhGAl3Zg+P5dVh4lGy3fXK+CYjOWV8iiaqCESv49p
         jwGzcWW1bMtbQivKCFeJa+eFHfNiYzEjM5HcuCWLA0NDeYagXRxnx7WNu5sBADkUf6Yk
         eEFOMQpjHXovg4WzOl27OzDwYcHbV2Lu7Jc4fD89628QhCOaYQBZeLqKjJiCYx3wzJYV
         bY8w==
X-Forwarded-Encrypted: i=1; AJvYcCVVrxwIzGg1GZUWKFNn3WLXM3nrRayjytuCiBqIizBblL8ABKsx25Sr3thZ4fPDdCHGk3bGdx4Lq5OKvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuaRM7JwRmCMrBgY6PXOUkhNqTnwCHrJ03YZU6X821dfBgwCr
	HSiNopyeAC3pLEzjRZf+ZKX5zhmgI0Vgg0LVpkGAfFphuYonj9bgBehT
X-Gm-Gg: ASbGncvl9oPrpXYr4z0DRkOztfvnJsAdLVXotUcoOBqPg1OMyv+8aiXqP6TCazJz9Mh
	09+98Wxb3GBSEjgSiBFsFQQWXk/2K7o2qJSbYG2/sJiLmQ1rHaC1aTh7ckr5PkahJckuvoWaf4n
	4huYD6N0G1T/Qi+uzoGarFlhnVMcQYv467qoQB7mEYaYtoRFGJC8BQy5xAreNOQ0+bBc4dveu7H
	YxU7RWAjXFXU5JomAv+ocYhWY1U2e4PlhwuCvsk7mFhVYwoehwzFu/I8J37O1xETcSoqycV55rP
	Uq66Qa7mhL2n6neyh25V43IRRyVLmwEiC0TPA7eA3oDc5GUxpT1BqjyQx4QgXvPwJP44Fows8mY
	K+yxiqD214bc9SBez4ZG88J1jdleffKhiq2PE/iuMMdqdDdjXCQBUqutBGKz320NjQ60dpEo=
X-Google-Smtp-Source: AGHT+IHL0Nn2myh43ahWAHTEYcipf8WoTWBJB634DronUarRuCn4nlQpbMCDdn3DqXPaZ/4g1GGrsQ==
X-Received: by 2002:a05:6871:c110:b0:30b:86ed:a23b with SMTP id 586e51a60fabf-30b86edad7bmr3728815fac.15.1754400040494;
        Tue, 05 Aug 2025 06:20:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741a71dc78asm1624719a34.30.2025.08.05.06.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:20:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d48395d1-627e-48cb-8eae-391cab27a9d9@roeck-us.net>
Date: Tue, 5 Aug 2025 06:20:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: scmi: Enhance error reporting with
 dev_err_probe
To: "a.shimko" <artyom.shimko@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 cristian.marussi@arm.com, jdelvare@suse.com, guenter.roeck@linux.com
References: <20250805125003.12573-1-artyom.shimko@gmail.com>
 <20250805125003.12573-4-artyom.shimko@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250805125003.12573-4-artyom.shimko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/25 05:43, a.shimko wrote:
> From: Artem Shimko <artyom.shimko@gmail.com>
> 
> Replace error returns with dev_err_probe() throughout driver:
> - Add descriptive error messages for all failure cases
> - Include relevant context (sensor IDs, types etc)
> - Standardize error reporting format
> 
> Improved messages include:
> - "No valid sensor info for index %d"
> - "Failed to allocate channel info array"
> - "SCMI protocol ops not initialized"
> 
> Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
> ---
>   drivers/hwmon/scmi-hwmon.c | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index d03174922e65..081502418dfa 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -240,26 +240,36 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   	struct scmi_protocol_handle *ph;
>   
>   	if (!handle)
> -		return -ENODEV;
> +		return dev_err_probe(dev, -ENODEV, "SCMI device handle is NULL\n");

-ENODEV is not supposed to log an error message.

>   
>   	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
> -	if (IS_ERR(sensor_ops))
> -		return PTR_ERR(sensor_ops);
> +	if (IS_ERR_OR_NULL(sensor_ops)) {

This never returns NULL, and AFAIS no other driver checks for it.
Why add this unnecessary check ?

> +		if (IS_ERR(sensor_ops))
> +			return dev_err_probe(dev, PTR_ERR(sensor_ops),
> +					     "SCMI sensor protocol acquisition failed\n");
> +		return dev_err_probe(dev, -EPROTO,
> +				     "SCMI sensor protocol ops structure unexpectedly NULL\n");
> +	}
> +
> +	if (!sensor_ops->info_get || !sensor_ops->count_get)
> +		return dev_err_probe(dev, -ENOENT,
> +				     "SCMI sensor protocol operations are not initialized\n");

It is not this driver's responsibility to validate sensor_ops.

>   
>   	nr_sensors = sensor_ops->count_get(ph);
>   	if (!nr_sensors)
> -		return -EIO;
> +		return dev_err_probe(dev, -EIO, "No sensors found\n");
>   
>   	scmi_sensors = devm_kzalloc(dev, sizeof(*scmi_sensors), GFP_KERNEL);
>   	if (!scmi_sensors)
> -		return -ENOMEM;
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate scmi_sensors structure\n");

-ENOMEM is not supposed to log an error message.

>   
>   	scmi_sensors->ph = ph;
>   
>   	for (i = 0; i < nr_sensors; i++) {
>   		sensor = sensor_ops->info_get(ph, i);
>   		if (!sensor)
> -			return -EINVAL;
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Failed to get sensor info for sensor %d\n", i);
>   
>   		switch (sensor->type) {
>   		case TEMPERATURE_C:
> @@ -285,12 +295,12 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
>   				       GFP_KERNEL);
>   	if (!scmi_hwmon_chan)
> -		return -ENOMEM;
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate channel info array\n");

Same as above.

>   
>   	ptr_scmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*ptr_scmi_ci),
>   				   GFP_KERNEL);
>   	if (!ptr_scmi_ci)
> -		return -ENOMEM;
> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate channel info pointers\n");

Same as above.

>   
>   	scmi_chip_info.info = ptr_scmi_ci;
>   	chip_info = &scmi_chip_info;
> @@ -307,7 +317,8 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   			devm_kcalloc(dev, nr_count[type],
>   				     sizeof(*scmi_sensors->info), GFP_KERNEL);
>   		if (!scmi_sensors->info[type])
> -			return -ENOMEM;
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Failed to allocate sensor info for type %d\n", type);

And again.

>   	}
>   
>   	for (i = nr_sensors - 1; i >= 0 ; i--) {
> @@ -336,7 +347,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   						     scmi_sensors, chip_info,
>   						     NULL);
>   	if (IS_ERR(hwdev))
> -		return PTR_ERR(hwdev);
> +		return dev_err_probe(dev, PTR_ERR(hwdev), "Failed to register hwmon device\n");
>   
>   	for (i = 0; i < nr_count_temp; i++) {
>   		int ret;
> @@ -352,7 +363,9 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>   		ret = scmi_thermal_sensor_register(dev, ph, sensor);
>   		if (ret) {
>   			if (ret == -ENOMEM)
> -				return ret;
> +				return dev_err_probe(dev, ret,
> +						     "Failed to allocate memory for thermal zone\n");
> +
And again.

>   			dev_warn(dev,
>   				 "Thermal zone misconfigured for %s. err=%d\n",
>   				 sensor->name, ret);


