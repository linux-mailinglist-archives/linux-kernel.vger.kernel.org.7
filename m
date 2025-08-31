Return-Path: <linux-kernel+bounces-793592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C1B3D5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2E8176421
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676023F26A;
	Sun, 31 Aug 2025 23:01:26 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9DA30CD95;
	Sun, 31 Aug 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681285; cv=none; b=dMqFLsbV4jwjTy8wDZTmyu2DBjd7vtw0yf0QCTlF83W91sEfZEPIWgNCNRkY+CefQHFsaLQ7sGGcOZVFLe1PsCrzg2eytIHX9yE7UJiFaW1H8VHjQaIv9LpKtgmQwidCuwtwco2UVpDnhZlexjYCXVzumnVRpw4Vfybf6R2bFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681285; c=relaxed/simple;
	bh=1tTe8YmZa/v+Z+dzIJlkYyauIExqf8tzO6l+kXXc3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TeqzRPJ3dWae4MLbwxT9CWQLf/KLyW8oPeNC/cPE5jE0KMV/jlNnWPn2YHSsjJN53Llm6xvC7h1o0TwnAViPO2fd+hER0U6YSTCpOzl1TZdlDSsE6loAXEZhYd/PNVlQenHlJEcOLUF/ZJinKONZ6ZgirkhnMEWllJSYFRHV/eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 89222B2200E7;
	Mon,  1 Sep 2025 01:01:12 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 0/5] riscv: dts: starfive: Add Milk-V Mars CM (Lite) SoM
Date: Sun, 31 Aug 2025 15:59:25 -0700
Message-ID: <20250831225959.531393-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars CM and Mars CM Lite System-on-Module both are based on the
StarFive JH7110 SoC and compatible with the Raspberry Pi CM4IO Classic IO
Board carrier. Mars CM Lite is Mars CM without the eMMC storage component
on mmc0 and the mmc0 interface configured instead for SD Card use. The
optional WiFi+BT chipset is connected via SDIO on the mmc1 interface that
would otherwise be connected to an SD Card slot on the StarFive
VisionFive2 reference design.

Add the related devicetree files for both Milk-V Mars CM and Milk-V Mars
CM Lite describing the currently supported features, namely PMIC, UART,
I2C, GPIO, eMMC or SD Card, WiFi+BT, QSPI Flash, and Ethernet.

Caveat with vendor AP6256 firmware files present the firmware loading is
successful but subsequently fails IRQ wake initialization. Common GPIO
conflicts for "WiFi" optioned boards having this module:

pwmdac_pins:
 - AP6256: WL_REG_ON>>WIFI_REG_ON_H_GPIO33
 - AP6256: WL_HOST_WAKE>>WIFI_WAKE_HOST_H_GPIO34

i2c2_pins:
 - AP6256: UART_CTS_N<<UART1_RTSn_GPIO2
 - AP6256: UART_RTS_N>>UART1_CTSn_GPIO3

i2c6_pins:
 - AP6256: UART_RXD<<UART_TX_GPIO16
 - AP6256: UART_TXD>>UART_RX_GPIO17

Tested successfully for basic mmc0 storage, USB, and network functionality on:
- Milk-V Mars CM 8GB
- Milk-V Mars CM Lite 4GB
- Milk-V Mars CM Lite WiFi 8GB

Changes since v1:
- create common board include jh7110-milkv-marscm.dtsi
- drop redundant include starfive,jh7110-pinctrl.h from jh7110-milkv-marscm.dtsi
- add wifi-host-wake-irq '-0' suffix to conform with dt-bindings
- PATCH 1/4 collect tags
- PATCH 2/4 use common board include jh7110-milkv-marscm.dtsi
- PATCH 2/4 correction of S-o-by email address
- PATCH 2/4 drop 'PWM DAC' from description of common supported features
- PATCH 3/4 collect tags
- PATCH 4/4 use common board include jh7110-milkv-marscm.dtsi

Link to v1:
https://lore.kernel.org/lkml/20250724094912.253723-1-e@freeshell.de/

E Shattow (5):
  riscv: dts: starfive: add common board dtsi for Milk-V Mars CM
    variants
  dt-bindings: riscv: starfive: add milkv,marscm-emmc
  riscv: dts: starfive: add Milk-V Mars CM system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-lite
  riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module

 .../devicetree/bindings/riscv/starfive.yaml   |   2 +
 arch/riscv/boot/dts/starfive/Makefile         |   2 +
 .../dts/starfive/jh7110-milkv-marscm-emmc.dts |  13 ++
 .../dts/starfive/jh7110-milkv-marscm-lite.dts |  26 +++
 .../dts/starfive/jh7110-milkv-marscm.dtsi     | 159 ++++++++++++++++++
 5 files changed, 202 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi


base-commit: f66eb149b87677da3171a0ed51c77c3599ad55d6
-- 
2.50.0


