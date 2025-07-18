Return-Path: <linux-kernel+bounces-736364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6AFB09BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61E21C272F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336F213E66;
	Fri, 18 Jul 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ5MGl/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4074D517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822464; cv=none; b=dS9eCdj/KJTZVa4zZpBaHrMxcvl4kbOS3Oz2cfMW8VRfnGNPc9PdbpgNhSy/g/xh+q//vBd2Un6TPbLX0JnAKaq6ATzvBzUzCwJ+FmiMFYDbauLW66m3y2bEfuAcQoGtEoHU/fV62T4/9o9NRza7pIgXtPqeffPhxATAnDJHnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822464; c=relaxed/simple;
	bh=qwSX/r4/Qms4nX6Zjonks/2RfVDwF2//gWuEt1ENQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fLaN1v8Lxx2as6ApgVLoeAVo4HuxBc+RxetVAQeW+1ARb3Wn++UlBUi6QqvcG9+3n1eu+Fd3y9sm1wNbOYoKoV2ffBU/dde1pnoKZd1nBQhd1RF5ZmaaWYILAvlMaWW641uNSRq1/6NmIJxm3eztYClyWrCVBmkMwL+ClNpgFSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ5MGl/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54FFC4CEF0;
	Fri, 18 Jul 2025 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752822464;
	bh=qwSX/r4/Qms4nX6Zjonks/2RfVDwF2//gWuEt1ENQxM=;
	h=Date:From:To:Cc:Subject:From;
	b=kJ5MGl/6I0xfx8dZDxIVqaAYm6rG25fFTCsVmCDHnSVY6T2VHVpuruUiQGiiyXtwA
	 /HCRQaDL76qEAYe/BJbsj6FYpBocNAH8yeURpFvM/kDsRCywQX73s/nPIw2K88WeHh
	 RJFRhHTX3NXHrvLROwoaLZ8gYtRQnGT8PyvhiU8/nlzqnnFuBFHBjJ9XBpkRU4GeG4
	 7MU9Jwzd9J2zJ6feechzklMW1CC00JRaCjMOF8Tg4+1kdIP/zy/8ATEXRkQuJh7Pis
	 /Ud1V6WV8iJw+RtPJyzEIdIT3nBVuI1ArNxNmi4dgarw4RMOmSdxnmDmDYXwjP8z6b
	 uqnPE8f0o+ZFA==
Date: Fri, 18 Jul 2025 12:37:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire fixes for v6.16
Message-ID: <aHnyvOQxBkGTGpXF@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eE79P5Ds7A7Fulan"
Content-Disposition: inline


--eE79P5Ds7A7Fulan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull couple of driver fixes for soundwire subsystem for v6.16

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.16-fixes

for you to fetch changes up to 834bce6a715ae9a9c4dce7892454a19adf22b013:

  soundwire: Revert "soundwire: qcom: Add set_channel_map api support" (202=
5-07-15 18:16:27 +0530)

----------------------------------------------------------------
soundwire fixes for v6.16

This contains couple of amd driver fixes for handles alerts when link is
down and cmd status register clear up. Also revert of qualcomm driver
channel map support due to regression observed.

----------------------------------------------------------------
Amit Pundir (1):
      soundwire: Revert "soundwire: qcom: Add set_channel_map api support"

Vijendar Mukunda (2):
      soundwire: amd: fix for handling slave alerts after link is down
      soundwire: amd: fix for clearing command status register

 drivers/soundwire/amd_manager.c |  4 +++-
 drivers/soundwire/qcom.c        | 26 --------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

--=20
~Vinod

--eE79P5Ds7A7Fulan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmh58rwACgkQfBQHDyUj
g0fE0hAApcah5zql+3MwzvVbHSNi4FtsD/a+F5a36bfaq0szODfrNn6DhS9TSGR7
WEiemLQUbrrSkbyptMebJI5QC12GdZxBioP/nrHg2T2r6etZ9iVY1VS4to6c0Ns1
h8SJcutkinbPcNMvYYrMWHlURtdhWCv5qhcUexNxI3yUvoPyC3KCgnnxYqiLazra
mFx2X/Uh7GLXWuvKOIxaJYFi1u2VIMELB81CETAKqOJzzIOkcajBCWFsPm+dslmX
tlX9+Lls+48f0PxSfa0DXEs1lmRRB0uXQ7A58dmd4tPoSbRN4CAsKhz9329VCTPs
NnBJrP10GTgZxW2UgXgY2aN8YJChGiXSxuSS2/T2unjFCVIIQUxbm1le+y/Xcapy
z4qk/NiWyRHcl3D4gylMZMdD3jaYLO7wk3M/LFMNRDkAheYTJu1Dg92VKROifMcd
sbMt/xGIZvYu8yuT89WxJ+mVHOgVON7XcYcfsLzLBuUiq/IM2wvYiX5n1IC2jUOJ
tie4zd8CEz0zbzLRsvsmDc5h6QBJXbJqkJoeymRFzWLRfAS5BHNLMNFUrYB9OYw0
MgU3J2i1fu1hmOn9gQ9tmm02pBl3e9P+2d1VrRc2LzDCZ8z/KCo5xn3IQTKXgfDa
mMUG43iDDkeeDLYavFKZqKLG4KBUSl4At/zpHtpblNksHcbDgq8=
=NCP3
-----END PGP SIGNATURE-----

--eE79P5Ds7A7Fulan--

