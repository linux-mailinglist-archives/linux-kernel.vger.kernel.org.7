Return-Path: <linux-kernel+bounces-798224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19645B41AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7841BA57E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149B2F998A;
	Wed,  3 Sep 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cKyQ09sO"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9471E5206;
	Wed,  3 Sep 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893284; cv=none; b=geMW1NjALqCjoKebXs9FYU92AfoEUC8C1P4Ig6OhftfvnrLN1JD4AGNZsYNhKDTwHYwfqVRCOLjFxzQVkMikIqaPVNJEjEYyPUl8XCowmeBtv6y7DdWfAnmcr/9FAmgWLrkVA9XaRiIj/coCYgDZ5NzSc/OMGGcSg3yOP2H2lEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893284; c=relaxed/simple;
	bh=hLn1vk+Tdm69GY6fzJ7UVGtKjyKPC46YpMhYCEKNLLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rbjafOjFZlTG90CTppsdHY8FmApgPqFMiANgJKmanSsZ3wzIGIgiJzVZZXM9r7ALV1BIPruRamo3pUoaAfk1EKn1n0uMJzH/irNqNYdhz6kACoEOO5fZMuiIYxVhdR2OH/s7MO/H3lG8KAlx71LZuhJEza/BcDQFHzEBdM54+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cKyQ09sO; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58394VNK018120;
	Wed, 3 Sep 2025 11:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+Wi1axt30079Z+PAa3WmL7dXmv5L8kwn1wbSNmLV1gw=; b=cKyQ09sOQqSFkPEU
	hHYH9y+thoSZ8rmdlEdkK/tlK5poGtcgzXssZzwDBo/yNa/Xzc0c06DEjLIoeiDZ
	J1lnE6iyRT/6jAjomqYpZqV62AwexrFCqM20q9es/bL+bPAH6w23PX0vpyfYLfmL
	7+T3ko3BFHmRsyEA4dQ35LSETNK85IKRAH4eIuUSX8D2vBi3VZBA/Mxg6aynUMka
	Sc0x2HdgKKAWamNMZfr+4MkDodSx66MidSAfhdFxZT4ZqEMsQAxcMbf4sQl2N4Qc
	HlYBQrdZ60qO4+soJeqDQVgFLjzyGwZwjPeGnij5pTXasTeYg/NIeEFoJQrNRazd
	gEBNzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2p11r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 11:54:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 620514004C;
	Wed,  3 Sep 2025 11:53:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0DD9D378FCC;
	Wed,  3 Sep 2025 11:53:15 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 11:53:14 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 3 Sep 2025 11:53:05 +0200
Subject: [PATCH 4/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-mp2_ethernet-v1-4-4105b0ad2344@foss.st.com>
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
RGMII mode. Enable this peripheral on the stm32mp235f-dk board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index 04d1b434c433e5f76d120f4bd254c15a2de3fb94..d60b7a4e893559fd7978c9a1d56915f9e7a64f60 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp235f-dk", "st,stm32mp235";
 
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


