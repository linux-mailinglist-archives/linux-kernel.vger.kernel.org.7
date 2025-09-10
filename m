Return-Path: <linux-kernel+bounces-810018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EBEB514AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A465601BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90B30648D;
	Wed, 10 Sep 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8oTKrB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA09253351
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501956; cv=none; b=htt/BL4E79jP2/B5dgjYffm0EcxDOBcnb/QX5QwJ5MkwCyKOB7PXdok2+WsxECDo3EErablVhI4aiOL2l8n/5jAlf2aSaRhsRX3YIxmk3HEtjtWykg0QPTsUFcJW/Kti801POVvz12i8UO2socctOBApBxG9+149z8hkrv99xbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501956; c=relaxed/simple;
	bh=pgRra0TbLzaoR1byNocr13Rx9YUuYQKJyF3mqpyH7hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFbq9c0PtDVZP/sndjJcHKkF3omsSQg/Pu5T8u5IFbmCwBfYZvtlthJ57szuXU28rHZWbmFg5Zd70MBE22dqdmzz6R3I087h5n7JqLoVA3e3eem50+yGRDGjhTu042XMguw+8XxxfgHh4C66dh8kiWh37aX3lkE2U68nONHOU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8oTKrB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002C8C4CEF0;
	Wed, 10 Sep 2025 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757501955;
	bh=pgRra0TbLzaoR1byNocr13Rx9YUuYQKJyF3mqpyH7hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8oTKrB76/fMraFq696qdYKLEIOUVOV00Y24E2m9EdRylSqzFFVLKtxrr1Kz7vTXE
	 nsEJvifqtZlayUYBkcq/7NXiqsX0Qk8jOjOa0UfTsiuTWenRPIplF1XonbJVYjGMg/
	 upB4zxoE6X18uIzckO1iB9z/RIq2Z2kbWY6vwmn152qdttugYdyykTqiXZkHjKcQjn
	 pJzYgaVOC2T1hM3mfB3DIJ+5DAr//OSLwXJsRJ/cTj1kPRaO5UJdcavwLuPNAO4T/Q
	 7oA6m7acEPcYa58TG+1fpve0Crm1vymjAi1pGrxuZJ2h+mGvMkqWfoICUttz7pin0b
	 bJoNcW6ORrI8g==
Date: Wed, 10 Sep 2025 12:59:12 +0200
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
Message-ID: <20250910-glittering-serval-of-piety-b32844@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
 <20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
 <l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
 <20250820131302.6a2da5ef@booty>
 <20250827-charming-arcane-stingray-cfb8b6@houat>
 <20250908154906.16693078@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="uofjwl6sf7vvmaur"
Content-Disposition: inline
In-Reply-To: <20250908154906.16693078@booty>


--uofjwl6sf7vvmaur
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
MIME-Version: 1.0

On Mon, Sep 08, 2025 at 03:49:06PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Wed, 27 Aug 2025 09:46:03 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > On Wed, Aug 20, 2025 at 01:13:02PM +0200, Luca Ceresoli wrote:
> > > Hello Maxime,
> > >=20
> > > On Tue, 19 Aug 2025 14:29:32 +0200
> > > Maxime Ripard <mripard@kernel.org> wrote:
> > >  =20
> > > > > @@ -1005,7 +1041,24 @@ static void sn65dsi83_remove(struct i2c_cl=
ient *client)
> > > > >  {
> > > > >  	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);
> > > > > =20
> > > > > +	drm_bridge_unplug(&ctx->bridge);
> > > > >  	drm_bridge_remove(&ctx->bridge);   =20
> > > >=20
> > > > Shouldn't we merge drm_bridge_unplug with the release part of
> > > > devm_drm_bridge_alloc? =20
> > >=20
> > > I'm not sure I got what you are suggesting here, sorry.
> > >=20
> > > Do you mean that __devm_drm_bridge_alloc() should add a devres action
> > > to call drm_bridge_unplug(), so the unplug is called implicitly and
> > > does not need to be called explicitly by all drivers? =20
> >=20
> > Yes
> >=20
> > > If that's what you mean, I don't think that would work. Unless I'm
> > > missing something, devres actions are always invoked just after the
> > > driver .remove callback. =20
> >=20
> > Yes, they are called in reverse order of registration, after remove.
> >=20
> > > But we need to call drm_bridge_unplug() at the beginning (or just
> > > before) .remove, at least for drivers that need to do something in
> > > .remove that cannot be done by devm.
> > >=20
> > > In pseudocode:
> > >=20
> > > mybridge_remove()
> > > {
> > >   drm_bridge_unplug(); <-- explicit call as in my patch
> > >   xyz_disable();
> > >   drm_bridge_unplug(); <-- implicitly done by devres
> > > }
> > >=20
> > > We want xyz_disable() to be done after drm_bridge_unplug(), so other
> > > code paths using drm_bridge_enter/exit() won't mess with xyz. =20
> >=20
> > It's not clear to me why doing it before xyz_disable() is important
> > here? If anything, it would prevent from disabling the hardware for
> > example, even though you still have your memory mapping, clocks, power
> > domains, regulators, etc. to properly disable it.
> >=20
> > You're still correct that it's a bad idea though because we want to do
> > it before we start freeing all those, so it needs to execute as the
> > before the devm actions ...
> >=20
> > > devres actions cannot be added to be executed _before_ .remove, AFAIK=
=2E =20
> >=20
> > ... and we can't do that either.
>=20
> I understand your words as "the drm_bridge_unplug() is OK where it is,
> your patch is OK in this respect". Correct?
>=20
> So if this is correct, and my reply on the devres cleanups is also
> correct (other reply in this thread), that means the whole patch is OK.

I'm still confused why it's so important than in your example
xyz_disable must be called after drm_bridge_unplug.

Maxime

--uofjwl6sf7vvmaur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMFaAAAKCRAnX84Zoj2+
dnFrAYDGfUPH4VISbESMA/r7qkrCU9CpnyRaDBNG1PnU6UTTuDEpGf/flsGfDD0K
BJ3NyUEBf1jVWqCYaD+1VjRXXXOVpwBOUaTpkVU4/FRu2LT48QZoPAQ6oYnH+fXl
euLGxFahzw==
=h7ta
-----END PGP SIGNATURE-----

--uofjwl6sf7vvmaur--

