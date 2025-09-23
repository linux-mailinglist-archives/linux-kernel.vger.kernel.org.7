Return-Path: <linux-kernel+bounces-828718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6DB95469
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097B517DE83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11133191C4;
	Tue, 23 Sep 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBVVCJ4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D7261B9C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620225; cv=none; b=YyZkF7bb/tPdwud2ztImYa7GWmQWGDsyB9xCsN4kRtl3TSjDYm14B3Fe8B8mooRdM4rnLCSrwznnvEmuYmxPLbwUNVCP+BcakURk9kBx6vVMuT8LxNU0oXXHZ/WhoN4RvwpQ7cT/FF06cCcq9HqyoWiqG9egOonkImnTbyd2RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620225; c=relaxed/simple;
	bh=Q+6zkt4LydWcbfY33CfsTRod3mEjDVleuBIbbvLm7gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSKqDLflPLbgR5ggeMEfDVoy1XdusKZD5kE+KmRcAOoqG17CwG4VFxdQVsbWdMWDORKFRyp0cZRkRpef00LLggKNZe8dI9WpKjQXUPSJnQtgIWvcK3yQ2NGe5Wi0SFUrLdAt0hyzAMrIVs+Lf6TYNyeOHAJeztWMFZWeAKVtNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBVVCJ4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAF5C4CEF5;
	Tue, 23 Sep 2025 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758620225;
	bh=Q+6zkt4LydWcbfY33CfsTRod3mEjDVleuBIbbvLm7gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBVVCJ4TK3utj+6/ePoy6dliRKTRd6jhX6fILu6sZFxQr2g9mcXvt0dSItiDmimjY
	 ym+fkvIXi4H9E6/fsgEkN1NdY3KcSVYY3Z11+tBqw4t1wdshcxBk45Z8rSrNqkOUtS
	 K4AmsNtWQp22H7RBZ7FC5AAIDTMy5YbzRjJmnUUsy1IZnh6fUUFeKzD6YGy7mVfJ0X
	 u+RIdH4oBWKROAfMrqHfB7sGf9QJvrAnu0PBN5Ghv6szJVQvyCDQIK3ay0LznfQTxu
	 1u/fHeDngQa7neaVhnqYPjQ20I2d8wehpYIPrRWM9Ms4f4MaRnSH5XplYaLU2nv5C+
	 AJLXdTRn4h29g==
Date: Tue, 23 Sep 2025 11:37:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
Message-ID: <20250923-tentacled-cocky-bustard-597cb6@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
 <20250915-active-placid-bustard-6e1faa@penduick>
 <5920ffe5-b6b1-484b-b320-332b9eb9db82@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="l4uwxdrhpwfeymjy"
Content-Disposition: inline
In-Reply-To: <5920ffe5-b6b1-484b-b320-332b9eb9db82@suse.de>


--l4uwxdrhpwfeymjy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 11:11:39AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 15.09.25 um 10:42 schrieb Maxime Ripard:
> > Hi Tohmas,
> >=20
> > On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
> > > > +/**
> > > > + * drm_atomic_build_readout_state - Creates an initial state from =
the hardware
> > > > + * @dev: DRM device to build the state for
> > > > + *
> > > > + * This function allocates a &struct drm_atomic_state, calls the
> > > > + * atomic_readout_state callbacks, and fills the global state old =
states
> > > > + * by what the callbacks returned.
> > > > + *
> > > > + * Returns:
> > > > + *
> > > > + * A partially initialized &struct drm_atomic_state on success, an=
 error
> > > > + * pointer otherwise.
> > > > + */
> > > > +static struct drm_atomic_state *
> > > > +drm_atomic_build_readout_state(struct drm_device *dev)
> > > > +{
> > > > +	struct drm_connector_list_iter conn_iter;
> > > > +	struct drm_atomic_state *state;
> > > > +	struct drm_mode_config *config =3D
> > > > +		&dev->mode_config;
> > > > +	struct drm_connector *connector;
> > > > +	struct drm_printer p =3D
> > > > +		drm_info_printer(dev->dev);
> > > > +	struct drm_encoder *encoder;
> > > > +	struct drm_plane *plane;
> > > > +	struct drm_crtc *crtc;
> > > > +	int ret;
> > > > +
> > > > +	drm_dbg_kms(dev, "Starting to build atomic state from hardware st=
ate.\n");
> > > > +
> > > > +	state =3D drm_atomic_state_alloc(dev);
> > > > +	if (WARN_ON(!state))
> > > > +		return ERR_PTR(-ENOMEM);
> > > > +
> > > > +	state->connectors =3D kcalloc(config->num_connector, sizeof(*stat=
e->connectors), GFP_KERNEL);
> > > > +	if (WARN_ON(!state->connectors)) {
> > > > +		ret =3D -ENOMEM;
> > > > +		goto err_state_put;
> > > > +	}
> > > > +
> > > > +	state->private_objs =3D kcalloc(count_private_obj(dev), sizeof(*s=
tate->private_objs), GFP_KERNEL);
> > > > +	if (WARN_ON(!state->private_objs)) {
> > > > +		ret =3D -ENOMEM;
> > > > +		goto err_state_put;
> > > > +	}
> > > > +
> > > > +	drm_for_each_crtc(crtc, dev) {
> > > > +		const struct drm_crtc_funcs *crtc_funcs =3D
> > > > +			crtc->funcs;
> > > > +		struct drm_crtc_state *crtc_state;
> > > > +
> > > > +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
> > > > +
> > > > +		if (crtc_funcs->atomic_readout_state) {
> > > > +			crtc_state =3D crtc_funcs->atomic_readout_state(crtc);
> > > > +		} else if (crtc_funcs->reset) {
> > > > +			crtc_funcs->reset(crtc);
> > > > +
> > > > +			/*
> > > > +			 * We don't want to set crtc->state field yet. Let's save and c=
lear it up.
> > > > +			 */
> > > > +			crtc_state =3D crtc->state;
> > > > +			crtc->state =3D NULL;
> > > Chancing the crtc->state pointer behind the back of the reset callbac=
k seems
> > > fragile. We never how if some other piece of the driver refers to it
> > > (although illegally).
> > I agree that it's clunky. I'm not sure who would use it at this point
> > though: we're in the middle of the drm_mode_config_reset(), so the
> > drivers' involvement is pretty minimal.
> >=20
> > I did wonder if changing reset to return the object instead of setting
> > $OBJECT->state would be a better interface?
>=20
> Probably not. The reset helper is supposed to initialize the object's
> software and hardware state. But in most drivers, we're currently mostly
> setting the minimal software state here and simply assume that hardware is
> off. Returning the state would water down semantics even further.
>=20
> Having said that, I could imaging building an atomic_clean_state callback
> that replaces the reset callback. It would work alongside the new
> atomic_readout_state callback.=A0 Current reset could be build upon that
> callback. The atomic_clean_state would intentionally only take care of the
> software state and leave hardware state undefined. This reflects the curr=
ent
> realities of most DRM drivers.=A0 =A0From that clean state, DRM could do =
an
> atomic commit that also initializes the hardware.

That sounds like a good idea, but I wonder how we would deal with reset
then? Should we remove it entirely? Still call it? What do you think?

> > > For now, wouldn't it be better to require a read-out helper for all e=
lements
> > > of the driver's mode-setting pipeline?=A0 The trivial implementation =
would
> > > copy the existing reset function and keep crtc->state to NULL.
> > I also considered that, but I'm not sure we can expect bridges to have
> > readout hooks filled for every configuration in the wild.
> >=20
> > But maybe we can look during drm_mode_config_reset() at whether all the
> > objects have their hook filled, and if not fall back on reset for
> > everything.
>=20
> That's what I meant, I think.
>=20
> > It would make the implementation easier, but missing bridges
> > implementations would trigger a mode change when it might actually work
> > just fine since bridge state is pretty minimal.
>=20
> If there's an element in the pipeline that's missing the readout helper, =
it
> might be safer to fallback to that modeset instead of ending up with
> inconsistent state.

Yeah, that sounds fair.

Maxime

--l4uwxdrhpwfeymjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJqPgAKCRAnX84Zoj2+
doY2AYChpPpwtaRIbZ7BmYu8k8IHQLZDz8l8m9zJK13Zq0ZYd7GSHwyEihEEEBsq
zuo7GsUBgMb/ie5iUhu8NZ+8dCjzxjeT6bdI1x4tknpDpRu/T31CFNM+zRG0yVg8
mEVmAaWrWg==
=n26g
-----END PGP SIGNATURE-----

--l4uwxdrhpwfeymjy--

