Return-Path: <linux-kernel+bounces-896652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26482C50E48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F394A3BA54F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FC221FAC;
	Wed, 12 Nov 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gh6T6VOI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+bF9K3x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346A299A87
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931575; cv=none; b=Zpc3PQqh6UeYGM4T+cxLBpe3rlJuSSRKe+Y4754pmxhts5E7UFJiOyKPR0nU2ddb9a+gPZlx9VRhxdKWyr99ESeCaK6x4pioorPjyZESAHTVqnw+mzWIsDSg+wzdGJa1QCY2Si3QppuZ0VC88JolJ5qvnYneUWSAPOmxTdzlue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931575; c=relaxed/simple;
	bh=6+jV71wGL1wBtsjG/nZuYIXE5SSOPVZMaiiUrvH3ZE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8SbW0Q0sBoZtkjruKUvjg4othBkRBUxPIIIQKm6JOzryk6AtInaTlqOExeyMYLrVhIz7cAYDk+sk2qjVzf7ayKVDanZska9qqctzNiQa/4rxGsFjybCV8XKHFI0XQyWDDSYeQyZG3Y3RdHUZemgOsdl+W11cHsePot4RWy+s8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gh6T6VOI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+bF9K3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1iCql4076895
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DKnzoLzTMmN
	A97V4zeF5ajfzMEJrp7kRrJtSmJdHD2U=; b=gh6T6VOIJYihAF6UODi0NKwQEFO
	KpYF/3N9tR4AYGQOfQ/1tqB16CZQYUNTqsqB6Z8wzERiqnKCuK0lxCIbsEXME0tR
	tK3StRBivc9mU5JtQKzTfWhEp1DD1H2DsTbLeCFnNrAr4Qyf3DYOrSOieHI1E0aF
	hxPEjCZJ22x+5o1pg+tafBxocZ4sh++0dog5H6eEV7vAK5DY1Y3mnDbyF1DyaJlC
	DIbQEemDo8aXbg3iGU0NIvDLSAVYJyazVwfdb5MeASu9r81n7cACoE0zw4p4PV1l
	e+AShulJQNJcgfpbeHrKZj+MEltyybj+oZBKFL3iKI3QQoJ58Ujfl3tJ9vw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguagsyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aed9ebcd67so164961b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931569; x=1763536369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKnzoLzTMmNA97V4zeF5ajfzMEJrp7kRrJtSmJdHD2U=;
        b=i+bF9K3x2P+2AN0zGSXjh4/p9guRuQfTOGrxodO5F8SpGWqG4yrzjt/vp5c3Rv2Tcn
         TytPYKfxBiXJXMQErGMF5wpy06tFNMXRqFfxMwHT+TlZi6WGoyqGWjFbEOlRvp9KwgqO
         srIB+/b0u7fGuHMTQJS9NOr9EI0JvWcp0CHwthPHuF4yRqAprAyw2XY1i0Pg7ZTETxda
         zp3gilozCVLscmNKYlAxvfOy2ecKctxYfm/1QiBQQK2kR9L/v2s0Xk58Ip68zWa/PkbH
         sY4UvGbaA6TIqScotOFlbzbNTM8fO2p2faTeMCJR1mgzzcX97lo5iJaLLy/yAdG/ReJc
         upnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931569; x=1763536369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKnzoLzTMmNA97V4zeF5ajfzMEJrp7kRrJtSmJdHD2U=;
        b=jjObALmlGHL0zXCM+ak4gNV0tpiuF3YaEJMAyyvSoH2oVjr3cKwXV5fKQ9jHL2rr0f
         4Q4v1MGKOjrTykMsXmlU+E9O5QDPuUsQS/lXwXhklmDqyK3B5Hqn+yz+KdlOzLi57SIv
         XCxSLgTa6qLdUlintIHH12w5yc7Qylv02c7x5M4xB85D6pek5GVEZA1kNCh5E8aJj3zE
         mSAe0nODxXfS6YUgH5aTbAQnqcnDxp490BmkLsgD3mD2Z4ljhXk4kVEU5qDS2ucJegDN
         I2OuwVtq29NHEZK/U1HtC7tmLx/Zor9bHsRQeK1S/Px4H/0v+2cjBFJvUykY65lCE5Oj
         CiKg==
X-Forwarded-Encrypted: i=1; AJvYcCUajzKLUxSH2RowYmoeeKF984XFlcubOzwES8Dilh8IjQz6AcNLgX+aeehIvpl3OBp+gtUjLcipsdkMAQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8z10h7EOXkB2OFPQ6ULFVOgj6jRJyLeE1HFwneHFeOJ+PgPo
	0JDckdR3WXzeLzVB0On8is6+QMG3gQfoGaIT+4NnWS7CPvas5t+Qw+4HPDZr886qJaIKjcl5Mb7
	DL1vwZEDq41xxw+G9T5x3DSWybtYZJxBhKgjgcLy+4PE3EBVEbAchYbra3ogY6sWBzg==
X-Gm-Gg: ASbGncsj+ojqZrmm1nj6cCA2wfdBNU7zTOI8SJg2OmD5qZpykVCE2fI3LAd8EJ1ITf5
	/ED1h3xPBKBLWm25RsRzGDafQYQk7e8uUW+bnZT2nvX1/Ij9CByd9G+8u5+MknKLI42MJ+KNJnx
	Bd3DQkm7RBhfJak3AgPaB4kQDjp/fR0/ekQ5A5B/ceJwKsy87gSdYW+EKXJcw/oyM4dCH/rg9nL
	Z662EnyvEw+w/anHHpoenRsvM9GJCdDk7ltUIWoGIpxXoeUmf/q/7D1X0qhSsjs5pv2xa4pHtKT
	hhD1+mQOIfShiiH5lzQO+52MyLVfBSliibZOpQT96/O+b9WrySV8HP1bRr/80n0q6gAZScUP05C
	XN/46I9vs6myIxoNZiKQIGY3JVtyTQQ==
X-Received: by 2002:a05:6a00:1491:b0:7aa:e4b6:b30b with SMTP id d2e1a72fcca58-7b79fa430demr1292407b3a.0.1762931569169;
        Tue, 11 Nov 2025 23:12:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY+zyejqTbTSe5Xl2V9iUiJ4naYNAjMmnf3X3oAmBKtfAOBL3sWC+noWqs9Fc42Lm9nRtF6g==
X-Received: by 2002:a05:6a00:1491:b0:7aa:e4b6:b30b with SMTP id d2e1a72fcca58-7b79fa430demr1292377b3a.0.1762931568698;
        Tue, 11 Nov 2025 23:12:48 -0800 (PST)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm17949037b3a.8.2025.11.11.23.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:12:48 -0800 (PST)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com,
        Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V5 1/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
Date: Wed, 12 Nov 2025 12:42:32 +0530
Message-Id: <20251112071234.2570251-2-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
References: <20251112071234.2570251-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SrTY9gzTNfGFJvRnF7v66xVSofN7fb3c
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=69143372 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZtXvRwAlPpC7nlbJvkEA:9 a=PufZQI4-Y2q8xG1b:21
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: SrTY9gzTNfGFJvRnF7v66xVSofN7fb3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfXwoj5q/HR7MbA
 y1O58psAFV4b9EnZZ6BCP8fb6Ym4+8B9wDtWWOC+kAI54oTZCUV3oI6gMjuW7orzTn5fk5Vl6a/
 KC1QjEtLZesnNCj4gvG5yCW2HRYQQbqOvhO4wY7pUNjP83B2A9L1ldGIoHWZso5zvanPQGY8lYn
 6nQsafrNF5SQp/qgr+FWeW5ljcIIC7IfHn1OAMkoC3VWvpkp58YU6iyZdpVqTHLiKnQcCJ70S3A
 r4218CKhUtjSwi/HEaxi99h/qyPHSyaP2qdDFbL/Iuw3T9Hdztt1iZhxZ9jOWJJH+CAIju9bFQO
 iGNZ4YIU0wr7/se0C680wbWhxMJ0cgTchXBJ/fqmyI7Ti5emhQhZwVpZAymsIWaTFtxgUIwtoI5
 CttGVfsiqhszQFstwPfIcVAyHknlOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120056

Add SD Card host controller for sm8750 soc.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 54 ++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3f0b57f428bb..ba8c010226e1 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2582,6 +2582,60 @@ data-pins {
 			};
 		};
 
+		sdhc_2: mmc@8804000 {
+			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x08804000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq",
+					  "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
+					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "sdhc-ddr",
+					     "cpu-sdhc";
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
+
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
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_hsphy: phy@88e3000 {
 			compatible = "qcom,sm8750-m31-eusb2-phy";
 			reg = <0x0 0x88e3000 0x0 0x29c>;
-- 
2.34.1


