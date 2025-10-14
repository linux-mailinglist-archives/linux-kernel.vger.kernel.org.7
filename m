Return-Path: <linux-kernel+bounces-852615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD3BD9763
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB45E3E571B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C054313E11;
	Tue, 14 Oct 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n0dB2ok1"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AA313289;
	Tue, 14 Oct 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446438; cv=none; b=JRm8r8GJz+4UJRu/qWBVKK56UHCzy42c/UH+A6qUPCZyIQgluGfV9+lOogpm0l54UxDbD9qWIOPR4rBTLjRhO1eKpYPaEBeVcsZwxI18/62pxVSd6JG+ugQkipBvIXjHSZj/GEGiIm+Hwf5P7DPPssGvpxd7CEzDTmrlNPhrx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446438; c=relaxed/simple;
	bh=2B+jRIduEboFmXwQWF9iEnP+KlNBF44RlRDITaBv7iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFtoYePzu687gJsUS8n9qLjk8xjlVEiQPW3iFqyoOfD+5sL0uP1BYP5aNBmKKdu4unAoGBN3TnnDTz5RxwrzqowGq8iJgBLtVeZok+XKE7gqKvjdcXn1Wpn3poPQKO5wAdmbYbkeHfOHmV0tf6VDQ0/NCoHzCeTYFeCJJTSm8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n0dB2ok1; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ECrp0Z1506713;
	Tue, 14 Oct 2025 07:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760446431;
	bh=10pZ663Njd/ByWxSQm55rtzQH9hSAc5998ktthtwdcs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n0dB2ok1P5OLo35nBLHj5g7yqRLkTqbr/CcZUDYhNLpny2thh0BLfxkkxCp4ZE4BI
	 xIJtXFk9UTymRtiuLRa0BrfTopFlNgj95nX6E6Kkb1b4humxaOR4W4v+ZPkSVQb13t
	 8DJgjrjDAJQFxEPoFU3FQ9f5kVqIZ0qxtJ2JizRY=
Received: from DLEE202.ent.ti.com (dlee202.ent.ti.com [157.170.170.77])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ECrp1b3814800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 07:53:51 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 07:53:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 07:53:50 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ECrhPU055621;
	Tue, 14 Oct 2025 07:53:47 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-am62: disable "cpsw3g" in SoC file and enable in board file
Date: Tue, 14 Oct 2025 18:23:39 +0530
Message-ID: <20251014125349.3408784-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014125349.3408784-1-s-vadapalli@ti.com>
References: <20251014125349.3408784-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Following the existing convention of disabling nodes in the SoC file and
enabling only the required ones in the board file, disable "cpsw3g" node
in the SoC file "k3-am62-main.dtsi" and enable it in the board (or board
include) files:
a) k3-am62-lp-sk.dts
b) k3-am625-beagleplay.dts
c) k3-am625-sk-common.dtsi

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250611114336.2392320-2-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20251010
- Moved changes made in 'k3-am625-sk.dts' into 'k3-am625-sk-common.dtsi'
- Reordered 'status' property within the node to follow the ordering
  specified by:
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 2 ++
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 +
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index ecfba05fe5c2..89be21783e27 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -181,6 +181,10 @@ &sdhci1 {
 	vqmmc-supply = <&vddshv_sdio>;
 };
 
+&cpsw3g {
+	status = "okay";
+};
+
 &cpsw_port2 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 40fb3c9e674c..0fd23ee996a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -723,6 +723,8 @@ cpsw3g: ethernet@8000000 {
 		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
 			    "tx7", "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7028d9835c4a..774178b9aa88 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -590,6 +590,7 @@ &cpsw3g {
 		    <&gbe_pmx_obsclk>;
 	assigned-clocks = <&k3_clks 157 70>, <&k3_clks 157 20>;
 	assigned-clock-parents = <&k3_clks 157 72>, <&k3_clks 157 22>;
+	status = "okay";
 };
 
 &cpsw_port1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index fe0b98e1d105..73a8882a650a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -212,6 +212,7 @@ &sdhci1 {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port2 {
-- 
2.51.0


