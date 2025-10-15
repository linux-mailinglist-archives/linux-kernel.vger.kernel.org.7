Return-Path: <linux-kernel+bounces-854381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31572BDE3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC233C5562
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661431D75B;
	Wed, 15 Oct 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bj3UWOIU"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08231CA5E;
	Wed, 15 Oct 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526854; cv=none; b=lF/GY3eO7Z91itcP+al+QQTAb45ldckvu7mTQAbd1Bt3+il/DbNen6pAAYsEeA8Qw2rTpYMISkMl+A7jFsAiWS/FHYwN2Ksq0iKmxSdp/srXg8v+1sjlN2eWaPIhBC1Sxw2VKa7Zfxa3cMhr/XqzrAiJ91sKr7Aw4TlZCEyFqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526854; c=relaxed/simple;
	bh=EC0V+FS8jfOwXhM5m6+Y4UpzZKjsDFrrWO4l6qTRtCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxxakBEK+stm4u3+iI7YfB7GrXxFceJLk3wK3pSN6M5wZ1kXpu+RAfl11VNIlGxzBuChkH+/Lux/xmypbi6IfS25C5lt4TIyiz/MTbRSGQguYyneylkNl7T9igQ1ImF6HS8mWODZEdTruDr4pOcFc7wTZUWIGfV8gjoDFgcGAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bj3UWOIU; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBDrx11303409;
	Wed, 15 Oct 2025 06:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526833;
	bh=n12Xnknm+lBM2YcZiqvTunVXJRCLAC2S7kCe9p1yz/A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Bj3UWOIURMFPKx4k3F0jMIuePr9Foxo5KZFmZO4g6LAwICD7oRznDKljWjZEiaX13
	 5YzA6UJeAST8TByoMV9yIe7WGl77XEEp1zjSCCyvjflG8h1gi+y0I7X3m/yD1jEPJy
	 Ilj24RzRiepB19aEbm2AVC45TfUXDuipTfp3oTH4=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBDrCB770650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:13:53 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:13:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:13:52 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHl1809909;
	Wed, 15 Oct 2025 06:13:49 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 3/5] arm64: dts: ti: k3-j7200: disable "mcu_cpsw" in SoC file and enable in board file
Date: Wed, 15 Oct 2025 16:43:35 +0530
Message-ID: <20251015111344.3639415-4-s-vadapalli@ti.com>
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
in the SoC file "k3-j7200-mcu-wakeup.dtsi" and enable it in the board file
"k3-j7200-common-proc-board.dts".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251014125349.3408784-4-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20251014.

 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index f684ce6ad9ad..f03a15edf954 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -323,6 +323,7 @@ &wkup_gpio0 {
 &mcu_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
+	status = "okay";
 };
 
 &davinci_mdio {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 692c4745040e..fec1db8b133d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -432,6 +432,8 @@ mcu_cpsw: ethernet@46000000 {
 			    "tx4", "tx5", "tx6", "tx7",
 			    "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.51.0


