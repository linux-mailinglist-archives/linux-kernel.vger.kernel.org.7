Return-Path: <linux-kernel+bounces-736368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E3B09C00
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36913AA11B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F32215043;
	Fri, 18 Jul 2025 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox5vPWEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47ED517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822611; cv=none; b=J/XrR2RpNZSjbreacHz86gXG39CldStNgL5UUe+2VcP8HfJrtv6P4F/31vEJX+zp/ZW9eG4vNHmz/Cf6R9SAJek95C4DTBoerwsw+/QaxIjkKnei6gPBmrCJl9zRlGYT0T2cHfQIJgi85v3wc2WbDt0pY4M8+4JnT8/rDbUUpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822611; c=relaxed/simple;
	bh=kbN0F0OWDcFkoeEYXmh7ETjat0hD1UCnG+I2D+LMyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jAlgb6BxTOVu00sclCi2vUP+N4VeqI7Nf0w7kuPuWjwaPR6gmyFeCdWWDglB19n8A1LeXOURPl7wvlg55qa9O+tJ80lx/r51jAO5tGwtVz++fHEGevjMX+/6/bDCP5ECBBMPtlrKo1pK8OQpgCum/aSOjArjM1TblHsAc0e93fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox5vPWEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1345C4CEF0;
	Fri, 18 Jul 2025 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752822610;
	bh=kbN0F0OWDcFkoeEYXmh7ETjat0hD1UCnG+I2D+LMyjE=;
	h=Date:From:To:Cc:Subject:From;
	b=ox5vPWEhcp2Z7ShOjJknHsXAkuxBrDVD69XfuQZXPt2hKG4Knbx2+Ko9VdRbfllPy
	 SeVYkEdcQICWhel2rUyZDFWKVtOyJ1fmuwDEqiN+4v6gIEd8U/hOOLCWXAl9Wnfxfn
	 CyUL1mfFqDFcXpNOLpyEsHEyRETLrRcZmEU8gQJoviYgXNx7fMn9Soib5QD52y2wk2
	 W9Ydo6kZJ8XSMJy715ohbam+3KUQfCBEFCv2MIVRR5BDdkng4DT32Cnlo9Pcr4TFsW
	 Lz6+6lhilQsRElY2s5a+fDHBis9ZTvL8DELJFE+H1w2qrLepVvsM5LkufH75IYiclF
	 Ek4VzjiUKFwlw==
Date: Fri, 18 Jul 2025 12:40:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.16
Message-ID: <aHnzTit-z6NErlsL@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CRJV3rwhctnAK5UQ"
Content-Disposition: inline


--CRJV3rwhctnAK5UQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull couple of driver fixes for dmaengine subsystem for v6.16.
This one contains fixes for mediatex, nbpfaxi and edma driver fixes.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.16

for you to fetch changes up to 3df63fa8f2afd051848e37ef1b8299dee28d4f87:

  dma: dw-edma: Fix build warning in dw_edma_pcie_probe() (2025-07-15 20:41=
:49 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.16

Couple of driver fixes for:
 - Mediatek flag reuse error fix
 - Array overbound fix for nbpfaxi
 - Frame size warning in driver probe

----------------------------------------------------------------
Abinash Singh (1):
      dma: dw-edma: Fix build warning in dw_edma_pcie_probe()

Dan Carpenter (1):
      dmaengine: nbpfaxi: Fix memory corruption in probe()

Qiu-ji Chen (1):
      dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()

 drivers/dma/dw-edma/dw-edma-pcie.c | 60 ++++++++++++++++++++--------------=
----
 drivers/dma/mediatek/mtk-cqdma.c   |  4 +--
 drivers/dma/nbpfaxi.c              | 11 ++++---
 3 files changed, 39 insertions(+), 36 deletions(-)

--=20
~Vinod

--CRJV3rwhctnAK5UQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmh5804ACgkQfBQHDyUj
g0e6CxAA1gOH0bY6P1yF+7Y2Z3lEKXTSS7sNZ39wLuWiZf2w7hdS9TddWQRDsPFP
C5aZLO8Ilfk3e5C0hjkM5kw142WYzl3VcHrjzLo23o1u3tjW1+Oicm0hfSMZ1sUF
SrMSpHVgD5MLPz8ktXGIufi0nYkA5vFfWtSuHd4/uA5z8jeNLP1kc0FdRprPEibC
1SPAK5gl/JcrHXkkYrg2WeD+2t9iDsaPSmHASUHpq5a8FZoV6K0Ds2xvCnwdkAxs
XzPZY4pM8nmDv6dfhjUzRBVBB0gGCN6affaUmxUnovZ/jDavMtgorjU1Tz2CeF4n
k8faAdOeQ3HgyURHxLzCIrgiK0TlzPgGwQUV39/edTTgJiMTGm9833g2PBlWL1O7
jMKHmuFPTj5NWUApae267I7r+6ytAkxqmjVUr2sSRo0HMaL2TYHkjpwHF1k04dRx
fl5J+hJ10qnZINU5MMos0wMzx7nqXeEA0lHp9JYQh5viSEXS31Vh5GWsPD4kMhq0
4SSt/0aYbw+O+abR2Q9xdHOQwB1+TZPX24YkMZ8nN1FQV+pfjb5zPENjTsiGswGM
6EtNhCnRu8jms9TTCiT2PmB8Hdb93FkyPSpjdclZ/vc7BNgnUCJiE5dsSGXv3c9n
pBKAuBV1QveiehYU5oSbdAlyzlEv32J8YcYI38rHKTIomXyeZ24=
=sjB7
-----END PGP SIGNATURE-----

--CRJV3rwhctnAK5UQ--

