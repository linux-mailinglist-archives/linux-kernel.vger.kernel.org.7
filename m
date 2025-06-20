Return-Path: <linux-kernel+bounces-695475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B867AE1A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 13:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E0189CD62
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A028A3F3;
	Fri, 20 Jun 2025 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLEauDJR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949C289E05
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419711; cv=none; b=TOaZ0IoEv4raniFxMjXUdZWV+CDWIXvl2n/yF3bv5ML4F6JI4xPoJsOfWWTZR/MDO64iKxQgeuL4OiKuXDoREwz468J+5kp6dhTL9hfEuCQFC4MM2VIjLbS5sNUNKAQeq54gIzFPEryUyVm6SdmANLCcDoWtHdkeUDsRZSKUfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419711; c=relaxed/simple;
	bh=NJeI8YppKOxLx0T0KsWLoadLL/ubvvWy8yozXSRreC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhvqHVC/PKo2CDgxGCgZf+gS2liW1ujEJN84pfpwgVMdOPTIRxdmJn8zwq+X32TKhsj3w/Q+Yx9BF6Q0z4G1wu/4KtBaQETeBVqOHR5VKnOd31QbKvHPLcPQWUwBFLCvPfbYz3QZoYBHVm5pu8iu8K7Oj3DTwOxJAVqO4ne/TGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLEauDJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0233EC4CEE3;
	Fri, 20 Jun 2025 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419711;
	bh=NJeI8YppKOxLx0T0KsWLoadLL/ubvvWy8yozXSRreC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLEauDJR6/Gfwu+2GELnsQ59RddEchkKxm1P0c2X+quuWtrfShq4LkfIuAvC+wbvb
	 i/nm1eaRttO/55Bly+rtsywkqF7DLy0RflVAcgR+CuDiscv5Af3pE+9Bwmk2X+8GDf
	 y3uZvjwdjg3EkQxREQ9i42N2e98WWKTbx1A0cgxqBGSkjyiSNnmdhuXgh4NLhVvd3c
	 VBoUHOpzBTN086z1NDz6grEqzcQUesleYAmCPfyxV0odsx9vDtDtyA6A7u6SBHUVy0
	 2hz7d4YqtJ4QENnF1Xk9Z9VTA050zo4KtOCTDW9RaIxoSkjJzHOJRyVn2onTgfmA6s
	 knIrvzY0/yAbw==
Date: Fri, 20 Jun 2025 13:41:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Anusha Srivatsa <asrivats@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/bridge: add warning for bridges not using
 devm_drm_bridge_alloc()
Message-ID: <20250620-adaptable-loutish-oryx-fee75c@houat>
References: <20250620-drm-bridge-alloc-getput-drm-bridge-c-v1-0-bad7eba5d117@bootlin.com>
 <20250620-drm-bridge-alloc-getput-drm-bridge-c-v1-3-bad7eba5d117@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="biluwndv5kawvnzs"
Content-Disposition: inline
In-Reply-To: <20250620-drm-bridge-alloc-getput-drm-bridge-c-v1-3-bad7eba5d117@bootlin.com>


--biluwndv5kawvnzs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/bridge: add warning for bridges not using
 devm_drm_bridge_alloc()
MIME-Version: 1.0

Hi Luca,

On Fri, Jun 20, 2025 at 11:32:08AM +0200, Luca Ceresoli wrote:
> To the best of my knowledge, all drivers in the mainline kernel adding a
> DRM bridge are now converted to using devm_drm_bridge_alloc() for
> allocation and initialization. Among others this ensures initialization of
> the bridge refcount, allowing dynamic allocation lifetime.
>=20
> devm_drm_bridge_alloc() is now mandatory for all new bridges. Code using
> the old pattern ([devm_]kzalloc + filling the struct fields +
> drm_bridge_add) is not allowed anymore.
>=20
> Any drivers that might have been missed during the conversion, patches in
> flight towards mainline and out-of-tre drivers still using the old pattern
> will already be caught by a warning looking like:
>=20
>   ------------[ cut here ]------------
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 2 PID: 83 at lib/refcount.c:25 refcount_warn_saturate+0x1=
20/0x148
>   [...]
>   Call trace:
>    refcount_warn_saturate+0x120/0x148 (P)
>    drm_bridge_get.part.0+0x70/0x98 [drm]
>    drm_bridge_add+0x34/0x108 [drm]
>    sn65dsi83_probe+0x200/0x480 [ti_sn65dsi83]
>    [...]
>=20
> This warning comes from the refcount code and happens because
> drm_bridge_add() is increasing the refcount, which is uninitialized and
> thus initially zero.
>=20
> Having a warning and the corresponding stack trace is surely useful, but
> the warning text does not clarify the root problem nor how to fix it.
>=20
> Add a DRM_WARN() just before increasing the refcount, so the log will be
> much more readable:
>=20
>   [drm] DRM bridge corrupted or not allocated by devm_drm_bridge_alloc()
>   ------------[ cut here ]------------
>   refcount_t: addition on 0; use-after-free.
>   [...etc...]
>=20
> A DRM_WARN is used because drm_warn and drm_WARN require a struct
> drm_device pointer which is not yet available when adding a bridge.
>=20
> Do not print the dev_name() in the warning because struct drm_bridge has =
no
> pointer to the struct device. The affected driver should be easy to catch
> based on the following stack trace however.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> This patch was added in v8
> ---
>  drivers/gpu/drm/drm_bridge.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index f001bbe95559aabf0aac9f25f89250ad4e1ad9c8..7d511c28608f1d8ea8fbb81d0=
0efa9e227b02a13 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -295,6 +295,9 @@ EXPORT_SYMBOL(__devm_drm_bridge_alloc);
>   */
>  void drm_bridge_add(struct drm_bridge *bridge)
>  {
> +	if (kref_read(&bridge->refcount) =3D=3D 0)
> +		DRM_WARN("DRM bridge corrupted or not allocated by devm_drm_bridge_all=
oc()\n");
> +

I'm fine with it on principle, but I wonder if using bridge->container
is set wouldn't be a more obvious way to check it?

Maxime

--biluwndv5kawvnzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaFVI9wAKCRAnX84Zoj2+
dru/AYDf1o82ABSqpVDUzoRUAi2lnvEW2Ru8cHWndoy8kfCGn3V0PIo/dHgnQGzG
Km9lf6gBfiMcTbF2bR6qv6gaCVUy87maQ0869Q1HyfDa31GCT7YV4OaKHt6Ztel1
NSnRrqzLJw==
=gzYf
-----END PGP SIGNATURE-----

--biluwndv5kawvnzs--

