Return-Path: <linux-kernel+bounces-854380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B73BDE3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA119C0B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9A31D750;
	Wed, 15 Oct 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K05cSIIA"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486431DDAB;
	Wed, 15 Oct 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526851; cv=none; b=B/HeeJhmJKU8vB8r0j2PPgCOH2ZpIQhkHZfdcyd5kNuag19E2EW0baBrRuZZNz33+UmROoEjq+sddUErs5vqK31Epeo7smBAuGRj3J1KqcjXf/5vddTZ9PrTSL/IyANCxEpJnbepJTlh6cLcdO+kEmvIK4Jbd8YXp2Xa6cavpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526851; c=relaxed/simple;
	bh=J7ygL/TEUUKND+Nz6VUas3OKdfcgI86JC7Ebm7GtA28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh93qFwDFjZntY3Srz86gwb/7FHEaT9BhSL1K2mW4Nqf86ShusVLhRMV1Z3vZ7IX1paxzexTBzs69O7Nctg14GFrymEg/0Ar1HbLAam7Kd2C37X/hyCL/DNFin7cHGCcoDDLOnqexN8msaaASB4FxxSp6w8xQb4Ns//hHi1Yq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K05cSIIA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBDnMU1828463;
	Wed, 15 Oct 2025 06:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526829;
	bh=017z0IEMjMla4w12r/wUzzSkyruPh4i0wZF1iCTIWEM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=K05cSIIAUZZAmYrIxZPDM7weBbceohwfZMg5C4sy+ZGOrqVnQJMYxKKKOK9HGdTOd
	 MCvpJIg3vZP1usSD43ukzHnj4Hpif4D5zJY8d0fN2JhmU7GQc8wZGAKSOpxMkBAIsL
	 MhqiFsfCzb3CcGMp/EI5CNnkYXjdw7omakpwJW1g=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBDnlo1179847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:13:49 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:13:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:13:49 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHk1809909;
	Wed, 15 Oct 2025 06:13:45 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 2/5] arm64: dts: ti: k3-am65: disable "mcu_cpsw" in SoC file and enable in board file
Date: Wed, 15 Oct 2025 16:43:34 +0530
Message-ID: <20251015111344.3639415-3-s-vadapalli@ti.com>
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
in the SoC file "k3-am65-mcu.dtsi" and enable it in the board file
"k3-am654-base-board.dts". Also, now that "mcu_cpsw" is disabled in the
SoC file, disabling it in "k3-am65-iot2050-common.dtsi" is no longer
required. Hence, remove the section corresponding to this change.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251014125349.3408784-3-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20251014.

 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 4 ----
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 2 ++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 42ba3dab2fc1..a9a4e7401a49 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -457,10 +457,6 @@ &main_i2c3 {
 	#size-cells = <0>;
 };
 
-&mcu_cpsw {
-	status = "disabled";
-};
-
 &sdhci1 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index f6d9a5779918..74439e0c16a5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -354,6 +354,8 @@ mcu_cpsw: ethernet@46000000 {
 			    "tx4", "tx5", "tx6", "tx7",
 			    "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 0c42c486d83a..8c3f150f6a84 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -571,6 +571,7 @@ partition@3fe0000 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
-- 
2.51.0


