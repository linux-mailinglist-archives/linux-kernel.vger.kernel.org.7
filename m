Return-Path: <linux-kernel+bounces-793080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1AB3CDE7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0675B562BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AD2D876A;
	Sat, 30 Aug 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwFLUfxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF002D6406;
	Sat, 30 Aug 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573762; cv=none; b=er8lLiGO3ET4gDXWXetN3Sgl0bSF3fqhlVFR1o0MIBf+OOJkDe/BVH6behHsuI25hEYvOqPrqrLNCwb+bQo0av23Oir7KkFbmIAcHsTZvrSnu9JliMWaVd5rjBcEoLS5q5BoBYosR1ZSVzwzuX6C/qhHIJcQ29xZ1y34fgRbuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573762; c=relaxed/simple;
	bh=X9UravRZTkYO/S1t31DyRCOSep0v8TZbjoIrBK1EKNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzP0q4eJPn42+F8X/8O0wvkeh4/Odjs9JnY+Il498DokVmJ2id7GAfGDe4j9NTJj+Cx7b01OclVvDj0zzTi9nS0BO7iADToHCLp70DIhFr6rc+Xd9ANjvU6QUqPNk+uZ0xpvAO1LKSjAjHyMNLVizJAoECSo8XZbiWeKmuiNUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwFLUfxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C8C4CEF8;
	Sat, 30 Aug 2025 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573762;
	bh=X9UravRZTkYO/S1t31DyRCOSep0v8TZbjoIrBK1EKNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwFLUfxlJFRuEDCHufRML+UIZZxkrkNLuW9Jorcc8xsw9v1WoDX0KJAJ8NHXNMfk+
	 yh/ifCmuennI9zj0KjV/5voVETLt/qc+ZxPVJ5xAZ2vSPBfijwsMjXdF8p9agJMWpD
	 k2nwhPQEotMppPXpGxzPrFxKQmaEoTvdbZq6DFEFbQIwvI7PIpEshjdgXOsI7CHavy
	 YUhA2F4y1pxYWGxRhGNu8u5b5aSp/NhW8ib3aRF/FZDXZHJrel6uweKlQtTXbsJJmf
	 avfDBFenDBvxkH7gnmYNXvNWFt5CmAb3+SLuz8cv2PTAe/B/3noF205eW3jxwRoJuz
	 KlphCMUjLomaA==
Received: by wens.tw (Postfix, from userid 1000)
	id 78ADF5FF44; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: allwinner: a523: Add NPU device node
Date: Sun, 31 Aug 2025 01:09:01 +0800
Message-Id: <20250830170901.1996227-9-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Allwinner T527 SoC has an NPU built in. Based on identifiers found
in the BSP, it is a Vivante IP block. After enabling it, the etnaviv
driver reports it as a GC9000 revision 9003.

The standard bindings are used as everything matches directly. There is
no option for DVFS at the moment. That might require some more work,
perhaps on the efuse side to map speed bins.

It is unclear whether the NPU block is fused out at the hardware level
or the BSP limits use of the NPU through software, as the author only
has boards with the T527.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index b6e82d53af54..1ab5b87ec78e 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -850,6 +850,18 @@ mcu_ccu: clock-controller@7102000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		npu: npu@7122000 {
+			compatible = "vivante,gc";
+			reg = <0x07122000 0x1000>;
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mcu_ccu CLK_BUS_MCU_NPU_ACLK>,
+				 <&ccu CLK_NPU>,
+				 <&mcu_ccu CLK_BUS_MCU_NPU_HCLK>;
+			clock-names = "bus", "core", "reg";
+			resets = <&mcu_ccu RST_BUS_MCU_NPU>;
+			power-domains = <&ppu PD_NPU>;
+		};
 	};
 
 	thermal-zones {
-- 
2.39.5


