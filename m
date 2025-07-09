Return-Path: <linux-kernel+bounces-723425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9CAFE6A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AC33BB982
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A8293C44;
	Wed,  9 Jul 2025 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iqXzmmWv"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540C9461;
	Wed,  9 Jul 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058419; cv=none; b=G+wAEZ7ejXE2E9w2jqolkU6linc5FE1/lLU6E07xJoobSGMlOwTHdZ+thXi9f45nTAD0oC5jMA3G2a0GSdff4gkr4Ul2zZ2Wu9n5v2mafHCN51aeS64DdOMCjyxd7ke+ndqS7EAbV+N/KT9UstxO8arvLlC6seD2s+RvvjYTy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058419; c=relaxed/simple;
	bh=CY/BhwdjeGx21G1kDCVVLuCWjfh/Ts43xmoyMvUt18I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IU0QB5k2nySdU1rsK/5Nz07LUIGObplBmpc3KTThu1f6HzMq4FiqtEYRfnZm71J7TY8xtuJokh7WcX3X/ZEYj9kX30DA47XBDXOOuaUctaT9WGhxktpn9ZRACh0zkRrLWvtq+FbEw2cwa25ogLQEHYyN1zqixDJFaRFK2vIRfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iqXzmmWv; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569ArWvs1454780;
	Wed, 9 Jul 2025 05:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752058412;
	bh=8dfSnUlzbRs/JYHXaRhRzcO9rF+ehFGsaozJ+ZORW38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iqXzmmWvHquJovqbLwnOzjkvr22aYxrepQyBNPBeKZBclXpvbKx4wYtcISfESYBKP
	 Lqg0zzZiWgtk/iAIPmjMEdmqaG6l9Cdmkx8eJboGlt/EKQAzgkqLpcFtOafWRsh/0V
	 Up+4lilPnLsd3VGy5kw6M8Ii3DKAFKI+AiYAK9wA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569ArW8p1934206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:53:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:53:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:53:31 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569ArUDW3808468;
	Wed, 9 Jul 2025 05:53:31 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <c-vankar@ti.com>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Roger
 Quadros <rogerq@kernel.org>
Subject: [PATCH v6 2/4] arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable Ethernet boot
Date: Wed, 9 Jul 2025 16:23:24 +0530
Message-ID: <20250709105326.232608-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709105326.232608-1-c-vankar@ti.com>
References: <20250709105326.232608-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Ethernet boot requires CPSW nodes to be present starting from R5 SPL
stage. Add bootph-all property to required nodes to enable Ethernet boot
for AM62P5-SK.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20250708084252.1028191-3-c-vankar@ti.com/

Changes from v5 to v6:
- Added bootph-all property to cpsw_mac_syscon node.

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 83c37de7d338..899da7896563 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -214,6 +214,14 @@ sound_master: simple-audio-card,codec {
 	};
 };
 
+&cpsw_mac_syscon {
+	bootph-all;
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_gpio0 {
 	bootph-all;
 };
@@ -267,6 +275,7 @@ main_mdio1_pins_default: main-mdio1-default-pins {
 			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
 			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -547,6 +556,7 @@ &cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
+	bootph-all;
 };
 
 &cpsw_port2 {
@@ -562,6 +572,7 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		bootph-all;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
-- 
2.34.1


