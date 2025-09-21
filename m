Return-Path: <linux-kernel+bounces-826405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD423B8E71B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5631420196
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8C2BE7B2;
	Sun, 21 Sep 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="U340dvpP"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADCB2356D9;
	Sun, 21 Sep 2025 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491145; cv=none; b=UL3EHdzp6uU2VTUjwnWxWtdiS5AV23Upep3cFfOZmuAopsy8KX6T5lOXtggrmqmozILjHsgUU7Vp4sEbUXxr6CegTnr+cd5EYnkGwEgf/aRgDd9Rmbx0wZpIzHTvyUL82LABU7J6ax8OjIP6Rk/If39OT8NhQP1ENyHNcdnRi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491145; c=relaxed/simple;
	bh=GiN8vzNbE/2rw0RjK4WQKhlSdVyJ+0EOVZcoVVCytec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZP1b+NsH295dMxpjAZ17YKZx5b7imdXjeriMg7N09qRN8iPPFjfd/aDMCvzhATnmzJ8LzgNnEVEN6arK9kLPpm/zvKQZl51c11/IeKJ2OynKw/6Xs3CR092K9H0rSKzSXOtXZzKUcQVZG2Mqu6g5klIyJRqeCQIkOcX0i3Dluw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=U340dvpP; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=YD4Voc8FBU0N9kAG+O8O976rZpeY6nJnOQhKE1mbL14=; b=U340dvpPaOCCnzI/Lay56FhnH0
	e/iVfyazp6p4n+wLkNO1Utp78+6d3AGLQGIgfrAsfBWnajOVS1Uq1B7MZDMi+034Vgp6TVQa7Upbr
	t163zMgSJ8gpIMp/AFpjbcjYVYeFd80e9dmSZYnMV5hNi7emoRas4Qe+RTwfr2wAEX0TSLFIr99Go
	Gx3nZFArMwGMccIW2kgiJLht6S+4EIYndYsXjDq9rk4Q6BPPhxR2gc5v9xC+vkCGZ0pEvltz7RxDJ
	DShKq0v0KhEwi15TWmC1Dbai7FMqsgKDTv0PThxMNPqkqoLKC+wBChzzcqmct2NFwl+XBeKpzEZmV
	O/0sFj3g==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v0RCo-009LbI-14;
	Sun, 21 Sep 2025 23:02:46 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Subject: [PATCH 1/3] riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
Date: Sun, 21 Sep 2025 23:01:41 +0200
Message-ID: <20250921210237.943370-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250921210237.943370-1-aurelien@aurel32.net>
References: <20250921210237.943370-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define properties for the I2C adapter, and enable it on the BPI-F3. It
will be used by the 24c02 eeprom.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 66375fd1e9974..3b6e4f52e9aad 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -111,6 +111,12 @@ rgmii1: phy@1 {
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c8 {
 	pinctrl-0 = <&i2c8_cfg>;
 	pinctrl-names = "default";
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index c9e9a844d2b1c..d565882c46dd7 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -92,6 +92,13 @@ gmac1-pins {
 		};
 	};
 
+	i2c2_0_cfg: i2c2-0-cfg {
+		i2c2-0-pins {
+			pinmux = <K1_PADCONF(84, 4)>,	/* I2C2_SCL */
+				 <K1_PADCONF(85, 4)>;	/* I2C2_SDA */
+		};
+	};
+
 	i2c8_cfg: i2c8-cfg {
 		i2c8-0-pins {
 			pinmux = <K1_PADCONF(93, 0)>,	/* PWR_SCL */
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index bc61a380baca8..d4f38ded52c93 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -497,6 +497,19 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
+		i2c2: i2c@d4012000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4012000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI2>,
+				 <&syscon_apbc CLK_TWSI2_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <38>;
+			status = "disabled";
+		};
+
 		i2c8: i2c@d401d800 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd401d800 0x0 0x38>;
-- 
2.47.2


