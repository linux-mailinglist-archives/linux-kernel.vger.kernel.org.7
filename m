Return-Path: <linux-kernel+bounces-803116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F2B45ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9647A603C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26451371E9C;
	Fri,  5 Sep 2025 14:41:33 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43921FDE19;
	Fri,  5 Sep 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083292; cv=none; b=M5PtBPRoDBizZSMqezw7y7YjivTn2ofpXd+joKbyFV+vo40T5jR+ZXhcfAd1+K97eo5O1l4NKIerByDLiVbUf1e5R5t0gGPuzm/Eyar8Yn0CKl8RVClwvEiLcl1Fkd6kHvvoDsJsvBFmsKYdJ68AsRqns5DYr+iWTM4oeXsQvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083292; c=relaxed/simple;
	bh=/AsMdZ/Tup/47S+UiseVE2kMbCB8OSwgd0CXlvrp76g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBVsB2JzAVXhp3iQT+OqR9wWn0DCbxzJvRM4/BfXI+HxGxZ/9XYo+k880geBETHnJmBB9k7/wfNPNEVJNMSicHZTfweFUg41OdEKYnN5dU51pCEl8g+HzPFjf7eRY6S7+/vGYXBlPlrMzhiEppoD1KYJ7lgTWqJ7SPnpTlMrX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 5EFDCB22004E;
	Fri,  5 Sep 2025 16:41:18 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v3 0/5] riscv: dts: starfive: Add Milk-V Mars CM (Lite) SoM
Date: Fri,  5 Sep 2025 07:39:38 -0700
Message-ID: <20250905144011.928332-1-e@freeshell.de>
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

Changes since v2:
- PATCH 3/5 delete newline at end of file
- PATCH 5/5 delete newline at end of file

Link to v2:
https://lore.kernel.org/lkml/20250831225959.531393-1-e@freeshell.de/

E Shattow (5):
  riscv: dts: starfive: add common board dtsi for Milk-V Mars CM
    variants
  dt-bindings: riscv: starfive: add milkv,marscm-emmc
  riscv: dts: starfive: add Milk-V Mars CM system-on-module
  dt-bindings: riscv: starfive: add milkv,marscm-lite
  riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module

 .../devicetree/bindings/riscv/starfive.yaml   |   2 +
 arch/riscv/boot/dts/starfive/Makefile         |   2 +
 .../dts/starfive/jh7110-milkv-marscm-emmc.dts |  12 ++
 .../dts/starfive/jh7110-milkv-marscm-lite.dts |  25 +++
 .../dts/starfive/jh7110-milkv-marscm.dtsi     | 159 ++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi


base-commit: 8181cc2f3f21657392da912eb20ee17514c87828
-- 
2.50.0


