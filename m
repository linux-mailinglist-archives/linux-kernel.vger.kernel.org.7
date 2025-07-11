Return-Path: <linux-kernel+bounces-728274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9EB025B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B6A6512F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12E1F4CBB;
	Fri, 11 Jul 2025 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpVd69ir"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB82BE4E;
	Fri, 11 Jul 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752265438; cv=none; b=TUBuZ2KDRfEe+5O+0/iBZagPNuLVPoAMXoCyb+g0MPEmKH2mFBCljZZkICIVgSntibfEN7APgp7AsqHNbxWpxz2ci9JlzXKv8aptmBOTDdg0oAY+85If24r8eZQdqQ+9twfMbkJ3Togvtaa2AOsq8CVDahuRmA7hqAeFKJ4XP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752265438; c=relaxed/simple;
	bh=YoELCy5FniTp7Y2lm/W8K0bCKOAqxq3dDPcD8Vc4JYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQU6fDuTh0lMiD0JMHKEt9F6dr0PfVXr1TbfZq8k5ztm499QdWRHvBE1OYBxIwMPuVSP7MsCGhQRmFHBkUq5yjHdqNAp56Jpzd3FLw1Qt9ZFjvGo4mRN79LuWYdnQJxV6Mgs4Dn1ca2d5XavJLk6kkPLueAA/ahQx+lco7Gc3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpVd69ir; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so4078198e87.1;
        Fri, 11 Jul 2025 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752265434; x=1752870234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ViwvjvyYagYyuQkx2zZM7j6gLRmdMIVphmkzamnsrY0=;
        b=dpVd69irt2eTZUPq1ASVq9GHf4DXEzvG1mVnqsuRJuaJb4wS1WI8VAqz48yAw6fHfO
         mrKZ5beRuF4Ri4ZI016eI9mIpR7G0SJmcMmuBphD4w1KB8MpnBvvOExD3X4vx9av/2R6
         m1ZOGycmXE74VfZnLj4BVbMQrvTx2YbSiD+Q8+1bKCiQ3sn7GK91As/6F3nViSA16xHj
         Sl1qSb2Itg6zyTlpcjI7zt5t3rPuhuLi1w3ngFGNTFpR3FrePtki6DD3vGd7Dis6Z6F5
         ZQ8h+YT/7qVkc5MEzjfe8vIywmRU+/dyfwdHaryU68ZVP+fX8Ry9Wrfe40c3G9THKMYe
         ClEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752265434; x=1752870234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViwvjvyYagYyuQkx2zZM7j6gLRmdMIVphmkzamnsrY0=;
        b=GQY5baHZQbme9u0Jc3ZCQ7hwFshb46GDPF1xfwbcQNrrrn58wE8wcT2sajhCU+rFqr
         9lwqKuWUNFzJALi0l2Dv0MT5p9s31IZb5HDqU1+6W0xGzaG/s3lJgfKBKxMFk21WrRuO
         6Wy+H47i9RKopF9iGYPNANInOzoSrEa5ywRVQAYnw0nV3VvVkXNn+lVqcnDhrZGCsUB/
         I85kVR6K1NyyXlRzGxjCF3R/OWf0Q8g7XgHh11QKz8eP3LN9cC0yaauc6te/lO5pyKlH
         pWv+mn9XPompP1xjonA1lZyjcD9at+Xt2w1zI8fgbjABylVu8v+JMMzUjuqrQ2O4O11k
         nGow==
X-Forwarded-Encrypted: i=1; AJvYcCWzU0RXb0nPUzlMH9EtcsDEshDATJQ36YfcpcPw8ZQVmWMVVdAySc08uOZpWru9LlH3UTjFWK71mNFW@vger.kernel.org
X-Gm-Message-State: AOJu0YxEA6ST/li9s4gvP6b89YCnlc+tMt32/9xiomCEg9e4fdoweYVJ
	3SyYuaPoO+oKslpf/pPqKGN+hkSQR0UexPoToCKfExugnhbBpfyQv4abkChnIVrWfG0=
X-Gm-Gg: ASbGncvMRaRK4gojUrdFmQ8KL5gLE/tbrcSSwKMW3GhY6l9T8yaKWx93euFB9gDS0ts
	S1Y33m3lyzhryv3pZD2YmmBnAjdZWOJeEGMn5KbmtBpRilmJSzARZtiw9/hOwciyjiUwtvEZnM4
	rdbYM20mqM0Z1Jo7PuiuUG5KWeSHdz6YO8jmP+IPrYNoybL1CUmNinW4d5tWmJKOOut3RljTdJz
	Lb7lentjTj4CFVKX/T0Dl1uMZXKi/rqE4HSNcbU/g1RcYV9Ve/iUoaMKloyQ0MdiMIwI/TOSZ32
	/7Ng4AvUfCueWOeyzH9pXP1Xf/OcExe3WqgNE9nzvneat93/ML9lONObIZ5rBtYVGiGuLQXMdTS
	VZKQ+t3Di4Pnk8L7PObMGQ9/5iielP8kXi9GH4ioleYhhC2U9G7+p6KeUvUg=
X-Google-Smtp-Source: AGHT+IGaB1OCM3rtIXV7ppHvS88LK5V03isAcfNOp8Cj5FBP+Hv6v3Iuwn993DccTWudqcs3MbERdg==
X-Received: by 2002:a05:6512:a82:b0:554:f82f:180e with SMTP id 2adb3069b0e04-55900715435mr2999523e87.16.1752265434144;
        Fri, 11 Jul 2025 13:23:54 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e8d21sm1067771e87.55.2025.07.11.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:23:53 -0700 (PDT)
Date: Fri, 11 Jul 2025 22:23:51 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/sitronix/st7571-i2c: Add support for the ST7567
 Controller
Message-ID: <aHFy125scr-g6zn6@gmail.com>
References: <20250710102453.101078-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mnqlV2pEEsmlw367"
Content-Disposition: inline
In-Reply-To: <20250710102453.101078-1-javierm@redhat.com>


--mnqlV2pEEsmlw367
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Javier,


On Thu, Jul 10, 2025 at 12:24:32PM +0200, Javier Martinez Canillas wrote:
> This patch-series adds support for the Sitronix ST7567 Controller, which =
is is a
> monochrome Dot Matrix LCD Controller that has SPI, I2C and parallel inter=
faces.
>=20
> The st7571-i2c driver only has support for I2C so displays using other tr=
ansport
> interfaces are currently not supported.
>=20
> The DRM_FORMAT_R1 pixel format and data commands are the same than what i=
s used
> by the ST7571 controller, so only is needed a different callback that imp=
lements
> the expected initialization sequence for the ST7567 chip.
>=20
> Patch #1 adds a Device Tree binding schema for the ST7567 Controller.
>=20
> Patch #2 makes the "reset-gpios" property in the driver to be optional si=
nce that
> isn't needed for the ST7567.
>=20
> Patch #3 finally extends the st7571-i2c driver to also support the ST7567=
 device.
>=20
>=20
> Javier Martinez Canillas (3):
>   dt-bindings: display: Add Sitronix ST7567 LCD Controller
>   drm/sitronix/st7571-i2c: Make the reset GPIO to be optional
>   drm/sitronix/st7571-i2c: Add support for the ST7567 Controller

For all patches in this series:

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--mnqlV2pEEsmlw367
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmhxctMACgkQiIBOb1ld
UjJKiw/7BCY1zpUT6onONzoUceczUg9xRDcyC/vTr0sOmrf3NPi1qRtgkNo7USBU
3qdniqhj4crFiM6cd69rdGgks4zSIpujzdefzbtHfmdpECmYe/HVmR0X3CZ99wwY
o3L3ty50gBNP5C5Hy71vdXWhhmcEC/wpwfXUnVBb0Au9/M88mb6naABn0+EPV2SJ
67cThMer+LyXYK3dEFpv4D2TRWO/qRW3eaW/PPYMi/k3tPMroLjb6LmeQq5TTizy
UarbkU54Ev5a04+IJfBZV9EflZlKDVNWtyfFCS5HOC1if7lhXYwW3sa58CFWc51x
QFukJ9hJ2K6kXBLXsrfVtz9cuNGoLp0B9mjrsyBVfV007zG1XsgylRqYBf3JkLdT
YcSa4JKDqgI+Lgw0P5rPwm7rWtTYnoRh0umBnCo4mLxlY0vJA4ARh50gdLA1J+qt
R/X6riGUGUQSQRZHDqaQuE90JQ5aMRkWPuTOOnoR+58DuXvLmgf3dS907FRqBGoT
JmfFFxgzcZxoLlQk0sfGZyi7oQdqN74Zt1X5cmYYd5QmAQFuMY8wTIynmyG2jnXN
ctvX9Va5rRuJ2VbnyJ1ttK+ymMAS3L/9MBkaTgG20yEpiyevUS01yTvK8hGWa45k
hMKaKBOjGk7uv10rDzRGZpxt/xEq+F4jxerLj/YCMyI72wQoivA=
=/GlZ
-----END PGP SIGNATURE-----

--mnqlV2pEEsmlw367--

