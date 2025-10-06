Return-Path: <linux-kernel+bounces-843162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E175BBE8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647D84EACB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2042D8DA7;
	Mon,  6 Oct 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2zo+Zien"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F72D061E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765737; cv=none; b=e3bP1Xl3CRQykJMYJyvU8uE3xP/2NPF4QnmqQoTR6qFN7xcohGK4il/5pmp0IEiSUcEKJnlmztK4/fQIQc47+QJQFEYUQ+vPSfZjLmDHT8q8SZaqjNuV16cvJ7HA93G9ApJNcGfMhs/Lu1twPl40E3vw/xpcQ4pdCKn55CLp3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765737; c=relaxed/simple;
	bh=7cCqsIleQbTCE8nJ/cqNLb6Xh7ymZFZDoUIkZvvwW5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im8/s4jXoXmZL9TiCg+h/Hag6tq2kl5e1hw225oy7xi/jVc1VPYpCmW6gwyRySnEhgy/bSYgJBoM2SPUpYPJhOuh+tfI7erBwvLx0b8jOuxW31TMrvu3DJlZJZWh2aVyueNlhxWClsr8R69pGviampQC74BXtSQwX9p1HlxCmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2zo+Zien; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7b6ac55cf86so3189286a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759765734; x=1760370534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T869gDVevA9LpG7p7hXPgb7SP5eHhcw4WWhaTQBkq5A=;
        b=2zo+ZienJvyGr8v4PFCMg777UXY9YbInkEZSYVHaJh1LkrIiNQ5HSe30lkob5edkt5
         gcX38kXd54+hdz1yB+LZchELWJwKFEYW6WPTMhoDU2sZJV9RMloSAwWUqZ30V8Lnx+uc
         PY/8SPITCvzJqOCIRj+gVJDSKdycdYsh6BimWJeM4zC+xWQvYFDAWTaZ4m5iS/d0p01y
         hkgQo2wu9L+mIVevhyMuhUgNS2SGZslZyXHWJhw9wI/cOl8vTr+GfP/IIkvlCHeBX7wx
         uzYomOekrrB/vn4cgha4lqO2Iw/ryKlaHS7hjIrj06Wl2Zbe+nTh1//C9yR+dyrsEnkv
         XTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759765734; x=1760370534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T869gDVevA9LpG7p7hXPgb7SP5eHhcw4WWhaTQBkq5A=;
        b=PxfJPYeZXDfgXBMOGCcyAYm6/0bv2bHEEoQmoUXUpqcShBmI2RoeRZXgrQExJWuoFb
         XsMoQdtjpOg5Qkt/+EFiF22rq6YU5YbfgndBUY1oIk3gx8RXsnJS4rBo0dz6OWEji7m3
         na7eQJiiM1xqG2msRLsHJ1uC1Wq2HCU0JWEaa3fgezv9+GBVpu2EyS1NrhtWQ3vCqxXM
         XTf+6Srv0mViZEWaag7SJRWQZAQecpO6YXAWEqG2XkebKgdaavqs4rXAowuZaQdyGKTA
         az65zYTMWFtU58ROcHNR6FugpJU5/vh2y4d14SUbT/qt2cekpUpn19ZwxfuSHJYQPY8n
         hsgw==
X-Forwarded-Encrypted: i=1; AJvYcCVCReBm20NXOVoTddj/IBFxl5RkW6diW5+lLrj0W4fQ6xGgWb9YnkFL/creyTIIDCU247MCiOXXhduEQJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJRKRxmXSyi+MIzYYVvRjhHQb/KtOzw5Yut1ZT/INGb7uYZO7J
	Afdo7a2zClrFMohEPFy+rzTKuXbUO6fSZqmLaFGd4pZfIBO9aH/OMeR/hgQxoXrNGy5ceD3CIGE
	cJYmDjuk=
X-Gm-Gg: ASbGncsaKLEwb8Uli+c24zgiwojanT/pPE4b1LaAfygy8O/cIyBlaFvLTMFnAuNeU2L
	6VWxdJPz5/M/Qj42yimaoYI22Emn8xhzYyOlMI/e23abg+t65rOXrFPPKtk/IL+2ib6vRTpYguQ
	UZIOXWfjF+EoGSFje6c+PQLQ+qyDlLXR4s8fdcnKtcHtT0lQZaKXlA1muZkDXhpy2AI2haBwa6O
	4beRCDpcHEXno8eTFuOS70T3x7ZzNCcXmaw+GslWhyRV6wdY3xLfd5gnZGe6iqL/d9udQYy836S
	yVcAVVYk+OT9vGUpN00MFURxu2ZtRDTveKmuGhy1mj28XIqTiNizfuxQufNiJMzqE8IxUY/NlSF
	d8Jnsg2wbZoZ0UobSiNlMJ82HD2qP4f6OzjDy7kbkv5kdYVuRHG5IpVtdO7tDOWQQpugNAaspk7
	ZNT+xr2Ggtacc7rvpHfNfyBir9q1LBncA0/w==
X-Google-Smtp-Source: AGHT+IH6njM+4Hb3ORuQPgRlqgDWQXTIapYtLEi8wuRV94ziPpiWcaXvJxfwgPJWYXWshy0ytCVboA==
X-Received: by 2002:a05:6830:374c:b0:7bb:79ad:6604 with SMTP id 46e09a7af769-7bf77538cccmr7827018a34.22.1759765733844;
        Mon, 06 Oct 2025 08:48:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246? ([2600:8803:e7e4:1d00:a1fd:4fbd:e7a6:9246])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3892248a34.13.2025.10.06.08.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 08:48:53 -0700 (PDT)
Message-ID: <da087553-c6d6-4e51-ac57-1be95a3c04b7@baylibre.com>
Date: Mon, 6 Oct 2025 10:48:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] iio: adc: max14001: New driver
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
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
References: <961e5351afa408e69541b60ec75852fbbd1ddd24.1759121938.git.marilene.agarcia@gmail.com>
 <476b75cff0c3e5ff23ba7c642924511f3ba09a3f.1759121938.git.marilene.agarcia@gmail.com>
 <CAMknhBHt9JVkaf1Kq76BKFM-Ff38-7ws6gaq+5fwy=pAih-fww@mail.gmail.com>
 <9ee20209-efba-44b1-9902-5885bacfb290@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9ee20209-efba-44b1-9902-5885bacfb290@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/5/25 6:25 PM, Marilene Andrade Garcia wrote:
> On 01/10/2025 11:03, David Lechner wrote:
>> On Mon, Sep 29, 2025 at 7:59 AM Marilene Andrade Garcia
>> <marilene.agarcia@gmail.com> wrote:
>>>
>>
> ...
>>> +static int max14001_read_raw(struct iio_dev *indio_dev,
>>> +                            struct iio_chan_spec const *chan,
>>> +                            int *val, int *val2, long mask)
>>> +{
>>> +       struct max14001_state *st = iio_priv(indio_dev);
>>> +       int ret;
>>> +
>>> +       switch (mask) {
>>> +       case IIO_CHAN_INFO_RAW:
>>> +               ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
>>> +               if (ret)
>>> +                       return ret;
>>> +
>>> +               return IIO_VAL_INT;
>>> +       case IIO_CHAN_INFO_AVERAGE_RAW:
>>> +               ret = regmap_read(st->regmap, MAX14001_REG_FADC, val);
>>
>> I don't remember... did you give a reason why this should not be a
>> separate channel? Or just use REG_FADC as the raw value and forget
>> about REG_ADC? In any case we would want another attribute to control
>> the filter window size.
> ...
> 
> Hello David,
> 
> Thank you for the review and suggestions.
> Sorry for not adding any comments about that in v12. From what I understood from our previous conversation, for now the code could have one channel to keep things simple, since we’re not sure if anyone will actually need to read both the filtered and unfiltered data at the same time.
> 
> I was thinking of sending a separate set of commits to address that after this one gets merged, as it will involve new code changes related to adding a function to configure how many ADC readings are included in the mean calculation, and adding a new attribute to sysfs.
> 
> Since both IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_AVERAGE_RAW are currently returning the same value, I could drop IIO_CHAN_INFO_AVERAGE_RAW in v13 and add it back in the next series of commits to implement the related feature.
> 
> I would like to know your thoughts about it, because if you prefer, I could change my plans and implement it in v13.
> 
> Best Regards,
> Marilene
> 

Since everything else looks good, I think Marcelo's suggestion to drop
averaging from this series and add it in a later series is the best advice.

