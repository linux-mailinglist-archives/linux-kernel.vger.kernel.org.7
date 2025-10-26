Return-Path: <linux-kernel+bounces-870299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D616EC0A6AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EA63AEC6B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD326CE3C;
	Sun, 26 Oct 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aauOFUDz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E00B26CE1E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761477506; cv=none; b=OE+EWSRNmbv3IjQvrJxifX8kg0cIyASINnYXMImewlEVkcEyVUye7f/UI4Y5b3gufJREaKFzO2AzUFKkvk/n0TspPLPdS7HIB/4OVOmcZf4rq87QwoP09snJHc69y2LGvrI/jN3IxByvm+d2+8Bi94WahzSOdJ+eCub6jmakOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761477506; c=relaxed/simple;
	bh=R5Iwm+p7FGWgomQXuQyXeJr0a6lDNiN5ZJM8uW4YGN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+9zBUnAcYXew1RgW0mb+19VQRTPmeFqDSyw+FjT2FQAiws/IKMx98LlVaxy2JDFVtyE6N+98ulNnhpMwD51EtFVE7s3XH2cSTHWyej9sZX0cS3xCQh+Os8JPBhh0d0Qzf6RgcEXna1lkRCuDCgj+x4sDfHXzoMGobcJzA4Zqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aauOFUDz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59Q8SQ3K3572961
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=n3egFmjPZZk
	XUA1mXAJGi4QA1hhYTOpuHfcukdRobdc=; b=aauOFUDzY8Nn22SR0q5Y9Pk3uwR
	oQF4xzfOxXjgy9Cn0rIAUR/9yeeeHUjWpIogkwhI93p2yMlj8kf+cnQxJ9hwiPmi
	kegkoZJIaZfA5VumD2g0TA80eizLzbmRTF4PlYuy5qkpbNwoUSBxyBJFS8/YqC6a
	4VdViCTWrgi8p/TFv08zStcHKHhAmBmbAG4d/1kvkcn6tGySVz1vvE97yQlqz6oF
	EaLPZBUz5M2M+TspywXIcSkuoQVPLxFVJ2I6wKAhFiyvUHkP6K5e5HtlnGmaqn9L
	gT/z5av0AuNu8rXjdJFedAG8q9aCOunPHiGGgfssFWnNV6uTSqMw97t7ykQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0nnxt0s4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:18:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a27cc51397so269700b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761477503; x=1762082303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3egFmjPZZkXUA1mXAJGi4QA1hhYTOpuHfcukdRobdc=;
        b=SJtEnMVTr+IiRBnlWV3OyVQbBwBVKoFb0RS7YkIeLQ+/6S1BPXFWPsj4eULbP7Vrrg
         IXKilUuavJsJwKod9+voaaCbL3DRLpH7A4E819DhGCzcQDT73e8cysWezDF14AlU+hnO
         nCGBXs+6kBxhSjImRxk8G7dLU/DRq2+0Pra4714KifDOl1OtuXSLnakI22e+pKY18k2R
         5eTjr3/F/kcMW2YM7vvL1iR1EujrpkIEfRgv+aynF1euYcEWA6IZC6UuzaqKcuKnM3qE
         Fsz1eV7JMcYT8mXd9GnM1ElsiQ7hWsgqirh7irKIAJAhUa6QgdV3yaspsdI2bX89c/Jv
         Cw5g==
X-Forwarded-Encrypted: i=1; AJvYcCXwCQxmFgaxD+MvsxKj5wULsP2evQ685enZj5DE4KgGX3zIXs3iWQC3TUq0MjifANTxzssJZEUuwZFLzyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXh75FQVkrVq/3RowsoQlu/ETHelTuPhpsUeMDBTZ1hwb6eD9
	0kHtPOpOy3jr8cK36dadAicyxg7dELK1TBxeP8SpM5sBJVJf1JWCSPuSSatwtU9hoCKOi/8IwRG
	yBc7M7PP8chtIf7jC2MTlIXSajnIUvDUfM5acXq+XudQ83uY1WnO7e3V3XvwyND2EIw==
X-Gm-Gg: ASbGnctHQjiUbb8KzJx5VoI6i1qWiLzqAlntA9ggXR949KPl4drmnO2RqH8qMRsMBNJ
	ZVRklGdeJvGSATo55Pa0je2mKdRPOUOQcDDHF4oQ53323ddUYjJAT/RurctiD7T3emwhTbm6KZF
	m2Bl/+TCDgas8c41H+us7jEWwNJ82NUX011Ntjn9zutNQoGgYoGUz2IhWmPc9lzZs0qyT3VgXzF
	qSufEVL2Aaiws8+sLNPRhf3ZELFOmhvShl1nX3xTlVruWmjBJK2/xEFHeR4AwyTy1oQy78RagDG
	GmkJgF3zCZ+V5PjG/hN7m4x07xOtYlvwOyM/EARccSfQRaqfNzRcP5o9KiiaJnSKtMncfVKVHes
	jHGhUtxPeeIwGHU6OVj792OzwdQ5EiQ==
X-Received: by 2002:a05:6a00:244d:b0:7a2:864b:9c8e with SMTP id d2e1a72fcca58-7a2864b9cf8mr5530975b3a.3.1761477503562;
        Sun, 26 Oct 2025 04:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVoEqBrpuDnh9tAPwwGRm/FFVYkw9r193nldCfCr9sEnaKUUISkGkIOf0DKuNkSXzwVcmXcw==
X-Received: by 2002:a05:6a00:244d:b0:7a2:864b:9c8e with SMTP id d2e1a72fcca58-7a2864b9cf8mr5530958b3a.3.1761477503053;
        Sun, 26 Oct 2025 04:18:23 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140301f7sm4707829b3a.19.2025.10.26.04.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:18:22 -0700 (PDT)
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
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH V3 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for sm8750 mtp board
Date: Sun, 26 Oct 2025 16:47:45 +0530
Message-Id: <20251026111746.3195861-4-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xc+EDY55 c=1 sm=1 tr=0 ts=68fe0380 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Fl7qsps3WXD_dGGssnYA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qv4ITydxQTNdnzKOFUiJ9m9akwLleOt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI2MDEwNyBTYWx0ZWRfX+B4HkBygLjKa
 oqenMvMnXbQk7ZI1115SDMxHDxbzK21PJqjvp+p7n/PwRn4lk+iJ2u0HtKXEW62Xs4gLSYJn2d9
 pHvi2SHtbFEEO0tCEZAPZ0JNQOLHNn8IOSVdT3ipmjvJ16MPpYR1k0HPw/x6MqGE8WLGO4MK3NG
 nll8BK0HITVMIBBV4YzgEnPFXOVRtme564+aXKZRwoMDPaypg8X5NhDePikTY15MxF6VIa/XjB7
 wZY7fgpE8iZcaARGmhvVlFx4xFtppr0k0oynQtJvM5qhVtc1ZxszCBvYSp3UHSQSuwLaOoGAeBz
 6Rf2fK8eR1egw0CqwxX3imtL2gwM3EhPcvH1bmz0u9NbXck7iHdSUhXj4Nui6cPw8oSNQ0cvox8
 T8hAyaaf4R3gXj/Rp5CVAD83/MTSTA==
X-Proofpoint-ORIG-GUID: qv4ITydxQTNdnzKOFUiJ9m9akwLleOt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-26_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510260107

Enable SD Card host controller for sm8750 mtp board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..5a00603ec347 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1163,6 +1163,29 @@ wlan_en: wlan-en-state {
 		drive-strength = <8>;
 		bias-pull-down;
 	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
 };
 
 &uart14 {
-- 
2.34.1


