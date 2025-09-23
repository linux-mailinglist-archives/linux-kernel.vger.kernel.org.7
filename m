Return-Path: <linux-kernel+bounces-828733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ECDB954E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1321D18896DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4B320CDD;
	Tue, 23 Sep 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7N6PqgJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384C320CB6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620752; cv=none; b=aHntu58v6+NFC+YX6vxlwYvql8MavyBbMI5ZKAiLwo/P3qC0gVV4UU4aEkyRj7HQkq8Z3XpDBAu/0+8dyzSbihmyAg/y3oBHqIrCdXoSYkDQHuAIDHJIz9Y7bUX7xufWaeANKicWDoq1wNfOmH9S44frgp6ksc0cxU2Zq79eFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620752; c=relaxed/simple;
	bh=F9M0nCaoB2hujHNonYH+GW8C0tt9Z9Zca54kRKpXrWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDR3ZBSv6kFqLjRWNYfaA85WTM17s/ZYAczEwm9+x0cD5S4zgeI5r5q8m+mb/F9pcz4XDxfC7sCnUww1UvXwAb5Y4z2NDO1xXyIvQjm1mX92kFVwJCO58ppabQoZOUOTbfGsL7c1P/GejuywjPfrV3wAMG5oubdzn28tqmYfmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7N6PqgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD32DC4CEF5;
	Tue, 23 Sep 2025 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620752;
	bh=F9M0nCaoB2hujHNonYH+GW8C0tt9Z9Zca54kRKpXrWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7N6PqgJ3KBALgJSFJS+mCAMfLaNchEROf9hbPnxw6FYIMLRrJgOOsdJ1EUL6Tsg7
	 eHQJ6iTT3SPl2qjfZgFIPwXhYUQo1/0hN+vtEmpEV55S66+srMm+/h5KrLg7hE3Qhv
	 jpHMV4M7ApZBLaxcRROkrJkycInr4RMAChbIp/Y6u0S+3gJDBx6vdsla3jevMeEeg0
	 OMgVfmOBjWXOMXUiTuI5CwLg5taRwPLoRwoSWB+u3adF0ZQHgsuTAbM4mVSEiwjiIO
	 EV9up7cem0OcEKpYPYw57Kcd1+KNme2Cy11WDjA7Vhxtw05WC520PXbUXlg4gHacK3
	 h10dlycTlVSmw==
Date: Tue, 23 Sep 2025 11:45:49 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar <devarsht@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <20250923-rigorous-tamarin-of-cookies-2f1a25@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <zvqtehg66dbrrdmik6ylo2kdk74umfzo5hbfkizwsb352nlyqv@jgouvmbfwa4x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pzzstkbdyxc2j6ic"
Content-Disposition: inline
In-Reply-To: <zvqtehg66dbrrdmik6ylo2kdk74umfzo5hbfkizwsb352nlyqv@jgouvmbfwa4x>


--pzzstkbdyxc2j6ic
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 09:40:57PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 10:32:38AM +0200, Maxime Ripard wrote:
> > In order to enable drivers to fill their initial state from the hardware
> > state, we need to provide an alternative atomic_reset helper.
> >=20
> > This helper relies on each state having its own atomic_state_readout()
> > hooks. Each component will thus be able to fill the initial state based
> > on what they can figure out from the hardware.
> >=20
> > It also allocates a dummy drm_atomic_state to glue the whole thing
> > together so atomic_state_readout implementations can still figure out
> > the state of other related entities.
> >=20
> > Link: https://lore.kernel.org/dri-devel/CAKMK7uHtqHy_oz4W7F+hmp9iqp7W5R=
a8CxPvJ=3D9BwmvfU-O0gg@mail.gmail.com/
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 382 ++++++++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/drm_mode_config.c   |   1 +
> >  include/drm/drm_atomic_helper.h     |   1 +
> >  include/drm/drm_bridge.h            |  21 ++
> >  include/drm/drm_connector.h         |  26 +++
> >  include/drm/drm_crtc.h              |  19 ++
> >  include/drm/drm_plane.h             |  27 +++
> >  7 files changed, 477 insertions(+)
> >=20
> > +	drm_for_each_encoder(encoder, dev) {
> > +		struct drm_connector_state *enc_conn_state;
> > +		struct drm_crtc_state *enc_crtc_state;
> > +		struct drm_bridge *bridge;
> > +
> > +		/*
> > +		 * It works a bit differently for bridges. Because they are
> > +		 * using a drm_private_state, and because
> > +		 * drm_atomic_private_obj_init() asks for its initial state when
> > +		 * initializing, instead of doing it later on through a reset
> > +		 * call like the other entities, we can't have reset xor
> > +		 * readout.
>=20
> Would it make sense to unify the way the bridges / priv_obj handle the
> state with the rest of the object types?

I would be all for it, but I think this is pretty much the same
conversation we had in my recent bridge improvement series. Aren't
bridges not assumed to have atomic support and thus we can't really do
something better here?

Or should we move all bridges to be atomic?

Maxime

--pzzstkbdyxc2j6ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJsTAAKCRAnX84Zoj2+
dpKWAYCEcJRa7+2tDeUz0y2h/VWhc6ILKt/pSvSoEUwyz3VdpHRGDOfCRVxIEUFE
EAEymiwBfR0dymG4bar7yy2532TPLF/3iQXZX5VD0gMrUGQ5CngXPYacZGW2NXHD
/NfI2CcdZw==
=5AuG
-----END PGP SIGNATURE-----

--pzzstkbdyxc2j6ic--

