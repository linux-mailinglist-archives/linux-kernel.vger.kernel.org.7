Return-Path: <linux-kernel+bounces-893418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0363C47558
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB544EC67F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DA313E3F;
	Mon, 10 Nov 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFWpkzen"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08F23BD1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786165; cv=none; b=Q4eGr3NoSRaFBuHS7upZIfOHRDUQLntiF7CbMv7GVE22V8LJsGkY+4P7ybeu8sQb4qpCIgn6LPDrvz2e5ILgPutfaGdICNUB3z1zkpHIyL7YYmhWFLKerV3YnD+8rCqJdlzorFGZN9vp/GR6Le4Gm2cmN0RR8rymvxFulFNeL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786165; c=relaxed/simple;
	bh=fj1lgNaqat0WAlpO8teOq5f/zGFKDOK7LqmlNPzOs28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUsKhDmSVZBWKonpuzszVQWtAkUlI5ewsdiLtQd6DjwJIkU3VsY1ecG1m68H6/uThJ3pphc/+4pAR+VbpddjBlbrfSVR1jwSqTpM5gqz0ARJw4GMBPWYODKxCW1ibSPjM2aukJckzekRHjheQ7t252an57OSm8Eg49oQREqzxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFWpkzen; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632b0621so21144505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786163; x=1763390963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rtwHEg8AcEZ1RJZW5TUVf80IN2gTbqjeIF8J9dLK1i4=;
        b=KFWpkzendZ1grw5IfI9Hl6ZrCXpIXCwg3kYWuXAvDZEGI1J4+uFP9OnyWhtyJp5xFU
         b1s8Tx1zj8/CcCKOxL3b7ziLXL4LZYMaTdqfs+QF9P/oNQzgr/Cka9NCKdO5WB2UYsZq
         ISYrit+eN/UvWFAgfUIEdAnxGvUgdUBoa/tx1yJEWzUGq4hkDnErMuiGTplntjwzztLP
         Sdd3IDe3rgJfwdpbgmZCncwM5b3hJ9mC1r/d/B6eupG4je6p/D/B0z9YIvnjC2y5/MGG
         wVq0mrHXVQTeoSSFaoFTpeNi+IWr5TcEBhGq3NaUOVHGAoIiDDojun3WPQrNSteMUPmL
         7gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786163; x=1763390963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtwHEg8AcEZ1RJZW5TUVf80IN2gTbqjeIF8J9dLK1i4=;
        b=hrSrth5PvXS8xZV/AE6RdG1sNzBXigWUEv8Q1ZuSfZLnCZXEWoGC2taPEoFCQY2zSz
         gWn0Itf8oisYCw/uBZvBC9UAqBnv5CqhzJ1m0ypOqO8mvulXi3CTN6ZCDdJID3cPb0LI
         d4Xe/jxx4MBPgiT1EKHu7Jb2XbYzYQYSi0OKvGAaFWPcJZ2TKeSNKs5jOHWtxZEcf10c
         b04bg0+nOu2O8wWvlfyaMW4MgS7FyA02EStEWT5PRnzJb3EuCCCTqJdn8PlYjYecrVyZ
         LfFlwyDP2H1GXm9H8Kpj8pCjFZFngHzgcDPi7l6Qx8sEa+DVbzfygWgGCLPdjztK8T5E
         rjTg==
X-Forwarded-Encrypted: i=1; AJvYcCV59fm55mHZs8SZn+4j6bPdG/CtC3uCoFrcn2pMcyhkFnlYWgo9jW9h5zkQfBkWr9jx757mXpwXopl/ugI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YFLQBbW+kN4y4/Ut495w/OO48AmtJwZsy3lMl43lPKR6taN2
	xy5Qu+5el9MC3lTjRrqAO1P4lr07F1HZqq+4VGQa0rc61POmOy42iLQAEArKcwW9
X-Gm-Gg: ASbGncu1639OjuuYoEBYlcJnsd3RAh3KnVVwm5OlZCw3VmmmpXkIBNubQHuW5D8P3cc
	esh7NMS3Vah3O7U4uVoJdBs0Y23PInY5UCtkSJAz1o4lFts0aa4kKaxFiuB7MidO17Q7aDdbatV
	bDVJCigfvz0a9sglf9fhIZEbh5XRYn5JF65wzhHSSWqeLoy11i8KG5IUZRgIZi1ArR9NZgV893G
	CFPvWH+qZNH7Ed8Wq90R9OsfZ0ohU45syZA1NcCBnqrKB1KnMfEjy4YnohUoSfkxsI6/cKgPG7D
	4c8kFXck9t7x7SAEUtzV8F5qpW59eH9UviHBH9NEpEZhxOn/zzkqRVp7asFQPmKKpODj7pZQkWL
	iXaWysN/Bjo0tYt2HE75yVIPzjWe74TWxsgybZcWvxjC8KOLHqx53WgWaEBpfLJfOu/+0XKDKBh
	zKLK6fBs2PM9d2xf0woLM=
X-Google-Smtp-Source: AGHT+IEOESIpSzas46jUxYDZXLiicWyoxGFZ51X/ZIxX8n/fWi5wNV9wtaFsyvpMDT/n0KzMw/ZuEA==
X-Received: by 2002:a05:6000:64d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42b2dc9f1b5mr5675297f8f.43.1762786159884;
        Mon, 10 Nov 2025 06:49:19 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2ee2ed31sm15770160f8f.29.2025.11.10.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:49:19 -0800 (PST)
Message-ID: <e1b6d5d1fee6a6879d94d22d95a15fbdf5d47231.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: trigger: fix device initialization order in
 viio_trigger_alloc
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Date: Mon, 10 Nov 2025 14:49:56 +0000
In-Reply-To: <20251110035838.37029-1-make24@iscas.ac.cn>
References: <20251110035838.37029-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 11:58 +0800, Ma Ke wrote:
> Move device initialization to the end of viio_trigger_alloc() to
> simplify error handling. This follows the pattern used in similar
> functions like spi_alloc_device(), where device_initialize() is called
> only after all resources have been successfully allocated.
>=20
> This change eliminates the need for complex cleanup in error paths and
> ensures that the device release callback only runs when the device was
> fully initialized.
>=20
> By moving device_initialize() after all resource allocations, we can
> use simple kfree() in error paths instead of put_device(), making the
> code more straightforward and less error-prone.
>=20
> Found by code review.
>=20
> Suggested-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---

Have the same question Andy has... With that addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v4:
> - split the patch into two independent patches and modified according to =
developer's suggestions;
> Changes in v3:
> - modified the patch;
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---
> =C2=A0drivers/iio/industrialio-trigger.c | 13 +++++++------
> =C2=A01 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 5baa83349e8f..760ae3e60639 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -562,12 +562,6 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0	if (!trig)
> =C2=A0		return NULL;
> =C2=A0
> -	trig->dev.parent =3D parent;
> -	trig->dev.type =3D &iio_trig_type;
> -	trig->dev.bus =3D &iio_bus_type;
> -	device_initialize(&trig->dev);
> -	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
> -
> =C2=A0	mutex_init(&trig->pool_lock);
> =C2=A0	trig->subirq_base =3D irq_alloc_descs(-1, 0,
> =C2=A0					=C2=A0=C2=A0=C2=A0 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> @@ -593,6 +587,13 @@ struct iio_trigger *viio_trigger_alloc(struct device=
 *parent,
> =C2=A0				=C2=A0 IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
> =C2=A0	}
> =C2=A0
> +	/* Initialize device only after all resources are allocated */
> +	trig->dev.parent =3D parent;
> +	trig->dev.type =3D &iio_trig_type;
> +	trig->dev.bus =3D &iio_bus_type;
> +	device_initialize(&trig->dev);
> +	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
> +
> =C2=A0	return trig;
> =C2=A0
> =C2=A0free_descs:

