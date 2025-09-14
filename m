Return-Path: <linux-kernel+bounces-815760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE363B56ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971CA3B7753
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21511DF742;
	Sun, 14 Sep 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ5TpHsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E542DC783
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757871116; cv=none; b=nIjfLVXGuv/WljEgti0QhiZ8+ml21HmlShvg5hXR6X6jbCU6QUYGa+KRBvPLcMqfTgYmK6uG7RpzINz5iP7JLp42mfwvqbEcwHr7rnPIDQhb0SmwesdByimVUNJ/uprqEcpK27vYAIjBz0PkEf8f3PlT8gbk6NephLOiht+Uq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757871116; c=relaxed/simple;
	bh=hdAnNaYFcn9BFHppfBa/NijJQoXlrl8FDF1feJvGics=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L8dqlgOVMZotGcg+7iYs31Ao6YpwEgeLEh0EoZIJGtXxCUiY7D/ZDxw9Dvg8QXsBE6zl1YGPOQDJO3Efk17viaNv0xVsZ2re1SQkqogbfuMl8+R88nsWVPTdDK6NCJ9QHnq1FbP2HONF8OmvbW2vme7RCY2D4yAb+gQrdG6UPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ5TpHsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17100C4CEF0;
	Sun, 14 Sep 2025 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757871115;
	bh=hdAnNaYFcn9BFHppfBa/NijJQoXlrl8FDF1feJvGics=;
	h=Date:From:To:Cc:Subject:From;
	b=FZ5TpHsPWJB3Axv1rrulaQJ7gzObIPBK4gDhNAQYMgO/Pr+XeDILpQzK4Ow32YKOe
	 reAKRipUzyqbTSy/o81OXpbgq9Z0YO6qRX3MFKu+FEEbpClK6cI1H9cfcim2Zl1zIf
	 y+gY+e/5LL47TpCmnBRHM2kw2gkoeo3vDCVw7vz6JCMpy/erFRpWx6qMJFnOnIzW8T
	 30+2k2uqmuwD9qb52SyYhCXymfqe1o2Pj3JNZbr4o/914xI7O+v4EYi4aQdFZcyr4Q
	 GcbfobdEozioVloqnfQX9e4yqOz4c2Hk9p9DAsSXAxNLRrPr4vtoJFso+iq74YmRFz
	 CgT2zd/yscZfA==
Date: Sun, 14 Sep 2025 23:01:51 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy fixes for v6.17
Message-ID: <aMb8B6czM8mgaOZS@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B5a0RPlIOoHpXmq4"
Content-Disposition: inline


--B5a0RPlIOoHpXmq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive fixes for Generic phy subsystem which has few
driver fixes for this cycle.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fix-6.17

for you to fetch changes up to 6cb8c1f957f674ca20b7d7c96b1f1bb11b83b679:

  phy: qcom: qmp-pcie: Fix PHY initialization when powered down by firmware=
 (2025-09-01 22:29:20 +0530)

----------------------------------------------------------------
Generic phy driver fixes for 6.17

 - Qualcomm repeater override properties, qmp pcie bindings fix for
   clocks and initialization sequence for firmware power down case
 - Marvell comphy bindings clock and child node constraints
 - Tegra xusb device reference leaks fix
 - TI omap usb device ref leak on unbind and RGMII IS settings fix

----------------------------------------------------------------
Johan Hovold (3):
      phy: tegra: xusb: fix device and OF node leak at probe
      phy: ti: omap-usb2: fix device leak at unbind
      phy: ti-pipe3: fix device leak at unbind

Michael Walle (1):
      phy: ti: gmii-sel: Always write the RGMII ID setting

Pengyu Luo (1):
      phy: qualcomm: phy-qcom-eusb2-repeater: fix override properties

Rob Herring (Arm) (1):
      dt-bindings: phy: marvell,comphy-cp110: Fix clock and child node cons=
traints

Stephan Gerhold (1):
      phy: qcom: qmp-pcie: Fix PHY initialization when powered down by firm=
ware

Ziyue Zhang (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings

 .../bindings/phy/marvell,comphy-cp110.yaml         | 29 +++++++++----
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  4 +-
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     |  4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 25 +++++++++---
 drivers/phy/tegra/xusb-tegra210.c                  |  6 ++-
 drivers/phy/ti/phy-gmii-sel.c                      | 47 ++++++++++++++++++=
----
 drivers/phy/ti/phy-omap-usb2.c                     | 13 ++++++
 drivers/phy/ti/phy-ti-pipe3.c                      | 13 ++++++
 8 files changed, 114 insertions(+), 27 deletions(-)

--=20
~Vinod

--B5a0RPlIOoHpXmq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmjG/AcACgkQfBQHDyUj
g0dAUxAAgy/Bhf4b9zT30OZvoOW6RaeCKuoyisfOcmQYpAYXQWaXL1obbk/bKRnC
yAzf/61XsNM6drgaRhThJmf7K16jedkVA7a7A75RczaF4+bdzURL8exk1isrlHNT
+00BRoI8AwpYC95GhmUfgflB+gGEqmTPlrgUlbLTi2uxj/z/Ow3v98RA4n09yrDO
+JsKFXdNVV7sbUF2esFjQIC4/wdGaeadl2ZozCZWzrEX8hOCtlKhVtNsPxEMUUzY
d3nS6/88Kdrh5VZye+bTduJ678q6wAdOaDdZUyouZppSk/ZWbiXyQjY9UH5gQwj8
IhecLy9DQ+XulrjeCobk5IhaiLpLQrZcABQs11dUYF0fNeOiFAqIENRGDpAj1jBx
lcCVZ8DiRAPHAzonAxW8kJy9oTO1ZrC84fJeiNqQSYW00HEFTGRYDIPrccqfjByB
K8dTpNDKF4Hm/DWC8zUQTTZJ3S+szqj30hHUqvT5Kl2DfCl+JnOybCee8+lsdIBm
NPnbgOOzG1NxOXOpp/1NzXmINWsxT2PVukjS8rpLST4P6mO9CtW6NHMaJxZeiuLf
Jgy4WBf0ICVyTDcWaLdawPHjf8jiQPZ6D6Wz5xh5c5Yc18U0I7HsFPynYKB9BkRF
IK9pmtul1eNP0EWNQa7BzR7uDuZqRUfLHplvE9PL7WkUlE2/Obo=
=xAcw
-----END PGP SIGNATURE-----

--B5a0RPlIOoHpXmq4--

