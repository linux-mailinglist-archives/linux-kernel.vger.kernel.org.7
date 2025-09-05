Return-Path: <linux-kernel+bounces-801864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7174B44AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BA21894DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCA1DF979;
	Fri,  5 Sep 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UWefGyFt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A831D90DD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032739; cv=none; b=PtI9SvCxsEkVFIDScqIQhA6yoouzG4RDhoNFy9kNNHr0Z2y77fsqSLq/sDAkFANv+z5AVm1OlE3IqkqCNcsbglmT8qjU3YirlmjRA7vQyGFrZ/qyFvp+NmkPBYU/rEtY2OdB1+6JidD/xJzcYIoY3BHnZh1aWSrvjMrgeYIwGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032739; c=relaxed/simple;
	bh=nMuJPm4tujFlIG/Bup3ztoIZhnYNRrxCLxzIl0hHDn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOPz965ZoK+M2VolUP+lTEYnQAIsTLxgT/fgB+o/6JwWFpBv4ESZnZHMBQyM2t7jz4lQ04dZXJtfwtxI/6jC2QR5z/tkNmjk5YsDOL9un/FNK2VdSZSvZBgqssxwQahHqpdmyufXXAJ3ABk6Un4kvfqGlJtnBhOCzWH/h/0cNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UWefGyFt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IJY8J022166
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZyJkojl4OO+NqHoy56xIqffWCIUCiH0xVFBe9iXAOPk=; b=UWefGyFt1qrq8EcA
	vjqFtGkxRLEtNbPbGIVabKUqnMh/X7dnSKLeeKYvh9yR1geNxmrk0dqbnYITQdg1
	Mw2x+3Tb0ZDll49/1p8yuddK7Uu9Up4Iz/BZmFtteicsTg1pDT4irpAO3JofFY3Q
	IoBEYsw/NUH4TE3t2o2olSWnJI7Y3n/jS2CBfjldnwBip+acbLEmDzkjbAV2MBql
	N9yDJYy/2ffdChxOxc5nvUKZ8g7HRTwQ/J0oEEPLTW8bzOGv+SLu+ntR9179AbF8
	0w50kLXAIj3WCBk+zU1awBuTcylM5kfMLbQSCwgiLb7GC/B9SNRUf6qw6wM/j+o4
	Y+BnZQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk994wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70ddadde46bso29046406d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032736; x=1757637536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyJkojl4OO+NqHoy56xIqffWCIUCiH0xVFBe9iXAOPk=;
        b=G0DwuY1AjxYW+QMkzdinRhe69xYMQ0VX6C1G7MEK8Ubt6I66qUtV6MBqq+PTADviC4
         kJmhQMISGSnekh9Pd3eTLJ9qWo9LIZku6u9zFL/qvLGn69N0F+NMYrTK2fdOI1Z+vsyb
         sZkVa53anNzMs0/zRyMOYdUQINOinI5WIMwlWZMN5KSNboqVhD7todf9xYDgBMQqM2dl
         voAFA3etkiKZ/FROJW3XDfojMr5SREc/Gx8DwuogBbKknZYgj0Qs7PVtNM+da9WpVH3K
         Y54NiNFg6uvfzu0XKj2XVs2WPvH4X4uxFWT/2mGsWGIApTkQtmbRm5D5AmXQpy6C0C1Z
         8swg==
X-Forwarded-Encrypted: i=1; AJvYcCW/3lRbs0TD1DZ92VQrUIbyez4blYxQWbzj5jMGV8DzQESGVHORgg8/CdAh0/ukDz3q0j8ZPlHBxevlWLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleU51fVCWcJgwZohepekD6r7O3EORlDiKmKXNS0KmSKOUngUw
	pOKlWKJ4dNubSgacPauum+3ocMkncB5tEBs9NFHhwKd1XO9e/yvXDtxyI+jLC+Zln/tCHq8s3ZN
	fueRRHmkZ9GwZPF9Pv0DQ+/GDJef1TFSmsBpu5eWMvZGpRYcdSJHsPxJYwucs5xCZ1S0=
X-Gm-Gg: ASbGncuJGCjtIxgPFWucMxERW3VATRTu/RweYEzOjU305gc6WGpycYR3xn/Riy4lJZl
	fRBLIO0skwgcmlOSamq0Ufouu5pNB4NGnb22g6vbci3c89fiGkJnsepkyh1adV1Anl1IeLl76Lv
	EPf3685kPW2wfZ9fG0S7aEc7gHJLnNuNO2k/WgaQ1b4XPcKnq002Tm4UPIsKwCjXD3ZjywpCe2G
	1dyiwfyAepQP1UvayFaJa1NSEarBSySdfBADepAJVJn69/D0RlAMeUzwV18vuOPUsL2xf1pSwj+
	4fvHrSFrR8uXQRE+oEDvUtMgngBtfaYEmurZ75Rdn+Pkz11TG8PCWpw//DwQwlIpQUogyRHc8LZ
	tg8Opl2XPVWpVjNGy7d+mC1JOOtbKJlk0aw/P1Sc7gf1cXKyTuQE6
X-Received: by 2002:a05:6214:21c6:b0:726:d08c:854 with SMTP id 6a1803df08f44-726d08c0a35mr92458166d6.61.1757032735316;
        Thu, 04 Sep 2025 17:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXpqU6DEyIjF4gKMfYD5tqp9Yph5/UllP5v2CM9Jbx6+l9n/cRjRpOP8VxxLph/+7TjHHjjQ==
X-Received: by 2002:a05:6214:21c6:b0:726:d08c:854 with SMTP id 6a1803df08f44-726d08c0a35mr92457806d6.61.1757032734861;
        Thu, 04 Sep 2025 17:38:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:35 +0300
Subject: [PATCH v2 06/12] drm/msm/disp: pull in common YUV format
 parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-6-7a674028c048@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10606;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=nMuJPm4tujFlIG/Bup3ztoIZhnYNRrxCLxzIl0hHDn0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEJzwYec9KjIa9RaCQxdCGG6SEEIwhb25qxS
 NzJyLf4sSOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCQAKCRCLPIo+Aiko
 1ZJ8B/4zKS4eAvms6HU0jPUIr6ZRkuq4uw3aixuYcGfYLgfieCCWAf5rbGt+rRp67aR1XmfWkN3
 ClxXs0Ei903rFb6H5xB0l0d3BYgLowlVzgMvhM46zqlvQXK3WpJC8kBWvU/jq77LrCY7dUigyYm
 SZOIP+nx2xNyJWluxe7+d1u82GePJhDQk75ba5yq5wqAd+0fU0R1Y52e4/qhBRJT8d3G+wQmVBY
 ObNDi24dHZc6nQX8SSmJkEXkafpV4SroUuiGSRp3XmY15ys/pQlne/1BIbbxd1Q+/njsathXh44
 6fiExcZdXDDi1Iyk1l8f2VCj15peZ/EZ3iwMJ7ByhAFddhAO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5gzG5d8syV3GwyMJbRgLvS0MlV2PImHr
X-Proofpoint-ORIG-GUID: 5gzG5d8syV3GwyMJbRgLvS0MlV2PImHr
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68ba3121 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=J-CC3KfA7NYzMh5jGAsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX5hT5jB8070dI
 8V19vtH+38xl26CMh8BL7xCIWvNdodfcGYeiVgxhcFXxqPeAOcCrv+9ByT35LiuYlKCmT6h8Kb1
 iOgphIcpIRYI6I5r9vNqgAKmrgDPebFd1h75Ea16hUIuSoqvAz2mdF1g3Wcq74MnLRj2VTLMnpI
 LIzOVeeIo9eu7kugvHIQ5PbIBu5lfo2/Psh2SVa5+3ZtAWgdyDJ2on8UKmp8i849cEO3/zEzPnE
 ZBvvYzJv8d0+B6izj31aaMkievA+f6fzqFR5YBj3vnZhrOXY8HtD1o3BTflZ7A89xEUmlZM5nbN
 ePPj/YVBmn7oxDJ49RftY9lqlxqO63+ZhpjPtIBKX5IVUMGlCxtcTYP6+g6QfeLFkS2+K6GxbKY
 dQYBgijK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Pull common params of YUV formats into corresponding macro definitions,
simplifying format table.

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 120 ++++++++++++++++------------------
 1 file changed, 56 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index d577b3d53fbebced63792b5c65f50dd45211c8ea..900b2de252a6eb2eac3d0670f1aaa77f7520fd77 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -244,27 +244,27 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
 }
 
-#define INTERLEAVED_YUV_FMT(fmt, a, r, g, b, e0, e1, e2, e3,              \
-alpha, chroma, count, bp, flg, fm, np)                                    \
+#define INTERLEAVED_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, e3, chroma)     \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
-	.alpha_enable = alpha,                                            \
+	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), (e2), (e3)},                             \
 	.bpc_g_y = g,                                                     \
 	.bpc_b_cb = b,                                                    \
 	.bpc_r_cr = r,                                                    \
-	.bpc_a = a,                                                       \
+	.bpc_a = 0,                                                       \
 	.chroma_sample = chroma,                                          \
-	.unpack_count = count,                                            \
+	.unpack_count = 4,                                                \
 	.bpp = bp,                                                        \
-	.fetch_mode = fm,                                                 \
-	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
-	.num_planes = np,                                                 \
+	.fetch_mode = MDP_FETCH_LINEAR,                                   \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_YUV,                                     \
+	.num_planes = 1,                                                  \
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
-#define PSEUDO_YUV_FMT(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)      \
+#define PSEUDO_YUV_FMT(fmt, r, g, b, e0, e1, chroma)                      \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
@@ -273,13 +273,14 @@ alpha, chroma, count, bp, flg, fm, np)                                    \
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
+	.fetch_mode = MDP_FETCH_LINEAR,                                   \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_YUV,                                     \
+	.num_planes = 2,                                                  \
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
@@ -303,7 +304,7 @@ flg, fm, np, th)                                                          \
 	.tile_height = th                                                 \
 }
 
-#define PSEUDO_YUV_FMT_LOOSE(fmt, a, r, g, b, e0, e1, chroma, flg, fm, np)\
+#define PSEUDO_YUV_FMT_LOOSE(fmt, r, g, b, e0, e1, chroma)                \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_PSEUDO_PLANAR,                            \
@@ -312,13 +313,15 @@ flg, fm, np, th)                                                          \
 	.bpc_g_y = g,                                                     \
 	.bpc_b_cb = b,                                                    \
 	.bpc_r_cr = r,                                                    \
-	.bpc_a = a,                                                       \
+	.bpc_a = 0,                                                       \
 	.chroma_sample = chroma,                                          \
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
-	.fetch_mode = fm,                                                 \
-	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | flg,                  \
-	.num_planes = np,                                                 \
+	.fetch_mode = MDP_FETCH_LINEAR,                                   \
+	.flags = MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB |                       \
+		 MSM_FORMAT_FLAG_DX |                                     \
+		 MSM_FORMAT_FLAG_YUV,                                     \
+	.num_planes = 2,                                                  \
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
@@ -342,23 +345,23 @@ flg, fm, np, th)                                                          \
 	.tile_height = th                                                 \
 }
 
-#define PLANAR_YUV_FMT(fmt, a, r, g, b, e0, e1, e2, alpha, chroma, bp,    \
-flg, fm, np)                                                      \
+#define PLANAR_YUV_FMT(fmt, bp, r, g, b, e0, e1, e2, chroma)              \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_PLANAR,                                   \
-	.alpha_enable = alpha,                                            \
+	.alpha_enable = false,                                            \
 	.element = { (e0), (e1), (e2), 0 },                               \
 	.bpc_g_y = g,                                                     \
 	.bpc_b_cb = b,                                                    \
 	.bpc_r_cr = r,                                                    \
-	.bpc_a = a,                                                       \
+	.bpc_a = 0,                                                       \
 	.chroma_sample = chroma,                                          \
 	.unpack_count = 1,                                                \
 	.bpp = bp,                                                        \
-	.fetch_mode = fm,                                                 \
-	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
-	.num_planes = np,                                                 \
+	.fetch_mode = MDP_FETCH_LINEAR,                                   \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_YUV,                                     \
+	.num_planes = 3,                                                  \
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
@@ -511,72 +514,61 @@ static const struct msm_format mdp_formats[] = {
 
 	/* 2 plane YUV */
 	PSEUDO_YUV_FMT(NV12,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		CHROMA_420),
 
 	PSEUDO_YUV_FMT(NV21,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb,
-		CHROMA_420, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		CHROMA_420),
 
 	PSEUDO_YUV_FMT(NV16,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_H2V1, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		CHROMA_H2V1),
 
 	PSEUDO_YUV_FMT(NV61,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb,
-		CHROMA_H2V1, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		CHROMA_H2V1),
 
 	PSEUDO_YUV_FMT_LOOSE(P010,
-		0, BPC8, BPC8, BPC8,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 2),
+		CHROMA_420),
 
 	/* 1 plane YUV */
-	INTERLEAVED_YUV_FMT(VYUY,
-		0, BPC8, BPC8, BPC8,
+	INTERLEAVED_YUV_FMT(VYUY, 2,
+		BPC8, BPC8, BPC8,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C0_G_Y,
-		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 1),
+		CHROMA_H2V1),
 
-	INTERLEAVED_YUV_FMT(UYVY,
-		0, BPC8, BPC8, BPC8,
+	INTERLEAVED_YUV_FMT(UYVY, 2,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C0_G_Y, C2_R_Cr, C0_G_Y,
-		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 1),
+		CHROMA_H2V1),
 
-	INTERLEAVED_YUV_FMT(YUYV,
-		0, BPC8, BPC8, BPC8,
+	INTERLEAVED_YUV_FMT(YUYV, 2,
+		BPC8, BPC8, BPC8,
 		C0_G_Y, C1_B_Cb, C0_G_Y, C2_R_Cr,
-		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 1),
+		CHROMA_H2V1),
 
-	INTERLEAVED_YUV_FMT(YVYU,
-		0, BPC8, BPC8, BPC8,
+	INTERLEAVED_YUV_FMT(YVYU, 2,
+		BPC8, BPC8, BPC8,
 		C0_G_Y, C2_R_Cr, C0_G_Y, C1_B_Cb,
-		false, CHROMA_H2V1, 4, 2, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 1),
+		CHROMA_H2V1),
 
 	/* 3 plane YUV */
-	PLANAR_YUV_FMT(YUV420,
-		0, BPC8, BPC8, BPC8,
+	PLANAR_YUV_FMT(YUV420, 1,
+		BPC8, BPC8, BPC8,
 		C2_R_Cr, C1_B_Cb, C0_G_Y,
-		false, CHROMA_420, 1, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 3),
+		CHROMA_420),
 
-	PLANAR_YUV_FMT(YVU420,
-		0, BPC8, BPC8, BPC8,
+	PLANAR_YUV_FMT(YVU420, 1,
+		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr, C0_G_Y,
-		false, CHROMA_420, 1, MSM_FORMAT_FLAG_YUV,
-		MDP_FETCH_LINEAR, 3),
+		CHROMA_420),
 };
 
 /*

-- 
2.47.2


