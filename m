Return-Path: <linux-kernel+bounces-722162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3AAFD612
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DA0585D94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B612E9EA2;
	Tue,  8 Jul 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUnf7h8+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB72E8DF1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997949; cv=none; b=ixwjS2qTWZ2vF2tIxfgI9mL51KRGX1gckwUoYH4vI5VbgBr5zWB3/C9/s8X417ZL6iQBRa1I+yo6wVchW/GeJDoPW53tFmep+io5FxDviK2iRX/rvDDc/vu0b+XW4eMjY1vEtWcGV/+PvtaAlok+QlcWsyW+u2G9VhEQ9tsLmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997949; c=relaxed/simple;
	bh=tI4EJY+AX+r+95HyElw6Y87H6Z+WIIFID7OrbHLVJ9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqiriowLRjXvGt8LoLfcHjtfHP0v3ykgMwWWJ+iVd4l7REug7d/7y/hFeL+uxmWdNIPG87vicPna0J9mR8f2fHXSBOjfLJMNZZaORnfRUxeA+U7YxnkSJa4RpkDtuM1xpmxFmLk0+eX3wjgQ9cfN62q7eP+KHgYwbZ3jWjI8w3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BUnf7h8+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAO3m001166
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 18:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cDNJIT1X4FF
	Dqpcezls1gtG8Nez0pdy1Boer2Zl4v9A=; b=BUnf7h8+6hrNC84fDdN0IO1GkwR
	PeXIA+vSQXhOmnsfjzqfOwDfWIGeYSg7S4ifBLd/tuKTn20Lial6OwOGX6jrcDIe
	svEog8j/AHeZN3FHIAoxQ+kBTlqPtowYpW9+3YAc9zuhm5gPnkCe5fZAe6nXnGBm
	MMud135PvcPMmCoSFlwjxJSQibGMwCVAlb6W7MVF4nen5aRlCy43RQ+XkA6Wkh5a
	2jVCm/vq0hMqY1ZzzIhGyjyjj2NjUIwPFK1bvv7mtLFvf4MGNuUNh6C4VHgFm66a
	0No5At4suLzPksLo8IqBhbFEtqmU33646pGn3DiV8awJ7FlgeAroKWC34Xg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdr1abx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:05:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a58813b591so3007861cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997946; x=1752602746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDNJIT1X4FFDqpcezls1gtG8Nez0pdy1Boer2Zl4v9A=;
        b=ZIFmAbe922CEPBJSOEHiBL9J/u/NMjXZLBCzHQaH+IejD8BPAQjGpOQZkAskiX+a77
         FdOdOY27trnNOoboY7LpoEUCMwis+bowb9aG/wppoH0lZ1uMzI4e19hD/xn6TM/cNYVb
         c8XmUciLLLxZqGyfx4h9Uh3lSnJHC9joYaO0KYo8agAu+wNHWX5+DlnV59xFMWhoQRLE
         cNf59PNRg2EfZIh+ZEsB+6XFiFcdtzFTiB/k4eIxiwMSQD1p+sQWuP2CcroHpqLklLKL
         rgXpL2KogCyigfI9q+9EZiglZaZp0E7wv7Lh7SXtwefWRy9ttBgm4ND4vRQoyYEZcKD6
         KP9g==
X-Forwarded-Encrypted: i=1; AJvYcCVE+UeT2tZoybDK9G3mwEiG4gsgDZCyBfacKzIvYsmqb+qywYZNK449YdC3uBWpPqsPeRbhrsdaWLQiBwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1BE+8c8cqmeH8y6EBcNMJ7Jn5JHosN5yRQpLd/BjDha89+Rm
	rLwwiDz/ubH9rmby+01lsB1TOkcFDLoalJofnvX5c6VC3S/hejemmsaKsjuTgBqgCQuCt/a5ftv
	Y3mP8/rTpX+8w2m6Mp4eFnq2yLNEEPULgxVjvToxAaSdKBWB4ozxYk1+X1MYB7bWdQTs=
X-Gm-Gg: ASbGnctrCM6yAc7gdLGRK2EGXXfsWoD75AYv4rp4xpgc0v22uRRZ/PZM4mTTB8ynUOp
	X5EC42zsB4rIeI1INqp86GewkIGG1KQb8IE8rNrBndrJoaOEff1anCmi/WKmLXuP79SOwlqXkly
	wQqrKYiQoRybAAlCjR5Zy+x1F2g+r6VL6cGLAZCDU/g00CGyIdTEOvb60qYBeu8/JmBDlLp1Wek
	s3hkaBiRYfJW1KsfYpGpEX2oSD9H0k9lTJvVLQSCwkq0sDRvzshgG6Y96bZC1xGIEMQLPTYDuBW
	aqkJ7PiqRyBub64m/hA4Z7jW4sXc7hEoAvAwymeHSs+mbDI8aa9vSGYhSiadJRMujNKRp9WgOA=
	=
X-Received: by 2002:a05:622a:98f:b0:4a9:8232:cb35 with SMTP id d75a77b69052e-4a9ce5bb4c0mr58062621cf.15.1751997945737;
        Tue, 08 Jul 2025 11:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyZT+HkJfTBrHl4+ei128F1dpD9omDu73cUZfR3tgtwSTp3pRdVUTSJ1irJwghrB5U2HsgJw==
X-Received: by 2002:a05:622a:98f:b0:4a9:8232:cb35 with SMTP id d75a77b69052e-4a9ce5bb4c0mr58061991cf.15.1751997945129;
        Tue, 08 Jul 2025 11:05:45 -0700 (PDT)
Received: from trex.. (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0a5csm13394906f8f.29.2025.07.08.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:44 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] arm64: dts: qcom: qcm2290: Add Venus video node
Date: Tue,  8 Jul 2025 20:05:29 +0200
Message-Id: <20250708180530.1384330-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686d5dfa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KD12_Wl4P5iJQNenjFgA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: IuBOwDsKUSMIGLgB7OcfOZDYqruJESpE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MSBTYWx0ZWRfX33JLy5sHJSxb
 nxtBVH806fE2SmxmidtdpyKJm7JrN55YH56QYfN8tS0kNfjTPBZmIF56rbmPzjDlJ969o5NLYnF
 y4DpW1EGGK3c1VaWFnQKojOIcYt/PbhKfyL7otGcgfKR6tbu1tXgULe94RcwbDVMkYepfLUWyTK
 9jgoJNA99Tm4H/rKam0uveXtFZafbkc+UVs4oIwxeGg7YdPQUGFuBE+MEfInGtikk+3AerIUJQ7
 vujCVTdLCMgijapSLInlh9IrjJRS2n8GmSsWB3XiQDHxPmDaAaus/IoRM1CFnHNWXzHOLVl6YQs
 axArrLd0B3VzG1zts1U7uwWN1CO6jAC6e+RLQ6ZDO5U4DzbF+pri0F4deNNzc2LBOaI7pq+pP/6
 LtSaGp9PdOz6ixzWaVqmhuT4kdGkOn6d0EEkfX1k9EvHBXxYLdUKG0L8CQBtBksicqmelrjf
X-Proofpoint-GUID: IuBOwDsKUSMIGLgB7OcfOZDYqruJESpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080151

Add DT entries for the qcm2290 Venus encoder/decoder.

Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


