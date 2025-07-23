Return-Path: <linux-kernel+bounces-741945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D3DB0EB10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A103AD4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1322571B4;
	Wed, 23 Jul 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPIhSHHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE6246BCF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253830; cv=none; b=fTPhISmNKqg89d3rT4rA0YzSvV6kjCa9TAEnuNyEGCG5ocpY9BF2/pVimDs438iMM8+WEjL986HmsIGvsh5MtHiII+H0gi8T9YTonSmM643Cdhs5h99vDAXhuZzwTtl+QXNBw+Y1dJaQYzdQxBUalxjIZf31lXzIPmikDO7kG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253830; c=relaxed/simple;
	bh=RVU+KRzzrapNt7trRutwG9dz5pii8N4G+QFx0z4cerQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2CBuEtPDztnhj1dfhuvQoLsqOnxdN8Zaj9Gx8F5D2tFdfoQwCSGZJQG/50h5sUy/BPvJX/NhsJsAsDG3hPUiY1R0sA3eLFzZK8O46ZE8sW1uIhcdoWxeQvZLhQbqs1jhmRrW8pVCG7qp6UeAvZ/bPiJ50K88Adb8OvXqANuDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPIhSHHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A4C4CEE7;
	Wed, 23 Jul 2025 06:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753253830;
	bh=RVU+KRzzrapNt7trRutwG9dz5pii8N4G+QFx0z4cerQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPIhSHHApLwAe8MDh8immv2YlR4w5M5EDhf4iqfHnjzuZz8vL2u3OQIHagkAxFANG
	 lgAf8+r0FAN7aT/it8TYikZHG2B7EmGSVETevK4eBpu4mrznYrgzDQzO2GDPMXEpTJ
	 kHePx1XtvlGSgMWKMNnSHX/SYogNSarb/xLytKjP8TspjTd9px7JnInVI1aIgUVlPq
	 U4+dW+xWLzI442+HOug3/PKwvJ3Q/7MgaV15udoT5uBQ3v9RuX5p/idiQ94KAvGt9C
	 ClH/Dj6yDKOJMAXAbMC60+dTQkCOiC2bwAKAI3x7lt5F0oZBrS4sJxmgK/cHSnR2i9
	 gl+KOcvf/Kmxw==
Date: Wed, 23 Jul 2025 08:57:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: victor.liu@nxp.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, biju.das.jz@bp.renesas.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: Add null pointer check for ITE IT6263
Message-ID: <20250723-gigantic-wrasse-of-warranty-dc70d7@houat>
References: <20250722204114.3340516-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="v64vw7w5u4nnxhww"
Content-Disposition: inline
In-Reply-To: <20250722204114.3340516-1-chenyuan0y@gmail.com>


--v64vw7w5u4nnxhww
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: Add null pointer check for ITE IT6263
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 03:41:14PM -0500, Chenyuan Yang wrote:
> drm_atomic_get_new_connector_for_encoder and
> drm_atomic_get_new_connector_state could return Null.

They can, but not in that scenario. atomic_enable will never be called
if either would return NULL.

In which situation did you trigger this bug?

> Thus, add the null pointer check for them with a similar format with
> it6505_bridge_atomic_enable in ITE IT6505.
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 049723628716 ("drm/bridge: Add ITE IT6263 LVDS to HDMI converter")
> ---
>  drivers/gpu/drm/bridge/ite-it6263.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge=
/ite-it6263.c
> index a3a63a977b0a..3a20b2088bf9 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> @@ -590,15 +590,28 @@ static void it6263_bridge_atomic_enable(struct drm_=
bridge *bridge,
>  	struct drm_connector *connector;
>  	bool is_stable =3D false;
>  	struct drm_crtc *crtc;
> +	struct drm_connector_state *conn_state;
>  	unsigned int val;
>  	bool pclk_high;
>  	int i, ret;
> =20
>  	connector =3D drm_atomic_get_new_connector_for_encoder(state,
>  							     bridge->encoder);
> -	crtc =3D drm_atomic_get_new_connector_state(state, connector)->crtc;
> +	if (WARN_ON(!connector))
> +		return;
> +
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	if (WARN_ON(!conn_state))
> +		return;
> +
> +	crtc =3D conn_state->crtc;
>  	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> +	if (WARN_ON(!crtc_state))
> +		return;
> +
>  	mode =3D &crtc_state->adjusted_mode;
> +	if (WARN_ON(!mode))
> +		return;

And that condition can never be true.

Maxime

--v64vw7w5u4nnxhww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaICHvgAKCRAnX84Zoj2+
dswIAYCeMGJa7sCOX8bvJRHr3W2xrdlJl81rl4rZOgrggToExAt6Y5mIXlMzNLM/
zGTl6qIBgNrjx+dqnhqGxGwmdIKU/Nd0ludwq2bakr3C+JWeHRCfcQk+hLK7ns/c
KXvBJLcxSA==
=sF80
-----END PGP SIGNATURE-----

--v64vw7w5u4nnxhww--

