Return-Path: <linux-kernel+bounces-752234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E3B172CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607B81884AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAD2C1594;
	Thu, 31 Jul 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqD4yT9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C581EB39
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970710; cv=none; b=Bp61lvK++fweBucM9TJB8boV2oloV9+2Cx6Q2NfZnTJ6Fpe5k/xRrK0kHDNDYwwtsLMkUIaQJo9zW45/C9P/ZxeyLaT/BizAzZDmxJ5xgJFIOI9P0w1WclCyDZb/VyIKcS5wI7iQm8h0IxqmzvZriVVRDnDbqTFiXi1ngThPBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970710; c=relaxed/simple;
	bh=Bp6qxWY5Vw4zchfSJZ5G0bLNb5BP1yJxoT6y6V2urbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2E/zQXGyvPy8FaFy8/IwaqJJPCIgOyfyPzgJeuSApx1ZxKFrbhEDfI2h2HBKI/VFhAkyoclQnV7v2WpXUHh+LyPBh6EqBcHf3ne7QgEvMIVY+RreW2xkIJblIxAeqUzuTq6ulM4KrMi7zxtLnTPBjHMdoQTGY375/gTumFtkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqD4yT9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA4C4CEEF;
	Thu, 31 Jul 2025 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753970709;
	bh=Bp6qxWY5Vw4zchfSJZ5G0bLNb5BP1yJxoT6y6V2urbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqD4yT9Vqrm2eckOx+2A9avYrCot149Z0UsurX7dJM/nhns3mbj+bDeDD4xdstgkG
	 uZgUPKJ6CT/y9tYR6SwFX1bw3fm981+O0oBbl6VJwXgA9Yuc2jdq7C7ApsPgIPuM9L
	 HelVI9G9hy/OoUD+wsiuN6LhkRwWIKFb72YUws35jR/83ObEMa78e6FAoNnPC5Yfiu
	 8tzkxwgWUNW2M768dRfnIPyZ76OtYEbYkiCSTnmicVEK96s5qf4gFzpiwjzuiqJQ+7
	 iRKxdM7+BTuFmqKeGQenmzDO4IVD8RxeVPrC4OJx4FFMWy/h1/ZN51fTxziJzeUkWQ
	 9mnv6i3zfzx9w==
Date: Thu, 31 Jul 2025 16:05:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] drm/tidss: dispc: Convert to FIELD_* API
Message-ID: <20250731-observant-fervent-heron-dbe833@houat>
References: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
 <15f0b568-3d59-4f0c-b390-4e3d3623136a@bootlin.com>
 <20250731-powerful-termite-of-inspiration-13f36d@houat>
 <c5e34fed-4dc7-4288-9183-c6c076bb3b85@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="etjucsgdpk7eff7t"
Content-Disposition: inline
In-Reply-To: <c5e34fed-4dc7-4288-9183-c6c076bb3b85@bootlin.com>


--etjucsgdpk7eff7t
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/14] drm/tidss: dispc: Convert to FIELD_* API
MIME-Version: 1.0

On Thu, Jul 31, 2025 at 03:49:12PM +0200, Louis Chauvet wrote:
>=20
>=20
> Le 31/07/2025 =E0 15:26, Maxime Ripard a =E9crit=A0:
> > Hi Louis,
> >=20
> > On Thu, Jul 31, 2025 at 03:04:49PM +0200, Louis Chauvet wrote:
> > > Le 30/07/2025 =E0 10:57, Maxime Ripard a =E9crit=A0:
> > > > Hi,
> > > >=20
> > > > The tidss driver rolls its own API equivalent to the FIELD_* API al=
ready
> > > > provided the kernel.
> > > >=20
> > > > Since it's an ad-hoc implementation, it also is less convenient and
> > > > doesn't provide some useful features like being able to share the f=
ield
> > > > definitions that will come handy in the future.
> > > >=20
> > > > Thus, this series converts the driver to that API and drops its own
> > > > version.
> > >=20
> > > I just saw your series after sending mine [2]. I checked, there is on=
ly one
> > > minor conflict that can be easly fixed.
> > >=20
> > > But when applied on drm-misc/drm-misc-next, your series raises:
> > >=20
> > > In file included from <command-line>:
> > > drivers/gpu/drm/tidss/tidss_dispc.c: In function 'FLD_MOD':
> > > ././include/linux/compiler_types.h:568:45: error: call to
> > > '__compiletime_assert_589' declared with attribute error: FIELD_PREP:=
 mask
> > > is not constant
> > >    568 |         _compiletime_assert(condition, msg, __compiletime_as=
sert_,
> > > __COUNTER__)
> > >        |                                             ^
> > > ././include/linux/compiler_types.h:549:25: note: in definition of mac=
ro
> > > '__compiletime_assert'
> > >    549 |                         prefix ## suffix();         \
> > >        |                         ^~~~~~
> > > ././include/linux/compiler_types.h:568:9: note: in expansion of macro
> > > '_compiletime_assert'
> > >    568 |         _compiletime_assert(condition, msg, __compiletime_as=
sert_,
> > > __COUNTER__)
> > >        |         ^~~~~~~~~~~~~~~~~~~
> > > ./include/linux/build_bug.h:39:37: note: in expansion of macro
> > > 'compiletime_assert'
> > >     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(con=
d), msg)
> > >        |                                     ^~~~~~~~~~~~~~~~~~
> > > ./include/linux/bitfield.h:65:17: note: in expansion of macro
> > > 'BUILD_BUG_ON_MSG'
> > >     65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask=
),
> > > \
> > >        |                 ^~~~~~~~~~~~~~~~
> > > ./include/linux/bitfield.h:115:17: note: in expansion of macro
> > > '__BF_FIELD_CHECK'
> > >    115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_P=
REP: ");
> > > \
> > >        |                 ^~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/tidss/tidss_dispc.c:599:33: note: in expansion of mac=
ro
> > > 'FIELD_PREP'
> > >    599 |         return (orig & ~mask) | FIELD_PREP(mask, val);
> > >        |                                 ^~~~~~~~~~
> > >=20
> > >=20
> > > This seems to be a limitation of FIELD_PREP [1].
> > > I think the only way to avoid this issue is to use macros and not fun=
ctions.
> > >=20
> > > [1]:https://elixir.bootlin.com/linux/v6.16/source/include/linux/bitfi=
eld.h#L65-L66
> > > [2]:https://lore.kernel.org/all/20250730-fix-edge-handling-v1-0-1bdfb=
3fe7922@bootlin.com/
> >=20
> > Weird, it compiles without warning for me here. Which compiler do you u=
se?
>=20
>=20
> I use this one:
>=20
> aarch64-linux-gnu-gcc (GCC) 14.2.1 20240912 (Red Hat Cross 14.2.1-2)
> Copyright (C) 2024 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

I was testing with clang, but I can indeed see it with gcc. I'll fix it. Th=
anks!

Maxime

--etjucsgdpk7eff7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaIt4DAAKCRAnX84Zoj2+
do57AYDvOXii+U61anW+nFQRa/XAyw4Xqjo5mcgrT8Jt8GGwUHH0NQ9dcQ4huElk
S7d+HVUBfi3pbfH1SUqIJh2nPXG4WpzJ10gwIilziA4vISMQYTNKFUDKnkan0XhB
apZsd/59OQ==
=zAzm
-----END PGP SIGNATURE-----

--etjucsgdpk7eff7t--

