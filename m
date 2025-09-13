Return-Path: <linux-kernel+bounces-815367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05031B5634D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FC41B2649B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82088242930;
	Sat, 13 Sep 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLYp7MnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171328689C;
	Sat, 13 Sep 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799067; cv=none; b=Q7Bq/1TvzqeGrc3CtsAelUvbsa5aSzHh0EWU/nFdP0FniTUEjdMngTEr4OYEeNlcXK7kWm8dj7fuNuWc7rxZqokx9H9LsP/dbt7bvsT1tcaEnii2SIsLJ+eJHo4Pgwr44/7k9dFCSKwCQlD6Zp0E5oRiIgPu7Diz2yY2/FsL0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799067; c=relaxed/simple;
	bh=ROziO+R3VmC4VR2DFaqybvemVQOuiZGsH20u0Q0dkX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9KELL5884GRgHlfG8vVVcHfwlUNvzPLM8qnpsL0zJ36oKkyZmLdSmvuzDMnbhU7Apc/bI7RNjQI33lxaensE8LvF9/3AqgHJMTKyQkd52F76AmHwLiBu5nRC5hdeo4vfhlvhlRTSyGOk1e0sEgwRIWYFLaXDrp+rorS0Fso0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLYp7MnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1141C4CEFB;
	Sat, 13 Sep 2025 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757799067;
	bh=ROziO+R3VmC4VR2DFaqybvemVQOuiZGsH20u0Q0dkX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TLYp7MnO2YyDeEmM3PVy7BIP0BZAvvh13gDY65vzgYxKjQI7OmAgc6+/DH7aE0XjW
	 qox3pr0clWeommspMtn5cYm6JBMQVtYvGBSXqp53mmF0ZYEFqDnANSDJl0kUw7ue7K
	 qc7lJJ0jnnRXy9i3Sj1ApMD6o3UzjS0R1KWDoWKBTj8ALHKtiPCixs9lsyvvqFmvwt
	 bIb0GSUyovHvfo/pk8otEwlsQq/eJePzWJtpseb73mWC/HrJ91U83OsvsqNsH9uuWD
	 EpXglKGM5S+q2/2UvMqZrnGAt74HKVe+2oiyoadzH/pES2rV+VkJNnBGU3VntR06xX
	 hARxvrIz+N5pw==
From: Drew Fustini <fustini@kernel.org>
Date: Sat, 13 Sep 2025 14:31:05 -0700
Subject: [PATCH 6/7] riscv: dts: Add Tenstorrent Blackhole A0 SoC PCIe
 cards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-tt-bh-dts-v1-6-ddb0d6860fe5@tenstorrent.com>
References: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
In-Reply-To: <20250913-tt-bh-dts-v1-0-ddb0d6860fe5@tenstorrent.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
 Arnd Bergmann <arnd@arndb.de>, Joel Stanley <jms@tenstorrent.com>, 
 Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.2

From: Drew Fustini <dfustini@tenstorrent.com>

Add device tree source describing the Tenstorrent Blackhole A0 SoC and
the Blackhole P100 and P150 PCIe cards. There are no differences between
the P100 and P150 cards from the perspective of an OS kernel like Linux
running on the X280 cores.

Link: https://github.com/tenstorrent/tt-isa-documentation/blob/main/BlackholeA0/
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 MAINTAINERS                                        |   1 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/tenstorrent/Makefile           |   2 +
 .../boot/dts/tenstorrent/blackhole-a0-card.dts     |  14 +++
 arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi  | 112 +++++++++++++++++++++
 5 files changed, 130 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2cb2aae8d66d21bf5c13b16b3b1d8fdc98b9462..20605d7530a6d19e928709647ea91a9cf7913ee7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21748,6 +21748,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/tenstorrent/linux.git
 F:	Documentation/devicetree/bindings/riscv/tenstorrent.yaml
+F:	arch/riscv/boot/dts/tenstorrent/
 
 RISC-V THEAD SoC SUPPORT
 M:	Drew Fustini <fustini@kernel.org>
diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 3b99e91efa25be2d6ca5bc173342c24a72f87187..0624199867065dbb5eb62d660f950b4aa3a7abd7 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -8,4 +8,5 @@ subdir-y += sifive
 subdir-y += sophgo
 subdir-y += spacemit
 subdir-y += starfive
+subdir-y += tenstorrent
 subdir-y += thead
diff --git a/arch/riscv/boot/dts/tenstorrent/Makefile b/arch/riscv/boot/dts/tenstorrent/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..009510bea6c8e558bda70850a7f8490b23bffdea
--- /dev/null
+++ b/arch/riscv/boot/dts/tenstorrent/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_TENSTORRENT) += blackhole-a0-card.dtb
diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
new file mode 100644
index 0000000000000000000000000000000000000000..b2b08023643a2cebd4f924579024290bb355c9b3
--- /dev/null
+++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0-card.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "blackhole-a0.dtsi"
+
+/ {
+	model = "Tenstorrent Blackhole A0 SoC PCIe card";
+	compatible = "tenstorrent,blackhole-a0-card", "tenstorrent,blackhole-a0";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x4000 0x30000000 0x1 0x00000000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi b/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..517b6442ff0fe61659069e29318ad3f01bc504e2
--- /dev/null
+++ b/arch/riscv/boot/dts/tenstorrent/blackhole-a0.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright 2025 Tenstorrent AI ULC
+/dts-v1/;
+
+/ {
+	compatible = "tenstorrent,blackhole-a0";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+		timebase-frequency = <50000000>;
+
+		cpu@0 {
+			compatible = "sifive,x280", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			mmu-type = "riscv,sv57";
+			riscv,isa = "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
+					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
+			riscv,cboz-block-size = <0x40>;
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@1 {
+			compatible = "sifive,x280", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			reg = <1>;
+			mmu-type = "riscv,sv57";
+			riscv,isa = "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
+					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
+			riscv,cboz-block-size = <0x40>;
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@2 {
+			compatible = "sifive,x280", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			reg = <2>;
+			mmu-type = "riscv,sv57";
+			riscv,isa = "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
+					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
+			riscv,cboz-block-size = <0x40>;
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		cpu@3 {
+			compatible = "sifive,x280", "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			reg = <3>;
+			mmu-type = "riscv,sv57";
+			riscv,isa-base = "rv64i";
+			riscv,isa = "rv64imafdcv_zicsr_zifencei_zfh_zba_zbb_sscofpmf";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicsr",
+					       "zifencei", "zfh", "zba", "zbb", "sscofpmf";
+			riscv,cboz-block-size = <0x40>;
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		clint0: timer@2000000 {
+			compatible = "tenstorrent,blackhole-a0-clint", "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 0x3>, <&cpu0_intc 0x7>,
+					      <&cpu1_intc 0x3>, <&cpu1_intc 0x7>,
+					      <&cpu2_intc 0x3>, <&cpu2_intc 0x7>,
+					      <&cpu3_intc 0x3>, <&cpu3_intc 0x7>;
+		};
+
+		plic0: interrupt-controller@c000000 {
+			compatible = "tenstorrent,blackhole-a0-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0x0c000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			riscv,ndev = <128>;
+		};
+	};
+};

-- 
2.34.1


