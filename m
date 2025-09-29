Return-Path: <linux-kernel+bounces-836296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6A4BA93B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90EF7A957C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21426F28B;
	Mon, 29 Sep 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ0nlt/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC33D8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149982; cv=none; b=RkKygxeANnLhUf7LDRhbzLuG0qk/pxdjuCfgSb1lp9djoEur7+1ZEU0c8PnKi/9Q8ZGOLqlnJjxZ5aDjQWyAVjWV4VD5PcuTvkVQUbtF54Q4LPdvF1f/33eAG+retrb6tEMxmuHxF2eNytV0pV2e5YDqjS6Wnz38IT/oNBAUNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149982; c=relaxed/simple;
	bh=F26gpiEeM1z6DaTvZ8H/lzXDYiyq+ETRgVcGNonv7wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDJYJGLI8HpQlK9Ba+Z7s8yUYhtMsu7HxcAEpviGKsKmT5ROawha2yPf2La4e5C1gucG0ddPj8/t2UZWz35XhBORmZ5QkjtcPyOZ/HfiqBTCcHTe94OH4nQQQBNErOnt56/IAACv8f+S+LJIY8gPw/jARe8tuEYAO/owwwc5JTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ0nlt/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2019C4CEF4;
	Mon, 29 Sep 2025 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759149981;
	bh=F26gpiEeM1z6DaTvZ8H/lzXDYiyq+ETRgVcGNonv7wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZ0nlt/WC1EGQ50HOXSSk0k+yQq+3R2ZKCwKVB9jlxy1vJ+0HUhA31V5kKZyPlBCz
	 im6DqdgfegkQ442gW5ZFu9EipPSbnCgpCxLVMFt4LpkhfJxJHyi4RkT9oXg/8EvZVv
	 b0rP3IgZMafuBIPEPhcpq/Z+LZuspgVrVa1M11ZSCDyM2C6ZQD9Vshn4vqX1d6jDNc
	 NJ79/Jndqz+KfUNq1q0ue9fxfr6x8uY4lB2TylN1HrKSdT9lSf+9yTytMzk9N+4tFz
	 K13QD4FGspwrxMWu/aJm70q72WRRidnnB3dTrqm0hINHvExgD8KizoaJ2QE1B+LHjT
	 cSapvdo2GNRJQ==
Date: Mon, 29 Sep 2025 14:46:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] drm/bridge: lock the encoder bridge chain mutex
 during insertion
Message-ID: <20250929-enigmatic-delicate-mussel-f36b89@houat>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
 <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-3-23b62c47356a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ffnt4grig7iuxmc4"
Content-Disposition: inline
In-Reply-To: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-3-23b62c47356a@bootlin.com>


--ffnt4grig7iuxmc4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] drm/bridge: lock the encoder bridge chain mutex
 during insertion
MIME-Version: 1.0

On Fri, Sep 26, 2025 at 05:59:44PM +0200, Luca Ceresoli wrote:
> drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
> around such operations to allow users of the chain to protect themselves
> from chain modifications while iterating.
>=20
> This change does not apply to drm_bridge_detach() because:
>  * only the drm_encoder.c calls it, not bridge drivers (unlike
>    drm_bridge_attach())
>  * the only drm_bridge_detach() caller is drm_encoder_cleanup() which
>    already locks the mutex for the entire cleanup loop, thus additionally
>    locking it here would deadlock
>  * drm_bridge_detach() is recursively calling itself along the chain, so
>    care would be needed to avoid deadlocks
> Add a comment to clarify that is intended.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 630b5e6594e0affad9ba48791207c7b403da5db8..90e467cf91a134342c80d2f95=
8b928472aaf0d8b 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -453,10 +453,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, =
struct drm_bridge *bridge,
>  	bridge->dev =3D encoder->dev;
>  	bridge->encoder =3D encoder;
> =20
> +	drm_encoder_chain_lock(encoder);
>  	if (previous)
>  		list_add(&bridge->chain_node, &previous->chain_node);
>  	else
>  		list_add(&bridge->chain_node, &encoder->bridge_chain);
> +	drm_encoder_chain_unlock(encoder);
> =20
>  	if (bridge->funcs->attach) {
>  		ret =3D bridge->funcs->attach(bridge, encoder, flags);
> @@ -487,7 +489,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, st=
ruct drm_bridge *bridge,
>  err_reset_bridge:
>  	bridge->dev =3D NULL;
>  	bridge->encoder =3D NULL;
> +	drm_encoder_chain_lock(encoder);
>  	list_del(&bridge->chain_node);
> +	drm_encoder_chain_unlock(encoder);
> =20
>  	if (ret !=3D -EPROBE_DEFER)
>  		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> @@ -503,6 +507,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, s=
truct drm_bridge *bridge,
>  }
>  EXPORT_SYMBOL(drm_bridge_attach);
> =20
> +/*
> + * Invoked by the encoder during encoder cleanup in drm_encoder_cleanup(=
),
> + * so should generally *not* be called by driver code.

Why not? Also, it looks entirely unrelated to the rest of the patch.

> As opposed to + * drm_bridge_attach(), does not lock the encoder chain mu=
tex. + */ void
> drm_bridge_detach(struct drm_bridge *bridge) { if (WARN_ON(!bridge))

Maxime

--ffnt4grig7iuxmc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNp/mgAKCRAnX84Zoj2+
doqOAX9Zy9Z7IPOipQKQV+gyfRFRn2CCq2vxUWDhJrXcgCK+p9lqv4e3JH3EtJpa
sFfzlDkBfj6ugTuah9OIS670G0m39UoodcBG9xBmgKreXb4qiv4kjkcIvYx69tIj
EY2dXXxCug==
=SJVk
-----END PGP SIGNATURE-----

--ffnt4grig7iuxmc4--

