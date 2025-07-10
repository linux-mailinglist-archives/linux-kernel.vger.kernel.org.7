Return-Path: <linux-kernel+bounces-725915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BBB00572
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E83A1C420BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB82741CF;
	Thu, 10 Jul 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VpiNC6MQ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609117B421;
	Thu, 10 Jul 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158354; cv=none; b=HiLWbseZFF7YuKWL5KczIOt8X1pCYarrugtahC4V3N7dh/xPTSCsEd0fHfvovgh0VRD3DGFrD3uf0CbSiGe0FOPTNxhftFFlValDP5YRl6cTeW+sfiQN3JgUVTlgyIhsV+8aldlgJ+pDQzSATooPTlFIQsRhmXSoRf6YP6L5jo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158354; c=relaxed/simple;
	bh=izQ5uWHo2tTliCItBz0mifpMQDS5rB8XDNZSog2nUHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mUYWPNci9AUO9WjIo/ua2S+XuyvmWPGPPyUFHqK3BOiGGEmIy4X/aZHaPZ4eUHmLxjA/mE+XPX04SEx84bAjlcmadP1ruwFqRmqVXhKMxFyQ13951JH7ghgxEm5quc8PBhF/dwew07NA/afZu2It3ybJhujyoS2s/qQqdrAxVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VpiNC6MQ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AEd5kQ1174302;
	Thu, 10 Jul 2025 09:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752158345;
	bh=xWDPqbbfYGSiT45F26qLKVykJ3iARoGM/A8R/24bBls=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=VpiNC6MQl2eUjiMgwKW6ikBm+M25313lYfKGUABrbaNwFjseL6xLoPDuaOE2PrCBq
	 NW7mSCyCwjfqILI1y6kBaMBAxF2TJCDx1m81PyPTxRl/ykuinUB3dlCI4EXwTUmq4L
	 JaAue9YyvIvRJw81hti2FGqKuxCodik2e2tBH0YI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AEd55G1320943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 09:39:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 09:39:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 09:39:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AEd4dI1518686;
	Thu, 10 Jul 2025 09:39:04 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 10 Jul 2025 09:38:59 -0500
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am65: add boot phase tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-65-boot-phases-v2-1-d431deb88783@ti.com>
References: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
In-Reply-To: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=bb@ti.com;
 h=from:subject:message-id; bh=izQ5uWHo2tTliCItBz0mifpMQDS5rB8XDNZSog2nUHM=;
 b=owNCWmg5MUFZJlNZHd1GawAAZH///7/be/fun8TaPfvvvHGnvcj/Ve0rPW73/t7/6n/quXWwA
 RszQxQ0A0PUA0AA0aGgDQaAAAaDTRoaAAAGgDQAANDR6h6TI9Q8kxPQjbRQ6Gg0YgAwmmmQZGmm
 jTQyaZGhoDRk0yBoZAyMgaYhkNBo0yaBk0aDCAMJtQ00DJD1GjTR6mjQZBoaABppk02iaMmgAAA
 yANDCMhhDEyGQyYgNNNABiaYg0aAEHKFXGBFZgITMOOlpIkRE6F8KpYQ0IBQ4je0DZhtNAfM2U5
 /QhrwRHhk0zX2H5QbtRknoppiZhrU2GOFYh5+hKRU/c5AsGdE+5okLOUOaY8D3q0XRjOFXfuzYI
 qaQjzfL/QPiEqRuqCOy1YBUpUKTxJUZqZ4JBBCEXhXxHTRifRUuf7nwF0H2O01eWR3qVTVifCvL
 UQZAdPcagI5giniUj7aKORMwKq3AVC/jiLsM7iDkxqxXbzm0zGSo2RyWW/CUZswnivChVo4RiOm
 WF7q+ZDp14pJ+ILu0jRdZFc/4t9FRJiJ5E3VK6+cz9Vas05OJS+rRdlP5DILoIr7okEi+oSIQcS
 76XwHiTgnHe6I+XnIIDTtUTNDfzBqABBesysw1IK2XMuHpF6yU/2BN6UHk23v0CfHblmBvYKQzh
 IEAbBNDf8XckU4UJAd3UZrA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'bootph-all' tag was added to the dt-schema to describe the various
nodes used during the different phases of bootup with DT. Add the
bootph-all tag to all required nodes for all AM65x platforms.

Mark the mailbox and ring accelerators needed to communicate the with
various vendor firmware and the power, clock and reset nodes along with
the MMR for the chip-id to facilitate detecting the SoC and which
silicon version during the early stages of bootup with 'bootph-all' as
they are used during all phases of bootup

Signed-off-by: Bryan Brattlof <bb@ti.com>
--
Changes in v2:
- removed tag from &mcu_udmap{} node
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index b085e736111660ed0dad5f127ef0c3d79c52fe1d..61c11dc92d9c27fc9e47123698c17118cd522be1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -655,6 +655,7 @@ secure_proxy_main: mailbox@32c00000 {
 			      <0x00 0x32800000 0x00 0x100000>;
 			interrupt-names = "rx_011";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			bootph-all;
 		};
 
 		hwspinlock: spinlock@30e00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 7cf1f646500a16c1d1bac6dfb37fb285218063b3..1ea20ee695875b1812e132cb92526c321172e695 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -211,6 +211,7 @@ mcu_ringacc: ringacc@2b800000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <195>;
 			msi-parent = <&inta_main_udmass>;
+			bootph-all;
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index eee072e44a42f5f66423200975016447d22bdc46..d62a0be767c814706e146bcf95ee4ff84461a515 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
+			bootph-all;
 		};
 
 		k3_clks: clock-controller {
 			compatible = "ti,k2g-sci-clk";
 			#clock-cells = <2>;
+			bootph-all;
 		};
 
 		k3_reset: reset-controller {
 			compatible = "ti,sci-reset";
 			#reset-cells = <2>;
+			bootph-all;
 		};
 	};
 
@@ -43,6 +46,7 @@ wkup_conf: bus@43000000 {
 		chipid: chipid@14 {
 			compatible = "ti,am654-chipid";
 			reg = <0x14 0x4>;
+			bootph-all;
 		};
 	};
 
@@ -107,5 +111,6 @@ wkup_vtm0: temperature-sensor@42050000 {
 		reg = <0x42050000 0x25c>;
 		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
+		bootph-all;
 	};
 };

-- 
2.49.0


