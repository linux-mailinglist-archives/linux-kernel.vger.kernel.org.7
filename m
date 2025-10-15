Return-Path: <linux-kernel+bounces-854379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D5BDE3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB09D4E8A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBE31D72D;
	Wed, 15 Oct 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ShNrOjtf"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F931D371;
	Wed, 15 Oct 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526847; cv=none; b=A17dJB6Oj0DneiPMbNAEoSz3p0sh1XFdPI+IKm7IFSavH922w3q9bt90asIz9/4n970pH00oBQMxU+ibyd7yDwrddwJ42gj35ue78jkwAkgtSduYOrg5aStKGgqRn6hY7jj1HfRb0O4CP3xL0THXT029lqvjfBdGd5JphjZ6fp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526847; c=relaxed/simple;
	bh=O1eWCrC3NVrZVNKW8/8/8uwpMgp6tpjN2Gf2bFUpJbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxmEJPp1HjPdz6fBVk3ieooyN3ojU2o7qhZE6f8EYHS7l6V/e8x+wxSmguO23LrTvWs332ZwlRg83aF7/rbXiV8d3v5UfrVhtlEhP3FZzL9y0hWkfqCx7+Gc6bLXuS/qFQckv7IH5kQwHdv2jSfuI5k20KeR/ZH6e14IHWQSqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ShNrOjtf; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBDuxG1740210;
	Wed, 15 Oct 2025 06:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526836;
	bh=NE7hPxLjGnDIQguwp54QNDgkME3TgBlaetNImw0CQj0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ShNrOjtf9PYWiSRvsgwLbyYXRZFE5UjIaE1mEkS5FfkMBeZMtmQi2wOyOcycbQpvF
	 ey52y6GNkjF1/cmBrzi+q34BF9wc52wQIOWBnCDb9y5o0W/q8cuGVkuBlJPei1VUL4
	 GaL8ryToUrh968FmEQWUxgT9mJQiH83GizguF9bU=
Received: from DFLE201.ent.ti.com (dfle201.ent.ti.com [10.64.6.59])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBDubg770665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:13:56 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:13:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:13:56 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHm1809909;
	Wed, 15 Oct 2025 06:13:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 4/5] arm64: dts: ti: k3-j721e: disable "mcu_cpsw" in SoC file and enable it in board file
Date: Wed, 15 Oct 2025 16:43:36 +0530
Message-ID: <20251015111344.3639415-5-s-vadapalli@ti.com>
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
in the SoC file "k3-j721e-mcu-wakeup.dtsi" and enable it in the board
files:
a) k3-j721e-beagleboneai64.dts
b) k3-j721e-common-proc-board.dts
c) k3-j721e-sk.dts

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251014125349.3408784-5-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20251014.
- Enabled cpsw in k3-j721e-beagleboneai64.dts and k3-j721e-sk.dts

 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts    | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 352fb60e6ce8..9907ef641ffc 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -663,6 +663,7 @@ adc {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
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
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 5e5784ef6f85..0c65c541b02b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1034,6 +1034,7 @@ &usb1 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
-- 
2.51.0


