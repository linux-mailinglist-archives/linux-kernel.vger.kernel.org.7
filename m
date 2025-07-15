Return-Path: <linux-kernel+bounces-732518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE93B06804
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67784E74B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6352D4B47;
	Tue, 15 Jul 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGCFEoEX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AE2C15A9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612491; cv=none; b=J2coH9W+z2CazoicnOE0G83IkVWRpjeSjtDtSY0kOH/V2fFugLiYFOGZXJGaLwvEzq+WkHLQDDuR4/NH/TIxA5AORPUBY+eVIxmtfCTQjJ3zRsiVd4gtjtJAYDUgt6NlUg1HNGcIDjpNVwSySrNdvXaaOShP+PdTNhmkch1KrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612491; c=relaxed/simple;
	bh=tI4EJY+AX+r+95HyElw6Y87H6Z+WIIFID7OrbHLVJ9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2WkWCvbSrKDT/0+A5soB6jOnfLc3tgwOv8/Sc18bxOLQMgLpUHzNtBZXzYHe9YyuI5Mm7nbyttRoqGhIJuPO15pceCQb+6pNvl5US8EkA0Q0d5GrXIeAUXKRo5HfrXATxAWMnZeudTcZWYjuPPppqoF0PsfhycDXGO9DLqddug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGCFEoEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDLPe024983
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cDNJIT1X4FF
	Dqpcezls1gtG8Nez0pdy1Boer2Zl4v9A=; b=IGCFEoEX1vwkNIi2yy0zlJ7Fz5h
	l7dIhVb1c9VmrXrQdIF7h7Myi3T5Ri4DKi6ADTuweG2/6STM3cJlhL89n5u8ZFb/
	chpfpGo3VDZO9ufFSahvQ+sZ1IE/HzWBkt4Cy8t1eTIYonVkq7F5Ry66SBjfyJ0I
	6ZKgnfcmvSk8lmnZpVY3uCJyAOW9ZS1jF5lt9JDmGuoE+tsHEJGZsshGUtCXk5ob
	i1suKOBCnZY5LUvPcUmYaeMslEbQsKrVtm/IvQOUmn4i+sKAz5s6N72Ak04oUCVL
	5WcTWFVOpcD9s9rOqzudoPX1NHiY1bLUItmdlN97b6UvOfM/BSd7kQJ7OvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ymdyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e03ac1bf79so329024285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612487; x=1753217287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDNJIT1X4FFDqpcezls1gtG8Nez0pdy1Boer2Zl4v9A=;
        b=JuVkA2tE8hYZU2t+IgpCZF4bABKNNH0sm9i7lKy5DqFjhOuawaqdXoov3453lgWRHT
         An0KY5IllkumV6FpAi/EzCr8ueyNFiGIWGF8dvrjfJEpXYpP09hIf7niThouo1Wh/zHt
         +5pnf7YzcIOxESvOwv2z5jjEdZJc9CYYZagJavJW9qfasnfyNzj2mITrjGrjCBpJqkyb
         FZLdH9eFc79cczqCImjgDokjOrxzSlb9iIhGlrZeT1v+MTkgQphQf4Rr5RcApPAinGQy
         Ml/RdX4sr+YLHqrpDklMByWYDnTVy/cd65bEC90XqDU9NJgkOKP/vh0DREyVHGdImjkX
         abYw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5z3SauTCuXy3FfVk+6rnzm/4ex6XQRTn7TDhqiGEWbtPL5pDpljk+L5EMNhlgFFaiqFBrp1L2DjGT8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJKNxkGa70TClrKueDDsNY78/odALGj5vJDcP5+lhm8kiAgcgB
	g+jPVeMAtNVMovjQuGCb49Nhl970goYz71c32CsEAJLC9eFmJOWr5oSkvzj3bw0zLjA6GwYz9c6
	/mefkI7VAEsSznslYQZH+NN6T2wv54GiDHar/WgRFdzjInTIzadVo5HEyoWsaIZSnCXE=
X-Gm-Gg: ASbGnctGvEgBvTagc6vPxhCI/5qhe2I5HnZIuVZgt0pskLtN9l9bPgh/cWlPd9JK6og
	Q2f38HwOfm/K9HRPP4+Kvvd7aaMZEL/Sv81b6KSvXA4ETTTRSLKXa3tE5Fa4F80RvIDUhe9Eoh0
	UhvrSPTBEVCprGAX6haXLyne0wnInsXhb6rJMtYGPlYzK3ZobVvnDPTXzwYzzh0bVOroOecmTfy
	/DeWe159boanjgpFgGM/FN5TvVcoVWzhpkHm0v3R7RLLhjz9LNfJmrssjVE5mNW323kE6BSunsg
	VH2sKVb/cN7nrnTjrHqliVQh9YmH0zbRFDPWWkX/v38uBqvW4Tt1S5XySM+QKtoJ/hZqfv8CP3n
	IwcMtzfjbut+OTlkEYw==
X-Received: by 2002:a05:620a:1794:b0:7e3:320b:437 with SMTP id af79cd13be357-7e343351613mr46872785a.1.1752612486924;
        Tue, 15 Jul 2025 13:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaeqOjGAPeWkJ+TUoENrlyBUvMJ4sXuXZS39RAbxA2XpPfqiQ58OtzuOP9EGEQ7JHQRLcPCw==
X-Received: by 2002:a05:620a:1794:b0:7e3:320b:437 with SMTP id af79cd13be357-7e343351613mr46867985a.1.1752612486325;
        Tue, 15 Jul 2025 13:48:06 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:48:05 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/7] arm64: dts: qcom: qcm2290: Add Venus video node
Date: Tue, 15 Jul 2025 22:47:48 +0200
Message-Id: <20250715204749.2189875-7-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX93hHMg3IOHXV
 hkJ3VCa8GMIhO8XpLVEMIhgHKysXi04UvdQ69rOXRMuMS0iNkriCAMxLSLp3d433oi6r5xoi/g/
 lTzx+i5B5ZW6i9vmmoFEBKcSqpEbDH2EivO6T+0x7jUMQyUEMxdrNxeR9U8SM0Y0dvvDcuOuHfT
 +sDKcjquG1EkFovf6qjYBVoSv+pxsL5Pd8NAh0Kqfjbl/IXLlmTQa8u8CEUXSVNZPsb9YjYHIAe
 SMuBZAcSbobvZEiM5lroXDIaUd7dSmJJsZyZV3/XoUScBpO5WDO1rRU440+5bBfEJevw9SsPz3T
 D/xcWaFMyXgtBePOkjxb6+V8J5CF6Ng7+WGn+OEF5vtIgvGC8sM9RyXemtTw5UdewO1VWX6I2nk
 6yJWLHqAH7G9DRhuzkGFhxfJFw8EgQrm3sWQ3WTWaIWoijQZE2GA4/g1fU3aI8tiosaePYF5
X-Proofpoint-GUID: nJ0gGdiDoSiwgrplO0N-sCZvtj_GACkV
X-Proofpoint-ORIG-GUID: nJ0gGdiDoSiwgrplO0N-sCZvtj_GACkV
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876be87 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KD12_Wl4P5iJQNenjFgA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150191

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


