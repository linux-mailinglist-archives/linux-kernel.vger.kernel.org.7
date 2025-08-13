Return-Path: <linux-kernel+bounces-766898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F0B24C71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 466A74E034B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C218CBE1;
	Wed, 13 Aug 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c6ErBi8T"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138382D7395
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096659; cv=none; b=CQQ21vq6DM5iUpv0Mi6lBuc4GsGr0MBwz7IR6XP+lhJumKNlzu8w3w4Fg9HF++defEMQa3xE57EFI+K/F7TBiY5pNpTsQNs4XhRJVHLqygFVboEtFd+52CEJhZijevINZcbJOyMwkn8YXyy6PRa1rPy2SYAGgbkmwZe0i0L6834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096659; c=relaxed/simple;
	bh=JLR0HDB+sugXsigzkPLR4y5+9MWTZ/84rhQ5b38TEVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnHLJjb8MNhYg8I9ZmmHwOAp8civsCssUSMnNkkiXhXJw45UXP/C1IIuusBv0T06WU1VymNQu7YdyeJVI3czjCnbmlKHGn67yJumX1fg2hC9NlK2YZrQplLuk5SuhuID6nkO3M6zrTAWWzGSTUcvjA4dUMu/6YbNKeHCRh/MqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c6ErBi8T; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-435de59ddf7so2437b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755096655; x=1755701455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+UquFq/+wFnP6FXzNP7+1OTyftKdtGDXwqAPY/zJW0=;
        b=c6ErBi8TNxS6xQnsQ99ktYkxpB166huH+MC4fiSMIgoE4lO7g3PYk3Nc7CC6ep36wS
         IQs5WAS1d8GZOUGHc4A64sY491hKzyURGZWNoYT6ZZa5f6sEPJu5/8Zde1sQnx/aEAyG
         xd6omGi5i3yFa9V6f6t89GVgMC+Knl5WQKGuiCdHNKzGIS74mnR7VkncEpDCWnJPY6GX
         /ewcM0s3dVE3/YeLFf6oMC7ejXAD1S5iWdCAeapmf4fFKKB5xzES0D/wL3Q0h29NX2V2
         5D297TJkUsNtRcGsbf7wignyid5PH5a3+Q5yTtP5Jy/vGWw/iw/YOURYjhyfPCYOSAsq
         bDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755096655; x=1755701455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+UquFq/+wFnP6FXzNP7+1OTyftKdtGDXwqAPY/zJW0=;
        b=RWJ+ft0Qi2ka60rRF3N3rduSh6B+7U1tMAldhmNELivzG5fEcE741bXSREDDe7pY3G
         BAJSgkBVVzTOYYwTMFaHs4wWypN4766souOkI7eFGjhrxoJAAK272FgDmpRYJNdgnQZF
         2E39p48pS2j8+9Z/p38eyb2PJkOj5+Ca4wwWsCdCvNelVmPCbEOvwjf2RNeiQaEwvRFU
         Z5UHkOaGEYS+fEVu7dBn4oeNBlyGBOs3DXAOeXMfboE13fnmNQ9JN4e2n/heVy9icxS5
         gjsfqy8QFRpeuUCF3yu36AR+I6AJBr7Y2EX7cXUBx3ReSfMWYuLQud0r8vl9P3w7HTUM
         UzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuSW4v6tnIQsDnNAaAHDKs0lHPvd0IQU4gM/0LFGLxULeZ2eRIOEOAK48IbluIxIP29D9tcUGvmoSO+qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz20eTq/+wDN+LTtfxwZv8gXcTrTkx+sv+Lx07qds9uoJ5r0dEC
	7zV6+krGhmEI1g6Mtfv8nGDHMhJ2ASPxwNm7uP/LqvAmDCO2sSCkBf3YxssXWi8jxHY=
X-Gm-Gg: ASbGncvJgdsbaRxOSzfnKt1h9sLOJ9FFAoOS69NOLtJzY66dxXnSb3m/SOT8bBPewHu
	fUK2WXoaL78B03faByzOIThVh9/yNualO5W1A8pGVtLU9fBRz28+z1D8cflo3L0+cLKXmg/4p2a
	NclG90Thd8JvNDh+bd4feQUReGMHqiEchYaFJULI7eho57tc6sQH7ET82ubeZC3/Rxj0Jpx/qOK
	/0Ni/jBCFpNCO0y+AA0krW9SU3JtVPiUzTawRppc1w9VeYt2ckxHix1Ao8zNAE7lMueuheBCToy
	UANcXZrNn3Zr1cKqXNFPXgZrRuVksPSFDn/N9Ia6dWv+uVhCfL9n7y+OAXTT1SY7zUXZdmciVIY
	lpEdojz4UuJcUaoyNiYs56Gt1FZdjyuDADsxXrRgKMBuCyAohyIX7WqelHwx/SRbMZA1wjUJK
X-Google-Smtp-Source: AGHT+IHiF8MN1FZQrTnzJnSv9CNFxA7tA6Te9YnB/LJkhWovfk6NtiQn4dodjNFAsr5GNuaK5WqtRw==
X-Received: by 2002:a05:6808:178a:b0:435:9705:86dc with SMTP id 5614622812f47-435d4276988mr2027407b6e.35.1755096654950;
        Wed, 13 Aug 2025 07:50:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce74ebb0sm668253b6e.15.2025.08.13.07.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 07:50:53 -0700 (PDT)
Message-ID: <dc817ac9-105f-40c5-806d-93db95955628@baylibre.com>
Date: Wed, 13 Aug 2025 09:50:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: adc: ad7768-1: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 9:49 PM, Jonathan Santos wrote:
> Use devm_regulator_get_enable_read_voltage function as a standard and
> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 36ba208fc119..d0b9764a8f92 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -225,7 +225,7 @@ struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
> -	struct regulator *vref;
> +	int vref_uv;
>  	struct regulator_dev *vcm_rdev;
>  	unsigned int vcm_output_sel;
>  	struct clk *mclk;
> @@ -809,7 +809,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = regulator_get_voltage(st->vref);
> +		scale_uv = st->vref_uv;
>  		if (scale_uv < 0)
>  			return scale_uv;

Can also drop the error check since we've already done that in probe.



