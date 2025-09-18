Return-Path: <linux-kernel+bounces-793499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CCB3D459
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFB7A972F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA12701D8;
	Sun, 31 Aug 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="M+D+bqdg"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AF248F72;
	Sun, 31 Aug 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756657624; cv=none; b=T5/lA579VbnnL2XykXisloZ0rzboqGqOznglzhOylX8OjBuggQpVLWiMZyk2zR1CSdeHodhkJKizG39JhkYotSirWrKy3SNfnNwE2s6t+kFAPjrhr7y2oF80TWa0FI1Ww7OSMAVDBObTBmkik5Ux2/5YqmAW1BEnlcl/UbBv7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756657624; c=relaxed/simple;
	bh=UsXGmYPT8TbmSPEDZad5VzVptp8g8Fh0AHQipQDvoN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2nuL3hQZbdHfuipsotuvQ2CYTvaLrpoeTWL/x5Mb/EdnYIE9DeYl+bK/ar1hg6hYKJz5K9VX6DJiA/5fJmrIWyRy0q6kWeIP6Qb7k8Y3wvIpRxrDBw9oG2M38aJNlXOxGMfwVef1XjpNtfYhgyw4OZaO57XAo97WukEjO584q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=M+D+bqdg; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=FquTVYtzEe8/l+LdA4BkvueJi3yLn+QSu87mo4h46qc=;
	b=M+D+bqdgH3YWYRg2ytp7U0I2eBOvKJfqeUGTjfjurtCA7X+Xb0yqzH5xhovGIvR50EbGvdJ982UCoXDe5+RMoDPrePcyb29l708G9YyP0O0vG0WZwpAnwWKH8SCFqw/eCBBwW5vRPDWgUm5yZD7KNlcjMMLe0/jaD3O7h7GOkYk=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Sun, 31 Aug 2025 18:26:47 +0200
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
Subject: [PATCH v8 4/5] ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carrier
Date: Sun, 31 Aug 2025 18:25:33 +0200
Message-Id: <20250831162536.2380589-5-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250831162536.2380589-1-lukas.schmid@netcube.li>
References: <20250831162536.2380589-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NetCube Systems Nagami Basic Carrier is a Carrier for the Nagami SoM
It provides an ethernet port for the phy on the SoM and some USB-Ports.
All other interfaces and gpios are available on pinheader, except for the
SD-Interface which is available on a micro-sd slot.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/boot/dts/allwinner/Makefile          |  2 +
 ...n8i-t113s-netcube-nagami-basic-carrier.dts | 67 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index d799ad153b37b..af287bb3231c8 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -199,6 +199,7 @@ DTC_FLAGS_sun8i-h3-nanopi-r1 := -@
 DTC_FLAGS_sun8i-h3-orangepi-pc := -@
 DTC_FLAGS_sun8i-h3-bananapi-m2-plus-v1.2 := -@
 DTC_FLAGS_sun8i-h3-orangepi-pc-plus := -@
+DTC_FLAGS_sun8i-t113s-netcube-nagami-basic-carrier := -@
 DTC_FLAGS_sun8i-v3s-netcube-kumquat := -@
 dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a23-evb.dtb \
@@ -257,6 +258,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
 	sun8i-t113s-mangopi-mq-r-t113.dtb \
+	sun8i-t113s-netcube-nagami-basic-carrier.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-anbernic-rg-nano.dtb \
diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
new file mode 100644
index 0000000000000..5ee9a211a5ccb
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Lukas Schmid <lukas.schmid@netcube.li>
+ */
+
+/dts-v1/;
+#include "sun8i-t113s-netcube-nagami.dtsi"
+
+/ {
+	model = "NetCube Systems Nagami Basic Carrier Board";
+	compatible = "netcube,nagami-basic-carrier", "netcube,nagami",
+				 "allwinner,sun8i-t113s";
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	broken-cd;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	status = "okay";
+};
-- 
2.39.5



