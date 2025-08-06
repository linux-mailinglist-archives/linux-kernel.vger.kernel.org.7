Return-Path: <linux-kernel+bounces-757965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F6B1C8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E52626B65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2B292B45;
	Wed,  6 Aug 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p95Pv6kX"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AE19A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494834; cv=none; b=JFW+8O5JrqDL0jihh1evpSqi77SwJsgei+l56ok1HqOlj2Hd9dDZtrERU8i1yuh1OQDwg7ah6x/0BtKuAOKLv5hHCFvR0+UPPu90LT3wk3H79d6hEGIBVhhLAsIFaNE4sj8ODr0g+IHRbHsFWlAhSXNdpGSqvsJsxRozlZv5WSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494834; c=relaxed/simple;
	bh=EeT0WZ+eBX99CaEowyMa9N2mX+gmwtjO7hXeuDnKxuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpDE5p2D8BDtw7UxkVytV4TeOIpXRVUJfmXHsXe76DuQW7GhG+dqMjCfj1jrKWyKQ9iGizpFdey5MbTz9kwluiUS24ljkCTTAXEYYTdCni35ULPioUdoKxkFsAkOTnfBBNL0iWg76OeqG4ItkkZc4aSF2Ns7Ep8yDcLDQfoyfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p95Pv6kX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea080f900cso23145fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754494830; x=1755099630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQBK2IwZMWMMUUwJMnG9AhYt75ddXd1X11p/6lNi7YY=;
        b=p95Pv6kXTjTDsxOxBsMpHJY4Y7y/PHFK+2NwFWSdbD/rvv/B2IbdWYQU842zzvANXd
         PbDcMhqzH9wIYg/HiDBsPzJ50NlGSRuPVzmUg0JJqRTqXSyR0uVJGbLLJqulD7q5dCch
         nXfpfT/9F8hf2lRycb0862I4Pd0DoCk7EkHEdLuoOqAjNHOVqQ8UuLsJbnd/5lwfzOe4
         pckE8gJZtw8LvvzTzEJGgjbH/OPV/8HhhYZwRgeYP+5NDzUnQi38VPr7aDNxxGunQ/bp
         /KJMEl+sMP2Pdjp8MZnFxDUhDYOsCipmEbbgASKK/4Y/TmAzED/SmoJp2kuMWqIqbILh
         z2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494830; x=1755099630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQBK2IwZMWMMUUwJMnG9AhYt75ddXd1X11p/6lNi7YY=;
        b=gKHxapLScvPZKylqt88kNSD3ZzxRG9HYU/yn9DXuMoMRj/H6G3o3CJaNsXPRc0htYS
         EvFqhCIhKAcGdl6WUoOyI0qiijrNewvvdM+XIJ1ON/MD1KWxJadAC7f3hBGgy6kE8hUi
         23IGHu5czFEuMd5peMlQOpQ55quFHvqRcglrQyZBUWKL5s4sJ+LBU8hraPicxRSg4wX4
         s50s5pFZcWdo3FuFpVhBRjxo/RFLL66NFlvyBmkMlcnykFBLyLVzybdaAcPX6yp9VgcF
         L53UpYSJAcCzdGi03ayk1swNgRLXjBwHndcpVWA/KSBnX9HwEsUekBqlKWaT5WQYp0sb
         9L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2frORPslaGg6UUQ4k/5XOjrtLLyA1Mo955VFHA4Z0PXc1NCYel/eSrS016ZTXRoD3QU4vRNwEix70b+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTz/mfxIT89RoFpvYUzxr+LgOOGl6TVyqEeiMUdXMdaXjWXoH4
	geczv3Ck6b2mGZVimonLQlW0NbvIu+yGfELEDxSjj5YfwViHml6YmqTfjxE0VPauyWw=
X-Gm-Gg: ASbGncvef2m49n6JUU01mNpc3Fp1FP7Ccs9E2TPXtReBkb2c8cevBF8x2q3irEAGK0Y
	U1+Dd7loA0KYMr+ss4m0pN3nr5RYM75RFFHb9mxF6AQ/UD+xv7A7ZVPvwQxZ8A4JFwkHPsw26ET
	GZYKYaPs5iHVmI8Ch+LTXyZGSAmNMpa8gsMzdMY2WT/sLDFuTrXSo4STEKEPsKJnWJ++QQnqYCP
	6BPpk0bf6V77tI/05O+XLyswiYcSUebQXvH6kgRrALKxAQ7JpcLMcJHNBjxV3x70GF9EAamEooa
	XzUfVVZyCDtWhusKLWBYmm52yhxfpJKTIrpn2gHCKOdLlUpazAEWzwKn0HLrBQYuZtIz/5CVWL8
	0NF2s0bVPx9kqi61L9SEVgO9g9PQEI10A9VxLWW/b1Vk4dzNDiuD5P9bTNcjOpwpn5NAZe/lklX
	Q=
X-Google-Smtp-Source: AGHT+IGyhhBDynpJJBPXpYSNWmJwFA6wI2gd1r9MWG+zv3b0rnP9HU9ECWIyhKY0YTr/FgxMV5AtGw==
X-Received: by 2002:a05:6871:7583:b0:30b:d2f7:5dca with SMTP id 586e51a60fabf-30be2ce6df9mr2375124fac.35.1754494830642;
        Wed, 06 Aug 2025 08:40:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742f6a3fb1csm1211295a34.37.2025.08.06.08.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:40:29 -0700 (PDT)
Message-ID: <29bac7ef-c9b2-4e37-b4a9-08a0120e6083@baylibre.com>
Date: Wed, 6 Aug 2025 10:40:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ad799x: reference voltage capability
To: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806090158.117628-1-stefano.manni@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250806090158.117628-1-stefano.manni@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 4:01 AM, Stefano Manni wrote:
> This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> in order to add the capability of the chip to have an
> external reference voltage into the chip_info struct.
> And so avoid ugly conditional checks on the chip id.
> 
> In addition the AD7994 is marked to have the external
> reference voltage as well.
> 
> Stefano Manni (2):
>   iio: adc: ad799x: add reference voltage capability to chip_info
>   iio: adc: ad799x: add reference voltage to ad7994
> 
>  drivers/iio/adc/ad799x.c | 45 +++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 

Something to keep in mind if you send more patches: this
should have been [PATCH v2] with a link to (implicit) v1 [1].

[1]: https://lore.kernel.org/linux-iio/20250805142423.17710-1-stefano.manni@gmail.com/

