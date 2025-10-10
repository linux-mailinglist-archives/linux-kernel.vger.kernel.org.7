Return-Path: <linux-kernel+bounces-847667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73BBCB61B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB90405E14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834FE23BD02;
	Fri, 10 Oct 2025 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="m/VCsbNA"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFE288AD;
	Fri, 10 Oct 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061422; cv=none; b=GZY3Q8HoJchn0RyLVcTM+Jsy0FN9G6gbDXNCHuALlV/iDuk/F5hPHMNOeAGynmOFR0xy2f+An/y+bWJez4IYEeWA6gqvs3oXOVNSpIotgrM1MHPS96rtk1OEMKxsjzeYDNEqjrMLbnY25xGr8KI4gG/ndfVAGCXpW6QoaKf753Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061422; c=relaxed/simple;
	bh=VjPixKGIPSWJzfZt2ZyF98XbRgKw9NPN4uHrBMVdns4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISBSgVM6/gH3zHRT/wHpkrMxBQ2gWT5OzfVze0LnB84kVfvVem53Xup9g2rpbhphZdzYJKM3xUZ4X5LmTOO0k6LI6twEHMiyOYxBLFBSSDgMdznPLCwegMQq+mMTrNsG+EZMQTRcHEVPX5cnQllF/+gsE2eYadoLHszfTOxXTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=m/VCsbNA; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760061413;
	bh=6GEc5zsgut2bnlpv/jK06yid5ojSc7UZYyVZwOJVrww=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=m/VCsbNAWy+BzZcxD93LQVRJpbv36SBb7FZB9ZY+Se1BTl53QvYejtGQa8UBbF7p/
	 ANJYguVD5ebWATaJYe6ZndtfeAldWSn6r22j6HfJFc/ExPppSRWrmjfQ7QoBFLRi5U
	 4E4Trhnr+5fPpChq9Og1QTXygTmaCwvxfUhpwSG0=
X-QQ-mid: zesmtpgz7t1760061409t51c12a8f
X-QQ-Originating-IP: WsJuJ7joUIEYVadBiCM8TpUaEtQ/VVMoTuhfwSq7zWM=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 09:56:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9563484237322633113
EX-QQ-RecipientCnt: 14
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Fri, 10 Oct 2025 09:56:31 +0800
Subject: [PATCH v2 2/5] riscv: dts: spacemit: add MusePi Pro board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-k1-musepi-pro-dts-v2-2-6e1b491f6f3e@linux.spacemit.com>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
In-Reply-To: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760061399; l=4072;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=VjPixKGIPSWJzfZt2ZyF98XbRgKw9NPN4uHrBMVdns4=;
 b=A/m/FHWBFUdGxFfgs3ieRTfb/VZpPHeoYY5vznZf39ETrKG80mG9SF7BVI4n8uHkLePrXGf0S
 br7xLEvU26TDIO2opvjInYyVOuEG5tjz0mA+JyRqVaHRFj2WfwEaRPD
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MAZ8JyhHyFDifTf+UYScEdS69OkeiRxwlT6qL/U3ofoAwiJbUmvMg3TH
	DUMR9/TnkU7/r0D7ePXWBGzzAOY77vzDYcrvcgiky+FJ7ZBZ+7ELWVxsNlLOM2W82YeBjZM
	WbC8VTmoyw7Nf+9GmeRArbwXvn0bdfnvq3W3npXgvpyqjG0n+CKGYhU+po4DHnlLa+7AeB5
	Pear5F2t4kHu9iHkS1wC/6GmVrGlz/8krB2fHoofrhw5HqLjAahTJ+C3ncehTn0BBc0jToY
	UYarHaQS8mLis0LweA1ip76Y5iYrkxWksFGgZnW8B6q/NIMnPMyWdXrBiCYryT7Lyt/Zzlj
	9CC+m4HSaw+evNzQ1eZWUUNH8rJhGpjxrEYAJc5R2Vlb5Y74Ii801zDP+h4HIi7MvwIXLND
	lUpNZwkWKUclE5NNnPh3KZJ+XOc6+W9/d2Xfps9M2F3ia9oudioekcVHyAMJEP0z1F+mvZe
	NKVUUhOuywHlaljQJYzZdsDKri1wDqzpqbHn4XJ0LFFbBJXxftAJCP4U/Mh8SEWZ5JeoP8Q
	SyTwX3zU7MoJB0gq3QmMWuC20VHnk7GD3QSL1UNJZKbQmWw4eFwp91qKipPWBzAs/AqQ6Mv
	Uw1KnntDWbXYcvahcg90fORmTBdE9gLRdyoPgAw4XI6GSSGa57NmKY97rE9euCJlEw4sImt
	Yz8oUywJaXx3K8kzp6FUiLVWxkn+ytbOsJh9QJzc8vDFddC+SqkGDVbzMznL5MAEJ8PXkxM
	l9Adr3k7/aTH6CpcHLbVaA1IIE6WdxK3eJReDz3FFTWqiy9XpW/r1dLuypSMqY/f6M4qoZS
	89PqQ3gn6hhH69boCsG0iZ9jTjkU5Q2MXZFrdTIhs+mkGESpNLNXUQx4eyzIxfGrrMc6GC3
	jywGl0o3Y8D3EpO5yXmFme4os/wz9J+XxERBNfhjpg8/O4+1UH8kVYKsPHEnHaeY/qm5YK2
	EuW6se/x/D+55BOCPsgfoOuocc76Bt/WnmwhciRu5X7XxH3DZfQFzujQg2+G14ABSoegEZQ
	JsbeBzqNJl9gcvNu0bF4dH4nmjIkg5MT+509r6O2aCAfyPYY/8cNvAmdF3mV+dRVci2VQSc
	So03y7W1Tni9hYi0+0cLArNoPPVWEahxCreyL9N6uVrXgyqhq7xUVVgOFPMWbc56yAvpl3y
	0jh5H2Aa6f9Gn98llAwgorbC4w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Changelog in v2:
- modify commit message
- swap pinctrl-names and pinctrl-0 properties in uart0 node
- rename model: "MusePi Pro" -> "SpacemiT MusePi Pro"
- keep the dtb-$(CONFIG_ARCH_SPACEMIT) entries in alphabetical order
- Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com/
---
 arch/riscv/boot/dts/spacemit/Makefile          |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 40 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 0000000000000000000000000000000000000000..49c41ce785cded31c9937d8244d9bc99dcd1e1da
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -0,0 +1,40 @@
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
+&uart0 {
+	pinctrl-0 = <&uart0_2_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.51.0


