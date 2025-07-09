Return-Path: <linux-kernel+bounces-724605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A45AFF4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7A588500
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162525A2AA;
	Wed,  9 Jul 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aHQZn5Yr"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5224A063;
	Wed,  9 Jul 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100559; cv=none; b=E5X/I453qhK4Gzm+Nh1P0pgjAAwcQJrQIZ/MgPEo+/Dgba+3uYDwSZfoo25Qzr4mJ+qDHYFNKR6jMX4tMJRI2Y/LcKVL+V8dSVYCpIYTOS44RI3VleGTMGz+DfX4vY04Xdl805qOoBIFGSwynng93gDQUs9BnHT1ly+aioE8o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100559; c=relaxed/simple;
	bh=ysqyFm2bbGfEc8u3dm+cgbyyWoFjlqbwr+P3EXSSjLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ci4AFUxDek7wZ/Sf9XbGJFoAEP5SXcTO/RgxN+2xmQzqgQAsbCMMb9FQy2PuqyjvegVuIuvdLdlDnqzqmydCaoAHZgjkrnp4jlxS4HY4BbCCzrQLetG8mElUBrp/kbvhdC7Sq5hp5poaZsj76/w/aN/8YIn6ZJI56s0AeonY3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aHQZn5Yr; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569MZoxU1569128;
	Wed, 9 Jul 2025 17:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752100551;
	bh=ieWThEMAjC1kkWBufnewbQMKpVwyrb/YlxHe6w5rs5g=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=aHQZn5YrvDk6zXI/Dlvyw3Sv8QMHXCeyzInI2DWZPb1+u6US0u5Ai+mJwDrnXZlqg
	 NHYJ5H6wmCtFVUjL38niqVgijlq3pRLlDi6AXvlg27ISdQhW5E3LB+6r/YtrPZZZXs
	 AL+LV1aQlrKbVs8iqiPWea9vR8pHYNPE7twvvCsY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569MZogW568838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 17:35:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 17:35:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 17:35:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569MZoU3520527;
	Wed, 9 Jul 2025 17:35:50 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 9 Jul 2025 17:35:43 -0500
Subject: [PATCH 1/2] arm64: dts: ti: k3-am65: add boot phase tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-65-boot-phases-v1-1-e1f89d97a931@ti.com>
References: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
In-Reply-To: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
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
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 2 ++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 5 +++++
 3 files changed, 8 insertions(+)

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
index 7cf1f646500a16c1d1bac6dfb37fb285218063b3..5bbd817bc51464f6605c5b2dc9cb544a109a695d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -211,6 +211,7 @@ mcu_ringacc: ringacc@2b800000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <195>;
 			msi-parent = <&inta_main_udmass>;
+			bootph-all;
 		};
 
 		mcu_udmap: dma-controller@285c0000 {
@@ -235,6 +236,7 @@ mcu_udmap: dma-controller@285c0000 {
 			ti,sci-rm-range-rchan = <0xb>, /* RX_HCHAN */
 						<0xa>; /* RX_CHAN */
 			ti,sci-rm-range-rflow = <0x0>; /* GP RFLOW */
+			bootph-all;
 		};
 	};
 
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


