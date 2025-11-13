Return-Path: <linux-kernel+bounces-899384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58568C57C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E4A0794
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F4350A1B;
	Thu, 13 Nov 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mYJZ5m7z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E6Tb+K43"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71E3BB40
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039394; cv=none; b=HOGPEmV5eWs4FsaEPfp1YEQZgiVoDcHL+tLrnBzoyCrHb4PCbxxf4TtdAhXRqJyTixgeV6GEKFfA7FAiF0Fj7wZnWMRHbLUW6UIRuVlV4Y44WYuYnJ/zyokCbLDDfeipcvM2vfZ4MXEjIsNkMUn6rwHSe0M2GiX2WJ+qlt/BwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039394; c=relaxed/simple;
	bh=Tb8hlY/ue357UAGp/YbnSZgOfvuSUTCaJDEbEWWhvQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EbwpVqQ/L5NyPu1GpA9cVdUxoBm9s5Idb8f9ZUo/YjOAWBUAmbZEooKWlo4uaAW7l6VeiVVKvUEmixj0DaN4sR9L805nH33+JJDmGkfupiuZkub4MUk5smcN/uViMy/PxlqCyzEm4mAHJPtNE8R+ibkcZ1elRF8WdbAti3AdXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mYJZ5m7z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E6Tb+K43; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADBLmbU174696
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X/Fk/eh9ArwhqLNgg6Q/DG02wpChZB9VVQ1
	LQ1/+140=; b=mYJZ5m7znx4pIAhrPniqUBRcDKIxRfPK8Vz9GDp20EsJRCAnfOI
	61W7FO5N4wUijHQ0u4QrNro1WR+KV32FRJWB7JCrSBHdI5fqqQBrqJ8Mt3ZHCOek
	3lLvr/d01eWXHHi+vwc92pZI4DLcqhg4lF4GMrT8dUwQoL0L5ZxI5Zfwj05qQ6ud
	9JBhcbml0WO7aNVWm778mhxIJdC5l72saKZzMpA2rUs9ohl4SiZBXClAdvPXfymp
	ZRAsstqQr+FiIAtqW1tnltw8VzWED+la5KwnQwNvRiHIqjX/vXOWvKfF/vCilta5
	+OMFK8v09Wg+y7t6AIAHUBNj00h4T1XDUHg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aded1r9fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:09:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3436cb61f20so201283a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039391; x=1763644191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/Fk/eh9ArwhqLNgg6Q/DG02wpChZB9VVQ1LQ1/+140=;
        b=E6Tb+K437YKlmpETxmtc/A3AuITUNFzqeAiyVMLRWD9hgMIW5WCF32n9cD6rB3TIJX
         pjjiyh+FMQple+VHDXkceVyka1Abya6YET1UAsvH6M21sP10t7QeU8mKVr7ql8LBytzD
         j3He3PY7QsKrMmNIHokPfmAVnpDfZhhZQtnMKCrXpHBV/iqI53evNBKvqVfoIquCx6ok
         43QylTQXEwlZFZyJud3vIlLO9xfE0vtLeZH3W7B2dhy/tPi14pEGT6cnq6inOtcq5zyO
         PLQrGBv6Lme3ZERfeYpCmzH0KUxWnhs2V2s8p4B+pa4MuIWI/orlzbMR6WGNkjBOspAT
         sXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039391; x=1763644191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Fk/eh9ArwhqLNgg6Q/DG02wpChZB9VVQ1LQ1/+140=;
        b=F2QiVcBvb8i561C54HcrfxwyRp+RpxKLaOF7fdlT47vnKaDbUr4/sfkJ17nscDKoyP
         86ZNK8JgO3XusC+or98qD4s1GMPssuHqihxk2CMxqGuNCiS+1aKoHH4zKaRDHA2z9wYi
         vrAAZnsz6GxCK0rnSfRZoOQWagUmTn13te55GRAFDO6fVsV/AzMCjJ62hfwYFSQ87lE0
         nEWcNQxVwz0vAC7w22AxGIur2F14PFc7z6j+UMzxlNkZFCyiXNkuohXHLTlE79Lfp50H
         cs+HteWise2+h/f+25xav69wco4QfGk9kUwkN03dNoJyhoCSIm9PKMo6u9T0mm8cD/cH
         UOYw==
X-Forwarded-Encrypted: i=1; AJvYcCXOQa4nAHoXqmxINnJnk+60Lhyv6m+WeicQjsV9mm+b/NWwfEZHi/GbgnfUs7g09nDtRPGbZzKcShhtuVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3qLzIZGbZpOe/rVnAA19GIzDE/eyZ3GiNzEcuOik3VIyblNA
	1ZmuI1CsxLTB+Q5XVwZKOpAlmjngJ9jaZWEzeaQ1i+jpq61s8H/E001wjgAa2bBMvdPhCXsqJOJ
	WiTFCGyvPxa8jkTL+aWocB5rfsJohF/M7jeH7e/ReUb8UtH/2gvwPnI1n2hTwxtEgpTA=
X-Gm-Gg: ASbGncuCc0r3xllFjb8aBV1og76ivWcBO6YGFuNbMV5EqRM8dgqK+1hSzEHZOmWOPqZ
	YU6WlT3l2eK9NEnw4iY1yYzVl9IRPamT6VnRy58GRaUqbv+Ctp85UOqsb0T9HtMOs0auZqU+d08
	LrPfvMtcq426xDfMWhdFwMe2r7Dlcr5LKrI76iyzWpcwSxEzNgrLXmzODJ2XvQFIfvlJDQfOaBp
	FscVENsu9sdVCR/DHv7zA6H05KHrUIx2NxgsEqJ0P1MuGbv9pLOkVhbGVtZ6IfhLVrjPnLeYLJa
	e44EkLgbhHIrDveRKBFcfXFgfRSbGhAnRkXlmrzR7VauD+B+PkrDTD3Sz7YopEcYoXDJx1IrrmW
	mymp7iSAHvs7ePa9E4OO2lg==
X-Received: by 2002:a17:90b:4d91:b0:341:88ba:c632 with SMTP id 98e67ed59e1d1-343ec508f1dmr1895583a91.0.1763039391098;
        Thu, 13 Nov 2025 05:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPzr2ytKgyBYrLp+8mgT98YfCzOzC0sfxbBUsxNvaFOcI8sAm1wPEhjrcHHrqJj/ft3JdzBw==
X-Received: by 2002:a17:90b:4d91:b0:341:88ba:c632 with SMTP id 98e67ed59e1d1-343ec508f1dmr1895565a91.0.1763039390590;
        Thu, 13 Nov 2025 05:09:50 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm6132600a91.5.2025.11.13.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:09:50 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
Date: Thu, 13 Nov 2025 18:39:42 +0530
Message-Id: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VU77-5y3X4tqkPtKbe5gIP40ag1xeBnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfX8CERj9gbTJHm
 VgXGTFMk8TJdkMJr/T9lJpKMaCPzAQq54+rAuZVuAE0haXan7YL65ZESXTctBM4ZDspuz/SGcy/
 YnXitRm2I748D0SA/nNe5rJdtBGn66nCopEzkv3yjJ+siQxdiLtVJQh3jPZFJCJCpKyYOrb1tZv
 I7ELcss/LyOqSVYLSf5/8/F83h3w81KBuu8gDu3Eqz4dxL0iTnuweB5k8Mev2dx4LTVHdX9nUKh
 zgMAFIqQFEKe7FiGNAF9ao+PHcJ9mSrB6BGuA6QJBCIoa9dK2HVYIlGCFu7spDBKe3i/csD/a+9
 X1+GMa5p3J+qxN9TKomviJnWHfvkfO5IDQ3UNk2vltkACGwnK/FTNiXs+fUpXImDtLZjVeVTEoR
 EkPjIx8AfUIheEZ9kQHYJdrlfMzfEQ==
X-Authority-Analysis: v=2.4 cv=StudKfO0 c=1 sm=1 tr=0 ts=6915d89f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NGL84Lcurrl29Kz1Wq8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: VU77-5y3X4tqkPtKbe5gIP40ag1xeBnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130099

Enable BT on qcs8300-ride by adding a device tree node for BT.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
This patch depends on:
- WLAN
https://lore.kernel.org/all/20251113055148.2729943-1-wei.zhang@oss.qualcomm.com/
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index cd8800a59700..08b705fe4eea 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		serial0 = &uart7;
 		mmc0 = &sdhc_1;
+		serial1 = &uart2;
 	};
 
 	chosen {
@@ -71,6 +72,7 @@ wcn6855-pmu {
 		vddpcie1p3-supply = <&vreg_conn_pa>;
 		vddpcie1p9-supply = <&vreg_conn_1p8>;
 
+		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
 		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
 
 		regulators {
@@ -501,6 +503,13 @@ &sdhc_1 {
 };
 
 &tlmm {
+	bt_en_state: bt-en-state {
+		pins = "gpio55";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+	};
+
 	ethernet0_default: ethernet0-default-state {
 		ethernet0_mdc: ethernet0-mdc-pins {
 			pins = "gpio5";
@@ -571,6 +580,25 @@ wlan_en_state: wlan-en-state {
 	};
 };
 
+&uart2 {
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &uart7 {
 	status = "okay";
 };
-- 
2.25.1


