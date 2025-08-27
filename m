Return-Path: <linux-kernel+bounces-787847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127EB37C24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09AF7C381D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F503164B4;
	Wed, 27 Aug 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFIccRh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167F2F617A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280767; cv=none; b=HezRJA6jFMvOSpWbHkOQijIkJZUJDu8a+/HWFXAAIOvsi/S477DyR6am8nrl39o8tmWXSpHkivLPC0gLYd9OtdRm8PD3tvxsqZNfsfTZM+e+3FjHrvnYTeYfAxC8fRdxo+TH95fBrXUhWK6o2s6Y/uQzjmikA9wevZUJ59QdeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280767; c=relaxed/simple;
	bh=ytubK461FniUf2IfwdqKsByFkQ4P0lYinRAgiXXMQSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZngYo0Bx/mgjWvMNTvitY1YVnsd4Sy18WS2L2tQ9xRlXEef6yl24fYhF9qEDHD9Sgv0lZXPIDvwnmVdMQ3HXfS/tubOiog6yjTC97M7UCwLBLCY7KVG1r+E7GnQ4FYjOoWIhERJVRA70/n7cHyxyZLlg95QedCz7mgfI9sFWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFIccRh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FB7C4CEEB;
	Wed, 27 Aug 2025 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756280766;
	bh=ytubK461FniUf2IfwdqKsByFkQ4P0lYinRAgiXXMQSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFIccRh0T7Gcu5rUbogq38tukybr1RmrGuforXmNK4SIKXOqQNlmNVDNro+9jy5vy
	 Sss83LMuf9GuGjIj95Lo6jzcmNtIUnzGuaYx8Rhrprh+ckO6axB51qtTemZYxUxk2n
	 FkEZZhvE6ToWkXq7N4hl8E/6L+9o9Q3FwPol8E/8e/1YG/aEvDoIUYkjzVZUpaNGr1
	 HP37jXpN+p4vno5I+RrxtD4/qPiVGAJPIicgbFhsyKrEjvdzdt3rg5CtqVhk7/om4h
	 Y9OjuTySiwIPW/vrjcvjQPKvW3VX9VAx0IKrPkIpdsQgahAKQxpmdWGD43fyTey3sk
	 R+B3Ib2RFpZrA==
Date: Wed, 27 Aug 2025 09:46:03 +0200
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
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
Message-ID: <20250827-charming-arcane-stingray-cfb8b6@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
 <20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
 <l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
 <20250820131302.6a2da5ef@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="crrk2hz4sf2bauvt"
Content-Disposition: inline
In-Reply-To: <20250820131302.6a2da5ef@booty>


--crrk2hz4sf2bauvt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
MIME-Version: 1.0

On Wed, Aug 20, 2025 at 01:13:02PM +0200, Luca Ceresoli wrote:
> Hello Maxime,
>=20
> On Tue, 19 Aug 2025 14:29:32 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > > @@ -1005,7 +1041,24 @@ static void sn65dsi83_remove(struct i2c_client=
 *client)
> > >  {
> > >  	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);
> > > =20
> > > +	drm_bridge_unplug(&ctx->bridge);
> > >  	drm_bridge_remove(&ctx->bridge); =20
> >=20
> > Shouldn't we merge drm_bridge_unplug with the release part of
> > devm_drm_bridge_alloc?
>=20
> I'm not sure I got what you are suggesting here, sorry.
>=20
> Do you mean that __devm_drm_bridge_alloc() should add a devres action
> to call drm_bridge_unplug(), so the unplug is called implicitly and
> does not need to be called explicitly by all drivers?

Yes

> If that's what you mean, I don't think that would work. Unless I'm
> missing something, devres actions are always invoked just after the
> driver .remove callback.

Yes, they are called in reverse order of registration, after remove.

> But we need to call drm_bridge_unplug() at the beginning (or just
> before) .remove, at least for drivers that need to do something in
> .remove that cannot be done by devm.
>=20
> In pseudocode:
>=20
> mybridge_remove()
> {
>   drm_bridge_unplug(); <-- explicit call as in my patch
>   xyz_disable();
>   drm_bridge_unplug(); <-- implicitly done by devres
> }
>=20
> We want xyz_disable() to be done after drm_bridge_unplug(), so other
> code paths using drm_bridge_enter/exit() won't mess with xyz.

It's not clear to me why doing it before xyz_disable() is important
here? If anything, it would prevent from disabling the hardware for
example, even though you still have your memory mapping, clocks, power
domains, regulators, etc. to properly disable it.

You're still correct that it's a bad idea though because we want to do
it before we start freeing all those, so it needs to execute as the
before the devm actions ...

> devres actions cannot be added to be executed _before_ .remove, AFAIK.

=2E.. and we can't do that either.

Maxime

--crrk2hz4sf2bauvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK63uwAKCRAnX84Zoj2+
dgLcAYCbzeLhpttYGY0jIOvo/NL1UpFAUrqw3LpkYCfx7XLCeWzOJnDcUU+sOaAV
PQRUGesBgJr8xIO7M9NVXmh8k2lakSPVKLcdG+5v6nlYTP8thl/MHrBT2nsih6oO
fJVVvVq9Pg==
=XFdz
-----END PGP SIGNATURE-----

--crrk2hz4sf2bauvt--

