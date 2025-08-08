Return-Path: <linux-kernel+bounces-759963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167D2B1E4FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED389A00106
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823912701C8;
	Fri,  8 Aug 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="adC18uwO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65E27380E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643201; cv=none; b=Zz3t/F3T4ocGB6USiQLtj7Umyt11FoUsyQJZWVSMfPiruKGKayR53PoImyuILHEKplus+5NSq4XSWND/K3mgiyHuI5DDmgJVuSf/lg0kxwz3uFM4X9Co2pIVPqelWuVqhcLu50NhMdAsE2prYYr9yRLzUOnFr4iVGFNnpSRu9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643201; c=relaxed/simple;
	bh=23E2L3+GM5Ne5G69gtx+iV/0DudIvZsRZTXNlVujEsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlUSQCeuO6iCIV1WMMk2ODGSprDpETjpgwskOBgpvFsbQQa3mva2GodJnpfomgbuDMoGWFKGadHK0scgq05v3epYe2onSlkd2mF5X6C4mQjEKgieyQx1x+ucQM7L0d9eOk9Vp2PTjx9AZiGyJ6nFdW7Csi75a2+RCNxkFEcdOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=adC18uwO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786tXqc018417
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WFXsE/Pq/OO
	0HhZLOEUiCFKFRSimd89W5kjcE0yBaHY=; b=adC18uwOjEKNRUPUah1X0XrBKjr
	NMGk48BH8w2E4P6CBLMFbfId64DCep6gma0n4suB7o8x5MFqKgvBJ7tprkP2OIc1
	9Dq+wrua2YBu3InDSjLx3SfeUuWf2n/MSIjzhvy5j02+0ufQkWXxSBFveb9uQDSa
	GfpagbISfmqGsHCKWXOIse2AkiDNm/9c+e9/9nwnql6FE7em9yQMbzcAEO7/zn35
	VA+tkoDSPQejKSvRSY7Zc56YtWUFvNbJK6Dua30py05449Ug/ErrBwQ+KVgtom6z
	4M30jB0Mx+U4ZlFk1Vh5FkJGe3tlh+ZLglc4jyfryzwR2r5C2EQqKy8X7Uw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c586eyby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f78ff9beso60082511cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643196; x=1755247996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFXsE/Pq/OO0HhZLOEUiCFKFRSimd89W5kjcE0yBaHY=;
        b=DQJHBexBL49WUefCm25rtZkgEsiyWtdGM8zpONYCPmX9E51E74RQQMlZxgfr8ea64/
         INfhidbnvnspk1GmDrW0LNhK3MYHmrmexm+rv1XYIIz8iYBY7OvVlhYxRQBA3vmngoXA
         WjGMsnzHVwXNKVeLpUgcVRC9SsCVS5FginyFaJ3UWMO6K4OUFlKlx/6FUQMNgNT+3yKG
         WvAHdtLvSRfiRCoBHMnO/gD2k95YiD64r866T1lm559IzyHGuVZTKu282MamUYCuCa5o
         yRJJQgMynfBk/qvCyOFBSF7FPUNS7n358J+Xxp2Y1AUTMjrvYz2gLq36C7BAgvfcKHXo
         4eFg==
X-Forwarded-Encrypted: i=1; AJvYcCV4gnaKHE0+eoW6o0udbIdu5SzyqnozRIb9RI+8n/5ZlNMTaagtQGBJz6lQXR3V6rGnPcoX8abG2Cvx2SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sh5/yevumhHNa0HaUP+sCtWM/Obo70JUz8O1fd4DgSaWBYbC
	VE0IGylJMVBp+dOKrOel0RiwI+DFnnZiOwK3Fjfk5lFy1ISP6P8jGxsXT32/w5ns5AidJkq/r1e
	1RZwojGeo/3b6Uw/jEXOglv92OY/GKlOxWgX4CPCSc6VRipCKH2Lj8GfPJgjxLNYwUnU=
X-Gm-Gg: ASbGncuQPZunp5xDPnyx0f3Hlix+H4qf41GN161ocDQEgvybBNRQIfbbjaD+IGGrHL9
	fqJ9sIE3ASzwljZddN6UDwAZFi1oO4gtQ+BAvF4pS08WrTK7lptthP0Qy1sZ6pw00ncH5PoRA01
	+5a2Xr/OCw74s3Bhd3q1vHJ8vxuggjXaj6tIzDdh2EcKDWUFl0k7DY2Qso+QBVUBqvOJxXw7xzf
	jA66vAXjZrfErT9ZxjtMHq4qgHBY4jCGrTYiguCsdthijuJk1ezBbE0+FJFopmDdNH/KJzyTpZ+
	8Po9jZV/hq93NQnR6XBmRBE69SMRaKXYVh59cldy7IxYZMrNB3HGPAEABdWJk6kIS8Urdw+39TL
	KAEWFyR8dhYL6
X-Received: by 2002:ac8:5701:0:b0:4b0:658e:bd88 with SMTP id d75a77b69052e-4b0aec6135cmr42498051cf.7.1754643195884;
        Fri, 08 Aug 2025 01:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIyBTkjW23ZduxStuoNxrstWFgHDzUxrr3Q04wuEvn2ojWkOcLrw597Hn/gTfb6Ox2Lqtjpw==
X-Received: by 2002:ac8:5701:0:b0:4b0:658e:bd88 with SMTP id d75a77b69052e-4b0aec6135cmr42497361cf.7.1754643195415;
        Fri, 08 Aug 2025 01:53:15 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:14 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 7/8] arm64: dts: qcom: qcm2290: Add Venus video node
Date: Fri,  8 Aug 2025 10:52:59 +0200
Message-Id: <20250808085300.1403570-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZnypGVL31bPTlRLWe1pj44bDKkK8Lsb0
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=6895bafc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KD12_Wl4P5iJQNenjFgA:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZnypGVL31bPTlRLWe1pj44bDKkK8Lsb0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX1n0H7iNAXaRW
 aWMirYv8abm9gJFPRO+LdCtfgjKwI86bN1zfhgYNzmRRx9pRmtq3mkUUG1PEMkRENkxll8cU+OJ
 N2/xoPCpjCHkiw95m53quDj3EvxiYvtg9c689LPfeUSVEZUtQ4fLc+KXZxdaddNdW1fdP+Dn6OK
 VEclWqNDaAUbc/fgLwCiBDVK+q260BNk8K5Ft6QUEoI8JODkPMay+eyotbSNQgsIU352Dwtkmbe
 qpdbQZZbn0+6fw+W1JFIBYbAQY+Wg2CVza/Wmui3j9z7tZtGiX/tZYZviyM2W+D5AkQUnivIwwx
 OqxiZYyB+gLusd8KLyMgh8VvbJ8eZ03DuNh8R9vWe4mqh4YQIrlnxvM1ELGY9C1j5n6su+GMfX2
 6myWvLqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

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


