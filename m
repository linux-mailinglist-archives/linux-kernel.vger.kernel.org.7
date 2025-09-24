Return-Path: <linux-kernel+bounces-830270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19821B99410
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BDE1B223C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287712D8DDF;
	Wed, 24 Sep 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5MFFI5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432C15624D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707626; cv=none; b=CHUeoL4I6DWxFx4y6oVsIJxcdBMSl7q2XauqKWzUjd6AIUl8U0vqwoS+ynRUeclpLSGBVCOeHQaQCCaDfo1D6YNLt2a4pgtFjKTkOD5haceDGjSUsKDFol3gRkT7hoDWH11VcF4O+UrmmIWbV2Pj1u6MFeGuKAOxspJOvXGCnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707626; c=relaxed/simple;
	bh=vun9Y0Nz3zxye3CfOiGBTgENE9yUPCfj3m+g0Vza6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljbGNdCkI7RwslHaxQzJo+vEXE5VVusCB0B/DvnLxDYVCRPw2puH0T0s4Cwo3uY5NRTxGcSvK/zL3pyYNTiyonwhYmsS/jcL/y6eCqkQSW1RAdTCmcjHwdhKT0ONaB5TedWpQthc02zzBMUotPwBj2/yRG4pQ3iErfpLuzfV4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5MFFI5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC70C113CF;
	Wed, 24 Sep 2025 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758707625;
	bh=vun9Y0Nz3zxye3CfOiGBTgENE9yUPCfj3m+g0Vza6vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5MFFI5R1VQh0f1spzsg4I7m+tQbj8VdfP9YB9VKdx64tNZONCGId6AKMFCmq9URi
	 o959r47IOxvnVbdOraqcMfk4ZkArE82/YXVYXi9Wgr6mTEQM5F8yeDe8G9OontsDmR
	 PptwL09Tf6jzQcvzHIMvOBfunGB+CZpkKICeRG8AJkZFNbT6fytHuu9g9A+MNyrAda
	 qg4N45HBqrGwVC2OzAhzTCfmZIO/Gv6NDYlzRuAMSLgqq40fMEqplYezj7XmHyNtbi
	 P1MJ/NWM4NeC2Z4Ngy+18NEx26oiTEPuGtD652hzWuUi5xSsHhMiw05l/FK03kaq9N
	 NG6tN7tdR1j8g==
Date: Wed, 24 Sep 2025 11:53:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Devarsh Thakkar <devarsht@ti.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <20250924-truthful-armored-jacamar-bb3efd@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
 <20250915-active-placid-bustard-6e1faa@penduick>
 <2ry3txigq3jyivtyz7i4c76g74vdgvlozsjkeswxalhu2vs5yx@jqswyjle632h>
 <20250923-debonair-earwig-of-abracadabra-940fa8@penduick>
 <osdt4teotc6qvja734dyo7be35nzy5lo4sw4dcniaqicqb3o5l@gabq5adeliha>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="mi2qfxtel4vcha4v"
Content-Disposition: inline
In-Reply-To: <osdt4teotc6qvja734dyo7be35nzy5lo4sw4dcniaqicqb3o5l@gabq5adeliha>


--mi2qfxtel4vcha4v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
MIME-Version: 1.0

On Tue, Sep 23, 2025 at 01:28:57PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 23, 2025 at 11:38:17AM +0200, Maxime Ripard wrote:
> > On Mon, Sep 15, 2025 at 09:38:44PM +0300, Dmitry Baryshkov wrote:
> > > On Mon, Sep 15, 2025 at 10:42:22AM +0200, Maxime Ripard wrote:
> > > > Hi Tohmas,
> > > >=20
> > > > On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
> > > > > > +/**
> > > > > > + * drm_atomic_build_readout_state - Creates an initial state f=
rom the hardware
> > > > > > + * @dev: DRM device to build the state for
> > > > > > + *
> > > > > > + * This function allocates a &struct drm_atomic_state, calls t=
he
> > > > > > + * atomic_readout_state callbacks, and fills the global state =
old states
> > > > > > + * by what the callbacks returned.
> > > > > > + *
> > > > > > + * Returns:
> > > > > > + *
> > > > > > + * A partially initialized &struct drm_atomic_state on success=
, an error
> > > > > > + * pointer otherwise.
> > > > > > + */
> > > > > > +static struct drm_atomic_state *
> > > > > > +drm_atomic_build_readout_state(struct drm_device *dev)
> > > > > > +{
> > > > > > +	struct drm_connector_list_iter conn_iter;
> > > > > > +	struct drm_atomic_state *state;
> > > > > > +	struct drm_mode_config *config =3D
> > > > > > +		&dev->mode_config;
> > > > > > +	struct drm_connector *connector;
> > > > > > +	struct drm_printer p =3D
> > > > > > +		drm_info_printer(dev->dev);
> > > > > > +	struct drm_encoder *encoder;
> > > > > > +	struct drm_plane *plane;
> > > > > > +	struct drm_crtc *crtc;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	drm_dbg_kms(dev, "Starting to build atomic state from hardwar=
e state.\n");
> > > > > > +
> > > > > > +	state =3D drm_atomic_state_alloc(dev);
> > > > > > +	if (WARN_ON(!state))
> > > > > > +		return ERR_PTR(-ENOMEM);
> > > > > > +
> > > > > > +	state->connectors =3D kcalloc(config->num_connector, sizeof(*=
state->connectors), GFP_KERNEL);
> > > > > > +	if (WARN_ON(!state->connectors)) {
> > > > > > +		ret =3D -ENOMEM;
> > > > > > +		goto err_state_put;
> > > > > > +	}
> > > > > > +
> > > > > > +	state->private_objs =3D kcalloc(count_private_obj(dev), sizeo=
f(*state->private_objs), GFP_KERNEL);
> > > > > > +	if (WARN_ON(!state->private_objs)) {
> > > > > > +		ret =3D -ENOMEM;
> > > > > > +		goto err_state_put;
> > > > > > +	}
> > > > > > +
> > > > > > +	drm_for_each_crtc(crtc, dev) {
> > > > > > +		const struct drm_crtc_funcs *crtc_funcs =3D
> > > > > > +			crtc->funcs;
> > > > > > +		struct drm_crtc_state *crtc_state;
> > > > > > +
> > > > > > +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name=
);
> > > > > > +
> > > > > > +		if (crtc_funcs->atomic_readout_state) {
> > > > > > +			crtc_state =3D crtc_funcs->atomic_readout_state(crtc);
> > > > > > +		} else if (crtc_funcs->reset) {
> > > > > > +			crtc_funcs->reset(crtc);
> > > > > > +
> > > > > > +			/*
> > > > > > +			 * We don't want to set crtc->state field yet. Let's save a=
nd clear it up.
> > > > > > +			 */
> > > > > > +			crtc_state =3D crtc->state;
> > > > > > +			crtc->state =3D NULL;
> > > > >=20
> > > > > Chancing the crtc->state pointer behind the back of the reset cal=
lback seems
> > > > > fragile. We never how if some other piece of the driver refers to=
 it
> > > > > (although illegally).
> > > >=20
> > > > I agree that it's clunky. I'm not sure who would use it at this poi=
nt
> > > > though: we're in the middle of the drm_mode_config_reset(), so the
> > > > drivers' involvement is pretty minimal.
> > > >=20
> > > > I did wonder if changing reset to return the object instead of sett=
ing
> > > > $OBJECT->state would be a better interface?
> > > >=20
> > > > > For now, wouldn't it be better to require a read-out helper for a=
ll elements
> > > > > of the driver's mode-setting pipeline?=A0 The trivial implementat=
ion would
> > > > > copy the existing reset function and keep crtc->state to NULL.
> > > >=20
> > > > I also considered that, but I'm not sure we can expect bridges to h=
ave
> > > > readout hooks filled for every configuration in the wild.
> > > >=20
> > > > But maybe we can look during drm_mode_config_reset() at whether all=
 the
> > > > objects have their hook filled, and if not fall back on reset for
> > > > everything.
> > > >=20
> > > > It would make the implementation easier, but missing bridges
> > > > implementations would trigger a mode change when it might actually =
work
> > > > just fine since bridge state is pretty minimal.
> > >=20
> > > DP bridge drivers have a pretty big state (DPCD and all the features).
> >=20
> > I meant drm_bridge_state. Subclasses would have their own implementation
> > anyway.
> >=20
> > > Other bridge drivers randomly leak state to the non-state structs.
> >=20
> > I'm not sure what you mean by that though. Can you expand?
>=20
> I think I've seen bridge drivers which stored subclassed drm_bridge
> instead of drm_bridge_state or stored the data in the long-living data
> structures. YEs, that's a bug, which should be fixed on its own.

Yeah, I'm not sure how we can defend against that. If the driver doesn't
handle the state well, then it's a driver's problem, and it would
probably create other problems anyway

Maxime

--mi2qfxtel4vcha4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNO/nwAKCRAnX84Zoj2+
dqyAAXwIWR/ZJ8j2HHQztw6sZLaUvoDHx4Aw4+XFWcbgf2EiMWxNT7INGKbJu9ug
NNE8CfgBf3gukTkbFq8K/U0WYR1cBv5fDS6cf/TDXE3rO9t8iM3XyRpQmn7nzYEn
7QrcyW35mg==
=VIGl
-----END PGP SIGNATURE-----

--mi2qfxtel4vcha4v--

