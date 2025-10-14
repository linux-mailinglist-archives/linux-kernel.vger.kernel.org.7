Return-Path: <linux-kernel+bounces-851859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC30ABD7779
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D50994ED7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7B29B8D3;
	Tue, 14 Oct 2025 05:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h935ldeu"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4852F88
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420521; cv=none; b=Wwwx7upy6rqyeI1688XULUBYfNpETOef8yngsp2A9s/0nhKmGHFVAZVa6sKh41viXWoeiLolQoGyzoUh8bMHGaHhUXnGwcaui8WgLMdHFyTZhTogTw3YmGrfuKv5z8zhKb+bLsRiCiFQikPdbh88dlGUQOGHr79IE7/ll7J3ru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420521; c=relaxed/simple;
	bh=LPydwwLuvDYOHl+cfwdXfUpN/GwdGHgG1JPhR3Rdmrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyqwnPUf5hUcxTxOyFJ4i8Yl99/Jq2ErcePwglFBTC8qLAsJiSDsKTbqzTWBtdLT68U0vRwDIDd4JZT/w5PCpLlDYPPRzLLI0knl/OS8Ieeo89OzrtBeaQHS0Cr/5uXJkuGZei3iJACmudqbdS4ICOou49J8XqEDTwL5uvLNxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h935ldeu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso7269362e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760420518; x=1761025318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlTEYK2lG8FrWga2XE6oW2K2KeWj/MOwPkOEHg1zPF8=;
        b=h935ldeu33LU8yqHCcIH+jy6XZMfwRfXgGOD0NVJ4GbOf/7UESrnnEdNQMIwMWJ2kD
         39A/liJFMk12rPRQQzaN8SjfzgQaU/Ykc3HrNa0XYkMSQFN/kmFm8NFO4ybsnsnVJmNu
         Edm6hI4mqIwKg72CJnpqiLNiqsj7tbOpDuC2c2HS0COIbf3iZ8+KgQoV9bOmr3/TCwyc
         HSIQBwTsv20q/51k1lBkEy8jmL1DQW9AH5zAQrNLGqCiLYEPLTZaXR3N7BCoC80ZOlND
         n0zsGMUxKU9JNM4si8vMSKHebzB70HAoUhh3/D0CpvtG45Idlq4SuJCq8+UAFRTnsJs6
         lhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760420518; x=1761025318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlTEYK2lG8FrWga2XE6oW2K2KeWj/MOwPkOEHg1zPF8=;
        b=oyNSLn5HntQxCDj9tTHTRbbWBT1LNOs+6PKAwzj9F1zbf+yqgn4NmB7I0fAbO5gTR2
         l77GtsMs79yMri2uSXaOrG3Zp5T/odyKYfhkCRngra5TPvETI+X+qv49Xjbgqj6s7HsK
         fF4lh1fbz1WXmmMR7Loo6ksZA40/iAXUDdlPFuDAqpUhg6FPuQjOqJ0jtHpdVMpFn5WW
         oakkjhsTyCRZ7rRhL8kO/BkTKy/EUaBRiRd4gPlCy4OxXVWe6ahC0t+NFRMRuGE2JoO3
         eDNCE9hKugWdsnPeY8qY59Er7+ZvVGdoyWfM38gkEfs6xnmxJwoZ4JqkDI45IMt9Wypn
         BIRA==
X-Forwarded-Encrypted: i=1; AJvYcCVf3EhqcYUn1vyuTT+fTdnTzOLGBT6UZJZBPLMqhT6U3o3CVTdzJihq5u+lSdMm+HVDSh6EV2E5U9xxExQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1LOTfnO82CpA+4g8Ai4VlHabCC5FXqaCKr2o6Z+mZIDlx33U
	KIKxNQV/Qxe68wWyUYbTVUsZ0f2a7fx4fXl6OXLuS3qMByCANF4M/6C/
X-Gm-Gg: ASbGncvkn9Ew0H4wcVudHBNeBj8jhgi3IokB/KUQ6s/A3BBXS2ZknNFNH2SwmPFOzze
	dmN30Ga9cS8SUijSn6ZgsWZibnVi4gfpy5GSfeP171pp+35HAnrPc7rvFWYHDZlI2QF/Lt2+SQV
	bJhUy9gfPSEVDx9bWPh/T3YSULIRtxjzdmUUMPTfVQQ/p17eQ1idnCH4GnFIHJcuv8ZgmxzeKV7
	lqyCZm0olKtQBTqOqcpk6BJeOhSVJXZX2XeLY73jmToJMYXWCJiyf7znNOgbQt7F8euiUQNbtfE
	q3YBTYalol/5R3pkcyU3gSg1Osz6hlGii0dIbWlBPC7v2U5MA9tYd9uZNv7IU/vyxawqQhl05kI
	6kFMwgiyII8mNWdjUssdvEaN6xx7mxB9ltbVxyGihoHI8eRSenvUj1y7guwzjkmnKM2wbeP6ccs
	a8sLJ1TLCrUh61Ki68b24mP00=
X-Google-Smtp-Source: AGHT+IH4zxyHQbgMm4QvAweY0h6OP5yIF60vhkFcv3s+/ryacaTZrzwbyJoBXHCVTMwkH2t4VCyn1w==
X-Received: by 2002:ac2:5681:0:b0:55f:6cc3:45a6 with SMTP id 2adb3069b0e04-5905e27c820mr8006424e87.13.1760420517661;
        Mon, 13 Oct 2025 22:41:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f913dsm4874148e87.42.2025.10.13.22.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:41:56 -0700 (PDT)
Message-ID: <5ef55577-b8ae-4c8d-a965-ee356c47c691@gmail.com>
Date: Tue, 14 Oct 2025 08:41:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/13] mfd: bd71828: Support ROHM BD72720
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1759824376.git.mazziesaccount@gmail.com>
 <93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
 <20251009161847.GE2890766@google.com>
 <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
 <20251010150317.07bfdbe8@kemnade.info>
 <d2295506-bf70-4142-8537-0fdf9cb04a30@gmail.com>
 <20251013151900.3e4cc69f@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251013151900.3e4cc69f@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2025 16:19, Andreas Kemnade wrote:
> On Mon, 13 Oct 2025 12:27:33 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Andreas!
>>
>> First of all, thanks for taking a look at this!
>>
>> On 10/10/2025 16:03, Andreas Kemnade wrote:
>>> On Fri, 10 Oct 2025 15:09:07 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>>>> +static int bd72720_get_secondary_regmap(struct i2c_client *i2c,
>>>>>
>>>>> Does this 'secondary' have a specific purpose or a better name?
>>>>
>>>> I am not entirely sure. When I asked this from the designers they just
>>>> told me that they needed more than 255 registers so they added another
>>>> slave address... (I'm not sure what would have been wrong with using a
>>>> page register). So, I assume they just placed stuff that didn't fit in
>>>> first 255 register there. But yeah, it looks like most of the registers
>>>> there are related to the charger. So, perhaps it isn't completely
>>>> misleading to use "charger regmap"? The data-sheet seems to be just
>>>> using "Register map 1" and "Register map 2" in the tables listing these
>>>> registers. I kind of like using something which maps easily to the
>>>> data-sheet, but I really have no strong opinion on this.
>>>
>>> just another idea: What about one regmap with custom functions covering
>>> both these adresses? Maybe that could even be added to the regmap
>>> functionality, maybe with a 0x100 offset for the second range.
>>> That way the rest of the code only needs to real with one regmap
>>> and properly defined registers.
>>
>> Interesting idea.
>>
>> I suppose you mean something like implementing custom remap_read() and
>> regmap_write() - which would practically select the I2C adapter to use
>> based on the register address - and then doing same thing as the
>> regmap_i2c_smbus_i2c_write() / regmap_i2c_smbus_i2c_read() do?
>>
>> I suppose this would mean duplicating the functionality provided by the
>> regmap_i2c_smbus_i2c_write() and the regmap_i2c_smbus_i2c_read(), which
>> are static. It'd also mean we'll lose the 1 to 1 mapping between the
>> register addresses in driver and addresses in the data-sheet. I agree
>> this wouldn't be such a huge thing if we used offset like 0x100 though.
>>
> Well, you could also stack regmaps like ntxec.c is doing (but there
> for some very weird reason). That would avoid duplicating code.

Ah. I suppose you suggest I'd try something like:

/* untested, not compiled, pseudo-code */

struct bd72720_regmaps {
	struct regmap *map1_4b;
	struct regmap *map2_4c;
};

static int regmap_write_wrapper(void *context,
				unsigned int reg, unsigned int val)
{
	struct bd72720_regmaps *maps = context;

	if (reg >= 0x100)
		return regmap_write(maps->map2_4c, reg, val);

	return regmap_write(maps->map1_4b, reg, val);
}

static int regmap_read_wrapper(void *context, unsigned int reg,
				unsigned int *val)
{
	if (reg >= 0x100)
		return regmap_read(maps->map2_4c, reg, val);

	return regmap_read(maps->map1_4b, reg, val);

}

static const struct regmap_config wrapper_map_config {
	.name = 
"Maybe_a_descriptive_name_here_Which_devices_can_use_to_get_this_instead_of_map1_4b",
	...
	.reg_write = regmap_write_wrapper,
	.reg_read = regmap_read_wrapper,
}

probe()
{
	struct bd72720_regmaps *maps;
	struct regmap *the_map_we_use_from_all_the_devices;
...
	maps->map1_4b = devm_regmap_init_i2c(i2c, &bd72720_regmap_4b);
	maps->map2_4c = devm_regmap_init_i2c(i2c2, &bd72720_regmap_4c);

	/* Init wrapper map */
	the_map_we_use_from_all_the_devices = devm_regmap_init(dev,
		NULL, maps, wrapper_map_config);
}

If this works, then I kind of like this. It avoids using the platform 
data and simplifies the regmap getting in the power_supply driver. 
Thanks for the good idea Andreas!

Lee, objections to this?

Yours,
	-- Matti

