Return-Path: <linux-kernel+bounces-885766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A1C33D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473FC189D84F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38829260569;
	Wed,  5 Nov 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WoxctGBn"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3127223DE5;
	Wed,  5 Nov 2025 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313903; cv=none; b=mBBAD7XylAimQCKAMaGbb1tMcbyx4VSz+hzVIIHpyMDYw8+GedZkj5xcZGuOd+cWvwUfZ9PTLn7qm+k2i4YVTtkJkVBKtv5QcAUAeyu0ZHArmXq6ns7vQfNpU8BnOIuz7A4XaKhgwnIrHEauBlx0kZX8WauIksxdZaYqCwhUpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313903; c=relaxed/simple;
	bh=za1iW/97Na7IqykeUeXIcmQhYVxz6tkFsOynk60wX7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLPuwjW9P5x0DBFmuvv1jt90/x4U/HZFsdndMEb8J6S3guj8BYakPavTPDc9cE9me2ednO4C+44TZ0nY6EtCwQHlvyS1LKDsLS1cr1wXdS+9Dst5oCn0S/cLihAnWMXJqqmdNBMtVECQyddCtv8QjEWADQ5iLyiDdr+WJahny4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WoxctGBn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762313882;
	bh=vuCR47oUhJumCT8fjZvIpM1LnjXI8nJ4RRggTSODh1U=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=WoxctGBnbPyKvZ06b5sc8KO/8LmcctpEZF0Y8xs78nEIBF8Z754MTHOCtPcpws+QE
	 zk6ceR/RYX72DWyGcjS3aD5L/XwKqDw2x7KI/Fk9JvPAQP27Rn9PNKJPjOEbkcbzzE
	 csP4eCaqSJN75xcfIxV8wu/Tibiu0grKsl8RpZJg=
X-QQ-mid: esmtpsz10t1762313877t6f7ec09a
X-QQ-Originating-IP: ndsRvCgevoxhv+OTVbjzfRaEyEjpwJqrHaCdIducQvg=
Received: from = ( [183.48.244.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:37:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5863978114994191627
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 05 Nov 2025 11:37:44 +0800
Subject: [PATCH 2/2] riscv: dts: spacemit: define all missing I2C
 controller nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-k1-add-i2c-node-v1-2-d18dae246137@linux.spacemit.com>
References: <20251105-k1-add-i2c-node-v1-0-d18dae246137@linux.spacemit.com>
In-Reply-To: <20251105-k1-add-i2c-node-v1-0-d18dae246137@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Encrow Thorne <jyc0019@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762313866; l=4289;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=za1iW/97Na7IqykeUeXIcmQhYVxz6tkFsOynk60wX7k=;
 b=UKWpQ0PR0KWAVDEJKvz8PF6cKOA9LPxwzW3ITOqWRmlA8MtADIwK+Xh3xLsdLb5jrJTYASF5H
 fCrUruzUPRWDClZUZWKPgXjQTwp247lusZgHrgtqDQdFpc4ZoqoRSQG
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NlrfLQhmr2s5YmI9JhnuSlq6cHSpf7f66Sr/JstzWwq+I9egZakn77f8
	5duuMnyc32NFsFiRLY6FaI5In0jHhMKRctPDS1+/O18TA3GuVpsKwPoc5K2YD/uDJomOZDS
	TiIlEwSrubcBHKrwKQm/LKhbnmVSdSWtxlb0t4MPiRXXl85f+KYvedEvqpANjXxXA74kGTr
	ZXzYFTcfarG+VA/zA5UxGeVrZ7jp3hdWjJYJH2zZ+L/WXGhBynX05RlrnO7pUuO5nvx+z0x
	zEHa9lgyb3BLrdClwHxEoj+OIxA3/CkPESsdG0Ze6gyxfEWTPMxB/kz+QMb6MqzG/H4FT/A
	XDOsceLPOnh1vMDVYsoEBR0/VjLfmhwKIreG1G3bYWschOvJo7OK+cEvFbUgqRX08/TyJHx
	08Ehlrkrry3sniCEmC3a8hFQ90Bh2+tQjwfVuyVQ8SD9dywOweobhXBvV/HZlh2x9iUW8FA
	x5zHT1HlrWLTv+gWHNd1h+hSCzpdL69tq/b41T1UkiFFDkRH9vuMp+mpZtSqun+YBln22KH
	67eKp0m1WAy04gKlsC9lIuXu7H3aodpilzVI8Ue7gz6vwUoNCt3dhjRxm+eJLHJ1T+ORtXN
	eCGh6IZ77cuokUyB4IxgralNGEO5sHKma18hlnIzWuvua+TlydmCrk1aoBiK0kObKIUi3nJ
	mPlrydG2o0UaXGROD+6OccjjUQv5Buo6YrCKz7ylCzzzV5FQ7K0cb6kbeeJ4WDziius3gRt
	0lV0tknAPQXU+EjbrYi5P5dVgJUizcc1zUTBGAml3SHvVT8Fmm/+5lHF7U1rErSaL8XQMwl
	UjkbL5ox8s5nNgmiuEhhV86e6EXHPkawOJFEJP1g+tRKMomGZWVygLOyDQ/jObivaBW1FZ6
	VYMnt20L6E3N7gjhq3JyX7kEtaxDQr55tNouPmGW9q/dbvYN7oSY6IYEjbc+KF21yyF8qFx
	CXAPOdABYtHOUYQIhruXXu0laM7DKzXYjtodibp6kggGxhEVbH67SPzhc9ixR+4lAu1JCyt
	dF76eCyQarBBRbuvHjx/p2TIHtpihatiCZARYpLlvpPhY/F8ArF3SCahuX6vsLtSI4MaLjh
	E70+E+bsn3+vW2KiOB7mB61bcHCQG4EnQZ4z/HhU/Hj7h+PIB4hz6CNTKtglnpU0g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The SpacemiT K1 SoC is equipped with a total of nine I2C controllers,
ranging from I2C0 to I2C8.

Prior to this change, only I2C2 and I2C8 were explicitly defined
within the `k1.dtsi` device tree. This patch comprehensively adds
the device tree node definitions for I2C0, I2C1, I2C4, I2C5, I2C6 and I2C7.

The I2C3 node is not defined because it belongs exclusively to
the secure domain.

All newly defined I2C nodes are initially set to "disabled", allowing
board-specific device tree enable and configure them.

This ensures that all I2C controllers(not include secure domain and
remote-cpu domain) are now available for use across
the K1 platform.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 80 ++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 5b46ce2edb059e22d878890b3b6192118dfdb2f4..843b7f3e2eef25fd3a44c4bec2b2280e33523f8c 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -358,6 +358,32 @@ syscon_rcpu2: system-controller@c0888000 {
 			#reset-cells = <1>;
 		};
 
+		i2c0: i2c@d4010800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4010800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI0>,
+				 <&syscon_apbc CLK_TWSI0_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <36>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@d4011000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4011000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI1>,
+				 <&syscon_apbc CLK_TWSI1_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <37>;
+			status = "disabled";
+		};
+
 		i2c2: i2c@d4012000 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd4012000 0x0 0x38>;
@@ -371,6 +397,32 @@ i2c2: i2c@d4012000 {
 			status = "disabled";
 		};
 
+		i2c4: i2c@d4012800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4012800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI4>,
+				 <&syscon_apbc CLK_TWSI4_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <40>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@d4013800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4013800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI5>,
+				 <&syscon_apbc CLK_TWSI5_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <41>;
+			status = "disabled";
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k1-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
@@ -382,6 +434,19 @@ syscon_apbc: system-controller@d4015000 {
 			#reset-cells = <1>;
 		};
 
+		i2c6: i2c@d4018800 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd4018800 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI6>,
+				 <&syscon_apbc CLK_TWSI6_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <70>;
+			status = "disabled";
+		};
+
 		gpio: gpio@d4019000 {
 			compatible = "spacemit,k1-gpio";
 			reg = <0x0 0xd4019000 0x0 0x100>;
@@ -472,6 +537,19 @@ pwm7: pwm@d401bc00 {
 			status = "disabled";
 		};
 
+		i2c7: i2c@d401d000 {
+			compatible = "spacemit,k1-i2c";
+			reg = <0x0 0xd401d000 0x0 0x38>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&syscon_apbc CLK_TWSI7>,
+				 <&syscon_apbc CLK_TWSI7_BUS>;
+			clock-names = "func", "bus";
+			clock-frequency = <400000>;
+			interrupts = <18>;
+			status = "disabled";
+		};
+
 		i2c8: i2c@d401d800 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd401d800 0x0 0x38>;
@@ -669,6 +747,8 @@ syscon_apbc2: system-controller@f0610000 {
 			#reset-cells = <1>;
 		};
 
+		/* sec_i2c3: 0xf0614000, not available from Linux */
+
 		camera-bus {
 			compatible = "simple-bus";
 			ranges;

-- 
2.51.1


