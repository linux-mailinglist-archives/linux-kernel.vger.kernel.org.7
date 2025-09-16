Return-Path: <linux-kernel+bounces-818627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2DB5944C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4534118817F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755E308F1F;
	Tue, 16 Sep 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DImXAdby"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A33081B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019679; cv=none; b=PpSslE4Q4GHXmzPz15TVbCxjcXi8ZoVmjWWj3jKU29r/79T8Fun0blxumtbMEQjzlpN3U7WyEySPx2/EUOZKJOVKaskuaOXJ9C8V1KWFx4E0eYT11dL+LWtFaFuWkaF/+nVpsBzq9TpBrqGKJiSRQc9pu2+2gygsfUXVNtIbEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019679; c=relaxed/simple;
	bh=EVxv7pTuTXtbJBbTq1cFIyCcb5+PnMhD77kH76TEvKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsZQI2erEEZfGfm1MQCjgap/lUItGfy8hrgGPhNeFGe8mvwja9Ctilw6R+I6WUbfdvtagKL2Tm94N/1oQlmBUoGPS0pjsqPKlfK1iJDufJIdCgPuJ7b704TFw0ebT/02/yOv4sLYXD018pHvkR8p2qZTNh+5vq/bth68V7vA7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DImXAdby; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3qYWY014382
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=; b=DImXAdby+60nerr4
	Dzmp+kxlH5hu7V/UUx7cNOaGy4IpVMbvDPpX6nLvLVBRuTqpMdj7KtzLFF20lKe1
	h8jdrKqgHs43vf70Duy77C/ZC3FDGSwkK9bR7ayq4d1GA6WaKVAWk+lvKJtAYc2J
	KEB/qPMpzZzVtRdwwDPj1VqIiXMVx5IOSp/rQS3wKhWtoLtwksIYvBlgyXDF3bYE
	F22adXU3/lQQAG/m1uiA8nLHx+M6/A1ZGkLaqvdF4TPZWE4xgwoXa1v8HZbCqpRF
	BTa3mbsLRK7vzbCaGnECQUPYuI8xFIrK+pm0aSTYdDoLjCX5dkFgQ3F/40z8/0RC
	d2BEtQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072rjfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2675d9ad876so24054465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019676; x=1758624476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP2WRzsTd7EkrIRJP7HeDDxQJ4fUG5rGQbk5fNbcD/c=;
        b=MaRS4MthWco7Km7ghDvjB8TaBlIeHfdR3qkIxOvt2Rghzr2golFMXXKWwDtsVjHH+m
         7cvXgfwEwdLm9I2iUTrIbdGlIsHMaGheLYQkCc92EFGcYJ1uUtuQVc9tAZa0XGYrGBM6
         94hvZ2h+tSyEEAVPXBcBXKlQdARWRoMGRCXYnLcM/7CL+LiCehiUqho1bKraDVm8Yqce
         csDRpztdMbwGpHsVWs7HR8G4sT/Od8DrOj44FymEgiwJaGsp/uqsA2Jly330N5HWVODG
         ALFzPvullyi/JSrJ3qL4ipQggNb43Zfy5Oy/f0/uZiSizJVBpAyM2pNmqXFdPA/UAWag
         FFqw==
X-Forwarded-Encrypted: i=1; AJvYcCV1eyYMBr4qjt6ccX/5r7v80M003+PPA35vDwwAAP6q4sdkFAy6qfk74+pD8aYuovq4osDheEYMrpILi6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7nVQ9+XOQi9zsc+Gm6gZqqMVqPSlgkUh8XTnKU1mhMH4M+xaB
	Eic5Lo98O+5gy1VFZ3vq4I90IfhVVHhHqwyLiTa/CYL7wJI8cVmmwcLeEmgYdjK4IKO8W9F4Fy0
	OhI/UyZG0TBvGOE1iRXZsaaPODxih1mluZEzu2sViGN2Y7uMBVC30kEdxlmTI1zNGmeM=
X-Gm-Gg: ASbGncubg52G56g1d4U5CvtR5pHkAHIYgWJC+pNoRQegtRwYucIkPkihO+8S4KydB9V
	bp2RdCcX68Knlu29TuOeaup5885CskFiwHiozbj3sGuT+yns4YsafdQA1mLeoBh893uZbGxCsO4
	Sc1WBMKMQNsN4gmYrcMC0AFmKQAk8TaMcroY6VXolaoflznMxMzNZZzoqT2OLj+QKPAYnf/T5N7
	HU+c7uw3hS/DJ0/LQQojF6hcy4R1sLxehjul2JPKmtF9bKVo8AALih2VMhZLAjZDSJ+r6oVCUz2
	sy6WUzQF4ot+VBFlICgiPqdN2GjqPBn9d1pwa83di9crdU9QcnY+63+XOLpF4X1FmbLJ
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr220848375ad.45.1758019675674;
        Tue, 16 Sep 2025 03:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhaMhuKnR3pAjBpv8t60tJ004Bz9yN6AtGwrZpjJVtA5m9XzDgoW9T0S6/ba9fgL6bzap8Ag==
X-Received: by 2002:a17:902:d2c2:b0:248:96af:51e with SMTP id d9443c01a7336-25d27d20531mr220847945ad.45.1758019675200;
        Tue, 16 Sep 2025 03:47:55 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:54 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:58 +0530
Subject: [PATCH v5 10/10] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-10-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=3663;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=d0901W5oS2IB+UAGgSU2EHYZ0jt+yeCd47Ja4xYspro=;
 b=rvMKyY9l1x9ja3pS3CXgVRZG9ysWFnYa7CyFQpUDBx1Xank5T/Mc5hl5+Q+cC0Vj5HTIOF0R3
 kuFZqw2/MK9AoDamBj2yds0dWyb3VbObnvctRJl/8IsH3rpc0UXcQJC
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX9fqgzCHOxR1g
 aksSX8+UaXWwAQELfs7Y0DimL4P7Pu7BfV3FWaAeFLz9nRhM/1SdRFN4qIPOMaGxlfgNY7w3HJ0
 ju7DrOkcJVLH8QT741vPjcPk3bnHEimNSXXhihHFG8tMeAkZoWOvJplH6pHcAF8cA88cr36aKhN
 ac5+wEpf8hyplREHpLtOofmDLVK7IcbHrs525B+olp8mrt9bTnhQDLsA7G4bHraGuFN6LhtMbnB
 n6ccvUlMdidV4oiv4577NOoEXsHVwCgOHepGjQT55F/NvcwopxEHZS7t88kIgXLkdaA9GZbSzJ9
 vMfCzAEpRfrM9ULFMXm6V60EVDJ2DsYPIzevgqk2gk1pLfLSG/M5KciwiTE5RU/6OSI1Fc7qKkx
 jGlNtby/
X-Proofpoint-GUID: pWkRvfWpQ9Al-t7-Mv6tVv3sP2SykK6T
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c9405d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pWkRvfWpQ9Al-t7-Mv6tVv3sP2SykK6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 0170da9362ae..d5dbcbd86171 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -17,6 +17,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -352,6 +353,94 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy@1c {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -404,6 +493,10 @@ nvmem-layout {
 			compatible = "fixed-layout";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
 		};
 	};
 };
@@ -552,11 +645,33 @@ &sdhc {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		clkreq-pins {
 			pins = "gpio1";

-- 
2.51.0


