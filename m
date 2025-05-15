Return-Path: <linux-kernel+bounces-649083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F84AB7FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3A17B42AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451A283FD7;
	Thu, 15 May 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERYcFq8v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3E2248AE;
	Thu, 15 May 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296698; cv=none; b=cgVWRlBfho1BzIUvi8rhQNcn7Bh2aN++McESiRvGxN0lQc5lQ6VXOC8Q4cnbH2QtQ8Lt4RR5n+0WdERMSDdiJ/ZGOoUXfxpBzOt0SdsEJzSR/+H6ITOa6X4rC/RrO2UZ1JsuJQeIbRQcIkGSBcAA+UIZZ3cIYNo5mXOEUmfztxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296698; c=relaxed/simple;
	bh=rbVrD9MiC3jK5EeZ9PE0xRdvA68qJ3Hw81sCpkWBrPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQLF5s0Gf0o+x0nsh+J1DVsCDfgMfpU9KahNF60l6JoYhw0nL7Han75RnznTa6VNWpVYvO6NkB8So/L9FkR4N4L+n1plgUiw65guiJJCGga/gU84MkR6VxyhLm1qjhV2OdZZut05tUiW4nnqnOSQOW0Ox2ZnEVO3N6AN6ruZg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERYcFq8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14837C4CEE7;
	Thu, 15 May 2025 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747296697;
	bh=rbVrD9MiC3jK5EeZ9PE0xRdvA68qJ3Hw81sCpkWBrPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERYcFq8viWWHeLzIq3zF3TXSURmbyOBjFGwFrxgsfBKl/Vl1cM37pvAxOajCil7f0
	 j2P9euHQBTiqNh9uSCMBrpeSTLkv0XdnEz+4gocdIzdeHzOm530N52Q1X35dMIhNvL
	 IR0ufUzR5vuqbjr87pM7vEV0BnCtiiZGmDz3nQ9VXcuaWifoN9vfuWhp7Zg2BRbTUB
	 Fsp5AYee8t1CRiUcL0WwWIIupiMLEMMKNCHE05gR9q/BDOShObu9TGOvtYIshj8Te6
	 1tf/j/3IDH4CW7woXYH53Yomw5CqD0dv+nGZvGIjGGPSmbmjdNl0VMJvhEvABKm6UP
	 VZe48MnF/jggg==
Date: Thu, 15 May 2025 10:11:33 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, Paul Kocialkowski <paulk@sys-base.io>, 
	Dmitry Baryshkov <lumag@kernel.org>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] drm/tests: bridge: add a KUnit test for
 devm_drm_bridge_alloc()
Message-ID: <gqe4ov7w54qe7mmfn2ud63g2ema2wh3qvyfvcaycvnh5mts3it@ef7qxryo2ccy>
References: <20250409-drm-bridge-alloc-doc-test-v7-0-a3ca4b97597f@bootlin.com>
 <20250409-drm-bridge-alloc-doc-test-v7-2-a3ca4b97597f@bootlin.com>
 <20250414-misty-hungry-woodlouse-dbbd64@houat>
 <20250415132214.19b1a4ff@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rle4hqmce2dkwfou"
Content-Disposition: inline
In-Reply-To: <20250415132214.19b1a4ff@booty>


--rle4hqmce2dkwfou
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/2] drm/tests: bridge: add a KUnit test for
 devm_drm_bridge_alloc()
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 01:22:14PM +0200, Luca Ceresoli wrote:
> > > +/*
> > > + * Mimick the typical struct defined by a bridge driver, which embed=
s a
> > > + * bridge plus other fields.
> > > + */
> > > +struct dummy_drm_bridge {
> > > +	int dummy; // ensure we test non-zero @bridge offset
> > > +	struct drm_bridge bridge;
> > > +}; =20
> >=20
> > drm_bridge_init_priv gives you that already.
>=20
> On one hand, that's true. On the other hand, looking at
> drm_bridge_init_priv I noticed it is allocating a bridge without using
> devm_drm_bridge_alloc(). This should be converted, like all bridge
> alloctions.
>
> So I think the we first need to update drm_bridge_test.c to allocate
> the bridge using devm_drm_bridge_alloc(), along with the needed changes
> to the kunit helpers.

Oh, yeah, absolutely.

> One way would be allocating the entire drm_bridge_init_priv using
> devm_drm_bridge_alloc(), but that does not look like a correct design
> and after reading the helpers code I'm not even sure it would be doable.
>=20
> Instead I think we need to change struct drm_bridge_init_priv
> to embed a pointer to (a modified version of) struct dummy_drm_bridge:
>=20
>  struct drm_bridge_init_priv {
>          struct drm_device drm;
>          struct drm_plane *plane;
>          struct drm_crtc *crtc;
>          struct drm_encoder encoder;
> -        struct drm_bridge bridge;
> +        struct dummy_drm_bridge *test_bridge;
>          struct drm_connector *connector;
>          unsigned int enable_count;
>          unsigned int disable_count;
>  };
>=20
> So that devm_drm_bridge_alloc() can allocate the new test_bridge
> dynamically:
>=20
>  priv->test_bridge =3D
>    devm_drm_bridge_alloc(..., struct dummy_drm_bridge, bridge, ...);
>=20
> Do you think this would be the correct approach?

It's kind of correct, but you're also correct that it's probably too
much for those simple tests, so it might not be worth it in the end.

> > > +static const struct drm_bridge_funcs drm_bridge_dummy_funcs =3D {
> > > +};
> > > +
> > > +static int drm_test_bridge_alloc_init(struct kunit *test)
> > > +{
> > > +	struct drm_bridge_alloc_test_ctx *ctx;
> > > +
> > > +	ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > > +
> > > +	ctx->dev =3D kunit_device_register(test, "drm-bridge-dev");
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
> > > +
> > > +	test->priv =3D ctx;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Test that the allocation and initialization of a bridge works as
> > > + * expected and doesn't report any error.
> > > + */
> > > +static void drm_test_drm_bridge_alloc(struct kunit *test)
> > > +{
> > > +	struct drm_bridge_alloc_test_ctx *ctx =3D test->priv;
> > > +	struct dummy_drm_bridge *dummy;
> > > +
> > > +	dummy =3D devm_drm_bridge_alloc(ctx->dev, struct dummy_drm_bridge, =
bridge,
> > > +				      &drm_bridge_dummy_funcs);
> > > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dummy); =20
> >=20
> > Why did you need the dummy value in dummy_drm_bridge if you're not using
> > it?
>=20
> To ensure we test non-zero @bridge offset. Say there is a bug in the
> pointer math, e.g. 'bridge =3D container - offset' instead of 'bridge =3D
> container + offset'. That would not be caught if @bridge is the first
> field in the struct.
>=20
> Does this look like a good reason to keep it?

Ack, but please document it with a comment

> > We'd need a couple more tests, in particular some to make sure the
> > bridge pointer is properly cleaned up when the device goes away, but not
> > when we have called drm_bridge_get pointer on it, etc.
>=20
> It would surely be useful, and there was one in the initial patch I
> sent ([0], search for "destroyed"). Then I removed it because the code
> changed, there is no callback anymore, so no place where this can be
> tested.

Why did we end up removing the destroy hook? It looks useful to me.

> I'd be glad to re-add such a check but I don't see how it could be
> implemented in a clean, non-invasive way.
>=20
> The only way that comes to mind is be that the kunit test does not call
> drm_bridge_put() but rather a kunit-specific reimplementation that
> passes a reimplementation of __drm_bridge_free() which does the
> accounting. Quick draft (note the added "_test" infix):
>=20
> struct dummy_drm_bridge {
>         struct drm_bridge_init_priv *test_priv;
>         struct drm_bridge bridge;
> };
>=20
> // reimplemented version of __drm_bridge_free
> static void __drm_test_bridge_free(struct kref *kref)
> {
>         struct drm_bridge *bridge =3D container_of(kref, struct drm_bridg=
e, refcount);
> 	struct dummy_drm_bridge *dummy =3D bridge->container;
> =09
> 	dummy->text_priv->destroyed =3D true;
>         kfree(bridge->container);
> }
>=20
> // reimplemented version of drm_bridge_put
> void drm_test_bridge_put(struct drm_bridge *bridge)
> {
>         if (bridge)
>                 kref_put(&bridge->refcount, __drm_test_bridge_free);
> }
>=20
> My concern with this idea is that it is not testing the actual
> drm_bridge.c code, but a different implementation. Even more, if the
> functions in drm_bridge.c will change, the ones in drm_bridge_test.c
> might be forgotten, thus we'd end up in testing code that is different
> from the code actually used.

Yeah, I agree, it's not really useful if it's not testing the code we
would typically run.

> Another way would be adding an optional .destroy a callback in struct
> drm_bridge_funcs that is called in __drm_bridge_free(), and only the
> kunit test code implements it. Maybe looks cleaner, but it would be
> invasive on code that all bridges use. We had discussed a different
> idea of .destroy callback in the past, for different reasons, and it
> was not solving the problem we had in that case. So kunit would be the
> only user for the foreseeable future.

Sorry, we've had many conversations about all that work so I can't
recall (or find) what your objections or concerns (or mine, maybe?) were
about thing topic. It looks totally reasonable to me, and consistent
with all the other DRM entities.

I'm also not entirely sure how invasive it would be? Add that callback,
check if it's set and if it is, call it from __drm_bridge_free(), and
you're pretty much done, right?

Maxime

--rle4hqmce2dkwfou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaCWhrwAKCRAnX84Zoj2+
dp8wAYDZZz4HohGInsWZy07HZIxX0HMbp0PSquVavPaf008d3H0IZzlRRPj6NV1t
29nDYdoBgJ0iHLfCi6462W/6SPnuZwjhuK3xo8qH8E5zn1FgM6OBpNfEQGxgbxU6
xsT9rNLviQ==
=OO2v
-----END PGP SIGNATURE-----

--rle4hqmce2dkwfou--

