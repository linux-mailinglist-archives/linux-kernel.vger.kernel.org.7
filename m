Return-Path: <linux-kernel+bounces-748587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938CB14362
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30D118C32F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912111F3B89;
	Mon, 28 Jul 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FA1Q0dNl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AE27A914
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734867; cv=none; b=m0FhrNyXY3Jva8vmYaT9PDDImFqeSyyyyNGneaR2D+acJ5mq6UL6z0CKMjVepfVw7n/pcAhc397jMV660DXeijJCo+gGeaPlfYdLHHthPgsqNSXqgfvCYwyo59mHQyY5m4/SdbiqXrRRKB2IMyacZl73PZVgze+Vxm4JB6fozr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734867; c=relaxed/simple;
	bh=YAIH+E/3LvpO5GlPE0CQ+tsFKSmMasbpXzwo031Mlqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWRKur2eG3tCBb2gLxi8NZoRQp2KaP1tHosqKfNMXxtbv8m7G+g91QcU52Q36mRIKX9x8SDJPjFrkZ4rr4GhTiLb1TGOK4FBNNN3ry+nS4XcchrEuq45QNtnVCaVjyny48jvpWzbOdzE6q3bksB1x9hMPekqriHOWxjNbCPyfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FA1Q0dNl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlQCN031280
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FblfID0Tg34
	q4efy9/6mUQC/8o/8akfX96cV9gNqkhk=; b=FA1Q0dNl4ZOlo74+lWU/K+j9SLn
	jsjEAa/cqprycRJPxnNmUbP5+DGx9b1x6qkxk6DFI0ULhCn6nc/j4F221+n3TXwm
	8QpimZafMakw53DB4k06w5XRnYvA+yCWwIChEjfaSLqdEOlL/qeng7N07gGd2WdS
	MNN1lA1AyXOLDh7wpF8jV9i738Ne0KRcHfkpKw9UHamcwW4VKl6i4UyErcs7cf/i
	5+KGZ7Al25qVvuMxB1CdIwDfzvlpvnD6zqHCCTenOlzApGHcNe281LYxi/AxQRDn
	4X2GPBzX5eKKCfxUfbuEApBfol8bbrDDf0K7klO0+qc+RSyBYWfdHJUsmYw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 485v1xb5kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-766607c02easo243575b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734864; x=1754339664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FblfID0Tg34q4efy9/6mUQC/8o/8akfX96cV9gNqkhk=;
        b=j8A9C/439DTEJbVWi7nl/fcqLViemlzW1KF4ivc5IXl4QRD9m5lNyZzt2QLbORL3HF
         BA97xJdPqJywDPhhsFqji5byiunAbPNEyMUYXm5gxjANnYeFEi10eNQzlMOPy1JXXyrZ
         PHkB4kL9LUhW/HXuAFcUd31z17xHHYPuaipz11XL7QZbpr9NJuQkb9msowIke6bxP0SM
         5Qw8GuBXaki1dELyYzL6/flgF90uCLswrGMr7krgCADbyDLslL12v14LC/K+B5Ptc6Q6
         l9Yxb0HzmcIqAQIK9gvjo3Ft3eBTiORGCuYQxFBGK1N+IFcRjSfnIPIHmrnwcRQgJpqW
         IyKA==
X-Forwarded-Encrypted: i=1; AJvYcCWqwtu0W/xVCySVnUQKQ+w06Vysv6KnC/w7Lqg53oLNrSjuJDDTH1vSVjHNwCVtFZoclohF+r3AtXTXe+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuWvgEPVGqjD7DpepO6H4RGelUSZbqN3ohym8O44Sbx90wY2B
	FkxHquHPIw/e/YhvaDathuH4HyOsiQi4hmEdRYkjiOtRIuTkkC1FDCYak5ZB7SPgsmQKRGJkndc
	yG3naDH6tmN6folmI7vJOfUR8YtxcjL92QgYgkU6t/9QP6b9tI3vO8sZNeWdX5JOoqXw=
X-Gm-Gg: ASbGncsaaHxfWdHbhsC5APhyc5bUocTG8SVtVpwZO8o7FPiQELP0xjx0LsaoyPZJCMg
	C2m52Xg/5m0UOoFv0rnF/HUaq3KIqFR6vmHW31TOGyS4YIoH2NosHR+hzlNSFSpD280ppEKshD8
	z+/sSVmMtHNirY5QPAFUpGo8PzDSaQLJ6P/x2IDsKDUUwGXJXA4uvXjU0DqwMKvzB4ODq7b237N
	mvDBVRHl+/2DG4Y/X807TE/4r/SYdupRL1ni2EO8zAnHS50722uhQx9Z4R83Mi0lthGBih1VPNH
	ayDiAvDhCM4WW3C+ydhmNNPJRKgp1Us2EU/CcwviDkEccID8U9s=
X-Received: by 2002:a05:6a00:3a09:b0:742:b31e:e9c1 with SMTP id d2e1a72fcca58-76967c8f960mr1024033b3a.11.1753734863970;
        Mon, 28 Jul 2025 13:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6V857zu2K5JXW/da9VThTUPhbu/3BvEVZayXh4F3IPipEL9YGCsaSIVW60VyqWLz3F3Hnsw==
X-Received: by 2002:a05:6a00:3a09:b0:742:b31e:e9c1 with SMTP id d2e1a72fcca58-76967c8f960mr1024004b3a.11.1753734863448;
        Mon, 28 Jul 2025 13:34:23 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-767bc848735sm2919670b3a.28.2025.07.28.13.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:34:23 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/7] drm/msm: Constify snapshot tables
Date: Mon, 28 Jul 2025 13:34:04 -0700
Message-ID: <20250728203412.22573-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
References: <20250728203412.22573-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1MSBTYWx0ZWRfX+F7kjUjxLuy7
 U//W2wzLQMLgEOr3EFWO14YHxkwp0R1mjbx2gDAwkPikZIGLJanZBF1wl9aaxHann2nYqC72fzi
 sZ1NYgEoWVbznwqO1DoJ5+LPbHimvvBpJwH25ywfrwbzDbtVB9ghLjdiLbtnxfHobPEfDc+zakd
 WBGxdCRCx2j9RXr0C0M61gbzcyRSIiMZWUQSAv0+17PloL1A3VoetzMKt2WybiUzQ4MvaxsSKWW
 to+NchZv9UPdqXd++7GIrwmf2mt1Q1gnfvL1vAkUtOa+OM0D9jP57h6HVdiUO7kk43/E009oZWp
 B0YtJB82JobOkBnvkYm9x5xFnqM9R5T8vn2LTP4j6gvXCzGdhiBvky8TcRU7lp1J5eY+CIfllzG
 upO0PQ1rLw0VtfjTXmoHhC/HpGEPDYhxJdFYbhuKWpt8zULCkKzCJynf84nFFrWbfNIUnCNT
X-Authority-Analysis: v=2.4 cv=JKw7s9Kb c=1 sm=1 tr=0 ts=6887ded1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=3YnKlkqyfxy5QV46dWoA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: WLhnb-NONpbvEVq2dJD2jX2_yjSHmxB6
X-Proofpoint-GUID: WLhnb-NONpbvEVq2dJD2jX2_yjSHmxB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280151

A bit of divergence from the downstream driver from which these headers
were imported.  But no need for these tables not to be const.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c           |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h |  8 ++++----
 drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h |  8 ++++----
 drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index b253ef38eebf..7ba7113f33cd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -11,7 +11,7 @@
 static const unsigned int *gen7_0_0_external_core_regs[] __always_unused;
 static const unsigned int *gen7_2_0_external_core_regs[] __always_unused;
 static const unsigned int *gen7_9_0_external_core_regs[] __always_unused;
-static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] __always_unused;
+static const struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] __always_unused;
 static const u32 gen7_9_0_cx_debugbus_blocks[] __always_unused;
 
 #include "adreno_gen7_0_0_snapshot.h"
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
index cb66ece6606b..afcc7498983f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h
@@ -81,7 +81,7 @@ static const u32 gen7_0_0_debugbus_blocks[] = {
 	A7XX_DBGBUS_USPTP_7,
 };
 
-static struct gen7_shader_block gen7_0_0_shader_blocks[] = {
+static const struct gen7_shader_block gen7_0_0_shader_blocks[] = {
 	{A7XX_TP0_TMO_DATA,                 0x200, 4, 2, A7XX_PIPE_BR, A7XX_USPTP},
 	{A7XX_TP0_SMO_DATA,                  0x80, 4, 2, A7XX_PIPE_BR, A7XX_USPTP},
 	{A7XX_TP0_MIPMAP_BASE_DATA,         0x3c0, 4, 2, A7XX_PIPE_BR, A7XX_USPTP},
@@ -695,7 +695,7 @@ static const struct gen7_sel_reg gen7_0_0_rb_rbp_sel = {
 	.val = 0x9,
 };
 
-static struct gen7_cluster_registers gen7_0_0_clusters[] = {
+static const struct gen7_cluster_registers gen7_0_0_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BR, STATE_NON_CONTEXT,
 		gen7_0_0_noncontext_pipe_br_registers, },
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BV, STATE_NON_CONTEXT,
@@ -764,7 +764,7 @@ static struct gen7_cluster_registers gen7_0_0_clusters[] = {
 		gen7_0_0_vpc_cluster_vpc_ps_pipe_bv_registers, },
 };
 
-static struct gen7_sptp_cluster_registers gen7_0_0_sptp_clusters[] = {
+static const struct gen7_sptp_cluster_registers gen7_0_0_sptp_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_HLSQ_STATE,
 		gen7_0_0_sp_noncontext_pipe_br_hlsq_state_registers, 0xae00 },
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_SP_TOP,
@@ -914,7 +914,7 @@ static const u32 gen7_0_0_dpm_registers[] = {
 };
 static_assert(IS_ALIGNED(sizeof(gen7_0_0_dpm_registers), 8));
 
-static struct gen7_reg_list gen7_0_0_reg_list[] = {
+static const struct gen7_reg_list gen7_0_0_reg_list[] = {
 	{ gen7_0_0_gpu_registers, NULL },
 	{ gen7_0_0_cx_misc_registers, NULL },
 	{ gen7_0_0_dpm_registers, NULL },
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
index 6f8ad50f32ce..6569f12bf12f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h
@@ -95,7 +95,7 @@ static const u32 gen7_2_0_debugbus_blocks[] = {
 	A7XX_DBGBUS_CCHE_2,
 };
 
-static struct gen7_shader_block gen7_2_0_shader_blocks[] = {
+static const struct gen7_shader_block gen7_2_0_shader_blocks[] = {
 	{A7XX_TP0_TMO_DATA,                 0x200, 6, 2, A7XX_PIPE_BR, A7XX_USPTP},
 	{A7XX_TP0_SMO_DATA,                  0x80, 6, 2, A7XX_PIPE_BR, A7XX_USPTP},
 	{A7XX_TP0_MIPMAP_BASE_DATA,         0x3c0, 6, 2, A7XX_PIPE_BR, A7XX_USPTP},
@@ -489,7 +489,7 @@ static const struct gen7_sel_reg gen7_2_0_rb_rbp_sel = {
 	.val = 0x9,
 };
 
-static struct gen7_cluster_registers gen7_2_0_clusters[] = {
+static const struct gen7_cluster_registers gen7_2_0_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BR, STATE_NON_CONTEXT,
 		gen7_2_0_noncontext_pipe_br_registers, },
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BV, STATE_NON_CONTEXT,
@@ -558,7 +558,7 @@ static struct gen7_cluster_registers gen7_2_0_clusters[] = {
 		gen7_0_0_vpc_cluster_vpc_ps_pipe_bv_registers, },
 };
 
-static struct gen7_sptp_cluster_registers gen7_2_0_sptp_clusters[] = {
+static const struct gen7_sptp_cluster_registers gen7_2_0_sptp_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_HLSQ_STATE,
 		gen7_0_0_sp_noncontext_pipe_br_hlsq_state_registers, 0xae00 },
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_SP_TOP,
@@ -737,7 +737,7 @@ static const u32 gen7_2_0_dpm_registers[] = {
 };
 static_assert(IS_ALIGNED(sizeof(gen7_2_0_dpm_registers), 8));
 
-static struct gen7_reg_list gen7_2_0_reg_list[] = {
+static const struct gen7_reg_list gen7_2_0_reg_list[] = {
 	{ gen7_2_0_gpu_registers, NULL },
 	{ gen7_2_0_cx_misc_registers, NULL },
 	{ gen7_2_0_dpm_registers, NULL },
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
index fc62820c0a9d..3785b644382e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h
@@ -117,7 +117,7 @@ static const u32 gen7_9_0_cx_debugbus_blocks[] = {
 	A7XX_DBGBUS_GBIF_CX,
 };
 
-static struct gen7_shader_block gen7_9_0_shader_blocks[] = {
+static const struct gen7_shader_block gen7_9_0_shader_blocks[] = {
 	{ A7XX_TP0_TMO_DATA, 0x0200, 6, 2, A7XX_PIPE_BR, A7XX_USPTP },
 	{ A7XX_TP0_SMO_DATA, 0x0080, 6, 2, A7XX_PIPE_BR, A7XX_USPTP },
 	{ A7XX_TP0_MIPMAP_BASE_DATA, 0x03C0, 6, 2, A7XX_PIPE_BR, A7XX_USPTP },
@@ -1116,7 +1116,7 @@ static const struct gen7_sel_reg gen7_9_0_rb_rbp_sel = {
 	.val = 0x9,
 };
 
-static struct gen7_cluster_registers gen7_9_0_clusters[] = {
+static const struct gen7_cluster_registers gen7_9_0_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BR, STATE_NON_CONTEXT,
 		gen7_9_0_non_context_pipe_br_registers,  },
 	{ A7XX_CLUSTER_NONE, A7XX_PIPE_BV, STATE_NON_CONTEXT,
@@ -1185,7 +1185,7 @@ static struct gen7_cluster_registers gen7_9_0_clusters[] = {
 		gen7_9_0_vpc_pipe_bv_cluster_vpc_ps_registers,  },
 };
 
-static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
+static const struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_HLSQ_STATE,
 		gen7_9_0_non_context_sp_pipe_br_hlsq_state_registers, 0xae00},
 	{ A7XX_CLUSTER_NONE, A7XX_SP_NCTX_REG, A7XX_PIPE_BR, 0, A7XX_SP_TOP,
@@ -1294,7 +1294,7 @@ static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
 		gen7_9_0_tpl1_pipe_br_cluster_sp_ps_usptp_registers, 0xb000},
 };
 
-static struct a6xx_indexed_registers gen7_9_0_cp_indexed_reg_list[] = {
+static const struct a6xx_indexed_registers gen7_9_0_cp_indexed_reg_list[] = {
 	{ "CP_SQE_STAT", REG_A6XX_CP_SQE_STAT_ADDR,
 		REG_A6XX_CP_SQE_STAT_DATA, 0x00040},
 	{ "CP_DRAW_STATE", REG_A6XX_CP_DRAW_STATE_ADDR,
@@ -1337,7 +1337,7 @@ static struct a6xx_indexed_registers gen7_9_0_cp_indexed_reg_list[] = {
 		REG_A7XX_CP_AQE_STAT_DATA_1, 0x00040},
 };
 
-static struct gen7_reg_list gen7_9_0_reg_list[] = {
+static const struct gen7_reg_list gen7_9_0_reg_list[] = {
 	{ gen7_9_0_gpu_registers, NULL},
 	{ gen7_9_0_cx_misc_registers, NULL},
 	{ gen7_9_0_cx_dbgc_registers, NULL},
-- 
2.50.1


