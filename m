Return-Path: <linux-kernel+bounces-788016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2EB37ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10491BA185E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2B343213;
	Wed, 27 Aug 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/IclHca"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765CEEA6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286921; cv=none; b=THT2vHnbThjlkZFEC38/isl8Uy4OnePquMEbAroTCNUPAZQBYt6zVRP2sWpv+PzqbfJW1PRjWr0Cp0t61PmKpHvzbRqUCU7QZS2/cEqE7sz/7n4C3Bs/QpAZ/4ELQ1Zo4RdCqydPEXNH4ZrnDFlKhIo8daWSYw5+31B9NWDpydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286921; c=relaxed/simple;
	bh=u1JT9esYUPh//8vGQAYEOXy1sSFQYIQb0ssbEMuIBNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkZaDHbr+HLo+bEIEiTlmS6pbuJoAjilYIAo/Y3T6fl3R7OhGZ3uyH0l1IXNY2xI6gJuLwSgSWB4s69TTPLv29bOyQuhweOdCTwr40QGna2nlH2ZQE/k7uWKHkEl8L0GVIB4mAmxYvea/68x8AWTFZvYpFJIAg/NR7u91HmBpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/IclHca; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78f5df4so1108583966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756286918; x=1756891718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WNhk1ZhM3W2L38lczRb2sJSYi/8+nhFpxpIIZjaaw4=;
        b=P/IclHcaTBO+twMuqno5qABqPY94dEDsIboSFdB8kOeMahKckJ755sVJiGpZg44SOE
         aX57IMZSDfi58Po9wayhn+l0zCIBa3elzmT17M9G+WcuC0At5Aqt+tBlQ8eOJWv9GZkT
         PpmP3ju9bV4GGXbew8p7qObGDKE2z2mncKVrRXBDYq32A42JYzBOUjp44IKEwNwZav5z
         Qr8Udh37HDtrv78FsjXPvDC1JyTzcSNqEYTjodPBqhWseaTAmzf8PLRXJWGwqEYFmWnY
         h/A/gIrq4mK00TglQ10E4NK6/AROolQhjM0Ill1O4mTi78sbu3yS8FT6x+qItCiNUzB/
         TZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286918; x=1756891718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WNhk1ZhM3W2L38lczRb2sJSYi/8+nhFpxpIIZjaaw4=;
        b=wPysh+8x6pwQAsS85Bm2GecHr+DL1GhYpkwoBsaA/0NDzw3ilJzgsDdFXs6/1AoyhR
         2tXAapPqkWy9Sx9PCiSh+NcjaYsR62IJ+IJX6btBPS6d1244h29cVHZIgK7DRwSSXOWy
         u1ELIZvO0VM5ufGsas/w78aJXtc/vsNWcXMmW0BwJAqTXLpuRshCKdN85aPi9ZqIGhsq
         v1+FG4vCuH49oD0YeWroVCsWbZSgS5RNetgBeS87NMZzicoNRLQAndn+jZb5DopI5nBo
         Ud2DioOUWpCOiwmz4tL26yscklq/3AXShZvQm+tzrDFcZTHOuKcS1vfGfhTDjhyoW53U
         46DA==
X-Forwarded-Encrypted: i=1; AJvYcCVhdwOLPS4mqF8mdIaXe4S0HxcGBXyYtqJKzDlamOivEAwlI19Me+ozDl0eLls2Toketpj9qhPXSzPTkEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZs4jaF6p+AFfsMQ4NjZYx4DPaeXAZxw4r2hLJkMXPInI8wJmz
	3L1Mjwr8xV/A4wHpf1jgMxHx33aT97IzOnibVNgmP3HXEZhIgoq9/ULX
X-Gm-Gg: ASbGncsNKMa30bwqhXF2bRLYC8EObPkrYKA0Ty9As01APHaCzUTJFH52fQYCh95duwK
	SWRZKyiYjXURY+fWK3U1Uoefgh5CQKLMGTkXmW1Z4kR+KSwR0i20gpj5ydOyfMScIxr+pycyl6G
	3VbaMrROrGpyGEYGdhciAsiJD8qj4x5Kn1JUQgN84hvnKkykLOnoWh/RjMsgh/WhiBKhlNsnc5A
	c4R5/pF+173G1QYHLGZOYfHWyR1NAAhVmULHriXNmaC9dx75lZRvEmMaS97tvgFsyxCaU+SdD+T
	Bqls7GVjq/TdJtVj/YP6FI5HFkFzQ69DU6fs4+SL/AVHHlyd8lS2kmf3/RudbvzWq4iTcPOeDMh
	U1YxPudBES3n8GqoRPQQYdD/dyTtxR3Tv39Q9clcFA2nbiqBrWYQ6nO43TJ/t2PwYkd4/ms0MM5
	nLFeJdqsl1fRdx/iZdIdUzLru9Ukb4/ANZRfIcDgEEmG2qKnLZziUbhEZ9
X-Google-Smtp-Source: AGHT+IEiUn0mw0Bd+eWTikezNk1J+BkpH25CzT2HWGH+6VVEhsrZO7sZhbdFaQJFJa9fYRGNuchv1Q==
X-Received: by 2002:a17:907:72c9:b0:afd:d6e0:ee39 with SMTP id a640c23a62f3a-afe295c9153mr1713662666b.50.1756286918192;
        Wed, 27 Aug 2025 02:28:38 -0700 (PDT)
Received: from ?IPV6:2a02:908:1b0:afe0:92e9:ef08:4a92:adcf? ([2a02:908:1b0:afe0:92e9:ef08:4a92:adcf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79b08cfasm684913866b.101.2025.08.27.02.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:28:37 -0700 (PDT)
Message-ID: <f3ab3c2d-2056-4802-aa73-2b0db4c7fc30@gmail.com>
Date: Wed, 27 Aug 2025 11:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: simplify and fix get_data_lines
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, dpenkler@gmail.com,
 matchstick@neverthere.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
References: <20250826220502.210485-1-osama.abdelkader@gmail.com>
 <aK6wlcLBN1HclMpl@stanley.mountain> <aK68qXqStIwBrejF@stanley.mountain>
Content-Language: en-US
From: Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <aK68qXqStIwBrejF@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/27/25 10:07 AM, Dan Carpenter wrote:
> On Wed, Aug 27, 2025 at 10:15:33AM +0300, Dan Carpenter wrote:
>> On Wed, Aug 27, 2025 at 12:05:02AM +0200, Osama Abdelkader wrote:
>>> The function `get_data_lines()` in gpib_bitbang.c currently reads 8
>>> GPIO descriptors individually and combines them into a byte.
>>> This has two issues:
>>>
>>>   * `gpiod_get_value()` returns an `int` which may be negative on
>>>     error. Assigning it directly into a `u8` may propagate unexpected
>>>     values. Masking ensures only the LSB is used.
>> Using the last bit in an error code is not really "error handling"...
>>
>> What you could do instead would be something like:
>>
>> 	int ret;
>>
>> 	for (i = 0; i < 8; i++) {
>> 		ret |= (gpiod_get_value(lines[i]) & 1) << i;
>> 		if (ret < 0) {
>> 			pr_err("something failed\n");
>> 			return -EINVAL;
> I meant to write "return 0;".  It's type u8.
>
> Also that doesn't work.  The masks and shift mess it up.
>
> 	u8 val = 0;
> 	int ret;
>
> 	for (i = 0; i < 8; i++) {
> 		ret = gpiod_get_value(lines[i]);
> 		if (ret < 0) {
> 			pr_err("something failed\n");
> 			continue;
> 		}
> 		val |= ret << i;
> 	}
>
> 	return ~val;

We can change the return type to int and propagate the error, so:

static int get_data_lines(u8 *out)

{

	int val, i;

	u8 ret = 0;

	struct gpio_desc *lines[8] = { D01, D02, D03, D04, D05, D06, D07, D08 };
	for (i = 0; i < 8; i++) { 		val = gpiod_get_value(lines[i]);

		if (val < 0)

			return val; // propagate error

		ret |= (val & 1) << i;

	}

	*out = ~ret; 	return 0;

}

Then in the caller:

u8 data;
if (!get_data_lines(&data))

	priv->rbuf[priv->count++] = data;

or we print the error here, What do you think?

>
> regards,
> dan carpenter
>

