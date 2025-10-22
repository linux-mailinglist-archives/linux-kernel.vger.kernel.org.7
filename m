Return-Path: <linux-kernel+bounces-864290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B35BFA6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21C4A503643
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900552F39D1;
	Wed, 22 Oct 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="epKs7Xxf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02952F3622
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116445; cv=none; b=c0uzZYCrfgUxT51lHm3moZg5PvjvYFwg9m7rPs3EEMCszz84xg541UUMXjKYM6IF56nV2y3KVdv4IHE+PhimfOOOUAMU+nxYjRO+9sqdWIDXxG1iONAUxAF+ScAyXPfWs0HP2f2KDO5HibVBP5UMBKoBnGmC+J9SR6cUKFmWniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116445; c=relaxed/simple;
	bh=H8JQ1rX5IbFJccoPRURxRkqH88JiF0MNlpJ6raTZSVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMvJFzPsIi+C6kYEAIHEdvZiMuObQW5ucNqZY0UncYJKxSx0XHRvYIDWlUR6SlvIg5oah8eXi9UWTdvvUydrKL5j17A82IiNcQZ4UnccWmbcQZpYkLtCAxLV+7zwqMb+OcURsk2SbdCUD4411QKPAtgfBg78kskF75XWVir8Cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=epKs7Xxf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1236041666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761116441; x=1761721241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS4biszQ2/uHLk1P8MSGvcA+rAl/T8gqyB50uLY2uZU=;
        b=epKs7XxfY6ZPqUZ5T4cftporSc+55bd6JiFnucbqr9zu1auBqRmX1yiHgluAoS1fJ4
         vMcX+Cj/nWXEGSRXjqMCGX0+r3YOM1veYoMkoWuqWj5YOYk2JeHuyk6Qhl0gNkdx9/V+
         jYUHmrPN7uaIcY7/K7QLDAhupWy9X5qtWR5yU625NNd3iA2DxB1s2NJlbLv6SUWU2Oer
         Cf0R27Pe10P6l2rE9GgVtgSZ94v1PXWSrUpsstId2R6+QMv0wThsYuhNDJ2xw68AClq0
         wnRpqCfw6960NEtFExCz6DvghMa3AIxkOaZbECzkZN3DEFyBUzlxP6fftTd4PVOf7X0b
         LOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116441; x=1761721241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS4biszQ2/uHLk1P8MSGvcA+rAl/T8gqyB50uLY2uZU=;
        b=pjjHJDbQM5CHr7y6Hf+RK5En709imEoKcAEAwfHJxDYzpTfo+B6zKYm57tc2VKOtuj
         gco1vIMsM3NGLYh/J/diPRhInONGXXnGpmIRyVmD8mJJWl8vcxyx6Pwwaj52Zhfmz26l
         6T5R0KiY0SkWIMwvdtBI8ozPfgumWNE99eQHnWnwNIrAjC7YGZsRf06RWwHkFPeMlnI2
         27MyxhuXKUbmeapX/iX/A060w3a4JfrNr3tixnluXXrYsFFfOCu2vZuPbAzqMmxiHqy5
         XfQrz3Tz+9pE9as/yeR1lrFJFqJ/AcFYhrwbC7gqrI8eh2FxTfhrDGkhvOpfwVeZtv+8
         COdg==
X-Forwarded-Encrypted: i=1; AJvYcCXeuXPIMVP7+fr2ORRiwRTQlpYV8a06KTHpANhUTScUQipa9SqHbH8lQu1eHeYdmzvfE6QPBuYQuikPGxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6QnXyTvqcHxgJugOVr74J81ar1pCtsye6Ldx8Ylhg7j5ydMj
	0XDIj30NgO91xFNuVmtHWUOW+CZJVCJ6v6HidVfELq7lu9+vBaqjSUIjVaU5xzVI+34=
X-Gm-Gg: ASbGncsSIB5wnfe2eXUevs+/EY3XFLKbcBQw8vCDtNsc+8AjbwDW+/3xabr+IWopKPp
	8DgomnfAGX1pMIIQjVBHLzp8TgHhSvlsSqyFrY1+gLds89ngfW0rU9osJnNJNlzWY6HS5VXnwWK
	euZmZzWS28oTtzgEm0kCSJpeCqZAuArcIsOk4GO91BohGSA+dtIYecU7qnC3k/sdbVkZGhIVzKH
	VgLwD5mBUIGwfcEa5Kqy890H1IMyZHZWZrdo+b4hTZxx3lDz4IYDsdqCXhsNFsb215xjjrxnJh0
	LrzSUs/IhYqCiU6B3EQaTUVLNwwiLlBEhHSPRwmE8w/k8Xbs+0N//IjYBir1kKTGGKMnB4HbDWN
	mXQNdPU1WZbof9XDWRylNGC75iDlR5BHmF72FZLNYLxZ5iQnAA1peFNeRn5sC3MUwIqeZmncclu
	5kI7AQ
X-Google-Smtp-Source: AGHT+IH0bPwIgjgA8i2sMaJgf1lSX56gTQkOTRQmgcBQCv3qEtFdupNIOrvNnhwmUXe7/9y/B1pttQ==
X-Received: by 2002:a17:907:7e8e:b0:b33:b8bc:d1da with SMTP id a640c23a62f3a-b647403a5ddmr2228210466b.1.1761116440475;
        Wed, 22 Oct 2025 00:00:40 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63c4945ef49sm11082908a12.29.2025.10.22.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:00:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:00:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bruno Sobreira =?utf-8?Q?Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Gabriel Somlo <gsomlo@gmail.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: Resolve a spelling error in the tegra194-cbb.c
Message-ID: <7ani46dskesos6ccfabi5nqdbljabjtlt4xtmrupta55ga4stg@k3az7he7xnbg>
References: <20251022015511.7257-1-brunofrancadevsec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjgngvca4ihobjy4"
Content-Disposition: inline
In-Reply-To: <20251022015511.7257-1-brunofrancadevsec@gmail.com>


--tjgngvca4ihobjy4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] soc/tegra: Resolve a spelling error in the tegra194-cbb.c
MIME-Version: 1.0

Hello,

On Wed, Oct 22, 2025 at 01:54:54AM +0000, Bruno Sobreira Fran=E7a wrote:
> I aim to join the Linux Kernel Mentorship Program, so I'm currently a
> ddressinng minor issues in the kernel.

This is not describing the change, so has no place here.

> Signed-off-by: Bruno Sobreira Fran=E7a <brunofrancadevsec@gmail.com>
> ---
>  drivers/soc/tegra/cbb/tegra194-cbb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb=
/tegra194-cbb.c
> index 846b17ffc2f9..9a52cd3aea65 100644
> --- a/drivers/soc/tegra/cbb/tegra194-cbb.c
> +++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
> @@ -1836,7 +1836,7 @@ print_errlog1_2(struct seq_file *file, struct tegra=
194_cbb *cbb,
>  }
> =20
>  /*
> - * Print transcation type, error code and description from ErrLog0 for a=
ll
> + * Print transacation type, error code and description from ErrLog0 for =
all

My spell checker does neither know about "transcation" nor "transacation" .=
=2E.

Best regards
Uwe

--tjgngvca4ihobjy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj4gRMACgkQj4D7WH0S
/k6F8AgAu4ixm4ZMXMgDhIZB7UECtpQKZ4HPXd/Z63QZfQt525G3Crw4mAG8z0Mi
zrWuuEngBaSzvJkf2/2v6mY4b3FFkjnpRLltBxNQXu4PebY7fYuoowdGedxRyXq6
VSUUGgJnji9goXYbKf6isUJOYq4lY11n7xNa22RrEQA6Ia2ite/Tz182C8Pg1+wS
moGH+myUhUkvxvp1YpkRUYyknYcE6VQYdUSOi3iMA6U+icMu2sWadf0IL8G0j/fY
g9Wen8Gm13uNFHah2Y26hAQDpAPjB8+f5YZ6DFpZSC3+F/bPLdTIbmTEsAZ7EplW
NBR3zxt7VRs2smctkyl43X9i2/75Lg==
=nefc
-----END PGP SIGNATURE-----

--tjgngvca4ihobjy4--

