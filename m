Return-Path: <linux-kernel+bounces-830578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CEB9A04D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A917B5DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6F301494;
	Wed, 24 Sep 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="as6UZ7nV"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF815B971
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720148; cv=none; b=hL/EUatVcyYiGUtTw5tzEwSm2Kz1PSOPp4u+63HkJ/+gv3WGnhWMM7qLD3K8Xumdtyi5903/PFD40z2Pzwvs3NP+rOAlNVeiulLi056Eqi/HaUHy42qW2zkc3EUuzDWIdnp9mzTcQO7bdgwViRQ89X2KeYEhwZjlJf0geg1oBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720148; c=relaxed/simple;
	bh=lI2GHuw6RP6D9TulmrFtEisGBRAcx8RDL9OwlG6McYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a35TPKHz8qAZRQA9pBsxwGdg7+9Hj/uiRY5CmrdRga5PpozOCH/WMqUQk73TQL4ESf/kkeeO1fXhy4YtdjGyBL0fB7zCXtKcvNY8y0RBp7MecAlkbu0J+NV4eHveNRMPMXfxmeNlx8/Rsyjd3kxzHfOweWupkl8iBvIN2zGqiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=as6UZ7nV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7859d18aa33so2094779a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758720145; x=1759324945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bk5S8ctIXq9wfVpD3CxClS13Cmu6hpYbPn+0lF9IlDg=;
        b=as6UZ7nVVSlggYRk+wj4p08+r2MjmJXSxwkkmKCcEzCOVUsIhGQU2LUIOlk8AiZWxP
         ldYkIbEjO6Z7rqHuCSuVm2MyQtA04xTj4vnRWXhKgk6OTjd5Dfa5nfcPwQtYwE1nDmSU
         h+60j4xnus3NqVoWwHxaPGrrycIkyfsYIYEHKqzkbZvdqTs/wzdSAHMDmlFW0ML99C/m
         QPZZ5ooX/+BWhItlcUwHNbVzeqhW01P6BD1UT+0tIK1XvOiu/j3CQ8kdAhj5hehZCN0l
         0tKIY/B4jTqQjVLUD4w1soI6RmGNFdw3y3bdjjwbutvkRb3pD1IomuwfTEMFVkEOeJRV
         O3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758720145; x=1759324945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk5S8ctIXq9wfVpD3CxClS13Cmu6hpYbPn+0lF9IlDg=;
        b=QbrqspPdCa+99u/teyFPwBwTif9FYXu/pxk8NDGTidWZe5158skCsln8Vdn5TB8bgu
         IilxN8+3QvbWILTMy7o+ZgGnWHqUP4Csh1lE5ZZMYx8lLDR7GlsaHXNId/Dy9goF84uf
         E1UGF6mvFzEQXHUHsIdaQizQ6PUeMV8XSjFyjfoeph6Trvz6v2zWJZkuv9nzlPHVlpAa
         /5t+9X2OYvFbIeZ07UCm67FqznfgYSrK146HZEQ7SlPm7GhKnRBApsswjtOWgScsl4GN
         r1e5ZF5PGUzX9eeEsHQmvOdeyfQfL05UhYLbrPPDUWwZmen1KmeNTU4KBs7Gab9A8Stt
         cpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVr26kzE6PK2jgbv7DhygY+1+lLY4/usJ7oEpgcCjbJwuVYwRf9T3PIluMAcZtVKAerjDqY7wU7xtAs5KE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+fUEESGsnhQOeaMpajgirSupSC8/ZlPPzLImbXHxznIu0wIo
	0DSDpxJ/gzYgeC9Kt2fQIfe8DUPSwxXX6sZKr5POLT9dIJE5pIj3ShDDFzlmB8gKHsA=
X-Gm-Gg: ASbGncssSe17tI7lOZgHlQpN6VSL+4gLGK1N0+p8Ry3YUyPNMrB5d2seL8CwCSE30c9
	CwORSKc9p+ZwnSlg36ithM1zgpkhzvz2gaZ54qQlkvEMZHg8R0Zj5Pc8YodBnj2syVQvSLlC7g2
	DQSvq0iW9nYAC8rmnRx9d/SMmdvK20VBIM0QRrHtsas8aBTk0gwtEn3pDeOAi8n9ePsKwI0UUmZ
	bhiWSaBqMn0JPEPR8etytZD/at5cfw8JxTGonNDpc17bb0IKN7L+HAIkgTBnhdcb/gZ4/xCiSO+
	yEz/50oaVJjCqnm6NFqwPi1aU8wEop2QnK8cKr+bfnWfVtWMVFLnAwSuF+q4e9hGwUe0+4tuCVz
	Yn1IRN7J8Xq4tC4zBn4uwqr/AQSvUcr/vqN8y/gFYIYqoTk0QkmoYYquDoNUu/FLk9/uy3Eer
X-Google-Smtp-Source: AGHT+IF0AAKtC4K2vFos6O8AcfB8HOurhg3DtXtcY/Osy02ydHwxnuAFRkAy4WH1cbNpMhYIdPvEMw==
X-Received: by 2002:a05:6830:25d6:b0:74a:52f8:6f40 with SMTP id 46e09a7af769-7914648876amr3753456a34.8.1758720144748;
        Wed, 24 Sep 2025 06:22:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2? ([2600:8803:e7e4:1d00:5b03:6cc2:9ec:21f2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-634f97f8abfsm552478eaf.2.2025.09.24.06.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:22:23 -0700 (PDT)
Message-ID: <f8af47c8-b2e4-45b6-8c2d-36f952327d00@baylibre.com>
Date: Wed, 24 Sep 2025 08:22:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
 <aNPrlIYGrB8oSsfL@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aNPrlIYGrB8oSsfL@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 8:01 AM, Marcelo Schmitt wrote:
> Hi,
> 
> On 09/23, David Lechner wrote:
>> Fix temperature channel not working due to gain and offset not being
>> initialized. This was causing the raw temperature readings to be always
>> 8388608 (0x800000).
> 
> Would
> 'Fix temperature channel not working due to gain and offset not being
> initialized to their default values.'
> be a more accurate description?
> 
> 
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
> ...
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
> I think it would be more accurate to just say the offset and callibscale
> for temperature channel need to be at default values for the data sheet's
> equation for the temperature sensor to be accurate.

This is true for all channels, not just the temperature channel and
there is an existing comment (partially visible above) that says
something like this already.

> 
> 
>> +		 */
>> +		if (indio_dev->channels[i].type != IIO_VOLTAGE)
>> +			continue;
>> +
>>  		/*
>>  		 * Full-scale calibration isn't supported at gain 1, so skip in
>>  		 * that case. Note that untypically full-scale calibration has
> 
> Maybe, instead of moving the 'if(... IIO_VOLTAGE)' check, this could alternatively
> be set when initializing the temperature channel at ad7124_parse_channel_config().
> 
>  	if (num_channels < AD7124_MAX_CHANNELS) {
>  		st->channels[num_channels] = (struct ad7124_channel) {
>  			.nr = num_channels,
>  			.ain = FIELD_PREP(AD7124_CHANNEL_AINP, AD7124_CHANNEL_AINx_TEMPSENSOR) |
>  				FIELD_PREP(AD7124_CHANNEL_AINM, AD7124_CHANNEL_AINx_AVSS),
>  			.cfg = {
>  				.bipolar = true,
> +				.calibration_offset = 0x800000,
> +				.calibration_gain = st->gain_default,

st->gain_default has not been initialized at this point, so this would
not work without more rearranging.

>  			},
>  		};
>  
>  		chan[num_channels] = (struct iio_chan_spec) {
>  			.type = IIO_TEMP,
> 
> 
> Nevertheless, the current fix looks good to me as it is, so
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
>>
>> ---
>> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
>> change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
>>
>> Best regards,
>> -- 
>> David Lechner <dlechner@baylibre.com>
>>
>>


