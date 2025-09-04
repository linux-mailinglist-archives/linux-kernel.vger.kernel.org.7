Return-Path: <linux-kernel+bounces-800425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D014DB43779
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DDA7AE381
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410802F60DD;
	Thu,  4 Sep 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Bd1UXp99"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E32DF6E9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979239; cv=none; b=Eiiq/rIX9ELkmqmZNSlU4a4v5pBq+l5QcS5du5F4fSgSEE6l3EXYmcNEBzqWc+Oop0a+xsSH6oVB1aTWjxfFa6jExC1G5dHJedSqLGlY8vjNmnkXi8e2Bcmz1GwAAGKoB0e3+b4mqcH3ieSXEpNb2E6vOsp6pGRIFOwwVKvS2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979239; c=relaxed/simple;
	bh=Co1V1iVYZyrAxYVz64uRvth7glMtN+0ZaCCb7K2hm94=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n7VP1UEvtjRAcrhTdv696L9eQTrxtjeldCM7yFNI+iy2SE74jsNVFF8tZViT4UdhHHODHEEbb6F9BhulzCzmIPJYsRXLN/FhBZ+OI4fGqZEVTVeEQKsFBdKuGiWP9RUZcZTtGrsM7fB/r/+KcEIt8VdC5pg1S0n4OywTVMWITJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Bd1UXp99; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:mime-version:content-type; s=k1; bh=Z94ywxLihlP5imbl3FU1jjKwYYC
	zYT7fwycWOKoAX7s=; b=Bd1UXp993IfnsYG251n/negH7uTJHbLI7dgi/rjn/GN
	IUjLMOu0lewDU5/rZkpfTVRSS9HaYcNK3hg6A+ounw3N2mcIv6VKBdNHMKQhdiS1
	Ima1sNLahAkVTCVRx55o+IjehFgMi78M8wyGnmOFeNrPB/a/Ed0Sz/oEQsev/XYB
	IbEyG+bCugWaXGS5hi3cEvmpNF3mOU2E2P+R72trHgstDImBXK/mg9N3ycvzwX+s
	lE7wWbv9Q2UEzOwcUrSIUPSRc169/wDs9osF7OM4A8midxD1pfRnjP1Jgv1btyCc
	+dpkymv9Z4c3QYn6RcHfn9W9zJjNtu1tm2nDpjDP2vA==
Received: (qmail 3617510 invoked from network); 4 Sep 2025 11:47:06 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Sep 2025 11:47:06 +0200
X-UD-Smtp-Session: l3s3148p1@vUWhmvY9xC5tKPNb
Date: Thu, 4 Sep 2025 11:47:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: soc@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PULL REQUEST RESEND] i2c-gpio-fixes-for-6.18
Message-ID: <aLlgGdrFEjh26knK@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FVwHWn2AG0eyJRbl"
Content-Disposition: inline


--FVwHWn2AG0eyJRbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

this is a resend because I used an old address for the SoC mailing list.
Sorry for the noise!

Happy hacking,

   Wolfram


The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-gpio-fixes-for-6.18

for you to fetch changes up to ed8c952aee4183ac866a83397e12ceb99493c6ad:

  ARM: dts: stm32: use recent scl/sda gpio bindings (2025-08-28 12:33:26 +0200)

----------------------------------------------------------------
i2c-gpio-fixes-for-6.18

We have dedictaded bindings for scl/sda nowadays. Switch away from the
deprecated plain 'gpios' property.

----------------------------------------------------------------
Wolfram Sang (2):
      ARM: dts: cirrus: ep7211: use recent scl/sda gpio bindings
      ARM: dts: stm32: use recent scl/sda gpio bindings


with much appreciated quality assurance from
----------------------------------------------------------------
Linus Walleij (2):
      (Rev.) ARM: dts: stm32: use recent scl/sda gpio bindings
      (Rev.) ARM: dts: cirrus: ep7211: use recent scl/sda gpio bindings

 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts | 4 ++--
 arch/arm/boot/dts/st/ste-nomadik-s8815.dts  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--FVwHWn2AG0eyJRbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmi5YBkACgkQFA3kzBSg
Kbag2hAAqxotRdcs2jDfUxL9ubnQ3k/TfkhqOEeU1mI7gF/zyC/egI96lb496+F6
Z4eatokRljKjTBvsfZefc8ppw+/JipizoFqZNSyqWeAMj3dXpFTh3KXkIBo7zRxl
mGcHl5hYkFiR2E+EuCPvMP+CudsqnkWPOMT23JDsWquEmfC+zGEjFbUpx/d1MlPW
sbsYvlY7Jep5WcNDwjgHVejf+XEnZNgsJnbmZUPuNhyFVXLQOQQheRqV/GyoQthn
UFQYBQt9ZL/lbR+timthvUuXP+6CGcdeVNk1AzO0DBjNbbyV4UweCiM8KaLFSRa0
WlOQUSg1sQh2ZPcZ2UURyt1NpvhefA8sw6K7NZZwXn7irkY2skmesElwSfZWcePH
+7wBwlZN+B6U3Lx18oWCrp6TkQhhBkSXpNhXbYSFttOmgsE8iBFPasfwarX1E6A+
epiPhWLYR+MvamKftL+A5EdA1m3JL2fZcslNQlrdxWC+xMag4+hNzWRvjsVuI58f
r7EP1IejZ8YZSljzXS/U+onzO7AGoFB3Uktk2r7/ztCW9t9ejEAWpEl92HJVnxyf
0lr+ZEwAtX9SH0b4D2Bk/QWxBN9k1Es/FtqnCjTsvcK4DiTaz29zYdWQyL+xmBtW
UblRFgKUZvJ9UCeYC00A+oDPOCVudy4G1FXgTDwANfFt6SRdd+k=
=1Vdc
-----END PGP SIGNATURE-----

--FVwHWn2AG0eyJRbl--

