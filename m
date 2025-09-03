Return-Path: <linux-kernel+bounces-798223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940FB41AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC17B7B51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543D2F659F;
	Wed,  3 Sep 2025 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GCTJxliv"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60A2E8B9C;
	Wed,  3 Sep 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893283; cv=none; b=a2mRTc8c7CxdyY6nV6TZzYjvcsnW/Bl6aX/FEDSDwY/FQU9xKgIFzbX8JTbZ3AcpeoowrVTKyOKLn8/Rgt/0qW4KBlEogquGwgC13+WpQDEXKDk7YLp8pGWbwgoSngfIsj7QEHvIOqWDBtq/dIV2IMs0DpqZDsf7WR7zfwL7Ots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893283; c=relaxed/simple;
	bh=FzhqjKrHNkynclL5oX3mI12Q5gkkp9t4CcwkmCAgCCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XfMfiMTinjmLvqJNTN9FwHRPZ+70DyN5tmRvMOMNJ3pvVT/6WkhMV2ZsiJVEJjjPQi3Vyr08h88Ht+7QN+lovS0svLPQoLAY9Y8BzrVkrxjlEO1CpZDUDFOkBjTjFaKYAEQS+7do+G73Cfbp9nXOUT/WGtYrQBTu0WwBLdgqw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GCTJxliv; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839j0hu017831;
	Wed, 3 Sep 2025 11:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zCAA24aLVQ5UCYBRXPQVDGjfntLRUibp0ZLGnQkGxKE=; b=GCTJxlivJZPLuLp7
	EXwKH9yLkzlTnqoMuX8htzGgM3tbXpv0MmStcP+WXp+1Wii6y/3RhdceufXeBoCm
	i0gOW7RuKzCnDyd5gDV8Mu/k4EqSjREBhPvxlYgN5rH0L8jHHHb6gvdQCVE1hgfO
	JPk5wmpMzInaVutthCcwzHsdA9FT9ykfeWWNwwcM0ugAKuGZsrYYxSG8vcPreL1T
	XGNKAjZM2FKt/Z+VjgaMM0nu1GdVZ9DKCKiul+cDvlIqO05lTC+ySC+lGnqLVzi/
	g/lebYtQkOepkvNAlX254oJE0/h4BypuOrySxUQfKIaMXC4VCXUZbPOwFsAL6PQy
	dGyh3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vc8m5hxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 11:54:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1ED9140049;
	Wed,  3 Sep 2025 11:53:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00EC8373227;
	Wed,  3 Sep 2025 11:53:13 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 11:53:12 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Wed, 3 Sep 2025 11:53:02 +0200
Subject: [PATCH 1/4] arm64: dts: st: add eth1 pins for stm32mp2x platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250903-mp2_ethernet-v1-1-4105b0ad2344@foss.st.com>
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

Eth1 ethernet controller is present on every stm32mp2x vendor boards.
Describe the pinctrl of eth1 for each of them.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 126 ++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index 5ac9e72478dddb82be0ef7432d7e728932b2f4d6..3a2a82de48536ef4fe625b69a61e91f746b0d53f 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -6,6 +6,132 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	eth1_mdio_pins_a: eth1-mdio-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 0, AF10)>; /* ETH_MDC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 2, AF10)>; /* ETH_MDIO */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	eth1_mdio_sleep_pins_a: eth1-mdio-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 0, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('F', 2, ANALOG)>; /* ETH_MDIO */
+		};
+	};
+
+	eth1_rgmii_pins_a: eth1-rgmii-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 15, AF10)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 1, AF10)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('H', 10, AF10)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('H', 11, AF10)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('A', 13, AF10)>; /* ETH_RGMII_TX_CTL */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('H', 9, AF10)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('C', 0, AF12)>; /* ETH_RGMII_GTX_CLK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('F', 1, AF10)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 2, AF10)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 12, AF10)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 13, AF10)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 11, AF10)>; /* ETH_RGMII_RX_CTL */
+			bias-disable;
+		};
+		pins4 {
+			pinmux = <STM32_PINMUX('A', 14, AF10)>; /* ETH_RGMII_RX_CLK */
+			bias-disable;
+		};
+	};
+
+	eth1_rgmii_sleep_pins_a: eth1-rgmii-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 15, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('H', 10, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('H', 11, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('A', 13, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('H', 9, ANALOG)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('C', 0, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('F', 1, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 12, ANALOG)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 13, ANALOG)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 11, ANALOG)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('A', 14, ANALOG)>; /* ETH_RGMII_RX_CLK */
+		};
+	};
+
+	eth1_rgmii_pins_b: eth1-rgmii-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 15, AF10)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 1, AF10)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('H', 10, AF10)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('H', 11, AF10)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('A', 13, AF10)>; /* ETH_RGMII_TX_CTL */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('H', 9, AF10)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('C', 0, AF12)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('A', 9, AF10)>, /* ETH_MDC */
+				 <STM32_PINMUX('A', 10, AF10)>; /* ETH_MDIO */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <3>;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('F', 1, AF10)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 2, AF10)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 12, AF10)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 13, AF10)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 11, AF10)>; /* ETH_RGMII_RX_CTL */
+			bias-disable;
+		};
+		pins4 {
+			pinmux = <STM32_PINMUX('A', 14, AF10)>; /* ETH_RGMII_RX_CLK */
+			bias-disable;
+		};
+	};
+
+	eth1_rgmii_sleep_pins_b: eth1-rgmii-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 15, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('C', 1, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('H', 10, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('H', 11, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('A', 13, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('H', 9, ANALOG)>, /* ETH_RGMII_CLK125 */
+				 <STM32_PINMUX('C', 0, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('A', 9, ANALOG)>, /* ETH_MDC */
+				 <STM32_PINMUX('A', 10, ANALOG)>, /* ETH_MDIO */
+				 <STM32_PINMUX('F', 1, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 12, ANALOG)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 13, ANALOG)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 11, ANALOG)>, /* ETH_RGMII_RX_CTL */
+				 <STM32_PINMUX('A', 14, AF10)>; /* ETH_RGMII_RX_CLK */
+		};
+	};
+
 	eth2_rgmii_pins_a: eth2-rgmii-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('C', 7, AF10)>, /* ETH_RGMII_TXD0 */

-- 
2.25.1


