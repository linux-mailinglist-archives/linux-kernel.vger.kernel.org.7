Return-Path: <linux-kernel+bounces-791756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE67B3BB86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB471BA8142
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01231AF1D;
	Fri, 29 Aug 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="Dos1Q13Q"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C531A54B;
	Fri, 29 Aug 2025 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471144; cv=none; b=LSDzUCojwfyE0a8st/P1mvJdUBKBeJLG/lWiLYNivjilGlDaR6mFiNXWVsYBDk7+Vxsl3d8Y1+aglF31/1P8cbrxjHDWTb9J9rO28sk1MgEeHwsZXd0IZLBAik9vmP5Odj8Qn7W+hjKvJW4b1FgHQRgCO14wGHqj+HhbxAAQNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471144; c=relaxed/simple;
	bh=hu5c7PABzbVHWF9m/evOHlPD26W0c81YZeCpT4mqmPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7e7S6Zq86Fbd8I+4AHhYv3Fv1qenYM+R2vfyT/aWAiG5AYTwcPeq8ZfTx86urSfrUtuZtsU4+YZ143EpiRy+F9zFi8d9G5G2tAuqDO5ukHm4VkFtJTb4G2eNARJ9Rjvm3pRFfQEF/Zw0KLWKpkG4bc8pcZYB7rTQqrmegJ6TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=Dos1Q13Q; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=2u0S9Z5uAyb3HMOlKtlzaMKqT/fl3RGCnbjggUuVWwk=;
	b=Dos1Q13QOFuxLLx71VXhTkJPavQr902dT0tq+ZILUcpJF4ofny3qEt7F4f6IAFYBEDyW9hj1coL5EZSITqSislKXizu39GwrUQrClIR0An12zjfKfACWIdOcq7g9HKAZUndxkIKkgwFZQA8iXtpdUG+3Inc9NyMY1ynmf9KxQfA=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Fri, 29 Aug 2025 14:38:29 +0200
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
Subject: [PATCH v6 2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube Systems Nagami SoM
Date: Fri, 29 Aug 2025 14:37:55 +0200
Message-Id: <20250829123800.1232645-3-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829123800.1232645-1-lukas.schmid@netcube.li>
References: <20250829123800.1232645-1-lukas.schmid@netcube.li>
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
index e4175adb0..c00996d62 100644
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



