Return-Path: <linux-kernel+bounces-801865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2038B44AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D086C3B5448
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A21E521E;
	Fri,  5 Sep 2025 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAlKFWoy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F221DDC35
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032740; cv=none; b=jPbLprfehDMH9SnVQoMpryX9L1xqK9LioeT3JNaQ4dEDgkB9BU4f1lsOPQdADWj6bZSRwyRyOENPeTlWE1lz3ufk1MVNtepjsvlXGxijOHBX7++8utghQ+gg43kXkJvJ9ry0biN4bW2pVuvMikmyC8eWAiooJwmcrCpZHqYiJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032740; c=relaxed/simple;
	bh=T764qGaUs1J9VFKtvepXHsiXpOOMX042xzB4mztK948=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWJ2iai+fwaUDv2Komofa+rru8f/Gf7hnsqMLrldXkxBBjjgvn6Y7q91+CnSoCDFRlncoI0R5zP6BJqBfHc/FNOAsdNOnUnXt7mnFbem7zx+oDz7WhFSt7sUJMN/9hvNC+SpVv6PNF7LlnspiHgza8tOPwAWsPT17lvmMNinnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAlKFWoy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IScQk012198
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9brpOFp+/3/6vV4g7EI38M1O3ti6c1WPwrR8J+VQwpE=; b=UAlKFWoyVvB7CyPE
	Nlvg0Sg+fFeWVIeDfuo+4jbax5cJ7h8ZXtsS3+dHpihKgxWC93cU3ND5N663+4pI
	xdqefPyl9lJDAWc+uSxHWmBBhHMfYe0INp37Wt+QagDegVmYi/KkQeRwB04Ol3a/
	Yv0BIZy3oyEa+obXQ3SNSaQgqkN4kilIOcNjd75iZKUb+YTJT2JSBYSU3p2uW84o
	1dZnAct7+Mg8vV8UXXzgFTRJX1IplwEE1lbnK+pPfrOWnrCeWWz9M51MoQ2XTpJb
	iiDYbUSO12O066hWaa1Zap4o5GhR5AFpvXjbMkSXWhxCUiRR8VXnxjwu9faJG1MV
	kv1kHg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj5pym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7296c012f86so22178006d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032737; x=1757637537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9brpOFp+/3/6vV4g7EI38M1O3ti6c1WPwrR8J+VQwpE=;
        b=tFQiiMk9q6+km+7V1ZmMWVujysIhY+/wys1XDEIUymJjgBjWpR0j6+vMHVco/kQmDG
         DKxmPStliw4JjZhbb/GuAPvEKEZ1kDRKTca4qYpPnor7l900i1hNIVg8fEifWzBgIJlN
         Adf6ZihzWxgJwxNyR4u2TIf2iLSpbbCJvolkqtqu5dRZ3BrVVoB4/PpiNEs8i+cgDTPp
         mRLENu1Ka1VJGd7+84u6aMp0MowgN+/zE6uasMVqf/6cUg5E2imFMzsT5gjuqlV6xheG
         FncNEH+c4wf8U4SQq/yDCztjGCYpdo46H5cXtbt73kMw8u1TeEdA0gRhJdDJD62MetUK
         CAug==
X-Forwarded-Encrypted: i=1; AJvYcCVK4YWp8jGTOwXQ+sgOjrhVRYoriaZdHBQ2Ma5EAdeoVXpKmgu6udfJTy1yDF6DzaDswaQDSDfzLVkWeIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLR42hXSb72uFZI+2pIzGdfypTnzG/VYIdol+M8TknITwFvZi
	BWPGeJsSjxeEg3k+g9lGf8cCJoMmlND+znzamXPt+2TvtuQLeuO7eGI/e/WSw5M+QMJnonZDVRp
	mJypGGDfs5zajFmE2kB8uc3AL1s3T3NbIbMyMq6GFoECyP4EINU1EKWDJt/JRrVgw9eI=
X-Gm-Gg: ASbGncvZZp/2EtvqcpSdEjsyFxrcxIIXDASIZeHP4ypYhV7tFrwQYYMzEg9t74YXsro
	xRJAcPTbdt/RrKUR+8qLjRDfs3sy4/aDz7OPLePMHIPPOFc+0N2yg32xh3e0xJ6UZMe3xIaBoI6
	8foMrtjLhBj4A1rhRhoRyGi5I8L4XIdUeDfkT92ueJhWOFANTyW4oBdQEHMS2mHG5cY4jlYMXn9
	NPWdj3KUBuw7hHkXWVul7e8X+0WiBlXrYpcE295nqZe7vQh8R6SMjgpNbm12b1sh2zdQwmxHOTf
	XQBV3kH3TS5bKlXt7maPoUfT2JMG0PYXDAzioHZxCrvZKWI4BFHHEbZUJSxBIJHa6ngaTCa9Mne
	NKkc1oRm/LHHXN5HJP91TaXcXmATEjNrch/2wqG3VA/dnUzsPphGX
X-Received: by 2002:a05:6214:2469:b0:72c:cc04:c3a4 with SMTP id 6a1803df08f44-72ccc04c455mr9697156d6.8.1757032737099;
        Thu, 04 Sep 2025 17:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGggptVB7yJzNpKmjyKL+r1E5aqNrdPD/lf2zm9l0aUlD3mzu8IDaTE/VSOjY55ioVtIEDZgQ==
X-Received: by 2002:a05:6214:2469:b0:72c:cc04:c3a4 with SMTP id 6a1803df08f44-72ccc04c455mr9696816d6.8.1757032736562;
        Thu, 04 Sep 2025 17:38:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:36 +0300
Subject: [PATCH v2 07/12] drm/msm/disp: pull in common tiled YUV format
 parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-7-7a674028c048@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3220;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T764qGaUs1J9VFKtvepXHsiXpOOMX042xzB4mztK948=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEKmhozhM/+m0ojp5V0LfFbrvFkofA6W7eN2
 zog3jTw8leJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCgAKCRCLPIo+Aiko
 1WBWCACkbqlPExGRCdiT0UZihOTCLMIN0u56fVd4JKEr4W83H1+sgCf0pawMxOGZCTHPFT5hvxM
 FujC3WWVbcsz1hnM2oRWtPtya6sCIPWKRskqGvJDUsGEa9mW4SP23z9y2AXAk5CgHNcFH9lu7g0
 IeaSCENfkEevQlYsG+m++UAQF+YBbwAI9gEmh2lcqlJG6LFBrkZQz6wPG4Ew9gynLcX5Gl7iSGg
 fQVzC2kJNG94q4D0gQV3mwBX1eqbvgxkfiqY9Ww+ao6uTJBM1ZBucWHIsfj/Ad3oe0m9FbpDFYD
 YIQo8lZLTi8QTq24/iy09Ml0oFMwtxweD1VrgixjGOcT8icP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXwmtYsiZhMgng
 5JnhJTEI8y61dpHkKHcczuiWzUyOqD0aolO5F7XCDj0TvVmvhZgXo70jINTChG26KpUDg/WL26S
 lQru2cnzEaKqlpaq0Em6ESegn66SJSIQGlP7lkX9wtTV871C+41WCeCQtluOjiAyehMDGwNi7nM
 pP+YdVWCcapPXcGFvZGCWptvX/GBRgHvmflMELrpCzqLotDKbUPUc4p56BTkm7GqNxm0RvV1nCW
 2qUUHmi+JGkfwLS/AdMOUH4UCDAph6Iyr/vw9KmzM7dQzrHc6HH7BQXgLRCZ4KGaoTEV5C3vxuz
 mjmhoqIJkHtMOALxt4zRFNnLy+MgPuaaTOyt0KMISDZRh4x8A0Hz7h6HmN6qLr20GKYBx1sH4pV
 PAshB+4x
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68ba3122 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=FCw1dLDEiFPyt24oSuoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 10MqLYBiugtvy_FRR0hrI5Jq4civTRzk
X-Proofpoint-ORIG-GUID: 10MqLYBiugtvy_FRR0hrI5Jq4civTRzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

Pull common params of tiled YUV formats into corresponding macro
definitions, simplifying format table.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 900b2de252a6eb2eac3d0670f1aaa77f7520fd77..79f7f973dbf348acf2c06e66afedeb8f22e7a8ca 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -284,8 +284,7 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
-#define PSEUDO_YUV_FMT_TILED(fmt, a, r, g, b, e0, e1, chroma,             \
-flg, fm, np, th)                                                          \
+#define PSEUDO_YUV_FMT_TILED(fmt, r, g, b, e0, e1, chroma, flg, th)       \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
@@ -294,13 +293,14 @@ flg, fm, np, th)                                                          \
 	.bpc_g_y = g,                                                     \
 	.bpc_b_cb = b,                                                    \
 	.bpc_r_cr = r,                                                    \
-	.bpc_a = a,                                                       \
+	.bpc_a = 0,                                                       \
 	.chroma_sample = chroma,                                          \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
-	.fetch_mode = fm,                                                 \
-	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
-	.num_planes = np,                                                 \
+	.fetch_mode = MDP_FETCH_UBWC,                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_COMPRESSED | flg,                        \
+	.num_planes = 4,                                                  \
 	.tile_height = th                                                 \
 }
 
@@ -623,19 +623,16 @@ static const struct msm_format mdp_formats_ubwc[] = {
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
 	PSEUDO_YUV_FMT_TILED(NV12,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, MSM_FORMAT_FLAG_YUV |
-				MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 4, MDP_TILE_HEIGHT_NV12),
+		CHROMA_420, 0,
+		MDP_TILE_HEIGHT_NV12),
 
 	PSEUDO_YUV_FMT_TILED(P010,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, MSM_FORMAT_FLAG_DX |
-				MSM_FORMAT_FLAG_YUV |
-				MSM_FORMAT_FLAG_COMPRESSED,
-		MDP_FETCH_UBWC, 4, MDP_TILE_HEIGHT_UBWC),
+		CHROMA_420, MSM_FORMAT_FLAG_DX,
+		MDP_TILE_HEIGHT_UBWC),
 };
 
 const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format,

-- 
2.47.2


