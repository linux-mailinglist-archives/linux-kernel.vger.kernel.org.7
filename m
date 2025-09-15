Return-Path: <linux-kernel+bounces-816339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06939B5729B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3C917841A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C82EAB70;
	Mon, 15 Sep 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUMHKQbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068742D1F64
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923962; cv=none; b=Y6HUswiob/30EP6+wZbHtZKPk69Sigy36afH7+vUpn6afrr+R9qeycp7oC3foiy6bK0w7DDIm6/ybuR91X6T0l7CamLK105GB/AwSlQehAULcmhVVY1YscanOTa+gNeG/NdUmuxoyDk07lZnoBX11kZpJccynuvTlUMmitoEMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923962; c=relaxed/simple;
	bh=/4t6fTEmgCtsxXWdHX8SLp+/K26imMxcD2QP8Rrpas4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoFBS70SpiKFCLBfZFvafS3EHjE+uePHt4OmEXhlq555aMjrYvLUQHUkuQAeWkh0cMOSdgfEptzIGauhZMGernkITMlhfOhFtNv4j8kLZmnUXZ+h1/GVvmXlJiU7GJWybwcr28ofEmCBIiCPnh/PkdIQ+v0Y1KpL3CQDaOzyvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUMHKQbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1C6C4CEF1;
	Mon, 15 Sep 2025 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923961;
	bh=/4t6fTEmgCtsxXWdHX8SLp+/K26imMxcD2QP8Rrpas4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUMHKQbp5umS/OO5KvDllD0mhbzCtK71FoLECRiJE4U0wXEomZNMWvQGVkmjAgt7o
	 jHE3ssHi+Fh+YxBNhfl1dHNO4Sys5n9SMBtDz1amHpMNK7D8kW1AFpcqxk/HbRaLBA
	 2SCRrZ0H28gy6esFOvq1MCIObqpSUjPYrvhVPKautZ27tbFF+ivhpG22HTf4jP63fy
	 d8JiUKe4k2zCKrLudR0UQEdZcEyZ8wfl9wIBKdgN2ia2jIU/oz6aiCEsRPDCKYj9N8
	 XyZHK0xAm1yXDmP4ON70ElgkXfDeocnHWocSzJrIjtRZOdUMgF2GNmTgwFzm4z1OwB
	 gYcMyKGwwMkzQ==
Date: Mon, 15 Sep 2025 10:12:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v8 2/3] drm/debugfs: show removed bridges
Message-ID: <20250915-whimsical-kickass-snake-ebb4dd@penduick>
References: <20250912-drm-bridge-debugfs-removed-v8-0-5c33d87ccb55@bootlin.com>
 <20250912-drm-bridge-debugfs-removed-v8-2-5c33d87ccb55@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vo2dcwrkr42b6wcz"
Content-Disposition: inline
In-Reply-To: <20250912-drm-bridge-debugfs-removed-v8-2-5c33d87ccb55@bootlin.com>


--vo2dcwrkr42b6wcz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/3] drm/debugfs: show removed bridges
MIME-Version: 1.0

On Fri, Sep 12, 2025 at 07:03:42PM +0200, Luca Ceresoli wrote:
> The usefulness of /sys/kernel/debug/dri/bridges is limited as it only sho=
ws
> bridges between drm_bridge_add() and drm_bridge_remove(). However
> refcounted bridges can stay allocated for a long time after
> drm_bridge_remove(), and a memory leak due to a missing drm_bridge_put()
> would not be visible in this debugfs file.
>=20
> Add removed bridges to the /sys/kernel/debug/dri/bridges output.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>=20
> ---
>=20
> Changes in v8:
> - updated to rename bridge_removed_list -> bridge_lingering_list
>=20
> Changes in v7:
> - rebased on current code which is in drm_bridge.c now
> - removed if (drm_bridge_is_refcounted(bridge)), refcounting is not
>   optional
> - don't show bridge address
> - improve commit message
>=20
> This patch was added in v6.
> ---
>  drivers/gpu/drm/drm_bridge.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 9491ae7c884d355be4a82fb02a43a42d17fa8e0c..fccc42017fd4df6ecfb596325=
df2dc4d17566f39 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1491,17 +1491,20 @@ EXPORT_SYMBOL(devm_drm_put_bridge);
> =20
>  static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
>  					   struct drm_bridge *bridge,
> -					   unsigned int idx)
> +					   unsigned int idx,
> +					   bool removed)
>  {
>  	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
> =20
> -	drm_printf(p, "\trefcount: %u\n", kref_read(&bridge->refcount));
> +	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
> +		   removed ? " [removed]" : "");

I would use lingering here too, and your commit logs haven't been
updated either.

Maxime

--vo2dcwrkr42b6wcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMfKdQAKCRAnX84Zoj2+
do9DAYDteYvIWCYPLySGJQruS1YCaGAxQ2F7TafW4OXMiCb3CG2tYRWisadWJgAV
mEsHYskBgL5tJgMWTqIxYJsG0nfjKy/66BmYLhsi5EGTEbeaZKx/CQMo/jtd6ixe
hncfQHsIWg==
=FajZ
-----END PGP SIGNATURE-----

--vo2dcwrkr42b6wcz--

