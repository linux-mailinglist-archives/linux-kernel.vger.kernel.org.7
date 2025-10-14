Return-Path: <linux-kernel+bounces-852618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0231BD9778
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8224C19A08B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F204231355F;
	Tue, 14 Oct 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OhkTCu8P"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8E3148DC;
	Tue, 14 Oct 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446448; cv=none; b=VMoGaO+jUeTCAj18amEz8kMPhiU9h53dpDIxWssx13BU18G4vtu46WsUyoNPbvyByV0rKvdFiNinrkv/lKMvQdLZ7RzRwBH8DrjGeSeo75CCjVnp4hr6OGopiaLOWT/PMt0hy0Zh2uTTvtC4M7y6ufXTHqnMJSwKp5/AKc+mg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446448; c=relaxed/simple;
	bh=P1aANXu80dMc5pROFuKvKJBvXaN136dWKRUHilVfqRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxQj2BSCEcYqeaNlspd2pPF71TnpcD5mskkzl0IbY4pzRYM6rE5e1EyGK5wcOt6Zq6XEHZV+ynghND3cMatDPXt2E3gymFJwtkIobr1i/ci8zQZxIVw07DsroVwrV79etuCKxZVDfLvuyiKWaU41mc8X4JVoVz1a6o2R6PENrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OhkTCu8P; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ECs1U01150064;
	Tue, 14 Oct 2025 07:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760446441;
	bh=FYrnd5ZeWZjhOgzEyXl4AKdtZR4o4zcpuDcV4ZvbLMk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OhkTCu8P9p+gcQks9tvUFKbBpwOCRpdj/6SRddr7zuKBKhRjzgDvZjaGMmYPKOPEN
	 zwEXXxtjmzE8XSRgrbqybT32DYTtKhNbE7P/zlS+K/hO6zli/YTnv7cWx3wID4egka
	 UyDRPL4bRLFAo1R6hsfkp4wFhAa0Qlrl1e6R6jeM=
Received: from DLEE214.ent.ti.com (dlee214.ent.ti.com [157.170.170.117])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ECs1SU3814849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 07:54:01 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 07:54:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 07:54:01 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ECrhPX055621;
	Tue, 14 Oct 2025 07:53:58 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-j721e: disable "mcu_cpsw" in SoC file and enable it in board file
Date: Tue, 14 Oct 2025 18:23:42 +0530
Message-ID: <20251014125349.3408784-5-s-vadapalli@ti.com>
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
enabling only the required ones in the board file, disable "mcu_cpsw" node
in the SoC file "k3-j721e-mcu-wakeup.dtsi" and enable it in the board file
"k3-j721e-common-proc-board.dts".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250611114336.2392320-5-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20251010
- Reordered 'status' property within the node to follow the ordering
  specified by:
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 45311438315f..5906dfa97205 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -769,6 +769,7 @@ exp5: gpio@20 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 42a21398e389..d5e5e89be5e9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -551,6 +551,8 @@ mcu_cpsw: ethernet@46000000 {
 			    "tx4", "tx5", "tx6", "tx7",
 			    "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.51.0


