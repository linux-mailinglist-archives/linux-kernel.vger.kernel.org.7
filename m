Return-Path: <linux-kernel+bounces-766426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A4B24676
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8B7886B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76363307497;
	Wed, 13 Aug 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmFRHX0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F22FDC5C;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078831; cv=none; b=gfpqzOzElZE1GMk9SPi1ji64v0gnT6OHAOQOjKlTNeBYghGH2Hq1IqmJdPvHnr4Q2wRTxZtlebZ+cNP2h61X5OsV5w3aOi2ffuD7v5VZdi7nfBIchIXPW32JCrY1FMHwQbwUMz+BUSxRgi1/jUQP2LseMn2K+2MylO4icVq/7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078831; c=relaxed/simple;
	bh=jPN0v70OwcYjIXRSNqY0ScIhvStfXtDwvU1h2Fu7Gd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suNQ1ekPvd6J7+0VKHslfg0cb69mPvTvpQTLHkxI7JnLZW9UQ9ESl1sBnaD780HNGHUU4k2RU6G6aiWfmznTPy/Eb23wSCa8LE28QIP/Lr+dnoknsK8G0Kuj871dNgie0l/WLEVgAF+mntvF3BCFg1erazkaMPpwtIK4DOGRYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmFRHX0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67D49C113D0;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078830;
	bh=jPN0v70OwcYjIXRSNqY0ScIhvStfXtDwvU1h2Fu7Gd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AmFRHX0YbjrxGtdZCqlqhva6zJNa7kBM2325QEIGyAtRnvgSvqDxCqLIj17U2JFFY
	 Z2zhYjAzJsPST6ghMzAxaLgz/TiK53DpD/iQG99XeDMItG71pYU4EZpRvylWvCXv1i
	 n7CgJw07gabP8AelcYoS1BzalZ/ZQaLDV84zkX0Xl89sAROYl9pvDjjFnUrZb1zaAo
	 BCr3gOlRRRNsmStmSMh4nxxswCQv3m7hjf9GqILXetXEgYKBup9zSu0xECJPWqI80t
	 Zi0GKtP8t6GC6kWls0dx7aCWIMBdx884u/+8DT/7WYILm4COpKiuqjWhyavQ5MrSCO
	 rouFkaTF6ekMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3CCA0EE0;
	Wed, 13 Aug 2025 09:53:50 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 13 Aug 2025 11:53:37 +0200
Subject: [PATCH 5/5] arm64: dts: apple: Add devicetreee for t8112-j415
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-apple-dt-sync-6-17-v1-5-209f15d10aa0@jannau.net>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
In-Reply-To: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=j/SpJUpMBqqMJF/E/m3nXQjyW/Z6PJx2/BxKhkTfoIQ=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhow5CWtKgtY+0FL7/rDyr1WzSVPh57e6DjMEJqlIz/m97
 IvM9HsHO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkbzPDf5e47DdhOWoftrt3
 vN5i/O3nw651SzO4DM6b62aUJM3sv8jI8PasQ8mfAIt2HQflkjXiFR4y3I+ya5d9vvHiIxuj8Sl
 bLgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

The 15-inch M2 MacBook Air was released a year after the 13-inch one
thus missed in initial submission of devicetrees for M2 based devices.
It is currently a copy of t8112-j413 with edited identifiers but will
eventually differ in a meaningful way. It has for example a different
speaker configuration than the 13-inch model.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile       |  1 +
 arch/arm64/boot/dts/apple/t8112-j415.dts | 80 ++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 4f337bff36cdf51837ac7d50122692895026ce14..df4ba8ef6213c9f7e4ef02a50d7250008977cc71 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -80,5 +80,6 @@ dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t8112-j415.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j493.dtb
diff --git a/arch/arm64/boot/dts/apple/t8112-j415.dts b/arch/arm64/boot/dts/apple/t8112-j415.dts
new file mode 100644
index 0000000000000000000000000000000000000000..b54e218e5384ca89155e4350d6680a28a531f408
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t8112-j415.dts
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple MacBook Air (15-inch, M2, 2023)
+ *
+ * target-type: J415
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t8112.dtsi"
+#include "t8112-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "apple,j415", "apple,t8112", "apple,arm-platform";
+	model = "Apple MacBook Air (15-inch, M2, 2023)";
+
+	aliases {
+		bluetooth0 = &bluetooth0;
+		wifi0 = &wifi0;
+	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+/*
+ * Force the bus number assignments so that we can declare some of the
+ * on-board devices and properties that are populated by the bootloader
+ * (such as MAC addresses).
+ */
+&port00 {
+	bus-range = <1 1>;
+	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4433";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-mac-address = [00 10 18 00 00 10];
+		apple,antenna-sku = "XX";
+		brcm,board-type = "apple,snake";
+	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+		brcm,board-type = "apple,snake";
+	};
+};
+
+&i2c0 {
+	/* MagSafe port */
+	hpm5: usb-pd@3a {
+		compatible = "apple,cd321x";
+		reg = <0x3a>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&fpwm1 {
+	status = "okay";
+};

-- 
2.50.1



