Return-Path: <linux-kernel+bounces-816763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E4B5780A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C4D3A5E69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277302FC013;
	Mon, 15 Sep 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeOCvMMM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AD21FF48
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935623; cv=none; b=gOnIFn97/6jD63M9xbx3/PDliEWbv1pihLj0TeZo2sGGoroOM0+WxsRoFldS5Tc5kRwA1Rfx9nv3bJx5HKUGVdpA8PdKJXK7HW+ELVCqEjQeCmV8tZ+nyiZMgi3Z0vDdrW/f/6CkB4yEyPMEQhwI4lKJannvZcrsd//XBQcvEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935623; c=relaxed/simple;
	bh=DIj0yhp4gbJoo1YTXeu1yB+1QIwWPgPRInkx0vYUyyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMHry6Wrd31Lifkfz7APlrenxF3c3N7yaYN4fK4YiebxNBEIvBZptfGHdVCyNgjaI6sbnoGBrqkJB0nMw/PkaF/x3qNppl1bgtVu2Ee4k3EKBafsCHQEZUPZt6pZPcQVenagVAck8xbQuycF+jHfnHGxWYXIcriaDogEL02oOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeOCvMMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFFFC4CEF1;
	Mon, 15 Sep 2025 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757935623;
	bh=DIj0yhp4gbJoo1YTXeu1yB+1QIwWPgPRInkx0vYUyyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeOCvMMMkQhHjPXvwGUoryyTOpbtkPvxwxT77GsjhXYqetPrf00cwrMVvXriCBOh8
	 8d+OoGvGo0M7Is/d9p8Bk5Kd7Sw3xe5HWGjlUkHSdO4YW35eu7yHNl5x4ytlffeCaC
	 K/JCNwBYKz0ChCT+BGRDpTpOiFjogFqAc27snwRLoKBVz2cV/dw0patGE6AkM8SI31
	 4e5CCOWcCAHAFczwQREQ7Kc7vMmyw9dZA8KpGV5PrOz81ASXcbnS7Tx9PMH6BtSbuf
	 5CKe+sCIQyYjMDUSeB2x7SauH+6YYTPFygrjxCcf7M0T3qTNfTvl9Ghf/TcOaNPUDg
	 AVCL4xxJGg2HQ==
Date: Mon, 15 Sep 2025 13:27:00 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/29] drm/atomic_state_helper: Fix bridge state
 initialization
Message-ID: <20250915-heavenly-athletic-lionfish-aa7b8b@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-5-14ad5315da3f@kernel.org>
 <9f17dfd9-a4d4-41e9-b988-bd8ca858e5e7@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bjstnpmexvpjhaxq"
Content-Disposition: inline
In-Reply-To: <9f17dfd9-a4d4-41e9-b988-bd8ca858e5e7@suse.de>


--bjstnpmexvpjhaxq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/29] drm/atomic_state_helper: Fix bridge state
 initialization
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 03:18:17PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > Bridges implement their state using a drm_private_obj and an
> > hand-crafted reset implementation.
> >=20
> > Since drm_private_obj doesn't have a set of reset helper like the other
> > states, __drm_atomic_helper_bridge_reset() was initializing both the
> > drm_private_state and the drm_bridge_state structures.
> >=20
> > This initialization however was missing the drm_private_state.obj
> > pointer to the drm_private_obj the state was allocated for, creating a
> > NULL pointer dereference when trying to access it.
> >=20
> > Fixes: 751465913f04 ("drm/bridge: Add a drm_bridge_state object")
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index 7142e163e618ea0d7d9d828e1bd9ff2a6ec0dfeb..b962c342b16aabf4e3bea52=
a914e5deb1c2080ce 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -707,10 +707,17 @@ void drm_atomic_helper_connector_destroy_state(st=
ruct drm_connector *connector,
> >   	__drm_atomic_helper_connector_destroy_state(state);
> >   	kfree(state);
> >   }
> >   EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
> > +static void __drm_atomic_helper_private_obj_reset(struct drm_private_o=
bj *obj,
> > +						  struct drm_private_state *state)
> > +{
> > +	memset(state, 0, sizeof(*state));
>=20
> This argument is guaranteed to be zero'd, I think. No need for a memset.
>
> > +	state->obj =3D obj;
> > +}
> > +
> >   /**
> >    * __drm_atomic_helper_private_obj_duplicate_state - copy atomic priv=
ate state
> >    * @obj: CRTC object
> >    * @state: new private object state
> >    *
> > @@ -796,10 +803,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_st=
ate);
> >    */
> >   void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
> >   				      struct drm_bridge_state *state)
> >   {
> >   	memset(state, 0, sizeof(*state));
>=20
> Another unnecessary memset?

I guess the two can be seen as redundant, but I'd argue the one in
__drm_atomic_helper_private_obj_reset should still be there.

What guarantees that the pointer points to a zero'd structure?

Maxime

--bjstnpmexvpjhaxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMf3+wAKCRAnX84Zoj2+
duAMAX4xw8C8UQB2U4qimHV/KWPOBbMcqvFXGq8mi7KpjsX3KUN9niJbwsCskBxr
aHibY0ABgI4ij7jrHirhgw5fa46AFGuNxRM5p2jgxs7zz0MefovMEj8WCCgnYQo9
W6wsPy9zbQ==
=6S4m
-----END PGP SIGNATURE-----

--bjstnpmexvpjhaxq--

