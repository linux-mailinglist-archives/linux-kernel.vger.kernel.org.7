Return-Path: <linux-kernel+bounces-857608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B5BE740F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B1962086C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD512C11F5;
	Fri, 17 Oct 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tIKmWjWW"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1644264A65;
	Fri, 17 Oct 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690839; cv=none; b=J0lNKPau35+cS2kfrnG4zfiLCu26y2nB99kPOIgIRvHPjnfSBOgEumtit9/Gng0Xfl1sPsPEIv69p4nhxIoCcoAXMHyD1smtjk0eRON2xaJuS/JJCky2Cp0+U5i3V0EFtt24yHPef46D5THJnXvD1PhYUjuP+/wcqYNPfXeZDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690839; c=relaxed/simple;
	bh=Lr6lO2Ly1pchMPtN3FAdcZ+RhOF711iRdOqXbtdjkQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCqf137sz0oe44hPzlHP6T0kdqkto513ciLJP7FK6jaD3F4NOKFW7epQS3p9hzaDpgj/ykX7HotyobV4Pl84ziYJc0GE/9T2ZbgJ68HJmOclJ7dK0hYzTvCqCeJWx9YB4yLjsNHH1uZ0qHZ+HmfKA0KImYuF+CMkIBs9n0Q3/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tIKmWjWW; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59H8l6Vm2228036;
	Fri, 17 Oct 2025 03:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760690826;
	bh=UqonKPjynlzAg2tpJmTeutIHA66gcJm6tk1HkkdCnUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tIKmWjWWPrckJpT6AP4BauHl1WV5i42Jm9Za7VygCcGFPo4A4DxSxTUCGGfYO0AoQ
	 xxZUpEJKqm2s4lCnkJ1x0tqfSygCovRBdRpR0WvOx6IUYkidmMAkG4ke4g+1kofO72
	 yIdHYXdRJbGYkSPMxJQ4Ye3SkubSFWR7eisLCR4s=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59H8l6YA2271184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Oct 2025 03:47:06 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 03:47:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 03:47:05 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59H8ktEV1019203;
	Fri, 17 Oct 2025 03:47:02 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to SERDES0
Date: Fri, 17 Oct 2025 14:16:53 +0530
Message-ID: <20251017084654.2929945-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017084654.2929945-1-h-salunke@ti.com>
References: <20251017084654.2929945-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

J784S4 SoC has two instances of PCIe which are PCIe0 and PCIe1. PCIe1
instance is used for PCIe boot process. J784S4 SoC has four instances
of 4-lane SERDES. Out of which SERDES0 is used as PHY for PCIe1. So it
needs to be functional at all stages of PCIe boot process. Thus add the
"bootph-all" boot phase tag to nodes required to enable SERDES0 at all
boot stages.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 419c1a70e028..31a8dea2fa8f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -970,6 +970,7 @@ adc {
 &serdes_refclk {
 	status = "okay";
 	clock-frequency = <100000000>;
+	bootph-all;
 };
 
 &dss {
@@ -984,6 +985,10 @@ &dss {
 				 <&k3_clks 218 22>;
 };
 
+&serdes_ln_ctrl {
+	bootph-all;
+};
+
 &serdes0 {
 	status = "okay";
 
@@ -993,6 +998,7 @@ serdes0_pcie1_link: phy@0 {
 		#phy-cells = <0>;
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
+		bootph-all;
 	};
 
 	serdes0_usb_link: phy@3 {
-- 
2.34.1


