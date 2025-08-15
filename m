Return-Path: <linux-kernel+bounces-771005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD1B2817A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA06BBA02C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573821ADDB;
	Fri, 15 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1t/HCDyr"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910020766C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267454; cv=none; b=GA/r7M4ibhhK9Vox66nmb9J3B6OTcCdJ1rmm8m5Qb5IXRE/llWznx3O6YiK4gIWHEDRiXAwYuZu4UOeXjVLdNhFY/6Uk4lL5NlBschCKpddya14TgB4GccK43iH/38xf8M1MmFj16eljLSOVCjfMKSI7OilpSxEL3qeB+jBlZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267454; c=relaxed/simple;
	bh=6UqgWiBtru3qNF4cKm5B90nNnc9QwBe82+mGbA/cY9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9Htb0MGQE3x3cOQonevgfoJMu8EOJ3sb4qOqPhgg+QxDmVEicM73lXlJRPm91gSgReWslkh2rwNRkbXqnOLxokMlDmP0/W4SK5HNy5NjMKljyS19TE+pQ0NqLMoiiQrM/oFoNlDSHvElalsUsjN5W9X/a8QBVnxAo0lgXOONx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1t/HCDyr; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cceaaecd8so778185fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755267452; x=1755872252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbhrCfk9RYJnvvsbCToqdaCZcrcBbxt81Ogo6J2bM9c=;
        b=1t/HCDyrSenuVSwVqJ99IIM+83ZU2Mr1tC3lbMlBA8sZtQpzjyS2cct46AI7rGc62d
         htmBjVDDz+eTHlwtW+njCnNka6316YsNzwpG1+xhGH/tDlOc20E/3cntcnM7l4Ve3hCt
         Wsc4AFn7+04u0qVUfwTOBlSPvgZrrj2AaEWzhmKgAWvDaas/22qMSNPeYflmQjC0eMTb
         qGNDQ0pJXz/bShNCYOHG88HlPxVJy+Zij3uG+0RAtmDnzGVo2MFzliOSbJN+CH2Xeho7
         Iq8Td9V3RkslsYrKzh8wDHy87C5J58+PKDcrom9irRF01FczCnzZgbFQUMC9WFhZdvvy
         K3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267452; x=1755872252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbhrCfk9RYJnvvsbCToqdaCZcrcBbxt81Ogo6J2bM9c=;
        b=U5SkHS2AulLGfyyXe2T5cZ8AXQMyyzztMaX7xpqmKVj62mR/DPYJtMpFdqALjonbzl
         G9SJR0vdO05bHN2iGIOXwldwfLOI+p17noRymDbRRGstR21eVa8SLWr8hi/8sz8FdrAN
         /gt6ZswoUIEtrWxpmN3IYCL5zdjeDsfr2KmI42YYo7Z8gFezHQ92TuAxvMES1q8QlumZ
         Uxpzd7e5sIW55ObP+4/OJDkdRzGKrE5U/ZeOgAXHx84X7NTSRgja8bOkp7B/NKZCYuTz
         ViexX8RqJaVUEba4tGwTEpG7TmjLGuPcq3HOjbVVGi9JL1FfHAC5K5HKxSrE4CagUBr4
         6L/g==
X-Forwarded-Encrypted: i=1; AJvYcCXmsvWcLPqthIxEXOemNHyy3iwSNi3YhCi+eqM7L3ImzOEoOp5WGElUjfgw9sDl7yjvxrHntbWz7BriyW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlK8upisZQcDaI2oe1Vah9HmBEhj/Hq9YgW8nPPfClz4/eyprU
	+hEaNks+ckYlBQPO/KS9f5Tg03QVqzdkePa07edSU6ul6TNW0qQNlSfFn3TaDltBUmw=
X-Gm-Gg: ASbGncskS7Ewozz0cu1Bs//n1/zqwAUj8bokfLf41cYb3aGbm4VWAl74oJKFcG8y5ni
	lAhgDlECQwAmUEm5kL3CSaQ63UH4OthrH4fISRP3mlpZWZjxIlXNeWzVprqLDbWGz1LGV2UF1wG
	mYeeZqipukpBTV5cawK5r9HEh89Bv+AP2BRXZUhWkMuSmOWEIwKo0yspqAeLWAU9WWrhiOONLMA
	+sMXtrfTJhNjm95Qjd10VXdFZDwZFLT7BWpl9zl69Y/yrWaqUiAKs3n2Xs4VRfCzQYYgcqj1O8Q
	CUrnB1lwUTpZRNwaQHfwN90wot2VmiLWFIW8AflwHlkpFERz33sb0F0wruG05GS3hY39okG36t9
	0Qmk/GJlx1v533JHSYDjn+OOvjADkA6jbJBaSOECzikAHyz5nXzvf91vlh0w+EOhChKQyXATl
X-Google-Smtp-Source: AGHT+IGjqpkyyKZlM08oY9DimEhkn8JHkSQ1hja/G82yMfhvgu4bjl6P3uoYQK3prUQOBvs9hxEJIQ==
X-Received: by 2002:a05:6870:1c9:b0:300:de55:8fa7 with SMTP id 586e51a60fabf-310aaf82636mr1088519fac.37.1755267451454;
        Fri, 15 Aug 2025 07:17:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abb34f14sm419442fac.20.2025.08.15.07.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:17:30 -0700 (PDT)
Message-ID: <ae976e31-78db-44f7-a3d7-b6178692401e@baylibre.com>
Date: Fri, 15 Aug 2025 09:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
 <014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
 <3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 12:23 AM, Matti Vaittinen wrote:
> On 14/08/2025 18:01, David Lechner wrote:
>> On 8/14/25 3:35 AM, Matti Vaittinen wrote:
>>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
>>> and, based on the data sheets, they seem identical from the software
>>> point-of-view.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>

...

> static const struct iio_chan_spec simple_adc_channels1 {}
> static const struct iio_chan_spec simple_adc_channels2 {}
> static const struct iio_chan_spec simple_adc_channels4 {}
> static const struct iio_chan_spec simple_adc_channels8 {}
> 
> This which should be clear(ish) for developer no matter which of the supported IC(s) were used. But if we stick with the IC based naming, then we should use naming by supported IC.
> 
>>
Even better.

