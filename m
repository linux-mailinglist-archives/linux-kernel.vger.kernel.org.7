Return-Path: <linux-kernel+bounces-820779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0BB7F367
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58AC188BF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF5D32897F;
	Wed, 17 Sep 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JQOJBz4r"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230433C747
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114903; cv=none; b=dOtEbXI4PGW7eWvkuHGkk+1nzCeFTfG6TUwsSEmq5nk42nAy9QJ9RyQoakqFVIntUHQpFaamB7EOda+lPo8VbY+3L1bbXHyDG+zIOq5XEASGjoTrfdhJr/UNpoYJYSy0uv1syi+U1NnKQ6/pu98WsvReQg7TgiO5KOax4GuakkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114903; c=relaxed/simple;
	bh=4VrqzSHnqfIZFSJUMKobQty8aJAljwwTZqC9uLs6RM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao4WenrREDUj3AafUREBv0RlByCSyk33dqneXtB2kyct4U0xX6lWN9fadmLncUl99jGO34PuYyCDl1NYozydeT40S043gwVPUoJHrRbIQ2qYEHPx8FfnnHfaCgJhIsiK3ClqW2j6TnvG3hSKbpvciSHdMe2F3WDXR9VZ5HdiKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JQOJBz4r; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so4457896eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758114900; x=1758719700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Y1CBE/f5s1brH0aS8WGhaIOsO3+43juyj2g7QT7y6s=;
        b=JQOJBz4rSywAXLvP3gYe2BXe22vl0vMlGbw4V35IeUwrXulDPMpFnpenBCdCFDcR4v
         CTXT74sSv17Zb9XB9jSdWwpZCiFed5jYWPQ3Xvn4GeK0wT/Ib8UJuLtsB0DGLVszUyIy
         j2nVhZRbeDF+Zpvgdm8XLac21/Z6BqmeH5UzmM0dJbaMB+9SxXs6bUoh2gUeDNeS8JVW
         b1xVt+V2gxyiIQ5qjtwnMA4vlOudJ/ScTwJiUrOh7/E4CYbIgXkiw0zzOLGKwIOZXoJw
         y8MOCcEA+Zb3Ss6S8wTATnB/s5OgfR8I5XbsHkXLKD7bRBTTFk/v9FaXEvegUNNrQjW6
         EBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114900; x=1758719700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y1CBE/f5s1brH0aS8WGhaIOsO3+43juyj2g7QT7y6s=;
        b=F3N2lw3LfjN1zO6FQ5vLg0cg7PYdHna7LanmRUu7020mMkJiuE6cak9VddvbZVLqa+
         2nn7g4CqbSHN4GlrD9QgO5GklChQRMSaVeCVhh5nAsvWVOGMp88G4H/fZNM47xdow5q/
         I/+p1felNXTylt2xGV9MzKdVGLSS3I5GRGxiuqEoKBIDieVggWoJug/emtR2BQX6c6wp
         QuoPTUGe28ecbNpbAFgPZhqWh6G0Ekp2XB2LVAKEURMgGDaz+q8p1HSs58lVnXZIy55x
         Wuh/GX/brAR58YEvgbrCaWROl8tHvz8wNHXp2RpCz6SODnbt4dEssxOwNSp8XnliKkKA
         fayA==
X-Forwarded-Encrypted: i=1; AJvYcCU3MLeJKYQK+I/DcxXWswuJ2DuR48EH3XXd8be8fBEQuEACU00VzREnn+3bQ7FQDM+7mczTbgcYLru1Kko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWFCQOGig5FXDOcOLsFjUcxMPbkwlhkl+LtDwKgQ452hACEZI
	Jh2uHwETHIlDvbILKG3QFF6YmhWTA9sJyLWZrDOn/zjPixvz1Rdb9u5j9DZyWZEsh48=
X-Gm-Gg: ASbGnct5qYLChhjGgDzPQJimHcUjO3AllHbC1oxNUB5vidr0VL42wUhbhZJ3Vyphh0/
	14Y6r/VNwyi8jMKx3nBxhQ2lGKdwm+ehLcYhcrl26oIakhdIbbgRDpiDaNOQ/vZqyRCr72dix6P
	ulRD46zx+4VY7bxpVyMLqmY83aef5h06vb3grmW9CZn/RzM0pQ9BDXqDmuhK/RXLHAMoVRFWTvk
	Wp9zEN9i0/8kl9QCM8CBYsb9P6HeW8iHiS2uVO3t+bOAEWDJtZIxGnJ3EdSMIqZt1rS8qOOO5AL
	M3h5M3NcJ2L0qqauMbRHKIKw02PKrRfsO5Lylr6YCV7e2BsG3nnf5JGeDr3CUsuxTOPNePWN9Ts
	qClWhF4ihu0o8KiN9j+4bpU1HhRQXI1Nu4YDUGTdRl2trtkVYId+CxpFdH1XeysWflKhpzpSZ
X-Google-Smtp-Source: AGHT+IFhTUt0P3767NPnyQxfn6fx/Ob88p+3+zA2O3pkXJeilzkFlrMeGbkz3MTLc15Ux1O1i1hzXA==
X-Received: by 2002:a05:6808:18a7:b0:438:4117:a863 with SMTP id 5614622812f47-43d50d49258mr767802b6e.39.1758114899762;
        Wed, 17 Sep 2025 06:14:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a72a53sm4260182b6e.16.2025.09.17.06.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:14:59 -0700 (PDT)
Message-ID: <e8734476-2b47-4031-92fe-98b325629408@baylibre.com>
Date: Wed, 17 Sep 2025 08:14:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
 <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 3:10 AM, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 01:04:41PM -0500, David Lechner wrote:
>> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:
> 

...

>>> +	if (ret < 0)
>>> +		ret = 1250000;
>>> +	else
>>> +		ext_vrefin = 1;
>>> +	st->vref_mV = ret / (MICRO / MILLI);
>>
>> Just a style choice here, but in other drivers with similar handling
>> we wrote it like this to avoid the extra if statement:
> 
> I didn't get this. You move from clear if to not-so-clear ternary. How is
> the proposed code better?

I can't say one is better than the other. What I suggested is just
how we've done it other similar other drivers.

> 
>> 	if (ret < 0 && ret != -ENODEV)
>> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
>>
>> 	ext_vrefin = ret != -ENODEV;
>> 	st->vref_mV = ext_vrefin ? ret / 1000 : 1250;
>>
>> Keeping (MICRO / MILLI) instead of 1000 is fine too. There are varying opinions
>> on this.
> 
>> Or we could drop ext_vrefin and have:
> 
> It goes back and force. Can we keep the code as it's in this version?

Sure. Existing code is good enough for me. (And in that case, I
agree that renaming to `use_ext_vrefin` is an improvement.)

> 
>> 	if (ret < 0 && ret != -ENODEV)
>> 		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
>>
>> 	if (ret != -ENODEV) {
>> 		st->vref_mV = ret / 1000;
>>
>> 		/* regmap set bits goes here. */
>> 		... 
>> 	} else {
>> 		st->vref_mV = 1250;
>> 	}
> 

