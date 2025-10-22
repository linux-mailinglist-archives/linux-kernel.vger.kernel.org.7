Return-Path: <linux-kernel+bounces-865569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F532BFD677
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E1D1A06D15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD528D82F;
	Wed, 22 Oct 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF68qPQR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B50203706
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151990; cv=none; b=Yw7cZpDAukHtqlqvA19tTaC9m92la69LNVs6WIOrJhkoi7sJeJUANlREF2o474fD5wSXhlE7hro55qbi0EU1+CHSLm4ksu1aeEM3/2oJS+vkOmCltJSMh6N3DBshDpuwoh9mx609KMqFtJ7iiiv7sTQjX6m7t+QCx2HUK+geyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151990; c=relaxed/simple;
	bh=TWNVlapC7XDe+7Bz4eFmpoVx9OjVKS5JYFgj3mkvBZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip7TyFwPuEWUGHOxULesX3psX9a1SLllZLQpthtuFTvL6m9xaWsJZbsKyWD+eSdfNtqkCK4HR3OoIfJw+asI5Pb4+Gtp+n8wYk/GGg/u/V4WGMkz8bj2XVWa3h+t4D5NgXdN+KxVgRfKN5BTiSO0GDrUU4GrElmw/Ah9nMVgquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF68qPQR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so89281195ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151987; x=1761756787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aY4e+rH9vc3mT7h+8PwwOAxT7elBzdw/6Q3LSR8Xjm0=;
        b=aF68qPQRlvSQbEkuBaqSsPtpNd+BQQLMME/oqbaC/vfQUNuQYVVBdbYliik2biixwL
         MEp8tyXBuzIFzt2Fm26lfnR8jqESmV0CGXAFVg6VVOW/jzyweSlHjbGDYRE1SdbJWEeW
         nxAxB2fSYt0swIQB0400GRDh8fVM9Ne5zrAIjmkW7/i01w0AIizg+eOWo4ZXKnvr6ZsL
         AXHLL4eubLrlvWcmZN5DCyQ1fSTKBFBvbwD/2p+9/W8+/4BUITnZgqTvVtqVSXM0vLdT
         OHNmqZhuzMQW6woOKa0+LTj0qPr4DascUWfJ2xN/3Ca6ulBW2llJH7v4Npi80Q/4wWjb
         U4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151987; x=1761756787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY4e+rH9vc3mT7h+8PwwOAxT7elBzdw/6Q3LSR8Xjm0=;
        b=TysqMILsTf47vzCGLfxrVFLFMNPbXhwrl/PytzhC8LdUyQOQui0MF41pQe3tT5PZGu
         4kkvS37VQ/aDFdaAHcBNDMunRl7093l3uW4G7h9zm5xJi6NsJBudZOUZQCdJseRilQz+
         ls19GVw9HzeGKlYmf32ZG2V7OPJOsEUAKadKSNugc9vrzCAb8E4ZUhWXbijFCyKKgmK4
         A34GRoT4s27jk+sr382TvQbV/4sRTbsyNaNkAqHQjCsGKSJ/YOYoQB9LpKEr56GlL01q
         5YvmGQ41N7o0iVH4kVcP5HrKjpAWExV300XooPQywRFgMhAa+YI9bzRTh60jnk5ZHWZK
         AolA==
X-Forwarded-Encrypted: i=1; AJvYcCWvV+Y0x7iqUrd6oPhLQjf1J1PtdNAKJHBSMOgMJrvWMR0aWYMkoH0nlPsasEzrx3G9rE5PShnVLblFRWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyppk0A/p3li1LZrEuVQflxMtFpPjxuBsDoLwNfkkUBVZEXn1qL
	HTaMB6EcxjlUtpkFqXxIh3lTRoSef+fb+OxDRF/nkHbF0HoJui8KcOjf
X-Gm-Gg: ASbGncv5SNltGD80FEslHumelD4bhaiuYPJi3UJZ1iOKpHwi5B5TIIrGg4K6YEuIo1j
	SdwDAb+rLlSb9VVOGeB5x4vEvtRsLDOM9zKxbaCHwWJvLyRVTVQkj2e0ML+cHOoTIujalm9LTje
	FbSquhJgaxNee8y5rPNeGAMy7QJF5LeJamRwjUzUNXg9zZ8pYjHB0+nMD9U738aY76wQsEj6tzd
	o1KbNO5Ri5PvVv0R5VwNvBrPr9/vHBryrKTD+oInF+GYCtY4Cw5+ESi9VAHo1yQ5QS3lGVYcYu2
	P99jGbAC2Q7+wGNQP0k4ZYGjlGg50XR+Ik2gNcsbKhp2oME9UccnO2HUzAvQZ9iipqmIoLRwJp3
	sMKrakxuGqB+E/a8Hgj3G0Fe1sSUy57xOzJijB6McMvYFfURMi8gzIFU2Eio1c7Oibb2UAH/rfB
	QnTj9bQFwY/zo2hVtOYQ==
X-Google-Smtp-Source: AGHT+IH1hFsCUy1cdTiHqBd/AssFtzguJtx14vMGrFxjJf/na9wGdbimDZUF/jeOmF+hKQXTkZu9Gw==
X-Received: by 2002:a17:903:8c6:b0:290:c0b1:edb8 with SMTP id d9443c01a7336-290cbb4a2ccmr285811465ad.40.1761151986566;
        Wed, 22 Oct 2025 09:53:06 -0700 (PDT)
Received: from localhost ([177.107.87.169])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29246ffb815sm143661825ad.50.2025.10.22.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:53:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:54:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
Message-ID: <aPkMLUhm_UAVzRSA@debian-BULLSEYE-live-builder-AMD64>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>

Hi David,

One minor question inline.
Nevertheless, the fix looks good to me.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

On 10/22, David Lechner wrote:
> Reorder the channel bounds check before using it to index into the
> channels array in ad7124_release_config_slot(). This prevents reading
> past the end of the array.
> 
> The value read from invalid memory was not used, so this was mostly
What is considered using the value in this context? (see other comment below)

> harmless, but we still should not be reading out of bounds in the first
> place.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
> Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
>  
>  static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
>  {
> -	unsigned int slot = st->channels[channel].cfg.cfg_slot;
> +	unsigned int slot;
>  
>  	/*
> -	 * All of these conditions can happen at probe when all channels are
> -	 * disabled. Otherwise, they should not happen normally.
> +	 * All of these early return conditions can happen at probe when all
> +	 * channels are disabled. Otherwise, they should not happen normally.
>  	 */
> -	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
> +	if (channel >= st->num_channels)
> +		return;
> +
> +	slot = st->channels[channel].cfg.cfg_slot;
> +
> +	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
>  	    st->cfg_slot_use_count[slot] == 0)
Wasn't the value potentially read from invalid memory used above?
It's fixed now, so I guess there's no point in nitpicking on that.

>  		return;

Best regards,
Marcelo

