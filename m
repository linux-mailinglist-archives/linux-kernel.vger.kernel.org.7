Return-Path: <linux-kernel+bounces-759246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E96B1DAE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DE7723F15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9126A1A4;
	Thu,  7 Aug 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cm/CGNEn"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B0262FE6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581205; cv=none; b=eOUe65PzMPFVL5sb3xwDTTv6XyEYumg+p3ibDytIZ7pv0Gg5etpMMaS6DfYcLAsiKgyFk3xFujr+mJf9oiSdv722vfHhQiZunGZMm3a+Ll/FgwAfahst2x0GEvSG8WVuRpkDYaPxYX1X0d/9c9NO0n5gCKczF3CFXFGgKf6ssMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581205; c=relaxed/simple;
	bh=wIF+y5g2uGbuQo4bUcsxBrBWuM5465n72gjk9JaHt2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XnRvCnoa4PagQnySRHtWoJc86qhlrsz7vPO8XaLMlF0GRxjVf5tLv5UU93CToh3gowJgpe65OlCaIGi534gUR20m4tHgl6kmtYLfmSd6RpK8eTbnBayvBx2u+zEx31EniOi2/OV78cvx5WDSvz2iLYaPfPgNwZ3005qTZU7F2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cm/CGNEn; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61b43c84905so720830eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754581200; x=1755186000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoN9jTY+2MEeazt9V1rAxwiLT3ACLDoB1uh4EsCKwso=;
        b=cm/CGNEnpChAKW6kpwaP9IYYyfYiiYfKUSEq43RBqQ6at/K883thVF2pgexq0oO1PE
         +dhCIP7RgifEL0baiRC12cNhQfDV0SoNrOq/GcJG1HmcMLXJ8kvaJKdoywLm5Y/YzGnG
         EyMFTEfn1tszXek+l/ZT1SjxrGqJf13kI4aOVehtVfhTeOKdjBGa8rVwzu+NLa743s6M
         aNMj2wE4R0PNB3THiUkSKNU8fegIEzI9Mg1MUgKS3CCKh+Enf09QNcstOWJgAUZpGSgy
         gMdhMesjrTi3YtxZfhpjLOTeO+rYROGcIMMXpgGWAZAjcDQv0w5DIkg5s0MvUthoFHqN
         C4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754581200; x=1755186000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoN9jTY+2MEeazt9V1rAxwiLT3ACLDoB1uh4EsCKwso=;
        b=r36H4pP1r3MHxJ9xI3vhyBCKi/errSeuKP92dDf/8qej2qfOFqyXoVtGEXuNTRESGN
         yovPhbERa32/rxgCApGAqsn2mffskiVYL7gEFemjxo0Vi6yQgSA16FBJgddPowLDc2eb
         F71/US0x5sXGNbft2n3qJpzjUYNOEwnP1vZDvMmpV1falCiO4PaFxG3VfemCysC2bNM/
         FKGanDB0hyV8cJ0W19Iu2ovjsI18whtOeO4jyfcRLz0ETQzPLSh5K4Q/CCjVJ9hRDC9H
         iJ+wqHCW+zRGH6XlNRUunzW4kVr5XZQCkgsDOFiyvow3bAyP0h9ANgmfXASZtMV7gELU
         D8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXOml6nG3YXhElFVvSvHeU3YQulD3JiohWFwLnC9gZtjSzs81m6I4TVEsyqJ6OTnpm4yM+gUSSjKAwNysw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygoCRpnJrRei+0AbMudtjfH+Q8FBRVhchSsbcdUgPTVwKaPTt4
	NSWzXpXkMShNTthqiNIxohpkqHvEde4IjNtIOCJ9DDJEWzE8CX5qfygd8XduSIq6Hvfu4mo7RUa
	kB5Aa
X-Gm-Gg: ASbGncvmw3sbWtUuCDyukganBzZnEOZ8gT/K11/1/bmAVQGwojlSRao0M8UCQtLpvbg
	VLegoQ5gkIHLeyGlhKfeeFZYbisrdaX1ZMwfo62I6drEla9P4nr+tgaj5jq97DbEiY0qMUXKiOk
	vOyaYlvWd5HDM/MpNHBFgpb5EwXqohdum0Sh9128/Y0AIyKwBCo65xBf2kM+wVOCZLSctZD085D
	qJkph23uZNToKBZOtom6fFABadyRmHuL1dlwhjhuHhwb7lEF7okpwktDSuwlmqC1oZBrOlVo+Id
	G2mCHBTTADpAQZslbf7Eg6q5v1DQmY3SL6KBv6uu2okolnIn2Uv3VnXYYSgtUwoi3RMtjhuqL6Z
	XAbakjupt6Sw+3jhhm+a3RM5ttu1TlIKQjgbK8Yeu2f1UmLlNdXCwcikcbcfuQdjSeGMiGIxlot
	Y=
X-Google-Smtp-Source: AGHT+IH6AZ126w1Co9dLKeIbsdLPUJ9qvleOlVFbsD7VCIoegbLBFtcVomaYlYGr1sYxjG5QysSzcw==
X-Received: by 2002:a05:6808:3198:b0:435:744c:929e with SMTP id 5614622812f47-43594a0a7b7mr368937b6e.17.1754581200539;
        Thu, 07 Aug 2025 08:40:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ce54:d09f:5709:ac85? ([2600:8803:e7e4:1d00:ce54:d09f:5709:ac85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742fd50d84dsm1487092a34.52.2025.08.07.08.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 08:39:59 -0700 (PDT)
Message-ID: <a11e80b8-a52b-462f-8e69-b1fa7768a756@baylibre.com>
Date: Thu, 7 Aug 2025 10:39:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
To: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aJQOmQKO219rS8ZN@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJQOmQKO219rS8ZN@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 9:25 PM, Salah Triki wrote:
> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
> Check its return value using `IS_ERR()` and propagate the error if
> necessary.
> 
> `dev_info()` has been dropped as it was considered noisy.
> 
> Also switch to `gpiod_set_value_cansleep()`, which is safe to use in
> sleepable contexts like probe.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
>    - Use IS_ERR() instead of IS_ERR_OR_NULL()
>    - Drop dev_info()
>    - Use gpiod_set_value_cansleep()
>    - Improve commit title and message
>    
>  drivers/iio/pressure/bmp280-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 74505c9ec1a0..be6c981a4cc7 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3213,11 +3213,11 @@ int bmp280_common_probe(struct device *dev,
>  
>  	/* Bring chip out of reset if there is an assigned GPIO line */
>  	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get GPIO\n");

Could be slightly better if the error message said "reset GPIO".

> +
>  	/* Deassert the signal */
> -	if (gpiod) {
> -		dev_info(dev, "release reset\n");
> -		gpiod_set_value(gpiod, 0);
> -	}
> +	gpiod_set_value_cansleep(gpiod, 0);
>  
>  	data->regmap = regmap;
>  

In any case...

Reviewed-by: David Lechner <dlechner@baylibre.com>


