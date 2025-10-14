Return-Path: <linux-kernel+bounces-852616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E5BD976C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD513E63E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440F3148B1;
	Tue, 14 Oct 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QseOSdAT"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DE313E2A;
	Tue, 14 Oct 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446441; cv=none; b=JtDnItkfntAVC0S9ezGm+VbG6H1DrmrsZzrHjy8pb1wdVa+ekkZML43XRop0NAG0m8pYhTxUgHHJflQ9WaSXXmySP5J6v2XCP3XsVH6YGVWiG6gPN8b1zbo72PfdPhnNShwwNRJeVE1p9QKJAQrzgbfbONdsj0Lhbe4NpjriWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446441; c=relaxed/simple;
	bh=eCwTwDYBRBQ6+w3gPEVo0zEbwYSzksC3FwoJ4u60DFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0ZSUs1w3KqqnUz4Gri0Zbf8Zc2UcIY9CDuU2zf0ls5M1ULMqojYPgWk1sWBdidfSKmyv0YwV5r5eZvSTW0tR3I4Q3D+AY0xCUQDEnBTeyzjlnrZe1VJ0KIfAsvTqDpBzk7/MXiua5LztGsrvYU5qun7VXOpCzNR/5f96rR03Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QseOSdAT; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ECrs9C1070446;
	Tue, 14 Oct 2025 07:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760446434;
	bh=WrV16kyvcnACRDiF2HhGxjNXvyNe2FyeZh9fMenGm1Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QseOSdATGOmgmefVVnjhmoJ+nwJeo4yNhOp5kLwfz5zF3rn0LjdsUpIO3+3jkH6Z8
	 u0Wr3XYmHDBKPfXFlnqg7AHQcNSeyDPPo9cpvMLRvZgrTjvkjxmwzZx8ChYim4dbK7
	 lsKMYO2u7G6mfTuk7ut3abeVsD8G1weXFYyKl2wY=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ECrs6x3814822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 07:53:54 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 07:53:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 07:53:54 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ECrhPV055621;
	Tue, 14 Oct 2025 07:53:51 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-am65: disable "mcu_cpsw" in SoC file and enable in board file
Date: Tue, 14 Oct 2025 18:23:40 +0530
Message-ID: <20251014125349.3408784-3-s-vadapalli@ti.com>
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
in the SoC file "k3-am65-mcu.dtsi" and enable it in the board file
"k3-am654-base-board.dts". Also, now that "mcu_cpsw" is disabled in the
SoC file, disabling it in "k3-am65-iot2050-common.dtsi" is no longer
required. Hence, remove the section corresponding to this change.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250611114336.2392320-3-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20251010
- Reordered 'status' property within the node to follow the ordering
  specified by:
  https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

Regards,
Siddharth.

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


