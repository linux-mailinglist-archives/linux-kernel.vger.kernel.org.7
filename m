Return-Path: <linux-kernel+bounces-815854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D29B56BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0111725AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F12E1F1F;
	Sun, 14 Sep 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Kqbq8Vk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CunYrNBY"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892712E5418;
	Sun, 14 Sep 2025 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878752; cv=none; b=jQFW0Hudb3rp8kizOIuJXIT4PDW+ToMzfbp0Ab/0LLMLDzLiMt2fx0/m/RonFJmVRribu6mkzVicOAsLeOiNg66bCZ/AT/K9mk4UH7zLzgv7hfktFiKenOhToOjwpEwQTeGbRHLvoExZYHcvnsuVep32r0CcXoMS38altgMlXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878752; c=relaxed/simple;
	bh=3PonbqJMczKSBYd/otrfHEQx7EHXLDy7vhorYufIaCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYYweDTxfcFML7r1iVsl4EzaWs73uaL4EtpOZhAnTqtDXAApTqT/nCuce9taSUEUDkof4Cl+Fn5/eQwpF7BoYclJHFVHAa9CsO8TZJnrv1OdAsopydyUYY/v2OAK0p/RahfB9JrkWV7zqye+2yuBxwXibadset8niRiaV/XgwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Kqbq8Vk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CunYrNBY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8101A7A0123;
	Sun, 14 Sep 2025 15:39:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 14 Sep 2025 15:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757878748;
	 x=1757965148; bh=W3/Ug4jK82Vh9zL1D2UBMJ0+7NXAz8xMMzpnI81fAlA=; b=
	Kqbq8Vk+h4gXL4/kYzbzNgFX+F77hA4BkPn0NUxpCTO3BMDnfkmh1aOo9tO+jdmT
	W218iWRV2qU+D+LoPJKnK2rOrinNbeOsWS/OacES4QrQLfBE4EL3nRLo7ITX8npJ
	Sppu+l75x4BEBMzIM7ttSiS8nqhiauTgJWlar3lc+vkLKuxbOOWujg+3CGhL9Vct
	b9qGmFvsQABS33r0Vfs0fZcuIRVfHpLH48UwVYv8sAAyqyFol1IvYfMCAOTnwTI/
	MfWxU478rFtEYU3l4Gp25wLKRKtlethYII17ZTTkaSPTHTxDz6BlMWS/1QCMcmR6
	a2SLvArUBUecVCpx1b5hTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757878748; x=
	1757965148; bh=W3/Ug4jK82Vh9zL1D2UBMJ0+7NXAz8xMMzpnI81fAlA=; b=C
	unYrNBYE4GHzJTAWDtQe8hdqRzsu7gLxwVeilwdMZ6hLqDU5z6vfueWEXsPKKOYL
	3mVKEj7sD9Lgxyzxx3X5jSO88NU1XkLPAbigBax0heCa2qALjr2WJgQjKNJwZXKE
	BbMHK55PxclKTjFWgqRh8ZSauK+KL78U4WxnEgz19yFY/FUfdg6yo/AtoPqCcRY+
	3v/jkVRLxcdLu+aeV/yRYl5YnWdVSQUbxGyuP1esffZBdxsUqYsbPmfZv5De/PK3
	Suk/qAsDRSlWZTj84ofpn6ZYq4E5IbtC1XCmfUOhiV+MI6u/+PMqdYJSr+s4aGcK
	J8Xj0U+8nHYzYhPF4gGsQ==
X-ME-Sender: <xms:2xnHaESxfLW8p8NBbqMHm8W0pfquWIrGWm9b4lrt5G1kYz0c9crhvg>
    <xme:2xnHaJDfgXcN9TlCLB8etaIAWspOa10K4-C7JINkXNST2sKOdMOiEmXOQ64lajyNE
    x9EQedDmt0I5hxr1NQ>
X-ME-Received: <xmr:2xnHaMvXZ7p1p7qFzQvJLV4lZbGm1o0PtERCK3SgXcRP8kB5HcsZF9VMxAcfoB-G3p6_n_5_UvBlcGN7R33SyV_MpCKqW757Smn1jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
    ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmph
    grrdguvghvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheprghs
    rghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrh
    hmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehmrgiisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihho
X-ME-Proxy: <xmx:2xnHaH_LpcJk-f25UTR-YcO46hxS6IEg0SW68-MZfiSoo6WBWLMsiQ>
    <xmx:2xnHaDT-nS5USvxs1035Tw6uqsO6lX8J1uB41pOL95VwhH6F2o-p5A>
    <xmx:2xnHaJWHEx6fYCy-HifoAxwbKNlnfNTd3CCU28QTNb0BoiKYNyW-wg>
    <xmx:2xnHaF8YXc5uOuCv3f4S4Uu3UK2bDwtwCBeUdixV1seXb9fGbF1e_Q>
    <xmx:3BnHaBSEOb8dHctkX-oZWDhP-MXpZ6aXJkN51kq57BzYQoHksqjfvlKr>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:39:07 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sun, 14 Sep 2025 21:38:49 +0200
Subject: [PATCH v2 6/6] arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra,
 2023) device tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-dt-apple-t6020-v2-6-1a738a98bb43@jannau.net>
References: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
In-Reply-To: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Marc Zyngier <maz@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=faHpJABUmh2pQbfVmmffgLLfTnAIPKwSQ01C5YgS5kg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhozjkqckss5fns2pYXRTq3oqdw9ziKPbM6Wn312aU9Zu4
 3vdqLSgo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwETu1jMyrGT58Knnz6Z2uUj2
 S2cSS/exrZz/JfmDwTfdziWPt0x1mcLIcFD+fP3uMh21B38Tvy7JPjNzh8wz8y+fI+YeLOy7U7z
 8KRsA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

The M2 Ultra in the Mac Pro differs from the M2 Ultra Mac Studio in its
PCIe setup. It uses all available 16 PCIe Gen4 on the first die and 8
PCIe Gen4 lanes on the second die to connect to ann 100 lane Microchip
Switchtec PCIe switch. All internal PCIe devices and the PCIe slots are
connected to the PCIe switch.
Each die has implements a PCIe controller with a single 16 or 8 lane
port. The PCIe controller is mostly compatible with existing
implementation in pcie-apple.c.
The resources for other 8 lanes on the second die are used to connect
the NVMe flash with the controller in the SoC.
This initial device tree does not include PCIe support.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile        |   1 +
 arch/arm64/boot/dts/apple/t6022-j180d.dts | 121 ++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index 21c4e02a4429fa1db506dd85637a44000073590e..4eebcd85c90fcf0f358b0b32debf2475f6dbbf2c 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6022-j180d.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j414s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j414c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j416s.dtb
diff --git a/arch/arm64/boot/dts/apple/t6022-j180d.dts b/arch/arm64/boot/dts/apple/t6022-j180d.dts
new file mode 100644
index 0000000000000000000000000000000000000000..dca6bd167c225aa23e78e1c644bf6c97f42d46b5
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6022-j180d.dts
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Pro (M2 Ultra, 2023)
+ *
+ * target-type: J180d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6022.dtsi"
+#include "t6022-jxxxd.dtsi"
+
+/ {
+	compatible = "apple,j180d", "apple,t6022", "apple,arm-platform";
+	model = "Apple Mac Pro (M2 Ultra, 2023)";
+	aliases {
+		nvram = &nvram;
+		serial0 = &serial0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0";
+
+		framebuffer0: framebuffer@0 {
+			compatible = "apple,simple-framebuffer", "simple-framebuffer";
+			reg = <0 0 0 0>; /* To be filled by loader */
+			/* Format properties will be added by loader */
+			status = "disabled";
+			power-domains = <&ps_dispext0_cpu0_die1>, <&ps_dptx_phy_ps_die1>;
+		};
+	};
+
+	memory@10000000000 {
+		device_type = "memory";
+		reg = <0x100 0 0x2 0>; /* To be filled by loader */
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+/* USB Type C Rear */
+&i2c0 {
+	hpm2: usb-pd@3b {
+		compatible = "apple,cd321x";
+		reg = <0x3b>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm3: usb-pd@3c {
+		compatible = "apple,cd321x";
+		reg = <0x3c>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	/* hpm4 and hpm5 included from t6022-jxxxd.dtsi */
+
+	hpm6: usb-pd@3d {
+		compatible = "apple,cd321x";
+		reg = <0x3d>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm7: usb-pd@3e {
+		compatible = "apple,cd321x";
+		reg = <0x3e>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/* USB Type C Front */
+&i2c3 {
+	status = "okay";
+
+	hpm0: usb-pd@38 {
+		compatible = "apple,cd321x";
+		reg = <0x38>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <60 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	hpm1: usb-pd@3f {
+		compatible = "apple,cd321x";
+		reg = <0x3f>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <60 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
+
+/*
+ * Delete unused PCIe nodes, the Mac Pro uses slightly different PCIe
+ * controllers with a single port connected to a PM40100 PCIe switch
+ */
+/delete-node/ &pcie0;
+/delete-node/ &pcie0_dart_0;
+/delete-node/ &pcie0_dart_1;
+/delete-node/ &pcie0_dart_2;
+/delete-node/ &pcie0_dart_3;
+
+&nco_clkref {
+	clock-frequency = <1068000000>;
+};
+
+#include "spi1-nvram.dtsi"

-- 
2.51.0


