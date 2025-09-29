Return-Path: <linux-kernel+bounces-836377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13850BA984B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0363BB8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545233090D6;
	Mon, 29 Sep 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4z1hulg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE6309F1B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155443; cv=none; b=gCTpBAQryAb+LpoiX8mOdqhjtI2+xvbtzqjWJIcfI1rxmHotBjRKrOIQ50V6o/fSGNbhLq8cizSdHVegYp7+06mxH3GCjEXLPn99lKN1EasJesQRrlShFRbWwR6w5FaBT1GWCAuKYxqSWyGv/j/pMCh2EkB/aLZpB7OAt930vf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155443; c=relaxed/simple;
	bh=u5cNG2Ln2eATor8RQIMsdKn7Fix2w6G9k7RgS5STwA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJbpp7iHX3lEi+vWYXhRoxKu/cTto1yASfJgnhajftK6Yq0mwPWL+wOZZpf7+2wv2CgE07DpXTZ4IK/9/5c99lgNU9Oerq5+bIf9Q3vV5VPsyrl/fyHk+pswuQlmsEeiiaB+CMAr370O6J5582mx4yMLg+gJ6es0Ihc4D6RsyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4z1hulg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T9efLV024781
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLsnlOo21G1qIqIJj+gUab2xf+5Tsw86JCxBxDRSXCc=; b=b4z1hulgFMIiVNhh
	sRnUD7WvBq0y07Ftndun0zRDTpx2DT4ECPKw5oLThsFgFAuRj1OxU3LTwyzmqvyj
	m3WU5pL24J3XWwhkPJcDk0tl2DVmRhSN0eKGOikkCpGey6Dr7IVo3SpPtMyP+Knq
	vE8hkiKFJmK3ro8IxO9ffVtuI3vX6wQSNRvCpgVylLXON/Nxx+IdeFOFfOUzae4b
	lOoJaGiDENSNAjpoKDZ4odZQXi0eybdo7go8PI65f3VuLqZfApcysBn6HuVFbASC
	higlqmP1VMZwWLK7WxC+iwdUe+oYH/krtRHd2gmSxXyCFk7H1FcZsUyGFKD+Hq6e
	i3MXhA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fwkn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7821487d16bso3675933b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155438; x=1759760238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLsnlOo21G1qIqIJj+gUab2xf+5Tsw86JCxBxDRSXCc=;
        b=XG0G7mpCVdsqVXKI9GZCfF6e5urTdSiYhoygzUbWvkx9mz+VzaGayK8f25PoMxtUGc
         LEGghY5d6ncwflg+1IHKFRlN2Ho+8mkUfxTMWnnTgTpvM8gBoGX3XEzHINiEa01xMolZ
         744qkuf/SIfoUzBJlEOhRXQmVkncd12aZlxTNZYO28vrfNtHIdtAAaQyE3wD1UpvBWd5
         kD2ygyMf9GzFyWi6kjmohvwueIJ4VCEi3dBRTobVt9pRCLZ1wQBBbj+aL5QVLyoKs7K6
         OcU80mI8iQMykhvwqK0I5NYIfw4vFBFeZ5N1CbF0P1WeAcL0Bo/Y0zgUZGIasC1/w7fn
         aiIg==
X-Forwarded-Encrypted: i=1; AJvYcCXQWkiuxnN2TXFuXrLZGQFNyNULECkYSJUeDN4v+zp7LB6EjPIcD5a8aVadRAg9D6RfdS0BDyjbr2EBoeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYjbI5qcmHIkNyMWmRcCXhHOtinGzvt5sQKIKwEuAuEPrG1PH
	Evgjm0w13+z7Qa+fGpw9pxC1AUy19ZFzXXvBYLvGPVLQJwpobx65FyRHbVEirPDxUDNM91W4NfK
	hetkcJXPSKLkAgJ9llSeu8nx8UAoo6ohzaUtQ82OlzW/XFJgTSXN1KRdQwOqe2kOBBlfqlzXxZ6
	g=
X-Gm-Gg: ASbGnctIBOgSMUewVNdVuTbz97soRimciM6qIPxgjS8hOYC00+Ywuv4iua41e0IUXis
	aeOywdwnJ74itehz628EUALUkXx9ZJD8RE9zmNcFN2DeNE+Ra3Wj38GqkBko4aqQWVqw8gMUZZQ
	L+NH/oxnwhOt3r4cGrc+TVNWfICY2eAgf1bCnQnvMjGEyC7PVdN4RUa8X6yEcBF9b/Ch5p/txGm
	4GY+D+HG7hclXyj1z+w94tpRra6UFg6YMOlQadrSzg7vm5qnvLfm++lCMAhzxwChA+AWGmcdtmF
	IsTn/KYfUDSVtwCkH+QKWpUJ/DV+gpbfNh/pHndLzOAixyu1FXr23Gzmq14uEYnLHGRK/POQrSZ
	VoGa7ZsL/Nm8x8oWvXV1bWMiyX/BUu1acCRIrbvYMHkbKrdYoiLqmCr1cbmvw4RJRqa8Iay4hou
	U=
X-Received: by 2002:a05:6a00:3e13:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-780fcec2c91mr14412591b3a.16.1759155438205;
        Mon, 29 Sep 2025 07:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdlNnF6NRjps77bQpCKt1tqZP95RfthHoB22w6sWUcZesCEBU/V4oeksDuzvoGLvP9WKvBaA==
X-Received: by 2002:a05:6a00:3e13:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-780fcec2c91mr14412566b3a.16.1759155437676;
        Mon, 29 Sep 2025 07:17:17 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23a48sm11536334b3a.59.2025.09.29.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:17:17 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 19:47:08 +0530
Subject: [PATCH 2/2] soc: qcom: socinfo: add the missing entries to the
 smem image table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-image_crm-v1-2-e06530c42357@oss.qualcomm.com>
References: <20250929-image_crm-v1-0-e06530c42357@oss.qualcomm.com>
In-Reply-To: <20250929-image_crm-v1-0-e06530c42357@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155430; l=3539;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=u5cNG2Ln2eATor8RQIMsdKn7Fix2w6G9k7RgS5STwA0=;
 b=VQViHskVyyfYtK7gXmHv/Owxq+4rpwvx3SG0n9tp20YLge4pPhZwzTzieSYaTkuqeEESiBzLC
 ExHkGIPciDRCpAyY0UYDw52QHC963saR3G2wl3vz1wFMPUQtuGkEC5i
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da94ef cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6TZun6eQlh8SgxM3ATMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX125rKRp+0NPG
 2T3/ih3H9h+kKHGUeg3ZI7pGMmFcpoJvnXId1iTrGlsmZwGSPAsOVzI6NuY2TejEYMho8K4n7UH
 pn3V+DZ5Oh9Yd55Qk+c8bdrvVxNz43siftq5K0IXwuNztlIRZniMusRm/bnnOwU6XqOw+5Q7DEX
 oYvbJzVmWGZyH4TTc0quaCi9g12gNCC71BvCGOu9iCwkdLyRa4lAo0X3SYumtRSepl1KVAhxJtA
 3z7sP92Wl4czH2gvDy9z5fp3UwO+ed7jg4w90IpKxNffeirhioGH9YaQ/Et0UK5e3osggSygX3u
 89wC3BYBwy4Uay2wJ7piOgbLqzO86xlK+Y3Y9EB8uvy64Z4HfhV7G1RITlX7eWKjFrOIZKMWyqr
 M28oMQSl0W9Iat5DB0WcZiPb6ak+hg==
X-Proofpoint-GUID: 1kIXdzdhbJw3t-hD4et0pK7ubK7a3uea
X-Proofpoint-ORIG-GUID: 1kIXdzdhbJw3t-hD4et0pK7ubK7a3uea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

Add the missing entries to the SMEM image table to ensure completeness,
rather than adding support for one image at a time.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 8d25da4c7018452f463c6ff1e7ce605d5d0c6aab..5627fb6ffbdb23338ff5e26a05964a07439aeb56 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -37,7 +37,13 @@
  */
 #define SMEM_IMAGE_TABLE_BOOT_INDEX     0
 #define SMEM_IMAGE_TABLE_TZ_INDEX       1
+#define SMEM_IMAGE_TABLE_TZSECAPP_INDEX	2
 #define SMEM_IMAGE_TABLE_RPM_INDEX      3
+#define SMEM_IMAGE_TABLE_SDI_INDEX      4
+#define SMEM_IMAGE_TABLE_HYP_INDEX      5
+#define SMEM_IMAGE_TABLE_ADSP1_INDEX	6
+#define SMEM_IMAGE_TABLE_ADSP2_INDEX	7
+#define SMEM_IMAGE_TABLE_CDSP2_INDEX	8
 #define SMEM_IMAGE_TABLE_APPSBL_INDEX	9
 #define SMEM_IMAGE_TABLE_APPS_INDEX     10
 #define SMEM_IMAGE_TABLE_MPSS_INDEX     11
@@ -46,31 +52,59 @@
 #define SMEM_IMAGE_TABLE_VIDEO_INDEX    14
 #define SMEM_IMAGE_TABLE_DSPS_INDEX     15
 #define SMEM_IMAGE_TABLE_CDSP_INDEX     16
+#define SMEM_IMAGE_TABLE_NPU_INDEX	17
+#define SMEM_IMAGE_TABLE_WPSS_INDEX     18
 #define SMEM_IMAGE_TABLE_CDSP1_INDEX    19
 #define SMEM_IMAGE_TABLE_GPDSP_INDEX    20
 #define SMEM_IMAGE_TABLE_GPDSP1_INDEX   21
+#define SMEM_IMAGE_TABLE_SENSORPD_INDEX	22
+#define SMEM_IMAGE_TABLE_AUDIOPD_INDEX	23
+#define SMEM_IMAGE_TABLE_OEMPD_INDEX	24
+#define SMEM_IMAGE_TABLE_CHARGERPD_INDEX	25
+#define SMEM_IMAGE_TABLE_OISPD_INDEX	26
+#define SMEM_IMAGE_TABLE_SOCCP_INDEX	27
 #define SMEM_IMAGE_TABLE_TME_INDEX	28
+#define SMEM_IMAGE_TABLE_GEARVM_INDEX	29
+#define SMEM_IMAGE_TABLE_UEFI_INDEX	30
+#define SMEM_IMAGE_TABLE_CDSP3_INDEX	31
 #define SMEM_IMAGE_VERSION_TABLE       469
 
 /*
  * SMEM Image table names
  */
 static const char *const socinfo_image_names[] = {
+	[SMEM_IMAGE_TABLE_ADSP1_INDEX] = "adsp1",
+	[SMEM_IMAGE_TABLE_ADSP2_INDEX] = "adsp2",
 	[SMEM_IMAGE_TABLE_ADSP_INDEX] = "adsp",
 	[SMEM_IMAGE_TABLE_APPSBL_INDEX] = "appsbl",
 	[SMEM_IMAGE_TABLE_APPS_INDEX] = "apps",
+	[SMEM_IMAGE_TABLE_AUDIOPD_INDEX] = "audiopd",
 	[SMEM_IMAGE_TABLE_BOOT_INDEX] = "boot",
 	[SMEM_IMAGE_TABLE_CDSP1_INDEX] = "cdsp1",
+	[SMEM_IMAGE_TABLE_CDSP2_INDEX] = "cdsp2",
+	[SMEM_IMAGE_TABLE_CDSP3_INDEX] = "cdsp3",
 	[SMEM_IMAGE_TABLE_CDSP_INDEX] = "cdsp",
+	[SMEM_IMAGE_TABLE_CHARGERPD_INDEX] = "chargerpd",
 	[SMEM_IMAGE_TABLE_CNSS_INDEX] = "cnss",
 	[SMEM_IMAGE_TABLE_DSPS_INDEX] = "dsps",
+	[SMEM_IMAGE_TABLE_GEARVM_INDEX] = "gearvm",
 	[SMEM_IMAGE_TABLE_GPDSP1_INDEX] = "gpdsp1",
 	[SMEM_IMAGE_TABLE_GPDSP_INDEX] = "gpdsp",
+	[SMEM_IMAGE_TABLE_HYP_INDEX] = "hyp",
 	[SMEM_IMAGE_TABLE_MPSS_INDEX] = "mpss",
+	[SMEM_IMAGE_TABLE_NPU_INDEX] = "npu",
+	[SMEM_IMAGE_TABLE_OEMPD_INDEX] = "oempd",
+	[SMEM_IMAGE_TABLE_OISPD_INDEX] = "oispd",
 	[SMEM_IMAGE_TABLE_RPM_INDEX] = "rpm",
+	[SMEM_IMAGE_TABLE_SDI_INDEX] = "sdi",
+	[SMEM_IMAGE_TABLE_SENSORPD_INDEX] = "sensorpd",
+	[SMEM_IMAGE_TABLE_SOCCP_INDEX] = "soccp",
 	[SMEM_IMAGE_TABLE_TME_INDEX] = "tme",
 	[SMEM_IMAGE_TABLE_TZ_INDEX] = "tz",
+	[SMEM_IMAGE_TABLE_TZSECAPP_INDEX] = "tzsecapp",
+	[SMEM_IMAGE_TABLE_UEFI_INDEX] = "uefi",
 	[SMEM_IMAGE_TABLE_VIDEO_INDEX] = "video",
+	[SMEM_IMAGE_TABLE_WPSS_INDEX] = "wpss",
 };
 
 static const char *const pmic_models[] = {

-- 
2.34.1


