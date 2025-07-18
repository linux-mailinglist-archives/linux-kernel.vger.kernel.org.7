Return-Path: <linux-kernel+bounces-736370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195AB09C08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640D85803C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4C215798;
	Fri, 18 Jul 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+ngxBmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A8D517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822730; cv=none; b=Ze7x4CdwOnwN3s7Xigl2/u2x4xBOfq/ouT+TSNIYdb0gTlQsEaP4F1xpCFLGIO4Dlro+VIWRYR3kd/W4WXGhK+rWK0F9zuvFMaLjHp9J0zVGDeVAZD0n2SoEszaHFDtZQjouLOF58XN/a9EfsO3SwVJTkGy2bfompNAfMcKF5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822730; c=relaxed/simple;
	bh=j2ivfdeZrdVbGY3pzMRN0XewXSeaCCvqhCtAd6Ds8Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JKA2gBEZMcsQIuKetoBNczyhnqv8v8rgX3LE4QQCbCVEImhFjoE8wj3xly4S/QUPD88i78JYvLaSrGfTwgX3mZgqQUsAiCjI26Ijf31KmIhp2/gCtgwdaqSIvkQO2cYEwFaWkb2j+b/JrgCYHzCWOlKXFlxUgL8Nz+M+zuuhSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+ngxBmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A0C4CEED;
	Fri, 18 Jul 2025 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752822730;
	bh=j2ivfdeZrdVbGY3pzMRN0XewXSeaCCvqhCtAd6Ds8Tw=;
	h=Date:From:To:Cc:Subject:From;
	b=d+ngxBmRbn/7EhhkU2rQPyyVCS/V9U9sf+xyy3IwdREaOsqLkJsDko0KO0pz2xDA1
	 AeonJquJCgyAD8YcUeR1HSxUFuMYhLyfrFk8Z29LUbM4JAzUY3GAFk9PGSlglbyv5/
	 +PzT8oVul5NUeWJK6TSXfUGxmB49GGfZoh/13rZRnIAHyW3xAsrIfIomP3+b1cHnM1
	 WJh0aAHcNIfvbFd0RaNh9KuIyCheapmc7W/MVGLLq2HHue+3ZQF0ylQI6j7st7cTSn
	 xwGBDw62Dqizq0qWqg8azPq8wQpCgPM8C8Y1tFynmAEH1l6r8aSJRIiIEorSBMpDk5
	 LGTscGAz4xyNw==
Date: Fri, 18 Jul 2025 12:42:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.16
Message-ID: <aHnzxqKFj1jgxG_v@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eV90A6LMnpFovRAy"
Content-Disposition: inline


--eV90A6LMnpFovRAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull for generic phy subsystem fixes for v6.16 which contain core
lockdep fix and couple of tegra driver fixes and a qualcomm driver fix

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fix-6.16

for you to fetch changes up to b7acfeab8af9ee661c933522132f3d1d92ed12d6:

  phy: qcom: fix error code in snps_eusb2_hsphy_probe() (2025-07-15 20:36:4=
7 +0530)

----------------------------------------------------------------
Generic phy fixes for 6.16

- Core: use per-PHY lockdep keys, this was required to fix a phy
  using internal phys
- Drivers:
	- tegra - fixes for unbalanced regulator, decouple pad
	calibration fix, and disabling periodic updates
	- qualcomm - error code fix for driver probe

----------------------------------------------------------------
Dmitry Baryshkov (1):
      phy: use per-PHY lockdep keys

Haotien Hsu (1):
      phy: tegra: xusb: Disable periodic tracking on Tegra234

Harshit Mogalapalli (1):
      phy: qcom: fix error code in snps_eusb2_hsphy_probe()

Wayne Chang (2):
      phy: tegra: xusb: Decouple CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mo=
de
      phy: tegra: xusb: Fix unbalanced regulator disable in UTMI PHY mode

 drivers/phy/phy-core.c            |  5 ++-
 drivers/phy/phy-snps-eusb2.c      |  6 ++-
 drivers/phy/tegra/xusb-tegra186.c | 77 ++++++++++++++++++++++++-----------=
----
 drivers/phy/tegra/xusb.h          |  1 +
 include/linux/phy/phy.h           |  2 +
 5 files changed, 58 insertions(+), 33 deletions(-)

--=20
~Vinod

--eV90A6LMnpFovRAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmh588YACgkQfBQHDyUj
g0ezbw//V3u/pWgWfnTnC8uKN3nLU1lZUwwM1wya3jP5xktHaYPJjnC7SGUYPg+t
dtSdgPQJLdvA5U2DlVkIwxzB8IQc3ORXL9hZergZ2/1QMVWX75JMxC+D0pvYBDxG
v4SBENDXPc1dgT4DT3I5qgOw9/K6NCGtK5+7T+v8vD87+BOj1AGicvKyJ8TQf+UQ
MRrbjb2me7sPrFuT41NGSnAWHqza04Lu3R6ik3dgVbXFwVE4xIKwNaCAlbkRmj9B
eM9r7P+HfB1MYphVxNF6wlUF7WH+lZFVtdsAPvu0n1YsEsDznV6WGYLL3/QYx882
oQmIlYt9gc39rxu0Lpd1Nrew52Ejm2O50txbqX/cBY8PfnAIyG3ikGpcEYkvXeuK
80Ghl3Mjp9GdkdU+bvy5u0HT0J6OE7lfH2/WKIZjM8Dj+ZdqZT67q+3MCNZmY1i1
ZQHNXOMKqk3b/JnE6nvot0BWVT9KBzp3SY4xAIwZ6GwL9M+88MxV18ECDqWj4c0Z
uC2Oc2Q3QUdl63OJF05TVBt0ZCMcK32/JoqvPrINFbFAwvfipDWQSl10PlvJUa3p
OsJu+DdotoNnEUEB5YpIEcAiyQKZ6E8qOfNuQWOpbHH71v3QyH3zKykkVo04MUFY
9KXbddOpersu9P2SH0vV38Ct+N+0VpZtkl5644I/WQ7YBjd037U=
=TBGB
-----END PGP SIGNATURE-----

--eV90A6LMnpFovRAy--

