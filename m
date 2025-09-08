Return-Path: <linux-kernel+bounces-805303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F284B486CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30614174801
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B9B2ECE8B;
	Mon,  8 Sep 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ghv8pI1J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950332FC01A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319674; cv=none; b=HjFsvNNsNXA38RKN469be2kAxJQf111sy2CXRusE67hcN7ujiht4Dm4+ToTSq4aYUyP4jmq85zJ7sxSe8FOIWSIQQZW04+qwL/2VXFdsa7uCkDFCO1kjEIfu8mZbuq+w4Y6po+VcioPTNi13jFdQBzxXdZdP/xarTFo+v77VXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319674; c=relaxed/simple;
	bh=ynWWfmuOZH738K5h1hVDK+fLyCGdjyFsLL3ly6nUHqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEWeFTiSDKIKmY0UovPBPY5r7l7+0TBbJdz7fvq3Te2lQWdxj85WKUQe6jVTaqlYPtrBfzjEC5K1s2qhyF8zfRb6Sv2jr3LGkhxD67p5nTUaXD8jDOWwrTDDf6ulPEIhmSJITnEMzbevRzSrx9ejlblGZMU+O6FHn81J0N/kDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ghv8pI1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NEWG7009176
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kUehLoxPYFguIke0YZr7WflOvoeqoE8uy3ntTtXR3EY=; b=Ghv8pI1J01x6qXlw
	EDFuRbumT1PoHo+5KtQGm86gkFXXo66O9ee6HrQNcwLjLIaVUU1v1lEdZeLDNU9M
	b7vCz2hsWH573BT+aBipWZYL3e1WccaB+kOyRitLKR0pT6Qk422BG4M6F+QsLha1
	pVFwVmmVPsiVdmiTCljagLT3vMbWSG2lEPPeObUDOucaYgfwpNPv61qLjnUAYvr8
	neR2DO2tu6asW5qJBHLVw9Biy49s6UDyvnaJFDwwRSEpXMHhOMei5a0p3kuLV6Fy
	r2NY5BwpYEL4EigavpcrkqZuBpoajtCITuwJN3r/BhS1scKN45ewzrFtg//nbObx
	3reN9g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3um7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:21:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so38142145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319671; x=1757924471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUehLoxPYFguIke0YZr7WflOvoeqoE8uy3ntTtXR3EY=;
        b=BC3SbPpLqNco2ZT/RGFbMA3ZUgCNdPEv0z/RJl1P4vzqgmL6U/sWH1qdLv7IyVP+Kt
         TfN/Xc3n4Gfe6GTT/JgZqD0YK1tTqqrRpOmhX/L0KEd5j7eRG/B/PQDwFHB6wsfxIsyi
         7Dd9WDZNkGKZw7TlPLGcLA7lZ+TeQ6845Yqf6r18SURYd+CKlYRgkYnusvJLSfTYWIN8
         6Y4wmMRX1N2MvvIdrKuW6MpLZQ68+jYC2nXbZvp/yKupdGoF9rHwQ0OzqD3Vcr909BHS
         q37Jb1GAPzBSAsK5urTDhlvh51kbnLG2o2Iap+A2q2a8tGTBiupxbo6wVinY0UMjbwbm
         4wfQ==
X-Forwarded-Encrypted: i=1; AJvYcCURdWfMaeg++NmV+kWEga3Fiqaeby7kuEkMwPuqiCPkXBSAjK+noZk9FuJAHM85KTMP3g8aUVplt1lycC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJe2ekKQcTbwRnyeUMX1f8DDrYJfzhAWogWSZWMgJvb9AKLnX
	52VY6eEikK1LkGnRworP3Z4GjKOQS4aYBUDuXg11QK3Vxibroql2Rz543/xzNNZXnDKVSuVB5We
	BKdTIlyOLW7sHH4cdC3BN+bRnH8P+v7BLztT77/IysOT7Sht34GucSJYSpbVy/M5lp4w=
X-Gm-Gg: ASbGncv0/fZPGjwFhmvzKDpgFltrhWwv4qLNxZVgi9vWAy/OFGD5PAwMlnpvpQPCoWN
	hlTjvk0cZS7KFnGQMsKo8K2jJRnWDKgCQGPeYHDbmGE/dG0xtmXyDz3gkNH0u2ZQ/xWv9+LsA4N
	c8E9QEl1pRREY7PiUgh6wvId9cBpZiRZp5OLLbRhjxgNwfnp420I3zN5/b9MphOxJp8tDO/LCB8
	c4N4MzpAAouUXVWNWwBPy4BIpoFAIOtqwBABReGxJmSiaXYTS6G1PHBSNjZ06SI0crjjJ47dLls
	Uelw+YLOLrsg8U6fPcQ0gg+gfxxH5tNk5xCLyntGNG3NuuIo9h3BDsJAYflV0iHI7ZCp
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr90918765ad.29.1757319670785;
        Mon, 08 Sep 2025 01:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUtcSUkOkO+dTfuatcYwsPYrubU+qI8Lp/5D/7A6MAMWz8SmZSETwtGcwyZVbO8TqpPMEBRw==
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr90918415ad.29.1757319670296;
        Mon, 08 Sep 2025 01:21:10 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:21:09 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:02 +0530
Subject: [PATCH v4 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-12-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=3663;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=T8ZZhZAuKSNtjHcghH+T9PxS/Yw/QtH5Z1v/0Byz0pg=;
 b=Me+SBvge5FuSQ1h8JklnOvj+EWfveHntHOtpm/71ellh1kiesdCWibSliFZA3LDIZIkIId9KS
 GCSUJXHdIjIDvfCH1de1UK++8Mbfu+gi1CF2V632Znhm1E0jw896p39
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: QR4ZF3Lvw9PB_gKYjFM4N6rMd24OKDQ-
X-Proofpoint-GUID: QR4ZF3Lvw9PB_gKYjFM4N6rMd24OKDQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX5kaYmZSQxTLR
 88rqDl3gJS+Navuaa3T8J8G1i+HwLfK3+ph+RJzIwvk7LQv4e4278nn386vh81RUssSxleZLeOO
 UbZ/SSofQTyIsMPKI+wlI5cq4pB6PVNp+SiHJ/9jOnBfV3EBDMvVxHuMdK0jLfCj1Rj7m9BGMXu
 IAkEiGtbci4xP6mwEFKgTdHnV7EonFbKLnHyvOzXw/nAsn4qztHR7PcH2zVLhejly9hhcBWIayk
 3NCkRCMJUotdxWRpt0RM5k+IP/0e5jeaxAXlpY3VHBIxhjRHk6N/WEroW5GgfsoKGBJx7UhlqtL
 CdwGOWrJOYLdPuzfDMb5txJoesRCc8oMk/lr9Bv4IPpsu05nWOsUiQRMD+ls2GKJwqLgFiiqvai
 6QNCRrzw
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be91f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

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
index 60e365a13da3..3e91ac928fa5 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -300,6 +301,94 @@ vreg_l8e: ldo8 {
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
@@ -352,6 +441,10 @@ nvmem-layout {
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
@@ -500,11 +593,33 @@ &sdhc {
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


