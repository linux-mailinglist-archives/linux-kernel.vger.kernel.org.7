Return-Path: <linux-kernel+bounces-725522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33300B00034
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33749167D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D828C2C5;
	Thu, 10 Jul 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1KFF0a7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B9219E8D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145851; cv=none; b=WhwvxoTk0Easco4r9Sw9A5AsrzVTUoTKjKGrJpYMzz4+vJBYpCur1ReBKzlxUkaKndxYdsyQjBI7NEyHAgIXPGbuqZv6oszqwEp+3udZNfVnEBN+eRup3iZHwHwpQznYHckHxWIfkUlZIqaJJZFL6v+0y5LHq5+mSk8IeKt+HJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145851; c=relaxed/simple;
	bh=yaWSYRxVNOpftVRILEYGdzN0BSHVgZsw0nzDbDADH8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5bT8lQTTUfuF5W5y1z0I/W6VyOyKFL/QTCfCXJEEg7h/Jb2skHDjbqd6+Q41sT3vl1N/iiaZoojJOepRwEF9nrMjLYUs0QyVythpDd3HQWI7OXrqMRKJ2qJbuqB3h8uz8su+mbS9fZxfu5S1xMkB9qP3dRrrlHv2/hirR4H8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1KFF0a7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1056992e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752145848; x=1752750648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5c6mdpZ5N5FmfKJmH2vsM3IpF/Oago8XZttHkyE30c=;
        b=g1KFF0a725CWfLaEVk17lTAsgn0CGnOiCXut/oS0gSBhCEtmhypUtGlA8RiygcPUeb
         7gdLB+TCYSO57juVRX0R561ZUPm+/tmytZdVCS4TRZ6FInhJABWtr/pnTvJyg13IdfAK
         JmKLuV5lplwNFVLTfYNcEszL2GU6jDcnEdonKQsMiWuhlGBMu38f8evDNOiR1QJdxODS
         Tn5D/nFMz2ubSSr6LLi9YD8ot3T7qqkejBaC+gaFxI3/con44nrDT4MeYN01jzzZep/x
         8jPwymQ0vuwfN3f+u5BviphBtvjV8NYOYaiHlL/czjOP8RMHWkXiUmimNY1X9j5L3xGu
         TroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145848; x=1752750648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5c6mdpZ5N5FmfKJmH2vsM3IpF/Oago8XZttHkyE30c=;
        b=tdIU06UV41gfDqBFTFSWGd8C0IAf/F1Szv/lphU7cNhIdP/lEUQwtp6evZ8QMVJ6E0
         hHOcvgYlAzfgh6eF6NR9xW6L6BsNHgcCsLV/hlx3zWIQzfBPZvLZYWInKJ1UArm6CRBI
         i+XaKe5rEuq4ZQISKkJC/ctl6srpNJtEfaRmg5t1t/bIJRA7ypfs668xEjETd9rjpj0l
         0tnqeXKlSeb/DDMKNsTaanLlRezsmNZ8+mRvT0B/WXsybwkcHF2sVhwiujye4hTR4zgr
         MY5UUfoZBzR+1PPif3/p6AZnoRBmaqgZCDq7GKhT7j6slKcwIYifYeIxNurqSPGisyPj
         MnxA==
X-Gm-Message-State: AOJu0Yza6mHRINAGURbP/81GeQq2fUcn/bOiELafd4govURRSsoDvkqj
	5Mnjx3hfleHxzhoFtUVlGBtLgUyyo+1JCXAE3PsVKLPMyr0MmC6BCIo0
X-Gm-Gg: ASbGnctjkaWbH5eCPsc+QsmuutA9hufUnSS+Hqno8L4EpcxaHJvMpdM8HhWJigxR8Ay
	si2wMi0b5jFGfMrhA8JcygOPAKA+Q6kN9aPUmvSsTFbG/R8+QkD42BcW1ZCcPJrj3SC3jxViut+
	A0+puCKQGN00PrT7Mnf9rZ0JVKEDDR3Y2efn3nbHpA6srFfcmulGU8X5YR/X37voJOEj/B3NyPG
	cXHc7bIWjGIg5nf1rp3HKIDkkEGuQAchoHidJIKgq7P0JZPTOlZcP1aX/3mLmyN9DRGweWWLrYU
	JY4AEJ6Qcvpwl+hY3iyNIgJrQ0dioMPQACRlyZpshhet69BSZNgC+eiclIuLNyMNGHvn2L9pu0k
	JCrO5O+E4RRZs3m+6T4CoBIQ=
X-Google-Smtp-Source: AGHT+IGAn8vcyrP1uTYa71RAZUTwdPJo5Eh/xm1IGiD6J5/7twt94HWi6Z71hsGH1I9HpbsakCg0Jg==
X-Received: by 2002:a05:6512:3b23:b0:553:314e:81f7 with SMTP id 2adb3069b0e04-5592e34ff2dmr912102e87.17.1752145847792;
        Thu, 10 Jul 2025 04:10:47 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b808efsm331907e87.245.2025.07.10.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:10:47 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:10:45 +0200
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
Message-ID: <aG-ftUl7l2zNm_eH@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-3-javierm@redhat.com>
 <aG-aXTgycE4JEJEZ@gmail.com>
 <87jz4gfgyu.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fti6taVECEwEdkZW"
Content-Disposition: inline
In-Reply-To: <87jz4gfgyu.fsf@minerva.mail-host-address-is-not-set>


--Fti6taVECEwEdkZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Javier,

On Thu, Jul 10, 2025 at 01:00:41PM +0200, Javier Martinez Canillas wrote:
> >
> > devm_gpiod_get_optional() returns -ENOENT when the GPIO is not found,
> > and that is no error we want to propagage upwards.
> >
> > Maybe something like this instead:
> > if (IS_ERR(st7571->reset) && IS_ERR(st7571->reset) !=3D -ENOENT)
> >
>=20
> Are you sure about that? As far as I know, that is exactly the
> difference between gpiod_get() and gpiod_get_optional() variants.
>=20
> From the gpiod_get_optional() function helper kernel-doc [0]:
>=20
> /**
>  * gpiod_get_optional - obtain an optional GPIO for a given GPIO function
>  * @dev: GPIO consumer, can be NULL for system-global GPIOs
>  * @con_id: function within the GPIO consumer
>  * @flags: optional GPIO initialization flags
>  *
>  * This is equivalent to gpiod_get(), except that when no GPIO was assign=
ed to
>  * the requested function it will return NULL. This is convenient for dri=
vers
>  * that need to handle optional GPIOs.
>  *
>  * Returns:
>  * The GPIO descriptor corresponding to the function @con_id of device
>  * dev, NULL if no GPIO has been assigned to the requested function, or
>  * another IS_ERR() code if an error occurred while trying to acquire the=
 GPIO.
>  */
>=20
> while the gpiod_get() kernel-doc says the following:
>=20
> /**
>  * gpiod_get - obtain a GPIO for a given GPIO function
>  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
>  * @con_id:	function within the GPIO consumer
>  * @flags:	optional GPIO initialization flags
>  *
>  * Returns:
>  * The GPIO descriptor corresponding to the function @con_id of device
>  * dev, -ENOENT if no GPIO has been assigned to the requested function, or
>  * another IS_ERR() code if an error occurred while trying to acquire the=
 GPIO.
>  */
>=20

You are completely righ.

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Best regards,
Marcus Folkesson

--Fti6taVECEwEdkZW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmhvn7AACgkQiIBOb1ld
UjIffw//c3pLhZJ1bRWdSMjo7egI2nUhTlVDEXVGWlnY+fPOG4uQJzFvUV0PM2vx
usQXvEGi1V2wJn4OF+937kfNUqoYyS/bkBj/QlBZN+/XRPlDitve0B83uUt4nQgJ
4jxjoaUnsQI/RNX2YSepQJaRh5FGTceeSPyRpVIlW2sy7IcheAB9mCxfhNc6ACtp
lUhrgsKiZKF3gjpNn5GctJbVyPPrFsdN90wIPXaD6vHdiVGk4gZfqUSxakb5Ifrb
cx3scfJMYWNPefjYoSmHeCLhBT+nWUls1kXBIWejE45f6tyToHzrIXs737/UFk6Q
qE7YYfyVsdWFEbzFALq1qY1AkPzVqwshEBNU8kDoL74DW4/pd+dlGctxGgZZYj/q
UEw/qT5gaq2xyRjDPitUaliFG/40sl1F5MVkcMRux2B7uxOrobZu9iJEPzN5oiA+
O5ywh6Ky6G4+lSJksgxv5fX4LoNgw6Xg1t5CiJREvhZzEpeqDaMndNfGZQsJg73i
qaXy5LHd9ApoMkLtCUKgRUP33uUh9GUzXwE5CkY0YGi8lo8ehxz7vxSAhIqXXlUf
JaLskasLS379gId/czLgtIrdC0DWLgaRILo/ccFspccgVf7UEcF9xxozEnoNfzIW
bkcNeSkSbgFtSANueTT839c/Q1JgbFZ3mjchardAJ8APLtGq6do=
=TOBA
-----END PGP SIGNATURE-----

--Fti6taVECEwEdkZW--

