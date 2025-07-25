Return-Path: <linux-kernel+bounces-745874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6DB11FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0FA7BB7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32501E8337;
	Fri, 25 Jul 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmtd1oVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042381C5D59;
	Fri, 25 Jul 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452927; cv=none; b=aEc4qzwTuMUjqX+Gq+hjW2dnCX4oKcdswh8Do11vPug5CvyGphf7sQgA/lrNHRuRBGxNyQtwL8T+1pieiJBdnHZHwcewEQeAxv13qnOIYDCsMFbyuf4ze+lykguLB8Dv4QW6jwsBuzAFTuqHdwKbzrshQcDY5b31bfX9DMst/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452927; c=relaxed/simple;
	bh=klj31ndNyAWRbK84pKxL4JoG8gx4CjB4V3j2sfODoUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUpXGeebA7PpuMKF6Q+ODQUOmL3KhBd91m4kHUoOpPUV/Rd+jWPebDPi0w5NDG3VwzcSTPF/5VdorFK/OfayLgaZl7sIcFuMF/7SHldQDkWeFsTPZ2vAeUV75Icdv2HSFDR2NXF66lSJH2vt47U0cVmgXMQ6ymvPzJFuy7vacoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmtd1oVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086CEC4CEE7;
	Fri, 25 Jul 2025 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753452926;
	bh=klj31ndNyAWRbK84pKxL4JoG8gx4CjB4V3j2sfODoUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmtd1oVzWi1NM63TDozl7apju5daWm6U3OWjyBWY29WQR6kAljjan0nSZI+9J3mIh
	 XekGDZvq8Rl3GzVNxEseDghIuBpxtvatGakpY0BIThktlCaQZx8l1CUBYttjp/YRUr
	 0DPuB3mfNOJ504RorGftZcbTTiT/nifETC+S/G1BUwZhzUQ/85Rw6KIqYx43X/5Q+K
	 BaoelOTWIX/M4gZQJJtF8OuSDsLtdTxugSCyEbV6IXkmVaG5AfH2b9SG0iI6CWsO4v
	 gDBG/ZaqBK7mxij7XPn1LTzEPd1HjM0fhWHuTnVhXZ/GvCclzVDa4/NQS01oxbpFEV
	 5J+CNfLss2LVg==
Date: Fri, 25 Jul 2025 16:15:23 +0200
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
Message-ID: <20250725-holistic-ambrosial-jellyfish-f41f6b@houat>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
 <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-4-48920b9cf369@bootlin.com>
 <20250710-daffy-mini-booby-574fca@houat>
 <20250714123240.16d8dcb1@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ujxl4547qfzdg32k"
Content-Disposition: inline
In-Reply-To: <20250714123240.16d8dcb1@booty>


--ujxl4547qfzdg32k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/9] drm/omapdrm: use drm_bridge_chain_get_last_bridge()
MIME-Version: 1.0

On Mon, Jul 14, 2025 at 12:32:40PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Thu, 10 Jul 2025 09:13:46 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Wed, Jul 09, 2025 at 06:48:03PM +0200, Luca Ceresoli wrote:
> > > Use drm_bridge_chain_get_last_bridge() instead of open coding a loop =
with
> > > two invocations of drm_bridge_get_next_bridge() per iteration.
> > >=20
> > > Besides being cleaner and more efficient, this change is necessary in
> > > preparation for drm_bridge_get_next_bridge() to get a reference to the
> > > returned bridge.
> > >=20
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/omapdrm/omap_drv.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/oma=
pdrm/omap_drv.c
> > > index 054b71dba6a75b8c42198c4b102a093f43a675a2..3bbcec01428a6f290afdf=
a40ef6f79629539a584 100644
> > > --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> > > +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> > > @@ -378,12 +378,12 @@ static int omap_display_id(struct omap_dss_devi=
ce *output)
> > >  	struct device_node *node =3D NULL;
> > > =20
> > >  	if (output->bridge) {
> > > -		struct drm_bridge *bridge =3D output->bridge;
> > > -
> > > -		while (drm_bridge_get_next_bridge(bridge))
> > > -			bridge =3D drm_bridge_get_next_bridge(bridge);
> > > +		struct drm_bridge *bridge =3D
> > > +			drm_bridge_chain_get_last_bridge(output->bridge->encoder);
> > > =20
> > >  		node =3D bridge->of_node;
> > > +
> > > +		drm_bridge_put(bridge); =20
> >=20
> > Any reason you're not using __free(drm_bridge_put) here?
>=20
> Just because the code is simple enough that an explicit
> drm_bridge_put() is clearly sufficient.
>=20
> Do you think __free() should be used even in such trivial cases?

It's a matter of opinion at this point :)

It' makes it a bit easier and consistent so that's why I raised it, but
if you feel like it's too much, that's fine by me as well.

Maxime

--ujxl4547qfzdg32k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaIORdwAKCRAnX84Zoj2+
dkjMAX9SOg3FKwN1N8vMVORyYMoULmzu5wxDDXKKuSFHlgdamHXhi0r6BnbBR3mn
Sr9UCrgBgJp8VMm91YNpmrlTp7YUpyrHZ7jGDOzb9ZihsYt9H+HB4JkLsHM6RPAL
oj/UGiAoCw==
=jgOt
-----END PGP SIGNATURE-----

--ujxl4547qfzdg32k--

