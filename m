Return-Path: <linux-kernel+bounces-899109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF87C56CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5FB4EC885
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC4322768;
	Thu, 13 Nov 2025 10:15:18 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13518312831;
	Thu, 13 Nov 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028917; cv=none; b=lGafCv0fnaGeRxgCOh6311mwI26dxK5Eqyv2RXR6WsO04O3xY1mxn4n5kNCWrsbkEyRYbxbn3HElvvsNUISohxDG2AjoRX6IZMUh8dA8fFkNk8jlO61EK3A740JQp2O+TOEtRdtvwuNSg3n7CzN1nlDA5qhrbeP6tBoUNDhlWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028917; c=relaxed/simple;
	bh=BAf4PChdrXsEECboXjuWhMhLZMG7PICo2eR6NUwLSpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYTiHnK3mAbCQXnqJ37NSxhLA8i7GKDAIKiDk5zOG2kVcctTCGW/6WMhe6CgsMXvnG3LXZsNwezwv49BQQkbH5VLN/Whr8xZULkAKEHZek2/tBD5RkDf3O316Lecg6xUwZsNskhLqDrHV1/ZipAmZarAMDY0mtdyIANir+i96zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from ofsar (unknown [116.232.48.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 80DDB340861;
	Thu, 13 Nov 2025 10:15:11 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
To: soc@kernel.org
Cc: Yixun Lan <dlan@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alex Elder <elder@riscstar.com>,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V SpacemiT Devicetrees for v6.19
Date: Thu, 13 Nov 2025 18:14:50 +0800
Message-ID: <20251113180732-GYC0846694@gentoo.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Arnd,

   Please pull SpacemiT's DeviceTree changes for v6.19

Yixun Lan

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://github.com/spacemit-com/linux tags/spacemit-dt-for-6.19-1

for you to fetch changes up to 5a97a38c22799a802f33001dcb022d2942fe4a41:

  riscv: dts: spacemit: define all missing I2C controller nodes (2025-11-12 18:53:26 +0800)

----------------------------------------------------------------
RISC-V SpacemiT DT changes for 6.19

- Add Uart and I2C nodes
- Add P1 PMIC nodes
- Add MusePi Pro board support
- Add OrangePi R2S board support
- Enable eeprom for BPI-F3
- Enable QSPI on BPI-F3
- Enable Ethernet and PDMA on OrangePi RV2

----------------------------------------------------------------
Alex Elder (4):
      riscv: dts: spacemit: enable the i2c8 adapter
      riscv: dts: spacemit: define fixed regulators
      riscv: dts: spacemit: define regulator constraints
      riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3

Aurelien Jarno (3):
      riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
      riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
      riscv: dts: spacemit: add i2c aliases on BPI-F3

Hendrik Hamerlinck (1):
      riscv: dts: spacemit: add UART pinctrl combinations

Michael Opdenacker (3):
      riscv: dts: spacemit: add Ethernet and PDMA to OrangePi RV2
      dt-bindings: riscv: spacemit: Add OrangePi R2S board
      riscv: dts: spacemit: Add OrangePi R2S board device tree

Troy Mitchell (4):
      dt-bindings: riscv: spacemit: add MusePi Pro board
      riscv: dts: spacemit: add MusePi Pro board device tree
      riscv: dts: spacemit: reorder i2c2 node
      riscv: dts: spacemit: define all missing I2C controller nodes

 .../devicetree/bindings/riscv/spacemit.yaml        |   2 +
 arch/riscv/boot/dts/spacemit/Makefile              |   2 +
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    | 172 ++++++++
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  79 ++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts   |  90 ++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  52 +++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       | 465 ++++++++++++++++++++-
 arch/riscv/boot/dts/spacemit/k1.dtsi               | 122 ++++++
 8 files changed, 982 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts

