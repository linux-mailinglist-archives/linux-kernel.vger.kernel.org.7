Return-Path: <linux-kernel+bounces-790791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B48B3AD01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8E7567D92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46A2BE7C0;
	Thu, 28 Aug 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lygXWnWt"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABB7404E;
	Thu, 28 Aug 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417947; cv=none; b=BUhJB1YbTeDLEkso4+qEACumBjgv6KBeEOeZmIbn9N++Z4ZOMRk4gbY9MHZXCE1E+hKyP6xkHgIfh1lBQ4lzDtl5+zWv4S15LUhkpjHjebSih55GaqTDzDn3Hqnc0B9xN7E7KiP19D/AoYN+sc6G/AT/tgVbfQWsReSDuopeN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417947; c=relaxed/simple;
	bh=W/WeEMsj0kEsXGjC4MQcZ4o8AZvufxrrmpNw8TSl5+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn1B3FiqBN1SSZZKZ8PLvgAdZvMHRlVbEIgd1VMt5xZ8T8l7vgufQRSkYGvOeAF9wrwo5ydVcWIPpuE4wYCwhGC6SWClZITrBKpJWjEiq1lhJC3FiGGcswSJcGDv5hC7D6z4FiEigyxwvhYIf8x03gc7s25YLQyuFh0+f3Vn6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lygXWnWt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7721b8214d4so1168430b3a.2;
        Thu, 28 Aug 2025 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756417945; x=1757022745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dV6XS/YvxNWNl1GO5NrzhWyJOeOG6F4gSdyBueTSGKs=;
        b=lygXWnWtfrjXkDb5VVutlKX4CSv19uZ9IKEgnNeLBU566WQEXla3RW42MsBlr7HUC0
         9q9f4WztJDLR7Tm62uGu8E0RUXr1aLu6nImY02jSBAm3YkZ9CpLMbxPuoSbqGB04N3pN
         7DTaLhEdq4K0cU6tcTCV+GSwFIX1mrPFhGTSdPRHXG+xwhJa05dPEk4mU3wfRfI18kaq
         b8w1MJWgWbwL2XUmaqVbaa+Q4EH3Nm5Znr21FL5NV/tC2O0G6P646aWV5xXmkAxYVg7y
         e1g8IgQwsZUk4EbAUESk+cO0nlSTcTYoArPY8Vcn424cn9lENGJPAH8ZXI3lFtzHSTA1
         qDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756417945; x=1757022745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV6XS/YvxNWNl1GO5NrzhWyJOeOG6F4gSdyBueTSGKs=;
        b=eNkL9WJd4BpmdXgczJ6m79O7iC9az6B8XkEtkOt+YXNboonhqHZBlwl7U0i7tHwnq2
         N7ZjcIkJM91ydJI26D9OWd4lVkFdAjuInNegsoa2KMnhbs65DnEEYECnp4Zv2REJtVQf
         A3/gztz1vlsl+xTnMBiePy+sc+kxTXId3LGxRSFumOT7BLVaxnjLGjGQ+h0zZbP9szqv
         Tfc+yvW3UArcg6zz6SuCTxjfMtkt2tEIOzB/3I4YIvUfxkmU/+JkXZDPzWPSB2UsPLHf
         O7dRINilEWCRuK+/qAXdTeSbZH4QMGLWSKSwtl/gM3iuT/fHdlNApWEOdulwLqrDnqB4
         fAug==
X-Forwarded-Encrypted: i=1; AJvYcCUPANeVWOnJeYXVBP8w8BLW3QbM4yTiSQO2DgJmp6FCM6JO/El85H40cv/6/4ozs6aIHdN2RSe0BzVB@vger.kernel.org, AJvYcCWE2xvP+/0oPL/b+abgwKSezloM5jV1mQAcpM639zcG9t0EqUtH3nOOhl5YXlmfDAJi11qnn5GnFB2GOR2M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/nmtcLV0H2e2uO0EWrrUMCFNKhVXRBweqUzHYZLRaB1F3124
	aFseT0mIEFL7zSvzYBjHWhlLS/HlRDDi/44f5Cbd1ush+rs3JL87aaHJ
X-Gm-Gg: ASbGncusir/EIPtp4idiv51sdU3yEvKDBq+ffb8E5VKPz0e3tptk4Uz3EAqX7//CqBf
	gId88V4qG1RsW3Aawljt1fRfquLo1iA/xvLmIeYeNug/XXtdwm0dlsXZy6ZpfITXvADSLkGS3ue
	zUuY5FUhL1KGy6pnWBwoB/u39/0du0DBvAVcZ7BjZ2GhL+wXPoduinFLZGaDs/ZhCxYCNTgLbky
	o8EWUwwyuEN9E/pUuGaqGJKXiaCZE6VLiXuusLEFLn2SZOQ3HWBghvdb+JP4l9audhKMdx+/zhp
	dUr6ouyoF3C2AorgqVw6Bq/PIJw0YLDtF+nBIj8Iu7rdGjK5lP38AxiiGfJoETjW9QGRcZYObhI
	JUWsGgJhd1zv9He+LIHhXRUcUEcE6mCZXfiV5Ly4Swv2kDkWuVpOx5Z1fZJzKPUeXkqAA4eUyMR
	l/+rFK30kN2JyECDDB
X-Google-Smtp-Source: AGHT+IFRRH9qkLwCyXNeElRa9Q7EA7zo2ntdVXtntSTpTdWi9B3EdswTYIjnDDrTpTePM/GNXXDTOg==
X-Received: by 2002:a05:6a20:3d86:b0:243:6f4e:fbab with SMTP id adf61e73a8af0-2436f4efe15mr25221703637.40.1756417945009;
        Thu, 28 Aug 2025 14:52:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32787c455b8sm2706458a91.1.2025.08.28.14.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 14:52:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <af0f9569-6d27-415e-b11d-8a66a9d05c78@roeck-us.net>
Date: Thu, 28 Aug 2025 14:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
 <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
 <d5725c87-ff96-4a25-995a-d4c3cbcc13a9@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <d5725c87-ff96-4a25-995a-d4c3cbcc13a9@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 14:22, Chris Packham wrote:
> 
> On 29/08/2025 00:09, Guenter Roeck wrote:
>> On 8/7/25 20:05, Chris Packham wrote:
>>> Add support for the TI INA780 Digital Power Monitor. The INA780 uses
>>> EZShunt(tm) technology, which means there are fixed LSB conversions for
>>> a number of fields rather than needing to be calibrated.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>
>> Your patch does not apply, and I can't figure out its baseline. Please
>> reparent on top of the current mainline and resubmit.
> Sure no problem. The ina238 changes were done on top of my initial
> ina780 stuff so the sha1 recorded in the patch will be a local sha1 that
> you don't have. I'll clean things up on top of master without any local
> junk.
>>
>> To simplify review, the patch should be split into preparation patches
>> (such as adding .has_shunt and .temp_max options), followed by the actual
>> added chip support.
> Sure.
>>
>> Other (not a complete review):
>>
>> I don't see the value of adding INA780_COL and INA780_CUL defines;
>> those are really the same as the shunt voltage limits. Actually,
>> the current limits _are_ available for existing chips, only they
>> are expressed as voltage limits on the shunt voltages.
> 
> My main motivation was trying to match the terms used in the INA780
> datasheet. INA780 uses COL/CUL, INA238 uses SOVL/SUVL. I can kind of

Yeah, only those change all the time. Just try to match register names
(or pin names, for that matter) for the chips supported by the lm90 driver.
I'd rather just add a note explaining the differences in cases like this one,
where it isn't entirely obvious.

> squint and see how they are similar the INA238 is just more complicated
> because of the external shunt. I did kind of think it must be possible
> to express the INA780 behaviour with some fixed values but my math
> skills failed me.
> 

That is why I ordered those evaluation boards. Forget the math, just look
at the registers. Fortunately the TI evaluation boards are not that expensive.

Guenter


