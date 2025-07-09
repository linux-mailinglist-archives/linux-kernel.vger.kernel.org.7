Return-Path: <linux-kernel+bounces-724587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E027AFF494
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449C87A924D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA8724679E;
	Wed,  9 Jul 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQp156Fa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A66243399;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099710; cv=none; b=GQxW1twuCTmW7C+kkokl1QAtM2uah/Xvog+rXUeVZ95xujM91HzYBi4hK1piQEQmuPg+MggMs08509MkIJmwLmGDVLy4uyJ6rcqRekgRcBlJmrymsdgJGb054HQOq3W3eCyj3HN7Fgr9Chj4E747w2F96gbpHTXHyKgJWiLpXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099710; c=relaxed/simple;
	bh=vMk63BU6vPbeqFxykHtTw4kWX4uzQsf8eR4cINkk+II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOEOGo62/aRgN7ZmMyY6ksZSWXB4/w7ykEHYvVo6SjkfciwxrWWqHdCauLOIPrn27/RbC8kJGG+ij6/lgqHa5K3m37vCaulAORQ0aPd9O2TFT/Bg3A4yRgyonpfORtezdi9fLTHqpBNKZdVhSbpAR/JnDwxoHXjtjQiwoEAqgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQp156Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA478C4CEF6;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752099709;
	bh=vMk63BU6vPbeqFxykHtTw4kWX4uzQsf8eR4cINkk+II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BQp156FaVaIuhLwdDKT/s4ziB7FJaKv9qdeDnwAj8of0sp5+9DlNSqzSWm4kUB6a1
	 LB0wJd7jaijSGvTLWbFijHDySGHw9OpV04kAPd6EzzyvbqrHf5AWvVCl2wQiQ+0StO
	 TDQFyukHn2jCiz7yXNeRxO4Xh1P93IEcgFj6AbLhPnpnaec6HwiNAGlJXTamv5Ndpr
	 wBkTTv1a0XFx+OWDUA89ibH3hl87VObQFogiuJNGF9pW0q89X7+OrtoCeq9Uc4SdHQ
	 nitePk+C/KMow9cAfTdO1JH1RFQlY4ZIKDtw7q/AUh1GWB/u2KPep62gDkjkE60Ruy
	 y1ZG/AQnRzc1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F2C83F18;
	Wed,  9 Jul 2025 22:21:49 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Thu, 10 Jul 2025 00:21:45 +0200
Subject: [PATCH v3 2/2] arm64: dts: Add Apple SoC GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sgx-dt-v3-2-299bb3a65109@gmail.com>
References: <20250710-sgx-dt-v3-0-299bb3a65109@gmail.com>
In-Reply-To: <20250710-sgx-dt-v3-0-299bb3a65109@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752099708; l=9228;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=K6K14UmmEMDGmK5+9wuNs1Mi4fwHRoanhZcBO8g9SnA=;
 b=lGoxzSJqwgctVwWzlLIVAN1JTfGOcYn2TGjIbCwp8FjHilhP80NzOlPsQ1KiyqwZQ3qZd7y//
 XJUh3SYHIiLAlyuXqOC3zHsrWeQMRIDozJbiEB0a+qvI5Qb3vpa+T/V
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add device tree entries for GPUs in M-series SoCs

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t6000.dtsi        |  4 ++++
 arch/arm64/boot/dts/apple/t6001.dtsi        |  4 ++++
 arch/arm64/boot/dts/apple/t6002.dtsi        |  4 ++++
 arch/arm64/boot/dts/apple/t600x-common.dtsi | 34 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t600x-die0.dtsi   | 28 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi        | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t8112.dtsi        | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 198 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6000.dtsi b/arch/arm64/boot/dts/apple/t6000.dtsi
index 89c3b211b116e96ee0a5ea0c923c3ab824008307..0ad77c98073fe65ddde7736acaece9acd5f3111e 100644
--- a/arch/arm64/boot/dts/apple/t6000.dtsi
+++ b/arch/arm64/boot/dts/apple/t6000.dtsi
@@ -16,3 +16,7 @@ / {
 };
 
 /delete-node/ &pmgr_south;
+
+&gpu {
+	compatible = "apple,agx-g13s";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001.dtsi b/arch/arm64/boot/dts/apple/t6001.dtsi
index d2cf81926f284ccf7627701cc82edff31d4d72d6..ffbe823b71bc8d9c0975524aa04efa9bf520a89e 100644
--- a/arch/arm64/boot/dts/apple/t6001.dtsi
+++ b/arch/arm64/boot/dts/apple/t6001.dtsi
@@ -62,3 +62,7 @@ p-core-pmu-affinity {
 		};
 	};
 };
+
+&gpu {
+	compatible = "apple,agx-g13c", "apple,agx-g13s";
+};
diff --git a/arch/arm64/boot/dts/apple/t6002.dtsi b/arch/arm64/boot/dts/apple/t6002.dtsi
index e36f422d257d8fe3a62bfa6e0f0e0dc6c34608a4..8fb648836b538bbd9efdccd6cec5d08d868a0d39 100644
--- a/arch/arm64/boot/dts/apple/t6002.dtsi
+++ b/arch/arm64/boot/dts/apple/t6002.dtsi
@@ -300,3 +300,7 @@ &ps_gfx {
 	// On t6002, the die0 GPU power domain needs both AFR power domains
 	power-domains = <&ps_afr>, <&ps_afr_die1>;
 };
+
+&gpu {
+	compatible = "apple,agx-g13d", "apple,agx-g13s";
+};
diff --git a/arch/arm64/boot/dts/apple/t600x-common.dtsi b/arch/arm64/boot/dts/apple/t600x-common.dtsi
index 87dfc13d74171f62bf3087401918d9d41eaac560..e20234ef213538f851d9da0dbd11b318831668b1 100644
--- a/arch/arm64/boot/dts/apple/t600x-common.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-common.dtsi
@@ -11,6 +11,10 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gpu = &gpu;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -378,4 +382,34 @@ nco_clkref: clock-ref-nco {
 		#clock-cells = <0>;
 		clock-output-names = "nco_ref";
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpu_globals: globals {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_a: hw-cal-a {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_b: hw-cal-b {
+			status = "disabled";
+		};
+
+		uat_handoff: uat-handoff {
+			status = "disabled";
+		};
+
+		uat_pagetables: uat-pagetables {
+			status = "disabled";
+		};
+
+		uat_ttbs: uat-ttbs {
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 110bc6719512e334e04b496fb157cb4368679957..341307330bfaa17b276d9c23a87931dbe71bd186 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -302,6 +302,34 @@ mca: mca@39b600000 {
 		#sound-dai-cells = <1>;
 	};
 
+	gpu: gpu@406400000 {
+		compatible = "apple,agx-g13s";
+		reg = <0x4 0x6400000 0 0x40000>,
+			<0x4 0x4000000 0 0x1000000>;
+		reg-names = "asc", "sgx";
+		mboxes = <&agx_mbox>;
+		power-domains = <&ps_gfx>;
+		memory-region = <&uat_ttbs>, <&uat_pagetables>, <&uat_handoff>,
+				<&gpu_hw_cal_a>, <&gpu_hw_cal_b>, <&gpu_globals>;
+		memory-region-names = "ttbs", "pagetables", "handoff",
+				      "hw-cal-a", "hw-cal-b", "globals";
+
+		apple,firmware-abi = <0 0 0>;
+	};
+
+	agx_mbox: mbox@406408000 {
+		compatible = "apple,t6000-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x4 0x6408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 1059 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 1060 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 1061 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 1062 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+			"recv-empty", "recv-not-empty";
+		#mbox-cells = <0>;
+	};
+
 	pcie0_dart_0: iommu@581008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x5 0x81008000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 20faf0c0d80927b2e18dd966a61b5507b322c72f..531cfcd463ae6d8701dec67cde8c953b8865eef6 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -19,6 +19,10 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gpu = &gpu;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -351,6 +355,36 @@ nco_clkref: clock-ref-nco {
 		clock-output-names = "nco_ref";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpu_globals: globals {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_a: hw-cal-a {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_b: hw-cal-b {
+			status = "disabled";
+		};
+
+		uat_handoff: uat-handoff {
+			status = "disabled";
+		};
+
+		uat_pagetables: uat-pagetables {
+			status = "disabled";
+		};
+
+		uat_ttbs: uat-ttbs {
+			status = "disabled";
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -359,6 +393,34 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		gpu: gpu@206400000 {
+			compatible = "apple,agx-g13g";
+			reg = <0x2 0x6400000 0 0x40000>,
+				<0x2 0x4000000 0 0x1000000>;
+			reg-names = "asc", "sgx";
+			mboxes = <&agx_mbox>;
+			power-domains = <&ps_gfx>;
+			memory-region = <&uat_ttbs>, <&uat_pagetables>, <&uat_handoff>,
+					<&gpu_hw_cal_a>, <&gpu_hw_cal_b>, <&gpu_globals>;
+			memory-region-names = "ttbs", "pagetables", "handoff",
+					      "hw-cal-a", "hw-cal-b", "globals";
+
+			apple,firmware-abi = <0 0 0>;
+		};
+
+		agx_mbox: mbox@206408000 {
+			compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x6408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 575 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 576 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 577 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 578 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+		};
+
 		cpufreq_e: performance-controller@210e20000 {
 			compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
 			reg = <0x2 0x10e20000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index e95711d8337f6cea898e88a3d564caf2c4f94404..b41b9f8fa122b13b9bf20dcb7135049e11e1819f 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -19,6 +19,10 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gpu = &gpu;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -366,6 +370,36 @@ nco_clkref: clock-ref-nco {
 		clock-output-names = "nco_ref";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpu_globals: globals {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_a: hw-cal-a {
+			status = "disabled";
+		};
+
+		gpu_hw_cal_b: hw-cal-b {
+			status = "disabled";
+		};
+
+		uat_handoff: uat-handoff {
+			status = "disabled";
+		};
+
+		uat_pagetables: uat-pagetables {
+			status = "disabled";
+		};
+
+		uat_ttbs: uat-ttbs {
+			status = "disabled";
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -374,6 +408,34 @@ soc {
 		ranges;
 		nonposted-mmio;
 
+		gpu: gpu@206400000 {
+			compatible = "apple,agx-g14g";
+			reg = <0x2 0x6400000 0 0x40000>,
+				<0x2 0x4000000 0 0x1000000>;
+			reg-names = "asc", "sgx";
+			mboxes = <&agx_mbox>;
+			power-domains = <&ps_gfx>;
+			memory-region = <&uat_ttbs>, <&uat_pagetables>, <&uat_handoff>,
+					<&gpu_hw_cal_a>, <&gpu_hw_cal_b>, <&gpu_globals>;
+			memory-region-names = "ttbs", "pagetables", "handoff",
+					      "hw-cal-a", "hw-cal-b", "globals";
+
+			apple,firmware-abi = <0 0 0>;
+		};
+
+		agx_mbox: mbox@206408000 {
+			compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x6408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 709 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 710 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 711 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 712 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+		};
+
 		cpufreq_e: cpufreq@210e20000 {
 			compatible = "apple,t8112-cluster-cpufreq", "apple,cluster-cpufreq";
 			reg = <0x2 0x10e20000 0 0x1000>;

-- 
2.50.1



