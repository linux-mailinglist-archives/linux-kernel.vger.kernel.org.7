Return-Path: <linux-kernel+bounces-732188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BBB06331
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76BA176BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF324337B;
	Tue, 15 Jul 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gjg2LBOX"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DD1FF7C5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594049; cv=none; b=F7f7U12mficUDidl+XXbkG1LQLwC8kHB6IxbWKxwf6FuWEeM/5glzhm+TGRQi+Q4Lrn448+s8yd9fQrgCdPf6obPl5Smhjxo+LbGK/wyG8x+KZk1HkbNzEaMahAnvsThyG2d6J+kY21vdyNnkiOwj58IZmxnfAPqA0/nGA9krh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594049; c=relaxed/simple;
	bh=KZXOlBZn/rmUm1Q4aIgSZSGz9T7kc7vaJG2a74RKDmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9EhaFWmPjYAjKHptJ7sVvTjOuyGExIjAzxlrJpdEzD2rb0G0pIpjBACwfnMc4bqevMxmDSTebPFqC2WVBOOOVz8H1bWxxA82fNxuH116U3Eswl0Mnz1bf5O0cEbtg3UKn5CrJkZN1M5bXHYopXIhd0TPk3eP9MpkGC4sLNdSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gjg2LBOX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eb6c422828so3529129fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752594046; x=1753198846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvoEjUb/iWQIWBM9X6EO9p+HH0rv8UIyY+iGcZ9kt2g=;
        b=Gjg2LBOXDvYHYLuI4ei0Y7pHoaK34UtmcLWbz+s6EnPLA1HBD7iCz8eBFO41NOVYFG
         n46QP5FdKrxojxk1Dt4fexaZ4PZOx2zZEyGfi6e1u6RkPhgKDCUDh024hQnAjH568yCM
         FqEG+gziZOrF7vBfas9lPYELBCy6fCtBAJbL/KflU6XfOHIWRED6/1utedCfvtv869hC
         aaZambSEmCa7Ks18vSgQoV0PAPSZlWYm9tDXokjaakbZKWhB/LFeFaojyUrc7j0i2HEM
         mQbw8HJ/bQOL1664Cuia+f9q144gnE5OD5FREE53AOb/By/37uRoiIo7kV3wGIHfo+0s
         ndnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594046; x=1753198846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvoEjUb/iWQIWBM9X6EO9p+HH0rv8UIyY+iGcZ9kt2g=;
        b=Nv45SvZcegz2WqZxP7LFUyjZitVtNEcf6bs4hf2b1wj8xX9KOCL5TPG/8TbCSrixIt
         KxHV3UExIB4GM5GLJqKLWqM56IszuaG6Wb0/Fvrw4UnU+4NwsqV+boyOt+ewN8RKxleN
         4j7ROR9kjxW4IxswRFA61DkGyipL6YF2gPDXKxSpoaQNR1Wb0OnNsykuh71ZOD79na6l
         bP5on8C1GFN2cSaSXeOLMvzJfZWKRrh1YRPYxzjaFQeIA/QgOjbC3jEcZaRYAdly5uxi
         VUhJ2SqXNnRtQ/5xi2tgkEo1WbP2+bUT/izRvnIpPV8Y1maoAnjWfHemb8CsM7jRo5K/
         lBvg==
X-Forwarded-Encrypted: i=1; AJvYcCULscW8Mz1NSYloPmJWkbxp1ndeuWxCZOJe9M5s7U98zai7RvsvTwNFnQfsuCSICWpUXq+D3k2Cm/FcQno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zNSRe8d5F+skT2sz3wneuk/DUonM9LTMcatfNN/WJh73FgET
	tqwv308QSqpLVs+06LCPVKJToZRjA01SNKH54cTBXunCrkAZKHqFBr5YCJuz72U+GxY=
X-Gm-Gg: ASbGncvMW0U8iy2jsOxq8vV2A+Ypd3JD/iJcea/irJHUVkGZtZ5fUDI7nyIi5Jsg1DV
	2gtXlNUXLLt/nlPBVIA4thFXNYUqZtEshfk5iKTyxUP9yopX3OgyxPdEOOV7/pXKdfUxfbDuNl9
	bqJ+KW7bQn8KIDD/GYqzIEGHdWJcVecfWd5HI1Y7zUILL+vd0zvaNXDxnhrvUEoTf+0GdRvN+S3
	UGGO6DWxBqVFOSxZnlgDdr0Ik+WDoVBckfSOhXZ1iDrxwIcQ1nHDFCvHAXW9Zogzmau1b1s5Deu
	DEiKfKcUTREuIOAxumIrXdSd7rsYss6cYzAeKsP6+6zX/RmLM/ZmFEZkZJwkGo0rT5bnPnKmDg/
	PKBN1noBBbO0Is/g8cSzH6+YwgonzdR4aG6w1t+mNnkwp7mQ7vr5oi4PSEAN5qkVxPkRrqe1GeN
	E=
X-Google-Smtp-Source: AGHT+IFKnhFNmq0KlawFl9i9Ft4HVwBOdlLXRHqle59J+ZLR6M7llrLVhScKC1ZYnIt69xEPFqu6Tg==
X-Received: by 2002:a05:6871:3143:b0:2eb:a01a:11b1 with SMTP id 586e51a60fabf-2ff8fb90c48mr3711951fac.9.1752594046499;
        Tue, 15 Jul 2025 08:40:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b? ([2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11236266sm2668611fac.11.2025.07.15.08.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:40:46 -0700 (PDT)
Message-ID: <764c464e-a45e-4d19-b9d4-a238f1ca84c0@baylibre.com>
Date: Tue, 15 Jul 2025 10:40:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and
 SPI_OFFLOAD
To: Nathan Chancellor <nathan@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 1:30 PM, Nathan Chancellor wrote:
> CONFIG_AD_SIGMA_DELTA uses several symbols that it does not explicitly
> select. If no other enabled driver selects them, the build fails with
> either a linker failure if the driver is built in or a modpost failure
> if the driver is a module.
> 
>   ld.lld: error: undefined symbol: devm_spi_offload_rx_stream_request_dma_chan
>   ld.lld: error: undefined symbol: devm_iio_dmaengine_buffer_setup_with_handle
>   ld.lld: error: undefined symbol: devm_spi_offload_trigger_get
>   ld.lld: error: undefined symbol: devm_spi_offload_get
>   ld.lld: error: undefined symbol: spi_offload_trigger_enable
>   ld.lld: error: undefined symbol: spi_offload_trigger_disable
> 
> Select the necessary Kconfig symbols to include these functions in the
> build to clear up the errors.
> 
> Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Thanks for the fix.

Reviewed-by: David Lechner <dlechner@baylibre.com>


