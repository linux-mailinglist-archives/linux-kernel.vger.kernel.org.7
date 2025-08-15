Return-Path: <linux-kernel+bounces-771002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A56B2816C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8EA3B87A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB020299B;
	Fri, 15 Aug 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L4Em8DIT"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F121219A71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267390; cv=none; b=o+cDgkxcYg/ZB3HQ+Lv10FPKS16S0NHEr/M1ZYlx4AIcfsjfhUc/kihOjN4YijesCiztxCZ5hf107Kdc5xJdMDPpMZu6t0h+oXoQJZecFEj3r7L6jxXRGkEcoHGXsryXAVLnAManQXEUS69jGHO3MN6UTW1eKfZQdoJ0kA1AL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267390; c=relaxed/simple;
	bh=KOhlSg0qcYg9ob3Mm7f2krs+0oUtcXnKHGyVvRFd7qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FI4t/zZaTypBQlpNwzsyeniHoU6AtNTvh66Iceew41FyLqMYccKi57Olf83u46Sjif8FDWBd5TARbmhTnQQtnugePudTuRjTYRDmPXkdkl3S8UoLZgwVc59mkz5q2wf3mZmK4u4SylzT6uaRfrWbcqZ6enBJ9UXbigWEzSQ9FHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L4Em8DIT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381e207a0so1165401a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755267387; x=1755872187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+dzZAqMWMrU9JQ+HnPQcZbDejbmWGfSuQd14G8BjoE=;
        b=L4Em8DITgSwkQaL2gneAQwGvbYpPWWUKhAmzj8MnnTVT/ewnqtdk/KVoLzoCjaLsuo
         Z1iVBXVHARtmuCP7RsKOYODxBWenZwwdMKJ+WbTnI4cUg4T067WJiVfMNGDdjtu7HrpH
         unVuTuImmmuod3GEXDdCLL7+nuWxdHaiSO84rs8i8sGiWRJSajnR8W8ORMe8K4BaYIqX
         3ilgJxEwREfO5MRFdXVkQAVOA25o5IW+uM8Fwui4JETnB1nVecPOExzpwlfu+E2xwZ4A
         vVfiuKY2K0F3VWl6islCSTJENFECRhZ6pHYnK8HC71AwiRHnnr8wzGWGBXjM5A6et6b7
         ktCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267387; x=1755872187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+dzZAqMWMrU9JQ+HnPQcZbDejbmWGfSuQd14G8BjoE=;
        b=msp6C4+rO5JNF5eOhKTNuKTNFWXBoTURNbbGrlJUFjZQVx7CR+Hi3iCGLjDLKid1sg
         bhgNoY+dnQPv1+ehYaq+ZR+oJFNdeQEbmZ5rfvblEx40pUOM//dKyWYQerHGA4KqI5FR
         kPTYKqkqi4F7bZD09a3vWCbmG6okpj8tC3qvOxngQKBnfmuldiXaRXWmsuzbY3vZ8TV5
         98Fd0gGliiQjoGBW6EetxvE8WVIQkxI3Cp7II/DOiOB/MUyty8E2vkVH2Rp4bgyjI3tq
         m2+e+yyO1qH4XTaHoV1IEy23GmzUVZqiyYQ3RhC7jyoutR5DOzP3OY4yT30sTBYw02Yq
         Ehpg==
X-Forwarded-Encrypted: i=1; AJvYcCWG7IvaeZEQQll4W1/kDBaK/X/B0r/Jd3ZRYrVWBvi4Ytgr0toZi7eMw1E6BoVRWcV0MZKA2ZDsWaYAm2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmxKzKURpwI+aJuhBp1atXUPBJQzyufqS40Bsox07ffVD5OMj
	WPwdxyprzy9MOp4GLtK2KkbscMoVQ605/XFrFbjbdb3pmMu+37Xj/hXDC0ODTMQLr6U=
X-Gm-Gg: ASbGncumd6S+/oeLW+RaZdN2MHYr81ikaAejluthr1DcY7WZNkrzOO2VGHMF9tIpbl6
	Eo7HV9hbuITzcaV/C6fXvS6OIsXpBpUwwLkvVH59IHmaRwq1XQgoqchJWPYtmZf7+lqkGUx8Ol4
	lw7lk9FFmAAmUwKenR637jwuQyHyA1Unk9DgMYyQUcsRB3KKPteSFYozDgL4/VFqdcwZltE7JN0
	JAuqeBPedewyi6k7xXS4eY2Uk2hAKTtfE4eCPFg35ASvsPodv0ACFNlUmq7s9C5cpivTGLz3OJY
	9BJFhjLBkX4nnfzWEtGL+KcBnoPZjwlLsRjudg4nymgHpVPzSlJ/3KhFsYslByax9H4dZhM/OsE
	wOQw0bh90lk4z25ZLRrMGdPQpFQdsPAakItYbGO7m4E4P5N2kbpJzoKoRq3zUXeb2it2E65mS
X-Google-Smtp-Source: AGHT+IHUesJ2V4GKpXl067F97odMOMFwnwY0zqEdIAx4kIEiR13a/+37EIRwtokkyj02SDIkZXFr9Q==
X-Received: by 2002:a05:6830:6585:b0:741:9b10:5f80 with SMTP id 46e09a7af769-743923abd24mr1135235a34.7.1755267387266;
        Fri, 15 Aug 2025 07:16:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d28dsm318773a34.35.2025.08.15.07.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:16:26 -0700 (PDT)
Message-ID: <384f56af-efb3-412b-9874-4d422fe2ac8c@baylibre.com>
Date: Fri, 15 Aug 2025 09:16:24 -0500
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
Content-Transfer-Encoding: 8bit

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
>>> ---
>>
>> One small suggestion. With that:
>>
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>
>>> ---
>>>   drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
>>>   1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>>> index 81153253529e..2f2ed438cf4e 100644
>>> --- a/drivers/iio/adc/ti-adc128s052.c
>>> +++ b/drivers/iio/adc/ti-adc128s052.c
>>> @@ -122,6 +122,10 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>>>       ADC128_VOLTAGE_CHANNEL(3),
>>>   };
>>>   +static const struct iio_chan_spec bd79100_channels[] = {
>>
>> Even though the driver doesn't support it yet, there is a
>> adc121s021 [1] so would be nice to use that instead of bd79100
>> to keep the naming consistent.
> 
> I have to disagree on this one. For people who don't use the TI ADCs, the TI numbering does not bring any clarity. 


I think it does in this case because the part number includes the bits
and number of channels. And the pattern is pretty easy to spot without
looking at the datasheets. This is why I suggested it. Otherwise, I would
agree with your points in general.

