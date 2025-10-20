Return-Path: <linux-kernel+bounces-861809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F227BF3B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A95D9350BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA5334693;
	Mon, 20 Oct 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fnJ7Qxwu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90B333755;
	Mon, 20 Oct 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995230; cv=none; b=tMg/JXet+CJHClhkABPXK52eeCYPLnZx23rTWqZHB5eLRvH/AFS+YnPdyEdHRIfiNLqhM47qMdPdc+EsukesVFjD1om7Y3iETkYn/ACba3cb4LrU63WZNwOTS2fdWC1cqNCA2APGNvMr3pmhrRBUbnkk7GTz96BjzB+Cckzp29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995230; c=relaxed/simple;
	bh=7PC6JHtD5/xPy2Ey7TaucbPgSAi+lFZoa3bDhNA91IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlinefB1hRfm6IBHpEKITBtB1X0c5pqRDc12N1oY2uNDZ8Wy4e1n+54u0LZ0Hss8Yd61I2Xvcvr97LjD9tjvqmAcW4iN6YrShR1Ho/EJdiY5TljH2niYZKJu/wiQ2Ry1jB+WSOXw8iMpRrpQXrlboZnuu8n4s91aje23cguIO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fnJ7Qxwu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760995226;
	bh=7PC6JHtD5/xPy2Ey7TaucbPgSAi+lFZoa3bDhNA91IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnJ7QxwuQI+5vZ3jGmQUj55/483QdNSBgF5l43Mi+EEwpDi2ZICQsgUilxUC7J6IM
	 nbum5eWpUZyy/rlc2JsZ692YIfPnq45hiOYXIrrkKuXNJq+TIBDsqezToc78YhitIR
	 ygTpmY2a1dvcH3mMdn2h9fh+tFwzjnXxiJfRdGMm/z1Qa+ujre3z1fuf12jhhhg5Zs
	 fvDyPodwjKyyQbs9zlycAiw2CjbtZzuU3/yzte4i01R7xsMs9W6dXOgtk46GNeuoOD
	 rBwIz6NRtmtR6f/B06Gai8UVSJ6IZe1aI29wlnQFWoEWzlIrl7AqOfnl6XH88VAMYj
	 NOb3Tznv9Igcg==
Received: from trenzalore (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 732BC17E0456;
	Mon, 20 Oct 2025 23:20:23 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Patrick Wildt <patrick@blueri.se>,
	Diederik de Haas <didi.debian@cknow.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 1/2] arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
Date: Mon, 20 Oct 2025 17:20:08 -0400
Message-ID: <20251020212009.8852-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020212009.8852-1-detlev.casanova@collabora.com>
References: <20251020212009.8852-1-detlev.casanova@collabora.com>
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
index e2500e31c434..d076267a330b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1353,6 +1353,70 @@ vepu121_3_mmu: iommu@fdbac800 {
 		#iommu-cells = <0>;
 	};
 
+	vdec0: video-codec@fdc38000 {
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
+	vdec1: video-codec@fdc40000 {
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
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RKVDEC1>, <&cru HCLK_RKVDEC1>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3588_PD_RKVDEC1>;
+		#iommu-cells = <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
@@ -3248,6 +3312,16 @@ system_sram2: sram@ff001000 {
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
2.51.1.dirty


