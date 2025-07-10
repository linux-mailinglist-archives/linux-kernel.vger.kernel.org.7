Return-Path: <linux-kernel+bounces-725075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9E3AFFA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6653A1C475BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F22882B9;
	Thu, 10 Jul 2025 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7liWRLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5E2877FB;
	Thu, 10 Jul 2025 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131630; cv=none; b=bacArZdS+2uR2ATtdROWTOV+Gc7YD+j0Xbktt+bykTY+hC9oy7XTO8NJvhxm8KpcNKEHIgwn9mMSkbLIPWZUbWam14mWMllTC4Eiz6LSisl8vpPK0WUtvOW0IqFGNca8GYQKHKGLoX92SeAQECwj6h6K0ogLXlp4hNbeUiNy64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131630; c=relaxed/simple;
	bh=1PZ5SYT8dRkcymT3/gj366sIXjNSe/oKNBKj+FH3zao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWyi41tkjdPIHHDrOELfvF0rp4Dr8e6wfp4ZdrDdoRhfRAGzlsh4bAgwSoQvo482quCYRppqmZIbyhsamk5oEyRDHzk4JmlBInZ3jQ6Hb5nGzLvTttLUowdhZMe3kcILGeNelDhd/EEMx2lwmvERn3Xm04uGBrKJVK7/Ip3okcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7liWRLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D023C4CEE3;
	Thu, 10 Jul 2025 07:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131629;
	bh=1PZ5SYT8dRkcymT3/gj366sIXjNSe/oKNBKj+FH3zao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7liWRLKF+YRv9KHpnqXc8KJJfHiKxyOMTbrf4C4eZLOzV18t8Z8ofdOCIkIpSfjd
	 QjwwFAS/CPeAASRC1DoCC2k8C9ZEtSRB60GCwhZk9OQJFhR8W3CglMyxGmmESsoRIL
	 UzSxbYpbOICcCujzD1mfSJKvQ++TcK5Ena+0BrPt/h/6JOuLAhzGIDeL+vjhYOWgXI
	 2xjCaIuea75KvEb/UOKsQrKc3AA4OlEehzaF5nmVyEB6hX7XZGil98DEUJPffpX4Rb
	 D32VrK3JfP3LBa27Efxq5OpODdxs0hx27s31b6i7QJcLxVSy5yXr2KZHuc/5iZlIZi
	 yJAKt7lEuWJVA==
Date: Thu, 10 Jul 2025 09:13:46 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] drm/omapdrm: use drm_bridge_chain_get_last_bridge()
Message-ID: <20250710-daffy-mini-booby-574fca@houat>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
 <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-4-48920b9cf369@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ksuiit4bl62avew6"
Content-Disposition: inline
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-4-48920b9cf369@bootlin.com>


--ksuiit4bl62avew6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/9] drm/omapdrm: use drm_bridge_chain_get_last_bridge()
MIME-Version: 1.0

On Wed, Jul 09, 2025 at 06:48:03PM +0200, Luca Ceresoli wrote:
> Use drm_bridge_chain_get_last_bridge() instead of open coding a loop with
> two invocations of drm_bridge_get_next_bridge() per iteration.
>=20
> Besides being cleaner and more efficient, this change is necessary in
> preparation for drm_bridge_get_next_bridge() to get a reference to the
> returned bridge.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm=
/omap_drv.c
> index 054b71dba6a75b8c42198c4b102a093f43a675a2..3bbcec01428a6f290afdfa40e=
f6f79629539a584 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -378,12 +378,12 @@ static int omap_display_id(struct omap_dss_device *=
output)
>  	struct device_node *node =3D NULL;
> =20
>  	if (output->bridge) {
> -		struct drm_bridge *bridge =3D output->bridge;
> -
> -		while (drm_bridge_get_next_bridge(bridge))
> -			bridge =3D drm_bridge_get_next_bridge(bridge);
> +		struct drm_bridge *bridge =3D
> +			drm_bridge_chain_get_last_bridge(output->bridge->encoder);
> =20
>  		node =3D bridge->of_node;
> +
> +		drm_bridge_put(bridge);

Any reason you're not using __free(drm_bridge_put) here?

Maxime

--ksuiit4bl62avew6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaG9oKgAKCRAnX84Zoj2+
dv+SAYD8WXoxdQImd1WsoY8Qa7eR03ok/mPvEvPAbyHoymKSL55M0Dxyg3aTw6DJ
SBzQpokBgJjlL8l44Tp0J8chUUsawNg8WYvr0GQO++AMrH0GWH7vZttF78pb1xGe
YlVI2cDkew==
=+6FN
-----END PGP SIGNATURE-----

--ksuiit4bl62avew6--

