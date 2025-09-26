Return-Path: <linux-kernel+bounces-834490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C213EBA4CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBEA1B2611A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425A30CB5B;
	Fri, 26 Sep 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="hL3g/yeF"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6B2DF68;
	Fri, 26 Sep 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909532; cv=none; b=NQH5Cg7J8nB/0tjtbcM4G+SbPP9+AyP1hU1IwMLvHpiRNncJhxK0xTcsHKuKABUWPVFz5r0Wf3uDAi/N6KdKtUO8BiLEHOF3nbQI3Wt3Qepw2/lSWeTPwzE/binnI5wjEgdf5N1WkoUK4cHFkvi+Sb/Otd4Exj4m/VwsiXeRbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909532; c=relaxed/simple;
	bh=YhJ9qZhv5N4hcSya2feM7KsSM6xBvnTbqFFCd86Lv20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OztcuUd8oZIe5e6H/4Y4oHzJs0vv9cIogEgYJmfe2StVLqOhnJEI+HIzENchU1tBp69KQLFt3j7N2JDM75x50DHL9wm0sQwG2zUKFqLsIl59xVYm4fgJhVIVHlRdBlCDMCOOncMhyF6JR0Humk3gMyEVT33X9wMGJvkdkGT1hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=hL3g/yeF; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=rDfPxbH8etVG3SibKBYPPHLX/VPpgi1sHW77GO1UmzI=; b=hL3g/yeFst2yFZ3o5kBW4DoMbN
	q4RQdoOQhBQAOoS1/RP/OvdOekwjxtS/ZK7dDc/sJz1QWbHqeee0+QCW+7mdm3sY++ObP1DLs8Rra
	oKa0DWIKvmn92Z0lUMC+qzZNTBvCMKit9W94IEjOqbXzEg6dowmZ/MyprnwEZfSc7wnPGgLcCIJ0b
	s1cmReSE6n/2j3RoTusXNZyxwJUD+cgLQyocpHz/s6ZBB4/O474ZxgGrvx5pvHcgKxQdazxywag/J
	oG+d1anGizTbF2SI3vjqwv1mwPSyLWVrRsau3hNXy4fbZo2NxAYX4RFZVSDZwuAPZ+OVi5p0GQdml
	5ZPaRX+w==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v2CiP-00GPWI-1A;
	Fri, 26 Sep 2025 19:58:41 +0200
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
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: [PATCH v3 1/3] riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
Date: Fri, 26 Sep 2025 19:54:37 +0200
Message-ID: <20250926175833.3048516-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250926175833.3048516-1-aurelien@aurel32.net>
References: <20250926175833.3048516-1-aurelien@aurel32.net>
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
v2: Revert the name change for i2c2-0-cfg and i2c2-0-pins, the second cell
    is not a function number, but an index.

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


