Return-Path: <linux-kernel+bounces-803418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3DB45F94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A841CC608A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1975322C83;
	Fri,  5 Sep 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gi8Ie0zb"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078B31B801
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092008; cv=none; b=BGEy3nTwBkXKVolbxJXWDr/Lh/A2/pEmJbfS95XfmdKY49uGV1S72P7zBXEZBt+S69ELl5cb/qE7+cfs5corFg80sRT53obDqzKpZEmQQiWbGiI9PJYzBPdARNKIG9iqL+aN7B8qRkKP9P0L/s+DX7XFDe59gMKH/CkKoUWdkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092008; c=relaxed/simple;
	bh=jN0s/h7c25JUNJUarwGqsw47/AYuJ42K931uUXRodvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URkrkD8dTuIBhRHsfQjwc/R+tX0RmHK+XRdzI6tKHkp8Boo9FbSLnGAOllfRS7QMYiTRq6IsVrAxXsQPfUT05CamAAIElIHQRFbIBn6i/LKeg3zHqzqnd+yxeW+lnxQx+8N8lilP9FW1+WJalXOZuLMupRK+oMCQg9F4bD1mFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gi8Ie0zb; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61bd4ad64c7so727474eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757092005; x=1757696805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVItyR2m2+5QjtGCrAbeXGO+ngiTgRfmo3zC9GGSyMY=;
        b=Gi8Ie0zbP8BPPd/qSAEaaNTfW/Z7wVTa0NxQ6jGwSwNlcDR2xwxBpxb8Dp8I6r8luL
         9kMG2jWsCriWDQAZp+OANr0MP5zNuGuwF/nljJSaOBhT29mko8B4owi/CLriWIJrmkIe
         mAuTX3KXQFITPgsCV0/ImYEzhFmXePg7FOFbicZhKVloaJ7wzfnGF139dhDd/Xn0oNnn
         nq7papv4pLpbpzBsaspoQUTubh6mA61w06fjoHDRBAWklprlXFkYo3cH313IQRNEoMGK
         yftZAv6bv7RVmObWtK7EJ52/EgZg07/i15LQsWT6Sy24wSOWtlmSZooo4G2JDYvPCJPI
         KxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092005; x=1757696805;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVItyR2m2+5QjtGCrAbeXGO+ngiTgRfmo3zC9GGSyMY=;
        b=R1W7wo9Q1o1dbOAtxjjEMDVgBp9qbEpjGbRfevwFNPMHEDowOvfqXkqR7RLu8+tagA
         pDWJ9Am9N7gb1qMJQ06BW0SHD+w3RvHUc8wkxM+zZ19zXOq7FHGcXmNH9CVBjFoRCKXH
         gTc8Ldmk3YqXs7+4FhbeSjAxk7VKeQyJyzjpY0z831exjpAwG/e/LY+DCqJV3MKI0ScJ
         YSaa2OKoNbrGeB9gPkPSvPXAAtAxhAEGmCptcAGl8meqCq5q7Y5TxQUAPOQO3vPR2FMb
         ST6cj4ZpKwe4GMibdwgDMDqXOAs4q4fAioviQEORs/7wAFA+3LN0N0Euo75zwvml0O9f
         VJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjZgNxCKpQi+GGEVP5vktE6cvdFtOG7n9YwpxwFYWQ4kuKbss8hD/so/7XE8i+hlXgO8quJbkJOVEPWjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrNiEjEFMDg+8kAfxJ+X655/WMYeIXm4VvutcrAr7m9Ocd+Sy
	rwInw09VNVAFvVGkgiEm/sJB/b0sjpQKOdjfFhc04BFdILfGjs5XPpNuNBANCkQ0Iy8=
X-Gm-Gg: ASbGnctUqj6/YCnn82ciLttxoiGgGsiqoOlwBOX5u0AHc043H4fbfh8W95dOO/iNLdY
	duU8bWN9+wAquGJ1EDZ5mYqF0jb4VezlNwwEX2Eoqlq50KQMAk1rX65sfKLAXneAEYkMEmN4vK/
	6jP4HKVqYaZ4zUdXXAEWF1uBQKTgj6CwYje5W+CTxhYEJFkLlFMCLinKtl27H8pvTyhvnIcU+OR
	ZtBnBpOBVx4SNgtqpY5rhesUh38v2FEfg9lbgFnajYphnSrDMu0Omp4+fQ16GDPY7HysLa1PS/O
	wBkG9SN7X/+QV1GrmOmXTUVR26QglWSad7KzZOjnmyg3HRdOzIIaoh+WptvpH9ZSXopPwy8jNuK
	tJTZM7aGHKtV7kEToaoKx2UYDhigFhpSXkTRqAWWxq+aA2DzIzAiyzOyn00Bjs0bIjS1WElkU
X-Google-Smtp-Source: AGHT+IGCip+t0CW1JF3kCxDlGyKFDm8SFolIuf1wSJVnpOilreSjhclhFmaFcTthQJmi9hElEWUmJg==
X-Received: by 2002:a05:6808:48d6:b0:437:d7b0:878d with SMTP id 5614622812f47-437f7ddeecbmr10847393b6e.50.1757092004820;
        Fri, 05 Sep 2025 10:06:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437ffed9f15sm3544740b6e.10.2025.09.05.10.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:06:44 -0700 (PDT)
Message-ID: <09cbea15-1b14-4a0e-b643-563253e2a918@baylibre.com>
Date: Fri, 5 Sep 2025 12:06:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad7768-1: introduce chip info for future
 multidevice support
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 4:49 AM, Jonathan Santos wrote:
> Add Chip info struct in SPI device to store channel information for
> each supported part.
> 

...

> @@ -1371,9 +1387,14 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->mclk_freq = clk_get_rate(st->mclk);
>  
> -	indio_dev->channels = ad7768_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	st->chip = spi_get_device_match_data(spi);

Generally, we want this early in probe so that chip info is available as early
as possible. Might not need it now, but would save us from having to move this
later if we ever do.

> +	if (!st->chip)
> +		return dev_err_probe(&spi->dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +

