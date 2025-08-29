Return-Path: <linux-kernel+bounces-791921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E16B3BDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29D93B13BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6F1EBA1E;
	Fri, 29 Aug 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/Wl56v2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413C367
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478050; cv=none; b=p6S1s60lh2hXOS+IBgqcD6BwmZcBR+gzBAxlruLrbvclRrsgTnHIj/7dwO9L8PJqBCOErMzvp83NATCALtU2m4KMP7UzY9NCPPyNKz6eba1i3lsnlnpyXKPooAhAPoHkxnjuqxYrs5WSZG3JP1gZTG/4oauo/FZjyW5Oa+KpqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478050; c=relaxed/simple;
	bh=XKIrrIe9nGe1E0/X50h2LcnP+IV6WWYC8Zg+naL6ieY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUev4o+pOZTmXUgYMdfq8mvHWu314CFFrQiRkSajSCueIcpoqK9P9KXNmnPjyCfO9GVPhWnxccYmPDQW4dqNWzEWZwtbJQPfYUaO2mnQQ8mGK/djwLXwwp5BXoMMMYbljaOWYGaEx+Akbh0rmqtA2XtzJY9XjUHb72UpZsULxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/Wl56v2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so2753542a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756478047; x=1757082847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdRTZcrZww+pyy3+CoQE7C811BJbMEHRMW/x3zTJzwk=;
        b=c/Wl56v21b1RZGHkw1lyLn/iTJ6Hrw4NP+Q+0HI/1C58hgmooURqAAv6GdF4vRI4dS
         ORz9HGveO7hz83uX6NPLTCvtQXYnQGcIaFA3WKBEeXks4W4fbGkboTGtGyFfOr/kwTrX
         qdAu4V53169WHJ2kY1zcFp8IRLOi+wkA/SqoYB/e/2KSx8/TifNEzGdwbbxlC5a43o+g
         pxKD0hSkScPlEqbqYvMzpgEIXAJku7ue091zca4KDBln8S8zqU+BrRDIC7NN/bFf/XWU
         QJfVzdKy88rK0uGoqXe10/8StmonB2u1LudvcwpEs33JSBIsY8wWevR7ED/6vwkx7FTH
         u5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478047; x=1757082847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdRTZcrZww+pyy3+CoQE7C811BJbMEHRMW/x3zTJzwk=;
        b=isvtbqWGZrUT4OB+tQVc4XXlVSPjSrTH88LfhshGpMD3em/W3RfoCYCxjuFYmYojoE
         M6Qg6bCh2yUI2IhXtFPlMPGfeoab2uzsH200feQdLizaxF8ozDXo+U0Gfm5/lPSojITe
         9fHzWoMzmGvw9bBvnA5BPlUpWmZlYPMuZlguhPD6hICG90dpNJembTbRxUu5R7adcbIn
         g3mvVeRqtTis5XNBaM2cJq3hg/ZTYiOY8cwzFKueWkFEETTK2wwSvTCrou847n2qC5sL
         qtcMgJglkSFUxtjptCrw6mxKIFlPQGQwuCXDAta5NZZ9HhiCUlAeyEqOZt7K5oraD6gM
         ufwA==
X-Forwarded-Encrypted: i=1; AJvYcCXlGein+CPLCXZ9MovqgcVgPwAwuq3PRQazvDCLXuWyPQzSP/QHJngg5134XejV4AFiYyeDXQ26J0qDRyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGPDVlU5yPmrQY4dIHT6h/tp8BMbIcaqodJkQi+9nkirWAaREM
	lJRdf6vEkVHx9m+Do5v/v43JmtmM/TRVoeJomzUFjD7q+mQLZ+tqzP0O
X-Gm-Gg: ASbGncscDR+gkhTjhEkUliP9WjjKWb/xYK1/+87gbK+V6j8Z0b/9l0nA0ZZT7ALgOih
	XzEzWlgc/NfPI1ZJdocXWoAvvmOwDyaiyFOdylzyiyiW0W43UJLvdj0fYi+H4cYUwwOct8FGrZa
	Xyms2Z03zZ84OgGCgzshg4oCo9jyQX7AM5vwzAoTdlM8O00ryh+U7BiqqrBtkx4wlce8C41gqe9
	TSV9cIXaGGjioFLUjq8D/Yf0BQBN7g+AYkpg9/pU0tn2spKXNq0hPWNHNYd1oMYBOYoy2snrmuZ
	vxlaWd8g8Uj2VOMQFvCleKUPMcpwUugtHKRF5r3tVeLhjTYzG8CgICRsMP6iMVVLZRoY8DxcOkR
	VMhSOT1IzMRtEU5+uxWOu07QPassgBD3OCTMaIOVFyjX1MLCERctB2OERJTPhl8flOtf6bLh4C3
	YFdiztOSiHnqXKlfzH+7EEZiEAg7wcxhIzheQpml9o9D4fDLscYIeraRHMWPOUfqOE9IM=
X-Google-Smtp-Source: AGHT+IFnI4qIfIyTXxPYEiHj0W+DPBn29+qh0m+qBGjJFk3GexO1LJNC3hqeoodfOeTei1uAARroxw==
X-Received: by 2002:a05:6402:2745:b0:618:1835:24ad with SMTP id 4fb4d7f45d1cf-61c1b449c05mr22852723a12.3.1756478046562;
        Fri, 29 Aug 2025 07:34:06 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:7f20:afeb:8c24:8d02? ([2a02:908:1b0:afe0:7f20:afeb:8c24:8d02])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbc07sm1897283a12.30.2025.08.29.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 07:34:06 -0700 (PDT)
Message-ID: <20ed561b-aba1-432c-9fdc-103e724852d9@gmail.com>
Date: Fri, 29 Aug 2025 16:34:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: gpib: simplify and fix get_data_lines
To: Dave Penkler <dpenkler@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, matchstick@neverthere.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcello.carla@gmx.com
References: <20250827113858.17265-1-osama.abdelkader@gmail.com>
 <aK73HPDKu6rqg9Ya@stanley.mountain> <aK8SGpevZsGM5CCF@egonzo>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <aK8SGpevZsGM5CCF@egonzo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/27/25 4:11 PM, Dave Penkler wrote:
> On Wed, Aug 27, 2025 at 03:16:28PM +0300, Dan Carpenter wrote:
>> On Wed, Aug 27, 2025 at 01:38:57PM +0200, Osama Abdelkader wrote:
>>> The function `get_data_lines()` in gpib_bitbang.c currently reads 8
>>> GPIO descriptors individually and combines them into a byte.
>>> This has two issues:
>>>
>>>   * `gpiod_get_value()` returns an `int` which may be negative on
>>>     error. Assigning it directly into a `u8` may propagate unexpected
>>>     values. Masking ensures only the LSB is used.
>> This part isn't really true any more.
>>
>>>   * The code is repetitive and harder to extend.
>>>
>>> Fix this by introducing a local array of GPIO descriptors and looping
>>> over them, while masking the return value to its least significant bit.
>> There really isn't any need to mask now that we're checking for
>> negatives.
>>
>>> This reduces duplication, makes the code more maintainable, and avoids
>>> possible data corruption from negative `gpiod_get_value()` returns.
>>>
>>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>>> ---
>>> v2:
>>> Just print the gpio pin error and leave the bit as zero
>>> ---
>>>  drivers/staging/gpib/gpio/gpib_bitbang.c | 28 ++++++++++++++----------
>>>  1 file changed, 17 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
>>> index 17884810fd69..f4ca59c007dd 100644
>>> --- a/drivers/staging/gpib/gpio/gpib_bitbang.c
>>> +++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
>>> @@ -1403,17 +1403,23 @@ static void set_data_lines(u8 byte)
>>>  
>>>  static u8 get_data_lines(void)
>>>  {
>>> -	u8 ret;
>>> -
>>> -	ret = gpiod_get_value(D01);
>>> -	ret |= gpiod_get_value(D02) << 1;
>>> -	ret |= gpiod_get_value(D03) << 2;
>>> -	ret |= gpiod_get_value(D04) << 3;
>>> -	ret |= gpiod_get_value(D05) << 4;
>>> -	ret |= gpiod_get_value(D06) << 5;
>>> -	ret |= gpiod_get_value(D07) << 6;
>>> -	ret |= gpiod_get_value(D08) << 7;
>>> -	return ~ret;
>>> +	struct gpio_desc *lines[8] = {
>>> +		D01, D02, D03, D04, D05, D06, D07, D08
>>> +	};
>>> +
>> Delete this blank line.
>>
>>> +	u8 val = 0;
>>> +	int ret, i;
>>> +
>>> +	for (i = 0; i < 8; i++) {
>>> +		ret = gpiod_get_value(lines[i]);
>>> +		if (ret < 0) {
>>> +			pr_err("get GPIO pin %d error: %d\n", i, ret);
>>> +			continue;
>>> +		}
>>> +		val |= (ret & 1) << i;
>> Delete the mask.
>>
>> (I wavered on whether I should comment on the nit picky things I've
>> said in this email, but in the end it was the out of date commit
>> message which pushed me over the edge.  I would have ignored the
>> other things otherwise).
>>
>> regards,
>> dan carpenter
>>
>>
> This patch seems unnecessary.
> The code will never be extended.

But using for loop is more readable than writing 8 similar lines, or?

> In the unlikely case of errors it will produce a huge streams of console spam.
> It negatively impacts performance:  114209 bytes/sec vs 118274 bytes/sec.

We can remove that error message to not impact the performance, but storing errors even unlikely cases
as gpio data is a bug, or?

> regards,
> -Dave

