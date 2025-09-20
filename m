Return-Path: <linux-kernel+bounces-825873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84AB8D006
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DECC7AA287
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D0265609;
	Sat, 20 Sep 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXdl/hKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20923D7E4;
	Sat, 20 Sep 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398292; cv=none; b=KvqfluMZunATd1K1ySr5a0TqWZl3gFuoGupdGLOzW3Mr7vZOTa3imVkar6EiPBDDsVnMh40s6G43aZBQm2C4SN3fFsTLmyoeSx/8Dbg7w1CuhEJAECiOx0M93AuB2ebePbpHkG0VoJqrMX8XqJv+kq3kbiPJ24uO/ofsXn+DVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398292; c=relaxed/simple;
	bh=CLvA819j+is4IEZ2FUAJfUZM9LMPtSS6cK9O3wuhO88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3juqWqf36Boxsma2y23OZ2fZlJPc/8EvqoW99q6SMBXDTTMDjlsa6kM97iWupw6r4olZBX589LJ/KiB680FF5mP3sX8osAwyyoHQYTs9BVR9NUVprzdgaqfu6+TIeRWq2OQqOPp6/kcqOU6p+a2uVtl/Zd36Li1g3DB4ynf2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXdl/hKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ECEC4CEEB;
	Sat, 20 Sep 2025 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398292;
	bh=CLvA819j+is4IEZ2FUAJfUZM9LMPtSS6cK9O3wuhO88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXdl/hKs2ZhNtKOsnPvpQzrtS5Oyfm2yb/VUyA6vEw1vPaRybw13APP6Y4Ld4uLP+
	 pUdbQPtFI3NIAdu7SYKKx46HyG7XCK7atXvtGTFQnrmGYWF0KCD/9NpADHPA7gmYpk
	 m5viqmI4IKOPMevBG8Ka5ZVbBU2foYMBBXcVf9WuF3Sw2p9AXzbPUUu5pIDdfrVK2F
	 AHIABj2qdl++tPcIpZqqbI6AOVdxprbWu4l8EBX38HsVp1X7fyk11pTcWMVp3a9Lya
	 YX0nMATWbLDTxORhx8GTIIyOLLAeEJJmUpU9vw4ApitoYPp1W1dX5OUhSniETLubGE
	 2GrPPWDmO78mQ==
Date: Sat, 20 Sep 2025 20:58:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: jdelvare@suse.com, linux@roeck-us.net, lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH RFC 1/2] hwmon: (sy7636a) fix races during probe of mfd
 subdevices
Message-ID: <79aa98fe-b9b6-4210-a556-d33863f0129a@sirena.org.uk>
References: <20250920114311.291450-1-andreas@kemnade.info>
 <20250920114311.291450-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzDHECRkk7792VgO"
Content-Disposition: inline
In-Reply-To: <20250920114311.291450-2-andreas@kemnade.info>
X-Cookie: BARBARA STANWYCK makes me nervous!!


--kzDHECRkk7792VgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 01:43:10PM +0200, Andreas Kemnade wrote:
> If regulator subdevice is not ready early enough, devm_regulator_get will
> get a dummy regulator device, not the real one needed from the regulator
> subdevice, so defer probe in such case.
> devm_regulator_get_optional returns an error in that case.
>=20
> That fixes things, but looks odd, therefore RFC.

No, this is buggy and broken.  You should only use _optional for
supplies that are optional, the clue is in the name.  You need to fix
whatever is causing the device to be instantiated to ensure that the
regulators for the device are described before it tries to instnatiate
the device.  Normally this is all part of a unified firmware
description.

--kzDHECRkk7792VgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjPB04ACgkQJNaLcl1U
h9C6bAf/WAIH3KuIxtj5OGgN29IhsUiwDbCnzWB61Bu/bgXSmc+LmlxBct4JjBhf
XlU0kOzdXLWQOt2Ey9yWwu2u5V8FfAjZNwoCZjHYMJBRpJ5n5tHw2YnCYX2mcVZk
u58bCHUqEYXZTIoCjW+Pg3AUeikeuhvQ+2nNr4UfBUcysNAlQX8McznYTbURS492
hoUUfCr1DRVmm/fYq7s/2oZSMkcKYATiQlT19flslNN0xNnBKwXQ7kOkAtQgANS8
2W76WcCsv9Mv0SoM607hhxmg9pKy4Mv1wXZlFl/tk6B+LuAJWMUWH+nq7604KScp
eXfusclLqBsMzGgEGcZGpb2wWGiAUw==
=nXYy
-----END PGP SIGNATURE-----

--kzDHECRkk7792VgO--

