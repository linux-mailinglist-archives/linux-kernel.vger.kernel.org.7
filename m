Return-Path: <linux-kernel+bounces-873690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EEC14729
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B15E5FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1E30FC19;
	Tue, 28 Oct 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="By1INTVp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF330E858
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651998; cv=none; b=H6LJsfVlYQMZSrmuQZf0XoY3ivhd7hbc17HG+gMgXEbuoabcIRQm8Uf5OruzVHRbVvlyKFCic/7/ZW7B1k08I3W5zJRDW6gtgf1qpax8+gqbge9S+YzJvALECgaeFbaeiNUGMzbN+G9KB5UYYIUFl85VzVSxuh+XyYsn56exdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651998; c=relaxed/simple;
	bh=d7tS2MJNUw2vaeE4fX6vM58/8/s2c7Y+VeVjXja5ONw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTAL1D2NhIjkK/YuxZYJQ1gdf87mtLSm6Au+UGPR9tt1mm/VabuJa0RnjwYGG+rwpDdSUFRyLqqBZulz1v7VaU7mVdD1ky+KKDsPoc/457+PYxVI5LR5/ZdAUe/GrcL00g4UVOX80Uo3LSROcXaSqWRJpPesDj+4hIatLstV24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=By1INTVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SA2vV41237669
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bB/NX0q/X1FSXzM60MuDC41GFlTt7PcGM4q7Uucp49I=; b=By1INTVp8XzI2F4a
	5o164V5gM/daTgkrovf1FgPUh2hMcyo5W4xkEI5aDORVIRJdwlO8ItsysXQx3b0O
	KLKjBd9vj1uiY3pgl6d69GR1lmu3BMw/fILlQMc5XqV1cMsMZhimxgvbbeJyaPq0
	TRA6GGO/AdMTbXULT+AxTLfVuLAYZgx3RLQNVsV2vPReFbZFWBBw/It9pd1RLFVE
	D+XUqB6krTZ7GBDcSHyhBzhv2cpqeybemp6IG7L/OKmMcQufgtAGiia9V8EAg4Xf
	nhJicm6qonrFDSH8UtNUc7xfq4x8yr4zUAbk3VHJKO0fk6b2QQaG/8/zoU5YTnzn
	ARyLZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2ur3g95e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:46:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88947a773so304543801cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651993; x=1762256793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bB/NX0q/X1FSXzM60MuDC41GFlTt7PcGM4q7Uucp49I=;
        b=d+81SNFHDJMKagagJuUGOc+u2jelaC49dbNSdQWljYH9NxW5/6E04CyFv4qEMnYDdd
         WJL6aEoBJrYDtxG+YmmBwFbymOVKX8dELeMp6DoQuocOUjuhpmGm5tBbFviDWqmgyJeZ
         J3l8yFM2MCZ3P2fph0WpqnAbb23ltEt1U/rPZlt9s4vEeuqmM4BZO4A99nAkasbEbNBV
         nHAFmPMwZ7eVdmghkkH2aC9u1W2/lQTyvRcq4a+de3fn4Ukbw3cS7o3j0QX7ZADI0myh
         hJxb9VXGl1EBesu0fRGtvgJNM596gYScDXGA6sm9rO3tUjcN5UfkCYnJ9uB4rGTZOet/
         4y+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ5VQPK98rmICWmc7vyDiWAPRj9P6iUYPCP7zNYFKF8k5vm1dr4Jx7H+Z40hs8jCh8995nCl76O8wWUPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyzJYPkQEN78C6QpsBJ6+PogmXC5sGhou0Gd2UxLCNYoyBe9i
	MMefPiEZOw/gF2lvcXc9SAbEEr4Yn24r975x2v1PjMp9s+dh5Ba/+/ajE4BidJnwW4M95ILIR0a
	tyziQ9k/+21Sx9iuyu4So6uj6mcZ9JFGeJ+dRPnD9yEhOjwDW9JWXp3cECuMLsCs9mco=
X-Gm-Gg: ASbGncui80zP8/9aZ8TA/2yCRnSfy32ZQH9bXT9GaWSki4K1eH2r6j0KIrCRRhEiUeK
	SX1fCcbDFtZHUXsu2TdPe7C8ItSSyf8hzVBg4bK8jaPYxSCt5ufUci1XAmboKLzLHCqF8DY5aho
	pyyDhST2jqzhrfK2IW3YNF1C2bBgY1fiRGcRkV3S2kkMa5Huh43OSqlqFNpkdqbKyEV8iDkZs5p
	4lutr6TBX6UbLyYSfZxWc8pruN9w3dNGGDhrsbPXeC+WJ6SUqMIR0AdRBSf+YeWpTcT48ya7qdc
	6zeanJTGT2DxTagfDpg7Ei1D72fBCR00oHOIK+SnIcUzq0DWPAZEQAgYvgLzHdbjRTH3Xn+tIq3
	Aia0jgfJe034+ujFIWA3nvw1yahUWYDxTkiIIZmT4rQE99fi0URkD2RvLXuVgPTDYLvDmAFOWj4
	0VmCZfofLotr4k
X-Received: by 2002:a05:622a:5506:b0:4ec:a568:7b2d with SMTP id d75a77b69052e-4ed0753d986mr40795641cf.34.1761651993191;
        Tue, 28 Oct 2025 04:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVH84JiStHmZAtytaZOmRVnn9IundQ/H4EFPLOZFWd8qguegxFZk6jtYAIAnhcb63GF2fEpQ==
X-Received: by 2002:a05:622a:5506:b0:4ec:a568:7b2d with SMTP id d75a77b69052e-4ed0753d986mr40795101cf.34.1761651992416;
        Tue, 28 Oct 2025 04:46:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm3096564e87.6.2025.10.28.04.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:46:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:46:23 +0200
Subject: [PATCH v6 4/6] media: iris: remove duplication between generic
 gen2 data and qcs8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-iris-sc7280-v6-4-48b1ea9169f6@oss.qualcomm.com>
References: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
In-Reply-To: <20251028-iris-sc7280-v6-0-48b1ea9169f6@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=d7tS2MJNUw2vaeE4fX6vM58/8/s2c7Y+VeVjXja5ONw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpAK0RgQH2F8yIU2B8hp/SCFvc613r9h/dOTExQ
 C76XfdeZ9aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQCtEQAKCRCLPIo+Aiko
 1ZeRB/9X0IHIbGXJnZawsdDbEkdAecre0UIh80PvJSFGygabGo3xstG+3wcJIlWcD0rJ1b6mN26
 hanjHLZh+odDWH23hdoSfhqSbcGmvMQ7bMPE0tyVsDC91/njX7SwaveYfnDhyVs3Ap72JaNKO9i
 i7HS7OMjNYQ6Y0KSlA8IFVuohAIlkUpJApHBVK8g+H++yXS6N+v9/Dh5qAICHw+/6vy65Y244nU
 fwPMrcsZTM2CCZVVRHEU12k0L8tKO/gllS/nWfIIlbO4u0qB3tvu5aS8IvZzUjhWN12yfpcZam0
 0W32e+ozf3iXeqFLu8X5+ctirhyGDV765KJuj1Q3mLCj/Ra5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5OSBTYWx0ZWRfX9G6i6esmbZNn
 SZKLwuS+8CzYhHXT6ZrY4ougd6kBJyg59SFb7BfSuhMfectJEYSDdE3TJWAOYsk/+MGSQnkUhOT
 MpzuO0/u2Md+6WctILwjKSjkWUpGFvUbsvi09Jeo8MzszhSwocqFGWnLkkNYYKVtHzTy0x/kIf9
 rrBdFLV0snVJw27mUprWjmNK1krtoX6WjAMypdFwih4n6TXl6iunleNtaRWh+TwkVjMgvvDK3Gi
 1D/QxHLHyc3GLTnvq7EwOugg8G/OqevsOFcqyiCxM2pfvj2FNPDpxaNpjFIMjWU45bSn0sUDMF5
 PsQqvqfFXaEStBecXx0GzgwmvxB+RCI/cKomzspDysnqyURBzPQeJ4H86FbKvgy8AUfBxdlPIQw
 QfXOjz3lAY7WiSL1UgWcx7UR6RUiog==
X-Authority-Analysis: v=2.4 cv=Jub8bc4C c=1 sm=1 tr=0 ts=6900ad1a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=8lhtx-rUCDsU0NfLSlYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: YgJfp5qHWBs-ilUvb18FFhzuMn36-bGq
X-Proofpoint-ORIG-GUID: YgJfp5qHWBs-ilUvb18FFhzuMn36-bGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280099

Now as we have removed PIPE value from inst_fw_caps_dec there should be
no difference between inst_fw_caps of QCS8300 and SM8550+. Drop the
QCS8300-specific tables and use generic one instead.

The differences between QCS8300 and SM8550 data comes from a
non-conflict merge of commit d22037f3fd33 ("media: iris: Set platform
capabilities to firmware for encoder video device") (which added .set
callbacks), and commit 6bdfa3f947a7 ("media: iris: Add platform-specific
capabilities for encoder video device") (which added QCS8300 data, but
not the callbacks).

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../media/platform/qcom/iris/iris_platform_gen2.c  |   9 +-
 .../platform/qcom/iris/iris_platform_qcs8300.h     | 533 +--------------------
 2 files changed, 8 insertions(+), 534 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index fb3fa1665c523fbe01df590f14d8012da3a8dd09..2631b7317e086084e5be95e2e0370c44ea255df7 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -994,7 +994,6 @@ const struct iris_platform_data sm8750_data = {
 /*
  * Shares most of SM8550 data except:
  * - inst_caps to platform_inst_cap_qcs8300
- * - inst_fw_caps to inst_fw_cap_qcs8300
  */
 const struct iris_platform_data qcs8300_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
@@ -1020,10 +1019,10 @@ const struct iris_platform_data qcs8300_data = {
 	.fwname = "qcom/vpu/vpu30_p4_s6.mbn",
 	.pas_id = IRIS_PAS_ID,
 	.inst_caps = &platform_inst_cap_qcs8300,
-	.inst_fw_caps_dec = inst_fw_cap_qcs8300_dec,
-	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_qcs8300_dec),
-	.inst_fw_caps_enc = inst_fw_cap_qcs8300_enc,
-	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_qcs8300_enc),
+	.inst_fw_caps_dec = inst_fw_cap_sm8550_dec,
+	.inst_fw_caps_dec_size = ARRAY_SIZE(inst_fw_cap_sm8550_dec),
+	.inst_fw_caps_enc = inst_fw_cap_sm8550_enc,
+	.inst_fw_caps_enc_size = ARRAY_SIZE(inst_fw_cap_sm8550_enc),
 	.tz_cp_config_data = &tz_cp_config_sm8550,
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
index 7ae50ab22f8c577675a10b767e1d5f3cfe16d439..61025f1e965b802cba939fda74c01ea33b95648d 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_qcs8300.h
@@ -3,535 +3,8 @@
  * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#define BITRATE_MAX				245000000
-
-static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_dec[] = {
-	{
-		.cap_id = PROFILE_H264,
-		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
-		.max = V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_HIGH) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH),
-		.value = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
-		.hfi_id = HFI_PROP_PROFILE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = PROFILE_HEVC,
-		.min = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
-		.max = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
-		.value = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
-		.hfi_id = HFI_PROP_PROFILE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = PROFILE_VP9,
-		.min = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
-		.max = V4L2_MPEG_VIDEO_VP9_PROFILE_2,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_2),
-		.value = V4L2_MPEG_VIDEO_VP9_PROFILE_0,
-		.hfi_id = HFI_PROP_PROFILE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = LEVEL_H264,
-		.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
-		.max = V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1B) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_3) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_2),
-		.value = V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
-		.hfi_id = HFI_PROP_LEVEL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = LEVEL_HEVC,
-		.min = V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
-		.max = V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2),
-		.value = V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
-		.hfi_id = HFI_PROP_LEVEL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = LEVEL_VP9,
-		.min = V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
-		.max = V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_1) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_2_1) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_3_1) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_4_1) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_0) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_1) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_5_2) |
-				BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_6_0),
-		.value = V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
-		.hfi_id = HFI_PROP_LEVEL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = TIER,
-		.min = V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
-		.max = V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_TIER_MAIN) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_TIER_HIGH),
-		.value = V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
-		.hfi_id = HFI_PROP_TIER,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-		.set = iris_set_u32_enum,
-	},
-	{
-		.cap_id = INPUT_BUF_HOST_MAX_COUNT,
-		.min = DEFAULT_MAX_HOST_BUF_COUNT,
-		.max = DEFAULT_MAX_HOST_BURST_BUF_COUNT,
-		.step_or_mask = 1,
-		.value = DEFAULT_MAX_HOST_BUF_COUNT,
-		.hfi_id = HFI_PROP_BUFFER_HOST_MAX_COUNT,
-		.flags = CAP_FLAG_INPUT_PORT,
-		.set = iris_set_u32,
-	},
-	{
-		.cap_id = STAGE,
-		.min = STAGE_1,
-		.max = STAGE_2,
-		.step_or_mask = 1,
-		.value = STAGE_2,
-		.hfi_id = HFI_PROP_STAGE,
-		.set = iris_set_stage,
-	},
-	{
-		.cap_id = PIPE,
-		/* .max, .min and .value are set via platform data */
-		.step_or_mask = 1,
-		.hfi_id = HFI_PROP_PIPE,
-		.set = iris_set_pipe,
-	},
-	{
-		.cap_id = POC,
-		.min = 0,
-		.max = 2,
-		.step_or_mask = 1,
-		.value = 1,
-		.hfi_id = HFI_PROP_PIC_ORDER_CNT_TYPE,
-	},
-	{
-		.cap_id = CODED_FRAMES,
-		.min = CODED_FRAMES_PROGRESSIVE,
-		.max = CODED_FRAMES_PROGRESSIVE,
-		.step_or_mask = 0,
-		.value = CODED_FRAMES_PROGRESSIVE,
-		.hfi_id = HFI_PROP_CODED_FRAMES,
-	},
-	{
-		.cap_id = BIT_DEPTH,
-		.min = BIT_DEPTH_8,
-		.max = BIT_DEPTH_8,
-		.step_or_mask = 1,
-		.value = BIT_DEPTH_8,
-		.hfi_id = HFI_PROP_LUMA_CHROMA_BIT_DEPTH,
-	},
-	{
-		.cap_id = RAP_FRAME,
-		.min = 0,
-		.max = 1,
-		.step_or_mask = 1,
-		.value = 1,
-		.hfi_id = HFI_PROP_DEC_START_FROM_RAP_FRAME,
-		.flags = CAP_FLAG_INPUT_PORT,
-		.set = iris_set_u32,
-	},
-};
-
-static const struct platform_inst_fw_cap inst_fw_cap_qcs8300_enc[] = {
-	{
-		.cap_id = PROFILE_H264,
-		.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
-		.max = V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
-				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_HIGH),
-		.value = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
-		.hfi_id = HFI_PROP_PROFILE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = PROFILE_HEVC,
-		.min = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
-		.max = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10),
-		.value = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
-		.hfi_id = HFI_PROP_PROFILE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = LEVEL_H264,
-		.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
-		.max = V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1B) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_3) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_0) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_1) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_2) |
-				BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_0),
-		.value = V4L2_MPEG_VIDEO_H264_LEVEL_5_0,
-		.hfi_id = HFI_PROP_LEVEL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = LEVEL_HEVC,
-		.min = V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
-		.max = V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1) |
-				BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2),
-		.value = V4L2_MPEG_VIDEO_HEVC_LEVEL_5,
-		.hfi_id = HFI_PROP_LEVEL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = STAGE,
-		.min = STAGE_1,
-		.max = STAGE_2,
-		.step_or_mask = 1,
-		.value = STAGE_2,
-		.hfi_id = HFI_PROP_STAGE,
-	},
-	{
-		.cap_id = HEADER_MODE,
-		.min = V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
-		.max = V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) |
-				BIT(V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
-		.value = V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
-		.hfi_id = HFI_PROP_SEQ_HEADER_MODE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = PREPEND_SPSPPS_TO_IDR,
-		.min = 0,
-		.max = 1,
-		.step_or_mask = 1,
-		.value = 0,
-	},
-	{
-		.cap_id = BITRATE,
-		.min = 1,
-		.max = BITRATE_MAX,
-		.step_or_mask = 1,
-		.value = BITRATE_DEFAULT,
-		.hfi_id = HFI_PROP_TOTAL_BITRATE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = BITRATE_PEAK,
-		.min = 1,
-		.max = BITRATE_MAX,
-		.step_or_mask = 1,
-		.value = BITRATE_DEFAULT,
-		.hfi_id = HFI_PROP_TOTAL_PEAK_BITRATE,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = BITRATE_MODE,
-		.min = V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
-		.max = V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_BITRATE_MODE_VBR) |
-				BIT(V4L2_MPEG_VIDEO_BITRATE_MODE_CBR),
-		.value = V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
-		.hfi_id = HFI_PROP_RATE_CONTROL,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = FRAME_SKIP_MODE,
-		.min = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
-		.max = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED) |
-				BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_LEVEL_LIMIT) |
-				BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT),
-		.value = V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = FRAME_RC_ENABLE,
-		.min = 0,
-		.max = 1,
-		.step_or_mask = 1,
-		.value = 1,
-	},
-	{
-		.cap_id = GOP_SIZE,
-		.min = 0,
-		.max = INT_MAX,
-		.step_or_mask = 1,
-		.value = 2 * DEFAULT_FPS - 1,
-		.hfi_id = HFI_PROP_MAX_GOP_FRAMES,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = ENTROPY_MODE,
-		.min = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC,
-		.max = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
-		.step_or_mask = BIT(V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC) |
-				BIT(V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC),
-		.value = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
-		.hfi_id = HFI_PROP_CABAC_SESSION,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
-	},
-	{
-		.cap_id = MIN_FRAME_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-		.hfi_id = HFI_PROP_MIN_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT,
-	},
-	{
-		.cap_id = MIN_FRAME_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-		.hfi_id = HFI_PROP_MIN_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT,
-	},
-	{
-		.cap_id = MAX_FRAME_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-		.hfi_id = HFI_PROP_MAX_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT,
-	},
-	{
-		.cap_id = MAX_FRAME_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-		.hfi_id = HFI_PROP_MAX_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT,
-	},
-	{
-		.cap_id = I_FRAME_MIN_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = I_FRAME_MIN_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = P_FRAME_MIN_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = P_FRAME_MIN_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = B_FRAME_MIN_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = B_FRAME_MIN_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MIN_QP_8BIT,
-	},
-	{
-		.cap_id = I_FRAME_MAX_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = I_FRAME_MAX_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = P_FRAME_MAX_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = P_FRAME_MAX_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = B_FRAME_MAX_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = B_FRAME_MAX_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = MAX_QP,
-	},
-	{
-		.cap_id = I_FRAME_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = I_FRAME_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = P_FRAME_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = P_FRAME_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = B_FRAME_QP_H264,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-	{
-		.cap_id = B_FRAME_QP_HEVC,
-		.min = MIN_QP_8BIT,
-		.max = MAX_QP,
-		.step_or_mask = 1,
-		.value = DEFAULT_QP,
-		.hfi_id = HFI_PROP_QP_PACKED,
-		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
-			CAP_FLAG_DYNAMIC_ALLOWED,
-	},
-};
+#ifndef __IRIS_PLATFORM_QCS8300_H__
+#define __IRIS_PLATFORM_QCS8300_H__
 
 static struct platform_inst_caps platform_inst_cap_qcs8300 = {
 	.min_frame_width = 96,
@@ -546,3 +19,5 @@ static struct platform_inst_caps platform_inst_cap_qcs8300 = {
 	.max_frame_rate = MAXIMUM_FPS,
 	.max_operating_rate = MAXIMUM_FPS,
 };
+
+#endif

-- 
2.47.3


