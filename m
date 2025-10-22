Return-Path: <linux-kernel+bounces-864410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A2BFABC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FC01A02E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAA2FE57C;
	Wed, 22 Oct 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU+8pQOh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C02FE065
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119950; cv=none; b=a9hRDOV5HCJo/vRhRy7PR5NYahC5BcdrihBfR3RLMCn2Pt9xyQypQkcwKXrVB6bGBZRoaj8EiXdCW6ziRZ2+PciFi0KLHnhjZfDgZFzGS7Ya5fZ58pX43yxXJ2VKHWX7U7UiT7OVIVknPl3v13Y4q7P+L3Al34vkTob16/vbT+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119950; c=relaxed/simple;
	bh=VMUdBHBNEd2JkJ+As1WG4mHvxEUaWrnkesCoiZucDuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7Y1kI2r0F9oczqqY75TZNriJsg5rqgGzY/dw8zAB4lFa+wAqxyx37tLHyXPWyPLzuov/7fmXnVcwSleoFQkemzgCkfBMMtBBWDkczoWvQSyMq33HTXtZRWWlc57PPOrYjnW8rDb3LIQg8OrhkcrZ3duT93cJKHOUkAUcl/mmMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU+8pQOh; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57b35e176dbso7974160e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761119945; x=1761724745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TAuOFmibaRaSmRnnPLTvDUwbdurIRPGvDL2ua9DN0qA=;
        b=fU+8pQOhkxyCUqojASCkPoD1QWXojYDJoTHCugnsVBNgVOrdjBkEcjNkVyff2p/G5R
         /QDabQNWWw+tXHkXm1Xxb9UwGkorZ+ZTljwU/ilGdUEyiW/8xW2UQ5PFj/CkPxFVG1X5
         RaT59S5Mg2Gz4wtrLjjUHU2ALKQikB/niYoVsE0sVME1il/OvoV/HBV49+1NObQULRW6
         bLgCXbjgytbv3rvmx+RhcRnfegFCktyRJwrbZ/eQUH31IT+2Hvaua3roobQ2tAj9911C
         LntZ/qYIMhYMsk/A8ey0sD+YHT+kqNtVnKmrmSZAYwdm0a3LrBLSSsDT4WyaI7NEPHoe
         Ui2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119945; x=1761724745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuOFmibaRaSmRnnPLTvDUwbdurIRPGvDL2ua9DN0qA=;
        b=eGkGRo5WnRPs0lPaZv1ClUEUa3MoJKV8hZrgXJnedh/UIKYmQcnEdMjHIp+RYikiDM
         A5PRsybnxl/9yj6FPqrY0QWE5zXDat5ZAwPvKvHb6Sre7jBmmhiARtTTqfNMQ2QCjNzj
         3Ny5cyX5yd1tvxkZvxY3PN2wTMJhybyyuZVwRZQPTaSdLRU3+zMBqbF4OoENnxPT1iqj
         x6WiSzcajZiY+KBsh0F2srHalvtDT4n5uvTSlIFStlJnKiO28BLt4ruu7MkIXTnhE83j
         gtXYYsvGtrLWwRWTjynOLSloZhZPdi1UgB4u5YR2c4vQNjWazh7zr4wjUa20HjQzsxp+
         ot5w==
X-Forwarded-Encrypted: i=1; AJvYcCVy8imL6LqibwHzCFI0AXOI//oEcfUlFZVBmXAVJ0/Wj6rfc7wLF+kIXGbt5r8tbqrtRK9B1L2EllT/5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRvcA/krKqtqykUU0BiXijxgchAa7nErBhs6nhN1TRmQ3d5FF
	mXKcCq0UNHq7Z60RNFhFZ08nJifw4kulKL2uNlI2MnbOoKOqyteyuPCM
X-Gm-Gg: ASbGncuDUd6n6CptbzBjUj1B5PxDGozC41Y2LtQeMJ7fojd5Hs+2Aywqjyzo/ShAqvj
	gMTwGIahQYqepEXBFRQp8RfgPF8KyanJHnZBY5bNdd4K6u1FN30BblkAHkuaCJT/96h14DwEgLl
	AJRn6UA2Tkc9e4SIfDGUIR7TZLMrTRVF2cs8nvF6MXrEgS1grgAItO59hRAcWt5ZmRAJZWKDBHi
	WFeDLE2cNZR7Op7HVU+YfnK8t8zhdxYg7jaoNUpMOM8fRmQsYzW/hJjSeVoGQuyoPBeau6CXtCL
	VcKinULtQ9NYOI/c725Oxo+5E9KSHI/CvbWfIYdAfOEOC+0zaFrNTA1PFXh4ed/AMkfNQwfcqO7
	CUn+wrLWiZ+wpoQDOSNmng5oeNmfoM/n5bbVY5BL8ir2Yhm3LZOun+FNvnt6aY4UzusHr/D0fud
	cBpI8mmlHxU3Hk8480c1U0vMC+kkPQEi5txPq61Mo7siv9ZO8=
X-Google-Smtp-Source: AGHT+IGePF5GY7HyPCsbSDcURO+wThAy6H9Ui6FSBxLQxWZA0e6cTLI1Aee4qoP5LBvWCtthMvh/ew==
X-Received: by 2002:a05:6512:3da1:b0:585:3109:bb93 with SMTP id 2adb3069b0e04-591d8564b51mr6661830e87.55.1761119944387;
        Wed, 22 Oct 2025 00:59:04 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591eb0d4be3sm1645800e87.91.2025.10.22.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:59:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:59:01 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: remove unneeded semicolon
Message-ID: <aPiOxYYY_dPkShsW@gmail.com>
References: <20251022-st7571-semicolon-v1-1-83d322618ff4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eTVSVn3PPTE1QalB"
Content-Disposition: inline
In-Reply-To: <20251022-st7571-semicolon-v1-1-83d322618ff4@gmail.com>


--eTVSVn3PPTE1QalB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 08:10:57AM +0200, Marcus Folkesson wrote:
> Fix style issue reported by Kernel test robot.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510221125.Cg0sM4xJ-lkp@i=
ntel.com/
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/gpu/drm/sitronix/st7571-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitr=
onix/st7571-i2c.c
> index 32b91d65b768b26caa7dcef42a00d36f236fbc32..4e73c8b415d677dab5b421666=
b56f4bb3697b982 100644
> --- a/drivers/gpu/drm/sitronix/st7571-i2c.c
> +++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
> @@ -322,7 +322,7 @@ static void st7571_prepare_buffer_grayscale(struct st=
7571_device *st7571,
>  		size =3D (rect->x2 - rect->x1) * (rect->y2 - rect->y1) / 4;
>  		memcpy(st7571->hwbuf, vmap->vaddr, size);
>  		break;
> -	};
> +	}
>  }
> =20
>  static int st7571_fb_update_rect_monochrome(struct drm_framebuffer *fb, =
struct drm_rect *rect)
>=20
> ---
> base-commit: c1a7cc00cd412505e070eb4e62bc0b0ca85243e0
> change-id: 20251022-st7571-semicolon-bc5287cde264
>=20
> Best regards,
> --=20
> Marcus Folkesson <marcus.folkesson@gmail.com>
>=20

Pushed to drm-misc-fixes.

Best regards,
Marcus Folkesson

--eTVSVn3PPTE1QalB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmj4jsAACgkQiIBOb1ld
UjLMPA//ZQq3SPQ1QOCTlYHoxVF76fxGwzlNFDCNVtE5kkFe2qp6jk6CZBvKRvTy
zx2D/eBt2LRoahlASY9shrwsgSvdCjZcKcscB8VPIXSJlqd74Bq0hCztYq6pIYgk
VZoAmmGIT2LSUbLAYEvj6hz6IgNsYkfzNLzVp/kPCplWs6YS9S+fdS3quChlWuE7
Es88rYmr6X+Fh9JbMiIXg0xXc/yEWR4kNsLNyWb5CBY0edMaWZZbB4HbnHj0PVH4
IRzm6YkbBCfEjGzFmOiYFKQqTm0zgpso/dJUHK0+zZDl6Y39dxZhfvWi0G/goBiY
Sj9GF67P3zoVSOKLul1t4bHiGSIqsm4CP3gdF7DgSBg8zez2ZI5tGtS+s+PeDnpQ
79m5cPu30l8Mu/d+2IViDs2p42Sv01i0nyStkJpH6iRXKCh6d8eM9hL19KO02YdR
a3nT6fmUf9DRP2wu1jezJHZv9+XUXoS1XbmyYePmwtZzMXKWhPjIGuWIBCzyF4w+
BQEHShbfDgg6ZAqpamfY+wo8MyI1mZ+bla4KJk442X4g9W0R7nJLA59AOlRiD4Lu
yj5H+04KQSwjjbOneaZ4DBN/X4kSqmeR9k1U0H7sNfYCgotyUNTxXDN45+SI5bo4
0qAOFK2rYCdAZDtG6K4LMbd9lvHyM2ExSt3CgR6W+F0J4jkn5FA=
=8X8b
-----END PGP SIGNATURE-----

--eTVSVn3PPTE1QalB--

