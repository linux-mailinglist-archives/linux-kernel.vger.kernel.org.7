Return-Path: <linux-kernel+bounces-829646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD2B97874
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241853B4C78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F030C36B;
	Tue, 23 Sep 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="DDVVq1fb"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BD302175;
	Tue, 23 Sep 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660656; cv=none; b=abqUdYDSXncFBg4dX6nniNHA+dyeGdGEzv+PA+uTLW8LnmCOAEi67Y5YpY475+t6Pu1noGu0ltWx7UTZ2LIVWN1Ynjq5/sVFQZmmYGeHAiWUDidorpKosiAItKsw8eSnKDQyGruTQCxGlPa2Suftoct3cnX2MgQFpAXVlC61lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660656; c=relaxed/simple;
	bh=dEvl8dUHWdjXqzb+F5yMEhZlvn1Q4YFHqLFlnj+rFo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX2G66pmv3GVTXUpJIH3twgDDsc15UeSC8Mo1h5Y7d5Vo9hyq1Z5rt2BWMROQe7UX127Kj+FQqhAYUdEgfFqVIPWguQHckrPyvtOoxESVjieswo1H1aEDOx6vwyzNcdEUICK5DQIc0JxrEK7fSWUmhA2tv+FBbojtbdSEs6Zq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=DDVVq1fb; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=mSU6j7WeHblJ1jPeNVJeuj23on20kSxgchyldp7Dd80=; b=DDVVq1fbVGMHZJWdJ/NCwT2pHs
	d9TS+kFRrKuWK6DzF7+QLeAEl8wM7xr95bKk9H1hEZqA0l+nTnleQZsjXa7nAj6jiYqeUuA0DDU1k
	Voa4eytW99e35lHl8zwZTacGXhYeSSTF0c2FOk34T9soWMKWNNWnSiFif4T6fTyfXlukmTHvz4qYk
	wE71WVREryNx8oowAcBVFiHplvWJv4q5yWCHoJi97OUt3lYrZmgCmgNP/blaUl7W4A7hGt55xjJMW
	o6F3+OoboHbSFDTxTD5DXKtEf/vTI62//IheZUt3xRx3UmJHHggO7ohzN/aTenJZbfBGO6jLxcNvf
	OJrhJ5+g==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v19yI-00CFUv-2t;
	Tue, 23 Sep 2025 22:50:46 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: [PATCH v2 1/3] riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
Date: Tue, 23 Sep 2025 21:45:41 +0200
Message-ID: <20250923205028.2355244-2-aurelien@aurel32.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923205028.2355244-1-aurelien@aurel32.net>
References: <20250923205028.2355244-1-aurelien@aurel32.net>
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
v2:
 - Rename i2c2-0-cfg and i2c2-0-pins into i2c2-4-cfg and i2c2-4-pins to
   match the naming convention encoding the function number in the
   second cell.

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 13 +++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 66375fd1e9974..7df7f2c547750 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -111,6 +111,12 @@ rgmii1: phy@1 {
 	};
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_4_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c8 {
 	pinctrl-0 = <&i2c8_cfg>;
 	pinctrl-names = "default";
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index c9e9a844d2b1c..2a5e819160df2 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -92,6 +92,13 @@ gmac1-pins {
 		};
 	};
 
+	i2c2_4_cfg: i2c2-4-cfg {
+		i2c2-4-pins {
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


