Return-Path: <linux-kernel+bounces-826039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79756B8D61D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D4818A036B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789712D59E3;
	Sun, 21 Sep 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mbZduiTA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF42D4803
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438706; cv=none; b=oFqfOoZQIQtkmjD7KowjSHmezt8kTnTPAgaflGB80Bzv2iNPoP8AE+CipdNe6MrHOcoqc4VDDbH0hQrbfMy2ipGLpr4xwSt0dVT0z2SWJGE9D1JCbgrY1U4ZUkIqaYGy94VTTbGpVZxeEfPmtdD8i94SnmC2lFARql8vX1S3Z/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438706; c=relaxed/simple;
	bh=redOLez6fIriMFkILfbpGmysM+ObU6M5aEyNYaHbMJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOWhxxJW7JpjjgkFp630pjAdij4hQ+B3omCMSAObSJr6dRPuL1IxQ+1GyZtyNms0P83+A8YuFx6Q76pyd8zM4Quc9U7eB86pDs6rkAob2KvOWGEE3o1SC7rzdmPENGwFnWKeJoOqUGBYpusVYdzp7xn0xqcVBZ2BN1+k8q4FvVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mbZduiTA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L1KJYh016525
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sO6MMk22SdZdiNIAiwokJHffFe9hyurjW/sJUDfRXf8=; b=mbZduiTAXZ3M+RJo
	j+sYqBO19xYE9zCxYQ/vthk0UgSBkH+015hJPQknCnLq64X5XriGWCIxjLu5yoA9
	P3Lp3CpCl9EEziM2lmYvfmfA8wekSHldGDWhfzmZAxEy3pnemozCkH5pKTIB9vII
	LcQoNmQPe6Lp2/+4MnWxzl6KmPnIEZAV4gWlI2DiuWKPWOiFvHlX5OPHw5LKQFEg
	XHWrQyz51QbpLEOwDRjfvR6FmpnAtKufivA4H9xcZh1sqkwJqAe6QZV11CsNjsCb
	k2c0nCUpam0/1VipPbfWt29+TymZOIwgnKISNZCvgCg+b9MYkAe8DtGKvHtPe5Yo
	c8NZZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7ssxav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso82792541cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438703; x=1759043503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO6MMk22SdZdiNIAiwokJHffFe9hyurjW/sJUDfRXf8=;
        b=Cj5uYqiqy+FWpcz640c2/ztAYQCUHZyW5NQRkvK4VQVsvmSJgC2grYTv1Pat+xqki9
         Q5jdCyFtpQiaHRtCZ2e/Re0M3V8LjZYd7FYgtOALF5eefkQgi3MQwdewSBbcyDPc+YOc
         J/f4Eu6VjrQkWgSH3JSuEN1iZ6KInW2hvLA74a0IDDve4+tsYhCKqK59ndouLURixrIt
         vuZwITzVb2CqoajSEKGUi+1F12RxMcKbVDgOOg6ZPj9NEbSPqcQFkn5+JUoGDd+qSMZS
         JGxHSMiwXtZUhQr1Jb4FMwplfqI07/OrPt7/FZyi9h8O1MTlOYFWVuihGh/c89yqrU5J
         zWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYV4F7NR5nU1j/Kh+A0MDKAlIHUgffzkNGWDFpAvwm8IakKT3zaIhjeTmJ3U4ZYXiD2AArl/ugGP3spKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRW3BgFv2mMmTwPBQk/d6MylZbd3v1h5srH20/j0pvQB4k347
	su8G+O39YGAghjdWk+LXoIEDFCDMVPDBzhP7N82n/Ag/SZZSFg1lKU26C4lTyisD7XQvDGtnj0E
	g7DEaN8IDCt7JdubscHu3Fb+m+OknHgdMJoRkdWm7cEn/JtjIQGBG2tWBSTplijsX7ns=
X-Gm-Gg: ASbGncvG3ulhGbMJiphiVtohaH+Hnkv1+NOu7nwVerksv+VukQ/fTO5Y2IA3Y+4WZ1m
	kITp//UAeyswhFZVWf5/GfApbYeJe4ZHi9Htof1ZA/pbOI2mVnU6YGD0vsVnejjPdid0nfz+GMt
	0O2rNBi4QRtFIn3l6R4wV+LDiXQDwbL6O6LXBz3L/12T8+riFzbEstZ0vk4BCnN1NRy2IkgD013
	fgDbUh8U0UaFsnqMAsF+0ZzaPGBr7cB17Q6A5cIUAJ4CCKL5yq1vgLDZbIm/krAhGeTsBRnwMF/
	nAgbfY2l9davNzDosJ1qWYTBzCQgCjptj56eCz/iiufa1nQPwaG+ebj+51r2eokAeN+Ma9Dl/7Q
	o/79dfrtdKrS0YI3+og3u03614B/VlKlLplvyBf6Hz7B//QwgyQtf
X-Received: by 2002:a05:622a:92:b0:4b7:a3ab:18a2 with SMTP id d75a77b69052e-4c074077216mr107112241cf.80.1758438703101;
        Sun, 21 Sep 2025 00:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGE+iquID9CtGDF1u5RitQ56fz6/en/URLR2HsdrnpUd2qjrd2YPRUh6Fskh+nNLL0a2v1fw==
X-Received: by 2002:a05:622a:92:b0:4b7:a3ab:18a2 with SMTP id d75a77b69052e-4c074077216mr107112071cf.80.1758438702698;
        Sun, 21 Sep 2025 00:11:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:22 +0300
Subject: [PATCH 06/14] arm64: dts: qcom: sc8180x: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-6-9d93e64133ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=redOLez6fIriMFkILfbpGmysM+ObU6M5aEyNYaHbMJ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UhLoyQ3Ovuu/Qbux/PsUQfYHpQ1abVBKWV+
 6C6BOqhPZaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIQAKCRCLPIo+Aiko
 1c+hB/4t4JBT3AxjKLoi7p6fu0CQoY2QGTEZkcUCGxhNYnCsA1/AVjbVxsDUsXxxmH5roYT/p3T
 Z6tgaEDM5VyrgbEOJJfe5eR4pFpBDhmm/G9JZQx23boekUxsIrsVbWxWaZ5R2l6xv2eu4JUfKS6
 OiVGp4Q1ax3XsfIkeg30MTNoDGZFsBVMxt0pKis5QLVqcl1lLcdW2wimvu4rlUTdsxJ0EQ8aVC4
 fQlZF/4IfGX7VwWmtqe5GdK3J+nO4t7OF+jP6KTXwZUKcAXdiDevelMaBD7uyAtgufuf7It4wV9
 Y14P3iG4OS2Rwz9keY2zKD7fJKlCJ6cGXbbyyyzjWj/7/dpQ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX3ct7MRTZoCi1
 d+Zu09fMjxuyh8VodcgPOzcuOdjsVxaGKAD3txh5BfP0RxoY/wZWEe39EbrABZcM7z3U9sNkoIL
 KyqzPCqBctVqC1fLX9j0oAMDUaj9+QaD8TOgkTz51jSiLJHrsINtGT1IoolpCI5K3zvwamfwcmm
 0J1+qPZEk+RTEY/m3GbuuzjlKzAyiCHLgIkp/qKI4KuwCaeJDxM/KCJbyBktPtr2lNnunfAd2aR
 OjxzuQEhsiGuWGhZw4DoI3ORYZHs6UN+x3ADcedE1TvGRppfd2kgsMjrRNNeIYa77QjromhpbXS
 oV+d7B4BLlFAXJZeZkUJUj8lew4JxH/xIwweQRKlvz2Rh0IV1DWZz9eLhU2A7+7TT0hi1sIousF
 UiJvno/y
X-Proofpoint-ORIG-GUID: gQHINvJ5tpTJUxAOocyBqQ-cCro4asvT
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68cfa530 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=qPKPcSrW1Izi2Xt96l8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: gQHINvJ5tpTJUxAOocyBqQ-cCro4asvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Add the refgen regulator block and use it for the DSI controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 85c2afcb417def2be3d99026c7febd9f9db25da3..e3143a4a41c948cf4ddbf4b137a1323366566fdc 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2530,6 +2530,12 @@ usb_mp_hsphy1: phy@88e5000 {
 			status = "disabled";
 		};
 
+		refgen: regulator@88e7000 {
+			compatible = "qcom,sc8180x-refgen-regulator",
+				     "qcom,sdm845-refgen-regulator";
+			reg = <0x0 0x088e7000 0x0 0x60>;
+		};
+
 		usb_prim_qmpphy: phy@88e8000 {
 			compatible = "qcom,sc8180x-qmp-usb3-dp-phy";
 			reg = <0 0x088e8000 0 0x3000>;
@@ -3116,6 +3122,8 @@ mdss_dsi0: dsi@ae94000 {
 				phys = <&mdss_dsi0_phy>;
 				phy-names = "dsi";
 
+				refgen-supply = <&refgen>;
+
 				status = "disabled";
 
 				ports {
@@ -3203,6 +3211,8 @@ mdss_dsi1: dsi@ae96000 {
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
 
+				refgen-supply = <&refgen>;
+
 				status = "disabled";
 
 				ports {

-- 
2.47.3


