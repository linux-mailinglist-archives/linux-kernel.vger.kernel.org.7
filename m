Return-Path: <linux-kernel+bounces-632127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8654AA92D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D96D3B87D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A524EF88;
	Mon,  5 May 2025 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HzfDfvDM"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F224C668;
	Mon,  5 May 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447422; cv=none; b=XnZ5UQuSFv9wkb8qMoe3bvx12YlsxomN4OeryOSKT+za5zDy53MHOL1xU1bKpYH8yJ6JTia7z5lsGxW3I85+5k/4ixptsGwAaXRsKKnMiPHBlnZ4QEgda229KAjwj0eEkZqsmaaj5yVXjGPwF2WBwOk6+vnBiBhQ+LlujUUXtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447422; c=relaxed/simple;
	bh=X5IrLcOfwIuI91baMFWQlUw8w0RcvcFcoEUVtY7RB8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bg7FJqEAnG7MKCkbxHmSmEKUfs27KKfNL8Jp4RbIQw1J+Pjr4eI5Emzrz/faqwWKUNXT66pqckHWuJWMvM5BFzk7r9+KEPSMnT8jE1YQjGHyxG4+tzA74u9tNoUmTQa8SWTzbu+g5BSY+uFwlEzIZPZEK8ElMF5fDBsJECnY+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HzfDfvDM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d63be72229aa11f0813e4fe1310efc19-20250505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PDrjQLrgCOGlD1G5NZ3v24S+BslDmlzYRM05njM6UbE=;
	b=HzfDfvDMhSFcJ8UhfRKgd4Wzi2xlqBivigDdLwOnXZVPF4q5rxS2Cuiqer9kw88I7BBGWix6so2s2dyQdKUEcRutAwa5SrjTaSDJ1IrY9bmv0Niwg4jpeOCa6cPIDNzW9vcmt+yP5/F3QROWwhExuMwY/CNSHa6MN5FcOxXp2Yw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:402dea40-214a-4f37-90ad-875ee0382cb0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f143c62b-be47-4281-8f30-e6479b5e1210,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d63be72229aa11f0813e4fe1310efc19-20250505
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 986170758; Mon, 05 May 2025 20:16:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 5 May 2025 20:16:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 5 May 2025 20:16:55 +0800
From: Sirius Wang <sirius.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wenst@chromium.org>, Sirius Wang <sirius.wang@mediatek.com>
Subject: [PATCH 2/2] WIP: arm64: dts: mt8189: Add mt8189 dts evaluation board and Mafefile
Date: Mon, 5 May 2025 20:15:46 +0800
Message-ID: <20250505121627.3944728-3-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250505121627.3944728-1-sirius.wang@mediatek.com>
References: <20250505121627.3944728-1-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MT8189 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
and 2 CA78 cores. MT8189 share many HW IP with MT8188 series.

We add basic chip support for MediaTek MT8189 on evaluation board.

BUG=b:387230785
TEST=emerge-skywalker chromeos-kernel-6_6

Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts |  20 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi    | 441 ++++++++++++++++++++
 3 files changed, 462 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 3aa06476c6c0..ad2ac9e1bb79 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -87,6 +87,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8189-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8189-evb.dts b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
new file mode 100644
index 000000000000..e5d9ce1b8e61
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sirius Wang <sirius.wang@mediatek.com>
+ */
+/dts-v1/;
+#include "mt8189.dtsi"
+
+/ {
+	model = "MediaTek MT8189 evaluation board";
+	compatible = "mediatek,mt8189-evb", "mediatek,mt8189";
+
+	chosen: chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
new file mode 100644
index 000000000000..de59d858bcf3
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/reset/ti-syscon.h>
+
+/ {
+	compatible = "mediatek,mt8189";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpuoff_l &clusteroff_l &mcusysoff_l &system_vcore &s2idle>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <958>;
+			cpu-idle-states = <&cpuoff_m &clusteroff_m &mcusysoff_m &system_vcore &s2idle>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <958>;
+			cpu-idle-states = <&cpuoff_m &clusteroff_m &mcusysoff_m &system_vcore &s2idle>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu6>;
+				};
+				core1 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			cpuoff_l: cpuoff-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <97>;
+				exit-latency-us = <252>;
+				min-residency-us = <6710>;
+			};
+
+			cpuoff_m: cpuoff-m {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <53>;
+				exit-latency-us = <143>;
+				min-residency-us = <2120>;
+			};
+
+			cpuoff_b: cpuoff-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <40>;
+				exit-latency-us = <107>;
+				min-residency-us = <2580>;
+			};
+
+			clusteroff_l: clusteroff-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010001>;
+				local-timer-stop;
+				entry-latency-us = <109>;
+				exit-latency-us = <325>;
+				min-residency-us = <6710>;
+			};
+
+			clusteroff_m: clusteroff-m {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010001>;
+				local-timer-stop;
+				entry-latency-us = <59>;
+				exit-latency-us = <188>;
+				min-residency-us = <2120>;
+			};
+
+			clusteroff_b: clusteroff-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010001>;
+				local-timer-stop;
+				entry-latency-us = <43>;
+				exit-latency-us = <138>;
+				min-residency-us = <2580>;
+			};
+
+			mcusysoff_l: mcusysoff-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x02010007>;
+				local-timer-stop;
+				entry-latency-us = <1357>;
+				exit-latency-us = <835>;
+				min-residency-us = <6710>;
+			};
+
+			mcusysoff_m: mcusysoff-m {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x02010007>;
+				local-timer-stop;
+				entry-latency-us = <1202>;
+				exit-latency-us = <679>;
+				min-residency-us = <2120>;
+			};
+
+			mcusysoff_b: mcusysoff-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x02010007>;
+				local-timer-stop;
+				entry-latency-us = <1143>;
+				exit-latency-us = <611>;
+				min-residency-us = <2580>;
+			};
+
+			system_vcore: system-vcore {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x020100ff>;
+				local-timer-stop;
+				entry-latency-us = <940>;
+				exit-latency-us = <3500>;
+				min-residency-us = <35200>;
+			};
+
+			s2idle: s2idle {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x020180ff>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <10000>;
+				min-residency-us = <4294967295>;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <262144>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-unified;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	clocks {
+		clk_null: clk-null {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		clk32k: clk32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+
+		clk26m: clk26m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+
+		clk13m: clk13m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <13000000>;
+		};
+
+		ulposc: ulposc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <520000000>;
+		};
+
+		ulposc3: ulposc3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+		};
+
+		clk104m: clk104m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <104000000>;
+		};
+	};
+
+	memory: memory {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0xC0000000>;
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+				<GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+				<GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+				<GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-frequency = <13000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		performance: performance-controller@11bc10 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#redistributor-regions = <1>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0xc000000 0 0x40000>, /* distributor */
+			      <0 0xc040000 0 0x200000>; /* redistributor */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>;
+			clock-names = "baud", "bus";
+			uart-line = <0>;
+		};
+	};
+};
-- 
2.45.2


