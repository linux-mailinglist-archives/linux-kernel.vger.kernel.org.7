Return-Path: <linux-kernel+bounces-768315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49B7B25FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44A21C220D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45552E8E1A;
	Thu, 14 Aug 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TVI7W/an"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B32E7F3A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161587; cv=none; b=d1SIl0qo4tfXskXkdyvgivi3eEGPxr5nZYfpEvFtB3KV2r93K0U5O0fO4l2OManpk7tbWcOYw3j4we0ZXUyaEsXgHS7Cjjsn8zUSfTVSCW42PmKW7fwpIy3uzCJ+YYlLgwnPlJDPmchMWagwxz77ctEKLnfr/PvAAwokNA/fHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161587; c=relaxed/simple;
	bh=gZm3ZSySExg5Ma1IWfjbw+2tWtzY5TEG+kq6H35x8Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFLKAAd3o+MBfEdznX+IfDGCDENTiveKb0glXlta9TAkFj/XIzL7MLfnymzlXIsem4UGXd063vqQWiJiO8HjDs48KLYGVh0AtrZbmMFdcc+xRrBPt9J+jJqJs6xZYNH4OSB0cM5NmQN48J6OzZogQPw2Igfq7B1TSnLeuwEMcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TVI7W/an; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMXWqg031953
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AUq6SEVReB4
	B8mcPNqCG0K6dhPWA7iXTcCZXwcqT3AE=; b=TVI7W/anddYTHiaZc08DDZW7iIk
	HF5shSoo2umAKmJ4O11TD5WBGU+TcJbVXnzY47O6hdtD2kr9sOi5TrB2apZwq4mu
	CIPabL+8OIDMqE4S8k03NEIujZU4BYhK+lzztesv3T46el1IPx4Gd71ND2OlmTUC
	OhMKz74pw7VsXm2MdcDeRjT9kOLM/SYyvKjYP/IXez83/73BD9KTCKYPLPf4SfAI
	qSTRpFQ8pOgci6K3/zq8QKntWphck5riok3u0KtbJTTS8CDal8b8et52C9K0Cb1R
	zPI6dhx06zWjf4fv+0b0NcXZdiXlAeo1IvVHauGgH+B8Dge6/nEsFRh+G7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4jyvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:53:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704d540cso77493685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161584; x=1755766384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUq6SEVReB4B8mcPNqCG0K6dhPWA7iXTcCZXwcqT3AE=;
        b=WcabHs9Sisv+f+WoV3wKFgWJ7CiboWAVorugoQOzkjWhkRbOVuf2/xJOpqI3IYn/I/
         9gFRzYRuM9hBeQWmTOFGdll66UOHgp9/3iYh/U+V+k/TpEm69GmEHPfuAXza0Wkm4sD1
         bdeHN8c+6t8ClYBakhaEfyb8dvff5PjlYajMvehApXxs4pcW0NVknlAE65jiCYHPuEDf
         2CDmtANgXG9zsHdiPhOczYaBPbhBEdVGj+tpkvD3IY8xyrmjCZkR1BD6pXCensNQ3Wkg
         Tjw9DQhq2pn1gGhUJ12SchfhFT5Ag9N0hHsnk15kqCHXlgahYpBpTZ607nStWOZ28L0b
         Yf9A==
X-Forwarded-Encrypted: i=1; AJvYcCXm876woJ4ftDBjSX8O7DBVoKCaLKT+3KbnfvzJ63D/nJF9WnOQsAIAd20k788Yybk6zzStB/SXSS3oWyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXPaj1wQ6tFyAS7XQBGAGHCD2j+XXqcUVqA7HBUOGa33/U9kM
	eoLMct4zwXVc4XagZ2wmAsKRa2DxiyteuKsI/lvnvs/+vv06tbHbHyb/0P253/kb52UJa/kTejc
	5SZ7WiO5rHQKFpK500cvwrcuAj5YLugD6MJBKwccKlGUau9EMYiZWol53deEF/0EAnWo=
X-Gm-Gg: ASbGnctoJa8/4ZXI3kbJ1146LuWGKJ97AQyst7XY2wLBPDh5kS85JIH9ZLZwYvY2N8L
	pS+xkR+uALjZqAge4tgkFmDl9XgT/KHKay7CgxNaDdFw7goa/TIoUETvzHmmlFFq4VADejX5uFm
	PQ5bdqYO1LeL493eGHl2D1To5dlHz28WEpyPh8Zwtu96oRu858zZ6HthpdhcAV8oUUNCyUiKiei
	XOkzV0JCCewLcNfKU7OVX4HjuHYSeJhcb0hJ09cE6P3Xn8+PXnJUMvpbHRoQJDPp+AskctmwSPi
	yIkkjfPtFAG6nbiZr6VDA9/nLTd/GZuOFZuHK1l1iJqjfkl5hgyzQRrl5+UC8cE4tTsN9ae5sVA
	GC0w3NcNdoLlV
X-Received: by 2002:a05:622a:1f13:b0:4b0:71e9:1f95 with SMTP id d75a77b69052e-4b10a918517mr35987761cf.10.1755161583616;
        Thu, 14 Aug 2025 01:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzsEBFX0XFzWTx08N9omB5JXz7W34VN/Ia8pVMBYnsd56pdZT3Br6u/m6Ok1Uqg3vq8AZrCQ==
X-Received: by 2002:a05:622a:1f13:b0:4b0:71e9:1f95 with SMTP id d75a77b69052e-4b10a918517mr35987481cf.10.1755161583184;
        Thu, 14 Aug 2025 01:53:03 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm13155895e9.2.2025.08.14.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:53:02 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 7/8] arm64: dts: qcom: qcm2290: Add Venus video node
Date: Thu, 14 Aug 2025 10:52:47 +0200
Message-Id: <20250814085248.2371130-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
References: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gNYg7tlSjfmeDSQfEqZNlf8vH_QsGUs_
X-Proofpoint-ORIG-GUID: gNYg7tlSjfmeDSQfEqZNlf8vH_QsGUs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX+KvCrQ4rNqDk
 N9Jqpgi7SpA7QeHoOeXXaVsuUOZ4ZBNeN/czmhP0F/awpdBmtdwizs1OKCtJBakOLTr0S48JpSq
 BoawfKJHa795s40B+FTf4hMzjytYWGvFYzw70LrhI//5H1NwzDLo6bzpoMbK2S4ZNwlDaXIeQl7
 mdD300FOm7kNKY/Oh3mKKtBxzb2nsWHgTlkTSPCXyY45V/OXehSh3x1yMuTp5kznP4vY2BQzvO8
 wEx22ut1JcJuplRyrzkH03Qyw2tHOKIbIBIAVU4JiLp2Ce+9zoeC3W3NAsFJuB6jrBC1cH1hh9V
 rUN2kL6KUmMq1shxz9gD/dJCSkAaw4695QXxun4T0x8umPGsiHnbuXWm/dRrQElQBUsu8u1Jr22
 OlwgvVCW
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689da3f0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KD12_Wl4P5iJQNenjFgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

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
index fa24b77a31a7..b1a31af1afee 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -2096,6 +2096,61 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
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
 		wifi: wifi@c800000 {
 			compatible = "qcom,wcn3990-wifi";
 			reg = <0x0 0x0c800000 0x0 0x800000>;
-- 
2.34.1


