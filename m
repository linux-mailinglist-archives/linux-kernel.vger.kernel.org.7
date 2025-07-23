Return-Path: <linux-kernel+bounces-741949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC03B0EB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CD16A8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E3257444;
	Wed, 23 Jul 2025 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ismISZ82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3E254858
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253922; cv=none; b=mRQ5N/Kp8mL0SSBq1dUVxPvI+9VoOKT+LS2yMQT84+r1LfWeY7k3lMqOuIjhF2r9LsUyDGSXbePT41rvw/oi+sLnAfD2uTeFUzvTKKmHiKQMaPzePdWE/MXMs8R69FX09eKUNaHUUaAXdNEok5wNtgKs9I3DDpFml+7yQlvzWGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253922; c=relaxed/simple;
	bh=ALmyuQldkzfnV9oHG1vZOe85gHTTd3HmGHpBRwZpYbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4TB1L5XitynQPtyn6d0eudRsaVH9DZLEjYs44vCVACBlyHADkrp5wSgfTZqaAcBRrYNpwbY0BTDPx4xA52fniAC7Y5wvShioIweBBgej/7Bivefe8j1q9OgZ/xg9M0OPsypMc+CnDUVFOvpu3EINpiYO/PJ8Ic1iOafSxfakGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ismISZ82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3770DC4CEF4;
	Wed, 23 Jul 2025 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753253921;
	bh=ALmyuQldkzfnV9oHG1vZOe85gHTTd3HmGHpBRwZpYbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ismISZ82vb+lWhcAde9f6dXo7c/67oAsSzya3RxbNuc1FSyXH5XrQmEyEVxRCDveP
	 EvIF+6RS4sY4Tb6Xn7X5oONxh61RSnWxDTs7An0X3HcJjDZIj26g0BMKCcxDa1FgLr
	 BpbT0KYv342KqkXHMficCM8ezbHeeKhvhpC1WMMGemUooUxwRC6S7AdpSXmspXODyJ
	 NGPYFyQosEsjq7YcqTxn2ipHGvAmZG+YNvK60rKaCFPWJcvxyXUz3mO+9g72uv9HbH
	 6aa0FFjxQcdbZKXB1hJrPApj2r/HIfHOcTnCbv/TDEFV5D06GilZzAeVsx4/36Ysuf
	 ilaeOYlwYza6w==
Date: Wed, 23 Jul 2025 08:58:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lt9211: Add null pointer check for LT9211
Message-ID: <20250723-upbeat-seahorse-of-joy-eb8c9d@houat>
References: <20250722205712.3527922-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pgf5mtqljfyijhur"
Content-Disposition: inline
In-Reply-To: <20250722205712.3527922-1-chenyuan0y@gmail.com>


--pgf5mtqljfyijhur
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: lt9211: Add null pointer check for LT9211
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 03:57:12PM -0500, Chenyuan Yang wrote:
> drm_atomic_get_new_connector_for_encoder and
> drm_atomic_get_new_connector_state could return Null.
> Thus, add the null pointer check for them with a similar format with
> lt9611_bridge_atomic_enable in LT9611.
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9211.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> index 9b2dac9bd63c..6be30c8bdf15 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -463,6 +463,7 @@ static void lt9211_atomic_enable(struct drm_bridge *b=
ridge,
>  	const struct drm_crtc_state *crtc_state;
>  	const struct drm_display_mode *mode;
>  	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
>  	struct drm_crtc *crtc;
>  	bool lvds_format_24bpp;
>  	bool lvds_format_jeida;
> @@ -516,8 +517,18 @@ static void lt9211_atomic_enable(struct drm_bridge *=
bridge,
>  	 */
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

Ditto, that condition is never supposed to happen. How did you notice that =
bug?

Maxime

--pgf5mtqljfyijhur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaICIHgAKCRAnX84Zoj2+
dn9oAX9xq80lu2Z8s0PB3xZ+GKJaMhZmk+d9bN4x6Z+bgYOuZpKkCprfcrTd1Axo
UPWusvgBgNia0bPdQBt/a1r7dRYm194UeAYpWqgq9uSgi5o1KGB0ELYhdFbinFH+
tXwKKT7P0Q==
=n7z0
-----END PGP SIGNATURE-----

--pgf5mtqljfyijhur--

