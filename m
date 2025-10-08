Return-Path: <linux-kernel+bounces-845024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A2BC34ED
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE0D4F1BE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9E2BEFE5;
	Wed,  8 Oct 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBD9u0+x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9291F462D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897997; cv=none; b=HQSFFv2+OF+FeJ5leHDgDlIU/L9Dwf6bL0GQ1Gm4YyVwjAZU/PMyc9QtojKp0Cgd2LYTl7b3PJydGgWTkQdzucES+2wxUDeyL4awRadzec7pOADEiLpj4/ehsC6pmrrX7xgDa7KSCcrs+oguV5Z1iRvKo1/t4735WGYQ+C/7+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897997; c=relaxed/simple;
	bh=WVcPThemHWksAIsVmW4eiiuZ9R/8dpiWBdZgPjKT5Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tl7MLtCkgrRoUTb20gTgglKlL+NRjMqB7jFRKw4aFT2M/DV0PK+odI+nkxO6kaIaOBWLHLV9PL+5ukHTbqGlK7yCFesaMpSlNX/FpB7S1bpjokXbBKd2wCwZkP/Uc8sYWBktT5/vp5B+0RTcvY+1Yrp/tDkqEBxl+LtElFAXmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IBD9u0+x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803XaN028187
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 04:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b3OkFKObasZHkBNUAbv6zxDXDlDmudDhGXc/cgtgK+Q=; b=IBD9u0+xBNhe4wvp
	ZILif3/oM9hWGm+ZwgyycymadCh6GdVbxfqkK5DYy4XNXg7C+wVTpyBEWQ7VjheX
	ikLeJdVhMOR/cR9j5XMs6XS4DCiTQ50x1dqqM7YRYkhiXTLMVHVcTgMXSXN6LRdF
	giYmHrXH5pC9f0sWP7ZRP09rGW1GQr0CJ8/SrBQgvAHhZ0sFvMFaNnLA9OFgQKVO
	G2eyUkxHHQNHpn4md8lqzRyoCx97/BptBpkIQqK6b9lx7nEhx1hhp2ieCipgN+oh
	4GnFmrDgtQE6ouYJYT60C0PdVw5yq7EZl4nhx/aZkd3eFlyrDkbzzo5NFbNO3+Yd
	enZc3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wkssm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:33:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-79390b83c48so141471136d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897993; x=1760502793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3OkFKObasZHkBNUAbv6zxDXDlDmudDhGXc/cgtgK+Q=;
        b=fZVjJwnNzHVY7zCfgLHEudtPpSaKCEAtNnOXIcsv6PyhXtZM1HlHEx2Pp98vMDMXP+
         E8ixPXPIUrFRu+53ex/f1ye7v4gNPkj7poQEGt407Cix0IePYshoIWl6it1X0eiKD/xm
         saOdO3If2t45EwI11JxaKg/AZWsSyqukm3fjVBc/HhraSYMZI9KAmdXYL66C0cGWPRIm
         8uxBlS7zWNflByvjDJIJ6wfjJ6Z49sihMW1zRLQE+ZKi09Lwd0xZEhS/uKcJwWwuyM9H
         pKSbkx7cKCFKIDhj3KUsTPJcgMq5WK7ode0JA5rRWymeeWVTd0F8WNSpYIpGC8DXgvx1
         wkLg==
X-Forwarded-Encrypted: i=1; AJvYcCWtQFxtCYS0cTN5LypSwhtV+zw5XeDei4/fHTgD1gIt88kkpNsyG7FKAuvCBBt39b/e1We5rj5Ob5ad4vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNT/zP4JnRAWmy+8tsOf9QEx91paJEkn2sis1IgQE0sGtkfp7
	RLp+tEA0PMsKwXqGjkupjgfBxYVI8/WWhqZ6hcqJVMx5zyiiPEyAX0OrhI29ocigIFhvo28E46t
	Vk2fS6+axJl1d6x1tEaJq1idpWHy1nOIqC9rEhlcH6b8fCx5v4fZrmDpGyCDZpkS3BegbGyc2uw
	E=
X-Gm-Gg: ASbGncsJowlZ3V9yqfzc72/rNKsUpdE3waeY+uKQmT+TXf6PFyOSTE5TQ6jUM9m4pW2
	JtDHc7EUdM5abxvToLN07StRFcvmNvr173EsziJHbZZg2aBa/v9OUKmz2Q94swXRz117jl8amfe
	x0EY4tCh7ll5S0d9G0MPFVN/ifjrOy+l4zB+A+2buqsk5GNVRYa8pR1U+b5VjHyExMntxvleahF
	SoIQkthW8m6Ymn6SA2oXNUCFzqgN8akfYdd35fEyePa9ZVAnOdDGAQ0udmlJOM54BB+P9dXB294
	Ku+Jh00OtFAr7LpGTjw5NaVRIQ0gxRPeIY/kCw9DsycUhsXuqjgFx01bdFDYSLoZiKDxVPM7xNu
	UpRui81BC5ZzvUprcnBvs69WHEwjOn/dEbE8p2C0mC1ehu67E/wao1ppIhw==
X-Received: by 2002:a05:6214:202b:b0:786:50ca:73dd with SMTP id 6a1803df08f44-87b2ef6dec8mr25060646d6.46.1759897992969;
        Tue, 07 Oct 2025 21:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5fSQzUEHlM9Sba1DnS9w73buYjBeWNYucwN0HTAHf5h2O3699qv7BAQEh0X1/W8ikiBVw7A==
X-Received: by 2002:a05:6214:202b:b0:786:50ca:73dd with SMTP id 6a1803df08f44-87b2ef6dec8mr25060406d6.46.1759897992532;
        Tue, 07 Oct 2025 21:33:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119f461sm6751107e87.107.2025.10.07.21.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:33:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 08 Oct 2025 07:32:59 +0300
Subject: [PATCH 1/8] media: iris: turn platform caps into constants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-iris-sc7280-v1-1-def050ba5e1f@oss.qualcomm.com>
References: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
In-Reply-To: <20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4833;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WVcPThemHWksAIsVmW4eiiuZ9R/8dpiWBdZgPjKT5Nc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo5emCPIOQmXOHe3H3umhVm6Pti8BcuSKftq32V
 7ZuzDrWEK6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOXpggAKCRCLPIo+Aiko
 1XuaB/oDRU5WDHN8I/Bco1ROv4ItfONcJkCZrGXR5Cl5LQl41bTyqOPKoekOgMKAnqFdZEYIXWp
 s03Of28XCTBbvMd1DxcvRusj540BikKox+2CHaH+V7L3cKFTRecdvCqZ5rH2Ujo7uVJJJi+AAY9
 9EmwCSXy3ivSS9vu5P2dleCoO66XkKaFw1b8jJxKhMm/Fmrx2bx1nA7zYYLsn+g08AqDLWyYc1i
 Ib6Sgi3T+72U3j3O9oNrhB3TVihzTnHWQwLyhot6KHkMI1r3n+b6+JaIyM5xImUYEzFD9xbGEgN
 rDa1mcdswSYVXzVDlRAz+mXNSIUkjJscqfgImPcPjvpHCeTQ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX6f/pANuO9MOq
 7TaKv4BdTZUbmktiyFIL0WpoyHt+tbNK9cWuUI05CU5jak/xXPCr7VXmpbuvvVuTjP6hA4o+rnm
 XSpMB5iU7kHbmGpjDdM9bfGkYw4u8hygwwnEo80Vk9HekIZZlS6XM9y4LyRGyjTyn+JxS5R5I0V
 YZjbu4prRKlTGzY82BvY3Go+eUxsJY/fo1jYO5A8ZG+4gvSM8WODa2aqbTaztKgXLy48+Il+cbt
 UGf3pE8mhFX2nM/cm8Mklx7wT0VHXB4wo63q0f/BMa+6rKoPhjP0fngwzJ6gncnkWWjLRfhiVRR
 pZv/Pc/qyxzkKtdPlMu2bDaLQWNdcrf761L6bwzWQ5lihv+1fG5BSxAtcqANVs7uT4Rq+zTY5nE
 ArjPytHXXxfdjdW3O7nTdZ0T+XOaRw==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e5e98a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=4lT8O_Qwe5KXetiC_XUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: k8N6SEsC2CEiW4kEOuG_vmevsTXyd1-6
X-Proofpoint-ORIG-GUID: k8N6SEsC2CEiW4kEOuG_vmevsTXyd1-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

Make all struct platform_inst_fw_cap instances constant, they are not
modified at runtime.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c            | 2 +-
 drivers/media/platform/qcom/iris/iris_platform_common.h  | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_gen2.c    | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_qcs8300.h | 4 ++--
 drivers/media/platform/qcom/iris/iris_platform_sm8250.c  | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 754a5ad718bc37630bb861012301df7a2e7342a1..9da050aa1f7ce8152dfa46a706e2c27adfb5d6ce 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -301,7 +301,7 @@ int iris_ctrls_init(struct iris_inst *inst)
 
 void iris_session_init_caps(struct iris_core *core)
 {
-	struct platform_inst_fw_cap *caps;
+	const struct platform_inst_fw_cap *caps;
 	u32 i, num_cap, cap_id;
 
 	caps = core->iris_platform_data->inst_fw_caps_dec;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..17ed86bf78bb3b0bc3f0862253fba6505ac3d164 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -215,9 +215,9 @@ struct iris_platform_data {
 	const char *fwname;
 	u32 pas_id;
 	struct platform_inst_caps *inst_caps;
-	struct platform_inst_fw_cap *inst_fw_caps_dec;
+	const struct platform_inst_fw_cap *inst_fw_caps_dec;
 	u32 inst_fw_caps_dec_size;
-	struct platform_inst_fw_cap *inst_fw_caps_enc;
+	const struct platform_inst_fw_cap *inst_fw_caps_enc;
 	u32 inst_fw_caps_enc_size;
 	struct tz_cp_config *tz_cp_config_data;
 	u32 core_arch;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..cbf38e13f89e5c4c46e759fbb86777854d751552 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -19,7 +19,7 @@
 #define VIDEO_ARCH_LX 1
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -203,7 +203,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 35ea0efade73caa687d300779c5b1dc3b17a0128..87517361a1cf4b6fe53b8a1483188670df52c7e7 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -5,7 +5,7 @@
 
 #define BITRATE_MAX				245000000
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
@@ -189,7 +189,7 @@ static struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
 	{
 		.cap_id = PROFILE_H264,
 		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..e29cba993fde922b579eb7e5a59ae34bb46f9f0f 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -17,7 +17,7 @@
 #define BITRATE_PEAK_DEFAULT	(BITRATE_DEFAULT * 2)
 #define BITRATE_STEP		100
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	{
 		.cap_id = PIPE,
 		.min = PIPE_1,
@@ -38,7 +38,7 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8250_dec[] = {
 	},
 };
 
-static struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
+static const struct platform_inst_fw_cap inst_fw_cap_sm8250_enc[] = {
 	{
 		.cap_id = STAGE,
 		.min = STAGE_1,

-- 
2.47.3


