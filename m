Return-Path: <linux-kernel+bounces-810001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C6B51470
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA5754207B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17223164A7;
	Wed, 10 Sep 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRKNmgeh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63143148BB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501391; cv=none; b=fOECLvMVZ3BWkErlX1ovTfkUa15W9Ix3lz6vVvIhtO1Rtw6vHueRoOj9zxdOEyNKUf3EEn0eMqqzej1lFp4hYlqxGAvDGP2BS8ZQ8i/H3Dskrgkoi/AGlPa0Wg0j5O7LKQDEm7gBAo1IF+HkLJmYBigak8TGNa/t9Y5xOZguWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501391; c=relaxed/simple;
	bh=1scGAYzK3UFwbg234OVlTstFWXGW6ME6pu6GwUoQ1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVTu41rHI2DhJ7pGaAo6IW5yqN+7SnNy3EZJS5cgMsrKhNz1t7wa1iJWnTNCJJkEaoRvKxbbj/F/FSIYcGeieZnW2++m4P13ld1PRxgC1vwaGS3YIo4gWZV2UnrIiJsLgwOSE+wWAondZMju6Wh48+CFYMZx58+YdyqNMDnuKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRKNmgeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB89C4CEF5;
	Wed, 10 Sep 2025 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757501391;
	bh=1scGAYzK3UFwbg234OVlTstFWXGW6ME6pu6GwUoQ1r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRKNmgehtOqqARDUabC1auDom7ANnkYT9fw8gllzC4yBAjy92hqe4B1kQ1hbOGtnY
	 ibnvZNihGxFI2wR5WuDYo7pnWXUbWGL/gmBhqvmhEPbnCdU22Xcb87faim2ZiR/PaI
	 Cxh4petA/DJ9kwcqoUzubfnxYoYVOeCVNkfS8TaMeg87Iy58fy+HRE6mQBGecLouJi
	 gPk/ffAd7V80RFIdTFzDjyi2rP8lHbzzc1sw5H7bExh0kei5qmnZn11WwwngYhuCP1
	 2TPcU3OHTMJiqV7sZT/kRpinrG7K/YYVmDU3XtcXNKLo7R0oVIl27FowM+lnQ01GOO
	 TtuTCfFRU+SVw==
Date: Wed, 10 Sep 2025 12:49:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/panic: Add a drm_panic/draw_test in debugfs
Message-ID: <20250910-astute-vole-of-kindness-c6f6ce@houat>
References: <20250908090341.762049-1-jfalempe@redhat.com>
 <20250908090341.762049-4-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="szadnobu3vqjke5f"
Content-Disposition: inline
In-Reply-To: <20250908090341.762049-4-jfalempe@redhat.com>


--szadnobu3vqjke5f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] drm/panic: Add a drm_panic/draw_test in debugfs
MIME-Version: 1.0

Hi,

On Mon, Sep 08, 2025 at 11:00:31AM +0200, Jocelyn Falempe wrote:
> This adds a new drm_panic/draw_test file in debugfs.
> This file allows to test the panic screen rendering at different
> resolution and pixel format.
> It's useful only for kernel developers that want to create or
> customize a panic screen.
>=20
> If you want to check the result at 1024x768 using XRGB8888:
>=20
> cd /sys/kernel/debug/drm_panic/
> exec 3<> draw_test
> echo 1024x768:XR24 >&3
> cat <&3 > ~/panic_screen.raw
> exec 3<&-
>=20
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

I see what you meant in your previous version, and I misunderstood what
you were saying, sorry.

> v2:
>  * Use debugfs instead of sending the framebuffer through the kunit logs.=
 (Thomas Zimmermann).
>=20
>  drivers/gpu/drm/Kconfig     |   2 +
>  drivers/gpu/drm/drm_panic.c | 117 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 119 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7ea8e895c0c..0d3146070d9c 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -83,6 +83,8 @@ config DRM_PANIC_DEBUG
>  	  Add dri/[device]/drm_panic_plane_x in the kernel debugfs, to force the
>  	  panic handler to write the panic message to this plane scanout buffer.
>  	  This is unsafe and should not be enabled on a production build.
> +	  Also adds a drm_panic/draw_test file in debugfs, to easily test the
> +	  panic screen rendering.
>  	  If in doubt, say "N".
> =20
>  config DRM_PANIC_SCREEN
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index d89812ff1935..0c01d6067eab 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -873,6 +873,7 @@ static void drm_panic(struct kmsg_dumper *dumper, str=
uct kmsg_dump_detail *detai
>   */
>  #ifdef CONFIG_DRM_PANIC_DEBUG
>  #include <linux/debugfs.h>
> +#include <linux/vmalloc.h>
> =20
>  static ssize_t debugfs_trigger_write(struct file *file, const char __use=
r *user_buf,
>  				     size_t count, loff_t *ppos)
> @@ -901,8 +902,122 @@ static void debugfs_register_plane(struct drm_plane=
 *plane, int index)
>  	debugfs_create_file(fname, 0200, plane->dev->debugfs_root,
>  			    plane, &dbg_drm_panic_ops);
>  }
> +
> +/*
> + * Draw test interface
> + * This can be used to check the panic screen at any resolution/pixel fo=
rmat.
> + * The framebuffer memory is freed when the file is closed, so use this =
sh
> + * script to write the parameters and read the result without closing th=
e file.
> + * cd /sys/kernel/debug/drm_panic/
> + * exec 3<> draw_test
> + * echo 1024x768:XR24 >&3
> + * cat <&3 > ~/panic_screen.raw
> + * exec 3<&-
> + */

This should be documented properly, and I'm also kind of wondering how
that would fit in the larger testing ecosystem.

Ie, how can someone that just starts contributing to Linux, or is
setting up a CI platform, can have that test running.

kunit is great for that, kselftests to some extent too, but I'm not sure
an ad-hoc interface is.

Unless we create IGT tests for it too maybe?

Maxime

--szadnobu3vqjke5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMFXyAAKCRAnX84Zoj2+
dunxAXoD/kd6NxYE7g0sLGTeai0rI+buW7iXgUXOw4+dMG2ZK2K7uCjj9LJiQwaz
bTPx8+QBf2q+pKsyVxyWG0ny+ZSnetRJWKMN8+fXCxf6ORHE9MWP/nXFSn5Zga4y
zds9rfAwQw==
=9+Uw
-----END PGP SIGNATURE-----

--szadnobu3vqjke5f--

