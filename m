Return-Path: <linux-kernel+bounces-792864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F5B3C9DB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C551F1C20846
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB0722A4F8;
	Sat, 30 Aug 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="o+dctFqz"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05441C3F0C;
	Sat, 30 Aug 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547260; cv=none; b=bscSQC12cP5u+WE9H2q+/72Rza4TseD1JZdrCmNc3AGLpztEwq7rCZSuFDJQ8K/9zaFNoON9503aZPGe6FziUzqR3+wAsfW571bAwCnlCwDEXu2UaGoP8St/J+jif8A1fIZGJWWSaTV9jlm4k5v02l/FSNvM2dHLdG1k0AqVA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547260; c=relaxed/simple;
	bh=O1fBk5jffFqjCHIFcOHG4vHijhyhO9U7OQyqaQYwbj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpmJMMcPBpCHP8YYwvGcnfaMw9w015/rUzjFbxIBMaX0DncABuy5aLiusyeS/qDkLl62ahdm7oDdPfs7OKqTfYHe6Q9GSBFu1OtZBQNXHSsrI/wkvRnoXtevC6NViq51yFIbzAmJ8BomBM7JbDUCLSr9e+7e/ib2G3vxMHl1Pa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=o+dctFqz; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=uKji/FCmBwfqWJNW5C1m3HN1FANNuZMTcCJ632t2uJw=;
	b=o+dctFqz3HX0r7Gm3jrCpKcguejk68zXpPYlNn76Mjs1/DFLP/uXv8/k3QZsf1aTVP8oyHqiwXJ1AqldCOVwMY7lLi9U1sg7xaZK8mBBhF72acr7VZMrLDFxzljWC6EKZxT0c+OPKCCuI9GdiV6vgSNjLSC2eFCJkgMkBxDQrtk=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Sat, 30 Aug 2025 11:47:27 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Ripard <mripard@kernel.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 0/5] Add support for NetCube Systems Nagami SoM and its carrier boards
Date: Sat, 30 Aug 2025 11:46:52 +0200
Message-Id: <20250830094700.1715658-1-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the NetCube Systems Nagami SoM and its
associated carrier boards, the Nagami Basic Carrier and the Nagami Keypad
Carrier.

Changes in v7:
  - Fix the gpio numbering for the USB_SEC_EN gpio hog
  - Fix the gpio-line-names for the keypad carrier

Changes in v6:
  - Add 'usb0-enable-hog' to the som to enable the USB-OTG port by default
  - Update the keypad carrier dts to match actual board revision

Changes in v5:
  - Re-add the non-removable property to the ESP32 interface
  - Add the mmc-pwrseq node for the ESP32 to initialize the ESP32 correctly
  - Remove the unused ehci0 and ohci0 nodes from the Keypad Carrier since
    USB port is peripheral only

Changes in v4:
  - Disable the default interfaces on the card-edge but keep the pinctrl
    definitions for them
  - Split the pinctrl definitions for the SPI interface into the basic spi 
    pins and the hold/wp pins
  - Move some mmc0 properties to the Basic Carrier dts
  - Remove non-removable property from the ESP32 interface
  - Fix typo in the keypad matrix definition

Changes in v3:
  - Add missing dcxo node to the SoM dtsi
  - Rename the multi-led node
  - Change dr_mode to "peripheral" for the Keypad Carrier

Changes in v2:
 - Squash the binding patches into one patch
 - Fix formatting of the phy node in the SoM dtsi
 - Add description on where the phy is located in the SoM dtsi
 - Fix the phy address in the SoM dtsi
 - Move the carrier bindings into the same description as enums

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
Lukas Schmid (5):
  dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrier
    board bindings
  riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube
    Systems Nagami SoM
  ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
  ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carrier
  ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Carrier

 .../devicetree/bindings/arm/sunxi.yaml        |   8 +
 arch/arm/boot/dts/allwinner/Makefile          |   3 +
 ...n8i-t113s-netcube-nagami-basic-carrier.dts |  67 +++++
 ...8i-t113s-netcube-nagami-keypad-carrier.dts | 129 +++++++++
 .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 249 ++++++++++++++++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  48 ++++
 6 files changed, 504 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi

-- 
2.39.5



