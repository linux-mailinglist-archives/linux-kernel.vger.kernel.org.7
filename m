Return-Path: <linux-kernel+bounces-662255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4EAC37C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 03:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEADC3A847B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 01:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607FE13B298;
	Mon, 26 May 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s2Uz9F/B"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E98BEE;
	Mon, 26 May 2025 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223809; cv=none; b=U3zxZoN2L0MHptAsIigN6cicsdm/mvRrzgMEN4Y5WH+OHbTFgC1ZBNxk9JW+pvRJ+tZ2jY9uKuPW4MLAWi176l5TREgHNF9aECrF9BcqBi4FMd0kV3hqxgo5/p9bLcqFx6zCiu6Tv8ikERNUxmSVDWhAoZPsjQUMRalX+V/awkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223809; c=relaxed/simple;
	bh=LLzuF6atmoLAtdgeB97udFx8tGNSqJglLQfkQHOx55c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NKm1dw6/QvapmBiDJ2bZUiwd7KKBg02F0vr/k3S2b+TrSYSxkA2Uq1e2v2hM75o2kSFN19/TUjuboekmI70ANfMYdB5jz3IEgBik1J0/ehtm5BaVodwfKzU3pPeIv8HrRq+QPXZza+D9gHieLoLAK2JslnznJJrRdll+Mei75KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=s2Uz9F/B; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1748223797;
	bh=GukcE8YDOVhu/U89crmZAPYL47oVpM/EXOi3tA0x4PU=;
	h=Date:From:To:Cc:Subject:From;
	b=s2Uz9F/BDlYG0QINDL3oZyFzqlTJkLKgBZflv3BbqtVlDxZQhRRz9YLFSYRpTCo6x
	 wHdXqFde9haGGa/fzhyM4hiV2uHPyP6uSFCFG0LhkfjkfqkydfT6nTl6Io9Q0lGcMX
	 WOvqNsPmJmyRucilFgLadJyrdj1tnguyiChab9Mgwr7/M1p2DrRuwXzVLZwjazDkJH
	 AI+7OQmZN41IgCfisNejRa9ljS0FpXtDozouGftsx6qolBNf/c/WI0sc96khrOwmOB
	 AhZuBH+oZzRc6CNq4Jpxxsy2JWjts2hZscIMhDa+t2IC9+8mvDGL5mh7Hq3JBP+YWn
	 4Sis7K0tDVI8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4b5JSP0QNPz4wcT;
	Mon, 26 May 2025 11:43:17 +1000 (AEST)
Date: Mon, 26 May 2025 11:43:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c-host tree
Message-ID: <20250526114315.733b0728@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j6f.eH.17RndcIjLbnsHMiZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j6f.eH.17RndcIjLbnsHMiZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the i2c tree as different commits
(but the same patches):

  a088ce22c118 ("i2c: mlxbf: avoid 64-bit division")
  50f317545149 ("i2c: viai2c-wmt: Replace dev_err() with dev_err_probe() in=
 probe function")
  608e2d633096 ("i2c: designware: Don't warn about missing get_clk_rate_khz=
")
  481391b537bb ("i2c: designware: Invoke runtime suspend on quick slave re-=
registration")
  736f258f0a9b ("i2c-mlxbf: Improve I2C bus timing configuration")
  a1a8ccd53458 ("i2c-mlxbf: Add repeated start condition support")
  c43383e2ffa4 ("i2c: xgene-slimpro: Replace dev_err() with dev_err_probe()=
 in probe function")
  3887d3f64260 ("dt-bindings: i2c: i2c-wmt: Convert to YAML")
  66234d6c7157 ("i2c: microchip-corei2c: add smbus support")
  55d144eaea36 ("i2c: mlxbf: Allow build with COMPILE_TEST")
  52360f31e6ba ("i2c: I2C_DESIGNWARE_AMDISP should depend on DRM_AMD_ISP")

These are commits

  2b2805404c92 ("i2c: mlxbf: avoid 64-bit division")
  3b7d8d151a7e ("i2c: viai2c-wmt: Replace dev_err() with dev_err_probe() in=
 probe function")
  bdf4442f4c7e ("i2c: designware: Don't warn about missing get_clk_rate_khz=
")
  2fe2b969d911 ("i2c: designware: Invoke runtime suspend on quick slave re-=
registration")
  e981364d89bf ("i2c-mlxbf: Improve I2C bus timing configuration")
  6bdc662c05c5 ("i2c-mlxbf: Add repeated start condition support")
  24d9f6050520 ("i2c: xgene-slimpro: Replace dev_err() with dev_err_probe()=
 in probe function")
  29b0b4ce6417 ("dt-bindings: i2c: i2c-wmt: Convert to YAML")
  d6ceb4053826 ("i2c: microchip-corei2c: add smbus support")
  053859002c20 ("i2c: mlxbf: Allow build with COMPILE_TEST")
  66e64b457c23 ("i2c: I2C_DESIGNWARE_AMDISP should depend on DRM_AMD_ISP")

in the i2c tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/j6f.eH.17RndcIjLbnsHMiZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgzxzQACgkQAVBC80lX
0GzM2gf/WR2etlL0RFcGOhBDs61K9XusaY3h63EUSPa9rmKYH7f3ZWjl2t6tQweU
SeB6BCxlludWnmGhfd0rXwXV+20nFJxLrcFZsv/7onOJArCf6oOg+kBEZ+QeuCVo
qCxargOIiehPVjmEU4GPGb/fKCsirl1PzwQvLWY5nhoF5KG5sGZHkfgAsnGvLBHc
M5+GYEc6+KqcpSwoK650miOEdOtHi9d+jF96YlCDlrvU9H3nEa5hFavQi1S3EnS3
9LM4JaC9MqZ4ToI8tx5WakSJorBtMIyXLbz+AzdINu4ShSRpepSuK/n4Wq3gUgN9
jgs0p30SSKdUhw3gsFM7SIrc6ZvlBw==
=cWka
-----END PGP SIGNATURE-----

--Sig_/j6f.eH.17RndcIjLbnsHMiZ--

