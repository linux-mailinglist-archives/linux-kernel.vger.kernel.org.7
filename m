Return-Path: <linux-kernel+bounces-735724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A993EB09316
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460163B476C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB030112C;
	Thu, 17 Jul 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="yF0aXylH"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00052FF471;
	Thu, 17 Jul 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772889; cv=none; b=qGwrb51FMLJTcVWAEq9qh9v4hvGVnseviQNKx5SDubUnGbNGltlrmYrqdQ6tczqq+56pJP0+PvpQOJyTm0Nk57MXxoVKmuzzxzdibHP0+9hCnvnRCi2DupHBMKrWw6JKi0l68LkbutYE10tOZuw+qktDaAT2p81FkwXu+pMm7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772889; c=relaxed/simple;
	bh=BC87w3BDNtlqvEOIYm0LnN+qw/D8xM/tzbFGW9nQjo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6zxzQisGbGH/FlBCOvYywlEojIV71Zs0rETZDObYCY5RyOxMaJsgYUyazV+UXtCWQ4WOCDunbYm17/dG5WA2QpFM6LxGiDCorKrWY6iAZ/3isVd1nA7XvC0dUSObxBo0BgWIsrlj6YIWxfu02qSaMiCyPY7VtIjogTdsoWonzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=yF0aXylH; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=flkrw68MjJZnRHTgaCTuAAE9V9fABxNnM+3EBSfDpyo=;
	b=yF0aXylHmh5jq94WFyMbEbUmDXeI0HzOd+2CGRVAwrdQ865zSnzcEXcO7EECZNL2leVgUjdUz84m8LaqqpW1Ptqqli6Q8B0ZKSIX/ILeZ70FL066WuSMCGIyLKJPZ7r02r0vVwXUYiiZ7D5BzbnVjNDqSO7E+RSro42T0z4YD0E=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Thu, 17 Jul 2025 19:20:54 +0200
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
Subject: [PATCH v5 0/5] Add support for NetCube Systems Nagami SoM and its carrier boards
Date: Thu, 17 Jul 2025 19:20:27 +0200
Message-Id: <20250717172035.3508831-1-lukas.schmid@netcube.li>
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
 ...8i-t113s-netcube-nagami-keypad-carrier.dts | 164 ++++++++++++
 .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 242 ++++++++++++++++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  48 ++++
 6 files changed, 532 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi

-- 
2.39.5



