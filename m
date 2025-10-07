Return-Path: <linux-kernel+bounces-843772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF32BC036C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AE63ACE15
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412522156C;
	Tue,  7 Oct 2025 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bq9XKxKW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1A21ADCB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815922; cv=none; b=k0z1I/HiEIwbtNkbB5lXhQnl9SvCZhp4bqACcUVIQNeqZEd2+q4L1r94PGniM0COTHHu+a8BrtP8y4phQu0mIE0neVfr/FZWdRtdi/JMnBWBJpyHRUg6c0Fcd5zlsU5Fjf6nyS8imOSYxSAOCbRAm9LdBmrJJsF2KdIW1DfZjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815922; c=relaxed/simple;
	bh=bQ7elM7f5BL1Lifxhw5fuJsFELFQKaeSC0XXu2tQuYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxPjam+xosyH0FgBepBh1YkcsCGAYYIrh7zufLpIyYBeNqVpT5dEncZgolx44Txdc5waTk3FsDvbix5P14ZUdHXqR2nndCtPr0RAqd0Ub/1M1ZhAVPsH6apCcpAiM+nfe1MumNd2VuafXSzAhczEynKRWciXAWr/VYb3YIZzWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bq9XKxKW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973m7RC004958
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 05:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MMhRpxaDY07
	1Od8E3CVtmEeDDOJ5yH67ZSz1WszGtF4=; b=bq9XKxKWCjKSbKImhp5r9pbnR9j
	FLH0kQuZM2L9CUPFYs4AfauoP6Tj55Q4hiDuIXg0BTJTQ5tz3H+bnNieYFWFBt9L
	sk1f1m0VdgQrT/soBFautmrmv4ldTICXbzPOdRq67+Q8bhBewWPhPhu9dHNTxQJG
	yN9v8+H8ZQtJDDLCuF+bIcDX+IxRzN7lkgy8OxArapUAUCgSTKIlFs6ieZKxtTHF
	O9WcNkRSXBpCBIrHSWa0kXAvIRy4JOzzcoZ7itaRNePVCowADvEcTn0Te/rUo9FZ
	kSRF7yJeXSEHft3D6RrGKM0fT6UTGq7DoVm5WEdaDbxZuytduUJUbDEOHfQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhnxru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:45:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-339ee6fe72cso140189a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815914; x=1760420714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMhRpxaDY071Od8E3CVtmEeDDOJ5yH67ZSz1WszGtF4=;
        b=JvvPNwar5TH6Az3TONdR3HgTEKm8VudbQHH4kUWmg/UomL/HmUyMqEFr5pXiydNWTO
         EYS3XTAtWglrsWo2NbtOQ5usZU5APFpAEzk1VfIsUiCTKG3I50vbnQk/vnR33lQugt4J
         U+YjIqmoyzWf5F6j5fRZSHm3kd0021jrJvv8tXuxN8WzhGqGuK0HRbDcN/1j66jfMCmz
         U0bajU6RRkTRbMujBUlnAaReqvHcsVQqDlQbs550rGsdL0yyqNuEo0RkPjEbON6l2AjP
         b/fKsaAfd3B/papr/yLyEJsZbFNucKPXAmqc+W4ENfHVdyP5AlD9ZU0qX/fK3EeKn+8n
         URsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWvM4Zu99saDOirhLHucD/4uZhGZ3QfvyKJ+xXbwuNYVhMYSiPaGYG4qe6Il226jPWjOez1RvlY1DL9eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YsLyXwq2o0krSKHyHIbCAQqvVW4bB/Kh9ugTjYBsOi4nl8ee
	zs5SSCA3s8EqNKE/V7vKEOXBudSr6SurVf6fTUktOD1rFJUaCB5ElhESTrtU2XIIEa0C6BpptUW
	kYG+GmXFnB5QRsWFl95aSxZ9NQuNt18pE932T5Jhhpls0NFgEQDqujklqTuoSBQ0ZXo5MpBQpvw
	==
X-Gm-Gg: ASbGnct4XrextkPoxCcZNC0QoW789kc7VZNyWY92q9q4o9+dOSqHVvZ7I+Jxfvwale5
	hdH3qckYP7cQ74LQoJqjWDrprwdpjGTQezXgNNxo3QucjaghefBCLPHpWNC9btAWi9bcL10OeWd
	zFU1eEPAcV7LHctF7SPFMQ4NNqF6o0TjQHcZO5Cf4n2oxF+R1/ZfJ/w1G4b4pkmZwz44CdAf1vB
	+8z92EGO2x0ls6UFMc5zIn1BIXhb35iV4wUpSEz/z5XPueHPB45/QnQ4LAaHdStkOALllV8w4S4
	SvD0EJR2kHB0Z4Po6bnzoureS7+txDf9vbTo17yUzBNkpBFgjddfdypU0SfmlmrgNa584WD8t2m
	W
X-Received: by 2002:a17:90b:3b8d:b0:339:efa3:e099 with SMTP id 98e67ed59e1d1-339efa3e3dcmr842447a91.6.1759815913987;
        Mon, 06 Oct 2025 22:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI88usWGiFCUosEbxk8+Vn9Li4jjEysOSm/+1UFh9yCY+hNAK+X5JXiib5yPF7jP3Awp20Qg==
X-Received: by 2002:a17:90b:3b8d:b0:339:efa3:e099 with SMTP id 98e67ed59e1d1-339efa3e3dcmr842415a91.6.1759815913464;
        Mon, 06 Oct 2025 22:45:13 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:45:12 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
Date: Tue,  7 Oct 2025 11:14:44 +0530
Message-Id: <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX3giFQUWQvdGI
 FWY9ep/fEBxbXOiPswpvgU/Q969UIhplR6/meqC1rVMrdA3oT2OQDNo2Y4By0RMGuodlkmCHedG
 yyyEey20Z0Oc1G7PDPX735JXom8rkQmkxU91yiW9n9qY/DsbwNPv4i2qVr7h+jChwCJODzyGKcC
 3vWB0AV6rINE/qTeviRZ+dTdpgnADX0iUzuQa5f7OU90sFaatpdMglmf0R/BuOmIkONYVdCMXvL
 Kzl+ZrKogz5sPEaChm9gYvx+EAHn7DJsePJj2I0eve0tbR73SJGTiezXV0npj8axlj/CoCHScJ4
 /Cf8aDbUqnUGkkmwGnbDEF/V64cxZ8o63SWzuhnUUhJlERqgTdtckyTXf4vKBG0UdxLDxcaSR5y
 X9311sq4PiEJOh32o9las1YqhM3kjg==
X-Proofpoint-GUID: mZUIw1LAhN8wdLLLz4OKWZr7z3o0u1gH
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e4a8eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=AsSGxY1rZHGoL8xKvT8A:9
 a=SDuTNzKu6uzCYS2L:21 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: mZUIw1LAhN8wdLLLz4OKWZr7z3o0u1gH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

Add SD Card host controller for sm8750 soc.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index a82d9867c7cb..dce70443f719 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2060,6 +2060,55 @@ ice: crypto@1d88000 {
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				<&gcc GCC_SDCC2_APPS_CLK>,
+				<&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
+			power-domains = <&rpmhpd RPMHPD_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			qcom,dll-config = <0x0007442c>;
+			qcom,ddr-config = <0x80040868>;
+
+			iommus = <&apps_smmu 0x540 0x0>;
+			dma-coherent;
+
+			bus-width = <4>;
+			max-sd-hs-hz = <37500000>;
+
+			resets = <&gcc GCC_SDCC2_BCR>;
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
+		};
+
 		cryptobam: dma-controller@1dc4000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			reg = <0x0 0x01dc4000 0x0 0x28000>;
@@ -3121,6 +3170,13 @@ data-pins {
 					drive-strength = <2>;
 					bias-pull-up;
 				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
 			};
 
 			sdc2_default: sdc2-default-state {
@@ -3141,6 +3197,13 @@ data-pins {
 					drive-strength = <10>;
 					bias-pull-up;
 				};
+
+				card-detect-pins {
+					pins = "gpio55";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
 			};
 		};
 
-- 
2.34.1


