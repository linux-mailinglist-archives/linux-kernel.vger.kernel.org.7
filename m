Return-Path: <linux-kernel+bounces-798220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E622AB41ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370C116E673
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0462E9ED4;
	Wed,  3 Sep 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4jTwXbiK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAC2BF016;
	Wed,  3 Sep 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893282; cv=none; b=comJoyquv6VX0pni0xjA5ceL8GFtrBal1yOb4P5uswYhOHM5if4HV2nWEMlO4gvDuD5MGqvuTnXbttfnSfTdLTGCunt2e9Y/tWW8VMJ15ztOUjjO60iINR/2zsmnDCrpBaebq19z/BGnGLgAVLaFLomfHZ2Zue1lRPMyx9boelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893282; c=relaxed/simple;
	bh=Rqg6RapIBF5ziFSGvvr0096VBaj3jXeHz+ZtyVT41Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iAvQEkR/iVo+Nb44cXoWyoMCCPyo+yOGEbpeTxbOsN8GKCY/r/ZIaqJD8+wy6v3Fa79R1xvz+xwTTyPj6wUIuRYaGazeae9MiyiMfEdAIXu4lIP6S8/fF6+/WaIngWrd85iCxRilPxYM2GDbbCUBRPXupZ+7BJfDuaVUmohWx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4jTwXbiK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839rtlf009516;
	Wed, 3 Sep 2025 11:54:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2UI4Julz+/cFlYvlDcSWVWPvsLMFnJis0/4qYRYcm58=; b=4jTwXbiKQBVyyf+s
	vXamSwODBWYj33BHtP4mMRBvHlKCXUYffgJGi7i0r7Shmk3wW+ebCKfFGuvN7m05
	e+/Y4OIHQS8QUCHoeVABee1tMfFpSVwsVAR1v1BsKVddOUiXLrcHv1u1x59/f/m5
	SD+AuLEQHYRl02B+wwWsHZoyeuVXH7ImWTI5il9YKHX6kyDSduPXleoTM1RkqeR7
	BoX1w15RsDBOs37R46vSeQhotnKitv5r8cnqcUjYTRnBOC61787dGEvglGYwx/i9
	hBYi8cuB8SOZFE3v/6NZhSs3pyovR2OhqqlO/B49ISziy1+IlbE1vLC8sJQmlwKr
	DtmNhA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkgw3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 11:54:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1EF7C4004A;
	Wed,  3 Sep 2025 11:53:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A21B02B4B73;
	Wed,  3 Sep 2025 11:53:13 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 11:53:13 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 3 Sep 2025 11:53:03 +0200
Subject: [PATCH 2/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-mp2_ethernet-v1-2-4105b0ad2344@foss.st.com>
References: <20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com>
In-Reply-To: <20250903-mp2_ethernet-v1-0-4105b0ad2344@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01

ethernet1 controller is connected to the RTL8211F-CG Realtek PHY in
RGMII mode. Enable this peripheral on the stm32mp257f-dk board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03aa379d40ef807d268bbf31a04546..1f81f717426afa323a2c1359413c1f439b5f4dd0 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp257f-dk", "st,stm32mp257";
 
 	aliases {
+		ethernet0 = &ethernet1;
 		serial0 = &usart2;
 	};
 
@@ -77,6 +78,29 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ethernet1 {
+	pinctrl-0 = <&eth1_rgmii_pins_b>;
+	pinctrl-1 = <&eth1_rgmii_sleep_pins_b>;
+	pinctrl-names = "default", "sleep";
+	max-speed = <1000>;
+	phy-handle = <&phy1_eth1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1_eth1: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <1>;
+			reset-gpios =  <&gpioa 2 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.25.1


