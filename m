Return-Path: <linux-kernel+bounces-771684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5DB28A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A41AE803B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4941C84A1;
	Sat, 16 Aug 2025 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ehjCBe2A"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145217A2F6;
	Sat, 16 Aug 2025 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755315312; cv=none; b=du/jdU86CglugtUpCPFLo+Dk/xYZqTtbwNL97ZD+1RN0pni7UpbJ5/++B+ehUydsr0lQr4AZdQGQgir67ffDOb6qW6tM+TeFPbORmQZf+UFj3O2wYq+2KraeK8xsUihxvgN2X6PWJCjddHplp8hPQ2RZr0L+mPJHcNWoDGKMGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755315312; c=relaxed/simple;
	bh=qzW26gUbpt8hihAYOY+dEBe3bjTSLZipdIoCfTbRj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSCwWxJJy0h4gtP/nDYadCG14xS7tRnKBj4Sq8tWxFCD7N1gRqKeO04YQsCGEMzPfVz7KmKV6q8B6krulLClRAVPnIJ/eeNNJmU2r83eKR8JiHptBV2s2PQEy8AwhWdJFhWnqabE8uzCT1Lxpo/l6HwG/8eIZH3somzlcuQK7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ehjCBe2A; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9022125CA7;
	Sat, 16 Aug 2025 05:35:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FdLN3DQp297; Sat, 16 Aug 2025 05:35:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755315308; bh=qzW26gUbpt8hihAYOY+dEBe3bjTSLZipdIoCfTbRj4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ehjCBe2A71we6h81TUE0nQ/FzDT1K+2g6AKiJPDsPkm8CmvpVAv3VMrnI5i+kbqvT
	 FgSQCmTjyzXlXXng6xby2ooQHDhhmBUrhxUF5Fd0rYWyt6uhHocK0IgSBBlJkHI99U
	 j8AYqiUZWOYyvR5bI9f+bov+EMmsLtPpfly8CPJUqjEnEtG5FXhM9JU/f7PzAQdHiv
	 zLfNka7XDYbxkyTtTOXmrPXZP9Zq0I27VGRH+pbvPWIWthF5s+q9xurStAIpHipIjM
	 XUPF1SLKnOeSzEyPtR/YRyzBFsyHihV3zyQGtXfxKgFRkOHW5TYgS0qDbw5l+bBpkX
	 HOhV+6iLwM4Cw==
From: Yao Zi <ziyao@disroot.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/3] LoongArch: dts: Add reset controller for Loongson 2K0300
Date: Sat, 16 Aug 2025 03:33:28 +0000
Message-ID: <20250816033327.11359-5-ziyao@disroot.org>
In-Reply-To: <20250816033327.11359-2-ziyao@disroot.org>
References: <20250816033327.11359-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the reset controller and add resets for UART nodes.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/loongarch/boot/dts/loongson-2k0300.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/loongarch/boot/dts/loongson-2k0300.dtsi b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
index a8ad8bd43f5d..835d3c63537b 100644
--- a/arch/loongarch/boot/dts/loongson-2k0300.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/loongson,ls2k0300-clk.h>
+#include <dt-bindings/reset/loongson,ls2k0300-reset.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 #define PINMUX(pin, func)	(((pin) << 8) | func)
@@ -50,6 +51,12 @@ soc@10000000 {
 			 <0x00 0x02000000 0x00 0x02000000 0x0 0x04000000>,
 			 <0x00 0x40000000 0x00 0x40000000 0x0 0x40000000>;
 
+		rst: reset-controller@1600011c {
+			compatible = "loongson,ls2k0300-reset";
+			reg = <0x0 0x1600011c 0x0 0x8>;
+			#reset-cells = <1>;
+		};
+
 		clk: clock-controller@16000400 {
 			compatible = "loongson,ls2k0300-clk";
 			reg = <0x0 0x16000400 0x0 0x30>;
@@ -128,6 +135,7 @@ uart0: serial@16100000 {
 			compatible = "ns16550a";
 			reg = <0 0x16100000 0 0x10>;
 			clocks = <&clk LS2K0300_CLK_APB_GATE>;
+			resets = <&rst RST_UART0>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			no-loopback-test;
@@ -141,6 +149,7 @@ uart1: serial@16100400 {
 			reg = <0 0x16100400 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART1>;
 			no-loopback-test;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pins>;
@@ -152,6 +161,7 @@ uart2: serial@16100800 {
 			reg = <0 0x16100800 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART2>;
 			no-loopback-test;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart2_pins>;
@@ -163,6 +173,7 @@ uart3: serial@16100c00 {
 			reg = <0 0x16100c00 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART3>;
 			no-loopback-test;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart3_pins>;
@@ -174,6 +185,7 @@ uart4: serial@16101000 {
 			reg = <0 0x16101000 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART4>;
 			no-loopback-test;
 			status = "disabled";
 		};
@@ -183,6 +195,7 @@ uart5: serial@16101400 {
 			reg = <0 0x16101400 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART5>;
 			no-loopback-test;
 			status = "disabled";
 		};
@@ -192,6 +205,7 @@ uart6: serial@16101800 {
 			reg = <0 0x16101800 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART6>;
 			no-loopback-test;
 			status = "disabled";
 		};
@@ -201,6 +215,7 @@ uart7: serial@16101c00 {
 			reg = <0 0x16101c00 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART7>;
 			no-loopback-test;
 			status = "disabled";
 		};
@@ -210,6 +225,7 @@ uart8: serial@16102000 {
 			reg = <0 0x16102000 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART8>;
 			no-loopback-test;
 			status = "disabled";
 		};
@@ -219,6 +235,7 @@ uart9: serial@16102400 {
 			reg = <0 0x16102400 0 0x10>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rst RST_UART9>;
 			no-loopback-test;
 			status = "disabled";
 		};
-- 
2.50.1


