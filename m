Return-Path: <linux-kernel+bounces-841368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CFBB71CF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8513B0C4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857561F8ACA;
	Fri,  3 Oct 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH4xTRGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D662B9B9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500293; cv=none; b=Gvu2irdeiVZl1uQ8K0yfltRt/U0Nng+K9L+XFses/BmiKBP6yv9uJnAcX36GeRe+mTW5OSCR328VFKAEtnwyhXZ12grAcL9Z/q258J1zPUMQcqnAKSx/55Tedoey+NNVOujG7kCbuzew0J6Hljc/7i3xDfVy91LyppTI1WuMrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500293; c=relaxed/simple;
	bh=kyzVK8/+AQWL2YDAf2Uh/No9phkR9UlQlj4bn/NRLos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmnJoZJ+j4bOTWrTNM/8etAqrH51ki/JTdnMnkGyogKVGx8K4UIIk9VKBMCiPFaj/PB13qf5HeBrGCC9hyGSAR8BkD2cUgqflUOGM87m0tcQjyv4+fzzHhDcY1oHhxLi1EaUFn2s8dw+M9Vl+OhwWsGbjciYCzvlLmJpP+YoO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH4xTRGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1637EC4CEF5;
	Fri,  3 Oct 2025 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759500293;
	bh=kyzVK8/+AQWL2YDAf2Uh/No9phkR9UlQlj4bn/NRLos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH4xTRGNT9XbL7k7G2f9lqUohgmPxEIKr1EvuAkY8/L5AWFJKCrlB+0DWzLaGLzKz
	 wgK2JnK8omSNMSEJ55MYpa8GNjxP/5ZFUhrAJuAzXme4sNpCPsqnubr7Q7AhUqp+xN
	 adIBB31GOpanYT0/Xnaxn2a07A48V7QDBfGYm6b2yY06QKK4rxr/d1mkCEgqZ31Js8
	 SGKgbzqQnW4yssefJN+/Crmb1UPl+J92S8m8nDljV1XhRU1sLEaf5+szwP/hfeopo5
	 4NNO5/MG89Gfhsh2snKfSzj7PsIKL+hDreT+ZXuorK6+x6NrPlCefPfxr8pPEmlpIX
	 65OG3y5m+8hDg==
Date: Fri, 3 Oct 2025 16:04:50 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/bridge: lock the encoder chain in scoped
 for_each loops
Message-ID: <20251003-dexterous-loose-guppy-45e1b3@houat>
References: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com>
 <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-4-78bf61580a06@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="j5nphwk6lufmqwdg"
Content-Disposition: inline
In-Reply-To: <20251003-drm-bridge-alloc-encoder-chain-mutex-v2-4-78bf61580a06@bootlin.com>


--j5nphwk6lufmqwdg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] drm/bridge: lock the encoder chain in scoped
 for_each loops
MIME-Version: 1.0

On Fri, Oct 03, 2025 at 12:39:26PM +0200, Luca Ceresoli wrote:
> drm_for_each_bridge_in_chain_scoped() and
> drm_for_each_bridge_in_chain_from() currently get/put the bridge at each
> iteration. But they don't protect the encoder chain, so it could change
> (bridges added/removed) while some code is iterating over the list
> itself. To make iterations safe, change the logic of these for_each macros
> to lock the encoder chain mutex at the beginning and unlock it at the end
> of the loop (be it at the end of the list, or earlier due to a 'break' or
> 'return' statement).
>=20
> Also remove the get/put on the current bridge because it is not needed
> anymore. In fact all bridges in the encoder chain are refcounted already
> thanks to the drm_bridge_get() in drm_bridge_attach() and the
> drm_bridge_put() in drm_bridge_detach(). So while iterating with the mutex
> held the list cannot change _and_ the refcount of all bridges in the list
> cannot drop to zero.

This second paragraph *really* needs to be its own patch. And I'm not
really sure playing games when it comes to refcounting is a good idea.

A strict, simple, rule is way easier to follow than trying to figure out
two years from now why this loop skips the refcounting.

Unless you have a performance issue that is, in which case you should
add a comment (and we will need a meaningful benchmark to back that
claim).

> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> Changed in v2:
> - Fixed infinite loop in drm_for_each_bridge_in_chain_scoped() when
>   encoder->bridge_chain is empty, reported here:
>   https://lore.kernel.org/lkml/202509301358.38036b85-lkp@intel.com/
> - Slightly improved commit message
> ---
>  include/drm/drm_bridge.h | 62 ++++++++++++++++++++++++++----------------=
------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>=20
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 0ff7ab4aa8689a022458f935a7ffb23a2b715802..5a72817f04a78f5379f69e72f=
e519c5eb3ea043e 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1440,26 +1440,29 @@ drm_bridge_chain_get_last_bridge(struct drm_encod=
er *encoder)
>  						      struct drm_bridge, chain_node));
>  }
> =20
> -/**
> - * drm_bridge_get_next_bridge_and_put - Get the next bridge in the chain
> - *                                      and put the previous
> - * @bridge: bridge object
> - *
> - * Same as drm_bridge_get_next_bridge() but additionally puts the @bridg=
e.
> - *
> - * RETURNS:
> - * the next bridge in the chain after @bridge, or NULL if @bridge is the=
 last.
> - */
> -static inline struct drm_bridge *
> -drm_bridge_get_next_bridge_and_put(struct drm_bridge *bridge)
> +static inline struct drm_bridge *drm_bridge_encoder_chain_lock(struct dr=
m_bridge *bridge)
>  {
> -	struct drm_bridge *next =3D drm_bridge_get_next_bridge(bridge);
> +	drm_encoder_chain_lock(bridge->encoder);
> +
> +	return bridge;
> +}

You create a public function, this needs to be documented.

Maxime

--j5nphwk6lufmqwdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN/X/gAKCRAnX84Zoj2+
dluHAX9+iHftEivzE2LJNwNJGCZWyWzaBcxApHUfzojgzDbZ7fz/tTxjzUYNdnD+
/q+zHzQBf3ZeePphxx67zFkY/rK7Qr9r4UBlztteTw/EeFfxvGyyd60wO+X6u2YA
CfFD2gIoaQ==
=Ixen
-----END PGP SIGNATURE-----

--j5nphwk6lufmqwdg--

