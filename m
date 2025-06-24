Return-Path: <linux-kernel+bounces-700050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1231CAE632F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F31925786
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943C28467D;
	Tue, 24 Jun 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkJ90pxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE8126C05
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762923; cv=none; b=T295nmvuo6Qq/YJaOIoBvrvNqMViqUaIV6Y8jCm8aeJJkMzQDzQHYwObdgQboMx0US02iwe5uTXWtpSjY5SR4cUSsh9pSqshZD9+NfE77t4NZj8NReyeke/uB/c4Puy+CvE8jOFYHhfWhUlkRdBi3hsNYactC6eqAeUz6xY7QvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762923; c=relaxed/simple;
	bh=SGZ39pfKwm56ViIlmBnvV+CwkHywLLMqm7iEHA3V79I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaK/DpysC1bdfLe2m4oEYxS12OzzTfx42zVl3hxp71ad4P+VQO3WHmVWLuPFHGK1vjYG20sQRRzeCBRWJPMGwiNN//WZeSY8b+8BoL63O+JchqadX/n8yn1WvMY/lXs5kTXTwKYgcP9Orm7brg40icpoPLLNj94z8NZoNE9+Nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkJ90pxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DEDC4CEE3;
	Tue, 24 Jun 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762923;
	bh=SGZ39pfKwm56ViIlmBnvV+CwkHywLLMqm7iEHA3V79I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkJ90pxCEFjmylcgGpief/8ur89cSKa+cl7vm95NNTByL9deC/3wA/N3xTT3cXWpa
	 KxBqW5idvK08YcCwOOYJlbhtid6oKR9CkgrkMGQmXnGHCbMXju1VDrtLejm0Dn/Wyi
	 zvh8CAohymVsR6uRNf+1tM0UlNKitYy9rqBxW+g5Nnhoybjx2ZJNKn2xFDMUHrOVtf
	 WaRXqRFJNrSVZZvSVOqvIog78KKsTshdF6P7yc+ZFIkQTqnfokSHnGgcgryu8Y+iWS
	 ApO19sHivxOCko6MLdtodOV/xXPuDsm+CHyV+xs63TTqpqsqDJYHz/2lW05+NfipFN
	 ef5sraDOTGBbA==
Date: Tue, 24 Jun 2025 13:02:00 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm/bridge: microchip-lvds: switch to use atomic
 variants
Message-ID: <20250624-beautiful-goose-of-penetration-c4ffde@houat>
References: <20250624-microchip-lvds-v4-0-937d42a420e9@microchip.com>
 <20250624-microchip-lvds-v4-2-937d42a420e9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yqukqchdcj2ncglh"
Content-Disposition: inline
In-Reply-To: <20250624-microchip-lvds-v4-2-937d42a420e9@microchip.com>


--yqukqchdcj2ncglh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] drm/bridge: microchip-lvds: switch to use atomic
 variants
MIME-Version: 1.0

On Tue, Jun 24, 2025 at 02:54:15PM +0530, Dharma Balasubiramani wrote:
> Modernize the bridge ops to use atomic_enable/disable.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  drivers/gpu/drm/bridge/microchip-lvds.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/br=
idge/microchip-lvds.c
> index 42751124b868..e4ff46b03d54 100644
> --- a/drivers/gpu/drm/bridge/microchip-lvds.c
> +++ b/drivers/gpu/drm/bridge/microchip-lvds.c
> @@ -111,7 +111,8 @@ static int mchp_lvds_attach(struct drm_bridge *bridge,
>  				 bridge, flags);
>  }
> =20
> -static void mchp_lvds_enable(struct drm_bridge *bridge)
> +static void mchp_lvds_atomic_pre_enable(struct drm_bridge *bridge,
> +					struct drm_atomic_state *state)
>  {
>  	struct mchp_lvds *lvds =3D bridge_to_lvds(bridge);
>  	int ret;
> @@ -127,11 +128,26 @@ static void mchp_lvds_enable(struct drm_bridge *bri=
dge)
>  		dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
>  		return;
>  	}
> +}
> =20
> +static void mchp_lvds_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_state *state)
> +{
> +	struct mchp_lvds *lvds =3D bridge_to_lvds(bridge);
>  	lvds_serialiser_on(lvds);
>  }
>
> -static void mchp_lvds_disable(struct drm_bridge *bridge)
> +static void mchp_lvds_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_state *state)
> +{
> +	struct mchp_lvds *lvds =3D bridge_to_lvds(bridge);
> +
> +	/* Turn off the serialiser */
> +	lvds_writel(lvds, LVDSC_CR, 0);
> +}
> +
> +static void mchp_lvds_atomic_post_disable(struct drm_bridge *bridge,
> +					  struct drm_atomic_state *state)
>  {
>  	struct mchp_lvds *lvds =3D bridge_to_lvds(bridge);
> =20
> @@ -141,8 +157,10 @@ static void mchp_lvds_disable(struct drm_bridge *bri=
dge)
> =20
>  static const struct drm_bridge_funcs mchp_lvds_bridge_funcs =3D {
>  	.attach =3D mchp_lvds_attach,
> -	.enable =3D mchp_lvds_enable,
> -	.disable =3D mchp_lvds_disable,
> +	.atomic_pre_enable =3D mchp_lvds_atomic_pre_enable,
> +	.atomic_enable =3D mchp_lvds_atomic_enable,
> +	.atomic_disable =3D mchp_lvds_atomic_disable,
> +	.atomic_post_disable =3D mchp_lvds_atomic_post_disable,
>  };

Like I said to you earlier today, it's not just what you claim it is.
You're splitting enable into atomic_pre_enable and atomic_enable, and
disable into atomic_disable and atomic_post_disable.

At the *very* least this should be explained in your commit log, and it
would be much better if it was done in another patch.

Maxime

--yqukqchdcj2ncglh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaFqFqAAKCRAnX84Zoj2+
dgtgAYDPf0huimnR82xcduXIE32eMBTRTxS5RWRYhOpMH6EBv6AgkUbZ8axPdrT3
JKb4Mz8BgJjlzOB8ZPEOjxsrsY2SjTq6PSukIFjXTGV6Q4vCOQEBwERBN9s8pSFe
C199SYhMJA==
=JjCc
-----END PGP SIGNATURE-----

--yqukqchdcj2ncglh--

