Return-Path: <linux-kernel+bounces-830568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8DB99FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755FE189199D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0392B2D9EE7;
	Wed, 24 Sep 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xF6sm1Vj"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16722069E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719847; cv=none; b=PrVTd4Cp3L5vkiLtEq3fnIH80l7l0KiXdc2BBPI0BKycgZHL7s5booahYCV1MsxhSVB4pROCE//Oi2TFdJyqjIhNE9IqbTGWstFj8A4sHBwb7rGb0/1jGD6xU4r1h1kUe3k7oEk0iG1d5vs7igGVSIBFbdo25YmTseOrgcIdvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719847; c=relaxed/simple;
	bh=nNlhZ3ky71IFd+n9wOyeaZgybeewKfw/SvYwsc4rOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTAzWIPphUdpQS4+HW92spp5bS3Ek2gpthplN1xO6CS87FERj5Gt/O3JT08ZbrJ5j7ncIKhqUbLhAAbOcOwJajFOQEvX/sXcAS2uSM9DT8nmwIZXkxYY1w8UxxeuyINdl3Nwud9wBTegDDxH8zKSAU18ssWCQif/N/d0MPWILWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xF6sm1Vj; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6218fc7c6b7so1603453eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758719844; x=1759324644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfzpwQgTHBHYqzRqbLUeQn97RlK5vix1IohjUgnZb8Q=;
        b=xF6sm1VjFVBtynlSmllYUAtJqUECS0e+rseikvsdgU2AgGLBUqlyjYn09J432Iwo5Y
         7fKfZguYR9lJ44G5TP9pew8fHVtORer6osKsKz0BXC6uUWb4O4EqNxnc4Se1tQRwxPJ/
         ClY9aK3PNYcLeg3sQqX+65jdkeSho+d/oAUp9ISRTxOo0UZxeckFym7dCcNTGCycZqdC
         qkqzp2j9xihzqbDgqPANdDJ28Kisa2UPJ1MXL3p0mxPGp0RF2OgIhyNakqRYpkiwUlRq
         B1//4aTTq3B3afAGyvCG1tmLTTqKs0RUpJtomFBWHH5l4pcaAT5kmxwUsNoEE690l55R
         mISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719844; x=1759324644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfzpwQgTHBHYqzRqbLUeQn97RlK5vix1IohjUgnZb8Q=;
        b=ezWevXy1kFXqAa9jpC3wIGUgnfKLGXkKzJwd+GzVsQ9j9V31zxWxjPYhcnRJQePpvx
         cG9DBddAHh4Yktc23Pu2zqm+eoSg+CqhMEvVTouV+pXKD2fmGH0yIg6QGbQAg4OcA8C7
         CrJjaR8pbVX254/x/bLDV1zvURw/zSrAAZPe2BjIml7a6DrfuvHEQIwKn1CNwCTHfQLx
         iD2aVXUZRzL7GkMEtXSV2WB4W/j4i8o0t1z2rJUUUrrEOfqY43xECZ+lTYZdbv8tsqfN
         kymUS3U98WhGUpJyWGOXD/RgfGRkpJuLHHuSTAeKpth1kQZ0hJiZ7rG10Nl6gLq6lkxG
         9VvA==
X-Forwarded-Encrypted: i=1; AJvYcCV+pXXfw0ct39CgHMV1t/e4Q3qK9Ew3XbWKQCGyCSOg4OXSBIBb1Jv3d2Ef7Vf4JpH0rZmpjqWXyJ5XGkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6uEYL6vziJXJcaulPsl+NZaTP7+GQpcYUixunZBa2QpEtDKd
	78VBb0Zm1FPYkNGHnyhHH8onfSYpGPYevMPG5kW99yoW+vRATtWVa+/4ztaQ4ouAA58=
X-Gm-Gg: ASbGnctpZtihRd1WxAfRry+KPzy1axJi8GOCPTQzs+7RqyVAZTXpvPU893NgoUP1rzJ
	J0rWDEpdXVb3AssyS3UYC6aZ3B4P0Qm+L907o4kv1mE2RMiXKiyDldAETKhewwBUtWQ044zO/d7
	eWO6IATaC1hLOeeSqdG4ZX6f1swocKLv43fe7PhlOy0Kr/hhkLhFv4lidaElaVpPSfnglBI0To+
	CUg/Gm8gZBY7MBTzR5ahutTJLvqMPOrIGTW7nbQ5PPTIudKhumKPiRQ4EeMCJHf8ln8VYKwFOtI
	vIvPcvDphpy+bZS0BgekYBh8fbmEQIF9qOKuC8mnUsWHSXjkwfzNwMvOPv/B3XdU+tZsgZBrq7u
	/GeQrbep8zHSLQJhm/UiWfvOzQeX6/kYXvqNBeYts6PdD7IxxCyV74fYVbU1sqtrenv/JlKNx
X-Google-Smtp-Source: AGHT+IHOZBg2Ew5oG8YZerk3MsMqJ2CIE1Jt5C4KrJR+KD/B3ZokyeWrlgJ+mwKYC9r19TWwcYEPcg==
X-Received: by 2002:a05:6808:444c:b0:43f:163b:88d with SMTP id 5614622812f47-43f2d2dbd80mr3060029b6e.18.1758719844018;
        Wed, 24 Sep 2025 06:17:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2? ([2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-344ccf031c7sm3446523fac.24.2025.09.24.06.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:17:23 -0700 (PDT)
Message-ID: <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>
Date: Wed, 24 Sep 2025 08:17:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
 <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/25 6:03 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Tue, Sep 23, 2025 at 03:18:02PM -0500, David Lechner wrote:
>> Fix temperature channel not working due to gain and offset not being
>> initialized. This was causing the raw temperature readings to be always
>> 8388608 (0x800000).
>>
>> To fix it, we just make sure the gain and offset values are set to the
>> default values and still return early without doing an internal
>> calibration.
>>
>> While here, add a comment explaining why we don't bother calibrating
>> the temperature channel.
>>
>> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7124.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586db0c4bc1690855be2c1 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>>  	int ret, i;
>>  
>>  	for (i = 0; i < st->num_channels; i++) {
>> -
>> -		if (indio_dev->channels[i].type != IIO_VOLTAGE)
>> -			continue;
>> -
>>  		/*
>>  		 * For calibration the OFFSET register should hold its reset default
>>  		 * value. For the GAIN register there is no such requirement but
>> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>>  		st->channels[i].cfg.calibration_offset = 0x800000;
>>  		st->channels[i].cfg.calibration_gain = st->gain_default;
>>  
>> +		/*
>> +		 * Only the main voltage input channels are important enough
>> +		 * to be automatically calibrated here.
>> +		 */
>> +		if (indio_dev->channels[i].type != IIO_VOLTAGE)
>> +			continue;
>> +
> 
> I don't understand a detail of the problem. The commit log suggests that
> there is a general problem, but looking at the patch I suspect there is
> only a problem if at probe time the OFFSET and GAIN register for the
> temperature channel are different from their reset default setting.

What I failed to mention is that st->channels[i].cfg.calibration_offset
and st->channels[i].cfg.calibration_gain are zero-initialized. And that
these values are later programmed into the ADC. Programming these to
zero is what caused reading the raw value value to always return a fixed
value because the real value got multiplied by 0 in the ADC.

Is that enough to clear it up?

> 
> I think the patch is fine, but if my understanding is right the commit
> log is more dramatic than the issue really is, as it needs some fiddling
> with the ADC's registers between poweron and driver loading to trigger.
> 
> Best regards
> Uwe


