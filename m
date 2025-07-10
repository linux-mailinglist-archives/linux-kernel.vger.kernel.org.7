Return-Path: <linux-kernel+bounces-725106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B55AFFADB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB0E1C828A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A0289340;
	Thu, 10 Jul 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeI8/VKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57573288C2F;
	Thu, 10 Jul 2025 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132500; cv=none; b=OEc8gINJ3JgWBmAnDcf5ZtWljVfSwyOfs/O9XJuCTdO0Pzw/CZCfYDzJJNXsSPPhkUoVGlHc5qgsk+PY3au0mbQG4Cp2PX/dn/NajzM06o68zKTCwoUpNLA+U55FZEh9zqtY98jJm6ev7G7islslIHeIwMFbIIBDDBfYAkuJ+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132500; c=relaxed/simple;
	bh=hdXjeCliRyJZCw75XF5LZkP9DunbKaTwr/NS/YNlOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEu+MecyFMtdJPSl6fvAvOkQ84E+LD9G+TpP8wBQ49ID/8jJuie0rGPc0A9KwbdsqHqN8DLStZ7huRhlrRWhGrQo0A6z5QDze28zad76hzaX4Cd5W+HtbVsS6Gr6b92Ek21fjluvbdMgDNBkPFWhGFaPfqmfVqZyR8k2p76LCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeI8/VKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76868C4CEE3;
	Thu, 10 Jul 2025 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132500;
	bh=hdXjeCliRyJZCw75XF5LZkP9DunbKaTwr/NS/YNlOm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeI8/VKQ537VmiYeHP0ZLXzBPqlrlyjylv5W7wUsHSWpYtHGVaIBqg6l6kKPGtv+l
	 WTGESYCudcBEy6Vj4g5+7Mj93flVBEhf2P9CVsPyB6X984Fotx5ddKzOzPe9STOA2y
	 sjbiQqPfX0xGiHit7XfBjif2Gplod4TliLjXUlzwqlhK4G9eQgERHD77DE2fQer7Rz
	 dXYaQtKpEV97iE+ZSNvTrgBwrE689dTDnV8tJb3L+ZpFt0a5Qiv1B95uoD9E6ydZX6
	 50IFww7wcn26Lpv6QZa2FBjdVNxhX4nrBOhE6guCoMQjop8A9ufVZgtOAY95+1IBIe
	 KxTwI2QQLSj6Q==
Date: Thu, 10 Jul 2025 09:28:17 +0200
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
Subject: Re: [PATCH 9/9] drm/imx: parallel-display: put the bridge returned
 by drm_bridge_get_next_bridge()
Message-ID: <20250710-dashing-origami-ara-ef9fc1@houat>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
 <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-9-48920b9cf369@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6tqwawwu3nnorjig"
Content-Disposition: inline
In-Reply-To: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-9-48920b9cf369@bootlin.com>


--6tqwawwu3nnorjig
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 9/9] drm/imx: parallel-display: put the bridge returned
 by drm_bridge_get_next_bridge()
MIME-Version: 1.0

On Wed, Jul 09, 2025 at 06:48:08PM +0200, Luca Ceresoli wrote:
> The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
> when done.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Same comments than on the previous patch here.

Maxime

--6tqwawwu3nnorjig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaG9rkAAKCRAnX84Zoj2+
dnTtAYDyf/Yxt9bmEdmMUGLXyfbD9i2hhDEJkGJ8L01jt7ghkn+L5uWiwnMPQKFR
XgUd/r8BgJt8+q4jJcV+k0qVy9a+O6Na5wzUPuLCVbN5rC+8KA4NNINmo7vDm9ob
Wf/nc0V2xw==
=dhT/
-----END PGP SIGNATURE-----

--6tqwawwu3nnorjig--

