Return-Path: <linux-kernel+bounces-805299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E1B486B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D818A3BFEC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9D2F7AAE;
	Mon,  8 Sep 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhNtNLzA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B02EBB89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319653; cv=none; b=T/IOI5QtPYDOnykQbL76zD0zj3t0+gLXHcYWWs42bXhlYQZUjMl5Jbw+hpDPFgAER4bLBng23cXUj2vHzDw6XhKjOi+1+7k2tHxy55g097rQo/ChpApDR3YveatenC9S9Ve7Lz+Q56Qx678XgxzGU1OEPS83NAEvR3NVvn09A/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319653; c=relaxed/simple;
	bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpP9XWJpOnsrm7Xv6fcIGkPYsbzX6jTs6iai0b2rfWxfk98C19mQtF6WIsndT9LLMgNYTXds2G24xQA9srdgXgwscbKzROIZCdqcfAO9Of1EOC9Gu9UaSPtz6d69yD4d02VGHhejyrQoDI5PuZMNMcv2hFOVmXFbQMsaI6/D++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhNtNLzA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883lOVr013554
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=; b=AhNtNLzA2BfKtu6u
	6yocinb1pPo+t4NunV33zYBVHtpgafUSmR+Z2fGoe1Muow4f4SUXY+CWzSLo4ptz
	eHpP8HmxMGQlfE1zAQXMCxVg0e9nuRiRmEGN49+z2Xtu/HI9qUNxISZMm8ezsTFJ
	kky//FSKLcx6qm1GsDq0fXWvD/AqHQeArLWrQvefwcFZkqXQf5dRyqeq5aAlEpxz
	Bd3Wlcw62F+Rea3x0bujz1hOCr1mfjXtCDflOAvgegQvanaNNwr3krcrW+5gn6eH
	/BzrMaKl2WE5ZVjGBfGa4h38qRcAJiEge/IpIuaJxRawhr9lggZLwzBBfq4gzTip
	qoeL3g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrmmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522c35db5fso838301a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319650; x=1757924450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=;
        b=aAUdYWKvy3s3r8Mnx91A+ASiRJ8ELaN1K26ne21QZ1bXMixuhq7k7rxBR3QTqRC7ZF
         b7r6XKNy/mtQZA6U1la8FTHNXbLe76/zzkQwXt0ff5tkUQA4CfnvAn1bOOX/dTYqgTTw
         hrLgK+jGSnARGwj5Ssd12VQrIzl0mVC3olTnZzyPr2y1vpU3pJoxtWCdAQhcDQmdzdC3
         2NtDwwrtudZcEtUbrgsk1+U2iuzu3QJ2DwAAvsz9OWtrJ9WzM999SnL6Etp7NrWPoNuH
         0qB+btTPqiMR8Evj4F73o2m5NNMSGFiryvh5ysd7SzS9W/kXCicdrl1qI8hhR793iWH7
         NyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVZsKfVzoJ+sfEMISO1Dy+c7Zgm2y24PHDCijzsYm+iyYnAOzk/sDTYxueg/sLzsqH394i+9iI8hxbViM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNyIN8Mv8EOMHKwalkuYDdoxxDFTzJjUcB5dWKQfOEkNEcZjSW
	V74YFbBFBSF9gvqiqJb1wIPd+90CADn8jmfJVBDw6ZTwPPfS2njT3gfDtlyAiKB/lZ+TGW4G4cG
	pVY9NgM501TDp/ZKa/CxatA6y61bYyPBzaapE3wkRHi+bbLeYjNuY5AZDUa276OJcq4Y=
X-Gm-Gg: ASbGncs72betbCTXLtOXThp1z5IOLEoFDmbAQV7NWepqjzEEifZm6k1i6neA7yL6KjG
	AtXxfMdt1qJegL8DwFZGQrT66XhXWvWKw/sPeM3lmPfp+9YWy3cZq3SLcxlTNgI/s67IFEqgMiz
	SSkVZBEH9YV7Td0aaGkAMcTN2LOXfyjTDZcBrJY5msY3I4XDgx4Gru/6u3YafAFMArkRnKFwAOf
	tfu0i29wMcL8JXVRJ4+0akte4eiQ4Jv/cuGIYVY81JurSf/bTHvwwBmduODrldBpG9pNCJaGLCA
	AAgsUOUdlSCsk+8v1pyIALUtGrjsRoUUFzp5np77NeChgg3Twflnd09Tgpm/OMioeuQm
X-Received: by 2002:a17:903:4b50:b0:24a:ab0f:e87e with SMTP id d9443c01a7336-2517301ce3cmr88103525ad.55.1757319649967;
        Mon, 08 Sep 2025 01:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZrdo5xjhycVutw6GQ52ITtWgmshTdAXB4TsZXe/wwIb/gpks+7hZaULtdFlwOFTMBebuQoQ==
X-Received: by 2002:a17:903:4b50:b0:24a:ab0f:e87e with SMTP id d9443c01a7336-2517301ce3cmr88103275ad.55.1757319649432;
        Mon, 08 Sep 2025 01:20:49 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:48 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:58 +0530
Subject: [PATCH v4 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-8-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
 b=AAUNN9zBr2X9i1EJ1D3Eje//aVUURrkPMOH1CL5ctvoVFi3wCa+/lrGJC3NJ1RYJZU5yzNG2Q
 sdA5G+fjPhoA5JZ1k5Ooo5M7NIEEUTgQXNZTRsk5NfuudglLmfGuZxd
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: vdlgETwWSzA_IaZSJdEfBZXH6eqlTJ7M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfXyO4Tccf5MvaF
 mIiIxetEyLUIW9Vs9IqlfFXb/Phibg9oZGjXjDzGRqduYUyOeh/AyFKnKfB71liyLWXkz0KLt9o
 XudAToCtC6wmBw51YJIbIF5PdlrV3oASNv07ZeqI1C7l6pYliy17JZcCUBeZIVDo9SJwmjBmZ4v
 3dZgkNrUjlXhYv8Y62l4KGHD7Mo0Bp6AsC8zOoKJGgbBDk0zcLH5rW041/MYemoLI2zhpnqF0QW
 fE80CLl8J4C0TqEO7nkCMOa3qsDR/U/5nmt85DFUReUIgxBtI9/Nf5aQxVl6cSH37rf9IoADzlX
 jfEhBqaXJ0jR1PVwJBKNi4CUJH9wFPKMLyISuNxXdPklICDOLxamE83PhGXXfJLLSYHCuRP1Bmr
 d5PGBdoc
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be91e2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: vdlgETwWSzA_IaZSJdEfBZXH6eqlTJ7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 17ba3ee99494..1ae3a2a0f6d9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -425,6 +425,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


