Return-Path: <linux-kernel+bounces-725617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DFB0018A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E85F7A706B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DEA251792;
	Thu, 10 Jul 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="TVZm5gQx"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE3238C10
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150094; cv=none; b=eqTAzylPmXflXDu2qjG/sehCEi6FhgpSWscQRcEm+lz2vC/ZkkM2vbe8U+PQ7BL/531fW1CA5gi0SipXGeSALpccyCkWoT71dR02LTzU5uiqdZWlbV9AiF5E7Gn/XsJlpCUAb/Y9wEX5tSIMCVBJZawgDSojsEa1qgub48GW+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150094; c=relaxed/simple;
	bh=k0sNT1J2hfShDmZMd5oQVwbeYhLtHhM5ZG7gUd/6Xi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGfPAUpKqcF8ocRxDJFrxGbQrREzLHmJQiL4mbFVM1LDeekfdtoh7hlj0OfaEQdof+tF9BLaWqUmG+J1oW/aG+h3NNyOgJwjQGbwczj5pVC1DYtXlkNbxmNObfwijCaxfhrmvJcPpKUMTwwK32UxIbJLpwHQ65wBMG2EXS6Z+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=TVZm5gQx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d098f7bd77so100241285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752150090; x=1752754890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykmA4VtBEf4m3I9yh9SrcV1DzXur6jCxtcYH7LJI2a0=;
        b=TVZm5gQxrpO8ojdSj9b2qpj/96miCnlP5hdzKOIlCrEmtIVUDCrg6pOFfWr10rkN/7
         u1/FAYp58ehb8jpY1Ox9ZzORmWcUuUeLut7Zurrn22kfVTFxuGLWWtPC/jCaaYNodJU1
         yk15VfY/vUMajOUj7sSP6Khql5FVD/+oQmRdILunMMAH8qPQlWTOGQ1XY5MG/QMc+LyU
         JwIDzq/SYo+4pZ4xiGyBB7+7/24M3t1uR82qqZjAS3PdymLBqXtJsofQmoEs19T3HjIG
         3bjg0rdl4vRnVyv80/UFhWtagPqGSd9Zuimg3PRvlyIS8wkNrGFnSnOmo6PSQ/GjQtq8
         zjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150090; x=1752754890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykmA4VtBEf4m3I9yh9SrcV1DzXur6jCxtcYH7LJI2a0=;
        b=pUKYr0F/SjSK/M3J0Z5T8Lqx/MNZqo8ByVqT2SMmWT/uwhGT5cgG+9LL17MqN8urCU
         q19PSndGoK/y0Es17lRH3auSYeUyPdECBvMB3oYS4LFCOMR4jvTi31ksxZ0jBj+fWmlH
         DAqT+mDqgFRq3MxI7D7Brylygs70Mj2jBJ4HcTr2sEpSorQh4S6IMiDtbdRwveXygTEN
         hoc727FAtgbOQlyDFBDZee6pot58i9G9KeY8cxYOx9KR0DYxra9IXh8vhYxTC0THeZfT
         jTtkUjH1OUHRBA8myngXjtBQCNyGtmTeDhouKG6bcWoxBonDJ2gHR0P0RqpfCDVBScbD
         4PmA==
X-Forwarded-Encrypted: i=1; AJvYcCX4llXg4sK42hVm4nklMv1uzsxPqhvkSOOOZAXPSN4EAXiS7Udl+5AaHFTw8+uGolTydyXh/4OAbwDrRsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8F4TZc1tK12mhBkk+XiQ26Gz3YniEPWXQvRhCzpGwbn7pBWO
	WvnwKXD/Iupua9b7EBTx4G2x8hwQpkIyOpYppHLHYwbj0sOLc+ybfOzlBiwmBQ1xiOw=
X-Gm-Gg: ASbGnctCnnE8hMnkT2tQqYm1pAyCVes9e5H6guqBwCNvy8WGIR/H7FVyJuqOI88jGFj
	DbPMff6jb5Cjxb4ZmL0/q/OI8xzmEIYe+ShnIG8LCbR12XC48VuJ8YSJl/QqItBo+r2uxVxuunA
	hbalu1tFtoso4B+zhEjRaAug67TLwPMeQZ7Yd4n52hYnijyW5RAb2fIJbuEOSRXAMFCXQ53kh7y
	FzuqdYJ0fYwUVhgfKO7I/WXbAk+T9ls9uZll+ZfnTUkVssvL4kkMSRK7GBLZ+HescopUbS9sSlU
	G5flNclMLqj41055RkOb02cwUYHMfcyjz9CLDsqeXhcHFaZ7c0ZZyyBoneXYxduXkM6Truy2yRU
	NkPY8f6/TEhrI+J4DG/Qgj14wDg==
X-Google-Smtp-Source: AGHT+IHAaGLj0dorD8TmmT+oXd6EpUTGrwAVYRSrLza6IYfI1rY0XCuwxUpREHQ/PIg/XOc23Vol9Q==
X-Received: by 2002:a05:620a:4408:b0:7d3:d8c8:1e32 with SMTP id af79cd13be357-7dc977d8fe3mr492098085a.3.1752150089600;
        Thu, 10 Jul 2025 05:21:29 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde8fd479sm90171685a.99.2025.07.10.05.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:21:29 -0700 (PDT)
Message-ID: <f68067fd-328d-496a-8b39-9d0cc6cd05d7@riscstar.com>
Date: Thu, 10 Jul 2025 07:21:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] mfd: simple-mfd-i2c: specify max_register
To: Lee Jones <lee@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mat.jonczyk@o2.pl,
 dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, troymitchell988@gmail.com,
 guodong@riscstar.com, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250702213658.545163-1-elder@riscstar.com>
 <20250702213658.545163-3-elder@riscstar.com>
 <20250710092448.GA1431498@google.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250710092448.GA1431498@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 4:24 AM, Lee Jones wrote:
> On Wed, 02 Jul 2025, Alex Elder wrote:
> 
>> All devices supported by simple MFD use the same 8-bit register
>> 8-bit value regmap configuration.  There is an option available
>> for a device to specify a custom configuration, but no existing
>> device uses it.
>>
>> Rather than specify a "full" regmap configuration to use this
>> option, Lee Jones suggested allowing just the max_register value
>> to be specified in the simple_mfd_data structure.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Suggested-by: Lee Jones <lee@kernel.org>
>> ---
>> v2: - Allow max_register *and* regmap_config to be supplied
>>
>>   drivers/mfd/simple-mfd-i2c.c | 15 ++++++++++++---
>>   drivers/mfd/simple-mfd-i2c.h |  1 +
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
>> index 22159913bea03..3f959f4f98261 100644
>> --- a/drivers/mfd/simple-mfd-i2c.c
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -33,16 +33,25 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
>>   {
>>   	const struct simple_mfd_data *simple_mfd_data;
>>   	const struct regmap_config *regmap_config;
> 
>> +	struct regmap_config config;
> 
> Why do we need another regmap_config?
> 
> Can't we just remove the const and make use of the one above?

If we change the global one, it changes for all users.

In my next version I will modify the global one temporarily and
zero the max_register field again after the devm_regmap_init_i2c()
call.  That doesn't protect against concurrent probes but I don't
think that's a problem.

>>   	struct regmap *regmap;
>>   	int ret;
>>   
>>   	simple_mfd_data = device_get_match_data(&i2c->dev);
>>   
>>   	/* If no regmap_config is specified, use the default 8reg and 8val bits */
>> -	if (!simple_mfd_data || !simple_mfd_data->regmap_config)
>> +	if (simple_mfd_data) {
>> +		if (simple_mfd_data->regmap_config)
>> +			config = *simple_mfd_data->regmap_config;
> 
> 			regmap_config = simple_mfd_data->regmap_config;
> 
>> +		else
>> +			config = regmap_config_8r_8v;
> 
> 			regmap_config = &regmap_config_8r_8v;
>> +
>> +		if (simple_mfd_data->max_register)
>> +			config.max_register = simple_mfd_data->max_register;
>> +		regmap_config = &config;
>> +	} else {
>>   		regmap_config = &regmap_config_8r_8v;
> 
> I suspect we don't need to have this line twice.
> 
> Either re-jig the if () above (I suspect this explains the existing
> complexity [multiple conditions]) or pre-set regmap_config to
> regmap_config_8r_8v and only over-write it if the conditions are met.

Sure, that would work, but it won't be needed if I just use
the (non-const) global config.

Thanks for the review.

					-Alex
		
> 
>> -	else -		regmap_config = simple_mfd_data->regmap_config;
>> +	}
>>   
>>   	regmap = devm_regmap_init_i2c(i2c, regmap_config); if
>>   	(IS_ERR(regmap)) diff --git a/drivers/mfd/simple-mfd-i2c.h
>>   	b/drivers/mfd/simple-mfd-i2c.h index
>>   	7cb2bdd347d97..706b6f53155ff 100644 ---
>>   	a/drivers/mfd/simple-mfd-i2c.h +++
>>   	b/drivers/mfd/simple-mfd-i2c.h @@ -27,6 +27,7 @@ struct
>>   	simple_mfd_data { const struct regmap_config *regmap_config;
>>   	const struct mfd_cell *mfd_cell; size_t mfd_cell_size; +
>>   	unsigned int max_register; };
>>   
>>   #endif /* __MFD_SIMPLE_MFD_I2C_H */ -- 2.45.2
>>
> 


