Return-Path: <linux-kernel+bounces-819407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D7B5A032
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006AF1C05AED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2292C11F0;
	Tue, 16 Sep 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVLqKVVj"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C12C327E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046153; cv=none; b=gzBes324odfnIIY1Fbtt/HqQhZ4Y/p8a6PGKTKcqoCTYEtewcaUF6vIDhDZyG4e0Hkz2MXiNSLaxUBjV60dBDuwpJMK0KLd05XzQCPpwhUlShCDymHEZ3bIG+N/aFPelt+Mssp34VYqViud6soIoe17aHFyXtoPcOeMkwLF4aNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046153; c=relaxed/simple;
	bh=/O6BqGKoOZ5K9649O9Td5nw4GX8SCQcR9AEX3uia0bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+S599xCFpAptyV0hGfp3FS+muv9tKV50EHYvd9aPnPoElWStsj4+wweY2BsedNFE+oOSWjV2PoJY39ApOfciCZIpmVZfCdWiJuXIBUQpgbInLt05t5y2SyzmNrGQmEKJ5VgOVfSY6WuUAWx10G9gJ7Bec0MIYbVI3bIdQp2QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVLqKVVj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-25caef29325so51081075ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758046151; x=1758650951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=393ZSVM5ykI+sxD/ecXmybLM1cMLXmjzwmWfsXvDE08=;
        b=cVLqKVVjMcIDAHwqxyco4/O0tklqV5SXEQvkcTQb5P5x0DVU6C6LCC2n3xvTRmLX79
         yiEb60uVuv0GyP4spKLWxGZBmkuRNMrtRi62RrBRY28kcvgmwdfEiJE+pIXmDT9LaT5i
         2g+OU47H/J8uFolgzPRVRw5PcJP5ZTwn9fuJJWdJ2IPwTX7CC8/OLks+YhS5EqGLrNS8
         /zNQdRKhj4OuyNAocx/MkLeeA4I6bNBGFkFU7QJEe54AIkkxkm0Zo30HOVfiKHTQ3ZpR
         weNwogvfxpulFqzmtcl6NI84reiqOIGtBmLzeINUvgbmU+oJ7akxHL+U4L++lsoBXXoD
         xxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046151; x=1758650951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=393ZSVM5ykI+sxD/ecXmybLM1cMLXmjzwmWfsXvDE08=;
        b=uaAE03IpHIKIo124FMPEBn7Vm2miopuwUI1hCxPFEgS6KkSAuMvcgQ2Aw77jc8uoKV
         CZIMjIyQN3KDM/f+qtPJuoWSdDCWu+iqEQluuypYpTDwkX1UYpvbIZq3guj6CixpD5Tk
         YOwQxMRhUsrObJ0O67QGRb8CIos8Ddf8Zb9BHBVhyDkKHDafHvTZJW1eH2gq4kD5U8vH
         B3A9s68FIQMEeO3l3t86QaRHd1L3XEOsy0VmTdert7icfiDxJvoaowG+zPmctLY0sF8T
         wFO0nCGTtE/Ao3fOMEZ9HkHg9udjFQMl8h8ni7vfvYXJuTh+O4u+j+MEPEdc1iwxJtwR
         acFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsl7b0Y0dBwa6SRTE5npt9L1KF4PUP2DwuBjS84SB3OMiH2VzYuksiYndhbZ+6dzpBJoSd/9sohSCcJAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mawnKaAGaicdHg2qNHXfuZdIbf4w4CckR0zAC7+WSfVOUOtv
	ehu4wzvw3MCrar2mu4J8waAEv7JMyuiOq8KeRlWL9JHZMYLHL2RL1lVD
X-Gm-Gg: ASbGncsT5wBdzryGiOqQoosSfVGpCrOTaIVXYzbu1JyuS/TuyEexIdDEvz4eBU8NoUL
	p7KQjtnxAkHmNdckhgGKAKPmUfnScEWDe7lnbP6T9lqFoyNd6jfT61tNik9LiUTW8qV8F1t/LmG
	TmXy5QHJUg2xKpx+SbHr5ekUsbar7UZTNVLn8RQ04JVsmJ7Y6t36enIAax8xEjDjvVs7qcavFJD
	7VVe54Ce3eubeg80B2wrFNp173diA/CxaVajHDeA6L8RjmyhmCkx36OOcpbCo9SfXESUxAccz6a
	FUyt08wRvT+oTNppDb8lwaaDfV4rHZV++RW58eqbwxh5gRL/WwusKcUqIlLNJd/+fCSnVJ6TE5W
	EFAGKV+mJFTljs5xInjRuT3Q=
X-Google-Smtp-Source: AGHT+IHDZ6xGl1SWZavtrIus2FwQJD5U1ZdJNYFkIE+cJe1VxYs5Y5VTvNHZNsOf98c4IOblb6w5Pg==
X-Received: by 2002:a17:903:298e:b0:24c:7861:2ee9 with SMTP id d9443c01a7336-25d24100ed7mr234529115ad.2.1758046151255;
        Tue, 16 Sep 2025 11:09:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:df19:cd01:3e91:19aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53a1sm167941925ad.2.2025.09.16.11.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:09:10 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:09:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexander Kurz <akurz@blala.de>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dzmitry Sankouski <dsankouski@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Heiko Stuebner <heiko@sntech.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] mfd: mc13xxx: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Message-ID: <fqhldiqylcsp6kp4tvhopxekgszabbemnvbseygkqaipgp5mhl@wtz6c7kjloko>
References: <20250914193723.10544-1-akurz@blala.de>
 <20250914193723.10544-5-akurz@blala.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914193723.10544-5-akurz@blala.de>

Hi Alexander,

On Sun, Sep 14, 2025 at 07:37:19PM +0000, Alexander Kurz wrote:
> Use devm_mfd_add_devices() for adding MFD child devices and
> devm_regmap_add_irq_chip() for IRQ chip registration.
> 
> This reduces the amount of required cleanup.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  drivers/mfd/mc13xxx-core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 920797b806ce..091c9171b2b7 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -381,7 +381,7 @@ static int mc13xxx_add_subdevice_pdata(struct mc13xxx *mc13xxx,
>  	if (!cell.name)
>  		return -ENOMEM;
>  
> -	return mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0,
> +	return devm_mfd_add_devices(mc13xxx->dev, -1, &cell, 1, NULL, 0,
>  			       regmap_irq_get_domain(mc13xxx->irq_data));
>  }
>  
> @@ -455,8 +455,9 @@ int mc13xxx_common_init(struct device *dev)
>  	mc13xxx->irq_chip.irqs = mc13xxx->irqs;
>  	mc13xxx->irq_chip.num_irqs = ARRAY_SIZE(mc13xxx->irqs);
>  
> -	ret = regmap_add_irq_chip(mc13xxx->regmap, mc13xxx->irq, IRQF_ONESHOT,
> -				  0, &mc13xxx->irq_chip, &mc13xxx->irq_data);
> +	ret = devm_regmap_add_irq_chip(dev, mc13xxx->regmap, mc13xxx->irq,
> +				       IRQF_ONESHOT, 0, &mc13xxx->irq_chip,
> +				       &mc13xxx->irq_data);
>  	if (ret)
>  		return ret;
>  
> @@ -502,8 +503,6 @@ void mc13xxx_common_exit(struct device *dev)
>  {
>  	struct mc13xxx *mc13xxx = dev_get_drvdata(dev);
>  
> -	mfd_remove_devices(dev);
> -	regmap_del_irq_chip(mc13xxx->irq, mc13xxx->irq_data);
>  	mutex_destroy(&mc13xxx->lock);

This causes the mutex be destroyed while the sub-devices are still
present. The power button will try to call mc13xxx_lock() and
mc13xxx_unlock() and of mutex debugging is enabled you'll get errors.

I'd remove mutex_destroy() as well (and transitively get rid of 
mc13xxx_common_exit()) and then look into getting rid of  mc13xxx_lock()
and mc13xxx_unlock() because, as I mentioned in another email, they are
IMO not needed.

But this version of the patch is broken as far as I can tell.

Thanks.

-- 
Dmitry

