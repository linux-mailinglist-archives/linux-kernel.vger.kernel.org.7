Return-Path: <linux-kernel+bounces-761183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8F7B1F566
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B318A6261E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1B2BEC5E;
	Sat,  9 Aug 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrfxhvNY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D71274B3D;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754756305; cv=none; b=rhZvsB44xdMn/hgdsizZr/Lka/mHx2vK8campQqS0FusR11RDq4HqhzB3sswuGZJyvxAf5HLFaQ+a36IP4BSGI1l0QRPQXc+r/0P/AXNaXUaMHDFXFQlbdlkRA/flWqU2O93uL/uUtvign7zcvHVCv5kVoCJVh2kqLKaIktILeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754756305; c=relaxed/simple;
	bh=nR2X7s3XzAMg7Jh5xr8ezkiYQpIyMXAwdpWu2LY5er8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9SFWeJlur4/wu4WJ+iog12bg+E56ttoEXRZ8wbGSCwrA6+oMx8LxUSbLDMRvX3ojlW8VEKXGqnfC2qn34y1sJh8t/zQjqD1jZoZfjjKWsvVgfDoWMV5ELQTmCff/aggUuxyGjcqiQPnc70/hXuU+iWJKdNyYyt/YABFe7BvdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrfxhvNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC68CC4AF0B;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754756304;
	bh=nR2X7s3XzAMg7Jh5xr8ezkiYQpIyMXAwdpWu2LY5er8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rrfxhvNY1Xma1bH/fKBsf09iN7y+fl8DiKnaeS+BlTh4cizsaQGF0wTAIVurPrwB/
	 Bdkv+a0wPPlCagIZcZTjF3NfqtaXp8R6KXA6zoJG7zbC0j/r8bLQsKcftFV6d49/ct
	 rpWwb5frvKo8qjdfVMoZbVZDeuYfY6LZd1NW2TJqe2twT+EIwZE9eE475/ibYRMTom
	 rE7xjPlrtSOiyQoY+hSrHXKH6Ilwo+iyQDHmVGSxRvFfb5ZeKONmQENRSx5fdT+H/t
	 nTNVsozhDG6viVrjAicRUS5azQYQzloLS/pgOA3Eu/XGrNxjqq5soDFsTNP5ibTdDF
	 m4NA7TsKBpLLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA566C87FCF;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 09 Aug 2025 18:18:08 +0200
Subject: [PATCH v2 3/3] ARM: dts: allwinner: Add Orange Pi Zero Interface
 Board overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250809-opz-audio-v2-3-f4fd15552a82@posteo.net>
References: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
In-Reply-To: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754756302; l=3705;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=rwwErTSLr++MWzr7FBwd2E7U9pR2ndpNt4EaJnJ0gxI=;
 b=UNB0zJG+JHbx/WEK9byBYkwHKR96kwXklUN3q3nyKKIbldkKzClVLmTI1r5YqJlV0SG59huMg
 oaeZ8XxD19UAbQAumRnof7/2vAsqpFTvu8yb1oijYquR5OP9ludnPBz
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Orange Pi Zero interface board is a (mostly) passive adapter from the
13-pin header of the Orange Pi Zero and Orange Pi Zero Plus2 to standard
connectors (2x USB A, 1x Audio/Video output, 1x built-in microphone, 1x
infrared input). Headphones, microphone, infrared (CIR) input, and USB
have been tested with the Orange Pi Zero.

CVBS output is currently not supported.

  https://orangepi.com/index.php?route=product/product&product_id=871

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- new patch
---
 arch/arm/boot/dts/allwinner/Makefile               |  7 ++++
 .../sun8i-orangepi-zero-interface-board.dtso       | 46 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index d799ad153b37b917d1e1c091fb051140398a574b..97d0a205493f40ba5969b5c8f4708a817ae725c5 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -182,6 +182,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-wits-pro-a20-dkt.dtb
 
 # Enables support for device-tree overlays for all pis
+DTC_FLAGS_sun8i-h2-plus-orangepi-zero := -@
 DTC_FLAGS_sun8i-h3-orangepi-lite := -@
 DTC_FLAGS_sun8i-h3-bananapi-m2-plus := -@
 DTC_FLAGS_sun8i-h3-nanopi-m1-plus := -@
@@ -225,6 +226,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h2-plus-libretech-all-h3-cc.dtb \
 	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
+	sun8i-h2-plus-orangepi-zero-interface-board.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
 	sun8i-h3-bananapi-m2-plus-v1.2.dtb \
 	sun8i-h3-beelink-x2.dtb \
@@ -244,6 +246,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-h3-orangepi-zero-plus2.dtb \
+	sun8i-h3-orangepi-zero-plus2-interface-board.dtb \
 	sun8i-h3-rervision-dvk.dtb \
 	sun8i-h3-zeropi.dtb \
 	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
@@ -264,6 +267,10 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-v3s-licheepi-zero-dock.dtb \
 	sun8i-v3s-netcube-kumquat.dtb \
 	sun8i-v40-bananapi-m2-berry.dtb
+sun8i-h2-plus-orangepi-zero-interface-board-dtbs += \
+	sun8i-h2-plus-orangepi-zero.dtb sun8i-orangepi-zero-interface-board.dtbo
+sun8i-h3-orangepi-zero-plus2-interface-board-dtbs += \
+	sun8i-h3-orangepi-zero-plus2.dtb sun8i-orangepi-zero-interface-board.dtbo
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
diff --git a/arch/arm/boot/dts/allwinner/sun8i-orangepi-zero-interface-board.dtso b/arch/arm/boot/dts/allwinner/sun8i-orangepi-zero-interface-board.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..e137eefee34163752372d442c22179b1fa41615a
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-orangepi-zero-interface-board.dtso
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
+ *
+ * Devicetree overlay for the Orange Pi Zero Interface board (OP0014).
+ *
+ *   https://orangepi.com/index.php?route=product/product&product_id=871
+ *
+ * This overlay applies to the following base files:
+ *
+ * - arch/arm/boot/dts/allwinner/sun8i-h2-plus-orangepi-zero.dts
+ * - arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
+ */
+
+/dts-v1/;
+/plugin/;
+
+&codec {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_ir_rx_pin>;
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};

-- 
2.48.0.rc1.219.gb6b6757d772



