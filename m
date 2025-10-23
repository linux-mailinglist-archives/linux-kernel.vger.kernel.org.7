Return-Path: <linux-kernel+bounces-866390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E215CBFF99C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B01A06E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A02C11D5;
	Thu, 23 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="BqvYa0XR"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413324A063;
	Thu, 23 Oct 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204541; cv=none; b=nWts44siZewy8G3Q5tCQoZ9eLzLFpMzHQRENoF8NfPqB1CFKT3njYUngP5AwbFaA6lqBAYLNMhuAA93jSBpYqiaUQvWMKHxIrkfxNRYzgGhPktzTeJesyQM6Y4N+Wb0f2bg0UVulapu08qbHWR+kcwhRjcOK/KElm7hHQ0HhCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204541; c=relaxed/simple;
	bh=Ng7sJU6uriYTf5rZYSyCQyjKItQMSXxOIfj5WN50fKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkSaN2QGiXlFgUVRPSIILY42gyIMxks3ssW/k7Qc1ta9PYj76USEtBXfl+F3/KSRI+enYgblzgUI53ciDJBdNdDd6489v+kcn6u6YXDuTX/DJ6/P/hO4RWOamOVAZc3p/i//PXIJFx/dn7s3nB/mGScYhs9zbd/skZ4k5g8/8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=BqvYa0XR; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1761204527;
	bh=joD46nXQLvIHo+j0HgWSZvew9QJQpcw/TMa5i9hHU8o=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=BqvYa0XRESYkp+lyWUfXCf7Fj6HMkQ7MdIiOZjc+7mg5sY61Q6U5FAwrop2Qxy86Y
	 JDGRVRmoc3uUFAIrLXC1z0wPKG1m9kFvXVt8esMGrkdRTood6DRBbra1K11DtJY+hZ
	 cYFCCbcblS5iTORd8XRFCq2hoKkbW45MhsIaz99o=
X-QQ-mid: esmtpgz11t1761204522tff170d3e
X-QQ-Originating-IP: B/S5rV3PQQenjL7i6qoZ3M1T7tn3dtYmHjmxvlqnzvk=
Received: from = ( [221.4.210.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Oct 2025 15:28:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5281825611618668887
EX-QQ-RecipientCnt: 15
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 23 Oct 2025 15:28:30 +0800
Subject: [PATCH v4 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-k1-musepi-pro-dts-v4-2-01836303e10f@linux.spacemit.com>
References: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
In-Reply-To: <20251023-k1-musepi-pro-dts-v4-0-01836303e10f@linux.spacemit.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>, 
 Paul Walmsley <pjw@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761204512; l=3829;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=Ng7sJU6uriYTf5rZYSyCQyjKItQMSXxOIfj5WN50fKw=;
 b=Aiw1SmBTfBNhi223fRNMnFvCpW5ccu42hxskoJ/AmhWNppC6CFtRZ8W+4PTH+uXzpai3WFagS
 F5w55z1lylfA5u6xmrZuAvQRQP5QrZugPyMHHVontQjsiZZHLPfx+KY
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: No2U+TjUQ3cypojtCejXczU2pBcHEXNeGY3dDtHEYlyus4/Bg7kVuEJe
	QvsrBPudOD86kCjhg+j3JU7ITCvvMi29b+M+4rX5vN8DFAWIongYfQ/RWjp+P1IFmbpuRVv
	VbpREdPjDlQAV/2D34SQTCk2s91oVgDy20BP6BP7bsE3aV4QFb7oRPqvl6KHjaoZVYBAIiZ
	c/AqtZn1MqT9+Q4SapYiEapXbEBedCFWSTBHEfmY4yITtWzehu/tfnvch6VS2O7xpU3MlwJ
	rCl4zIv0T0tVqysa02j7qpHs5EAcZSgvSDAVY+9WuudRDFz62nQ1wo5rXnZ9l8+uzisXs1W
	DVhdgimvwMTQbkf+uUTDiNaMVuWyMxmNMXzq0TGIY3zOGqTev7p41HPtm1/b6lKt5gRkgcU
	prvVEuCqJR3VKiixNX13dic3EEKDvxk+jk20liNYapAQIScB7KlJs/JEUk1X0DyUbc/pEvE
	BHqqxDW5XBL0kSV94ELyteSUASqMS40zgbWTcPnROyH2fwJ+6oOT8ow7Dobm5efz7n0nqdM
	4oSK2v9t0uvIaH/lSe6FsAS41OudgAZefqv61Ks32JT8/uzji453wwWKheJ/TLZoeuYgCSk
	nGzEMPnVhxvqs4Kq5STzkV/hTz/o+nTV2BHGCtjGHTrjTM/qMZF7IWUzB/Rj4ZUVPRe7iHh
	EBGW0ewYX3SbPDKVjn5es8nLzM2D8ChRMLhpZgLXzucku7W742W7D7PC3mWDmDz0e8JjnRI
	dDF/uM2xLGGd0KE7gISE9geE0aGuHo7ur+JamWgiC8RvxwDZoYEOxLqUMCoYTfYlu8MTmJz
	uKLyo7y6pHdbuVNSkblVAM+mQABfsAnlsQzQJmWUXqL6+RzeLeDX931fDYASvo2QZ2A8+aH
	mGvlAN6KVDKbUejapELwX6q3bvCM2j0knrWeDnApssXLCJYGzJODfmlSBLu33hCUEwQsPKC
	W+4QRMljo1MKvZsbqcZsXyF/bVFCfDwXpYLeRP2/y+HxIqDi6Y2RNnnIGlv9PPxz5Peqs9W
	5ar6jebuw+9+xmURP6T1GFUPxJnjnyS+pr/mAiDKOhfIU1TGzmbowgykpkeIOHwoE/hk/1a
	jd+bfSfaDDbaO5+jIbHKyRg2Fx9Dr2CMYsfQ4W2CGo9vVSkxvg0MaL2rjo1omK6q71O/qNI
	shAaD2G9kQPzo6k=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add initial device tree support for the MusePi Pro board [1].
The board is using the SpacemiT K1/M1 SoC.

This device tree is adapted from the SpacemiT vendor tree [2] and
enables basic board functionality, including UART console, LED, eMMC,
Ethernet, and PDMA.

Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
Link: https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v4:
- modify commit message
- add SpacemiT copyright
- Link to v3: https://lore.kernel.org/all/20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com/

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
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 79 ++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

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
index 0000000000000000000000000000000000000000..29e333b670cf0a5c4ed852668460db475b9c44cb
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 SpacemiT, Inc
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
2.51.1


