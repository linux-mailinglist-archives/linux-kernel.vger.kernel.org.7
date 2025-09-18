Return-Path: <linux-kernel+bounces-822772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3FCB84A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFA1C2057B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73E304967;
	Thu, 18 Sep 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I5NSZtqG"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CEB303A37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199509; cv=none; b=sA/bALa7goFDWecHd65AkrUcEwfw5XWf/SnWWlhAzguJwXHd2JRwIQd93xDF2jX61+Fu7C0FNj4FTcI2s08zheSCcVeoRD9qujfoHXI47yVCFSDth3IYBh1nIcIfFwVIw0ZRixFacXQeWa5o+clxblkW9ovRH40qXr8xbBnTIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199509; c=relaxed/simple;
	bh=2r2DqH4kvoOqNFyWz3gLh5tGZx1qsaQVdjaRa4xm2C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXkwq8odqOd1Wo2L0XC6fEyFxxSWpBAwc7J6CJqME3wZeCZH1QHw+FSzY2AGsBECUWH9bwB4A3LKNz67WShCyGRrNQf24cOPXy5pOOv8XxAbQYhquE/K1nRlXowLNubmNsVc2iylDSKov4jDq3eL2GXYDa4e03QxtdUvV9aYRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I5NSZtqG; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce5be7d0so384434fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758199505; x=1758804305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TrHcbBVSV/CFq3OKJf1oeKcQfVMH96LOSkAo4pIa4YM=;
        b=I5NSZtqG2AD+0MACfQ0bN5pt1qTLK9h6jm7CrjLSY0yDfcH5RtDr+ehepqmUirorgY
         NiaCzu2FrrgljS6TlbFgoAIb5FOpbnmrRJRYExqisM6sABy6CIwDsyoZhOvRWIAqVS0Q
         GakqnnfKLDftZq584JXUK57fN6Icj0Glsf/71fT7/TgLOy/L5lydGf8djXxBoZmvlcdW
         p4dtSgwhRKOFOLLSCtt8H2teOjQYuy748QOvR4S890D3aoSb6O2AN3CrHVfZRw7JwXgk
         17FjZKPC18UJxaXnmzfiLks0/2X9IHzTRhGiLG4zulY3GGXYvIwgUJHrlibfLm9JyOZe
         9CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199505; x=1758804305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrHcbBVSV/CFq3OKJf1oeKcQfVMH96LOSkAo4pIa4YM=;
        b=rH+lcdWt9ZzS4LsfcSK4MkzXaE8fL+KVmpYOvf+hAG5zQrPC0w7WooQ5eJgom8GiM5
         br9XOKBAhO12SC7oE8g3dtxkVMQ+NdZrMNFxq+946b1nzacnzv2VjT5joTPbpr2/+CwV
         baauU2jzB0txpxD5TeARUjHbuvwkQ87LxA2yHuI5ZPyevylDq7PDWPhYyORzkE/AlJvN
         ADR2ovm7F8kNN53D/ikLvdtdV7jgKwEi7yBOxrb2eOGIun9TnZ9a+gS8wDqHg1X73Wlz
         fm1KsSfQQYrL1QRmvxIzTibQg/oJYWYzzqE7ree7uu6VaF+aSRbJeFkZhSzGl5s6twjC
         GBeg==
X-Forwarded-Encrypted: i=1; AJvYcCWTpJIyTLQjivCr4vHP8egoCGhmalt/87ppy4IvLh8EbizPkHZ1MLjMrXdMlE7gvKJMrXGC4EieGfNu9jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOR2B9FK+IE93/IWLVKCax/4AwXlxRV0srFnt7nQrNKG8GTsS
	DJnwx3vuwaewazeftgTvf7221g+1Cm/Udko8Zg0W1zst2lP32PS4gIoTtlysbmJuwFk=
X-Gm-Gg: ASbGncvKo7jupI9oPJQWt3aKmEufBJyHUYZY1Rzm9TUYrfv3H7cxVC7vC3B/GtL3rIK
	Vy+oOUPXcluMJvyQu8S3VtOfFxFQcJf6yskzAsr80JuUk+Wd5bfZHr84GopS2Yx5QbIG4aujl/V
	TETtI7vYiT+Wyej6Xipcye2nFmf7IXs7UxrCr1JXVlsjwOw2BaKj7TNnVN59gNbXLyZqB+AHyAA
	pp8O4UE1uhmpgw212YGRioeicAdOZJMKdaBDWL0veqAIo31IKDNU2KmCDqrXTnvVEl745VEbHvA
	UXYRMvg9MxEX+lo/wwG03qluzB1aNssWpjQJpOIjj6M9Dl9hZ6WlMuhtosqElfKhNCpzuwR+iey
	Lbw+FxGuvbqPbyzz5DsrmIYMoMX+LfRreqMtHOVRA1qzK+yUwcalW3xY+sukHBkZXJTKbBr8ww4
	uk8xp/uYaZc/PunaiUIw==
X-Google-Smtp-Source: AGHT+IG70b8bbYjlcdip/AFDOzCWeuKNJgx5mvzujZIIYrYwil+TyN5Ijt1aBQfWNQl1ClewrC8Uig==
X-Received: by 2002:a05:6870:9e0b:b0:31e:1def:1e0e with SMTP id 586e51a60fabf-335bf200f56mr2999250fac.25.1758199504895;
        Thu, 18 Sep 2025 05:45:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e637cad3sm1393268fac.29.2025.09.18.05.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:45:04 -0700 (PDT)
Message-ID: <c18d6200-3f42-4a84-bc15-627d1a4174f1@baylibre.com>
Date: Thu, 18 Sep 2025 07:45:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: rtq6056: Correct the sign bit index
To: cy_huang@richtek.com, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Hsu <andy_ya_hsu@wiwynn.com>
References: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7e43ad09f814d63b570ab6b2b9fe3fe17775d22d.1758164614.git.cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 10:10 PM, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The vshunt/current reported register is a signed 16bit integer. The
> sign bit index should be '15', not '16'.
> 
> Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
> Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


