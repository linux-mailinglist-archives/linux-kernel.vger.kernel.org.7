Return-Path: <linux-kernel+bounces-826043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECDB8D64A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3717E4428A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6D2D8DDB;
	Sun, 21 Sep 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q+2A7B5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F912D6611
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438713; cv=none; b=Zk1aDQPkfHZJbnmt/d/rJZys6gCBd1B3WkT4NqBbD+Y5G66437fnFETymyUFBjPxX98g+poZ6e8aENGNwGHX+xsx37Wm/etl5GguZUvZLAU/OnW2QRKfPWEwDLhuLJEdpa55p7nd1AmJTTqTYNEfJV2Rnuy8AtEzG5nF3TS9qQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438713; c=relaxed/simple;
	bh=KOrtr9anBwhu3Lm3+yW4FXeCTQdCvH4Eo/x1eLlVG78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmcSQBwIz71yq75G5tVfC7I3dIAEw/UQNoXJPgiEdZlbvlrpFVenypB4UNBY26xv19/HWU+ySEfKwIYStjZt7EqBaEnBo1ewcpo0XLs6CRr5ZpTjcJucJ3QprYSk+kBHhwVxQkMMRzc8BjykuVw9hBxbZuJTj7WUiRSRxDhK7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q+2A7B5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L3lHHA023650
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5UKxEl4Tj1idU7Nm/u6DnMbzEVRNgZL4yVBAlpg8pIU=; b=Q+2A7B5td2QcFt7H
	4WnNBfSZgCaFdjeWv3RoHpGM5Wb0z80/pa7FW4qcokmr5HMFYB1ZINBi7LuDF72X
	/JdxLRW+1/uzONImOy97yBBHlf9cjNWfUA5hNcAu75ndGuofU01iS2Q1ESucBfF2
	DEbSyJpmN0j8wIJ9EnT60OJ4DIKAVFc+2pe8rxB1t9Ud30BeWACEcVz/HER2f034
	PhQWG1PRjvh0UMGd9nDgFVucqorRSLm9EpvWkBoXAivnqzGBNG+xCtl5J3/ubdrA
	q/Szc4TuOp5Nw71NhkQi4dPjFycR6ab6R2y+L0OqtfXY6lst62LPCwui0i2fF00D
	fdoshg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8spyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b49666c8b8so59956411cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438708; x=1759043508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UKxEl4Tj1idU7Nm/u6DnMbzEVRNgZL4yVBAlpg8pIU=;
        b=hhvc1ppWQz7SzE4AuqQ5xu4I8yMNBYM4XUfkENsxpCuS+0Lte4x6+f1r8DiJAkQ1ae
         2Nt5h6aPz4bsJPxqxFZhyJDBSC6oPww7dv2MixQNBEbPz+nOcHVjPZfFJ15yEDDZQu+F
         fk6ZKdS+gByFvumae57W8gXjeo8OIMZJZQlVQvw1mvZDVvOkJ8jD1f6rZ8hptVjc98l1
         3Y8jlPeWjsllTJSyZNyCF5mQiXcbWYuiM7bmBCrBPa3Jq35H4a6H0t65wn6aABG+cAvn
         xvo3T7Gju7MJzCvAwazFIGABTHmHjSYQcIEP2ygeHyFK15jxMCO7KeWf9QLxU6Q+v+8L
         hHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKsKkYw2CEVlo2ZtBvGfdskLSPPiqEOx3rl20KVmbQB23+5uR8RxBfHJWxMpp+HuW96vjz8lv9QAm/kg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMJYy84D75JBPdEfLP5Rx9WS2g9lUmeCuFKqmxYICf1XkCP99
	xiMZtepE/23OZjBfE6hsBOjjU4kJT7cEqf2BlwZGbRMyAnjXeeHKPBHixm5gksLu5/8dxKcmvsN
	lEsLz/F2w9eCE/6s2Uz8qQ4fFXkVlw/iQ6xrBt41AWdXaOIfZPpGQTPDKf2cR4XjU64k=
X-Gm-Gg: ASbGncv/wqp6E8LsSPm2ZoMQIHYHZ4wDO30SP7dDUxa0NMApgXwLlZKm+9qjubXVRjg
	O09yj5oxwSPV0otOxXcexTuiMkTZUsotvdZ/ri1rpMzfNg5pPGRL8efaQ6HaGsBy+rJI+B9eIUN
	njBBuCQeEAIVDEQAN7/9pgbaujhViljJ7B8ShhPy3o7ESkXC0zL3OtTivdvNEIqxeawQsq3gvZ9
	VhMQoip5ZdiS61oRrXvyrK3aaHtU50sdh8pLrQktx11zSzaQEfbTCz7UUgAeusgsa/M0wXh+Ov2
	b67S7MUGAls1yN5AMlrn7dtlyt0NkZXzAsmrnLEJGFkh7MTCDPmx7yaa19xgDcKwXLlEbrD9PK7
	eaEiFnTWXGVOpW5DKoy8yXnGsB542kxHDuzUYGl3RFwy5/Q1gGDzK
X-Received: by 2002:ac8:7d10:0:b0:4b7:9abe:e1d0 with SMTP id d75a77b69052e-4c074359c94mr94438561cf.83.1758438707787;
        Sun, 21 Sep 2025 00:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiNftRpn9KjvlSL/RDOxBX5e8nD0VvpVQBe/J+schooKFCCi+R5m7dj1MxaUqGGzQ7yvMK0g==
X-Received: by 2002:ac8:7d10:0:b0:4b7:9abe:e1d0 with SMTP id d75a77b69052e-4c074359c94mr94438451cf.83.1758438707335;
        Sun, 21 Sep 2025 00:11:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:25 +0300
Subject: [PATCH 09/14] arm64: dts: qcom: sm6350: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-9-9d93e64133ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KOrtr9anBwhu3Lm3+yW4FXeCTQdCvH4Eo/x1eLlVG78=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UiYddOH0h7x7juqL8KjUrr3kezSpxnEbDeV
 5Z8OUkSmcuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIgAKCRCLPIo+Aiko
 1Xm5B/9cwh1oT90s6mnxrQVmsGk7jwkEdm15qFkwklbt3suWr2TmDUrHAkdXqTgT/K/hbjJ8gtp
 +qyKdRGEWuNmgt9yPWdzENoKyutWeDFkquE5jKOlbjjnKIxSfibiMkJMK77gK9E766nHwyjiQo8
 sC3SgBqBs3BCAVQ0uXDq3TfdfjfQKJF0A1Qe+//e1NfuR/K+uRJojvLZ/dSuP011FHan/rZnGug
 FZoLmAuXzyufE6FpXSU/StCx1whgetuAeM6RXSqr6HADNFiPhS8XrtiHo8E7YyCNtRvDgaP6h1Z
 N9Ng7QG1F7S+ExTrVg4lkZSt0cxNx6fkJOJuOppIcy17xeUN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68cfa535 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=XZOqtvWFhPgZnOB8h3YA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: TXUI_e96GgybLfBQtuz8V6VPBDvo-qPM
X-Proofpoint-GUID: TXUI_e96GgybLfBQtuz8V6VPBDvo-qPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXxXAoZSx9yVVm
 6ktc1QRMr7FEBARNnWDBMeE1XcIyMDo+rj/8GlXDoGAdxDdlX2M3+18bMVpsCmQ1Iis2Sjd7YWO
 3G0COO4ZaObG9/WDmAQ71zCkBaaFSuDOOvOENSzE2/5W4trzwYOU/h1RgleVzaarrEFNOQXwTdr
 ZTXz2G5nS3GUEvcmZ7e9Sgz/e1fQRf4V7ymCFRdghG6Je0gEZJ5G60V3YNc19nYi3QoUTqGXBX5
 4B2OnQjfbVlg9ee9dpqJmrqenYj7DjOi5YodPTo1lE47ZwGgydqUu9xLr3iTiG99cC8absrgWUC
 FkLJfO1281tlxUvt3Q7eeKREHcjX3Ps38svpz36zvVECMOGD1T5pdkPJlAsDXV4bH+jg6krqn+8
 vhfo5ddv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

Add the refgen regulator block and use it for the DSI controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8459b27cacc72a4827a2e289e669163ad6250059..dd009569a6683a25f13b068e3e0bd8746b2ac501 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1768,6 +1768,12 @@ usb_1_hsphy: phy@88e3000 {
 			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
 		};
 
+		refgen: regulator@88e7000 {
+			compatible = "qcom,sm6350-refgen-regulator",
+				     "qcom,sm8250-refgen-regulator";
+			reg = <0x0 0x088e7000 0x0 0x84>;
+		};
+
 		usb_1_qmpphy: phy@88e8000 {
 			compatible = "qcom,sm6350-qmp-usb3-dp-phy";
 			reg = <0x0 0x088e8000 0x0 0x3000>;
@@ -2360,6 +2366,8 @@ mdss_dsi0: dsi@ae94000 {
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.3


