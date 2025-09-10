Return-Path: <linux-kernel+bounces-809621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80BB50FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE96482869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90F30DEA6;
	Wed, 10 Sep 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LamIGD1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E330DD3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490745; cv=none; b=W+6xHx6w7q8Qyy6YvrCigBFb7/jubw7Mb+QwRJ/pntHOOAN0ZA4jpCP47T6tbGmdvXzSZppNrcPlX/CxyITep9BB7J4sCukV3C2MyKFVqgp6DspFoQBkWu8CaM8OzNdm5mjdPm24fVL/kNkhyeHLkqYvYMgnNe22gtgLUdPwVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490745; c=relaxed/simple;
	bh=KT11CFgDF51QdJwu+rJCwNinPOsU6PNjp4Iyulbjie0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/wvwFuX5znJQJWS8EfHbXVJF37SI03ye65GbYrV+pQW+dG9Hr5dEzQ43W4mKFxd0uWleXFodB8ImX3+dizZ8SA6gSOt4UBe5PccMDo4e0ZPUy/sqSfirds/6sqqZAC8xv4Y+TUQMatiQNmVHTkTyzzltkZfYIrj19BbCZRpG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LamIGD1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5A6C4CEF0;
	Wed, 10 Sep 2025 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757490745;
	bh=KT11CFgDF51QdJwu+rJCwNinPOsU6PNjp4Iyulbjie0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LamIGD1qr4S96Y5A6Ic5A4xhpLGmLFZwjKKjMZaPgkUbMNx+N3T3xHpH8laPCApBY
	 cSokzYof+HScaMolR+F7QEW7fb/BKnlN3WWR11smj8plV1yKp3qSlLbOU5YiujZXQ5
	 jWCSejGI7odwMnjKTJE35ZHFQ4ExRgejgw6ce7DiW37ClMA+y5QUsDiCDjPVsSOWDp
	 Gt9IcgN9Hh6r4CAua5QDT18oZUnBjnE78dX2xLsgCE3VT/fy5Na9i0Lp1dssZ9QpRm
	 NGLwF/9QNa8/sWNSCZHPfR0H4j1WMMfqDRmEXJTKHq0ZSAzyiERMvvO2BqmYzhodvM
	 4z4sv6mFtL7jg==
Date: Wed, 10 Sep 2025 09:52:21 +0200
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
Message-ID: <20250910-amazing-camouflaged-barracuda-bb79cb@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
 <20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
 <l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
 <20250820131302.6a2da5ef@booty>
 <20250908154901.64f1a639@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="r7rztooyq4gxwyol"
Content-Disposition: inline
In-Reply-To: <20250908154901.64f1a639@booty>


--r7rztooyq4gxwyol
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
MIME-Version: 1.0

On Mon, Sep 08, 2025 at 03:49:01PM +0200, Luca Ceresoli wrote:
> Hello Maxime,
>=20
> On Wed, 20 Aug 2025 13:13:02 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>=20
> > > > +	/*
> > > > +	 * sn65dsi83_atomic_disable() should release some resources, but =
it
> > > > +	 * cannot if we call drm_bridge_unplug() before it can
> > > > +	 * drm_bridge_enter(). If that happens, let's release those
> > > > +	 * resources now.
> > > > +	 */
> > > > +	if (ctx->disable_resources_needed) {
> > > > +		if (!ctx->irq)
> > > > +			sn65dsi83_monitor_stop(ctx);
> > > > +
> > > > +		gpiod_set_value_cansleep(ctx->enable_gpio, 0);
> > > > +		usleep_range(10000, 11000);
> > > > +
> > > > +		regulator_disable(ctx->vcc);
> > > > +	}   =20
> > >=20
> > > I'm not sure you need this. Wouldn't registering a devm action do the
> > > same thing? =20
> >=20
> > Good idea, thanks. I'll give it a try.
>=20
> I'm catching up with this series after being busy a few weeks...
>=20
> I looked at this, but contrary my initial impression I think it would
> not be an improvement.
>=20
> The reason is at least one of these cleanup actions (namely the
> regulator_disable()) must be done only if there is a matching enable,
> which is in atomic_pre_enable. This is why I introduced a flag in the
> first place.
>=20
> I'm not sure which usage of devres you had in mind, but I see two
> options.
>=20
> Option 1: in probe, add a devres action to call a function like:
>=20
> sn65dsi83_cleanups()
> {
> 	if (ctx->disable_resources_needed) {
> 		/* the same cleanups */
> 	}   =20
> }
>=20
> But that is just a more indirect way of doing the same thing, and
> relies on the same flag.
>=20
> Option 2: have a function to unconditionally do the cleanups:
>=20
> sn65dsi83_cleanups()
> {
> 	/* the same cleanups (no if) */
> }
>=20
> And then:
>  * in atomic_pre_enable, instead of setting the flag
>    add a devres action to call sn65dsi83_cleanups()
>  * in atomic_disable, instead of clearing the flag
>    remove the devres action
>=20
> Even this option looks like more complicated and less readable code
> to do the same thing.
>=20
> Do you have in mind a better option that I haven't figured out?

Would using devm_add_action in atomic_pre_enable, and
devm_release_action in atomic_post_disable work?

That way, if you have a typical enable / disable cycle, the action will
get registered and executed properly, and if you only have an enable but
no matching disable, it will be collected after remove.

Maxime

--r7rztooyq4gxwyol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMEuNQAKCRAnX84Zoj2+
dtLOAX9rfDRVVP+/z7dJDPxsVAJx0Q3CbcUFefT8oLdQq+ir/1ZSRE1K/ac7ytHJ
cEOJhy4Bf0PYd6HQyy2bD/x4/X5jf+w8apfzLbg+ydQa+kAMAwStBVAOjMZEGylM
F9sYa3xEFA==
=Bjkz
-----END PGP SIGNATURE-----

--r7rztooyq4gxwyol--

