Return-Path: <linux-kernel+bounces-759945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8AB1E4C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C072F162691
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA1B270EC5;
	Fri,  8 Aug 2025 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePhFp+3J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D726D4FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642983; cv=none; b=lGfXGizXwXW7mWLIYwek9KEsPBSfkQ9lCJBSMNb7ZC4FiPzEA4glyfjflDkJ0x0I782GgPe2LPkWikMQRCVmej8YmWVbvGzwukqACToB6Kx9nI8IwPeTsYAwOXxXJ3/4gH0GYCkuM/H2SL5okX5NyKiqUL1VHiaGwt4orQ0xatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642983; c=relaxed/simple;
	bh=23E2L3+GM5Ne5G69gtx+iV/0DudIvZsRZTXNlVujEsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sx4pyuYWEFp/Hz2T42Z87tzmrWTBbXDv5RelAYYQbxFEbFFOGpUFFXKTlpcpfQP7+w5fP//uWuDGjchbUEqMQVWH9DBOI1+Z/NL3UIqd45ze6vrGy7ZpKHTOKtDROtGt7qQElRw6j9nA15LziTNBwGXlZsBL5nUWqLvAk5Uv2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePhFp+3J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57877MTw011685
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WFXsE/Pq/OO
	0HhZLOEUiCFKFRSimd89W5kjcE0yBaHY=; b=ePhFp+3J2AxulnJ0tRa7EH8+nlp
	o6OyCZuHRYAWinKlnqgWs4l9TJQWCpVPoW8tqcLhbELiVJ3Ydmx5CVNOa4CvpD8G
	E/e/IcMy9Bmle2GDTppOh2CzNzdaowot41jM5sw2/TYrjjd1117Q/AqQ2ZFOnAGJ
	KuL9rgQhSj6u6S9EIg9O+Mn5z6CFqhUo796IkKNHDCdoGDO/g8jlO4dI03m55sGt
	HlzVyGdli3lJzOpgPSM8DDnObDLkJDxyDzetyOKuYp1BsAEbV0md4d1p5KCMCoiV
	1Ao/GyS4Kt/45NTFBC2c8e2GzPNZGfu08Cs9mVXDEgSdrAFez1HryuapVhw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cpvy44h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:49:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b061ad3cc0so56062971cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642979; x=1755247779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFXsE/Pq/OO0HhZLOEUiCFKFRSimd89W5kjcE0yBaHY=;
        b=BAkxWd+GE3/cEvsvL5OeH8IQLIC+Qr2c9balYg1l8mGilOJQKsXnvVpZUWpXyWIDFX
         9ufpKKJrP5FEE6cWz1tVsNlwf/pVtC6p5thEAutB2sMwFhgfrWmYp98GSCWUXfegAbCj
         jnCnaiMcBTh4+0ZNBy7ZGxAV6Dg21gzwnsHKYuA4H+0AvhS4fzB6Mm1c9st6TISZSTBu
         VXLcQ20L16ooppEM2a6AKtwWjsI6myUULYC9DAs6SMjg4SofQ7E7I39VzJKO/Ymxk5Pu
         11f3x39P/ssUM+NNNV0nrimPIUWWBkdoobsb2vQOAqPwjZ/7KZ2/3goyS3oWaQ0NASf0
         wpJg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zv1vpZpz/cM1CtV62WbkTndAizZ0qRqzz1oPSLtdUmgtv/24HBM8gYfAzFJ7gUelJuOfCB/uu4IQ7y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNMnATXdPDf95PMwQ/T9K44tn0Zvw1z281OVF5rsGDtPVSElb
	S87BGnIIa3vd0O1nG8twsSf8Umt8s0UKQunId6GVbWN1j+HML+NhyBU9rvgyilbu7TFFsrwYJUT
	AlkqlVqrqJ9i8dYNurzJtrKBeHa+IrxscXCG6X2mctGfvbKhyTM6M6TXC8qWR3IVKQ2c=
X-Gm-Gg: ASbGnctf6n+J/vzm6x2BLjYMXMiziuy8ioz/YiHTkZ3CJcGMuQe5JF3XzGuP4uY9g5I
	CeKUOCsECAbQMTZ4bwPe5gw+qmjA7Jw/OYoalpBQgFlQk81TuknKcEGN2qiwXhIFUqS+O9s2Lit
	K/gHcgS3ek6n2NMryXJ0NTAX83hi7w2z4RMgSBi0OLTIFMhxO6aoIroh4RpALtOdZ0pW8pRjWnT
	dOibqNnbvwgWqB+DjED1cdq1+/PoUZqf6XzzhPtZ0GUzXWWi1fNhjJZFDpwqYiDqXTTXeu1dqfs
	+u99GqjFwxxEJ4P5OyU24WPXQURTwoRr7ALuXuw+mntBEl9eNl24h3L7bYTqP3XMNhzFAeCI4QG
	sWjZyJNnb/CxG
X-Received: by 2002:a05:622a:1a93:b0:4b0:8e1c:d87d with SMTP id d75a77b69052e-4b0aec59704mr30866001cf.2.1754642978964;
        Fri, 08 Aug 2025 01:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPMIXHPPD1tdceQhbz+B4qpGQUoHEbS4Q68Djht2hs0DqD2kW+fYFCxOmTWJ4VNIBaNufslA==
X-Received: by 2002:a05:622a:1a93:b0:4b0:8e1c:d87d with SMTP id d75a77b69052e-4b0aec59704mr30865781cf.2.1754642978561;
        Fri, 08 Aug 2025 01:49:38 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm122904295e9.2.2025.08.08.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:49:38 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/8] arm64: dts: qcom: qcm2290: Add Venus video node
Date: Fri,  8 Aug 2025 10:49:22 +0200
Message-Id: <20250808084923.1402617-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808084923.1402617-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJpFS0la c=1 sm=1 tr=0 ts=6895ba24 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KD12_Wl4P5iJQNenjFgA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N7Y8iIm51Im5YN3p6EjWVSS6nuT0K6tR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NiBTYWx0ZWRfX4YV/k5txwSS8
 TfeRTj4xY6K4fMiBabAi83k9DPfgMjMlvg70MmGnS5k6QFq/yQy5Yhd41Sa0MhP1HsJsIJnqeiW
 mJ+F9VMq7swY9vRuEWrXHTTBGdWDxDi8ONMeerQluZkGknBBXebUAySNwJ82JP6A3uCmgR9SqYt
 xOH6fTgIZT/sl6+hNiX3i9OuIr2EXje7YVMNF+lrRwhvX7fUCLpV9lmBY0rwVL2h5U5YjSnTGrt
 ldv4e0cv3MBrbZcxXBpWw3kwW3tzuW/t9SYm2+O1YWljqyxMMk9C2OuVjyNQdfxQYI2+miG/vcN
 kXVjqtb8UwHBqjRBomuh7OnjswsW5ZL3wJYYA178dngwTCe8ROFKqO/hRIENnPCamFesAPNlDIg
 t4Jrt677
X-Proofpoint-ORIG-GUID: N7Y8iIm51Im5YN3p6EjWVSS6nuT0K6tR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070046

Add DT entries for the qcm2290 Venus encoder/decoder.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 55 +++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index f49ac1c1f8a3..7cfacd189a10 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1628,6 +1628,61 @@ adreno_smmu: iommu@59a0000 {
 			#iommu-cells = <2>;
 		};
 
+		venus: video-codec@5a00000 {
+			compatible = "qcom,qcm2290-venus";
+			reg = <0 0x5a00000 0 0xf0000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&gcc GCC_VENUS_GDSC>,
+					<&gcc GCC_VCODEC0_GDSC>,
+					<&rpmpd QCM2290_VDDCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "cx";
+			operating-points-v2 = <&venus_opp_table>;
+
+			clocks = <&gcc GCC_VIDEO_VENUS_CTL_CLK>,
+				 <&gcc GCC_VIDEO_AHB_CLK>,
+				 <&gcc GCC_VENUS_CTL_AXI_CLK>,
+				 <&gcc GCC_VIDEO_THROTTLE_CORE_CLK>,
+				 <&gcc GCC_VIDEO_VCODEC0_SYS_CLK>,
+				 <&gcc GCC_VCODEC0_AXI_CLK>;
+			clock-names = "core",
+				      "iface",
+				      "bus",
+				      "throttle",
+				      "vcodec0_core",
+				      "vcodec0_bus";
+
+			memory-region = <&pil_video_mem>;
+			iommus = <&apps_smmu 0x860 0x0>,
+				 <&apps_smmu 0x880 0x0>,
+				 <&apps_smmu 0x861 0x04>,
+				 <&apps_smmu 0x863 0x0>,
+				 <&apps_smmu 0x804 0xe0>;
+
+			interconnects = <&mmnrt_virt MASTER_VIDEO_P0 RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+					<&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &config_noc SLAVE_VENUS_CFG RPM_ACTIVE_TAG>;
+			interconnect-names = "video-mem",
+					     "cpu-cfg";
+
+			venus_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-133333333 {
+					opp-hz = /bits/ 64 <133333333>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+			};
+		};
+
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,qcm2290-mdss";
 			reg = <0x0 0x05e00000 0x0 0x1000>;
-- 
2.34.1


