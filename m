Return-Path: <linux-kernel+bounces-824717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D30B89FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96CF5A6EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E967314B70;
	Fri, 19 Sep 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YaZXsM+c"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C6313D5C;
	Fri, 19 Sep 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292182; cv=none; b=oPLqvxYUMD6peY2Fxo7VEXfxrZeoCOiHuCp2rQFOfKvegwCh01+fSzc6Y/2uhQF0ZDhQJ9MU3z1AvPH4TlVNJzbCih2WjKzJkYoPm2BbSBRnmUj9KNd958EZ7iUY+JfoY6MfYyslEF3MaW4KZQg9PKt+4frTZJkKhj39Fcqsr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292182; c=relaxed/simple;
	bh=RuyvpmG2t13QQMjunY9RjVpiiVYBqIn0A101uyqlM6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNm1DfMhPUk+ATmw5VmRekLeg/nY7mWgsLV1eynS8WkoQWhLLhJkE8tak9327T+/zgkmGhLI9V6v9q/s9XSd+zSW8L3zT+uL6Rso/KkUkk36hhftevx88uF/zwsaA6+w1mxd+L2OLJQIrPicqKlc9D3epZI0f4uttcsyE43J89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YaZXsM+c; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7AFBE25DAF;
	Fri, 19 Sep 2025 16:29:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VF3DWfCFfU43; Fri, 19 Sep 2025 16:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758292178; bh=RuyvpmG2t13QQMjunY9RjVpiiVYBqIn0A101uyqlM6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaZXsM+cQFPBNx4Tu+BlZNdxa1BIPCEvyx01BpckNjHIug4qdbe0kAvEELwnX0zil
	 FGWUZp5dBhe2umMX+3/99TMtOkDZu5QP8SCA6Vxb/EBddEKmAT/PJo6NrHVeXEWiyp
	 kYrMfDaBZoyUfyrg6jEg1fEsgOHFRCPs5P6VFw0JeOUJJ+dKevPFXm8yM378fD1u9+
	 6XBEVao+Q+Fb9NNG5x6AxAmd07PvdY3xxkL2LQJE43Me9syUDUnOKzcHabSmYm2fJj
	 yH0cewo4xrJHSxhBIQokLArgLNibWwcCl9KNV5vWFuVq8GvjJC8pwBt7zslEdxx0Bz
	 oo6p2H/4+BO3Q==
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
Subject: [PATCH v4 7/8] LoongArch: dts: Add clock tree for Loongson-2K0300
Date: Fri, 19 Sep 2025 14:26:48 +0000
Message-ID: <20250919142649.58859-8-ziyao@disroot.org>
In-Reply-To: <20250919142649.58859-1-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the clock controller integrated in Loongson-2K0300 SoC and
clocks for UARTs.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/loongarch/boot/dts/loongson-2k0300.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0300.dtsi b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
index ce3574691aa9..ddc2e2697838 100644
--- a/arch/loongarch/boot/dts/loongson-2k0300.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0300.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/clock/loongson,ls2k-clk.h>
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


