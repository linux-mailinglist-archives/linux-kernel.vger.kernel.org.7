Return-Path: <linux-kernel+bounces-794745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B878B3E6B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1A1189E226
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609F6340D9A;
	Mon,  1 Sep 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS6GiE3Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB012D6E53
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735717; cv=none; b=ceB5+31eCAbZZ3iceN28VYzug44JWBxafSisyEWaucXMRV3razo6tOJ6WpGj5sIZ17aHqsSPhhKamki7NpGYiS5Eg0eFgX9i6ZPDBu1eeKAaI7C7Ys5Jm72pHZFE1WLWDAAlMq5eJNoyzJJwPT2ZtKa7c5DeqKxG5iCDVchS2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735717; c=relaxed/simple;
	bh=KroEk3sdxMN5GcGXSEis12Lf1evPZ17zgOav8XHocXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s104CEsZuWWojEFZFfXGrZgoCbpBlnySpviRl/AIGbFKvUk3t/pVM+Ry3Qqr+uIv9FgraHUvZ2J58NAnJCMqq1TtH1gn5swZklTBZX4jCsIWDxhK99+McCtq8F6u55KRcbbwjksiGbi0Covg7IHqgCGqfulbamzFvL98LJJiZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aS6GiE3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756735715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG3k34WesFMCtdXqENehSrO9ASZMVDjiI7ZPCvnu0ec=;
	b=aS6GiE3QTWLuerZvxCZx/NMShP/WBEoWQLHo/eL8bwUtFGzcASBbOGMWQmKcnehJR3cY7y
	Q5VVcZClzesPRbzA55GnjT2XeGtzc4oJmpgNIuv21tV4+seS8ktpj5Ujptz2X3T2o1S3Jp
	6AKWNQ60+VaHTQheX99QAaT0TExhIH4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-FGBX165_OWe9HZSPlPBRgw-1; Mon, 01 Sep 2025 10:08:33 -0400
X-MC-Unique: FGBX165_OWe9HZSPlPBRgw-1
X-Mimecast-MFC-AGG-ID: FGBX165_OWe9HZSPlPBRgw_1756735711
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7265febdso30108115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735711; x=1757340511;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG3k34WesFMCtdXqENehSrO9ASZMVDjiI7ZPCvnu0ec=;
        b=FMOdO2wV4AhbDQ/aBEL24Vk0opDGuABrou0mfFX40GWXnyJlz98fD0Zp2KvRfkTSwg
         cTbyOdsAscC8mrbXV55JpC9EhGm+lTDpq4CdDXfFRH6V1fEdPQbOnWMHsSGoGR1OG5X8
         pf6pvME/7CWGzPC77cVB0/39xWYyz6yirKnfRKUwW/CFqtp0egOTxfxCD6M1K1/9w3NC
         NRqwVHQzz4ynu0IVob7qdHoDDpFclQixmDechLnYA1DDo6nYm9pRpndrnfHtrw8whWYr
         +8AiWtstwLq54qCRCn5ww4SrZzg98uMQYiLQJ17/qX6Q2DFzTM8rTsZbb0yksM02cDL3
         2eZw==
X-Forwarded-Encrypted: i=1; AJvYcCXqiGrrSclEWsh+RkFrYoHdm7y9ZW1eleO7yJFIFkWGoUKvlrPUVg4kg6WA8d9hmoyCG4N2elZ7V7Jh2xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+OicYu1ZWkV+eofc/0GzAhSmJY3j/PeW+h8qMj82neuYoZhq
	a3YpAagYn6eOkbTnxkwK4kvsnyeHo3whlVgAkbkHEEK1h/fY7zkzRe5cNsf5R1RS208RR0UY6t6
	B3EcI6Y00a9F7odhp1SS3LUCxQk9efbFOBS9lcLgDdR/XS9twHdA2h1qLAhwB+iKqjQ==
X-Gm-Gg: ASbGnctBZiwjXy12S/A+2YI3XwTMyXecHU4dASB6oe6vTvX6gGI0TfP1dU+y6hhTVF1
	XRdL2LPZr4gV3+kzPnZFqVb0PYOK52IKwUWWDJuUDjAcMSB+GWkDdkaYUBJZ17k9E2KxQIDqZ45
	PEjCRfVF3eRtOnQm/zZbgTg++7zkDfGTsUgOI7sWzE3WNszCdCYJQSgQsL3gjEtd4+m9kj4wy/l
	SdKzeLwbH0/Bc57kSB1ZxZxw0GiekP4peU9kNM691q0QcRwVSn+//5ekR3rx449/KeZK06FeRPw
	4mWU5qYVbeZjwWI2CiOvNUZvszIqWVFXyJ5LT/EDVI649zDLhwoctDvVBEf4Jzb5Zw==
X-Received: by 2002:a05:600d:1c:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45b8b957228mr38686355e9.8.1756735711374;
        Mon, 01 Sep 2025 07:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF65HlIg6+uyOeqqsJwBsKXgJDxHMdxpxLS9KnNW9siKf0q8SvCMuKt144dJd4GbtZBArffKQ==
X-Received: by 2002:a05:600d:1c:b0:45b:8b95:7119 with SMTP id 5b1f17b1804b1-45b8b957228mr38686065e9.8.1756735710875;
        Mon, 01 Sep 2025 07:08:30 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm239483635e9.4.2025.09.01.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:08:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list
 <linux-kernel@vger.kernel.org>
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] drm/ssd130x: Remove the use of dev_err_probe()
In-Reply-To: <20250820131416.500048-1-liaoyuanhong@vivo.com>
References: <20250820131416.500048-1-liaoyuanhong@vivo.com>
Date: Mon, 01 Sep 2025 16:08:28 +0200
Message-ID: <87plcafeoz.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Liao Yuanhong <liaoyuanhong@vivo.com> writes:

Hello Liao,

Thanks for your patch.

> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
>
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/solomon/ssd130x-spi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/solomon/ssd130x-spi.c b/drivers/gpu/drm/solomon/ssd130x-spi.c
> index 7c935870f7d2..b52f5fd592a1 100644
> --- a/drivers/gpu/drm/solomon/ssd130x-spi.c
> +++ b/drivers/gpu/drm/solomon/ssd130x-spi.c
> @@ -74,8 +74,7 @@ static int ssd130x_spi_probe(struct spi_device *spi)
>  
>  	t = devm_kzalloc(dev, sizeof(*t), GFP_KERNEL);
>  	if (!t)
> -		return dev_err_probe(dev, -ENOMEM,
> -				     "Failed to allocate SPI transport data\n");
> +		return -ENOMEM;
>  
>  	t->spi = spi;
>  	t->dc = dc;
> -- 
> 2.34.1
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


