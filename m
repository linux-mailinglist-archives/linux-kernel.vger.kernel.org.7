Return-Path: <linux-kernel+bounces-897589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D187C53753
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B01425F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB76306B3D;
	Wed, 12 Nov 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFGBCpIy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA92224B14
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961993; cv=none; b=MdZwtIlCLlFyY6mcDpACZRITbn4nykTF7mKNcoFzSMSQbH+nnipNjOrpzF5IDOWO15CxHN2oj1VCOyb3/xf4UjtNSS/DCfmbR1Z3iGAuRch46O7X1kPh4oLTJ7KGROjJPVtgXOQPJfrK/omQKvOuFHTgTevpSV6s1zxua2+6784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961993; c=relaxed/simple;
	bh=JArvLajd0ZqdpVYVOCc9UsYN0DA2uy8SRtq5zfsPOkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGjmZmimAeYvxQk9IZ0d8pHbOUk/aoSOHuKKjZm4y200DeRezFoqiYarOi8qA88dWc1SGQpkoxVwGmuAqICELGHnkgWugg7z1XahR9E/XS6AJqiKSRyP9x6DT22rkxFhSm8xQeorYn/8f9cNinGc3U7uE2ATl8svtSU85j5SaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFGBCpIy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59469969bfeso947645e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762961990; x=1763566790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQMGHeuVetKMPR9AyI2Wocgl9opG9fOrKP3UuI7HdsU=;
        b=cFGBCpIyIO22HxoTQ3hy0meWBi1dchvpSst2c5awBB0TL54xtj8bedxB8Kd9ylyhus
         Es2mA/Z0gqe+eS/3ZX44uVrDnMn/seirUw6CzSQKjt+1fg0nRGGoe6gaSkzeg3hRcmzG
         GnWoSlvEbiPNhNBqfkmWH1+eD5V5a+wUPLGeysQ8FNs5UnbDBNZIsunVeUewHxDNxBDm
         pGehXEkmoyqRqEjmt8BEZfncmN0dkKMlU3OX1WwuLWaoG5CDqCJB+/bGqNE4k8Io0cGa
         oRw7jqKYxRM08O3U9OgYxnvFKhwr60DlniC7XJw5Wf6/cvq1PvaNoXzxwWkDjeTpa14f
         1Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961990; x=1763566790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQMGHeuVetKMPR9AyI2Wocgl9opG9fOrKP3UuI7HdsU=;
        b=qqTUmtVaW7tb0R7FxvvOsLFKgqM4p4aWaeZd5ksXZXQsTfzG3eQCsWyT9+ja48/MZJ
         tIQ2eikrc0GBunm1wmrLKTq48pFxW+si+C6367pBSHhIET9GFcJIYZffwLBhIDf6oU/p
         UhqhkcdQtStvcpy8mbhyfmSn7oWQJyjx+gHUn8LZ6tSzEMpxYHGzmgxpHgsPgyE8HyOE
         kwKsLVLntqjMg6rK4hqq5QfluUcYmn0PtoNOgn3OKuNmf7uVqJWriKwm5f+b2nwQoho1
         uLN9/wVR9k3NQlo1+KubzwIwELNB9u4z8XzpWd+MsZi6YDE2/J2kQlQ8/qsbLzOPBZsV
         pJeA==
X-Forwarded-Encrypted: i=1; AJvYcCVg5MG9i/3hOvbaPPSMGQ7s2j2CZaYNtu3XpsNuYQYIzIbQZ9ikALCN5kbzZm3QW2LOrRZ04ivG6pUezj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUTGg5cmQGc5QrFhZ0E8oOSPTQVXp0tS15CuNeW3/nQ+OmuzD
	VfM7HnSLMyhAGjHZpnSo1l+1OHiHBoXyINQj9UZf5uKj0XMpNzfqIwYeev1NOZCp
X-Gm-Gg: ASbGncuLcYHbxfvyfQi87xzS6GnAaqUshBcy3b4xR/uA1NXkNIgxYzDedgh9PkCBC5v
	DJVWesmTANdJe9HLUzpbee+0iEgP0OfzgCA5Ev4Oq2/+rOawmOIiEhmmgUtd4P18HmcbkAuei6g
	mAZSgWjXKXlBoYhBnNeo67Yu7M4kIWMY5MxnegV8kP2uqKy5wm0Xu9Ig4SMfakvNP0kSEKqsd0w
	kHxo2BSaghCWRZT29aa3/yTc+GDwD7BYqJitafZLnRJ6NEdhgvwICM6syRLupk1l57wmtXz3g7D
	VKWkQwd+pMFy4Kps7xgMUhPi31H8EvdaHvKa3kTtp91p95FpX1BcND5Jfpf5Vlf3Nd/GL6Fwab9
	pdLGdvVhLdldcLIP2S3rvMXE+VBxgx3fVdeu1/4NdTQ/SFiTZESiqSbVkhiEqt/sxwt7FhHx6Ui
	/bnbHJkztrB7rdvNd8Wqi6YG9p9ZELBOqsvDZH
X-Google-Smtp-Source: AGHT+IG6fxfn9Ejevg+kHxxkHAI8+e+Pp8yzrvtVeAeXPBB99bQNtGL7z+dS6UndPXzRJTWN+ZedwA==
X-Received: by 2002:a05:6512:2390:b0:592:fc68:5b9d with SMTP id 2adb3069b0e04-59576df324dmr1311109e87.10.1762961989929;
        Wed, 12 Nov 2025 07:39:49 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5a0b7esm5951757e87.109.2025.11.12.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:39:49 -0800 (PST)
Date: Wed, 12 Nov 2025 16:39:47 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Lars Rask <Lars.Rask@axis.com>
Cc: "david@lechnology.com" <david@lechnology.com>,
	"jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
	"agx@sigxcpu.org" <agx@sigxcpu.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kernel <Kernel@axis.com>, Amir Dawd Seid <Amir.Seid@axis.com>,
	Johan Adolfsson <Johan.Adolfsson@axis.com>,
	Daniel Larsson Persson <Daniel.Larsson.Persson@axis.com>
Subject: Re: [RFC] What to base new driver for Raystar RDX0063 display panel
 using Sitronix ST75156 chip on?
Message-ID: <aRSqQ8AFWhUFlOyT@gmail.com>
References: <AS2PR02MB89157A26C4CFF62811208A739FCCA@AS2PR02MB8915.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijoNkkVX71GLNuQ2"
Content-Disposition: inline
In-Reply-To: <AS2PR02MB89157A26C4CFF62811208A739FCCA@AS2PR02MB8915.eurprd02.prod.outlook.com>


--ijoNkkVX71GLNuQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On Wed, Nov 12, 2025 at 03:08:08PM +0000, Lars Rask wrote:
> Hi,
> I'm trying to create a driver for a small lcd display called Raystar RDX0=
063 that is using the
> Sitronix ST75156 chip. The display is used in SPI 4 wire mode similar to =
many other tiny MIPI
> DBI displays, but the register set and framebuffer format is not MIPI DBI=
 compliant, since each
> byte sent is actually 1 column of 8 rows.
>=20
> The datasheets for the Raystar RDX0063 display and the Sitronix ST75156 c=
hip are unfortunately
> not publicly available, but you can find the datasheet for Sitronix ST756=
7 (which is similar to=20
> ST75156) here: https://www.topwaydisplay.com/sites/default/files/2020-05/=
ST7567.pdf

Support for ST7567 is mainlined (st7571 driver), and once this [1] series
is applied, it should also support the SPI interface.

Hard to tell without seeing the datasheet for ST75156, but if it's
similar to ST7567, you might be able to just add an entry in the st7571
driver for it.

>=20
> The main difference seems to be that ST75156 supports a higher resolution=
 than ST7567,
> as can be seen here:=20
> https://www.sitronix.com.tw/en/products/industrial-display-driver-ic/mono=
-stn-lcd-driver-ic

This is how st7567 is defined:

const struct st7571_panel_data st7567_config =3D {
	.init =3D st7567_lcd_init,
	.parse_dt =3D st7567_parse_dt,
	.constraints =3D {
		.min_nlines =3D 1,
		.max_nlines =3D 64,
		.min_ncols =3D 128,
		.max_ncols =3D 128,
		.support_grayscale =3D false,
	},
};

I think a similar structure for ST75156 with is enough.

>=20
> As a first attempt to create the driver, the panel-mipi-dbi driver was ex=
tended with "tweaks"
> to support non MIPI DBI panels. This seems to work. However, after some d=
iscussion with the
> maintainer that is no longer active (https://github.com/notro/panel-mipi-=
dbi/discussions/14)
> the conclusion was that these "tweaks" were not upstreamable, and that I =
need to create a new
> driver specifically for the Raystar RDX0063 display panel using the Sitro=
nix st75156 chip
> instead.
>=20
> In order to make my driver upstreamable, which driver should I be "inspir=
ed" by (i.e copy and modify)
> and base my work on? The drivers in drivers/gpu/drm/sitronix/ and drivers=
/gpu/drm/tiny/ usually uses
> struct mipi_dbi_dev and mipi_db_command() helpers, but drivers/gpu/drm/pa=
nel/panel-sitronix-st7789v.c
> does not.
>=20
> Should I create my new driver as /gpu/drm/sitronix/st75156.c and use mipi=
_dbi helpers where applicable?
> If it is preferable to avoid using the mipi dbi helpers, is there another=
 set of helper functions that
> I should use instead?
>=20
> Best regards
> /Lars Rask

[1] https://lists.freedesktop.org/archives/dri-devel/2025-October/532431.ht=
ml

Best regards,
Marcus Folkesson

--ijoNkkVX71GLNuQ2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmkUqj4ACgkQiIBOb1ld
UjIwBRAAyVBRr+dj9P84ET1/ILprKUFBu+JfI+tKodLXmLdii2HbxF0cmHeA1RAt
RRZKnPiJ57IWFI7dolRE4shsRvW026F9aRRIcKRP+cB+p+szTZryhbm6Hc61Uj1J
nPYsAOSh6ynFsAFGJypFd1irqhTMIfhTrACZ7DXrd8jwKHJR1diyv4LT7QdLm0R5
Hx73yvI5x19IkEEoIc+TR1BqSVSxgo860YdClgfsWubLLRV9GBV+FKz6BCD4fwXk
mxgUtwcAh0iwKz7GVNs8wFiHVbYsaLtwmFElVlfKAhpN2O3mI3ubrwR14yUw9gGk
7BbCQKoOh/cFBhE+5e19BBuXILZ9nJm4q/YqZgC3l8YeC2j0pwJprCV6PvhtHJly
D6pjfcnyMnNXu3oZEolxNOcRwwc/XQp0ANDPQ2+G4dTwslKrpxN7n857/anRMKg1
GdsHaTnMzwVARh2rBDfPbaPHYrY4a/GwHIBPYnVldehAVkIclcS/XCD824lAhhh/
rx2Sxsv+zYN3qgZ1/ztZagkyyGe2jUECiEWdrxzptUeviPOtG5FNPaOTSFi0xpZS
MJVFSD80ZCkUyT9vDgvp4ovxwmd8yKFTuyiow5RDzY2jqivNajHlKfmcJt6GPHQh
Hgs2L5Pi+pj4fWuNk/4EMPFiRcUhVjH9aEH0ML7ZeRFTw6FtTyQ=
=ZOZV
-----END PGP SIGNATURE-----

--ijoNkkVX71GLNuQ2--

