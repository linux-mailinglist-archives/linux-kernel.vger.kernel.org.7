Return-Path: <linux-kernel+bounces-854382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2ECBDE3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A3219C2101
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B432039E;
	Wed, 15 Oct 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HUd1DMjy"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F131E0FE;
	Wed, 15 Oct 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526856; cv=none; b=jAit+aGVfZkGxyTw085Y6cFL0i2Qi2vyxUk7XWGXUZSIveJekdwUfQU7MtFAZENWhBE3Csd6Kqv5UFmv8AS8MQvLVmj07HrpXZkuJEwG+3YEn9svUdWwQz3ZTsSKcRwz2DXYoUDT/ewEnx15zk/1nSmZWIBzGwFY7KhBGOAH/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526856; c=relaxed/simple;
	bh=OgizwtT1W1HTYdW7W6Q46N7j/FNsDV5aR/OdVxogSS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ituiKvpe3hTBvkotBGsd8CcBcFZQrXskhjr+ZPAUwCBQwLChrK2KbyyuBwXTiixV+E/alsX00/EoTK09SRQ9Px6YRzIOfXRt71ifUKtXGZHNVQ200cyjQ+j4aEEV7lDXJgcGmB8hjamEt/h7DcmFmJloYI4Jdx0g89KrWcyntrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HUd1DMjy; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBE0Ms1828485;
	Wed, 15 Oct 2025 06:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526840;
	bh=ctceTll3xAGQoau/JHLiaRcQEETQnVqO+VnzBBxC17U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HUd1DMjygZA2jZ+QvEZXrtxLSI/3oizjKnvZr/nQEuJqYr44CmJBLSchTnu/tgRRR
	 V/jCTQyoB1bB70xiGr8NuPG+qxN554N5NgOjJEzVXjzdCtIZmE6jSY3lR1K4GKWbaF
	 hSpssW3EGiyGfTaGbiDXSIWYO/n3kF8GpUo7WuU8=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBE0e3362488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:14:00 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:14:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:14:00 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHn1809909;
	Wed, 15 Oct 2025 06:13:56 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 5/5] arm64: dts: ti: k3-j721s2: disable "mcu_cpsw" in SoC file and enable in board files
Date: Wed, 15 Oct 2025 16:43:37 +0530
Message-ID: <20251015111344.3639415-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015111344.3639415-1-s-vadapalli@ti.com>
References: <20251015111344.3639415-1-s-vadapalli@ti.com>
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
enabling only the required ones in the board file, disable "mcu_cpsw" node
in the SoC file "k3-j721s2-mcu-wakeup.dtsi" and enable it in the board
files:
a) k3-am68-phyboard-izar.dts
b) k3-am68-sk-base-board.dts
c) k3-j721s2-common-proc-board.dts

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251014125349.3408784-6-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20251014.
- Based on feedback from Dominik Haller <d.haller@phytec.de> at:
  https://lore.kernel.org/r/df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de/
  cpsw has been enabled in k3-am68-phyboard-izar.dts

 arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts       | 1 +
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
index 41c8f8526e15..381880cf9d79 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
@@ -422,6 +422,7 @@ &main_uart8 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>;
+	status = "okay";
 };
 
 &mcu_i2c1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 75a107456ce1..e44542b1584c 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -692,6 +692,7 @@ &main_sdhci1 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 9e43dcff8ef2..3740596576c0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -457,6 +457,7 @@ &main_sdhci1 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 837097751c18..2a7f9c519735 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -552,6 +552,8 @@ mcu_cpsw: ethernet@46000000 {
 			    "tx4", "tx5", "tx6", "tx7",
 			    "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.51.0


