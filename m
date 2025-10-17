Return-Path: <linux-kernel+bounces-857316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF006BE67F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E032A4FA337
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5130F93D;
	Fri, 17 Oct 2025 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="a2PQ3+8v"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689ED256C9F;
	Fri, 17 Oct 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680418; cv=none; b=gIUzVr67TZBAYzCqk35xNKMjtIT8nN79PcBU23YYp63S+ytHDKEbIXl3Qh5Yuj0llaGyGk4e8YRHiWqmt52AXltzRyClG7UP6CKmNBSLvAeGoUZTOMveHln52+Gzn87XhBws9PwlkiYqR0bCF0wVk/iTBYdZJtbI/nuX0Fp5hG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680418; c=relaxed/simple;
	bh=q9LRA4h3mJr3SEKt+t0E+rblVbMjhTzqT5dGm9ZJDKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKf4BqQ7HJ1PWAigMP2qkRB0ENKu38AaO6+Svk2/bdSiORnLI/mRzEzuPre/NBMJ0Mh0ao7TO1c5yznuOv2QeShS4dStKhX206TZUR9uY0oA1EqtQYkEhyaHDLPNC4eXD9AhxQfr6MC54TNP0+fwZ4eM8lWb+lCA4ZqePpk6NjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=a2PQ3+8v; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760680404;
	bh=LVADmxXBbozwcINYt1G5AcUgKaMNIsBCDxG/7Xs5sT0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=a2PQ3+8v3zOQ09MzwRXm+dU1rjI8yEaOBWpIT/zDUrEG7klfuYnWJ9S/iBMhEOLS+
	 2IT2O1l8FevZk38aIxEfSMQaRyvh63BTb0h8C9P3MnQ+mDB9XXswE4qI0k8xePxzg+
	 HP3H9gsAanfBwZA3Qu7Xg7EvvQXI/jVfj1wPZz24=
X-QQ-mid: zesmtpgz6t1760680399t70296d4a
X-QQ-Originating-IP: 5oCZgJmoQ0FSZ5t6CA5RChKzD1Qy/s2qWWN8VRUBU8E=
Received: from = ( [14.123.253.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Oct 2025 13:53:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17574647453569216988
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 17 Oct 2025 13:52:26 +0800
Subject: [PATCH v3 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
In-Reply-To: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760680388; l=4977;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=q9LRA4h3mJr3SEKt+t0E+rblVbMjhTzqT5dGm9ZJDKo=;
 b=o/YWvFZZsuxra16nrUiXQOcg935Ah9M33JLr8e2ZbRUlXDjYsNgfZ8Y8pKmdFjao0hQIhJtM1
 Cbul26PFPoFAAkoo9+mefmrlpn93Bgzb6ShU4z/zed2iQPgFt9/zVSZ
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OIE+G1CPd2p357vwo7nZI0hcsRrwLJ81NMYhQ7+gG8fe/E3y1QYvudzM
	QvWQBLoRvykHk/mnZ4VtIuj4g3a+rrnoE58LuRDUj4dgN/6l5eVZgbGLPf0XIoYBkJ/f6mT
	NWEd0mwvZXtWQNogXzW8EDX25+3iaZ1nw4SKxST0JvyThrYvjIBWwRsPtH9xg3GhFKW76WP
	uQ68USK+FtkaoUIq7onM43xWcdhUgcpdKQ6IpP4T2KW0rAyjD7Q0slng0DE6/bKiRoV2ZEd
	B7KSCLa9iFhVh0QDVbLz0CIkrGGeL23Qw6HMoOTksqyfxEyeBRejXvKaqw472IAwOPZA3Kh
	wtkIb917mKbQN+t/qWPqH1/fzZCUbxhd5fN9yAcbXjnukojemFlJ++mtVKtgOLQGTfTG/9f
	jbimBNTepQBIyP52/CluaGsC6Ixf+A896f6iXmJdIi3Rv6MvAxfudtxuMWfCdQ0kYus3Bib
	dbQE7ctP8u90AQODwO0sbQ5Whc0ygEP/wS7kq/7vilvZeble9IWD4wdYHZbg0lWtkHR1BkZ
	5d0myOONiMPrYcuZuj7utcl97UEe5K5No9PukKacfn2aCdMtPH1f/+GA8XJzv8J0iIxCo6j
	WMfBTN/davj+ayfJ8wl+KnH0k1flmGhTrV682V/LI9zf69GkMnYID2Lir7v7s6QGm1O33a7
	Q+wPBk2clIn848fLZ5iDNGCPH+fW9TYIC921+zga5/+U7ABdm55ndpOFdKgOFm8e/t/5565
	8PEdvy7/zZZ6X3dfZsMEWqymQ3tjdAbenGd3FPleIGCKW3CzCy6zDTVxN8mziCh8u0FyZ5n
	iik5Tc6hfDkWzD31lWBU1mJh6qk93faWS8tZgtx/8aq1OgYB9Gxp+e3dilkOhwyTJf3cb65
	Lrf2j1OpIAvexo1c9Tt8BcX+YEFoTaljlcZOE3f2jlH1JYXbVt3WnsZrHgOw5qIRWnbLb2e
	Jd53Q5lENmpQCRfusV1ppLk2KfWljHPCtzOJwGHAoKTUSVXzx2EyMTRdXG6vSyuaH89nwjP
	Z2PsOd2np7UxFNtAtJvyiKL/oDbQYl5gKGnE9ypGcFsCVTPOrMjOxGPnQdDajtwe/b1cmLO
	y3KyGytm9AVZ0tI+Cs9gb0uxYuix1yHCaET4V7Ula5+TAGGG/RyoJGCz31S4QnD5an4W7XV
	i3FMNJY8a3gETlTVeukXI/0MPQ7pO7g9lQjB
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Add initial device tree support for the MusePi Pro board [1].
The board is using the SpacemiT K1/M1 SoC.

The device tree is adapted from the SpacemiT vendor tree [2].

Here's a refined list of its core features for consideration:
  - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
         This suggests potential for light AI/ML workloads on-device.
  - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.
            Sufficient for various workloads.
  - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
             SSD (2230 size), and a microSD slot (UHS-II) for expansion.
             Good variety for boot and data.
  - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
             Standard display options.
  - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
                  Ethernet port (RJ45). Given the stated markets,
                  this should cover basic networking.
  - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
         Decent host capabilities.
  - Expansion: Full-size miniPCIe slot for assorted modules
               (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
               general PCIe devices (SSD, PCIe-to-SATA, comm boards).
  - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
  - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
          for cameras and displays.
  - Clock: Onboard RTC with battery support.

This minimal device tree enables booting into a serial console with UART
output and a blinking LED.

Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v3:
- sort dts node
- add ethernet alias
- add emmc, pdma, and eth0 node (a squash of patches 3–5 from v2)
- Link to v2: https://lore.kernel.org/all/20251010-k1-musepi-pro-dts-v2-2-6e1b491f6f3e@linux.spacemit.com/

Changelog in v2:
- modify commit message
- swap pinctrl-names and pinctrl-0 properties in uart0 node
- rename model: "MusePi Pro" -> "SpacemiT MusePi Pro"
- keep the dtb-$(CONFIG_ARCH_SPACEMIT) entries in alphabetical order
- Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com/
---
 arch/riscv/boot/dts/spacemit/Makefile          |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 78 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 152832644870624d8fd77684ef33addb42b0baf3..942ecb38bea034ef5fbf2cef74e682ee0b6ad8f4 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
new file mode 100644
index 0000000000000000000000000000000000000000..590c9bdbdfda4d6ddd97a96e10fcaef0a75f3390
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
+ */
+
+/dts-v1/;
+
+#include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "SpacemiT MusePi Pro";
+	compatible = "spacemit,musepi-pro", "spacemit,k1";
+
+	aliases {
+		ethernet0 = &eth0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "sys-led";
+			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&eth0 {
+	phy-handle = <&rgmii0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&gmac0_cfg>;
+	pinctrl-names = "default";
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii0: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&pdma {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_2_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.51.0


