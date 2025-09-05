Return-Path: <linux-kernel+bounces-801861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C2B44AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80E91BC4611
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A521C84A1;
	Fri,  5 Sep 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvY1ggft"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655B1BE871
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032730; cv=none; b=YPlFKSmcvavC2jJOqDFmYK7pBtaCGGim/Ml9FgoYzVAUI+K+pQB8t7i8R/ncQM0LqNKB8dorRwc+13dth0Q6OgpRBbOVtsW7UjJiF67fMm7rOsCieAJb6rt5nYU1AyJBCio3c6CgUT5hlA0jQsvzm6tksvgKpKiysPY2Es7tHrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032730; c=relaxed/simple;
	bh=Ec6ILQ/MERXTAPVK3p0IrR1LWDecA4ARKM5wLiwsDmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8nN6FPoFaSGQHoGFprzmtxBAp44TpBhsoxX7Dr54houtlR01uuBg2ozWfX4olQaywp+Lc5E1PtySFjLmkW811hOW8naK9RpIB1nswtI74vP76MuUg1WI/28Z30m/ucsxJVWsFQueIKhiPMTspiq8NKcPrItYTQLbEcmW6UvMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvY1ggft; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IScQh012198
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OL3LAbXldIQiGj9Ib++uS3oFdqJcW9ykoQXFxLINnAY=; b=TvY1ggftz6BE32OF
	Nclb6oOybWq8wGRnqMeXd5+pOSnQSq29FyZOgA38F8lQq9YOzxGK9leBkRuXhtx9
	nWJpu1WJsorwZcDYUCBHJn+hsArsh996XcT6BFeFYZjWC/N7PZcmyZWHODp/C/yu
	kVU/4lh0qrlcglAqvjViUrNYnS4g0q8tHXakx5nFIgEA8b2qy/EE0+kly5QiFbN4
	1+wq64JE0FSbZ3zinKawRbdPu9y2gzI27SDPBINYNF1XRHPdNCrnInRHtoiTw83P
	6mN8P2cyD0L6Qi1yAiEKP2GVqWMpfTCHETYWWQFT1hSEwPaJ14MdjBBxGoVPzeuG
	2v7pog==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj5py1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-726aec6cf9fso38512066d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032727; x=1757637527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OL3LAbXldIQiGj9Ib++uS3oFdqJcW9ykoQXFxLINnAY=;
        b=ZbYQhGF6h8W7F+aqOPHXZA8iKZOGFK5CExt8LQHhEgO0eDdfIynMHclCH67CZGrxeW
         0Jq8j/D6KUAsRsYB+4uCP2LLMWunmwI3G3WUcsCV7DmaHWbYYSjqCN4cl5Ns08VM/UGm
         /Rl5vIfDXzIllAvGlrMtXPi7tmh4BPl1moc6p5Qz3eR8EktfiYpESx3tZ+JWAIg7kqFx
         Kp9tusetaoLIFRUFwoyLku5gxFuNpuZOeI1CRXOWqNBQF9Jyi6gKTAYkCtS0a7CQ/QM6
         FUKGicY2bA7r9ANDUM08bk9C6MM9nmkQjuya+eaxuYlkKiv9evdg/xTL9EuhwvTfue8M
         VnQw==
X-Forwarded-Encrypted: i=1; AJvYcCUbhP/qmih3z/pN55PWc5DSulx+HdJ2QsHemnHaC2hZ7lRXbfB8gSwF3dOeGTvvBXo4swhZBz2nHYVAfdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2i5CKJuHp06RWi7r/WUFRgW4bRsaIsfZ3I22q7/MESjeYWAIw
	wyi66996hpDW7S6+lU8AqtIqxs9qRJfSWWMMGmwMAUubj37J13fr7JIdYwk4aYGQEmaedl1gk2U
	I+9UFf8i+1QyTa4E87iPMJ77p6DZ3pkC14iNzwFRDmoMUXCmciiAck2BjbRDFMIfy9EE=
X-Gm-Gg: ASbGncuXZxgcvBgtpdf9TfUWkshHDLa6hExBYgHTSFG4PNfgCC4PEFehFItqXJ4dTtM
	RWNN0i+iD8Jlq0slEx3li3bdVDdB16lA5XPT/SOrdWiHz52DM+OAGw7PWJLNFAL7YKVCknsjSG1
	3HrDvibW4dsz3tVya9vdQkN1vDt9b6lKD54wXsod81UravBF3MX2GoWe3cw9vnMuXBQscnkztxd
	N/xhAzfhGwqT3/B2is5bGqewnNW3iVInZpvyNaqwCXbQY7ejcRFNE8stEkYEp1RaZ7FeCXN6yag
	nyRfJYAH2PiXA5KxHhf8ls4TsIiUwLRZJfU85j988OoeKdO4x28gSzhGNEPrl96wZXCkm8Qrpwh
	CdYu9exSKIw8k/e1QnZmeyaurf2lAx3OprjtVJ+prydFAsciga/Jv
X-Received: by 2002:ad4:5de2:0:b0:72a:e803:f76b with SMTP id 6a1803df08f44-72ae804018bmr42147426d6.19.1757032726818;
        Thu, 04 Sep 2025 17:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz8kxuYrUIpJzDp5rGUNwTXMjhxk0pkTF+4eceBdshBoWIPLL5cOkNdB9Lv+VDrEIdNsLHYw==
X-Received: by 2002:ad4:5de2:0:b0:72a:e803:f76b with SMTP id 6a1803df08f44-72ae804018bmr42147166d6.19.1757032726379;
        Thu, 04 Sep 2025 17:38:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:32 +0300
Subject: [PATCH v2 03/12] drm/msm/disp: set num_planes, fetch_mode and
 tile_height in INTERLEAVED_RGB_FMT_TILED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-3-7a674028c048@oss.qualcomm.com>
References: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
In-Reply-To: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5031;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ec6ILQ/MERXTAPVK3p0IrR1LWDecA4ARKM5wLiwsDmk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEJsVz89rmAldH1rvVO9fcAm9fkaFPz4TZ4b
 h8z8b7SOguJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCQAKCRCLPIo+Aiko
 1WvgCACXS/BhzzYc3B/78wRyweVo/RuimjNRjDQ8SH5WQpgAK97Wvg8F+TM+rq07OMry/GVn/yZ
 wdUGy7Gl+qtr+fDWVTYxcjn+EP3zZJ4DF68kHQbUKTgVDOl/KzUEkAbCw4q6iWSGRvEr3lckISG
 4Z5r3m5cKAGaAa6LYo0YJ5Ubf9GzcBdqDYwyEGdXd2r9I+9quStGAZunzNLfEOa4X3E4DX6Ezcy
 dMDYlR22YeK3qILhYjxFKCXt1V9f4wsGGsT7P6ZqIMxdkrn3e2i1vkJZsdkdJ5yJAexgq4lZ8YB
 YCIx9U6R+SZpEKikmaphLXrwYXcbfsYvmlt7eI//R9DqDESt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX1qh0C4A6ZlCT
 N5APdKT4cCiYZTfkIgjKvRzpChsWQ1tjDm9aVJ6ZI2ZfY+yRMD1m6dPF/8r4vMBEmhK4zA25OSj
 zfib/lP4uI0ULhrHE+e4a2DO3qDgb1hRz7WK+cNKL++5dQrsiDAfVHF3zS4z6jp+B1AHEAD6+xy
 CWkCsJxFZiTcMfRrPbtNwwzej2yIRHPTJ5dX/9awvTVe3E88WnDXmFw78Q5SgnWT2jqQMZn7hqw
 pcRglolcnvXTH5Oezr5b2j6ESi14H5Gab4+FMIe/adp3LcYaZsCBLDNnz47cOyr8UENJe/NZCh+
 ow7E1Be6RKdSj1+A9p+UlVlB+IZgqfXEglbzSmwvRmlO1POfm00v+cohqKI5ziQrp2zXnEvMSdR
 7lqtXwI7
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68ba3118 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dmvhxJvSUNPaeTh-JWgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 05ob_-CEjbUJBlhaNmO0U7RByYFlEpo-
X-Proofpoint-ORIG-GUID: 05ob_-CEjbUJBlhaNmO0U7RByYFlEpo-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

All interleaved compressed RGB formats use only 2 planes,
MDP_FETCH_LINEAR and MDP_TILE_HEIGHT_UBWC. Specify num_planes,
fetch_mode and tile_height directly in the macro and remove unused
parameters.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 26be35572fd2ee7456401aa525cc36025bc52ee4..09a5bffd838b8a4fd3c22622e82dcf9fb99b5117 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -87,7 +87,7 @@ bp, flg)                                                                  \
 }
 
 #define INTERLEAVED_RGB_FMT_TILED(fmt, a, r, g, b, e0, e1, e2, e3, uc,    \
-alpha, bp, flg, fm, np, th)                                               \
+alpha, bp, flg)                                               \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
@@ -100,10 +100,10 @@ alpha, bp, flg, fm, np, th)                                               \
 	.chroma_sample = CHROMA_FULL,                                     \
 	.unpack_count = uc,                                               \
 	.bpp = bp,                                                        \
-	.fetch_mode = fm,                                                 \
+	.fetch_mode = MDP_FETCH_UBWC,                                     \
 	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
-	.num_planes = np,                                                 \
-	.tile_height = th                                                 \
+	.num_planes = 2,                                                  \
+	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
 }
 
 #define INTERLEAVED_YUV_FMT(fmt, a, r, g, b, e0, e1, e2, e3,              \
@@ -487,14 +487,12 @@ static const struct msm_format mdp_formats_ubwc[] = {
 	INTERLEAVED_RGB_FMT_TILED(BGR565,
 		0, BPC5, BPC6, BPC5,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
-		false, 2, MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		false, 2, MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(ABGR8888,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_COMPRESSED),
 
 	/* ARGB8888 and ABGR8888 purposely have the same color
 	 * ordering.  The hardware only supports ABGR8888 UBWC
@@ -503,38 +501,32 @@ static const struct msm_format mdp_formats_ubwc[] = {
 	INTERLEAVED_RGB_FMT_TILED(ARGB8888,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(XBGR8888,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		false, 4, MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		false, 4, MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(XRGB8888,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		false, 4, MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		false, 4, MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(ABGR2101010,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(XBGR2101010,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
 
 	INTERLEAVED_RGB_FMT_TILED(XRGB2101010,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
 
 	/* XRGB2101010 and ARGB2101010 purposely have the same color
 	* ordering.  The hardware only supports ARGB2101010 UBWC
@@ -543,8 +535,7 @@ static const struct msm_format mdp_formats_ubwc[] = {
 	INTERLEAVED_RGB_FMT_TILED(ARGB2101010,
 		BPC8A, BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 2, MDP_TILE_HEIGHT_UBWC),
+		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
 
 	PSEUDO_YUV_FMT_TILED(NV12,
 		0, BPC8, BPC8, BPC8,

-- 
2.47.2


