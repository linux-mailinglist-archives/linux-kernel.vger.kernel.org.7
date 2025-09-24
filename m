Return-Path: <linux-kernel+bounces-830941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FA4B9AF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F029017D6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F931985E;
	Wed, 24 Sep 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AV8ih3+5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91440314A8F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733290; cv=none; b=E2OkB60Sthme9/28wYruR64rbAMqNuKCmy2sfXI67OZHpJFIn9EP8bb7jsOpXLddA/U+X8j5djCYTurOJIRAybcO2qLZdZhIwn7UUSzGJKMnxWrLLitcSnHr9imUpah10Wh/JqR0vFOlhBev4NGjp+xss5c4xRQ9iZg+Sf8LBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733290; c=relaxed/simple;
	bh=/aCT6AMn+DEBAszM+FafwAQnaRRZOfmB16zLDUBpxGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INUtSIgRPmCiXGm9Mt95BCI8OdO5Ro7MlfvEB01yCuEuCJjECxzrODCB5IG+ZYAEaKCqptRiEFS4Zs+yIumjr+DTjCFomyUeShg9OOCO0w3dykwnry4Xy/PezovSV6wGYddh1kqu5g39pi/bKPm1dXshA8m/qKUjmPGFhmkrF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AV8ih3+5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODM0Ag001948
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K94gZNJCyxLLjXcq/8C3d4M0HAtuU0U9u9rzRHmSpBg=; b=AV8ih3+5L5ShgFEc
	jUQGbPgQa+3ZTHZZxtWe6quQixGcAFzPPFavPQMm3mlsCARdaDH67ZZqlYX/oMwL
	G5lnvzOyXrG68n1IB1RKWqkwY1yW+k8hv0eEzLRW0MdMbF5osbGmeqhbAAS6B03R
	vrD4+3VqRTbaKZE+cumWdYZ50GyAXTVay0QHazHCRzVFOrvPER8QEofSXiEO+cOe
	0yq1uaKmEXM3JZkwY+Ctv5PtGvDUDmz6L7o4oH4GwNZ1xWjQJceLKvMJA7WUIkmF
	MqNMt0RcFoungbnUt2IQwXOa3+c1ufWWWG/ZGD++TdNu9oaRVRdv7Zo7z1cmep5+
	X7Jjzw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98n4gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3304def7909so47215a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733286; x=1759338086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K94gZNJCyxLLjXcq/8C3d4M0HAtuU0U9u9rzRHmSpBg=;
        b=SuLOAm9dbEp6U9gh0nlWptVoftfEzR4qLpEDbQjj6y8CswJkAiJ45diuLRwpfLgLt0
         xYFYrHExUHqe3f2Fs/98h0xEf1FnGWwagl1KODwkV3egZE+9A7MfZnVdoJY3E/AwMzI5
         U7VaxUBlStsnETooT009ZKRu4D3oes7Kpu4ubafi0Uyu6jTZqQErMzUOjuXBvltji4SW
         hXSbrYiiD7tJ/6gCmY8MVzeRYmA1NteTgpuK0KtuyQdF3nQTc2yK8EUAKAYPcPJQQGZJ
         7rueKKQbk6bAdewNZsNroA0/NiqkTLVtanOz9odT9VeldnB1yKR23880QeFBzS9bfkPf
         rOwA==
X-Forwarded-Encrypted: i=1; AJvYcCXvYdVW92bJqS7ui9AGzodKVsQ9fS9Nv0XvmvUJ5JNjtXiPqCVk3JwClV9e5Y1KguDFZyLw8FDkM1ODlbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5to0M8gSd2ZCUJutNI+M4O52Gu2FcjOWVcC0VKTtnr5mAA1NN
	4YqGMqDin7zlHv55vNBApe6qKU8nO9RK7GY6o0nvtWo3Jajy1kcEcuXBaBjK9BeeC+j0lokUybI
	z/Lbw619OhovBn5CeusvXskGSOtl4dQcrq6Sh/twJp451zC/fsdzqWN9+18m8ppWTjd4=
X-Gm-Gg: ASbGnctUIFZJW4MBXgqMVLAIBtZQtnHOCFys2fkzj+AXFI1nZIfoZaGVatbq50BhPSf
	pE/3T+zO5k8NAB+E3bXfnYxq+W52tRP0w/NFWhhyu9BcuGB+F22HWWTlStxxMBYyM91SHe6Hw9u
	vlEK5zqgY2b6i2/8nWRbGFGz0xHIUNBBDKpk/wyuG2zbBvfRbybXARpDH/Z6i0nYS19FZDCFzft
	SBdxof5AlNA3Nej+yPvzmMxF/L8Sypyj5q4OARK0PsYZOlftKhkqnXLZOu2HN4u9A/zJJ4kw+Sm
	mry17IL5Zx0miG9l2lJS835lfoLslAF+pY9Lifb7MWVQLyzTYiIIVyb5mymeeYc0u3NsRxmlQYK
	RXhyQEG7qJM+UJ8pS9MENpxBVNQ==
X-Received: by 2002:a17:90a:e710:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-3342a22beffmr419192a91.11.1758733286225;
        Wed, 24 Sep 2025 10:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAPpvCtd2d4vHGdIUOkRx6YtnUHb9m7wAZMK8a3e7Ta2Wt0f3XAL5MqaTZbYyUtxqvTDCxvA==
X-Received: by 2002:a17:90a:e710:b0:32e:ae12:9d32 with SMTP id 98e67ed59e1d1-3342a22beffmr419079a91.11.1758733285177;
        Wed, 24 Sep 2025 10:01:25 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda09a0sm2931299a91.9.2025.09.24.10.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:01:24 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 22:31:04 +0530
Subject: [PATCH v2 3/3] pinctrl: qcom: spmi-gpio: add support for {LV_VIN2,
 MV_VIN3}_CLK subtypes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-glymur-pinctrl-driver-v2-3-11bef014a778@oss.qualcomm.com>
References: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
In-Reply-To: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758733268; l=1502;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=CiPyfA3fDFL/yWTIk0JCWKj4mCCnWYx7OMCyiFzL4yM=;
 b=yJgfH64tWhhT/hfvUAVVym082LRueDGJbwARlk+JMQ/+MvtcmVuU3ceW9zhTTlBdRjWihOkjk
 Zkg/C8RHR2sBI20u8IGUaN2S8Wlxpsmcl9tgbhTfgYtEl17X30J6CgV
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: 4idrrp9ZTb_moKN-X1OD2A7ZvDYNtLU2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX8oCQBe572kw3
 eqoCgHiwjdJJWWc7o5ckzVOdB+A3yPr8+CucKftpdlEC7d7ZyrxK3kM03Us2aO6gWUauSL6ni+6
 aTck76BT8bVkg58nhjHQkKH3LBZK6QZ9k4lBd3j/OdK6cz+7GqItr6U4XXoBbYfiroHULMXQmb5
 VA1KYgYgGSh7JlB8p+BMfj22y8K8yaL35HMExuZpNmbLxH8cOGefzr+cztH3m0DGMHDFMPX1HS0
 FchSDeY0bkHw9ttzVUzzDuWZqg0NNfLsfOIecD1EKph4BuA2Dk+8ZOTBhCY6S+SMqVizvJ+L5qD
 j/rlaTmkaAB0IbWoGrCPOkP0sjrRuXDdS9G7F6cONwje850RMc8P5EsNX6bEIwL/UmsTwytHDM7
 kymcJcVE
X-Proofpoint-ORIG-GUID: 4idrrp9ZTb_moKN-X1OD2A7ZvDYNtLU2
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d423e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_LkKalIgBaL7gH2Y5XQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

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


