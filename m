Return-Path: <linux-kernel+bounces-834116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE74BA3E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879F01C02498
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE932F617B;
	Fri, 26 Sep 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsc19axR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB562AD3E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893630; cv=none; b=bWq1BJuzYxd3ifdPKWVKQ1pD3Q+LvTxQSxE3BkZK9BBaAMAuOUKGoPEHWIvG3TpUnLOomDfz6P4WHnCweHxQXO2QPEUmsJLsAhyw5cteh6kA9vH5uUpUFHkQW+SbcrmG+3HZ4KpdYnqNHQYOKskomUa21QmQ7pfFM0+ZTkvjt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893630; c=relaxed/simple;
	bh=Pt7z3mijaZRcTi2kiJmB2nrbDqeFwtsQxHgY8d/m5jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIch5ffPeWCZ3nJmwM87RiJYwGNdAMKXGYLE/LVmNbCMbF2kTt7fyQv4OEYOCbAfALKMQ/aif21APdRLu9p9N2rN5IJByyMtAZnaC9mk6dwdDnhJb2boxsbPoJcLWRnK6oDyWbKcVadfJDiZnUVZDLdxf/dwuMyVNZ+2zhXigGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsc19axR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26c209802c0so23799645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758893628; x=1759498428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tcqokYsWpz8RiIxAM57uVjrW1cPk6YvKlwakPUCpCAg=;
        b=Jsc19axReYE6jvPAb24yJO2pfdsHPG6FkICIE3KrB5Eyek+NT9ASc0G4sqgLWPYWRG
         hkP9BcDcYJsmCK31MqifXVPzysNDgoCeb1rRyXHnIXVvpkLfo+JR5XjEK4XboWhMpGMG
         eF3iyDvf0ldA1YgLaUVBBLDHuY2SL4WxC7XQiOkoWJolzjAmvgoxTm+L16D1+8EVmZoG
         O8JRe7URqOMrPyGBpZmd2yZd5Yeq9abkRax66ifrHEH69zMZ7O4cKAMeslbC17PRaxWC
         Kgm3eo5DWMchUNXAhD3Fh+7UeGQfE31d1Efk3eFbXptI/iHv36ZMnlnWrVp4AglLjX6i
         zHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893628; x=1759498428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcqokYsWpz8RiIxAM57uVjrW1cPk6YvKlwakPUCpCAg=;
        b=UiQc5GY7vdfGwdytFNlmsxImsvgMUKKL3kMIW3YXbmUvfopnEP2zGbN5xueNVsy74S
         bomT6zDNnElRu9/7yqJs29jUAUcrRF6t6KXDFokxgg5rtslBiL6hwW/tl5Gsy47WKp8V
         66SwROi8Ehc/Du472Rg+ePXuW+CSjuLDWTwQO6Hu4zaLvoP7Vq+A24DmBOIXgbIRHQZZ
         ejZ3exuYwuAHR1HvKB39ntIV9LW2OKNqOZtlebg/vYoqItl20WaUoWhLZBKqEf5uW7fX
         IxMMFLM1jKuk7pk3E0RZK/yHsRKHAWgBTm9SE60hsfZnjsnP2llA6is2wDhIcSpRBMRE
         OcBw==
X-Forwarded-Encrypted: i=1; AJvYcCVlMAXi4AbnRrB1JAXyXB591l1VEJxjTuYAV9/9mfJW3B3tXSInr4UrMyzAyvjFLw1eqpP6GaVgEZ9w0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6U4ilukQNF4T271Wgw9cjOwm4kRrbz7wtJcESXyIIrtaAF2lh
	bTZ+NNywmV/ALF2TTqYtvijayprSYTk12FJy7zjJKIRB3SPTPsdotoMqxoKM9vm4
X-Gm-Gg: ASbGncv1P9hC4m+r11X2s2bDRGzPqQfaeMTqMmNYtOXgPXeKrk7i/6feuNZJMaTufok
	4cG4XqktG7HQL5UfktYHmeS6jkobb/3a4S1JFDgC/7KkKqlHrAz/RYGwSg+Jpl8gGUFs2J7W8qA
	qH4AJ2JtdraVh2ATgUDnVGyJYDQkEe5HEs2H48Q0V7+EE0KcHRwWyKu7Jm0NSmHMccc74lN7FMM
	3YSu0+4umTS93b3fA7BiAz9AQoXFIouCNnZIfNLhV5E0xuTsTESepahoJG8fERnVDLjr46wRSUL
	D2GlAavNo7v3eS9InmRFuzBnuI4B68M5B/swdQ/kDgA6e6maRPqi72JYokP4kCJ5w245kHyoth1
	144wbgz95B7yDYMdFpL9aXIqOMW8j7IGIbNb614Rhulp+RDbP+BXlyUQCU+hQbMdwmFw0Jzc=
X-Google-Smtp-Source: AGHT+IExeqPZAv+oAD3U8/+k8mWznyTMcn8PDjKYGA65NFD29WAscSHSXpn/4Z+X87GhMFIClktq3g==
X-Received: by 2002:a17:903:acf:b0:274:5030:2906 with SMTP id d9443c01a7336-27ed4ab8df8mr81830515ad.46.1758893628254;
        Fri, 26 Sep 2025 06:33:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a339dsm4724097a12.40.2025.09.26.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:33:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3bf744e2-aced-482d-9690-1bb3354aafad@roeck-us.net>
Date: Fri, 26 Sep 2025 06:33:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hwmon: (ctf2301) Add support for CTF2301
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
 <20250916-ctl2301-v1-3-97e7c84f2c47@linux.dev>
 <53f1d5d2-c871-4823-ab13-8c3dfd86dbfe@roeck-us.net>
 <aNXtJ0S5SAMsUwnD@kernel.org>
 <8c6f609e-c086-4b6c-abb5-8d33ec85df47@roeck-us.net>
 <aNaTPE494MMExSBz@troy-wujie14pro-arch>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aNaTPE494MMExSBz@troy-wujie14pro-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 06:21, Troy Mitchell wrote:
> On Thu, Sep 25, 2025 at 08:57:13PM -0700, Guenter Roeck wrote:
>> On 9/25/25 18:32, Troy Mitchell wrote:
>>> Hi Guenter, Thanks for your review.
>>> There are many things to improve in this driver.
>>>
>>> On Wed, Sep 24, 2025 at 08:43:35AM -0700, Guenter Roeck wrote:
>>>> On Tue, Sep 16, 2025 at 12:46:46PM +0800, Troy Mitchell wrote:
>>> [...]
>>>>> diff --git a/drivers/hwmon/ctf2301.c b/drivers/hwmon/ctf2301.c
>>> [...]
>>>>> +
>>>>> +#define CTF2301_LOCAL_TEMP_MSB			0x00
>>>> 	LM90_REG_LOCAL_TEMP
>>>>> +#define CTF2301_RMT_TEMP_MSB			0x01
>>>> 	LM90_REG_REMOTE_TEMPH
>>>>> +#define CTF2301_ALERT_STATUS			0x02
>>>> 	LM90_REG_STATUS
>>>>> +#define CTF2301_GLOBAL_CFG			0x03
>>>> 	LM90_REG_CONFIG1
>>>>> +#define CTF2301_RMT_TEMP_LSB			0x10
>>>> 	LM90_REG_REMOTE_TEMPL
>>>>> +#define CTF2301_LOCAL_TEMP_LSB			0x15
>>>> 	TMP451_REG_LOCAL_TEMPL
>>>>> +#define CTF2301_ALERT_MASK			0x16
>>>> 	TMP461_REG_CHEN
>>>>
>>>> So far this looks like a chip based on LM90 or TMP451/TMP461
>>>> with an added fan controller. I can not immediatey determine
>>>> if it would be better to add the pwm/tach support to the lm90
>>>> driver. Given that the chip (based on registers) does support
>>>> limits, which is not implemented here but essential for a chip
>>>> like this, I would very much prefer adding support for it to the
>>>> lm90 driver if possible.
>>>>
>>>> The public datasheet does not provide register details, making it
>>>> all but impossible to do a real evaluation. Any idea how to get
>>>> a complete datasheet ?
>>> Yeah, more register info at [1].
>>> I've checked the detailed review below,
>>> but I'll hold off on sending v2 until you decide if we really need a new driver.
>>>
>>> Is this chip more like the LM63, by the way?
>>>
>>
>> Good catch. Yes, looks like you are correct. LM63 is an almost perfect match.
>> CTF2301 has a couple of extra registers, mostly local setpoint and temp LSB
>> plus the registers in the 0x3x range. Actually, those registers _are_ defined
>> for LM96163, so that chip is an even closer match.
> Yes, so just to confirm,
> you agree that the development should be done on top of the lm63 driver, right?
> 
Yes.

Thanks,
Guenter


