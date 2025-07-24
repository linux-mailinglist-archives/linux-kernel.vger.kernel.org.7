Return-Path: <linux-kernel+bounces-744014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFEB106F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DC93A7B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF23255E2F;
	Thu, 24 Jul 2025 09:49:59 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D61F4606;
	Thu, 24 Jul 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350598; cv=none; b=VK1In5Da9xzHfrluoi7Z9A9GD4NFc6uIZTbnk6SBidkWeT/7N2eNpHNb2NYXW6VMCcNJsgpP6mF9Vg43LgyTTBdClbZ2RdJtsq7QSoxuXCAdw6IPv1VASguns4EoZeGCY4qsuPiXdZUDM0ZyxZmgUOrPh5ijez8lmVMEVXrMyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350598; c=relaxed/simple;
	bh=0NPue2eQZiUVKuoMSC8bqNQVgW4t927OHHBU3I/s5j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LD/kl0proqZaxcVTMtVyWGqXr/t4bxNC7Y/u1q29mgoy2g2Gxw2hqDu3/kriqZDYPY69RoERr4T2wrPXp29+fB4P9915oItXPN6SNlwsNDrw60/px6maJt+Ks3vjD5lbhspRxjNo3m6kwvH5HZjhobkMzkvgdzREY4+pL7fMQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id A911DB4D0064;
	Thu, 24 Jul 2025 11:49:51 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/4] riscv: dts: starfive: Add Milk-V Mars CM (Lite) SoM
Date: Thu, 24 Jul 2025 02:48:43 -0700
Message-ID: <20250724094912.253723-1-e@freeshell.de>
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

E Shattow (4):
  dt-bindings: riscv: starfive: add milkv,marscm-emmc
  riscv: dts: starfive: add Milk-V Mars CM system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-lite
  riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module

 .../devicetree/bindings/riscv/starfive.yaml   |   2 +
 arch/riscv/boot/dts/starfive/Makefile         |   2 +
 .../dts/starfive/jh7110-milkv-marscm-emmc.dts | 163 ++++++++++++++++
 .../dts/starfive/jh7110-milkv-marscm-lite.dts | 176 ++++++++++++++++++
 4 files changed, 343 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts


base-commit: 28fa0dcb571ab8f3be4d919f0e20e01d4e44bcb1
-- 
2.50.0


