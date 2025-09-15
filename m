Return-Path: <linux-kernel+bounces-816396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDEB57343
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB743A56A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C12ED848;
	Mon, 15 Sep 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9jQaSaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DB36D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925745; cv=none; b=oXTXEpxd7oOLnN9lDeD05c39NucMyzdypgYCrie+bcgieSHgJiHp+Ca3ywtaaH55AauN7fc7ggGjBnrRSLjMNbNof7DIYTKM+tUNUyrR7bUA9lvzhutJN+kLwaB+GOK6X94WylS/pSXeQ1Y0F66kxCU6OUsy2+5h5C2JjjuNLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925745; c=relaxed/simple;
	bh=wleHSUsSgWx9qHAIz8fMq3O7Jb1p1ki6q2T9lTslIT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk1ze9xvitMyv3Do+83EGV40YK3WAhZIug8/UkmNzG1SWmT5vzCqyIfwKT4Qx1k9AM6Erz2eVfrHs/TmjR37X0Mecxc+uSPhFIi0lEkdCDdDnnzZfQfprCSI3pwGP+swjR5s+tArac7uoFHqdeujWx04LwWysQsB/RzXkZjUUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9jQaSaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9C8C4CEF1;
	Mon, 15 Sep 2025 08:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757925745;
	bh=wleHSUsSgWx9qHAIz8fMq3O7Jb1p1ki6q2T9lTslIT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9jQaSaWikbzrKLxbjsiWrS3qT8+DmO1J7tuhqW+so3iDdHuoZXqF9/R7M+3isE8G
	 1xMUVTvU6ZicmeDRZgZQiDek7nNH4ZcdO0AglxSacF7iPhLEu7QZgpEgvpnub2TO8a
	 SvlQ5WbaVuhzyZcnr76UQznFVju47mLDG5F8wRepRP4OIkAS95gbhvxbNNk7upHrGG
	 U+XSnQC9VjrmtfwB6dFsrFFq7UqOUpJcFE+KZC7tjI10Gx1S+5ijEGtk69SpaQHyQX
	 00RTpd76MUcku2pYe+/haex2NywJpa+LEB1cdu2fR9JBBbdAqpqvt8s9xnDlvQwQk+
	 fSI4HHeKjyUZg==
Date: Mon, 15 Sep 2025 10:42:22 +0200
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
Message-ID: <20250915-active-placid-bustard-6e1faa@penduick>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-10-14ad5315da3f@kernel.org>
 <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rquzft6z5fvp5dul"
Content-Disposition: inline
In-Reply-To: <03240fae-544f-4753-96c5-a116b4b5a318@suse.de>


--rquzft6z5fvp5dul
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/29] drm/atomic: Add atomic_state_readout infrastructure
MIME-Version: 1.0

Hi Tohmas,

On Tue, Sep 02, 2025 at 03:44:54PM +0200, Thomas Zimmermann wrote:
> > +/**
> > + * drm_atomic_build_readout_state - Creates an initial state from the =
hardware
> > + * @dev: DRM device to build the state for
> > + *
> > + * This function allocates a &struct drm_atomic_state, calls the
> > + * atomic_readout_state callbacks, and fills the global state old stat=
es
> > + * by what the callbacks returned.
> > + *
> > + * Returns:
> > + *
> > + * A partially initialized &struct drm_atomic_state on success, an err=
or
> > + * pointer otherwise.
> > + */
> > +static struct drm_atomic_state *
> > +drm_atomic_build_readout_state(struct drm_device *dev)
> > +{
> > +	struct drm_connector_list_iter conn_iter;
> > +	struct drm_atomic_state *state;
> > +	struct drm_mode_config *config =3D
> > +		&dev->mode_config;
> > +	struct drm_connector *connector;
> > +	struct drm_printer p =3D
> > +		drm_info_printer(dev->dev);
> > +	struct drm_encoder *encoder;
> > +	struct drm_plane *plane;
> > +	struct drm_crtc *crtc;
> > +	int ret;
> > +
> > +	drm_dbg_kms(dev, "Starting to build atomic state from hardware state.=
\n");
> > +
> > +	state =3D drm_atomic_state_alloc(dev);
> > +	if (WARN_ON(!state))
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	state->connectors =3D kcalloc(config->num_connector, sizeof(*state->c=
onnectors), GFP_KERNEL);
> > +	if (WARN_ON(!state->connectors)) {
> > +		ret =3D -ENOMEM;
> > +		goto err_state_put;
> > +	}
> > +
> > +	state->private_objs =3D kcalloc(count_private_obj(dev), sizeof(*state=
->private_objs), GFP_KERNEL);
> > +	if (WARN_ON(!state->private_objs)) {
> > +		ret =3D -ENOMEM;
> > +		goto err_state_put;
> > +	}
> > +
> > +	drm_for_each_crtc(crtc, dev) {
> > +		const struct drm_crtc_funcs *crtc_funcs =3D
> > +			crtc->funcs;
> > +		struct drm_crtc_state *crtc_state;
> > +
> > +		drm_dbg_kms(dev, "Initializing CRTC %s state.\n", crtc->name);
> > +
> > +		if (crtc_funcs->atomic_readout_state) {
> > +			crtc_state =3D crtc_funcs->atomic_readout_state(crtc);
> > +		} else if (crtc_funcs->reset) {
> > +			crtc_funcs->reset(crtc);
> > +
> > +			/*
> > +			 * We don't want to set crtc->state field yet. Let's save and clear=
 it up.
> > +			 */
> > +			crtc_state =3D crtc->state;
> > +			crtc->state =3D NULL;
>=20
> Chancing the crtc->state pointer behind the back of the reset callback se=
ems
> fragile. We never how if some other piece of the driver refers to it
> (although illegally).

I agree that it's clunky. I'm not sure who would use it at this point
though: we're in the middle of the drm_mode_config_reset(), so the
drivers' involvement is pretty minimal.

I did wonder if changing reset to return the object instead of setting
$OBJECT->state would be a better interface?

> For now, wouldn't it be better to require a read-out helper for all eleme=
nts
> of the driver's mode-setting pipeline?=A0 The trivial implementation would
> copy the existing reset function and keep crtc->state to NULL.

I also considered that, but I'm not sure we can expect bridges to have
readout hooks filled for every configuration in the wild.

But maybe we can look during drm_mode_config_reset() at whether all the
objects have their hook filled, and if not fall back on reset for
everything.

It would make the implementation easier, but missing bridges
implementations would trigger a mode change when it might actually work
just fine since bridge state is pretty minimal.

Idk.

> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -490,10 +490,31 @@ struct drm_bridge_funcs {
> >   	 * The @atomic_post_disable callback is optional.
> >   	 */
> >   	void (*atomic_post_disable)(struct drm_bridge *bridge,
> >   				    struct drm_atomic_state *state);
> > +	/**
> > +	 * @atomic_readout_state:
> > +	 *
> > +	 * Initializes,this bridge atomic state.
> > +	 *
> > +	 * It's meant to be used by drivers that wants to implement fast
>=20
> 'want'
>=20
> > +	 * / flicker-free boot and allows to initialize the atomic state
>=20
> I think we should only call it flicker-free boot. Fast boot is misleading.

I agree, but it's also how it's been called by the only implementation
of it we have so far (i915), and the name of the module parameter that
controls it.

Maxime

--rquzft6z5fvp5dul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMfRbQAKCRAnX84Zoj2+
dmFvAYDuDFWmhNNkft79tiALv3owEKTrru4/rL0SRhqujC12Dgb4xqjmiowmWw7D
D/pZxlkBgNE2szU6woQ4HiQribxJLm8+e5U4I1UDXv6Ahrz40FGJ4o+wiMiOUhJz
YKNHJzA3ig==
=Ks+6
-----END PGP SIGNATURE-----

--rquzft6z5fvp5dul--

