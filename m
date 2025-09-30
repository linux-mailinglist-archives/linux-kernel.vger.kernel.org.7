Return-Path: <linux-kernel+bounces-837444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CABAC54E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21B27A1B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC872FF653;
	Tue, 30 Sep 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuZWZ6pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F442F7AD8;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225052; cv=none; b=pLNK0D6nTtDfmT5QgwUs63rjfxSlA4R3yxD+Lp60gb0Yq5tfNQaHktXh5tvLPx7m6yeWN2LyfUyNPYrAoxK1Xm7JlE7nr4eWJFqyCkRvzQxmom0Vz8EwgpUrAfRgHITVTrTTyBFZ1NlqLvaibxbh3oz/PIl+0E9zQtxX24vK7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225052; c=relaxed/simple;
	bh=iErMSw2Lyr6Fmu4FymWLOW0ESDvPsMZJihkoB1lmfRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPfpxRisyqFOueblfFS1BbLH0urbDW1VeKR1KQevxS3wobsotCFZ6uE6CxiO/W5NbkTHV89gBc3TDgc2m7frNmPFGHk8tM272Z7VjBNdVA5cV1w1DhsVW2ZyK1Tp0kbGAFaFww4/Vjl+XlTXQLrxEinol7U5yHYRSMTKgsIEHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuZWZ6pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74BAEC2BC87;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225052;
	bh=iErMSw2Lyr6Fmu4FymWLOW0ESDvPsMZJihkoB1lmfRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BuZWZ6pfCnTh8LtgpYTG/NTL1OPECQihA9IPACJdP5aLvsywy2AgjVyGmOBBURfAj
	 lWtBy/5Oej8axI29aJx4pabWX9S8Pk2PJVylhe+x7CbTfZT5tRnEKLZ1pt0MPVmAFi
	 nzTQzx45pTc87A5bT0YdByoVeFu01p6X2uRpdp7+BK3f4ulrvX3oywrxki75Ym8cvJ
	 ycd6jLhqG8fOaIE1MTNUE3H3sFhRxmaHKbaqGU9eZQE/86yMJunslBdM0ALSHgKYWB
	 OnaZPeXoQsjmx8T/WYnzXXb1sM96rDChkDDa/9SvwpGaLtOomkvQ1StFWuE5Zd0WxP
	 /KYygW21CgYqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846FCCA472;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:31 +0800
Subject: [PATCH 18/19] arm64: dts: amlogic: A5: Add PLL controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-18-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=1206;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=bQhUJaPTXEFMSauXPfNU5Yja/N+Lz2eh2uhawupxhwk=;
 b=UElGDgkVJLajjfM34iPcghGIOuiB/lpPmFynnVW+ce/mdO2+P10mxC4rS0P1YJUZZCzFnWhYo
 QuYSVMIy9gBBKgc+CYr1bPud4fDnT8BSZMaIRW0C8s7CRGcba/vkzwx
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add PLL controller node for A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 3b0e70211268..89f7b5ff4ea3 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -6,6 +6,9 @@
 #include "amlogic-a4-common.dtsi"
 #include "amlogic-a5-reset.h"
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
+#include <dt-bindings/clock/amlogic,a5-scmi-clkc.h>
+#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
+
 / {
 	cpus {
 		#address-cells = <2>;
@@ -96,4 +99,16 @@ gpio_intc: interrupt-controller@4080 {
 		amlogic,channel-interrupts =
 			<10 11 12 13 14 15 16 17 18 19 20 21>;
 	};
+
+	clkc_pll: clock-controller@8000 {
+		compatible = "amlogic,a5-pll-clkc";
+		reg = <0x0 0x8000 0x0 0x1a4>;
+		#clock-cells = <1>;
+		clocks = <&xtal>,
+			 <&scmi_clk CLKID_FIXED_PLL_DCO>,
+			 <&scmi_clk CLKID_FIXED_PLL>;
+		clock-names = "xtal",
+			      "fix_dco",
+			      "fix";
+	};
 };

-- 
2.42.0



