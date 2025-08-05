Return-Path: <linux-kernel+bounces-756635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D356EB1B719
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156F517F337
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80E5279DC4;
	Tue,  5 Aug 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NjjGFTbB"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5E2797AE;
	Tue,  5 Aug 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406340; cv=none; b=FPn8mJoAbIStjTOensWDcaZo5evajTeqJBFDs1DYgnUkzp/G08pAvLhynMLht/R75IjuNQEDSqaPu17PoD2m+Sbuwgk6KZOi94TI2EMCaOH9tOU8dGkXvz1L0jxEsCknY7mhawWzg4AWLcS+BFzhwOPTj9BBehsT+ckRqv9whlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406340; c=relaxed/simple;
	bh=T5CGTCEyj2V5/vVEKnqFx9gkHF9Rp65X/Eqg0GrMZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyWvNuEF9Mt+X7HSnfsmgm0+WMmwK3iyfPBW+xU0ZLiBXvYMxG/4R9Dsa4g1C2v1zFbpIgVQw15Dq3plofMpOgLgg8YtAVlddoeh/0P40yTv4cuNK/ZG3ovqIOwYZD2DZZ0UMheEWgzrpM+XkCnTVz2oAttMrq2YOLm3T+SDpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NjjGFTbB; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 75FD3204DA;
	Tue,  5 Aug 2025 17:05:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lX0QPEqM-xdD; Tue,  5 Aug 2025 17:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406336; bh=T5CGTCEyj2V5/vVEKnqFx9gkHF9Rp65X/Eqg0GrMZdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjjGFTbB+mTwdt93hwIqYOQvXmlEuhrTHXTiA4yjRthMe7ZaZh5E3XcghcA8yQg8R
	 GP+JB1cjgyZJxXRbjgnaRsbmjd5q7QIaXVdGyrlRbU1ihtoTOh51C8puMQiskEK/kT
	 vYqneHrhl89l6VGBzwO2y6KOWtw7n3JSjlbrQZ/GCTPwXaLwWtdwmzLinxRFypYas7
	 d86fdDADriR0nHae7/Xez5lHAjcj+aJiwldgpHv6GP81H2CvboQd20POxo+nu8gb1t
	 gXz+uvNRzh9U9Oyc70h7BQuU3ibwSuh9cd9MSzCzjI118ONz5w7SA3NivubyLK8qOo
	 +ArLFjaQo+p6w==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 7/8] LoongArch: dts: Add clock tree for Loongson 2K0300
Date: Tue,  5 Aug 2025 15:01:46 +0000
Message-ID: <20250805150147.25909-8-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-1-ziyao@disroot.org>
References: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the clock controller integrated in Loongson 2K0300 SoC and
clocks for UARTs.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/loongarch/boot/dts/loongson-2k0300.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0300.dtsi b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
index ce3574691aa9..d909a4eca312 100644
--- a/arch/loongarch/boot/dts/loongson-2k0300.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/clock/loongson,ls2k0300-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -21,7 +22,7 @@ cpu0: cpu@0 {
 			compatible = "loongson,la264";
 			reg = <0>;
 			device_type = "cpu";
-			clocks = <&cpu_clk>;
+			clocks = <&clk LS2K0300_CLK_NODE_GATE>;
 		};
 
 	};
@@ -32,9 +33,10 @@ cpuintc: interrupt-controller {
 		#interrupt-cells = <1>;
 	};
 
-	cpu_clk: clock-1000m {
+	refclk: clock-120m {
 		compatible = "fixed-clock";
-		clock-frequency = <1000000000>;
+		clock-frequency = <120000000>;
+		clock-output-names = "refclk_120m";
 		#clock-cells = <0>;
 	};
 
@@ -46,6 +48,13 @@ soc@10000000 {
 			 <0x00 0x02000000 0x00 0x02000000 0x0 0x04000000>,
 			 <0x00 0x40000000 0x00 0x40000000 0x0 0x40000000>;
 
+		clk: clock-controller@16000400 {
+			compatible = "loongson,ls2k0300-clk";
+			reg = <0x0 0x16000400 0x0 0x30>;
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+		};
+
 		liointc0: interrupt-controller@16001400 {
 			compatible = "loongson,liointc-2.0";
 			reg = <0x0 0x16001400 0x0 0x40>,
@@ -87,6 +96,7 @@ liointc1: interrupt-controller@16001440 {
 		uart0: serial@16100000 {
 			compatible = "ns16550a";
 			reg = <0 0x16100000 0 0x10>;
+			clocks = <&clk LS2K0300_CLK_APB_GATE>;
 			interrupt-parent = <&liointc0>;
 			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			no-loopback-test;
-- 
2.50.1


