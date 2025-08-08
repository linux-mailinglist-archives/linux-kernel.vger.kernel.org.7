Return-Path: <linux-kernel+bounces-760693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDCB1EEF5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B5E1C20310
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2EC288526;
	Fri,  8 Aug 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nx2ejqv+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2D287510;
	Fri,  8 Aug 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681778; cv=none; b=RVwIjIEA2w58gMKmIJmrhxTde0pnSwITLVyqqs1Uf20S3WsVcELKJsLGVurS7XkZS5/6U9rat3Zsx6ja/tGkhb3MMueoxBClGEPQpUCrqrZikVyQwRulcvUVauPkY2X83ua0K4m0vITmExp514hYWzmBwE9uwcZcOkfnaw1dUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681778; c=relaxed/simple;
	bh=rl0GSEMQipGgM/tHbM+N9H22RJ3YNzoiPPjreDdRxxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DidlY/vq38LdvJjubhr2fjTyqV46Q3u8bU+jTABdNp/krwfUamVTM/SqpPOs8sdF2vWZWFbJz8QWMdewJw06wR7p1FkO+lBh+o0ZXMybuh4Hrm7qL4yX9hq92hh0kXF32iJn+MIsAx1fESe31lRyCOvSR1I79NJwApuU5kv8YM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nx2ejqv+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754681774;
	bh=rl0GSEMQipGgM/tHbM+N9H22RJ3YNzoiPPjreDdRxxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nx2ejqv+Bfbt1EGrmSAFz4ZpoGJ7oheCE8D6NN9AzVTjil8qd5ClVFXIDVwezUsea
	 b63njDfAvxrrS1n37ePH0CyrmchENhAcdHMliqois2H3sbE2+1fZYXTGS8avZMFjwM
	 7tZtBnkyk3vaXgHiU8kCGE7crvoR7WRTE9ummRwRm6BbvWTS8dmB/BNk8EEHrQIZ2O
	 a8be4es7fKb+RytRn4zftG2u6eZEjzWqcNY+YTwqJ/2cp5P4qwCu0ibVcahAzPTidy
	 mv2H5DqluwwuD2RwN04d+AxrsnP1U+LFJli/ysZhiZ6nYurKE6DAx8myU8IzbN3aRu
	 SZkWGPyM3YE/A==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC64817E1277;
	Fri,  8 Aug 2025 21:36:11 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Alexey Charkov <alchark@gmail.com>,
	Patrick Wildt <patrick@blueri.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Diederik de Haas <didi.debian@cknow.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add the vdpu383 Video Decoder on rk3576
Date: Fri,  8 Aug 2025 15:36:02 -0400
Message-ID: <20250808193602.142527-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808193602.142527-1-detlev.casanova@collabora.com>
References: <20250808193602.142527-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the vdpu383 Video Decoder variant to the RK3576 device tree.

Also allow using the dedicated SRAM as a pool.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index c3cdae8a54941..d16817526b9f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1139,6 +1139,41 @@ gpu: gpu@27800000 {
 			status = "disabled";
 		};
 
+		vdec: video-codec@27b00100 {
+			compatible = "rockchip,rk3576-vdec";
+			reg = <0x0 0x27b00100 0x0 0x500>,
+			      <0x0 0x27b00000 0x0 0x100>,
+			      <0x0 0x27b00600 0x0 0x100>;
+			reg-names = "function", "link", "cache";
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru ACLK_RKVDEC_ROOT>, <&cru HCLK_RKVDEC>,
+				 <&cru ACLK_RKVDEC_ROOT_BAK>, <&cru CLK_RKVDEC_CORE>,
+				 <&cru CLK_RKVDEC_HEVC_CA>;
+			clock-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+			assigned-clocks = <&cru ACLK_RKVDEC_ROOT>, <&cru CLK_RKVDEC_CORE>,
+					  <&cru ACLK_RKVDEC_ROOT_BAK>, <&cru CLK_RKVDEC_HEVC_CA>;
+			assigned-clock-rates = <600000000>, <600000000>,
+					       <500000000>, <1000000000>;
+			iommus = <&vdec_mmu>;
+			power-domains = <&power RK3576_PD_VDEC>;
+			resets = <&cru SRST_A_RKVDEC_BIU>, <&cru SRST_H_RKVDEC_BIU>,
+				 <&cru SRST_H_RKVDEC>, <&cru SRST_RKVDEC_CORE>,
+				 <&cru SRST_RKVDEC_HEVC_CA>;
+			reset-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+			sram = <&rkvdec_sram>;
+		};
+
+		vdec_mmu: iommu@27b00800 {
+			compatible = "rockchip,rk3576-iommu", "rockchip,rk3568-iommu";
+			reg = <0x0 0x27b00800 0x0 0x40>, <0x0 0x27b00900 0x0 0x40>;
+			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru CLK_RKVDEC_CORE>, <&cru HCLK_RKVDEC>;
+			clock-names = "aclk", "iface";
+			power-domains = <&power RK3576_PD_VDEC>;
+			rockchip,disable-mmu-reset;
+			#iommu-cells = <0>;
+		};
+
 		vop: vop@27d00000 {
 			compatible = "rockchip,rk3576-vop";
 			reg = <0x0 0x27d00000 0x0 0x3000>, <0x0 0x27d05000 0x0 0x1000>;
@@ -2428,6 +2463,7 @@ sram: sram@3ff88000 {
 			/* start address and size should be 4k align */
 			rkvdec_sram: rkvdec-sram@0 {
 				reg = <0x0 0x78000>;
+				pool;
 			};
 		};
 
-- 
2.50.1


