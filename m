Return-Path: <linux-kernel+bounces-788045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEB4B37F20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDE51BA3F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B233451A2;
	Wed, 27 Aug 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2C1AzYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D3342CA2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287900; cv=none; b=FnTGd0flVC7mqZsQRO6o3p5ZFSjkTMQGRtYnrP9i112GTThRsU3O7E8L9I3PjUMHRNAtH2hVSF5FfOWsZJHwE3SAQX8b4SGkNzDveTQpm68IscgFhAPJ5F5K/WvDXgYU5CCAS+ByTNrOLvf86QBkakERG83twgHCEN3ZIj6+7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287900; c=relaxed/simple;
	bh=IQmmmnOV4AonCKd4nzcG4Jt17mDk0i/CU33Y9/xne9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVVIMIsNP2jY2OTOm6FSiZx8L3IfzU8bOAwKI9wzxx9vjhrJgVaufO8c4/i6hNNShigua0n7ehTw8uPLs6D1dybSNQvpo00dBdh8TIPOo8T5ym7gprpey6ieQB10ZLYcwt/GkNxyf2tOSycVc/w8sjQ7xeSLDvaH1mRp9MdXn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2C1AzYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E06FC4CEEB;
	Wed, 27 Aug 2025 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756287898;
	bh=IQmmmnOV4AonCKd4nzcG4Jt17mDk0i/CU33Y9/xne9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2C1AzYi48LmBNWRPCk61Qt80s0JK11EZ7aefmNSO3cxpCsbX5Yzw0ITbrSP/cnlV
	 Wdmwh99ycI8zE/7KWcn5mxTwO2gdfWZvDPGKiTSXQ60xuzvcY30G39xvfaB5A95Egc
	 xs45MhmLybsAOnN5/Q01O4fkdKYlV3/EkeJGNnnx2tI556QS9VUrIdemGHAttZTLY5
	 5TWgNEh07lBTmoYEJLNuwudtgY+fPlKnyjg8Yvqw54qlytSi+QHPwSkoOnqxMcyufS
	 L3loxfeKqV/gfU+LH7624V4FavYH0aWjy2lHuqkRoM5Ms1Y/l0k4lVQMGPyfUanBiR
	 swQ3L6pZP8h9A==
Date: Wed, 27 Aug 2025 11:44:56 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/panic: Add kunit tests for drm_panic
Message-ID: <20250827-wooden-kakapo-of-defense-0c4273@houat>
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="howmumtkmtde4tfb"
Content-Disposition: inline
In-Reply-To: <20250821095228.648156-3-jfalempe@redhat.com>


--howmumtkmtde4tfb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] drm/panic: Add kunit tests for drm_panic
MIME-Version: 1.0

Hi,

On Thu, Aug 21, 2025 at 11:49:06AM +0200, Jocelyn Falempe wrote:
> Add kunit tests for drm_panic.
> They check that drawing the panic screen doesn't crash, but they
> don't check the correctness of the resulting image.
>=20
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  MAINTAINERS                            |   1 +
>  drivers/gpu/drm/drm_panic.c            |   4 +
>  drivers/gpu/drm/tests/drm_panic_test.c | 164 +++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfa28b3470ab..285d1e27734f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8465,6 +8465,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kern=
el.git
>  F:	drivers/gpu/drm/drm_draw.c
>  F:	drivers/gpu/drm/drm_draw_internal.h
>  F:	drivers/gpu/drm/drm_panic*.c
> +F:	drivers/gpu/drm/tests/drm_panic_test.c
>  F:	include/drm/drm_panic*
> =20
>  DRM PANIC QR CODE
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 1e06e3a18d09..d89812ff1935 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -986,3 +986,7 @@ void drm_panic_exit(void)
>  {
>  	drm_panic_qr_exit();
>  }
> +
> +#ifdef CONFIG_DRM_KUNIT_TEST
> +#include "tests/drm_panic_test.c"
> +#endif
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> new file mode 100644
> index 000000000000..46ff3e5e0e5d
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +/*
> + * Copyright (c) 2025 Red Hat.
> + * Author: Jocelyn Falempe <jfalempe@redhat.com>
> + *
> + * KUNIT tests for drm panic
> + */
> +
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_panic.h>
> +
> +#include <kunit/test.h>
> +
> +#include <linux/units.h>
> +#include <linux/vmalloc.h>
> +
> +struct drm_test_mode {
> +	const int width;
> +	const int height;
> +	const u32 format;
> +	void (*draw_screen)(struct drm_scanout_buffer *sb);
> +	const char *fname;
> +};
> +
> +/*
> + * Run all tests for the 3 panic screens: user, kmsg and qr_code
> + */
> +#define DRM_TEST_MODE_LIST(func) \
> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_XRGB8888, func) \
> +	DRM_PANIC_TEST_MODE(300, 200, DRM_FORMAT_XRGB8888, func) \
> +	DRM_PANIC_TEST_MODE(1920, 1080, DRM_FORMAT_XRGB8888, func) \
> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB565, func) \
> +	DRM_PANIC_TEST_MODE(1024, 768, DRM_FORMAT_RGB888, func) \
> +
> +#define DRM_PANIC_TEST_MODE(w, h, f, name) { \
> +	.width =3D w, \
> +	.height =3D h, \
> +	.format =3D f, \
> +	.draw_screen =3D draw_panic_screen_##name, \
> +	.fname =3D #name, \
> +	}, \
> +
> +static const struct drm_test_mode drm_test_modes_cases[] =3D {
> +	DRM_TEST_MODE_LIST(user)
> +	DRM_TEST_MODE_LIST(kmsg)
> +	DRM_TEST_MODE_LIST(qr_code)
> +};
> +#undef DRM_PANIC_TEST_MODE
> +
> +static int drm_test_panic_init(struct kunit *test)
> +{
> +	struct drm_scanout_buffer *priv;
> +
> +	priv =3D kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	test->priv =3D priv;
> +
> +	drm_panic_set_description("Kunit testing");
> +
> +	return 0;
> +}
> +
> +static void drm_test_panic_screen_user_map(struct kunit *test)
> +{
> +	struct drm_scanout_buffer *sb =3D test->priv;
> +	const struct drm_test_mode *params =3D test->param_value;
> +	void *fb;
> +	int fb_size;
> +
> +	sb->format =3D drm_format_info(params->format);
> +	fb_size =3D params->width * params->height * sb->format->cpp[0];
> +
> +	fb =3D vmalloc(fb_size);
> +	KUNIT_ASSERT_NOT_NULL(test, fb);
> +
> +	iosys_map_set_vaddr(&sb->map[0], fb);
> +	sb->width =3D params->width;
> +	sb->height =3D params->height;
> +	sb->pitch[0] =3D params->width * sb->format->cpp[0];
> +
> +	params->draw_screen(sb);
> +	vfree(fb);
> +}

You need to document what you're testing, and what the expected result
is.

Maxime

--howmumtkmtde4tfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK7TlwAKCRAnX84Zoj2+
dlG7AX9KdrHTzAhHPfeWF3SuY9pZwJOBNx61rGiIuFzhB6mEWf+wF2mBSuNWN+ZI
EANpL90BgO2BFiQVMoJRJ7+wdlEyfbcNiJ61jntwEAwnRqe5+cDJUU/b5gkNMIWx
1XLFgWTXbg==
=ej9Q
-----END PGP SIGNATURE-----

--howmumtkmtde4tfb--

