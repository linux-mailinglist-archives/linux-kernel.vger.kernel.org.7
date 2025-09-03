Return-Path: <linux-kernel+bounces-798221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2FB41ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D90C165A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5322DEA76;
	Wed,  3 Sep 2025 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VsTEhjG5"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB52C1591;
	Wed,  3 Sep 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893282; cv=none; b=BvsrxYTSCss7TSvg6vPmayh16n84Uxq9ZkN1kHta12ic3RCV6mvHDo0NFhIUwAn0FA+B1YHNoFY+LybWefeJV0Iqw6diDtklwCmY7yRIErORqezcEDJmkcxqCFnFjl0NCKurMI2l+15ij4ZXUMa3ScU2d+HnRcocKIY3TM/Mf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893282; c=relaxed/simple;
	bh=XNoMN++8FXMdXjwfHfSBD6fUwm3GmnvBCdRqqz3O2HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h+LDVBJqQUWOOtua8WvuRjq4OfnRRd6Dkj7wOXFblzpcIC47MLtEJZb5vKLYNdq7mKtKSjgHnm6C6OtAizuGHcmFcGVzdLToWTtL+H2J178G3UzfBnQ9tYuwPorVsAyMZhuHXO5qsBlIRp4nlkpUvLc6Llm0TBceqg6JZ7ZNKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VsTEhjG5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839lVCA011971;
	Wed, 3 Sep 2025 11:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kr0qsv6QevC8O4Vu08rbDlOZZqjwFJtz5rUmJDaOsGA=; b=VsTEhjG5tkbM2PwB
	KtYjW8Q3Q9BQO01q/r8PVnPvPB8d2Z/Tw11jzAwha/vvs4qfXt19SZYyujqrq2yR
	V7uXAKJgqYcR3xvbXs8oHh1ia4afBlBDrkYcqzKnwNaHmWWvAHwqHpIqo6FeFsmz
	qxcubyAu+FlXGNiwai1oqjRp5ZxNfGSKkktT25I9veheKPhY+NBM7JYCRGcRppUr
	75GCk3URBkQL/A8S4ujbwuIbTI8KuFtuehHM6sxnFfVH6H8VYBhY5QVkg70KGirA
	zGh1H5YwI+5vbyb9RPB5bhjUBhiPAq6eY1XiAM37Bb53PF9xlTznj2VO4CaWuSGf
	KlBcRA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48ur6fqnu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 11:54:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 06B6B4004B;
	Wed,  3 Sep 2025 11:53:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 59CE52B5137;
	Wed,  3 Sep 2025 11:53:14 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 11:53:14 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 3 Sep 2025 11:53:04 +0200
Subject: [PATCH 3/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-mp2_ethernet-v1-3-4105b0ad2344@foss.st.com>
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
RGMII mode. It can either be used as a standalone Ethernet controller
or be connected to the internal TSN capable switch. For this board,
keep the standalone setup. Also enable this peripheral on the
stm32mp257f-ev1 board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 4ff334563599b46e987474076798337e75e16ef7..725846dfaac925646f43db542ed803dd7b9d85dd 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -19,6 +19,7 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet2;
+		ethernet1 = &ethernet1;
 		serial0 = &usart2;
 		serial1 = &usart6;
 	};
@@ -133,6 +134,30 @@ dcmipp_0: endpoint {
 	};
 };
 
+&ethernet1 {
+	pinctrl-0 = <&eth1_rgmii_pins_a &eth1_mdio_pins_a>;
+	pinctrl-1 = <&eth1_rgmii_sleep_pins_a &eth1_mdio_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	max-speed = <1000>;
+	phy-handle = <&phy1_eth1>;
+	phy-mode = "rgmii-id";
+	st,ext-phyclk;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1_eth1: ethernet-phy@4 {
+			compatible = "ethernet-phy-id001c.c916";
+			reset-gpios =  <&gpioj 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			reg = <4>;
+		};
+	};
+};
+
 &ethernet2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth2_rgmii_pins_a>;

-- 
2.25.1


