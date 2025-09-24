Return-Path: <linux-kernel+bounces-831265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6766B9C3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F3E7AF0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05C283FEF;
	Wed, 24 Sep 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baXsumoO"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74827E7EC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748022; cv=none; b=etsFpekGNLHTcGjsZG0hP4JKMgbpXqfcT7kL4V3g7T7+3ElXVNuIEkIotE+EZgZtZLAXoNdPEiqn/Zbt3zPWVsDbzj+Y/3Y+EeQS1I0G8BBj9ZxO4ujPdUhYJemfTHwTffMbE8rC4o2UIPMEvs+aNM+O3JpVVfh2eDC5MJkvws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748022; c=relaxed/simple;
	bh=fWTMi3+euibnnqUJrVC9kod8rgCZgxCRr8C9SyyPuNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dtdpo5aU/JcAbp6m/kAXrdr0rpUqFK99DQvBM3gPS8tEKU8nQ8lywfkh20lB0oeprycZ3O3sm+04W6gBjRe32VQr6g+nLUHlPM6eH4PP2uDFv9QTExj/jZ8kyVJzgo2RAvQmRtOUt4RUVVLEzrs/g3j1eGNcjIR4UbUKzfGhI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baXsumoO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso1179533a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748019; x=1759352819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JI9xpslBxstQZ9wuc180aMmQ2ZixsujiLXaQMOgp6Xo=;
        b=baXsumoOifVEVK4BG+rE+w1tW5La+xIy2SkMXQogXO0vOMFN9GYbgGeDdJZY5qLGM1
         z4jK2hoyRUEiXwbI+BjKqDIa2MKFxz9QVi8WaUzD6W5Sfb65C6h53Ftvh98qMXC5fLha
         sev0EKNTeKEOAiaL43p2unUDTBUtE2tyTeN0K4aWAfdRlkXsq+xHqt4yA0e8Tv25nwTn
         unaPGG2xcx2PgSAt3X52Ob2vizkljT26qii7tWNpriHAqWZ5SkqJDHh9Mmv+88IG8P9Q
         QgajFUgKpSRL0rElm2anJlq5oKXttZjKNUkqdfHk5NoBkOH0p8aKi2bmmAnN0bUSJI/K
         OFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748019; x=1759352819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI9xpslBxstQZ9wuc180aMmQ2ZixsujiLXaQMOgp6Xo=;
        b=n1LoZ0sIi/vxzGIWLF9ivxxCl4hG7kYi+Uu6b2+Qkod4pmyv5uggTzza5mMfexDcQN
         9/JlEkznC/XzmZClVrEChNVN23sbadiZf5Q3SBM2ckGX0XJem+rErligL5qkGXEt/4JE
         sVPaE00ct5ObSX7ebwrcxRpnbAW4PDQkkajf6Jz9i9lj4KPNjI6SDdGq60duLzwldcaZ
         D3JEP2+iP+z8MZ5dYKguo+2v/6XoJuErhzMhTNklsfEGDmktXNFVjVYEGjXScBw8kdGm
         qXcQlmPZrVq8XBVtYv3gAyeq4Bs9mt7jwoSLqe4GRpKkyqhCzrn9S78GERYBVD0llvY/
         gaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkx/efugKbUiwzBGdIqP8Q4o9EPkFv1YzlHf4sSTHlx8hWCfzF9yjzl7uSuTRS5u59H3fuwsP4qwXfob0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPg9gx/MBdVdndlPCSrfcKxQ5NjrOQcBmYgeo9QrsTg1ya9U+
	VF3OAtzW1ppdXGZ8mz9bTSXhuLokhzatQkbKuk1/AJGLjIyUvuk5D08O
X-Gm-Gg: ASbGncsdQUpNvA2kjeTCQFxOti6GVJLpq+Gy4uVF1KW9RKnAA7SiF0tKtPYs3knsHqX
	6uDw26+pwxF8W51Zof83/niiNNwtKRW0peq7wvaTRiRE0NDIpDdqqA4eIeR6Hzkb4s9/gBEQeCU
	oUte5ibJnBQgHfrFUoZWx6VSfqXGDitzFuAcCAw+mGZ65WJPqwM0Y37oAsDkxnc6xGcP5kYxfAl
	pSRQuljWeM1Z5QV/gtUUepuvl26nB4lxgeHLbvDA2cAHwpXd1wCd0g9nzj7vMB6ry8k0kbpE++r
	tTSnf9XLzgBkOpqWXydisUppKv0gakUfU0xszq9eACRvsx1F79EI5v+qQUlILUsqfVtsrDWpoUo
	VgKswIZp/wBXwzYyfZs4sXuIkYGdkIKp4FszQmCkvOILQkerdicwBbRXoUwZTpKl2iN/RRcI=
X-Google-Smtp-Source: AGHT+IF/kFqaeulQbMV8VrbB7BPcJZb0NjNLiLcMZzp3ihjMiV71sNegKdVqrcFHijT2LC3hQK5HMQ==
X-Received: by 2002:a17:902:db03:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-27ed6beb88bmr3081035ad.10.1758748018983;
        Wed, 24 Sep 2025 14:06:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm1680015ad.138.2025.09.24.14.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 14:06:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <00685721-8f34-4ad2-9452-5447eafb23b8@roeck-us.net>
Date: Wed, 24 Sep 2025 14:06:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (sy7636a) enable regulator only if needed
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alistair Francis <alistair@alistair23.me>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-3-andreas@kemnade.info>
 <25ef8eef-a4e6-436b-87cd-c77506b4b215@roeck-us.net>
 <20250924224035.2b20459a@kemnade.info>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250924224035.2b20459a@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 13:40, Andreas Kemnade wrote:
> On Wed, 24 Sep 2025 09:06:15 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On Sat, Sep 20, 2025 at 01:43:11PM +0200, Andreas Kemnade wrote:
>>> Avoid having all the regulators in the SY7636A enabled all the time
>>> to significantly reduce current consumption. In pratical scenarios,
>>> the regulators are only needed when a refresh is done on the epaper
>>> display powered by the SY7636A. This is can save around 10mA which
>>> is much for this kind of devices.
>>> Also fixes the asymmetrical single enable call.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>   drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
>>>   1 file changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
>>> index e83d0e50c735..0fda69bea3b4 100644
>>> --- a/drivers/hwmon/sy7636a-hwmon.c
>>> +++ b/drivers/hwmon/sy7636a-hwmon.c
>>> @@ -18,14 +18,26 @@
>>>   
>>>   #include <linux/mfd/sy7636a.h>
>>>   
>>> +struct sy7636a_hwmon_data {
>>> +	struct regmap *regmap;
>>> +	struct regulator *regulator;
>>> +};
>>> +
>>> +
>>>   static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
>>>   			u32 attr, int channel, long *temp)
>>>   {
>>> -	struct regmap *regmap = dev_get_drvdata(dev);
>>> +	struct sy7636a_hwmon_data *drvdata = dev_get_drvdata(dev);
>>>   	int ret, reg_val;
>>>   
>>> -	ret = regmap_read(regmap,
>>> +	ret = regulator_enable(drvdata->regulator);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = regmap_read(drvdata->regmap,
>>>   			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);
>>
>> Does that really work without delay ? Usually it takes some time for a chip
>> to return useful data after its power supply has been enabled. calls
>>
> Hmm, enabling the onoff bit behind the regulator is just needed to turn
> ADC on here. But there is also the power good wait which should usually be enough.
> Usually... But there is no guarantee. So yes, better wait for one adc aquisition.
> 

Would that be the power good timeout (50ms) ? The conversion time on top if that
is not much, but the power good wait is a long time. That strongly suggests that
this should be made optional. Not everyone might like the additional delay for
each temperature reading.

Guenter


