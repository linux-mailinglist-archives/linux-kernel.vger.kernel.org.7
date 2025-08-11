Return-Path: <linux-kernel+bounces-762681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5BB209A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E179D3AB621
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D752DAFDD;
	Mon, 11 Aug 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPRtyiMn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC82D97BB;
	Mon, 11 Aug 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917701; cv=none; b=gUkFdMkdOxc23saMM9ngwWR2KmEZgxBcIVFLZHKAvLNtzlmLEHpCVHc9vWT1CiVTQa3IhEsESORC/ZbAJDqN101Hoga+kG4erxFQJZqOHhatMM74+G8Jyhb5aXRr3H2pfWL72MWk7oGp3441Nxatbz+yjfEEmtpCUJLa1J13Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917701; c=relaxed/simple;
	bh=/d1KfM733xo3R+3/FrFqcjdaajI0/o+yoPMVuCUOk6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClUzCgmmaiOG87XOcWNnxrBWN0OpQAVHMAL4JPA7kOgRllRXqklUIykTfy4L4+FauF7RJ8/TkZBpxBaNjUbaCUMlmYfIJPP+X+igCcmPZCjfnWt72+GzY7zgVnoBu8sN7WnVd8so1eA9Klnlf2CQP5hTqZPRrrvHskH4HRQRFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPRtyiMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634DEC4CEED;
	Mon, 11 Aug 2025 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754917700;
	bh=/d1KfM733xo3R+3/FrFqcjdaajI0/o+yoPMVuCUOk6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPRtyiMn+3F/Jo9S3Zc3bMjLlAPmm6JKZq9yO9a5IHU3W5CJn/fZ5m4o+Ys9UJpqv
	 CsVa8g3eBqX3KxEbeB7aDeVHM3xWRHnnC2knCTcCJ24rA7k7WzShKoGFV7l/9Cwz4r
	 Oif5brJ6Oq2MhvsFHT/RWM8223Jo5Bh+z2YqDgvMIJm7wijPaDEdCiK+tu4YjEXN7m
	 Cv8e40ogPmQD+Ec7U0BS2CQ/Sx1AHkqkQ3y+FyiuX1sjRv4uWFMf+PpTkMAaQBaFXS
	 T+oQFAyqAXpgwyplQGZtKcHfc2D1yzStOSZICf/oOoaI8JLNMKYBjDeeI26/jssK/7
	 da/IMSUNrZJ+Q==
Date: Mon, 11 Aug 2025 14:08:16 +0100
From: Mark Brown <broonie@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] regulator: rt5133: Add RT5133 PMIC regulator
 Support
Message-ID: <421d5c9c-bf2c-40d4-b8da-cbfc19d60ff5@sirena.org.uk>
References: <20250731031701.2832994-1-jeff_chang@richtek.com>
 <20250731031701.2832994-2-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Jcc0h44nmsTmYGk"
Content-Disposition: inline
In-Reply-To: <20250731031701.2832994-2-jeff_chang@richtek.com>
X-Cookie: I've Been Moved!


--6Jcc0h44nmsTmYGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 11:15:32AM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>=20
> RT5133 is a highly-integrated chip. It includes 8 LDOs and 3 GPOs that can
> be used to drive output high/low purpose. The dependency of the GPO block=
 is
> internally LDO1 Voltage.

This breaks an allmodconfig build:

/build/stage/linux/drivers/regulator/rt5133-regulator.c:605:15: error: inco=
mpati
ble function pointer types assigning to 'int (*)(struct gpio_chip *, unsign=
ed in
t, int)' from 'void (struct gpio_chip *, unsigned int, int)' [-Wincompatibl=
e-fun
ction-pointer-types]
  605 |         priv->gc.set =3D rt5133_gpio_set;
      |                      ^ ~~~~~~~~~~~~~~~
1 error generated.

--6Jcc0h44nmsTmYGk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiZ6z8ACgkQJNaLcl1U
h9DNDgf+ONNkMu5C/QmIBqU3avkdCADf9UaCI3COdNjFMnfbqth+im53Y3aMVa7D
vqYHcuv7smBjrtpSSpxQWo0rStW91PYVSGIqCxl3oSbabebQkfcD+p73LUQzWbJW
e9rptuu3xK3XCDRCvfTicuWRREJW7UnWf9tqtJcszkOKeL0eFOh1gTnio70KZgle
t8oSCpsTuV2uCBLa2EbO0NF4j1xLPgJXRTWMObFTUeCBX69eAC7XKyGaKjAk8UTs
uMrUvcb7PWgP1n/KW/aw5uJay8vaoMIcn0Ffk2xgyeAodVuu1c1oOsqJGZ5RYKOq
dYlpL6pp7DTTsvN5L7Tph0j6zwKmOQ==
=cKnQ
-----END PGP SIGNATURE-----

--6Jcc0h44nmsTmYGk--

