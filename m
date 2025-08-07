Return-Path: <linux-kernel+bounces-758507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DDAB1D00F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B8C627ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF630195811;
	Thu,  7 Aug 2025 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bHlB8/P9"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075918F2FC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529882; cv=none; b=sYXjcj+vBQsiMUt5zSHjVuPAH2ZKaNBrsdiw/zLG/70/WJ/DFOyXGUssk4iXg1HXhkXOvA1cU+5GEurSKjY1INJpS7Ait/mWlr7/DDQ0ohX6pWAmaOJUQhW+uC6gYgTuilIjNKzMu8S43RhIgrhsMrhqYPPfiCBjhi/fpyrlFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529882; c=relaxed/simple;
	bh=7U4fHvP0ih8VFJgO3STDVGAT0vqMcDLOgP2/LcG5M0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=omkALmJFQ7WBRUT61hR/b5xooE6PmfqFtTCTjifKoxF0r613pWa1IC2zJ/wFoClUCQHD+D4noDFMGbUc6g/CzxZPvF0M1xh2tt27XNlsTfhLZ1jHWgSRX/nnK+/tMUAkTjrohm8QQ64u6qPnOJNn3S27M4rf7QZV1/+RPBKpNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bHlB8/P9; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30bbb2d332eso178860fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754529878; x=1755134678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlob5EoTKbwfdk1l3MgDDEiHlXNGbyvCLwvCntrqVtE=;
        b=bHlB8/P9Buw2yIBk/eD8D+zl3e3hcwObWtpOkdrcOlE7nSg3Qw8LjlACJTcxHulyf3
         C82pXSrRxEHYAKeSqLlrLrBKRFqwWWv59W3t0TOPz6crJPcYy6SPY9ACU/dEC8EOngDF
         erB20RY3Nc4QHFKEAGXkdYgR+1g/lQEKubGpOEE7O+RWbs7Q2K1l+8K9Nr45Kjdgruxz
         u1Yf02LOD0llubyA8clPidwGSUePdkvRl28JY00tghWQdvMAmaCfUJZE/7G1HGzJx3tL
         nN6ytIHBUS+3Iu3O448LkSVkKQqsUu6qcmSryrKu1jhYtbJoVBc9oO/h/kze2UQd6/+j
         QWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754529878; x=1755134678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlob5EoTKbwfdk1l3MgDDEiHlXNGbyvCLwvCntrqVtE=;
        b=edaaxBdcd4sOV1PzYnH6IA8/STZsIQKIyFzFfxy+t7AwOBtJ/rajNhUNNuqZ8ACGTv
         u3x2mTNiE1cH3bPseWkFRS0xKbvt22N/dn5+AfXvBtsFRXJMWd3SSbg0L7ljmc1VOavu
         645XiXB7msYl+icwGVfn19Fg2p+mMFw74up8SdWR6fP47U75PHCSV1lrOSvlUsjQJe5O
         bCIrT0gvIr4N6heLLQMFREeef4cnRxNy2NEhEEnOZTNcKmLdVVqRs9EUITI0qp2X7P+8
         0h3oV/JnF+2dGEderRKp2Wktwn3OlNU7esZvG2zfWzHh9s7FLmf52AZ6HL4E6/sDJsO2
         1tiA==
X-Forwarded-Encrypted: i=1; AJvYcCXwusgaqueob0Joi06NlD1WsUyJ6zLRzNjjYc/dbK868fXzOCd65a9WLe85rlePnGt2zkqHQRVBkvNGmtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6MDoUI2KjJU6hLkWv1CIOhaRZpRJLrmbbn10Es9+BfZrVYJF
	SQnDGAUJB9qrI+6dHBMqVE+X2jwDZ6h4pmtMZ14qS693h3unW4c3pNRzjr7JjvsHf1M=
X-Gm-Gg: ASbGncvub0fqUbIcxjrfKcmIx7H7qIv36bmOvdpV8xDa4AQjKdLgI4v1av539YulYiB
	/tft0Vc0RUI9IcJCr+ozLb1AdTGWODwUoVm6/q84K95Kc8l6s7PqmNylY9LSgE4tcdTknp/ZKiY
	Wecwwsn8batwxaZ6p4lgZwjThyrDHKfdZJo+VrN2iM0bZ8AiJxDTfNF6JtZF95/Tix3mhLsQrl1
	loEFZfqgyzXaggNSwTq+Lz0ngTqi0uuLWdhiaJ5oMZIThxT2LyAwtzZWTGSIPSK07XpMMHCEKEF
	1Hkdg+zY6p1auau1nwGZemT1+dtFs1X1c4zYXHIfvsCnpmwU/34pW5IuBJO0ch3GeinDSRui3TE
	qI3DbBAu9mMs0Rn7NojpqJ4Z+desRvICeO6VqyNvjFW8B8CkPNLvM54ASBvuPeubh9lfbzEGA0b
	wbNthhlUk3Nw==
X-Google-Smtp-Source: AGHT+IEZAM7i8noTFma5wAnR8o4D7glt2vGuAH01kSmUPVRf7KW72alZoNCyV4wMEfKwuI1X7qG5Qg==
X-Received: by 2002:a05:6870:3c0d:b0:2e9:4038:83d7 with SMTP id 586e51a60fabf-30be296ad83mr3038244fac.11.1754529878596;
        Wed, 06 Aug 2025 18:24:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b6dac161esm3485598fac.22.2025.08.06.18.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 18:24:38 -0700 (PDT)
Message-ID: <b7288d5e-8dc8-4ee1-ae34-52904a3f989d@baylibre.com>
Date: Wed, 6 Aug 2025 20:24:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: bmp280: Use IS_ERR_OR_NULL() in
 bmp280_common_probe()
To: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aJP44mH0AXQGCFFR@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJP44mH0AXQGCFFR@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 7:52 PM, Salah Triki wrote:
> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure.
> Check its return value using `IS_ERR_OR_NULL()` and propagate the error if
> necessary.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 74505c9ec1a0..2ac0188d2857 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3213,11 +3213,13 @@ int bmp280_common_probe(struct device *dev,
>  
>  	/* Bring chip out of reset if there is an assigned GPIO line */
>  	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +

No blank line here.

> +	if (IS_ERR_OR_NULL(gpiod))

This needs to be IS_ERR(). NULL is not an error and we
cant return early here because there is more to do in
the probe function.

> +		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get GPIO\n");
> +
>  	/* Deassert the signal */
> -	if (gpiod) {
> -		dev_info(dev, "release reset\n");
> -		gpiod_set_value(gpiod, 0);
> -	}
> +	dev_info(dev, "release reset\n");
> +	gpiod_set_value(gpiod, 0);

If we drop the `if` here, we should also drop the
dev_info(). gpiod_set_value() handles NULL gpiod value
so that is fine, but the message is just noise.

Also, gpiod_set_value_cansleep() would be more
appropriate. This is not an atomic context.

>  
>  	data->regmap = regmap;
>  


