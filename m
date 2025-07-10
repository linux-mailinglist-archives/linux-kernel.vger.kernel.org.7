Return-Path: <linux-kernel+bounces-725102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD7AFFAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25455A291B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D328983F;
	Thu, 10 Jul 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYCfigXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F318F5E;
	Thu, 10 Jul 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132432; cv=none; b=mrTod6CFMsGnyuL1eCo/B1fR0jAB2jOkrimXK5x/jtPJiuRpmKaSHJF/DUDtJN4v8MrrRiMpATaQOhYEJIrU/yIsiTxdL6ouN5QwwBQn4dcoHF7FoIghE+2ZS4v/iO+V39ZftSjjglIl1i0SLFqyKgtQH+9jSBmnXyMpQPxdrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132432; c=relaxed/simple;
	bh=yR1yt72iESvtf706LR6VBiJOb+AEKItKxPYtLvUPyhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciVlXGtRAZsgKs5RzQCcOr+S1V7y2+Yy9FvNvlennueyXdE815SsZPl36wVJtJti4uQA9YKlVHPkyen2RT7SMRT5JJF6Pet2mxbw2ea74WpAAfgadF80nJ3lkRPflCuOJV2z7KCLg1iwv36NW5Q/HIHZuADm9t3jDcV3AAGcGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYCfigXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A971C4CEE3;
	Thu, 10 Jul 2025 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132431;
	bh=yR1yt72iESvtf706LR6VBiJOb+AEKItKxPYtLvUPyhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYCfigXhEmpMraXE+SzXg57pc60PfyVnaArkCqeGznlOXwQ/Y9NhpkO+Ca38NVEvl
	 iQGVB9QNpqZ7usSvT5+8Mni8RdimYhCSzk++msnaC58io7HbuMjZ5FRIgW80PKpBG1
	 ee8QPhmOLACZGKx3Q3u8NBqvRQIHHi6J/Hi75YTp/9ocEBaHACMI17Md1M7DIpIJGz
	 KRWDV+pjp1AG8XJrHBu9crlyo98Ay7Ksg0CcVwvb85nncbsYUzkN4vuUCMSiUSMMyZ
	 YXghCMXRjORlRJbbZzsYmX1XvdoP8gUON9ZxsBNxnTAiUFbKyPG4BaxF5oicIIRVZb
	 2Vvp3osNZJsNw==
Date: Thu, 10 Jul 2025 09:27:09 +0200
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
Subject: Re: [PATCH 8/9] drm/bridge: put the bridge returned by
 drm_bridge_get_next_bridge()
Message-ID: <20250710-classic-bouncy-caiman-8e2045@houat>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
 <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-8-48920b9cf369@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3v6clpzuhyggvmrg"
Content-Disposition: inline
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-8-48920b9cf369@bootlin.com>


--3v6clpzuhyggvmrg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 8/9] drm/bridge: put the bridge returned by
 drm_bridge_get_next_bridge()
MIME-Version: 1.0

Hi,

On Wed, Jul 09, 2025 at 06:48:07PM +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
> when done.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

You should really expand a bit more your commit logs, and provide the
context of why you think putting drm_bridge_put where you do is a good idea.

> ---
>  drivers/gpu/drm/drm_bridge.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 0b450b334afd82e0460f18fdd248f79d0a2b153d..05e85457099ab1e0a23ea7842=
c9654c9a6881dfb 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1147,6 +1147,8 @@ drm_atomic_bridge_propagate_bus_flags(struct drm_br=
idge *bridge,
>  	} else {
>  		next_bridge_state =3D drm_atomic_get_new_bridge_state(state,
>  								next_bridge);
> +		drm_bridge_put(next_bridge);
> +
>  		/*
>  		 * No bridge state attached to the next bridge, just leave the
>  		 * flags to 0.

In particular, I don't think it is here.

You still have a variable in scope after that branch that you would have
given up the reference for, which is pretty dangerous.

Also, the bridge state lifetime is shorter than the bridge lifetime
itself, so we probably want to have the drm_bridge_put after we're done
with next_bridge_state too.

Overall, I think using __free here is probably the most robust solution.

Maxime

--3v6clpzuhyggvmrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaG9rTAAKCRAnX84Zoj2+
dr15AYCUDUXM2027tbhyBFNnTMDtHivlc5bgpEwgheOP8GXxP7YFX/QLF0BkDV7V
DnRK0VQBfAsNfigLg8ct5uD7iCc3b1OYcgl8hgrtM7STVo7OZSQpRSJyWJv9Amo6
YYUahgkEQw==
=3R2K
-----END PGP SIGNATURE-----

--3v6clpzuhyggvmrg--

