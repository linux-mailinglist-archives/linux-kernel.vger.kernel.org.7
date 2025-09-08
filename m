Return-Path: <linux-kernel+bounces-805293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9716B48690
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9EA179F22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC572602;
	Mon,  8 Sep 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTQ3RELc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95972EB853
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319624; cv=none; b=c+HIM10j1/ov+jxt0IvwdW9OLmOFay3N1HtwFuRUz/XTp8VPV8/H3jCZ41j7hYVHXwgyy6yYwHUfTM1LX0ZYnFQr9L/G9ZY2n7QNGYBwAMblJF04Vh7Km9jxgAblHj8tdZGy/7xsilb7xIU7e9vVTtSgzauAZWKGbhGqjmLXc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319624; c=relaxed/simple;
	bh=OOKP3IxxuvrHC6Z+46EpwtrPsYz3mUsSZbROsUuhS2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHJUyj5CbKfrPm4XKvmFTZisQRhM+Lvqb/e1658EpAT9o9jc6sJoA0dMtJRYK6gItF4UmktR+WrxtnJBZLIm7fBbc0O0+fLyaZDSA4XLr/QUrdPgMqrfxWDkjHH2tGyCsBdm/bBRGGwPlgaxFo6L8ZaLgefqet4ot03R3k9jWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTQ3RELc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MuF23005773
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	faMteZ6S1wHqGokADuRhWLiX/zE3TInCiyV91pcLmgY=; b=jTQ3RELcSIjLOBqi
	CWSulV4ekygDoZK/oQ4NjO0kvdb2AkK9AxUQ8yF3RxYySSubX9/+2AucqCG5+C7I
	IYaxzzy7PLGbbt6JBn94mbck5aEufSN9acqRLA+j6gC7bjz4B9y+KL3c0EpDmEsM
	DnrqmYc9/2Pfn4q7CBmykkRBsSuTSPN6HO2ojljQQ9/R5QAGksoTS7Pj3X9N6M8+
	QD5LIbTqpiMPPC8mOoo1FuBw+hvPWxLPKNx3diCpwQNMd/mq++6xsfTLuBilwqn2
	biCAf0i/0N8WZ6hnbZexg7gKT5nytDYRw9kSUxvAGH7Kic3BpuQ+j5MyUQJ3vYDl
	F10zzw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8uvc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24cc4458e89so94513975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319620; x=1757924420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faMteZ6S1wHqGokADuRhWLiX/zE3TInCiyV91pcLmgY=;
        b=GQVkQmrGCicLUTMZHv/3AVHPSbglBIrVO2wXrQW3rUzmShYH4W7kTvkXy9eAih7eJB
         x79rraqciktrNcLjYkII/iiOWFVMGKxSZwU+snJHHue7+Fejb6gGddqdibMTx9kF0bwy
         9DWavS7WXytU1FJSQQJjXpWscCF+tG9TJNfkM8kOE5LLEul5Kd/GchVNKm01K6KFMYDb
         3eMIo8aSmBuQ4kwK5giVWuP68L7K2LxeHIX+Sxz1hUsfsbo0YwHgEwIuZsjXylFuvu+h
         PT3sgfcL4IsHCODIrNvkPcy45a8PBwqZ3Ev+lZPad85+dVPaQtRUWQInKQGW8MxbhESd
         iG4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNarHHx2TxtUApPb7XdJNTQvGW+b+p41azPfoc0+OrYkzwOS+2BVL8TGXHW7cxra1rSbd+p6fLYfPLo2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYH7nv8krXFxske9tlVwFscZ7E+NCldBSioOAHxrtfoZXJSD9
	4XbSXEciSbIoOW0p21vOBjF+4P2/OBOg4RqgwY902Ux6E5tUFRfZpbHEasLIwUbZpV4H7VpBkOE
	WQIkv2MJ7lQgJG2m6Yv8kHOOmYGvm690MBJ8ipaGevxzCXmk+BLQGRXuetk9CvjDx+uA=
X-Gm-Gg: ASbGncuGib8JMIhvJB2jYXFMIFHN6nMc+il9MaD2emJtveu4AkWOz9RRsyciWR1ZE/e
	jHHOMKwCpK8+wwFUQt+3hESiAAHQzyw+lHPHIT2bTCJzZbQwLrsLdo5z+zzQH+UY5UIuyCYjZEA
	M3X34x/F4ijfRLlC5tl+BrTKd472me/MH8uEwbtXJKw0LWeZ8D1G4y34BlLoXh9MSrTBeZXsc38
	r/vb0gK3PyHWk/JE2L0pxdku3+NJ6guzVDOEOC10jwUHxiNCJCgePHodKlfYCzu8dEi8A9nODoK
	z//jK1J7KGP7Mt90DjhjdrGvi06TDmeXrM63HOhyTAHQdpr6a8DwEvyb4HrLwlzspNzU
X-Received: by 2002:a17:903:90e:b0:24b:1785:6753 with SMTP id d9443c01a7336-251734f3e0cmr79172205ad.53.1757319619980;
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHE0/CxZRdvfy8vSn5LYlLNvjyAMh5WISGk4qCxX7YYAm8cG+QyMS80zKFSv7DBuoACRrAew==
X-Received: by 2002:a17:903:90e:b0:24b:1785:6753 with SMTP id d9443c01a7336-251734f3e0cmr79171775ad.53.1757319619482;
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:52 +0530
Subject: [PATCH v4 02/14] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-2-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=3497;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=OiBTb3F2PHVd/TNBpEA9CdLRTPKY8wFa90rNHzmvnVU=;
 b=wQqZJgyyWQK1E7EecFQDbe/xkDNHHqY1QcgMke0duTkHdjcrkuZwVbAqJ2qePTObIej24bc7W
 d1hAQsGQ+BUBPazoNoZqDHcwcelBEZ2KlvVXWIztJfoYahWH9GYfq04
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68be91c5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uosFifNmqa3Wiex5iiQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bTxAjlEEz6kFEfVpAnnYxQFUE7nNW3xL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX6nIY8FTKJsWf
 aB1BMDXE8Aygp7frLczw2Kt+MW0H1pB6cjjX60eRh4y4X1D6tZQg2RWhjNRU2TSBnnJUEcx3ydJ
 qnd5y++jXkgLqVzGW+xHXpYtX/5jP+jNjxYL6BhEJ3a/y6gJh7JkbZqA4kfXQAYGynHIsV5v9oL
 4q1TOZd98ZDEEnGrMj5mEZu1D5i6KKcEkeyrpr8LFE/eFz3F9qHgmXyxtVDIokX368MZA77GoX4
 5tGvQuPg8kkjSu7XLocFSHURTCQMr6ahKPckIOw0ZEK9u3GG2libkTtxSGp9qHsaYLZwOMdgvA4
 t+Ma1bwBH+fJsyjithZr9557tgtwudxTojrRHkXs8G5aZIK3LQ1eH2yj8avH5CIwRpx9Y02hmjm
 zvbtOsIe
X-Proofpoint-ORIG-GUID: bTxAjlEEz6kFEfVpAnnYxQFUE7nNW3xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

From: Monish Chunara <quic_mchunara@quicinc.com>

Introduce the SDHC v5 controller node for the Lemans platform.
This controller supports either eMMC or SD-card, but only one
can be active at a time. SD-card is the preferred configuration
on Lemans targets, so describe this controller.

Define the SDC interface pins including clk, cmd, and data lines
to enable proper communication with the SDHC controller.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index f5ec60086d60..05d5da382bca 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3834,6 +3834,58 @@ apss_tpdm2_out: endpoint {
 			};
 		};
 
+		sdhc: mmc@87c4000 {
+			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x087c4000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface",
+				      "core";
+
+			interconnects = <&aggre1_noc MASTER_SDC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_SDC1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
+
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			operating-points-v2 = <&sdhc_opp_table>;
+			power-domains = <&rpmhpd SA8775P_CX>;
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+
+			sdhc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1800000 400000>;
+					opp-avg-kBps = <100000 0>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <5400000 1600000>;
+					opp-avg-kBps = <390000 0>;
+				};
+			};
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -5643,6 +5695,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
 					function = "qup3_se0";
 				};
 			};
+
+			sdc_default: sdc-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc_sleep: sdc-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		sram: sram@146d8000 {

-- 
2.51.0


