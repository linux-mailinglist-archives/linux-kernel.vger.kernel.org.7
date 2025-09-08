Return-Path: <linux-kernel+bounces-805706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D7B48C81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA77116BE53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6382FC026;
	Mon,  8 Sep 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mF6Myaxr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C42A1D1;
	Mon,  8 Sep 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332137; cv=none; b=qT88Lr/lfO74YDEHWgAWz34j5wvMVWbMgsx8L+RjRMPg3ANTeiO2IdVZYpxWmmcvwpeOORxyqdaaqISjOn8QPtFOh8phA2yaCvNgqiK1BVf4OHLzkEFw8PVvnhSn35Pq2R55vn2Hanqs+nkuMJwm+bCZfux+4o70rieWNB9LlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332137; c=relaxed/simple;
	bh=khzirs232ONv9Ti/rgyEG1nzqfuQZeNc7eGF+WvAWTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScM8sFGvTjyDJhrpM7U34aMCHNFSdUHa8BFQeM0JaPOcJ+XZhkJ3QA92QQ+O+iytS74PsNde55ql02m11oaLbFeMY04/62gw4Sua3MoXTMkTpusR5WIOuUdKnjpmehGsJ2VkDvHPL56dOr8WBJjFIRrX5cGFGX+n2jl0cx590aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mF6Myaxr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757332135; x=1788868135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khzirs232ONv9Ti/rgyEG1nzqfuQZeNc7eGF+WvAWTw=;
  b=mF6MyaxrTk8oCibTopOL5D5cKFEBWy7EuyuPEqup8lhGQysM1js2dr5x
   4le0oW+h0SXJRwIVwpHXUlXSAEWu3NSdewYkpgy43js/2Ehx1DkUEejqS
   UGyGJvXVNDZSQBHfU3zOjE0Kd8qJRlJlb79xItfx9bGBjpbcDlLGo40li
   mU7xa5os7WsuJN3jD3DpNcjps68o2iBnKWGWUSPkpdMR7omGlV2CSbujp
   ALpmUrRyZskGw1JZWR0JQ8pTuv87da7VO4ExNPHxoAmZVBwDQVxStS4tS
   Mg2c8yRN8Y1oZm/VI2KcIkBHWxY4bQstXn5iyhmhMHybUOAXZR0CLcd/r
   A==;
X-CSE-ConnectionGUID: vDOPHTnsQiaqmkXt9yltVw==
X-CSE-MsgGUID: CFRpFRBqQ0+zmhKj6MR+UA==
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="45634878"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 04:48:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 04:48:43 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 04:48:40 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 3/6] riscv: dts: microchip: add icicle kit with production device
Date: Mon, 8 Sep 2025 12:57:29 +0100
Message-ID: <20250908115732.31092-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the introduction of the Icicle Kit using the production MPFS250T
device, it's necessary to distinguish it from the engineering sample
(-es) variant. Engineering samples cannot write to flash from the MSS,
as noted in the PolarFire SoC FPGA ES errata.

Add a new device tree (mpfs-icicle-kit-prod.dts) for the production
board which includes the icicle kit common dtsi and enable the system
controller SPI flash, which is only accessible on production silicon.

Remove redundant board compatible from fabric dtsi and update board
compatibles for v2025.07 release, which includes Mi-V IHC v2 for AMP
cluster communication.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |  1 +
 .../dts/microchip/mpfs-icicle-kit-common.dtsi |  4 ++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 23 ++++++++++++++++---
 .../dts/microchip/mpfs-icicle-kit-prod.dts    | 23 +++++++++++++++++++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  3 ++-
 5 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index f51aeeb9fd3b..1e2f4e41bf0d 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit-prod.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
index eafea3b69cd7..5c7a8ffad85b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
@@ -134,6 +134,10 @@ &i2c2 {
 	status = "okay";
 };
 
+&ihc {
+	status = "okay";
+};
+
 &mac0 {
 	phy-mode = "sgmii";
 	phy-handle = <&phy0>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index a6dda55a2d1d..e673b676fd1a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,9 +2,6 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
-		     "microchip,mpfs";
-
 	core_pwm0: pwm@40000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x40000000 0x0 0xF0>;
@@ -26,6 +23,26 @@ i2c2: i2c@40000200 {
 		status = "disabled";
 	};
 
+	ihc: mailbox {
+		compatible = "microchip,sbi-ipc";
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
+	mailbox@50000000 {
+		compatible = "microchip,miv-ihc-rtl-v2";
+		reg = <0x0 0x50000000 0x0 0x1c000>;
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+		status = "disabled";
+	};
+
 	pcie: pcie@3000000000 {
 		compatible = "microchip,pcie-host-1.0";
 		#address-cells = <0x3>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts
new file mode 100644
index 000000000000..8afedece89d1
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs-icicle-kit-common.dtsi"
+
+/ {
+	model = "Microchip PolarFire-SoC Icicle Kit (Production Silicon)";
+	compatible = "microchip,mpfs-icicle-prod-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit-prod",
+		     "microchip,mpfs-icicle-kit",
+		     "microchip,mpfs-prod",
+		     "microchip,mpfs";
+};
+
+&syscontroller {
+	microchip,bitstream-flash = <&sys_ctrl_flash>;
+};
+
+&syscontroller_qspi {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 2cb08ed0946d..556aa9638282 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
+	compatible = "microchip,mpfs-icicle-es-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
 };
-- 
2.34.1


