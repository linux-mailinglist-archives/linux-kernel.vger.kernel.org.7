Return-Path: <linux-kernel+bounces-781680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75EB3156C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757D7167C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637D32EFDB2;
	Fri, 22 Aug 2025 10:29:48 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC42EFD8B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858588; cv=none; b=TdTZEsWilG6sz3A2MS8SFgDpwFbADbCzJ79TEx7jrQ2aUhgQeMOu87OGnw9STfX1+Zsy8EHWaikuUI+Fc0gYy2x9koFKzTPpKuqrqCevBjszg9fbXTRVyEi/QN1hDXfFYUmPhTXDR0UmWHVfo7uFmB/T0jKYOJCYLzEe3iLwdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858588; c=relaxed/simple;
	bh=kB0xCrcZ1sA4vsR286bIAX6688rH45wxCTl4GDxP2S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO3Szvx2h+446hXSyG7sV31LITgnhnEnQ16VFuZE7KCgRDtMPbrN3R1Re5MwuslDXYHKWPaMhqX7K0sYW7FcBH0ZVy6kA7l1HvxpDtywgNbQFbVoo6FKrmOdeU6kQ/j1m1teoupk5p+SKTkWnj1rE4bmXj0+HlHHIoq0NNQdDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 505F91F0006A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:24:04 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id ECEECB01C62; Fri, 22 Aug 2025 10:24:01 +0000 (UTC)
X-Spam-Level: 
Received: from shepard (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id C43A7B01C52;
	Fri, 22 Aug 2025 10:23:59 +0000 (UTC)
Date: Fri, 22 Aug 2025 12:23:57 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] drm/sun4i: Cleanup v3s mixer config fields ordering and
 indentation
Message-ID: <aKhFPRP8ILNkKAvy@shepard>
References: <20250704154149.3464461-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MlV5q36HRY4ckIBP"
Content-Disposition: inline
In-Reply-To: <20250704154149.3464461-1-paulk@sys-base.io>


--MlV5q36HRY4ckIBP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri 04 Jul 25, 17:41, Paul Kocialkowski wrote:
> The v3s mixer config definition is a bit messy. Tidy it up.
> No function change is intended.

This patch didn't make it in the previous cycle.
Would it be possible to pick it up this time?

Thanks!

Paul

> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 8b41d33baa30..674b55f218fc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -670,12 +670,12 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer=
1_cfg =3D {
>  };
> =20
>  static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg =3D {
> -	.vi_num =3D 2,
> -	.ui_num =3D 1,
> -	.scaler_mask =3D 0x3,
> -	.scanline_yuv =3D 2048,
> -	.ccsc =3D CCSC_MIXER0_LAYOUT,
> -	.mod_rate =3D 150000000,
> +	.ccsc		=3D CCSC_MIXER0_LAYOUT,
> +	.mod_rate	=3D 150000000,
> +	.scaler_mask	=3D 0x3,
> +	.scanline_yuv	=3D 2048,
> +	.ui_num		=3D 1,
> +	.vi_num		=3D 2,
>  };
> =20
>  static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg =3D {
> --=20
> 2.49.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--MlV5q36HRY4ckIBP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmioRT0ACgkQhP3B6o/u
lQzkTg//WFiyxqhfUY6FczVWL/ImHTtICZrkvrBZX0dJV2uHqYzypnnyT6NxmMxk
SDXCSLmVFsSMoND1aiqS5dc4eYOPlSmo/hpJib1+nfo+1VTrB7dgafngaUpgcEXh
JBfaN92tUfhO+Aw/XSDY3Bh1vdYJt4LH/IfSpN7OFnULBw6/VVwVkOYUm/UvSFzf
RUGZ3WCqf/N9pVUDCTV8uRU104hhbZk8l6N4afTKcR3X6ol399SLZzZz+7y0UJWl
fU9229JlB9ndl1Pg5LsQz/eclJA0KFNAe6+EN1lHxDqReaiAtziTtIVzgdQLtpga
AUYSqY9oVinh0Bl2ENP5MmFFCBTduNN6/HK6IXH6wPIdMUpmU24w/Rw+MtUl/c4+
xkZ5L6U5idcFfEW/R+Tv8fyOVeCLXxDGg0gAhyo6wcf9k2HKDI1IV/FVeCaCs5wD
ztKSieqm6mr6xBIvdL9vKeLEAik1AmlNkpYQo4HFirxRCr+M/UlUeFf3NSlWhfx4
9WyDwMcctDD8ESW3V2Q3oYAPmQPh84oX2uMDyd19djNwcy+rxwvWmQc4X4ESFZDe
nE7BYg6g1UvJlLBIpWxEACNoX+oBJ/AIVtReJmmWB2wXFpTTZo5jOobrDnYHxOe1
ck45AXtCLJVrvt+LfBPR3XxAYalBQfW6zYsLjXUh+OlC7yq9Giw=
=aSaL
-----END PGP SIGNATURE-----

--MlV5q36HRY4ckIBP--

