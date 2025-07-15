Return-Path: <linux-kernel+bounces-731821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE311B059FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C783AC103
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967142DE6FC;
	Tue, 15 Jul 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXyLaX9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DB2DA77D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582510; cv=none; b=ZOVmLOYYvnbwwaVF1pbYwscrEOngrwNpeytgED3yqn8R9nPU0MX58MWLbqiZdliuZ+0EKvSAWDngRSUNo3+qmpa2isbrE95fF/B30yLFa8AURTdYpQnDpfBNAYyJpOPSBn2HEgqyGucBFfDplv60b1pFHdsyDTsAyx3fsMewSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582510; c=relaxed/simple;
	bh=iBP3BhhuxTyX6+y3EN+5CBtDDPSb5aDDBu28cZf+Mo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ4RINnZHjaInbkzsgGYAsFf6Y4QJIo8gNAy+vWG4ToA5zD0Z05nsRAu1EdQpj+XPbQUJD1Kh57911Q1GyQ8MEkH+fQEnMULdQFm+bujjf8aPn10iYJ5niE8T8EVA0RWObvkNFCweIy9Tq65+W0QL2BrC6ePOMYK7j1tTYqoMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXyLaX9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B3C4CEE3;
	Tue, 15 Jul 2025 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752582509;
	bh=iBP3BhhuxTyX6+y3EN+5CBtDDPSb5aDDBu28cZf+Mo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXyLaX9/uWHFJd5Iqgd/RXyR+p5Vg9L943MLzb6vvlqWcJaDaIm6/es0AjVIlJrJk
	 YQu4V7U/fyLYBj9GgCYdKFKyYLC0ycgZYfyh+oEH8h+6yrEPd3BpA6ieLxyVJlFGYt
	 IbfFw/DFetzMtEpre3F8qynmeJRgU2wPo0o39lnWjte8puLOzKViYF4qOhuhKFgnlj
	 ewfThYfqYnqAE//1ZiK1XsVnv5u5MsfAqjAoBXBmR/8vEFxTaDXQey5IoaJ6XSea9n
	 /Nvq11wWrglIhQ4HCUwhJ9exMTOTPBYbn226Yy4k/GvgKiqix7p+1+9Vb6/qIHc+WA
	 yRYpKa4XaRWaw==
Date: Tue, 15 Jul 2025 13:28:26 +0100
From: Mark Brown <broonie@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add rt6166 vout min_uv setting for compatible
Message-ID: <69385dc7-b749-4c42-ab41-def7034b45f9@sirena.org.uk>
References: <20250715065144.2651342-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XjnGmMot0n4OWkFh"
Content-Disposition: inline
In-Reply-To: <20250715065144.2651342-1-jeff_chang@richtek.com>
X-Cookie: Your own mileage may vary.


--XjnGmMot0n4OWkFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 02:50:16PM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>=20
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> --- a/drivers/regulator/rt6160-regulator.c
> +++ b/drivers/regulator/rt6160-regulator.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-License-Identifier: GPL-4.0-only

This looks unintentional?

> -	if ((devid & RT6160_VID_MASK) !=3D RT6160_VENDOR_ID) {
> +	devid =3D devid & RT6160_VID_MASK;
> +	if (devid !=3D RT6160_VENDOR_ID || devid !=3D RT6166_VENDOR_ID) {
>  		dev_err(&i2c->dev, "VID not correct [0x%02x]\n", devid);
>  		return -ENODEV;
>  	}

This would be better written as a switch statement; ideally all the
device specific adjustments could be done at once there with a default
case handling unknown devices.

--XjnGmMot0n4OWkFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh2SWkACgkQJNaLcl1U
h9D9sAf/Xw0yFUfbAQFRdCzoo18xl0k55zHIJdYeyeYJEuWfio2lbaaAIGVguRlc
ZwHY9QosG4wcgORnR7eKEkpuMzpVIHXabCYvzqr58l0GI2l2Ga7y8ngXkM1v0e0s
iF0TGxQtzgvQovabqTa4SKTzUCk9JrImcA2Cu/Ehh8TFWy6iITItVCA2SSoIGHpA
oKdvFFh+zDHAqj286zRcMf/p1aa+3Bn6v2gEozq3uGYzDvmlYZq9i1Y0L38/2B2a
z+AjG6FGg8MAN0oo/LEYUIjc+Xh1C1Ew8PhWyGZ1pGUeuQYOWnhICRtnCIVwZs4A
sCn0MZQCt/M4CZ0sVHEKni+woPNJ0A==
=GDE/
-----END PGP SIGNATURE-----

--XjnGmMot0n4OWkFh--

