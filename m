Return-Path: <linux-kernel+bounces-823497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3AB86A82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD035660E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E952D29DF;
	Thu, 18 Sep 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zQtHLl7I"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFC274FFD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223182; cv=none; b=hStXxEbV0GF18kXugVr/McDID19YJQWNHFLN45qY7FbKa3GFXq2IqntAsrkpcD066hqZwqSlZbW5Wg17qVdvvU0CyR2RUmyyw9pqSuyEvWSdvhasTeYOD4+Pzkk5NM57lSeaoDKe7DFr2Jm0rTmJTV3u89fSK3thbjawPkWhIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223182; c=relaxed/simple;
	bh=VAds+2wzYTdgT84lPSyZuzQ1VykRr5iVJf9THaSbedk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMMRewpJzgH3vsV+e32e93dOlfmVZ80e2qDAlemyq6tJHgC20PgtnjVeY2KaVKI/uHyDODSPyH35VnYXUBgdIfDwp30Wo4Rluohyo+IBPOcT6gJrLgHWjL6Awaxpd6zxE2n6oW6oyt55+q9cHKlpSkufHsEpLtHQ9Jn7xw62AJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zQtHLl7I; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-745a415bf72so581154a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223179; x=1758827979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=zQtHLl7Iorfc9SfkZwEg/3fvbJiHAoF7kl3AnRY47ZIFEX6ytjMBBas/bT/S+U7a4M
         1DIMbb4aC4eaWscTqm6W7FevPXiKw+9b0WVdSR9P5PNeTblxszszWONnjXOldqAOobIf
         d4hpK692wbFMJiLK9JMG+N0uqzgJwJVnZv+wjf5QDDfTqXHbr0/Nqeqh+hCNZ6V63zK5
         UMaKPv5QkbWKTyeoowY41KZWsvfcVGut+/iCoQ9EfluvhXagxqHBVkwI1hFUrd3FLdDB
         YG1Rw2PfTnBZGSNZuDy8bad/yYxe3nKyEAlEe7S3iOY2ibT+dQtds4bKBmr1ZlCFQUov
         SiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223179; x=1758827979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=uFNC6sVFh/h6niI0tf+rDhIdJ+WISGXGOqZ+uwtz3PzAZ4o3L0LYf3LcqGWKae6Iwq
         7y1w64Cmip+WUTEGpI7mR8z+Y35AmQvkVNWr8d/Ys4tlkSyNTU2q18RuW5s0Oh9YknYn
         7CIgHQUuPKf+bwI5SsiA2YpGNupwBifNS5JCQbpE592AQqbr4bCLnHhdXlyiWxLKCI+q
         15QHyig+jaUWsKC39wVfU7QJw8B1WQ9Im+EPxVWtgY1IcOgh9wQRD5XbAEwOvp0UpxkD
         RAhAajfTlzmzE9EmlJAQal96/KBdfGfgCRWi61Fh++lr53LvOwJuqqjXH3ik2rNHTgM2
         F6tg==
X-Forwarded-Encrypted: i=1; AJvYcCW497wSWg6RCscKOw/h3lyEU2pDQ71n54ZqAjz5nFha8ac2mB9NztupUnW6tW7Dh0S/WdybanIVZwhs4nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ih2UM92b5XgMrtrPAOGNdPnIEZyvMdN27QgbuUaNaEY15Fm1
	KsmDPoKHzahT1jCyB0jgmWF2A3GjdUnbNL8X0VPr9B1ZsP/RREgcyI3q4CloGCme4kY=
X-Gm-Gg: ASbGncsr4JxGyvUmSJPecEq9qdRisuNHaZJ39cgDCad8AK6Zot4sb6+bWO5Qa+qvdAe
	wRbd5HRH5OAxMLkeB0hvbjo/D9oPE/X/3F22KrqgnSg9cwEuu0jvsz44UtWrHcsrGOJoEDVW9nI
	oehHRBC9Pyg3u8l8DGbykco0mdfx/Vheo8X7s+2lXzWnYFYlayI/ZOFmgRwwuDsAImoL4hcfC4Z
	ZxvZLfPzmtGw+TFlUEfSE4Yipg3kyCmpSjSWKCzkot0wMnr8DblyPiinD/SKc4FwBEigcFqQzM9
	xAB9hxUJ6glWQIXOUp8iIJ/01ReX+yMdYHneMcDqQD554uKpDb2G7hMk7of1cRUk3MAGEqUw1sq
	X9qqJzWOcBTto8gojZHjF66l17KMUeHUxzH0noyKwAV30+Brmuw/92xAN8uoYs4/PiGp1fFH4Gv
	D1iFWMcz/x8pcBLu+bQg==
X-Google-Smtp-Source: AGHT+IFYizUXzzXfO+m4EDIZA0JMmJrXu4MhcrJu81pFbRnpj6sLHpXHOc03v96Ezh1XqVDz3IUWwA==
X-Received: by 2002:a05:6808:1b26:b0:43d:24a5:e9ce with SMTP id 5614622812f47-43d6c2d02e5mr324464b6e.45.1758223178893;
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm1751557fac.17.2025.09.18.12.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Message-ID: <813ddecb-efde-4c11-be45-e894fc52f752@baylibre.com>
Date: Thu, 18 Sep 2025 14:19:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-offload-trigger-pwm: Use duty offset
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Pass the duty offset to the waveform pwm.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-offload-trigger-pwm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
> index 805ed41560df..3e8c19227edb 100644
> --- a/drivers/spi/spi-offload-trigger-pwm.c
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -51,12 +51,14 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>  	if (ret < 0)
>  		return ret;
>  
>  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
> +	periodic->offset_ns = wf.duty_offset_ns;
>  
>  	return 0;
>  }
> @@ -77,6 +79,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>  }

Does this really need to be a separate patch from the one
that adds the field?

