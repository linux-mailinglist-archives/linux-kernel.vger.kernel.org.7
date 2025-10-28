Return-Path: <linux-kernel+bounces-874680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF5C16D84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4C74F27A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE7350D7D;
	Tue, 28 Oct 2025 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2yBx+Q7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJmqdRHS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A2350D48
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685212; cv=none; b=QDVcnxbNlWeTOVUKIUIchc2osHGBVzLn61qUPTcOfBqZ4/8iuiHqeK5M67cII2GZusW7Nd6XmsuMxWoxhLNZ1t8GLQBEkOv0P2TkSgu4xR1HFVgg7xe0DMUmlxJ5LIZIrAelrR30qnnouH+9ze0OhRo2HdO3fWf0MoaRyDoygOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685212; c=relaxed/simple;
	bh=3J4fuWFWNFHF+/rRsGFk3aPO2J9M1d/P9hBhGCblRCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NijKgARAlG7fj+qmnKCSzshO/RFZg4KYdKVyTZ5IdXo7XpgFTaYZ0ZkMcYy4HYzD8ImeF2Z8aeCnJHq9RoIjDRlu9dzqTXhivrtq/8sL130sk2xzGHWSU0LIdYwO8gJzpeFcX8KUjfjsvv47151oXN5hjLDNX+vWrdViWapdDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2yBx+Q7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJmqdRHS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJloAM2554715
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X/ZmLcOwVTgqaHSdIV+9fQF703khVD2MDhcprQ9yZUE=; b=Z2yBx+Q7wRguamtw
	tLSEDlVaJ4Nn3RiQa+nu+M9884n9V2y8elw8LvBoDdWMc7rTAs6R5xMxFT44jCJ6
	DBScgdSdseea90U1+DgkZnoIC/wXDSQbYLN6bkzSy/CxjD9llhGALK0dTrbIj1dg
	eAuuT16LY6kKNT5jX5bv5NiV7V4BWrdSzvLS0SALvDHn3PmV/DhS3XWVwra0xh0n
	YvSx0l8pcmW0UT2o/CIYpB6NEdnGXGS11Ct8CLbjms6Xy0/Zng2Pz5vJwNlM0DY/
	jodQGv83YuTIuWIY/kmhnm2sVUUAdtDUFdTbeoSKGvhnNjyoHYBGNaer/sIUunOl
	fWJZQw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a105um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88947a773so327645411cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761685209; x=1762290009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/ZmLcOwVTgqaHSdIV+9fQF703khVD2MDhcprQ9yZUE=;
        b=GJmqdRHSL1iGq4MqWyZKgDAOrpQPrUO0utBZ0KVqWyDAeDtFWKMuqvYd4YIcOsEIG5
         BGv9S1S3jVEyzcYPF/ckmf2Rs3ggzlSdSBFZwFTcytOdTSrJNrIdLvma6SNV5YOlnm3N
         QAnJn7Komzti9rfAUwVyyPZPchSUXGdRhgceMs5aJNLk4/fFS/Xsu7qSm7hocYpbi68g
         8EuRznnzZ5iu6BXvjAl05f4IrjZ6S5bcZYmkG0UXsKu459o7AYpKAPGZuufe1H7RCpzw
         r1NbuIwahA6S2unD1oNZHgv7qxshPf7W9GmasdGh2fq0uZS/vN4Z39zFBUNJXDlmXCyL
         vL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685209; x=1762290009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/ZmLcOwVTgqaHSdIV+9fQF703khVD2MDhcprQ9yZUE=;
        b=S5dYCO/Zhh0q6C0qE9SIc/3imSXUN6JSBjc9lQTHJaQ/iKekRUyDiAo7ZWwPV/04zJ
         mZeVeBMFz+Wqmrsog4N/eL/ap4KpU1wQn/RtSHXDkrOLyKT2W2ohjaTliU1ekx9KetG0
         eH28iWe/F0IxKnPhlxZ82QgCP7ZbjdwChQP6ytt1xzMFQoEqGqLKVvL5PYFhDH9UX6wp
         Jn5sgJlPuRn8VwM/2WsQ9kp2uD1IimpMpm3tEz0lq4APUAYJfQ/B4UQnFBXcUtgvyG+o
         9aw9UW6ZcYdjWBjCswoRqGzacmYO0j1URVSIxm174v12zP8ky/yd6qI9h+ojPLTFhjT0
         6ELw==
X-Forwarded-Encrypted: i=1; AJvYcCUW4tjJXhm/FdhW7fdpUjLcmy9JqdrjCk1CeoZR+sxPgKZH2bdRvJNrOJBeAtPf9ccG5nUbl6rZvLF6Hls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4/ZP4/Rx+l6+FZpjFNYCtS/U6rOZDojJIzFrY+whZCXXXXJz
	5G/0CWkvrohmh8f8F5SnXa1rd25sXOyLcxtS4Q34dst8MGVsX2YOzI63Gso4GEc8OmAqeHV5P1c
	NNAOOsdOQq4ph9zRnfs/3XHYKRoxqmdYUSDoxY53AUMjrFBXENv+KCkb1kxG8zETxX90=
X-Gm-Gg: ASbGncukmyLzDUDxqTL+KJS39gkn0LyG+aCDuvW6yUkRh6DWz/ppbtE+ozfZMkVntoD
	xD3uKIvAPy62hpC3kr5+92fzXiuqEV4VrjhD4dfxOMh9A4eFQ0qhdnJ22fCeUGt8Yn7YSuH4FJ6
	udhK2UHTuMVTkHcHA6uiElC0DMZxY/SavU2ON/M/KWPqOUO9f8sxbChAHNUMJK8YcAhD5LBuD6p
	k7LuAKLpfRtdOpiJqvfLd2zE/ApwrCCTzwhAWYiX7VN2uH1X3zSko4ZMn6txZCnOKLICLfv5VES
	t5xvYiDnelFlNYz598UPqwkDxFRK0Nft2GZl+Q+h9iveSQtiixj2DD0+Ym2jLLgtbsDNTojAGyB
	4FLuiyEaM3C4YWwCuTey4iLzlLNXUnj5SngfwVaCMvF412E4+7CGSq+ZT4ab0IrK9WXsub5eVxi
	MyP6Zd4+je3spz
X-Received: by 2002:ac8:7c4e:0:b0:4ec:f153:3562 with SMTP id d75a77b69052e-4ed15c25099mr8921941cf.59.1761685208849;
        Tue, 28 Oct 2025 14:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMgeUM17c43Y/LSCQhwCKsld4n6+veGLuBUG+V9ycQJnaLhlctI2mmo8Lbs8gVqJ341PGRaw==
X-Received: by 2002:ac8:7c4e:0:b0:4ec:f153:3562 with SMTP id d75a77b69052e-4ed15c25099mr8921401cf.59.1761685208279;
        Tue, 28 Oct 2025 14:00:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f861f5sm3283594e87.107.2025.10.28.14.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:00:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 23:00:01 +0200
Subject: [PATCH 2/7] arm64: dts: qcom: sdm845: create common zap-shader
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-dt-zap-shader-v1-2-7eccb823b986@oss.qualcomm.com>
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
In-Reply-To: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7067;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3J4fuWFWNFHF+/rRsGFk3aPO2J9M1d/P9hBhGCblRCo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAS7Tl8ITmL35JNCMCtV6n4AFSMLyfrI2M7nro
 OHEUVN9sSCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQEu0wAKCRCLPIo+Aiko
 1a0SB/40PMJmUG68LWQzfUD/Vz0jZg50JoQE5QYYEidxNPNiVxwjfQ+7GAjOdu5qj6FduR1L4i7
 +LKxsBCJ00JTTPM+s2ZPAZBtSq93yTSmkGinT24m+vySDSMnOOtT8nWvHILDH7ShMR/K54ZJmeg
 mlzfuBjmCeh70372FcgmEYZdShCDGdvXMrhwe6y2XffHOdr52GMMCYM8kkQTFzTziazNtJDpaE7
 5xNzR5d05sPK77r54JJLLuVfZmRNx1fn1VGKP6+nd6v9ZgHe+YyZk5TtSA8HmOptzhIRRcQnZAA
 z52k31JYI1PYjB8oY/ugO7f9Q0ZIbo7/JTUgKzyKECw4KAQ9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE3NiBTYWx0ZWRfXw7NYJCaQQhpk
 7wCuYnnLL5bvj5dw7labZQdAW/W9fVT72dGBnG5huC3s4QL3MWcFUDIQ0MomNmklkra34n0ZiG9
 QQwSd2CQUuXz1Pu1RnjvABzujL1//H0sHkTXmlah/GZKEzLuEqDXvnMfEchwCZcfKi1qZVOnhac
 C9xRMN4SDg/qGZ7H918yJ2NQxN4fjYsTCXqDdxip/bv+gerbCrK6nZwPf/P+Dx2Mhbk8j/Sq3FW
 CogISWfjZ+pDHnrYiij8VH7OwvzQV1qlQM4Sg0/+A0mR/G8qviEUxxQrYGvXHetrY/zL2b0jFBa
 1s8Es7Krj88o6Gj8wcWc/Kt6j4016InHCK44eMAkj7pAl7Ly6Ze8Xys7q7fU64c0F412C53BXcD
 izWyzTMnjMWuka1gRKOvd2NoTJfjew==
X-Proofpoint-ORIG-GUID: xIB4Dp7HjzwP3_LhIFWAXxT8lPM4NfBj
X-Authority-Analysis: v=2.4 cv=EKULElZC c=1 sm=1 tr=0 ts=69012eda cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YgUc9-wyc0V7V68UJQQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: xIB4Dp7HjzwP3_LhIFWAXxT8lPM4NfBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280176

In order to reduce duplication, move common GPU memory configuration
from individual board files to sdm845.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                   | 1 -
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi               | 4 ----
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                      | 1 -
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi          | 1 -
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts      | 1 -
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts            | 1 -
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi        | 1 -
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 1 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi                         | 4 ++++
 arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts   | 1 -
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 1 -
 12 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 8abf3e909502f3c3b82c0ca3d7509fdaf23d882c..662722adf20b7d1b6a44a28ba3bbf6b3e373cd0d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -456,7 +456,6 @@ &gpi_dma1 {
 &gpu {
 	status = "okay";
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 83b98bad19dd2824650378da7ad02e6f41a68d9f..0ee2f4b99fbdb6bd8019187dbfab5f9977c8973f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -456,10 +456,6 @@ &gcc {
 
 &gpu {
 	status = "okay";
-
-	zap-shader {
-		memory-region = <&gpu_mem>;
-	};
 };
 
 &ipa {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 63d2993536ade229a84da16e811e8bc83c46bd15..971bdb9c3693bfafab820a5242a82874340b6c4f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -418,7 +418,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index eb708ebdb0202c7e453bd01124166dd050de8d28..3fe71adf1dbb0f05fc4aa0d0bf4d0c6bf14af6e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -341,7 +341,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/oneplus6/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 493c69e9917461600b2400b6dde78443342139c8..45e9dda007cec2500bf5b6990e7d8b1ba56a67c6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -253,7 +253,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/starqltechn/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index f0ae0159f32a05edc376007d1d792e70a51a0db5..238471267e1feace68487aa25f97748704ebb18c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -425,7 +425,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/axolotl/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index f3f4c0900572a85ec173539f09074ae9c1025591..f3ff0b3352bcf7c3eccf7ebe615cd2e40cee7847 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -428,7 +428,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/Sony/tama/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 7480c8d7ac5b7f84a742dc6c77943c547c49fafb..5b30ace99579d014d762865377d5e9fdd5bab371 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -248,7 +248,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 1c50a0563bc4728e67fa2dca76bdb6a503ebf102..26f0900513169368ecfb65b01eedcaf1050e3f53 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -394,7 +394,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm845/polaris/a630_zap.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1c3a7371a2d371f78e13a5b0bc400f79c62d210b..8c90f652afff25a0860ae993e713f94dc9b39f00 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4902,6 +4902,10 @@ gpu: gpu@5000000 {
 
 			status = "disabled";
 
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
index 117cc0133363bfb6ab1118312ab6be7f797a203b..57afb35770058b84c592db9f20e82ebb7c4f8374 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
@@ -490,7 +490,6 @@ &gpu {
 	status = "okay";
 
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm850/HUAWEI/AL09/qcdxkmsuc850.mbn";
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 90efbb7e3799b9aa75ac4df84fe0006d470ae131..35121cbcd37b08029d3e1a12b99fca44f3e4846d 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -358,7 +358,6 @@ &gcc {
 &gpu {
 	status = "okay";
 	zap-shader {
-		memory-region = <&gpu_mem>;
 		firmware-name = "qcom/sdm850/LENOVO/81JL/qcdxkmsuc850.mbn";
 	};
 };

-- 
2.47.3


