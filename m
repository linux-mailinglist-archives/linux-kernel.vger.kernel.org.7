Return-Path: <linux-kernel+bounces-865292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307CBFCB78
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C8D4F135F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0B3469EC;
	Wed, 22 Oct 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paOWUNtT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20635BDB8;
	Wed, 22 Oct 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144990; cv=none; b=KPCBZt0sFTPg3p7V7C4OWvzVpOpRGKs/JMGtZu09Vig15/p0AF9Ne28nOqZcro0wDFJj/2hO5Pj9qHuVZtYDfUPS1pYQvkByY6P4Fx4C3BAeTW3QXc+3GZiXGlJtO16EoAyvJWJY1rS7xu/OLwLRbkiZi+vq4VezjW8gm/yOo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144990; c=relaxed/simple;
	bh=Y0/Qsj5JIMYuznL9ResIUaTDl4hth2V0/GJK4iH2b6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLpXgMjJb3ZBkTo4G2W9T4eCGXA9UQlTX3LeF/5zrZxDz03PILXRXa3vwyP0ike3SqQFVrAmvPZy7Ww2JIUbVUeCyhNsINW2HEffFzXPAih5/QqFdw7jHGn29LFAEb5h04Dy8RbhnNYnEaVGzUyrjByOBoBeo0jc/ctI6rHZj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paOWUNtT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87040C4CEE7;
	Wed, 22 Oct 2025 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144989;
	bh=Y0/Qsj5JIMYuznL9ResIUaTDl4hth2V0/GJK4iH2b6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paOWUNtTBD4Qy/+mQnAgI1bho5pkHdRpk5XmyrpTkjalZeXoUoiLIayDZofCtytkh
	 yqLsP1lEo9MyU/klHMGqlaBWkEET+ANXU0UZoehxyfTLm5Wvpc2jHif5sINR8aSc68
	 c0M7skBTbvK4wKYhZ3NGbSTvzGb/pJtuAe4uj2dm0+RDPxWDdv2D9s+ihMfwC9fXJ5
	 G2BTK/OfofMykbtyhqGlNeRYxn2NEzZpSFTFM0qXd7Q4DoIctgbwNfviaZKNzaoWRx
	 Zj8JO0pdrwlFVQDDGNNbsICI8dVHe1WmqjsPmjVGnSlwofo4xC6d6s2eqXAdMZnXoX
	 phmzfit+96CTw==
Date: Wed, 22 Oct 2025 15:56:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Herve Codina <herve.codina@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <d38779a7-a1af-49e4-b429-5ebd791e2168@sirena.org.uk>
References: <e7873e6ce07cd92f4b5ce8880aa81b12c2a08ed3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tOG5GnSnDDCzxrVp"
Content-Disposition: inline
In-Reply-To: <e7873e6ce07cd92f4b5ce8880aa81b12c2a08ed3.camel@gmail.com>
X-Cookie: Remember the... the... uhh.....


--tOG5GnSnDDCzxrVp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 09:12:13PM +0200, Alexander Sverdlin wrote:
> On Tue, 2025-10-21 at 20:00 +0100, Mark Brown wrote:

> > Or at least you'd get both modules loaded with one being redundant.=A0 =
TBH

> I'm quite confident that udev/modprobe will load only the first module
> from modules.alias file.

Oh, I'm sure that's the case now but I can see someone changing that.

> > I'm very reluctant to touch this stuff for SPI without some very careful
> > analysis that it's not going to cause things to explode on people, right
> > now things seem to be working well enough so I'm not clear we'd be
> > solving an actual problem.

> The actual problem is that i2c-core is producing "of:" prefixed uevents
> instead of "i2c:" prefixed uevents starting from v4.18.

> Most of the dual-bus ASoC CODECs are affected.

That's a description of what change but not of a concrete problem that
users are experiencing.

> Now declaring "of:" to be the new I2C bus prefix for uevents starting from
> Linux v4.18 sounds strange.

I think a robust solution would involve having the OF aliases namespaced
by bus, or just not using the OF aliases but potentially having
collisions if two vendors pick the same device name.

--tOG5GnSnDDCzxrVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj48JUACgkQJNaLcl1U
h9An0Af9EGASCGgg9J0nbEkxfOLan+MEdKSUHqCxepMM6NXEHuCA/sRRv4zz2lnS
SY3xPDrq6KjkhdkAjGCTKGpL6xMQ3LHSVcsDlLle4C/h+nIvPirFyPVh9OqqHSi+
KwE94+8b5/YmoRtb5zw5T3TpBCHLcT1w2tdsSWbNaY4IcXRmaE+qzt/s9QRT9dgq
2RrcMS1m956Ll6sg0K1DjRK7LPVx9KKOwKhSJQHLzTX1pvtWmr5JYDHaqrl1wgIJ
zqLOeAePbm0jwnKedgG1/pphbckXTNTmOtdJNb9kWV+Y2feXYyh+vERtoNJ9HxYG
jbVav2epAVmTcFa97pqz5NVim3zl1g==
=Uwr2
-----END PGP SIGNATURE-----

--tOG5GnSnDDCzxrVp--

