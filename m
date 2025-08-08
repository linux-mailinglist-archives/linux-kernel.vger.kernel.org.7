Return-Path: <linux-kernel+bounces-760692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9912B1EEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B3A563DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A228850C;
	Fri,  8 Aug 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LWXmok4Y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CD2877FC;
	Fri,  8 Aug 2025 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681775; cv=none; b=jU4Oo7sZW6Rx+0zwHXMm85x/GuYFskcnU6afxFM59xZighTKUCSFqOYXloGDi/dXxMPIFE/QXHc9uteihzWGHsrAtXHbGY6ecSh5M9D8FNoYKMfHUnVrhT8znoRsNT0iKCRsZj7eAryHCwKVwK/Y3tebvXoF+MsTZ0NVyX7ED0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681775; c=relaxed/simple;
	bh=5Gy5tegd6uu1e9KY0y64YIwx/lrqPHX8tSnZWyRsDnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqaAhMtK7MDbClzzl8JnRly32mdNPbqN9j5KWGO72TLcmR5ZR/tpgGScHoXGQVeCXceC6MSno5bNAJMMKog1JIF6YJWw3zGAaVA97jrgWll8F6lbV97R3zg7+OsTTvieLOLzY6rk6C6A11jFka+YIOeb38kck7OnNsb4XNaSmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LWXmok4Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754681771;
	bh=5Gy5tegd6uu1e9KY0y64YIwx/lrqPHX8tSnZWyRsDnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWXmok4YzSAZh94/u8tkq1ocP4Nml9vnU4JCK5t+r9F5YEXasCVDq3U1vbw4okW1t
	 Vash47t/DuiTV0ov+AOb3UVHPLzqHEniW8yp1TQ2mIxMCe/DXkVIxK3yX1UfzRTyLB
	 DrJZAq3nEG7EmWdH1M9AlB0CVMUDbM9UxgwOtadkAuuFRMSwRpo+JFFP9Lmpe8DwmK
	 h8sVlIKkBENZMG7h/i2unKdQviYYA070G+tP6njfFhaobLXKkYunTeUbHse5obdSkt
	 O+HtaSXm2wq5f2pNbotmpUxtCsFUXl2NyfN5aoBXLXgVXQL0QzJdufffFteRrK1IuL
	 7MPjrk8Vyg/jQ==
Received: from earth.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 568E717E0DBE;
	Fri,  8 Aug 2025 21:36:08 +0200 (CEST)
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
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
Date: Fri,  8 Aug 2025 15:36:01 -0400
Message-ID: <20250808193602.142527-2-detlev.casanova@collabora.com>
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

Add the vdpu381 Video Decoders to the rk3588-base devicetree.

The RK3588 based SoCs all embed 2 vdpu381 decoders.
This also adds the dedicated IOMMU controllers.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 70f03e68ba550..189f07c00089e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1252,6 +1252,70 @@ vepu121_3_mmu: iommu@fdbac800 {
 		#iommu-cells = <0>;
 	};
 
+	vdec0: video-codec@fdc38100 {
+		compatible = "rockchip,rk3588-vdec";
+		reg = <0x0 0xfdc38100 0x0 0x500>,
+		      <0x0 0xfdc38000 0x0 0x100>,
+		      <0x0 0xfdc38600 0x0 0x100>;
+		reg-names = "function", "link", "cache";
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RKVDEC0>, <&cru HCLK_RKVDEC0>, <&cru CLK_RKVDEC0_CA>,
+			 <&cru CLK_RKVDEC0_CORE>, <&cru CLK_RKVDEC0_HEVC_CA>;
+		clock-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+		assigned-clocks = <&cru ACLK_RKVDEC0>, <&cru CLK_RKVDEC0_CORE>,
+				  <&cru CLK_RKVDEC0_CA>, <&cru CLK_RKVDEC0_HEVC_CA>;
+		assigned-clock-rates = <800000000>, <600000000>,
+				       <600000000>, <1000000000>;
+		iommus = <&vdec0_mmu>;
+		power-domains = <&power RK3588_PD_RKVDEC0>;
+		resets = <&cru SRST_A_RKVDEC0>, <&cru SRST_H_RKVDEC0>, <&cru SRST_RKVDEC0_CA>,
+			 <&cru SRST_RKVDEC0_CORE>, <&cru SRST_RKVDEC0_HEVC_CA>;
+		reset-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+		sram = <&vdec0_sram>;
+	};
+
+	vdec0_mmu: iommu@fdc38700 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdc38700 0x0 0x40>, <0x0 0xfdc38740 0x0 0x40>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RKVDEC0>, <&cru HCLK_RKVDEC0>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3588_PD_RKVDEC0>;
+		#iommu-cells = <0>;
+	};
+
+	vdec1: video-codec@fdc40100 {
+		compatible = "rockchip,rk3588-vdec";
+		reg = <0x0 0xfdc40100 0x0 0x500>,
+		      <0x0 0xfdc40000 0x0 0x100>,
+		      <0x0 0xfdc40600 0x0 0x100>;
+		reg-names = "function", "link", "cache";
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RKVDEC1>, <&cru HCLK_RKVDEC1>, <&cru CLK_RKVDEC1_CA>,
+			 <&cru CLK_RKVDEC1_CORE>, <&cru CLK_RKVDEC1_HEVC_CA>;
+		clock-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+		assigned-clocks = <&cru ACLK_RKVDEC1>, <&cru CLK_RKVDEC1_CORE>,
+				  <&cru CLK_RKVDEC1_CA>, <&cru CLK_RKVDEC1_HEVC_CA>;
+		assigned-clock-rates = <800000000>, <600000000>,
+				       <600000000>, <1000000000>;
+		iommus = <&vdec1_mmu>;
+		power-domains = <&power RK3588_PD_RKVDEC1>;
+		resets = <&cru SRST_A_RKVDEC1>, <&cru SRST_H_RKVDEC1>, <&cru SRST_RKVDEC1_CA>,
+			 <&cru SRST_RKVDEC1_CORE>, <&cru SRST_RKVDEC1_HEVC_CA>;
+		reset-names = "axi", "ahb", "cabac", "core", "hevc_cabac";
+		sram = <&vdec1_sram>;
+	};
+
+	vdec1_mmu: iommu@fdc40700 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdc40700 0x0 0x40>, <0x0 0xfdc40740 0x0 0x40>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RKVDEC1>, <&cru HCLK_RKVDEC1>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3588_PD_RKVDEC1>;
+		#iommu-cells = <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
@@ -3093,6 +3157,16 @@ system_sram2: sram@ff001000 {
 		ranges = <0x0 0x0 0xff001000 0xef000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		vdec0_sram: codec-sram@0 {
+			reg = <0x0 0x78000>;
+			pool;
+		};
+
+		vdec1_sram: codec-sram@78000 {
+			reg = <0x78000 0x77000>;
+			pool;
+		};
 	};
 
 	pinctrl: pinctrl {
-- 
2.50.1


