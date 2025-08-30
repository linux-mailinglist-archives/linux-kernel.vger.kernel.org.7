Return-Path: <linux-kernel+bounces-792867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49A8B3C9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0278568255
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AA261B7F;
	Sat, 30 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="pRJcNI9B"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250F22129F;
	Sat, 30 Aug 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547286; cv=none; b=oWhAtIjXrXPsTUEk+ZNcbWjh7vAsvLkZxm1WGo8zv3E9JbEGtQ72R4giwtOvucnTjgAr/hsEO5fVrDzivvS6UHi6lFZXy/m2Zhr2IlSHdw+I9IjXcFvvpUOnic2rR0xkenc6UfFLcqZSQM5yEmuA5J8BjOQhO8mizlRy/G0PY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547286; c=relaxed/simple;
	bh=IAEUllPYaczp2aMU1bdOaTuDN7VOxW55hFIj6W3H8Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0NHNnKInQ++bFBuqTLu1hKoFTvODSyrSoVoc+ipxk+DNVXVeXyFmw5+2OvAGPTENzq8YrbdM0YzDvhm39khwFB9eWwvDOxe5wdtkjDVdR28wauzniH/yb5ihGUTLORopGWU1MzGocvT2cc1q0ToCXK4gOy13tt5vvZ08RKK9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=pRJcNI9B; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=Tulqcgl5E7xddxV0QVa8ixoBhbEOneG+ZJlK77Ah9ws=;
	b=pRJcNI9Bf3JFnHaLbwbeD3wmPJuWGF28HTy9SE5rduqMknD9IRlAKj2CKOEihWgf8Vv0oi9ANybSoR7UMmAlya/CGd1TvG2hG3vwFET2GDFodGNsuQKG8KfgtipyuSfZgRSNKJ7Zm8c9p2fMWZIh19Ba+RUlh39YKm6qawq7nF8=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Sat, 30 Aug 2025 11:47:39 +0200
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
Subject: [PATCH v7 2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube Systems Nagami SoM
Date: Sat, 30 Aug 2025 11:46:54 +0200
Message-Id: <20250830094700.1715658-3-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830094700.1715658-1-lukas.schmid@netcube.li>
References: <20250830094700.1715658-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the following pinctrl's used by the NetCube Systems Nagami SoM
  * i2c2_pins
  * i2c3_pins
  * i2s1_pins, i2s1_din_pins, i2s1_dout_pins
  * spi1_pins, spi1_hold_pin, spi1_wp_pin

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index e4175adb028d..c00996d6275c 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -78,6 +78,36 @@ dsi_4lane_pins: dsi-4lane-pins {
 				function = "dsi";
 			};
 
+			/omit-if-no-ref/
+			i2c2_pins: i2c2-pins {
+				pins = "PD20", "PD21";
+				function = "i2c2";
+			};
+
+			/omit-if-no-ref/
+			i2c3_pins: i2c3-pins {
+				pins = "PG10", "PG11";
+				function = "i2c3";
+			};
+
+			/omit-if-no-ref/
+			i2s1_pins: i2s1-pins {
+				pins = "PG12", "PG13";
+				function = "i2s1";
+			};
+
+			/omit-if-no-ref/
+			i2s1_din_pins: i2s1-din-pins {
+				pins = "PG14";
+				function = "i2s1_din";
+			};
+
+			/omit-if-no-ref/
+			i2s1_dout_pins: i2s1-dout-pins {
+				pins = "PG15";
+				function = "i2s1_dout";
+			};
+
 			/omit-if-no-ref/
 			lcd_rgb666_pins: lcd-rgb666-pins {
 				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
@@ -126,6 +156,24 @@ spi0_pins: spi0-pins {
 				function = "spi0";
 			};
 
+			/omit-if-no-ref/
+			spi1_pins: spi1-pins {
+				pins = "PD10", "PD11", "PD12", "PD13";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_hold_pin: spi1-hold-pin {
+				pins = "PD14";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_wp_pin: spi1-wp-pin {
+				pins = "PD15";
+				function = "spi1";
+			};
+
 			/omit-if-no-ref/
 			uart1_pg6_pins: uart1-pg6-pins {
 				pins = "PG6", "PG7";
-- 
2.39.5



