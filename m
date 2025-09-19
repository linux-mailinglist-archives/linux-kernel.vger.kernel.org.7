Return-Path: <linux-kernel+bounces-825173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406B3B8B2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD2A8282B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEA2D3A68;
	Fri, 19 Sep 2025 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VaJ8arMt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF72D3217
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312063; cv=none; b=RZfXMm3IJ33OyT/sFtF7wxMGQQvtsKDVdCrH3DM8WSGcAgrbcvMRXXo5WJo79+wFfknTI7kDLHqwcjQBzvRdZ7C+6PJdln3lclo7ansyyLsD/Kd4Cj3aVHrb0lFZ0gPNwqK8o64BziQHsol/oreBc5FkuSlkmguPVO1SzT8W85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312063; c=relaxed/simple;
	bh=/aCT6AMn+DEBAszM+FafwAQnaRRZOfmB16zLDUBpxGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLmAuoySpRAZk1sL+yuP0Vfn/CScVGyHWm0K/fXFolEj71YvLpisnd/ROgbpwIWdmRzyl+5HPraiOF2u7mbQ4b0OiABflV416I2H/HYDoT9ep5ssjQi0/2R3sJ2d/wymQXAnMDJ7a+iaqk9fKeRlHE33NjSq/z2lvr4MV7pWnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VaJ8arMt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDxXb5017023
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K94gZNJCyxLLjXcq/8C3d4M0HAtuU0U9u9rzRHmSpBg=; b=VaJ8arMt0sXK/vvc
	WuySYrcuoPxGJJCb1R1P0X1NmCc3yuBq49+DLeO0euViY2TQBRYRQw7k850Xy2i3
	rOFs13rCv/2ZagvX0IgUtUgieuotIPAibSqEF+F9KFTNt4BPjLwK59da5mDtH5iU
	8sMcAG0A6WrXS+wOJm+3WpRJ3Ehwot2dT7euNYxUXlBsTjkSzxuK+BV8MfbvXTjb
	uOr6QZ3+NPOVP5KiKw93SYHUy7BQPAWxW9SDFyozD9+SLWJt4Jz41XXPbSpqXWT6
	RLz3wv56yjSD9k8QnuY0mjlt9beP99935OBs0YlYHGlzNAfjMQCUux0JjX9xZGsR
	x6j1FQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982degapa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:00:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ced7cfa07so24696625ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312058; x=1758916858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K94gZNJCyxLLjXcq/8C3d4M0HAtuU0U9u9rzRHmSpBg=;
        b=MOUnUn27c4oNB5y7PT8ESv6mmV7esnE7LlfBpdWrm3V5j+vyf0fGr/UH0lkD0+sINj
         vETXk8L1RYd5AbJeFQ7E5hb9xP+9SVk/yl2//5SMoqmJBnOf+jD9NQe8j9mdv9p9lfFp
         7De702EHaHi/TILcEbBBGHhQzKf+VEpT+c2RLqwlvhHpjO65L1CQ0lGYfXFwn1nkZltZ
         mMjBnpaEvnPn/rHzc5UA9o0x3AHKSAwfiVmllx2fUlgdylV8HeNuQlGQnhuzrVJPjopU
         5BgQ5GF1pMhirLEXcYdkUxxX02UgstMkdAShnNe9nzxLxaDNAk40Oc6wKV3r99sP+rkW
         aZPQ==
X-Gm-Message-State: AOJu0YwVbWQ+XCyFi0Sgj6XwB0iB4jAiVrZxW+UDZoOSHj0WwlAFhyop
	D+YP27bnQl7FSXiUtStJKkdzTD+x/b7MINXfj5Ka2eXB7mpXefjSTMTNEDw4Q2jh3u5rm/i/uke
	lJgXZ8MTaWZJGfGUhB2yeClpxv/a4RYxT4aIleEJUUQeN4CrpiwgaKBADClQdiiYhJmsJMtqFLd
	k=
X-Gm-Gg: ASbGnct/29CTkFUHsy8zXlDTo7A1+yBBgAJClU5s+upkROqPzz0a+W6MBRzRcZ5XByC
	7hB83/7DZmp4iqhGhMGecDT0v6Z2bCGzCUGNsju3lkS7D6b/iNryfWixnxuad19qlYX5Z1hs9Hh
	I2OIVSwCQhZ4/FkQgWOlBqgow4JivczDx3G/3Y6l/AnweM91pUJOFeEWviI81i2TQvJeUKNIL2p
	zxeHOuNR58LMa7mYtdNadnInJk0hUx6Ftb3BI4YGtCQonzxlAXqrBG9zCfTLsGJi7luGl4/2iM1
	qDRSuSrKnBfVRV+iYvmXh7zNP2Yav4mmwU36L7FkXU23BuBS0BhZSYeqJD+PcgNHAQgpE2qYRIy
	p3UQIN5ezfz/fgD4UUOzR9ZWwPQ==
X-Received: by 2002:a17:903:2ace:b0:26c:bcb5:1573 with SMTP id d9443c01a7336-26cbcb51803mr27453845ad.53.1758312057967;
        Fri, 19 Sep 2025 13:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqRMuKYms0JN+AnMSRPMr6bwLIE6pahTEbvacteRwGgkGEd+6lWHLIQ8iRIIeo2zWClmYa9Q==
X-Received: by 2002:a17:903:2ace:b0:26c:bcb5:1573 with SMTP id d9443c01a7336-26cbcb51803mr27453585ad.53.1758312057420;
        Fri, 19 Sep 2025 13:00:57 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030ee20sm63053905ad.109.2025.09.19.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 13:00:57 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Sat, 20 Sep 2025 01:30:11 +0530
Subject: [PATCH 3/3] pinctrl: qcom: spmi-gpio: add support for {LV_VIN2,
 MV_VIN3}_CLK subtypes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-glymur-spmi-v8-gpio-driver-v1-3-23df93b7818a@oss.qualcomm.com>
References: <20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com>
In-Reply-To: <20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758312044; l=1502;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=CiPyfA3fDFL/yWTIk0JCWKj4mCCnWYx7OMCyiFzL4yM=;
 b=vo+kuP/Xa2OvNsoMoxwqxQFsPysvdPfhVd51JJgJuNtTZukkJyMaY/f1cuqegwm6AyIdjsir8
 UXFGdIxN1wQB/CjSgADfVbjao/uan0KuM/qJ2gFdrRmCMofjXkol4xT
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cdb67b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_LkKalIgBaL7gH2Y5XQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pL-4DJ8YhOTh4W958-FSrmXeCKyPQMEs
X-Proofpoint-ORIG-GUID: pL-4DJ8YhOTh4W958-FSrmXeCKyPQMEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX0vKOvXK9PsC2
 PzVYhEemTtggTTZTktSt/WuXjYvH7JWOJMRkdqhAIXsZcMpzuAtdLcT5XPrWh98VViYxb0Ppuyv
 ViW5Y9Qkn1l4nlvD1BqUA3+JzDp5/dGrnXRhU67LDBp+Nz47slABmFo04E6jI9OUoq4bGMhiiTD
 648xZgaDvMre4Q0oOE1SXlb8qpA4mZYcDwmS7utUxE+qv/ykwS1OoDqBZY+oFdIJWnHmHnwzGbW
 E9s/vSLWQbUZGB4+dI3SVskH9QCaU0zCIrGVEtHk8CBGPKUgwn/AGXdv0mHV3dedx78VQf27yU/
 jujSrXk0yl2u35ufwX10hXSx0E+SULEKbtQFX6fpuRXUrl7wHsAidfik+rHSqPy+NVcycr7D0Tz
 Vy6l0DnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

From: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>

Add support for SPMI PMIC GPIO subtypes GPIO_LV_VIN2_CLK and
GPIO_MV_VIN3_CLK.

Signed-off-by: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index c4f7d2d7a017684cd9c0d0850cb8d998668b543e..83f940fe30b26ae06373860616c54955c3b2253e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -42,6 +42,8 @@
 #define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
 #define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
 #define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
+#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK	0x14
+#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK	0x15
 
 #define PMIC_MPP_REG_RT_STS			0x10
 #define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
@@ -852,11 +854,13 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
 		pad->lv_mv_type = true;
 		break;
 	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
+	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2_CLK:
 		pad->num_sources = 2;
 		pad->have_buffer = true;
 		pad->lv_mv_type = true;
 		break;
 	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
+	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3_CLK:
 		pad->num_sources = 3;
 		pad->have_buffer = true;
 		pad->lv_mv_type = true;

-- 
2.25.1


