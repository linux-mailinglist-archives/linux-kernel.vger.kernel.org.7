Return-Path: <linux-kernel+bounces-825583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F2B8C451
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8659E7E2E22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBFD2BEC2E;
	Sat, 20 Sep 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDrSaxy2"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238A298CBC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359567; cv=none; b=Zlw3otUy0p9SyR5YRSm/AB1rOdYq+xcw8jNjQqBAYnogjtVpqCoXKSY7WvEVyiQMcvXy6AAZ8l0Wjvnn02JuN5t0MmNyjFOGTVn2rCB0UUJvx6ic7Vx8eG/tJH+L2o/fUSj5onoUp9axunyacq9nzizTM45Y6e+MDd/4NMJ9S1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359567; c=relaxed/simple;
	bh=1RPX1o022vxaMbbkCmG8PzVP+OT47HI5SaSZEtZ+BUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxhvVdaTTwQlHsANmdmL7U5VxHTmHNT9HFNJpx3RGKhZSyPJydm0jnccpqF85rX58Dxwx0RK1UYmNVdD6ii3ljqq+V6m9nc+ZEesLverzvHD69upHntArYctxpY/u6dNJdPOZIIca8u4RsBGq/6Au5hfsUYB4JOY80NTlXw7vOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDrSaxy2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso1448970f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758359564; x=1758964364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KAascs3KaV3Z3mHhvMTLU3s9nCHKKshT+qkVXRYo2g=;
        b=MDrSaxy2y9K2xdzZrlR1ypfcaOAdFGzgiluKL87O+gx5TB2ErDQH0ji991kJaETweq
         plNkMOLqc66r2OPfVIY4/0lqY6E7Pirr1mBmRbPh994QnzJd1GFOU01UCCtaHMwO1RAm
         0zr0QE+RJ/kb0nH8n0R2Mez+ofXqjwrhhPxErIySsHM39Xf79e59peZiHpsHVjbxeeX/
         +EYuJnZxw1rHLRwSSVxpuNnPeFMMroKrA8333/hxeoLfQbBk+mezTY7xnwfDyZgVYXc3
         jXYuigfUgrD8h9TgjQ+0Rxu/DK50VH8tcWaAKYaKEAopxAXBpwrdkMEkv4KlE4i4TXUB
         fPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758359564; x=1758964364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KAascs3KaV3Z3mHhvMTLU3s9nCHKKshT+qkVXRYo2g=;
        b=rE091vZlkug4mVv/0sD1bXccXyX2bw+OWXXB1cXzEAw2Lj56JV8+rueNgNevQLXRnt
         VoQq1fExqto9n8zTseoOiq2zaouIHIL3d9rS3pjZnnFQU0Yz/XoxUG/fsqeQy3GL/egp
         p2PUW1fD28qKHZiNKg+Wf+ushdIZ+Y38dsruwvyUDWHQvhzuziPswzCy2Z4DK6C8byvf
         tLCz2p81jE1UjO/4lvIxg29skorx2GImuScq1jfJho5zMHs9i8MX+4KZM2peVNedKjOq
         AhNwmCyPtE0/2ovvX41ioEaAr2JYBD4obEsQL3/hpK9AHKG1c7xYuLloW1EdJrJa5KBf
         2NRA==
X-Forwarded-Encrypted: i=1; AJvYcCUNo6rOwsckER3EWL+HL8nMchKvn+3QOHvfCTaF2wVF12nsSexzM8f1WdnozMIVjBKkC4dpwfVTUJPjZHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6C8U6Xm8d6dhPAUR9/s1ywXkvtf0wXii188Rm/erlbt6CVUlN
	Zi+vohK/yM2mu636BxbCrqDzWSjKc/+1WTXMe4Ys8kuO2N/pa8TbgPQ6
X-Gm-Gg: ASbGncuLW3hLw728BRzgE+qvQyElHxsTGBqUWKyN43EFLht/+6heV9TPNyG4SjQXIxv
	IW2XiO5QUkeKNVyGa7gR8fJFBkZ5KyEyYjE/yRExQlJG0MgYJZFEj3n/ZMiv6NudcPzEvv3oKtP
	atbzC5rNUUnpB3Qg7tA+230SY56lZmCTYP9KSyCWdALfHjGLCxatPrnxypTwXQxIbkDV7qD0GKc
	SjRkIzrP8eP94MuS0JzpFxGON1MbIHnt8D39Go/sWkqhZ7fMxwQQqh6eqIdxq8Od9SMfItXEgkH
	8iIfLkwIk/7FwbD1/H+YR4moB2QTzdQoZ7lIzgd4L6iKBSfwGRonYYgLhHtwrNZMi1KnvqDfcPd
	4COHVTmeCu/RoSuqX+4sRTsxA2w0PkCExiLXPNredrJ2EkPz1LS656izHQlXiSknuUNlXXCw=
X-Google-Smtp-Source: AGHT+IHrh+ndXxTb1EFVumE+GYJ79IR8tl0ePHWHwP2BuY3hk84NbTQ7ULb7XUOoja074PzYe5xg8A==
X-Received: by 2002:a05:6000:310e:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-3ee852a434cmr6002416f8f.53.1758359564118;
        Sat, 20 Sep 2025 02:12:44 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm6375782f8f.40.2025.09.20.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:12:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: Add Airoha AN7583 SoC and AN7583 Evaluation Board
Date: Sat, 20 Sep 2025 11:12:29 +0200
Message-ID: <20250920091230.17702-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920091230.17702-1-ansuelsmth@gmail.com>
References: <20250920091230.17702-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC initial DTSI and AN7583 Evaluation Board
DTS and add the required entry in the Makefile.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/airoha/Makefile       |   1 +
 arch/arm64/boot/dts/airoha/an7583-evb.dts |  22 ++
 arch/arm64/boot/dts/airoha/an7583.dtsi    | 282 ++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/airoha/an7583-evb.dts
 create mode 100644 arch/arm64/boot/dts/airoha/an7583.dtsi

diff --git a/arch/arm64/boot/dts/airoha/Makefile b/arch/arm64/boot/dts/airoha/Makefile
index ebea112ce1d7..7a604ae249b5 100644
--- a/arch/arm64/boot/dts/airoha/Makefile
+++ b/arch/arm64/boot/dts/airoha/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 dtb-$(CONFIG_ARCH_AIROHA) += en7581-evb.dtb
+dtb-$(CONFIG_ARCH_AIROHA) += an7583-evb.dtb
diff --git a/arch/arm64/boot/dts/airoha/an7583-evb.dts b/arch/arm64/boot/dts/airoha/an7583-evb.dts
new file mode 100644
index 000000000000..a7f83436825e
--- /dev/null
+++ b/arch/arm64/boot/dts/airoha/an7583-evb.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+#include "an7583.dtsi"
+
+/ {
+	model = "Airoha EN7583 Evaluation Board";
+	compatible = "airoha,an7583-evb", "airoha,an7583";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/airoha/an7583.dtsi b/arch/arm64/boot/dts/airoha/an7583.dtsi
new file mode 100644
index 000000000000..74044811efc0
--- /dev/null
+++ b/arch/arm64/boot/dts/airoha/an7583.dtsi
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			operating-points-v2 = <&cpu_opp_table>;
+			enable-method = "psci";
+			clocks = <&cpufreq>;
+			clock-names = "cpu";
+			power-domains = <&cpufreq>;
+			power-domain-names = "perf";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			operating-points-v2 = <&cpu_opp_table>;
+			enable-method = "psci";
+			clocks = <&cpufreq>;
+			clock-names = "cpu";
+			power-domains = <&cpufreq>;
+			power-domain-names = "perf";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	cpufreq: cpufreq {
+		compatible = "airoha,en7581-cpufreq";
+
+		operating-points-v2 = <&cpu_smcc_opp_table>;
+
+		#power-domain-cells = <0>;
+		#clock-cells = <0>;
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			required-opps = <&smcc_opp0>;
+		};
+
+		opp-550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			required-opps = <&smcc_opp1>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			required-opps = <&smcc_opp2>;
+		};
+
+		opp-650000000 {
+			opp-hz = /bits/ 64 <650000000>;
+			required-opps = <&smcc_opp3>;
+		};
+
+		opp-7000000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			required-opps = <&smcc_opp4>;
+		};
+
+		opp-7500000000 {
+			opp-hz = /bits/ 64 <750000000>;
+			required-opps = <&smcc_opp5>;
+		};
+
+		opp-8000000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			required-opps = <&smcc_opp6>;
+		};
+
+		opp-8500000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			required-opps = <&smcc_opp7>;
+		};
+
+		opp-9000000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			required-opps = <&smcc_opp8>;
+		};
+
+		opp-9500000000 {
+			opp-hz = /bits/ 64 <950000000>;
+			required-opps = <&smcc_opp9>;
+		};
+
+		opp-10000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			required-opps = <&smcc_opp10>;
+		};
+
+		opp-10500000000 {
+			opp-hz = /bits/ 64 <1050000000>;
+			required-opps = <&smcc_opp11>;
+		};
+
+		opp-11000000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			required-opps = <&smcc_opp12>;
+		};
+
+		opp-11500000000 {
+			opp-hz = /bits/ 64 <1150000000>;
+			required-opps = <&smcc_opp13>;
+		};
+
+		opp-12000000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			required-opps = <&smcc_opp14>;
+		};
+	};
+
+	cpu_smcc_opp_table: opp-table-cpu-smcc {
+		compatible = "operating-points-v2";
+
+		smcc_opp0: opp0 {
+			opp-level = <0>;
+		};
+
+		smcc_opp1: opp1 {
+			opp-level = <1>;
+		};
+
+		smcc_opp2: opp2 {
+			opp-level = <2>;
+		};
+
+		smcc_opp3: opp3 {
+			opp-level = <3>;
+		};
+
+		smcc_opp4: opp4 {
+			opp-level = <4>;
+		};
+
+		smcc_opp5: opp5 {
+			opp-level = <5>;
+		};
+
+		smcc_opp6: opp6 {
+			opp-level = <6>;
+		};
+
+		smcc_opp7: opp7 {
+			opp-level = <7>;
+		};
+
+		smcc_opp8: opp8 {
+			opp-level = <8>;
+		};
+
+		smcc_opp9: opp9 {
+			opp-level = <9>;
+		};
+
+		smcc_opp10: opp10 {
+			opp-level = <10>;
+		};
+
+		smcc_opp11: opp11 {
+			opp-level = <11>;
+		};
+
+		smcc_opp12: opp12 {
+			opp-level = <12>;
+		};
+
+		smcc_opp13: opp13 {
+			opp-level = <13>;
+		};
+
+		smcc_opp14: opp14 {
+			opp-level = <14>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	sys_hclk: clk-oscillator-100mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sys_hclk";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@9000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x09000000 0x0 0x20000>,
+			      <0x0 0x09080000 0x0 0x80000>,
+			      <0x0 0x09400000 0x0 0x2000>,
+			      <0x0 0x09500000 0x0 0x2000>,
+			      <0x0 0x09600000 0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		crypto@1e004000 {
+			compatible = "inside-secure,safexcel-eip93ies";
+			reg = <0x0 0x1fb70000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart1: serial@1fbf0000 {
+			compatible = "ns16550";
+			reg = <0x0 0x1fbf0000 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1843200>;
+		};
+
+		watchdog@1fbf0100 {
+			compatible = "airoha,en7581-wdt";
+			reg = <0x0 0x1fbf0100 0x0 0x38>;
+
+			clocks = <&sys_hclk>;
+			clock-names = "bus";
+		};
+	};
+};
-- 
2.51.0


