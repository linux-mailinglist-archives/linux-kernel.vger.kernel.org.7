Return-Path: <linux-kernel+bounces-725476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A682AFFF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1E61C84940
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD1245005;
	Thu, 10 Jul 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blT7uhkX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA0D27E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144484; cv=none; b=r4IIK5veTeJzfGyxYCbi+sZtKdc+s2deKwj8CwfWxeaq9YbetayvVeKPR/0jtLbIsKaezFD9sf2EFjIVI+DQhDpzDFp5lL1GPScD7fevJusXHFPjjVQebQKjp40u5J8Ue+6PdT6ajCheOrKtips0OR3MlP1wfdKSAOe2ZlvVhpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144484; c=relaxed/simple;
	bh=bFqWAHwId+j6sQOMiJX9dUYWQm9Sg0YJ5PLZl0beQkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHSjZXwlTdnHZ1IvbeMn/SJDkYTl9aK5BCm8jVbayUuMPST1sxKNaeKdnx4alyNzI9x7oeiZ+TsS3s/dyE2IY/xhVevM+Lg05pRULUr0UM5y3saKLfC2fj/imaAaFzjtMGXYWE/ToPiEX/1bcAGsWd0iX7TYefcrvE7UhwCHJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blT7uhkX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553b60de463so735742e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752144480; x=1752749280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeyQd3+FwTnYSdw2VCo0s+mkigMBSF97ai9NjTs6fao=;
        b=blT7uhkXBYbYkKjH9uA/C3egeCPmr2wXL0nXCvcW/wFXjPgUM9RU4YvaBC/LUjDgh5
         JvOWVpHUwgMZiF/1Z/7u/4ogazjpQ57X+wyojB58L2Ee/CVvdOVaDakdiXHUeJSU1xaD
         ARsYCqkEo2tFt4FMfHR04LQF2w3gzBKHIYSOQ5+oePr7ugvU10iPcxz2JfmrWukeWxeU
         SIG1oUap0ZWs2j0nyeipUDbbAVAFTK+IYp5GIM8rTF0FQOzEmTeQcmIwUZ2bHP2O100v
         qEv8HBINKGfTgN9Y/F7VZ/mZXJYiMh5NqkrISyv6kFwRXFkyfswN1sXQg6sgE2f1ruJL
         LlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144480; x=1752749280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeyQd3+FwTnYSdw2VCo0s+mkigMBSF97ai9NjTs6fao=;
        b=UrGqwsIQZS/p8QD+ZKH/C+HXc7Nfip/CFNP8ddIE9myTeC42koekgtMYC1yV5spCNn
         Cx+eeYPPgA4mGOoU2UH06YGiyjJ3Voppsk2gJ6DaYOyyg8fh+wrGMn2fdcb2CXf1ZT4Q
         V4nTA/RLeB6WiJ1px6FpVAh+LRiWeOZ+zd0kcIzAuiqZbzUo+aizMH/BiRZdI2hyJRXF
         J4pdbxQj0koEdhd4kGCGvJ0VxUETZdF7ZRd5LI7nnhTKF31H6HQ1i1bjLpvL9hhfJUz3
         D/ISo9TGc5yXJJWlfSAHsLSw4OT1Idcj3+uAYOchmJl1nD+BBEOKacY/MKAzW86x89PD
         cDNw==
X-Gm-Message-State: AOJu0YyWtUkEnNGonMx+KTm9gA3q6wELNlaynNgRZldQTM4mMBUJ/tkX
	uiNc+clPfS/qvUzYMXG3XJE19kHaSUE9ToiSKemeh0u9uFYseG2dSyLO
X-Gm-Gg: ASbGncvaKmu8cI1Y5t/43dvI/PdXNk4ILLmdjEMbsoEWXkawFrn37FBlnQPjZfHh7ML
	LYkrVy9y89HTQNcmOIyhqcjyC2ieDkSor0XXJpVDOYKBuHIP/G4D2F0cw0nOVvlbKP0G1xqhw/B
	8ZpitlWJcu9V2TYTExWn0pVmmCc+lf25TpZQ25xsJNKSLTMi7ZM5o6h5SEA0H3QSZwfOtxi7KRn
	B7GdRUD9qeVTxG1t7RAyPK22ATku0LGxy/uFwkADeSm6Xuv4xYgODa3/gXFaHEIHSXIRUzI5Sto
	FGkyF/eYWVCXOgyUokpgbABbMCzoweiTk7HhppBUrBFHSe28sq8TIxK3K/Z3OAHvdZt0kSS+iE/
	B3Bty6R8jxdkUsNlrxm4jvGY=
X-Google-Smtp-Source: AGHT+IEOTgz8Yn/OZ6h83EwkwJBqrgRuTKQeHj+q8D1ovN7NKHb6DiFoTh/pZu7ebVo1ZfMvzg5Ceg==
X-Received: by 2002:a05:6512:3c8a:b0:553:202e:a41c with SMTP id 2adb3069b0e04-559000c439fmr1097729e87.28.1752144480144;
        Thu, 10 Jul 2025 03:48:00 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b74335sm329631e87.215.2025.07.10.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:47:59 -0700 (PDT)
Date: Thu, 10 Jul 2025 12:47:57 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/sitronix/st7571-i2c: Make the reset GPIO to be
 optional
Message-ID: <aG-aXTgycE4JEJEZ@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eOMp4AYn7twABwbo"
Content-Disposition: inline
In-Reply-To: <20250710102453.101078-3-javierm@redhat.com>


--eOMp4AYn7twABwbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:24:34PM +0200, Javier Martinez Canillas wrote:
> Some Sitronix LCD controllers (such as the ST7567) don't have a reset pin,
> so lets relax this in the driver and make the reset GPIO to be optional.
>=20
> The devm_gpiod_get_optional() helper is similar to devm_gpiod_get(), but
> returns NULL when there isn't a reset-gpios property defined in a DT node.
>=20
> The DT binding schema for "sitronix,st7571" that require a reset GPIO will
> enforce the "reset-gpios" to be present, due being a required DT property.
> But in the driver itself the property can be made optional if not defined.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  drivers/gpu/drm/sitronix/st7571-i2c.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitr=
onix/st7571-i2c.c
> index eec846892962..73e8db25f895 100644
> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
> @@ -802,15 +802,19 @@ static int st7571_parse_dt(struct st7571_device *st=
7571)
>  	st7571->nlines =3D dt.vactive.typ;
>  	st7571->ncols =3D dt.hactive.typ;
> =20
> -	st7571->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	st7571->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(st7571->reset))
> -		return PTR_ERR(st7571->reset);
> +		return dev_err_probe(dev, PTR_ERR(st7571->reset),
> +				     "Failed to get reset gpio\n");

devm_gpiod_get_optional() returns -ENOENT when the GPIO is not found,
and that is no error we want to propagage upwards.

Maybe something like this instead:
if (IS_ERR(st7571->reset) && IS_ERR(st7571->reset) !=3D -ENOENT)


Best regards,
Marcus Folkesson

--eOMp4AYn7twABwbo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmhvmlgACgkQiIBOb1ld
UjIYehAAqdDofl1NZfrXplyMLlYvsv0zY6FKIOjlOzV6Hi/GizuR2JTKqffK+3fn
OEdmpbkMYj+nWOJBQj9t9uolWGa7A1G3K408CmIXU9vKhbS/EBIbL88CwS3aZUja
Rg/CW9Mc1RE6CDKaixSQwubaKoiz3RPqC/QwyJY4eZ1gpxKKplRLfAc62bO1WfcZ
4rOH68fNHH0bO7J3q5gdZtgv/OxtBwhHhVJ6ntCpqTSBr7z3iw+fZsy/z0gilTQy
M9V/Cq4ilBxMPgu3rLFl/ebC/SGF0S8cIEkiP6UAhY+BWrLIN+JNqASvj1dYnGsn
Q5odrBX3wI8OwvROzoPfLP4/FmJreYFU40mNZa9+JqrfG1HGc2IBEkRoCZjUVPDg
/JAS7UGc8S+NQI/C7Q/U5x5IgCgASisDvzSusApuCrp5XRHPQ3TvEDvzU4zUsAue
p5E66zBveFCMj1agTCBY4M2btwnenfoal881HJGLYp2gtmMBNrWc3PmWwQ31g/cW
BQMfxtARCAe6VE+wywAQchXRHJeNejJYicAyu8FxacmCR7pMaonzPFUlPyGlUpJi
5mklgy2FKz8V5M4PQ3Mh8eGyq4JQNTn7Tym6OKY2FTLEwm2uDV2Qx5HtbgRCLJD7
hUR0Lji4qzMfuJv59Jmzr9C5ufkw1A9DAwbE696PD5E20BTcShk=
=wIuD
-----END PGP SIGNATURE-----

--eOMp4AYn7twABwbo--

