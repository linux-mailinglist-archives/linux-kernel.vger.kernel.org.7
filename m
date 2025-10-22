Return-Path: <linux-kernel+bounces-865577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AA8BFD6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DDF1893CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7483258CE8;
	Wed, 22 Oct 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mJP9SujQ"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DC35B120
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152402; cv=none; b=i5oLnIY7EbmqsL0hoTUwAj/eH9A41tPquv6EB1/OOon576aS77PtzMBpwwS3C/jW7ASd2Y4fuymV9x/AhARvPngsSFgXrAYGkYL66M015IvuzyltRqLjuMEy1nrF1rEjZGa4Blbu6LKJtcVshvA+GleSxNGOnUgPLCWYRqHuqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152402; c=relaxed/simple;
	bh=tg3+sV6cIbsxOjpGV0ypP+7yV6rtvMxzpP/xjjXMSBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGDbiqIrtZvs7WoPW65xfWSoN/xWKs0GT9U6Q8/sFKXZqUW7pIsR5Xc6/DXvTKKqnNdXzfQNDXBKLl7I/k+As24D5TILcIye6nXE8aWqZP01BaFGuF1TcuiVB+B9GDMXDrfUOsNW6ZyU8N5kn91dl3imSVMMKQULcVCtCDbKSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mJP9SujQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3c9a42d6349so7511666fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761152398; x=1761757198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MocBUHP0H4U2F0hQ0me7gqNWaKXOLx5jISmorrxl84=;
        b=mJP9SujQCiVRtLuLwAGnfVpxeSS4XvyL3IoBKqyd54ovtWsmOoKnLrQ8RWl3FFvV2G
         VHW28TtvO1KsCIdvrhpHDhVbJmimYlCgSCoEKJyBz7p1mPq1+sL7i67m/AzYyYCcl+Px
         F0Hrdzd3DsmlOOTS6+a5UgUpb9ssV/2N+xAKYNhyZIC3J9j8EuxnoRY+gl8Zm1wEL+7V
         cd8QdhIxCo3uqfXuWn+D2LklXfapnnywghD3asWrgEiRxxYZAl7/BJCghws/KenqDK0v
         0t1jCv7v4nX2vFWjlMsfa+dQyv2mGCAv4R8gXIYY7j6klmpiAmPL0bjzPJsQDSVwuQmM
         ZaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152398; x=1761757198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MocBUHP0H4U2F0hQ0me7gqNWaKXOLx5jISmorrxl84=;
        b=avF9g7sfgqVIPWwOlXsewycEPK6G4NpPcewzhJO80oG91RqOZ6fvm5gah7U3VEMxjK
         wQyl8KPXQ09kqfTT92woNlZTr4Ug+Mrpq5s6a+B8x17v4x5zUY77N9gOMBXx5BSLWzNg
         GVzsNj1pCeOHiuzZlGSSU9FX4+raK7AjG/pkHqYpEuRdEON1tnLesK072t29MPP2TSAU
         PnePmkgNYJG/EJDJSQ5sRH93MUVqGxmGstXaWrFKOClpS2tP7kNXYZ/wLmbc9NlH0uaY
         nU+eT6x4MS4QkaHPaxDwDuOkAzLkMAS+AHXcGvmG+hDlCX5PsTtujpiV+YQCUI1Glg2m
         VXOg==
X-Forwarded-Encrypted: i=1; AJvYcCWa+Bo7qcwBnlOR5iPi8tWYOU8Ic9RndPFw2eXkCodVRV7Qirm2xZZyWNdXiV7CTjW7vGtH8JggrKTzG3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wivBNrDDgLMINzzwqzYRtNVMCZVJOxhSnk+o0MALvnlUAPAU
	MnOgcM4I4fTg1AOw8HFxAW3VjDxpRePgoqLVByT37iDc0NFYFqvHOLLlkUHviTHyp6c=
X-Gm-Gg: ASbGnct2AhvdQx+S8/gF3eRjOaZ5vf2o8eiEYdcVUHBUmsBgIZEoxXFb9AMyOviWEy7
	dyHSrNT5WIvj80ObiqRKW8+BWf8tL57eFuI8V/wqGrNMZE5Jaz+8ThrR6l4Y8VSK9VRYtQUXhm+
	eIYLrc41vSmynKONyOQoS4HhZM6t1EEKClQtOEEYjI2ZPuJr54rDLdyGJra71/ntZO7rBZoZclM
	XIe3WAGX6mMXKiUky3RhP750V9ozkYtLpBClr5zXc6aY81zdTqAXH4L4672x7FChE64O3PyssZq
	t5LwTAGb7Re/1SoQT+KDz0N710pnpkoB5Pq4qmeoBKX6GKzM0Okl6huB49Ma+d/LDdt0+xeynwg
	pD/Ib9MYHJ7cjdUUIuzuFTVK/oRDfV79kW/QtiLaL6sCEcqV8qdunHAX1dOIXzOf0lpSOUrmcUp
	aUpG6HrBXZy7CWKWjTGTWUZxeoZvWiseb3I/95g+GwghdGU1UQPR3efAGXv7LB
X-Google-Smtp-Source: AGHT+IGmTiETk7edY0S6+L/36Kx1QoipR/q7VPDogbPAbXmnaia/pRjTlN+ehPvAAFfh3ISTfN6iCw==
X-Received: by 2002:a05:6870:24c:b0:349:de3c:bfbe with SMTP id 586e51a60fabf-3c98cf43518mr9335490fac.1.1761152398097;
        Wed, 22 Oct 2025 09:59:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9af01b3b3sm4184066fac.11.2025.10.22.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:59:57 -0700 (PDT)
Message-ID: <49c09806-0f58-4d1d-aa0c-4351fc3e7089@baylibre.com>
Date: Wed, 22 Oct 2025 11:59:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
 <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 11:54 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> One minor question inline.
> Nevertheless, the fix looks good to me.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> On 10/22, David Lechner wrote:
>> Reorder the channel bounds check before using it to index into the
>> channels array in ad7124_release_config_slot(). This prevents reading
>> past the end of the array.
>>
>> The value read from invalid memory was not used, so this was mostly
> What is considered using the value in this context? (see other comment below)
> 
>> harmless, but we still should not be reading out of bounds in the first
>> place.
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
>> Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7124.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
>> index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
>> --- a/drivers/iio/adc/ad7124.c
>> +++ b/drivers/iio/adc/ad7124.c
>> @@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
>>  
>>  static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
>>  {
>> -	unsigned int slot = st->channels[channel].cfg.cfg_slot;
>> +	unsigned int slot;
>>  
>>  	/*
>> -	 * All of these conditions can happen at probe when all channels are
>> -	 * disabled. Otherwise, they should not happen normally.
>> +	 * All of these early return conditions can happen at probe when all
>> +	 * channels are disabled. Otherwise, they should not happen normally.
>>  	 */
>> -	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
>> +	if (channel >= st->num_channels)
>> +		return;
>> +
>> +	slot = st->channels[channel].cfg.cfg_slot;
>> +
>> +	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
>>  	    st->cfg_slot_use_count[slot] == 0)
> Wasn't the value potentially read from invalid memory used above?
> It's fixed now, so I guess there's no point in nitpicking on that.

This code was unreachable with an undefined slot even before
this change because of the check to channel >= st->num_channels
before it.

> 
>>  		return;
> 
> Best regards,
> Marcelo


