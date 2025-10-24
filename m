Return-Path: <linux-kernel+bounces-868779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67558C061FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575573AF701
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069142DECB0;
	Fri, 24 Oct 2025 11:50:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8452D4817
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306613; cv=none; b=luoiKPvCAerSABSxBObgyeZ1AbCiXhWAwcazgUKwuuE5Mzg0ERrbiZm30GPh9WkqeAmAT3p3eWBpdD/7GAn1s7VaAvTSC5eMOiN5z4HQ5b4jKPtyyGLeEjbB2zHxH2pynIMEjnmMnB9BZFhIzHnleOSwBfmydubRC+9r+XyLFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306613; c=relaxed/simple;
	bh=zQNLx6McgX5ZBI5nCKCJRfU5Uo1WNEZSPvfjbFobIVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSRVBNugs/ZTkE2wYoChgvL07+ySlYJxjeCXCe3WZknZt8M9cLRrDWYAbqheGrqafN23jyTQqq7LMrrEq2MEmGmsW6H3nQCbPbkqpNIf2qZxCnZDEUDXk2eR78EuLz/NgetRJX0f58vKg8LdZzHb0l7kIWs+xb1YQp9MMYodLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGJ6-0002FG-85; Fri, 24 Oct 2025 13:50:08 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 24 Oct 2025 13:49:56 +0200
Subject: [PATCH v5 04/10] arm64: dts: socfpga: agilex5: smmu enablement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-v6-12-topic-socfpga-agilex5-v5-4-4c4a51159eeb@pengutronix.de>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Austin Zhang <austin.zhang@intel.com>, 
 Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Austin Zhang <austin.zhang@intel.com>

Add iommu property for peripherals connected to TBU.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 4f7ed20749927..4ccfebfd9d322 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -303,6 +303,7 @@ nand: nand-controller@10b80000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
 			cdns,board-delay-ps = <4830>;
+			iommus = <&smmu 4>;
 			status = "disabled";
 		};
 
@@ -329,6 +330,7 @@ dmac0: dma-controller@10db0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 8>;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -346,6 +348,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 9>;
 		};
 
 		rst: rstmgr@10d11000 {
@@ -468,6 +471,7 @@ usb0: usb@10b00000 {
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr AGILEX5_USB2OTG_HCLK>;
 			clock-names = "otg";
+			iommus = <&smmu 6>;
 			status = "disabled";
 		};
 
@@ -553,6 +557,7 @@ gmac0: ethernet@10810000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
 			snps,clk-csr = <0>;
+			iommus = <&smmu 1>;
 			status = "disabled";
 
 			stmmac_axi_emac0_setup: stmmac-axi-config {
@@ -665,6 +670,7 @@ gmac1: ethernet@10820000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 			snps,clk-csr = <0>;
+			iommus = <&smmu 2>;
 			status = "disabled";
 
 			stmmac_axi_emac1_setup: stmmac-axi-config {
@@ -777,6 +783,7 @@ gmac2: ethernet@10830000 {
 			snps,tso;
 			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 			snps,clk-csr = <0>;
+			iommus = <&smmu 3>;
 			status = "disabled";
 
 			stmmac_axi_emac2_setup: stmmac-axi-config {

-- 
2.51.0


