Return-Path: <linux-kernel+bounces-729877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98058B03CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988A13A605C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296C244671;
	Mon, 14 Jul 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHi5xU5G"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E670823;
	Mon, 14 Jul 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490918; cv=none; b=TRlvlD53099xSghapmHQe0rCtsy9O4IcBgXCjd1zJAsXEQdhQ9y6YXYFVSfcSmG0L726gF42Rkqt1oGsOvvE9lx65ZnHpwnHxDr6IRM5dLGAS2Zcqyj/81spwgyf3eOzdR0XG+5hoXhYPaAdSuAw5+3t+IAygs1vlFLDAdWUa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490918; c=relaxed/simple;
	bh=TEdmQ3sQzz4m1gTGlsELMQXiHmt7M9QslQ5TdDOoX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQz2ywZZPuDJ+jhkWuXoBtcXFW9Uy8QmD7cXlaTccZDyfWVLipjPmg9PAPvB0kt4MBWqW9T6PY6CqUYEkF9yYrkK2iHHpXfHtVmq5YBPpWMNSJjcLw+zOAgsAMDwsvGyBD16XtlJx/JeQyZEQOUrVJu/9tcEk17xxgcQaMmEc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHi5xU5G; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32f1df5b089so35730671fa.3;
        Mon, 14 Jul 2025 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752490915; x=1753095715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEdmQ3sQzz4m1gTGlsELMQXiHmt7M9QslQ5TdDOoX78=;
        b=OHi5xU5GgxWMZD5Fu6x/PUXnx9tlGaJDrSlKWytQ59BjntoUH1LV/ixoEJl9Ii2CYy
         2zzSCNZtG2DBo8dllHV7p1RwEBJ4co3SbRjhOApxL5quYRWj4h0kAxS0qBCk4wEesBjf
         0r/c3GM0lDoFu7aZQU14Tk4URH4gMxflMrwF1/PJtIARs2mqqCs09HF/o1xupGczJTYw
         EGjy3hAIVRfxQWPQgw8LCDikGT21geQJAultjhX0kyNeiECUiP+b6/o1ZQnK1jv4uGJB
         6etg1ygLW3fl00wPflV3FDeMu4JGfO29xtw+EeHT5thzpMdn0r+v11PPCY6E5U9fX9dl
         MMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490915; x=1753095715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEdmQ3sQzz4m1gTGlsELMQXiHmt7M9QslQ5TdDOoX78=;
        b=fUJ1vVW1ItgQul7o6Ft224x4JqMYRjqtgjN+E3Zp7vdWXTQtletq8ZUwmS9jXYx1Kd
         7835kjUpMZyrgUajMYI7UWM4sG0SkKk0SEuGaGsyfUc7cVUk8JyaFC//psuLrC39pK7O
         FYDu0PnA5UQf2OUFK196dYhU5AuBtLEHb4eA6+hScpnABfmONCb5XKjqgnmimaSRY3kn
         RQZDWsR23NmSwUgOoZWeTP9kOVu4Nj8gOb1JQBSkkyPIfoX02lO+iMtEFhCoX6NVcylI
         xUirp4xlMKV/TtuKZCha5mt20BkXX7PQAt/SvyrNVis7M2qY6l83Wn1lHCQgj3PFVoBl
         PmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnaqDWHqkSeAUPuz1vAvd/hGbFk7jdy2rZ44af8C1s6QwSXIpUtIak1Ez/YU2GDg10S+8VWfdzHuWmmgzD@vger.kernel.org, AJvYcCXFB9e3VmFHTnWf98hgIgrf4asyi1J1Z0bwKL92F107wI0n8p2sZ5mCs2lV79OgWTzi7mztEw1HjSkO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9d85YoAeFaJb950/DHFkuHNhKQq4njEMnDK2yrKkidf9gqV1
	Vj7hcncLhcLiu+D/h3HWfoEMzkIgPG0WRNOSv7u4+K+EGlhrTossF4R+
X-Gm-Gg: ASbGncsw1iY/e4ZOeeuq8nb/zIX9Npy2Qy594ZpnkFpd0yq0BcqwvgDVqUm97Pkk2VI
	sG7KTh6I0Hy2v77OjhkiPaBXrCQhNpXQI1QtnQ5OspjQTsyY7fCP4Ljb/UK2J0c+zknCKS6gzHG
	pxNN1ruTFXjyT8JPEwtasjJRENOBvlpO2G4Rhq0VszI6abeEOJ2yy1tcicaXbfy6cN+HZ1Oh3t8
	q0W0M1TvbpsmurwIGKrpCAK5sxBqREUHB2oawRY4Lnf/3gVvOMlM1dPX6h+v8SsOL+nLBj/Z2cV
	R2lDPAaPk60X0Yj+hNBR04OXV0HX3T+o6tYk/Jks/y7J0miMZcwmowktRP4LSSc5hrFd80zBWfp
	IKtd5jg4ZOi+T6HfKM3a4p3lpHiE4kGWR3dIJkwgOv4WNTDVPof75hONBQjI=
X-Google-Smtp-Source: AGHT+IHjS9hZdr8cyMVFntbRjNYb2Oumvk3FGh6U8F2VpP3TacRH3nymulm+jQlQNNGanb7gPRa5pA==
X-Received: by 2002:a2e:a006:0:b0:32b:3cf5:7358 with SMTP id 38308e7fff4ca-33053473347mr25758041fa.28.1752490914855;
        Mon, 14 Jul 2025 04:01:54 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29141d1sm15310181fa.12.2025.07.14.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:01:54 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:01:51 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: display: sitronix,st7571: add optional
 inverted property
Message-ID: <aHTjn3NqhuwwjQVh@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-2-a27e5112baff@gmail.com>
 <87o6tnkpun.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hnxh8WnDa6UQU/LQ"
Content-Disposition: inline
In-Reply-To: <87o6tnkpun.fsf@minerva.mail-host-address-is-not-set>


--Hnxh8WnDa6UQU/LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:51:12PM +0200, Javier Martinez Canillas wrote:
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>=20
> > Depending on which display that is connected to the controller, an "1"
> > means either a black or a white pixel.
> >
> > The supported formats (R1/R2/XRGB8888) expects the pixels
> > to map against (4bit):
> > 00 =3D> Black
> > 01 =3D> Dark Gray
> > 10 =3D> Light Gray
> > 11 =3D> White
> >
> > If this is not what the display map against, the controller has support
> > to invert these values.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
>=20
> Could you please rebase on top of my series that adds the ST7567? Because
> I see that this controller also have a "Inverse Display" command, so this
> property will also apply.

Sure, I will rebase on top of your series and include support for the
inverse display command for the ST7567 controller as well.

>=20
> Or do you prefer for this to land before and then I could post a v3 on to=
p?
>=20
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>=20
> --=20
> Best regards,
>=20
> Javier Martinez Canillas
> Core Platforms
> Red Hat

Best regards,
Marcus Folkesson

--Hnxh8WnDa6UQU/LQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmh045oACgkQiIBOb1ld
UjIBbxAAgTFlu5KKAUWMswSzSlDNwsZ15dXj/w13i2R5WRaObTVQscLH3IpabSWN
vW2sSUlaiOkzSzIm/RVXzTEiU2Dz3tXan4vPGABBolmg+0kVKpXLr0NzDMQyy6P5
vu7yrtg3Fa6fBZeBMQodEoVNCXezJ7UV3AtOP8j6vSN98CnNl8NG1N5OpT+hfsmN
hxLL5qCAj0xw1t8v/75bVEUQReaPqNlBWckBo2tlJmw2J7WLAZ2K3jKzxjPfxxEL
Kq1cQ2RuSNyLF9BxjJgtZrY4+3M6to+Nzlre1kUPNPmGvu7IbyRQa9EZiAXO/mvV
RNLC+y4G5qworVGO9hJUrKoRM9gA9YXCK7+d1wyDxQK8stP1K9NwBA3lF6o71wyS
sejM5v9qN7Yc6xGSpcEtYOIGfT+znmbBmi5Gq/xVZJRtT4gg9ylxEtVJODInk60K
M05Rj9S4RzhM4CGF2B7Eie5wyZ/QVbAn1PZYzH8zOy+dWHlSY+75iuLjtk8/RDW+
XyrVBO8HOHUW4r601mDO9LiH/D6u2XDRIVKlMSy9zZctOah0WB8Sf3kKUPQuuF7l
ixyk170qygFa4kt+Rqc7pm2SH6gfGkIeE6ZmNGTI5yS7/LkZ62bNsoNvT+9BWkIa
bcERs0rvmAUaz5vz/x3uehgV6OGB5M/GklMHlPP37HeElKi3CZw=
=DDNb
-----END PGP SIGNATURE-----

--Hnxh8WnDa6UQU/LQ--

