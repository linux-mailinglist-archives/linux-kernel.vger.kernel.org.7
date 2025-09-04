Return-Path: <linux-kernel+bounces-800668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8AB43A44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8681A1C285BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F15E2D6612;
	Thu,  4 Sep 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+jmeyIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE7242D6B;
	Thu,  4 Sep 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985609; cv=none; b=K6wdw3DZPS18RLEMbh3YhJZ0NLb/Gaie3Cs2tBoXaCwZAMN8dHM0JFPmVTJb6y9Hze+aLiJLaEjki6PqCDrqk0s0fSTX8euBBGsVHCMWkrXAlcqtTNK96TapRWHQ5QuqoukaML1eHCgyeEHPGV8XhReQLxid0XZLuimCuuzc1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985609; c=relaxed/simple;
	bh=T/DqnimmqNg1hlwVomLilFseGcUlFUOn2fQG5yvijQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWCYSI6QbHUvIiM60UFbZUue3jp5+jWj5cI2oqzufrXeSoCm2PLddo3XZ8UXDB0PzxhjdYFNpJvMggH7C6Gua/upxkgCrXKWAo/+cHVkTpesg5Du5pDj0IPps9E9gsm25oRhE8ITZp9c7N9XzmVPdN0p2F/T1hpJxRLRv+7OIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+jmeyIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702E5C4CEF0;
	Thu,  4 Sep 2025 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985609;
	bh=T/DqnimmqNg1hlwVomLilFseGcUlFUOn2fQG5yvijQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+jmeyIbEV8woAPaZSKtQ8hpqIDBGsndebxBZBRiIxj75tE4tekGxc3z3n/p3XBtZ
	 RLeoAmCRPw1fOJBcLFLwsXaX+moovvpf8oyfZAcJzsumM7lxZIFAEZjosOdGA3wTjV
	 abxdgfIE+UFQWlIACop18h+oEdajxri48MAmClU+59R3mMGHB6Wjg1Gk1+TQWlUMyy
	 0QRBoTDKbLpwPIvQRB3m1Pjm1hgd6rIuhlJrNEeYXSogl5Fgy7foXJGV3UDQR0ci+z
	 Ij8f80wjQnxfwKGCoCOxsoc8c2mCgiIY5gm/Lstir/+UK/ZXPAdf5ZbQ0g0MT5SN8c
	 piVshZUPh8uCA==
Date: Thu, 4 Sep 2025 12:33:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Message-ID: <c4402946-9b76-4e1f-9a03-e5985cb023a3@sirena.org.uk>
References: <20250902-pf530x-v4-0-4727f112424e@carnegierobotics.com>
 <20250902-pf530x-v4-2-4727f112424e@carnegierobotics.com>
 <997eb50b-db3e-4c0e-be29-0d04fef73ccf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DnZTrNpTjH7ExAQo"
Content-Disposition: inline
In-Reply-To: <997eb50b-db3e-4c0e-be29-0d04fef73ccf@kernel.org>
X-Cookie: No lifeguard on duty.


--DnZTrNpTjH7ExAQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 04, 2025 at 07:44:57AM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2025 22:03, Woodrow Douglass wrote:

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,pf5300
> > +      - nxp,pf5301
> > +      - nxp,pf5302

> Still compatibility not expressed.

> Please respond to comments.

He did reply to this in the cover letter (possibly for v3?) explaining
that he couldn't understand what you are talking about, the devices have
the same register interface but differ in the rated current.  TBH I
can't really understand what the issue is either, perhaps if you could
suggest a concrete change you're looking for?

--DnZTrNpTjH7ExAQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi5eQMACgkQJNaLcl1U
h9CRyQf+NI8NKm+mTQzzGv//Sx1/jmAow9toT4Nzzcqk39hRPhkmRy3PkwvNWwOq
ogFXsF8u9CKkNk0B7Zrj1cy3GZCVbdBBFiKgIcK5zZcjGn+TL2gAQuxfq3BpyZZq
Agox2r4IdwVSLM+VTUyhbZNZ6Y9L31qnhZhfkCJFqwWotZNGobQsX6JQEU/VN42M
k7M4BVqOkNicdEigR8zHJxqGj2Va0YhtqyEJGIn1YZNwzcJ5xKz5kTfrPufRFcA6
E0LpYPVRifmUCAKtv9UwPyPGbFbAWUvvQI9mhL7/mWfs1W/WjSqNifidwUQSOZkd
VV3x9iF7SfbRU97RIRpAPsxcojOVoQ==
=hh+k
-----END PGP SIGNATURE-----

--DnZTrNpTjH7ExAQo--

