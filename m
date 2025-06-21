Return-Path: <linux-kernel+bounces-696785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AC6AE2B69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 21:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545871897F37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306A26F45A;
	Sat, 21 Jun 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sLef4a0G"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AE185E4A
	for <linux-kernel@vger.kernel.org>; Sat, 21 Jun 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533487; cv=none; b=gRq7Aqki6G/lx3MSv6EpuJ3/uqRZx/om/lUxitLeJf3BBcj1WNeYPL2t6vrSYLA5W9Mw3gc26uuIxChNJISzdLBlzEacFHzkhBvkmNsh4gtKR3KHNGtbSDvdue30RkEle/AE8vTUuGJyVHG7gAmqjTQwG75BnHhYDXavxNXYJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533487; c=relaxed/simple;
	bh=XE5B+PrttvOG0WztdNX2inda4S/t1YtPipFew/hr/4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYMEcTX70jOwn28o/Vu8nwl6pR38CVzNK0yX+C8l3A7eY7thCNBXT9MMIzsvsGUw+jIKp80LTDrcaanS0uQ7gLijVSlmA3w0+Zib4lbzIiQprzEvT6ISm12p+S9zNHETs4reGp0sPBUah1MIW6tt32G9Urg9nLFgkvKt0n3iCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sLef4a0G; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40ad1f7c23bso819581b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jun 2025 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750533484; x=1751138284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDqnnBv0DNrWAt+UkIR6UGFfAeWU8x15pwwMWRrWyZA=;
        b=sLef4a0Gl5u+64mAUfYYSJR3IX6eqScn8OIYdoi82x95sNwDd4iZPI1NIxZuqY3vFC
         K0U5OExu4EBdFapKykWudxVVSmeyAl0ru/FoIO4nTp/L6MreQYy2fgK7t7GpanW5WXtg
         qBHaK7qVlZAUnY3bLQ0MDPYWEZR+Al3JHiaTi5lIACIQZkzW5MOBm9b61gDoaILBiNCe
         Y0g8rIpOjX4oyjbPsXEAIaXTHDMfK6ySVCEPz4JEMStOGE1aeu8BgV9vn3u64P8vNjkk
         FbpZ6MhARV+s/h9Qgzp+8fiLf0DD7feyij7f8uJ52bzsXmZFyBJupcriEt7CvRlUnUFy
         525A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750533484; x=1751138284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDqnnBv0DNrWAt+UkIR6UGFfAeWU8x15pwwMWRrWyZA=;
        b=FkL9dSO+KQ/kewTTEZTVrLhZFHMieFUGl0EFbAR8xEHMioD+ryDLJfOTzljlWeAJb4
         fC2FaCtuBPTDcur23G8C5f2Yz0QXUT+aRqNFanCjC14i+fJEWzK8vo2l7rTNZJRcg0yG
         tH784MbRWheTSBmcUFSL9SAJ45X1nqzNixJbjF0M3FDB/Is7MS0Ble3clsEaPbZJWOqM
         hB4hAWI+LeV3YtPf0OLZB+hFuqKcZbEDl3DC2hHy4BmP12KqErjlSvGw6TS0Pe0i9uRr
         s1eKaDLpfQYdsouEanvPbU2qygoE5HNZhdkFIP8cyEKHP1iAViemhjLtqBjh+xt4kjoQ
         dtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6lUAbBUFi9fvthDO1z259/LM6Tpt8aJZTp1DpjzfXbBSmkIEp4sEU/bQumR4RyhXpUdq1eAMXue26xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50iS1HVMMpOnrXYZt1j/xLZ1RY/P0eL085R4S4GXTH39Z6kNf
	Ii6hINgKF1F0pRq1d96oNaPj6B9OIGZUzc7rYU5+VyJgKhKM0U2bTs/2D1/smau7Qlk=
X-Gm-Gg: ASbGncvZ8mNeujyZdFQZFPLLlZAkAXdr+PZxpiWNsK67zTe/fIstcDlFiGQ/0eAxUoo
	WvdQx+FHh4pjO/HbjP5ZZlVRF6m0yBu+TFoyT4ieYMDJG+Qft/30JE2uSAeSI1gLkgv8j6uW6+B
	oW7VSPJwK0IfDIi5lNPHc+JWNrfyphxQW2ZETL4r5K/bdprSdhvBdGmO9Pt1kgDSTxCFMYi8Xu/
	fh62hHkQdr/MIBi7aHb5uNo/QSOAwADX+FzORn7fSE2IEOzlrXxDClpqAoPjXRkeEmjVV8K7E5P
	krDs8POjqFk8pIvJzG4ZOW/Oakt8vV3la7TL8AeyPtOy5ZIcFjJdsUE6TlTAxsgkHYtmlVt8RXT
	1T7+KwhVwsf/hbLvtds7LsjWlnsixFeTWXbJJFA2Vy+lTXG2alw==
X-Google-Smtp-Source: AGHT+IHNg+F7/FEkXh5lzf0AI+54cGfLcpIAxTNe2osOdreyIYLLq1fTcJJ5ffTvCxyOVUG8NIlGmA==
X-Received: by 2002:a05:6808:199d:b0:403:51ac:23ea with SMTP id 5614622812f47-40ac6f69cd6mr6064565b6e.9.1750533484042;
        Sat, 21 Jun 2025 12:18:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5a14:cde7:1a11:c454? ([2600:8803:e7e4:1d00:5a14:cde7:1a11:c454])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6c30aa7sm771843b6e.20.2025.06.21.12.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jun 2025 12:18:02 -0700 (PDT)
Message-ID: <8437d9db-8123-4c50-9f5b-b9adf265f32c@baylibre.com>
Date: Sat, 21 Jun 2025 14:18:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: spear_adc: mask SPEAR_ADC_STATUS_AVG_SAMPLE
 before setting register
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, conor@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250621185301.9536-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250621185301.9536-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 1:41 PM, Rodrigo Gobbi wrote:
> SPEAR_ADC_STATUS_AVG_SAMPLE info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register. Since the value came from dt,
> mask it in order to avoid touching other register bits.

We have macros already that is the usual way for doing stuff like
this in the kernel.

> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> During the submission of patches related to the yaml creation of spear_adc [1],
> there was a discussion about the average-samples value/dt property. It turns out
> that the dt property value is direclty written to a device status register.
> Considering some defines at the .c file, we have this:
> 
> #define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)


> #define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)

Replace this line with:

#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK	GENMASK(8, 5)


> #define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)
> 
> SPEAR_ADC_STATUS_AVG_SAMPLE info is a bit field coded inside the following
> bits: 5,6,7 and 8. The bit 9 is a different info, vref in this case.
> Currently, there is no control if the average-samples is outside of allowed
> range, which is 0x15 since the driver exists. There is no documentation about
> how that information is managed by the device, but I`m suggesting to add a mask
> with the max value for those bits before configuring the samples bits.
> 
> @Conor, I`m considering to add the "Suggested-by:" with your name here due [1].
> Are you ok with that? If you agree, I can submit a v2 with that.
> Tks and regards.
> 
> [1] https://lore.kernel.org/linux-devicetree/20250506-equivocal-snooper-8a7d1ce931c8@spud/#t
> ---
>  drivers/iio/adc/spear_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index e3a865c79686..cf412ece90cf 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -37,6 +37,8 @@
>  #define SPEAR_ADC_DATA_MASK		0x03ff
>  #define SPEAR_ADC_DATA_BITS		10
>  
> +#define SPEAR_ADC_AVG_SAMPLE_MASK 0x01E0

...instead of adding this.

> +
>  #define SPEAR_ADC_MOD_NAME "spear-adc"
>  
>  #define SPEAR_ADC_CHANNEL_NUM		8
> @@ -158,7 +160,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  
>  		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
> -			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
> +			(SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) & SPEAR_ADC_AVG_SAMPLE_MASK) |

Then here we can use:

			FIELD_PREP(SPEAR_ADC_STATUS_AVG_SAMPLE_MASK, st->avg_samples)

(#include <linux/bitfield.h> for this)

>  			SPEAR_ADC_STATUS_START_CONVERSION |
>  			SPEAR_ADC_STATUS_ADC_ENABLE;
>  		if (st->vref_external == 0)

And do something similar with SPEAR_ADC_STATUS_CHANNEL_NUM() while we are
at it as if follows the same pattern.


