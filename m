Return-Path: <linux-kernel+bounces-843865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AC9BC0716
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC14F5298
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74C2264CA;
	Tue,  7 Oct 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GDm6T3/E"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089D35959
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820245; cv=none; b=Jl85xVV8lNlyRrb33veoVM5YhvhgKZ8iEiZjKJrz+esrH5vZNNuf0Cyjr1k3i7AhPrkkAQyYi/aWh0PmUBQcaSvWNSX4GQXcGtOpkzV0TSdKdLmM6g9pwlezGpPYWxudYJmoJwcchfNNhfsUpLpVFe+Pps3BKFy8+NJmZfP3iTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820245; c=relaxed/simple;
	bh=pSXHczsOQ+O+qL7wzRP41/2qS+AEtN6NYQCYJaAcnXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnouE+dSaCUnSPf/qWTM5IsPEH6aqVz0NaGvVufLPMD6WUghSAK2RgIhZKZTHyadsPzZHzrRgv9trLX6uSphZmFZhByzTvkN59sB0ED0bmAej1ZD+zPIchpFLP2gQ3Tz7OOzg+SCoZjA4cCoW8vQMnq0MUVKIV0d6PVqUqumc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GDm6T3/E; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so10629013a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759820240; x=1760425040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQBr1iLVFNtqeaNs6yJ80+xGl4WT5Nt3T8RxbNCflzM=;
        b=GDm6T3/EqEXNZNyqG3807ztDAdlLvZQnHWsMR5qsLoJeQLK9euGjMSXUg9Lpsa7DBH
         Dxyqcr31TqScDpZYPqJLyy5dvIisAg9vc/XZCeptLfS8bJmVkN52uY26J2+cOWn7xRjf
         TQ2MwQimmRYT9lLhdSq8TJrZJ55Izbx0Y1FpsphG9cC8pJIC6cAU3bp5AtNJgxLQVmo2
         3nfPCVVrIG9euX44FYXi59aDxXx6+huMKqqM5MHloGeNkdstfzdVQd/cmVn5LGeGEsPq
         exv63tkC9UsM8CECyqhYBzPopONIbldb3M8XK/xrBdkH/m+cbI8zPdFjYt07hN/Y1aMT
         br9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759820240; x=1760425040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQBr1iLVFNtqeaNs6yJ80+xGl4WT5Nt3T8RxbNCflzM=;
        b=vUvvK85uQjjXzy/co9SFJ91T7MGrBzpAm5huL7aExpG/sU/tX3QBsAHyK8wnJUOCtw
         P3uW7IsriqKrX7/211GLWBpy6SeHU0o3ZFOsLzSRVcGHM/45HcpJyoxQbdDoqr+5MGHP
         ZiECf/JNCAs731FP54mRKMVnAho7S9f6SGmdQ4g6n5qeBeY0Lhv5I8yOLaVEEntL0Vph
         NT/tTi4iCVj33RmccfJlO8attl18cgZCx+1zGf7EdagGuq9x/RflRLmBi31mim6ATKww
         HidTyBPnvPMgv6aQHuwZY5DF1NvChUExFXbg4zGxQPeMHcLi2LqHBsS3wWQnJrcB/tVv
         7AqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDpxXsQPgOUnB9L2fA21jhU4vCun4MQ4+stE7AYHbwszE/tlaUDDaFjAIvLny0zmG9X7jtCVLHp4aoNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIoraUkPMbLm+7vycQrh2yOJJrdePpx1vs2KR2Qwzz8i770RP
	58i9zp8YdPtpk7B2QfbtyomkUXT2ADv2Vrgtdcu8JImO6IXj2goaIWFEWAp69gzp0e1BvL2YdfJ
	U/pZI
X-Gm-Gg: ASbGncuKVzz1TZdAt0G+wKGJF3lTe8rhNUYG9otgEKi4vZ5/mFskgOKDNWLiNjKt9SN
	BUkP6xZhw9mscgek1iRw1MX0yQ+oWZiTnZL7qfAaqz9K99tT5dT2j1WQ9mQvRWtz3igk21HAGG0
	eQ9jIXOmVmPMvqrGU1MGJA/p70KFyQ1I40Q/3NjGdgFN5vCAL0b9KjN/J/te7m4ewykE2T+hW/+
	NNnKA5eQef0ybZGO2LcBomyjcDxz1vbMGjYZvjFa+3Xr+xTWwnvW5piX5AAESpHg7f9fgj2v3sf
	fOJ28AW1ivU9Zuu3Q/hts6WNbQVrHF8Mp71uVwNbw5LDoQPpqDV1kqezeont3I9w6WX7PutM65Y
	lg1oEASZrQaLV9eY7qH9i9esxV8whC3HuBGRlFUnFokqvtCTrNk7yWlJr/O9FlTq1TOaRz2bybo
	QlCzQxBkYzFLSPx3WIEqt9FHk=
X-Google-Smtp-Source: AGHT+IH+x4rvNU4JaZu7YZXVaGBVLRKK1beKwvljFVhpKQF3G9mDqkXPfemHJ//E1ME4YBbm97oUxQ==
X-Received: by 2002:a17:906:9fcf:b0:b41:e675:95e3 with SMTP id a640c23a62f3a-b49c20531d6mr2080358366b.16.1759820239882;
        Mon, 06 Oct 2025 23:57:19 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b486970a60dsm1302323866b.63.2025.10.06.23.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:57:19 -0700 (PDT)
Date: Tue, 7 Oct 2025 08:57:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Javier Garcia <rampxxxx@gmail.com>
Cc: deller@gmx.de, tzimmermann@suse.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
Message-ID: <i63463tzmzyjwqvqgduwakdx26zzftj43yay5ytit6ll2hvg72@3azlq2glpmos>
References: <20251006164143.1187434-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmvirqnkodsp7h45"
Content-Disposition: inline
In-Reply-To: <20251006164143.1187434-1-rampxxxx@gmail.com>


--xmvirqnkodsp7h45
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] fbdev: mb862xxfbdrv: Make CONFIG_FB_DEVICE optional
MIME-Version: 1.0

On Mon, Oct 06, 2025 at 06:41:43PM +0200, Javier Garcia wrote:
> This patch wraps the relevant code blocks with `IS_ENABLED(ifdef CONFIG_F=
B_DEVICE)`,

stray "ifdef "

> allowing the driver to be built and used even if CONFIG_FB_DEVICE is not =
selected.

The driver built fine without FB_DEVICE already before, doesn't it?

> The sysfs only give access to show some controller and cursor registers so
> it's not needed to allow driver works correctly.
>=20
> This align with Documentation/drm/todo.rst
> "Remove driver dependencies on FB_DEVICE"

Given the above, I still don't understand that. (But maybe this can be
fixed by Helge's request to improve the commit message.)

> Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> ---
> v1 -> v2:
>       * Fix error and improvement , thanks Uwe Kleine-Koenig.
>       * v1 https://lore.kernel.org/lkml/20251005173812.1169436-1-rampxxxx=
@gmail.com
>=20
>=20
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/f=
bdev/mb862xx/mb862xxfbdrv.c
> index ade88e7bc760..dc99b8c9ff0f 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include "linux/kconfig.h"

I didn't need that during my build tests, also don't use "" here, but
<>.

>  #include <linux/pci.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> [...]

Best regards
Uwe

--xmvirqnkodsp7h45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjkucoACgkQj4D7WH0S
/k4C1Af/WV9h/qgYbP/3+qXNhC1BXfM3TuwVm+Sff8RZnlO741v4wQpli3yGXbi9
KcG2h9XY0lwvH/VMa67XES7Mndveqbrc129IdezMXfpXxskJpUgvhtSaEdpWf8wL
QfjmYKi3YchT4zMmtqzr5rSePQpfqEbxXN+Bo/FRofoQkrKLIslEo9xYzbUExm0t
WUMwiK4+Den2I8Km5fTZoCp4z5RXxARQ4yc+/8hCE4KQ912dNSoIde2pFzxo/25C
vzuO/UINyYqPt4F1AHY/7tfrP5cgO3z3jbdtjLvEIk6m/UYCwnkfpJXsEteOVgJx
kYSTrHFuIq1enwL31Vxj10PYMgEwcQ==
=zm7i
-----END PGP SIGNATURE-----

--xmvirqnkodsp7h45--

