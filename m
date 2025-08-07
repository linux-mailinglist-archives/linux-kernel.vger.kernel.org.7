Return-Path: <linux-kernel+bounces-759270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C04B1DB47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723AB1AA5460
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887826E6F1;
	Thu,  7 Aug 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0enLXZF"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554026E6E4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582585; cv=none; b=F0BWyzaFNuoFkM2QDIc99o6KOdEjtZfxWIV32xb8anOcEQZ8kvAybLJT7bIfUiVPTkJ9Ry/Xwdd3zjzKJUe562LYO9ogrVvjUBdglNEZeyUV5mvU70ZR/R58IusORnc+U2t0sHhOg44uQQJDOqMDxFafNtjBsv4BaHiewp6eJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582585; c=relaxed/simple;
	bh=SmbMv/qdEz28m9GrWcI4c2WD55LP+jRQUDQcxubXHCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XnDTn7XXIsfiLF0iJV8DEP6rVE9IxrCTu7z7SPWKO1mQ4YBbZmoEFweu+mo852hzSv1OqPscqTxULSECmHNEypQWlmky803Tsv6RqMEbWSeybGU/Fgb6BJIhVYzvQ1U3K9uCIbADCr7iTKQDNA3SfBOOz5CSX2U52+L4Y8J0PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0enLXZF; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30bc0cfd8e7so728298fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754582582; x=1755187382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IiA/OxVAqFEZu+6RNkj75UQ6W/OZ49cY1TnC8j0a0xo=;
        b=j0enLXZFkwlMEHVqCs9FWUWuz6ZLTouHCgw7L6KuArVnA2FBnaIqTpsuTWmv9Zd9Nz
         zBtjxqMYYVwuSkqb0TkQEPlSdLW6F4ddV/icQG5MMwBh6vdatXpXGKR2TUh0aSbTER/y
         YlFf4qYvoFsahBFONizVbtTjCaOm3lQd+P3YHjosdfeUtehI2hksCc4vTmvLt5EKjrYX
         X9wdB+j6SjPOkF/29jA/t7WBWAL+yG1OAEQQFBJVRHYAkQZ6vmEmxM6ttOKfM1nqDD3Q
         H9zfi4+taE6N2wZfbSM0bfQb3QtbChxeFYdpxu1FmadI2FFw54LK+WH7w1cV0HlTbHVW
         My6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582582; x=1755187382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiA/OxVAqFEZu+6RNkj75UQ6W/OZ49cY1TnC8j0a0xo=;
        b=u1ULsM7U4F9omOwQ2C5QjGim9wpQAigFAwtQuj6yIZdxhcapsnwfESUe0PJBS2niaV
         9iErxtAVLi8FFFSNWsE809quNJznwO+gULs+BI1qGZfl/t5VszJXGf7Efswt4hXQ4aqq
         hljVLTsMEVmWxal3pjwfELp8cQJpOB4dznrfpWvJh8+cL++r2wBSVg6ZrIrJgQ+NDkeX
         W4+NYRemBY//TBEuCiNVilJhdrAsPyhRdhaWsfC37EFqJOWIKcSlEn7IDgqjH/3QFBaj
         Sy6gx5JCg32JCsJYY3ovSI5TYebSH4M+kPXqh0RqgtCKBMBw6OgY8loO/u43OVwjwIgk
         uwWw==
X-Forwarded-Encrypted: i=1; AJvYcCUxPBRALso0W8tVHM10QbnvRLg8MnmH81wQHeVXXmwa+nnjZAKy4h2rppYfbtMlrwCWlBXsNeh57cKMQIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8wDWDfhH1EiRBJmfJFpgKp8+iVQLsAw6sdGgPkZT2SsPyzlO
	0kqBnoBBXUPWwNaYmE8Un+cqgjE/4qjS95IGWAuxmcu1hdizevw/FLoO7R4urCFmnQg=
X-Gm-Gg: ASbGnctikLE9oJofTbdjDmJ/WXyyhG/81Tmzag65emZRB+3eNVcDFPY7r3bYJu3kfzJ
	p24QiOZ3s43BFhVoq7bR9BKvxzzTmbLj+PJLmotGOkGQ7xcj0qMcg2JWY+3Qs3rsnaByQ87bWxK
	0F4KHyyAL5e+uhTcA5UN8tGewbxnPIzeUX77mmG9FxRJd6rYidSiMoHPUSMuWukDsYEGgCCYY6n
	rCIiNYF7yWwtvdBmLKtw2aq16gDcRnU3ljOmNEtQc0B+HxS96F8ibrWnE9tAF9u94U1dBEc2Usp
	PQUVppJBoEbbQ3MAmbj5XswIsHJkA36RFMdnpPSgpxcBlXok20x10mfqdPJdXbZN3016+e5J6xq
	G8kjmHP83q9F4LNXXcGnW2YE+d7O2Xp1d1udvXWyE+IbjyyyTUOmAAMkBBSQTVCryFlr9rF9Vh3
	M=
X-Google-Smtp-Source: AGHT+IEDd9iWnbMRuwQ1lQVibSMLGfaiPKZhtrHEAEpQskYUkoxN/o/4EBgUPXTI+PhOLsKX+tnrsg==
X-Received: by 2002:a05:6871:24e7:b0:2c2:4d73:ec43 with SMTP id 586e51a60fabf-30c004ddf0bmr2547212fac.15.1754582582003;
        Thu, 07 Aug 2025 09:03:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ce54:d09f:5709:ac85? ([2600:8803:e7e4:1d00:ce54:d09f:5709:ac85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ba8228a79sm2726450fac.35.2025.08.07.09.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 09:03:00 -0700 (PDT)
Message-ID: <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
Date: Thu, 7 Aug 2025 11:02:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJReTh-t5D45aZNV@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJReTh-t5D45aZNV@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/25 3:05 AM, Salah Triki wrote:
> Use `ERR_PTR(ret)` with `%pe` in `ad4170_read_sample()` to properly display
> symbolic error codes (e.g. `-ENOMEM`) instead of raw integers (e.g. `-12`),
> improving readability and debug clarity.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
>    - Improve commit title
> 
>  drivers/iio/adc/ad4170-4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
> index 6cd84d6fb08b..6296b5dc930b 100644
> --- a/drivers/iio/adc/ad4170-4.c
> +++ b/drivers/iio/adc/ad4170-4.c
> @@ -1253,11 +1253,11 @@ static int ad4170_read_sample(struct iio_dev *indio_dev,
>  
>  	ret = __ad4170_read_sample(indio_dev, chan, val);
>  	if (ret) {
> -		dev_err(dev, "failed to read sample: %d\n", ret);
> +		dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
>  
>  		ret2 = ad4170_set_channel_enable(st, chan->address, false);
>  		if (ret2)
> -			dev_err(dev, "failed to disable channel: %d\n", ret2);
> +			dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
>  
>  		return ret;
>  	}

Interesting, I didn't know we had this format specifier. But I think
this is something we would want to do kernel-wide or not at all to stay
consistent.

And if we are doing this in more places, it would make sense to have a new
format specifier for integer error values instead of casting them to
pointers.

