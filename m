Return-Path: <linux-kernel+bounces-826046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5464B8D66B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F2C17DC79
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2202DA779;
	Sun, 21 Sep 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNJp+CE/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D72D949E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438716; cv=none; b=Qwr77DzgOydBdgFoMeEwFdH4aKFROIDGfXrqu/1Fl2ytKm22wjhYiXrzRsvBnSC+BnZGJ2+DjqWWQ76FMb0aE0X468iGCggPcXSyyNBnNqM0nCWIifGMlwJdvI6l5V7yNqEWvNRzthbWwI3WIyz/S5TPPyZHWvdtcMHUT479SbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438716; c=relaxed/simple;
	bh=gdZruk0srcqzy6/KhEGZDdfF3ktae7pNRxkyRa0+7Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8hchYLufOz5Zvh57ptPeb84NxbzbX5uKMvwkhcUA/vlFoJkQ1LHnROI3NC+W/FJMDuffpGWCFr/GBAp93krVChOobvplOhmFxVHEgDIebiYjxeANag2+zegLM3WlaMN8KXs4wgdWLg0qPcSOqqpsYGkfKJbmZsLEXHH4jQhDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNJp+CE/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L30GEn013624
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qws5POK3y/Gd1qPYhifYTlDuaozSLRFNtSkU85V2wx4=; b=UNJp+CE/9GWtKuQc
	4R7KZLps8nbHQMjD2KgKXAhuJwnGKtWCduaYMuCvwZSTXc9OpqwZ36Zba0UXy5Vf
	0fXEPOUaBxsxwtGiggAcjijfn3vshrnhOl3MomeK/ef6j07R8WPJX4ybjgXYu91L
	pecTZyK5cMxNjJcGJSAhXKNpSNRYyH+cA7egWaImSUGGlqPkxCUVmf8bJalU1B/q
	Z+9XdVUdlAEdeO8agA/v7AnEcVl9EbjvRpKk8gl+w1kv01zzAzHPWbmS5LfuGP4V
	vAcy3+smy2RBjLGTDvyhT0a5WbzECd/2uMyEqJpgubDTHnZl96PbL9Vy9bnFNSEf
	h3NAGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyej2g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4bf85835856so64966571cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438713; x=1759043513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qws5POK3y/Gd1qPYhifYTlDuaozSLRFNtSkU85V2wx4=;
        b=wMiCFisOnXXZFFwTPoBlw6FfnUltq3zUZZo/h+1KDwX9mNtSYe4+8Ij2aNa+okLR0m
         gwMrA+RpnwPCdjvPfXhQJFKK+pcu68JThAE/Te0vU42+iobl7TqoKWve3jTXK+09akW4
         UpFuq5LoA0vJmvynqhbsDeLmigV9qLskYQR20igN3uBTDqGyhjeFCcb+CPYTsp0uILHF
         twr/YM8qIdLfAhcbNxZArfnsSZDRK1bAAu1+M5s1wgjsmIYiMBYOVOY/gVvhYvZH7Rt3
         V3UKmkOQ2l8pgLgodWUtmFb2nWw26qnvJWb9NI1RWTjPjK4bu1aXYom7x85DgCwm+qhp
         dcUw==
X-Forwarded-Encrypted: i=1; AJvYcCUVJIVeKJa6EzogSC97S7DfUjgV3zyKSDeplO3Qpj6Y8Aijg0hnBeyV8fmdvoZPcF7HNMsTEv3uLJMVlC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXVAtoGGqjjEKheSKFi9BSuFPOqZHOguwAshcm6Fm3ZtgSZuq
	N3Mts2zTP+N4YjU6/k/IdffTzR1nGBMGsiX+bbHOAXdKSR5N3WqS977fbMAJZcn/KabpfYVfd6h
	H+YtJSL+bQnEYlPhJiSLNRCwMxb/kYql994L/ovAR5Z9uvvMnP1Rq4s//LSdPjf0HcvI=
X-Gm-Gg: ASbGncsZMWtBppqqmLvQGbnt8H7KTYZCeuYu1BZAvzipSieoH+XmpcpLXG5npZgPQJ+
	r/jd8juOuDnmLt8IK69IAY8pJj+9aJ8sQXrwPbZfVXiLh79xMLEZQTKEumHZmrZIATZeWO/yZKl
	IXbOKuc1w7/lOvijGaDAMWnAC2GKrRs+3CPNSn5PSZ6Z4kLDa+gGzpk19YzJz1N9gt/fAGYva17
	BIDSgEnZzRabNOcMRJ9DaaXQwRf4DSxQ+TSRkOBI2PSkPoMu2oN9huDwxQpgww8d7knDkhngvfp
	AnCjPxc9ZmcnopmTXrLH/gNScpsLt+BHo81YkFvvda94oKZzLPjepL9XA+kEyWt00XGFSF9k8cS
	DNzeDD/ZJ8iIxbYkD8h8V2jlahOU/AlLdytbhUmOjNP5tvwsztTOe
X-Received: by 2002:a05:622a:315:b0:4b7:9a56:b076 with SMTP id d75a77b69052e-4bdaef577afmr148108241cf.36.1758438713415;
        Sun, 21 Sep 2025 00:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfyHNM0vbrXxYJJC/PFoXLo3Bpg+crKWScknsQAk2AFYJNIiz5xCXfVfgDo9Hy3N1WhQB6aw==
X-Received: by 2002:a05:622a:315:b0:4b7:9a56:b076 with SMTP id d75a77b69052e-4bdaef577afmr148108041cf.36.1758438712994;
        Sun, 21 Sep 2025 00:11:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:29 +0300
Subject: [PATCH 13/14] arm64: dts: qcom: sc8280xp: add refgen regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-13-9d93e64133ea@oss.qualcomm.com>
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gdZruk0srcqzy6/KhEGZDdfF3ktae7pNRxkyRa0+7Fg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UinXpj8MqCA274oGiiTasJ1axiVCfZCKUFd
 ZXTggT1e5yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIgAKCRCLPIo+Aiko
 1d+0B/9XX6KZ7o6ch/9bnWXIKnxIZuF4WZeJJddCyC++BY7flJiufRsnXAWA2N4H07M59xcgzLT
 HZN4C9TpuKpeYp6/AEpQzx6x7ji5EuWBdbMKB7uIVb4nyfcNQCAxGpLJDZrpxF/sz1YyUOynrpo
 +x+S+tIS+HSEhFh4KRAXUP+W3ylxBfsZVfyMlV+QwTSj8uwrLAYUjhVczqoRJhQsHkdzeFS7cV7
 LcYJynFBotO6+TsW8/sNRzkVTWnSnBSZoaxvjWbywWo9AM8RvT6Zw4OznAa09rrTLe4tON0JC3Y
 mf6822CNHho36tcF1nxmtMGTkmU+rWy/rSNBg2m9N2JvjCiy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: ppDA7K06fO2PH1ZKDjiPwatNzUW6tgBv
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68cfa53a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=PBGS3k_iT5jBzarLTFgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX7Gpyb5IZgBWv
 st1hhKNm69IC3b50zFzoO/j+6Gphy3eC5lOolP7clKKUe8WeiFafChIMTmBRxOWWpwAjYF/krZ9
 s27u995FRQcQlMtDUvxgivlYI4zkXKfRZ4UDO8NdLnbJLCcRCN9wEm27TN9vaPo07us5K8usU0W
 N8qx6TCJ8zgHWBTuGcpfC6mc0JJ4kQ5DYF8fN6hGFNQwpCfIzaIUM1d7L23RGUHDNZeOS4oZbaT
 zvuRcuoIRGHpPBS/7lKgQpiJd771ZnnADdPJwaK5+BdB8yjIb4JGwwC3tsV2FPaU+eBh5nasuA7
 oTspaJGD+X8HFM8R3+bOwaH9vbyuIU4IKYIpoKt6DCl7T9yXEo/fiyqhaq8Pf90sxaOQ9yCytbC
 /XKMOLGE
X-Proofpoint-ORIG-GUID: ppDA7K06fO2PH1ZKDjiPwatNzUW6tgBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add the refgen regulator block. It should be used for DSI controllers
once they are added.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 279e5e6beae2099f26b8e0b8576cd6c99fa856ef..e48efbd13bfa8dba71928ef11b80ac27eb4b6f85 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3723,6 +3723,12 @@ usb_2_qmpphy1: phy@88f1000 {
 			status = "disabled";
 		};
 
+		refgen: regulator@8900000 {
+			compatible = "qcom,sc8280xp-refgen-regulator",
+				     "qcom,sm8250-refgen-regulator";
+			reg = <0x0 0x08900000 0x0 0x96>;
+		};
+
 		usb_1_hsphy: phy@8902000 {
 			compatible = "qcom,sc8280xp-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";

-- 
2.47.3


