Return-Path: <linux-kernel+bounces-872180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF90C0F7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 632074F46D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAA3148B3;
	Mon, 27 Oct 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVi8eGW5"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546C31354C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583980; cv=none; b=HmlCPzy/V9EN46M4daHy8Dak2y0vlJCEpMaNbgUEr+3Nv+tT3Qu1+rsW2+xuOazAPxClOxttV2B7hvR5c/FUXvEUjg+CxdjX8ldUOxaTqbDvXYCAZ9hzfLCx/UT2+FbfmdJuhbn0mKKYuf9b26c/5M1ktXMz87tu4fo1jbof3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583980; c=relaxed/simple;
	bh=ez/mIQCI0gAsepx7KDmrGjw1VRoEx13dA304T/Eyp0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1ruiNJSzyrobr8oS9dFzj5yPxG/Os4W7vkykmg461WBccjSD9u96unx1JVtTwALiiOw7vtZYqDkcCNZxJKTZHTr/oEM1tCkFR+I0Z6rSTUjFCLsX2Bmu07ZdugLL1aie5YInJGYVc2lTNdYsDfJBMQgWV9johfa627NQK+fJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVi8eGW5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781206cce18so4867948b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583977; x=1762188777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1UjUmi5Ka+7gfU5ZG8hAL+hkQbUFpTtINYP7f5ILrSk=;
        b=jVi8eGW55EGjyrRsXjvBSfyxC/oQYt7Yj6/g+YsyXkn3KA32KIQlrFnNVarbEqBI3s
         Yx4qQf/bkbAXK1z4QPBiwV8UDOPdwPfsjbIsJZh9egQXn2X5XjhK5foAUzLDDKEtJ5p8
         IJrLrRQSfJTHWIJPhsWxyFj4A3/EiX0qhpiQBSb+qVO+X/63EumKBAWNheMKLiPULTIt
         Z9ADbTY4erHT9TGVeiCK4AU+JEK4dRfILsZclYxw7qVDAR6SYcH2s3lK+DjY1MsLmGYC
         neojcLp6c8ZFgJGOBZmoSsBTevZNq1b7YZ9uEDiW+/zN0VRFK++ccqShGPeAbSWkshYk
         WqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583977; x=1762188777;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UjUmi5Ka+7gfU5ZG8hAL+hkQbUFpTtINYP7f5ILrSk=;
        b=BozxKT1zajB9lIuYsIyeQJ1pdOQzAvkDaixaK5SJFS2YpHZQGkFN78rou60ZBi2mDP
         L1BbTPk+c+G6StXZv4FHP9ztYhfQ7nycM+ikuNrC8XZ2BMku6RGeN/tWqJKTp9HECvRE
         0jg4bZoJGti/0CjULarq0gm+10Xf4bPdF6/EKjkElFhqxPPZqK3quVe4W3daeCyIp2YX
         gyCAVKDvyqPM1PhrIV6LhAcrYz+GzybJqvcso0MAlw1pdQP1icBA1mWk/KUlxQ4dGvCw
         0S5Ktx8/NKyMRddBMEw4drIrTiA6NHhXzK9NWN4ua89hn9Hft+g6rNXp3RY9IQA8hGtX
         c7GA==
X-Forwarded-Encrypted: i=1; AJvYcCVO5IlI9o0NFnplU8gb8NWu1SjuczThXhJsgt80NEZQ6MVjeb99Dc7v+S9puQhfemTENh1bsy9RbOQ6H3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfS9yygE64bbRcBGnmrzY41nnL5SmUWssYLTB/o4VbINx4p9E
	zFcdUttdUn/9xEyVdKsQ+m7tzRbtBDWEOeOmyF2Pianil5NA5OzcFCxt
X-Gm-Gg: ASbGncsWmzsawPhZtfPtbNHuFajoDia/tcu0bQ8t76APBtikwkaRvViJJsUnUmss/vg
	deO40KJ0miMVGWSyfVUHcq0Qvr1inlh+OsLWWwTnj/HLlgYSXJ2uaCJdmm5rxctqgL0MpvXNTwE
	ih3YO84N7dhxXR+265fsT+9dZN1u1McxcgkqMORv548YIvzB2wNyG5GpqeN2LGv1bT+8KEJ9hGB
	pCmw0mNq2ieFJd6awjoJns8GbmKIeH9rn4cnAViEf1IjvooWlF88yG5Sw3U37cAnXur7HU/nQlV
	X3Hgfzr8OIQyHc1LjLxU5Meb7d99bqK7YQzoIKEqpLbx0ejQPFxlUwqwD/qvgyC/S1T8jzCHcN3
	RYJoyVviN7CIajFW4ohwDQCC10+L/aBAbsg129OjyTw27LqrVzcd/5oX9nBgIUqHLKOYLG4QG5+
	qFkHjQfDnxv+GVGwmgaJ3qpcfZgWwZJGpEU4ccAMRKO05loL2jnM+ciXNQ7VI=
X-Google-Smtp-Source: AGHT+IFq+QgzAYa0Pzepb131iFTCn1+g6011G4/2bAwqtv01tirsdxRlxBcZ2qwcf9EHIL7uZdLTBg==
X-Received: by 2002:a05:6a20:430b:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-344de5ddc8cmr202153637.12.1761583977229;
        Mon, 27 Oct 2025 09:52:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm8972989b3a.8.2025.10.27.09.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:52:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <afe3f2e6-703b-4d9f-ae88-99da1321d1fc@roeck-us.net>
Date: Mon, 27 Oct 2025 09:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: Add TSC1641 I2C power monitor driver
To: Igor Reznichenko <igor@reznichenko.net>
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-doc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 skhan@linuxfoundation.org
References: <d3365f32-dc92-4a55-91a1-c4a446558c5a@roeck-us.net>
 <20251027064127.648712-1-igor@reznichenko.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251027064127.648712-1-igor@reznichenko.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 23:41, Igor Reznichenko wrote:
>> In some way this is inconsistent: It accepts a shunt resistor value of, say, 105
>> even though the chip can only accept multiples of 10 uOhm. In situations like this
>> I suggest to expect devicetree values to be accurate and to clamp values entered
>> through sysfs. More on that below.
>>
>>> +	return 0;
>>> +}
>>> +
>>> +static int tsc1641_set_shunt(struct tsc1641_data *data, u32 val)
>>> +{
>>> +	struct regmap *regmap = data->regmap;
>>> +	long rshunt_reg;
>>> +
>>> +	if (tsc1641_validate_shunt(val) < 0)
>>> +		return -EINVAL;
>>> +
>>> +	data->rshunt_uohm = val;
>>> +	data->current_lsb_ua = DIV_ROUND_CLOSEST(TSC1641_VSHUNT_LSB_NVOLT * 1000,
>>> +						 data->rshunt_uohm);
>>> +	/* RSHUNT register LSB is 10uOhm so need to divide further*/
>>> +	rshunt_reg = DIV_ROUND_CLOSEST(data->rshunt_uohm, TSC1641_RSHUNT_LSB_UOHM);
>>
>> This means that all calculations do not use the actual shunt resistor values used
>> by the chip, but an approximation. I would suggest to store and use the actual shunt
>> resistor value instead, not the one entered by the user.
> 
> By "actual shunt" you mean defined in devicetree? Then does it mean disabling
> writing value by user via sysfs and making "shunt_resistor" read-only or leaving it
> writable and clamping to devicetree value, thus discarding the user provided value?
> 

I said "used by the chip", and referred to the value written into TSC1641_RSHUNT_LSB_UOHM.

>> See below - clamping is insufficient for negative values, and it is not clear to me if
>> the limit register is signed or unsigned.
> 
>> Also, the datasheet doesn't say that the limit value would be signed. Did you verify
>> that negative temperature limit values are actually treated as negative values ?
> 
> SUL, SOL, TOL are signed, I verified. The negative limits for current and temperature
> work well based on my testing.
> 

Please add a respective comment into the code.

>> This doesn't work as intended for negative values. regmap doesn't expect to see
>> negative register values and returns an error if trying to write one, so clamping
>> against SHRT_MIN and SHRT_MAX is insufficient. You also need to mask the result
>> against 0xffff.
> 
> I was under impression regmap would handle this masking correctly when defining
> .val_bits = 16. E.g. in regmap.c:973 it selects formatting function for 16bit values.
> I can mask explicitly if it's required.
> It certainly doesn't throw error since negative alerts work as mentioned.
> 

My unit test code bails out on negative values, returning an error from regmap when
trying to write negative values. I had seen that before. Masking the value passed
to regmap with 0xffff solved the problem.

>> Why did you choose lcrit/crit attributes instead of min/max ? If there is only
>> one alert limit, that usually means the first level of alert, not a critical level.
>> Raising an alert does not mean it is a critical alert. Please reconsider.
> 
> I used hwmon/ina2xx.c as a reference. It covers many similar power monitors which
> have single threshold alerts and defines only lcrit/crit. If this is a wrong approach
> I'll change to min/max.

Isn't that great ? You can always find an example for everything in the Linux kernel
if you are looking for it.

Guenter


