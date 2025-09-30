Return-Path: <linux-kernel+bounces-837147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BCBAB8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012681C597F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DD427AC5C;
	Tue, 30 Sep 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maM9JAzg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B727AC3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211429; cv=none; b=YqdGxFLOL50YE9E8xKXduYP+MsYwCl5f3JN6tDmpRDJIQWpO+STQhsz3ZExktlpk76si0AW41dpDveMvKKQBXE5Bg2XN6byxtLvwlLa77kOLzfbt1nlkWM08VQXpeAqVxrN143GPCMQbbhpbuRm6HscLSbPnUxq5QZjIVIzQCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211429; c=relaxed/simple;
	bh=r9oQbEwLVJJDIQbYTusbpAt6OAJRxZxziR2i2dJYHBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcRgkr5dTOEGL+V7E+9MVbHPGpToN+H6ZMVqV5+fH7qw3YFVRW9j4ppyo4yy/hcqfDEnky244moOU8Jf2V62fYbRYHz6ovsbUtP37+SggQUlo5bPbz25q9TQUjZV6mgnhTphVkw518K2rZmp4DtfAz3z4s1wuHyrsdEvm0sT20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maM9JAzg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HNH5017533
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5DcOYuuJJ+cW6vFNFMyOqLHX/YGKWTBxTGWvOie70iM=; b=maM9JAzgC8bn3UtP
	bK3l9Mr5pbIBVnd51dGsizmhHoKWbbpPi/8nG7N4p9sJEp+cARaCmUjI/BafMMBS
	OShbyK0S7NsVakVVhBPMC4di37if5ePlKzRjD+GcdQ+CjyaUmHzJt07bNQu42aDB
	nIlUYI6k8sfMZbjTEQKa41YRiaeXreNbDHN52R5E/qafzwncU7iaFwjom1g8Rb1f
	Hv4nzvTG68XgnXz7uoQMVUPqb7cA9QMwsFlMM1lj3AHvrhfTZ+8Rlj7Jzd09iudx
	tO+gOPVF28/UYIXaIVF5CW51UdhMXIA0SlO0BMYVP8hrofLC9foRJ2DHMtvG470Z
	SC9o0A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tqvnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befd39so10658020a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211425; x=1759816225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DcOYuuJJ+cW6vFNFMyOqLHX/YGKWTBxTGWvOie70iM=;
        b=AR//aiGkbC8t8J4oaHIOsze5lSxnsLQML0bXrryD9imkk5o5bl/K4iKTRwbBlkLh8f
         +Vh+553GDYGLSEuHUYIsMqeqZw7GCDmbPbsRSxnZ65L07twsvzDB/qpCIaqXZB7BhFy+
         IwW/21jQMQ1W4kOsLhw9qNkDt+OxQJMD7cbqRkh4Ijskf2A7qJsJpJFg93wADsqoyjhC
         QXe9No3ME9krCGdZ8Oxp0vHxgpjHbULSOl4WQKZ38CTbDu4KZPaiGvMapCuxUmatxCU5
         O0Jn81pUVV4Kh1Zuk0zcz5XHdFIfOhY6PhA2b+JLNaD45H4M6tD1Cxn3pzS5vM2rYYOH
         9XBg==
X-Forwarded-Encrypted: i=1; AJvYcCX2YO5v+PyIKL5NP3TKqXAXdDbDx08hThQM+tmFUP/bySb4188RyCxOep1+b3H7qLcrr4CMdVj7RsDMEhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5M019lKvWWxsjIw4n2neZtpzZE07ZxaGLo3bcW988AsxN6Qb
	AY4BMAi9twHSL9848vHfpGigfoyFh9q9BcR5SpEJhpVG050TuMUzMnAQEh2BOT4meK0GLFoOeYY
	3deix7KgaR3aDaHs1b3/w+v7lIqS2cspyYv3mUyJoZ8n1g5YMVTfym3oYijX6k+k3chjMwJ2ETR
	c=
X-Gm-Gg: ASbGncvfdQ+/V4vU9Oyun2Nf5SxsnTCkXtiCMVBq0td38a9DzgyH/+bp+22S4S8Emul
	h0WI0flzqjTQFeJ05C7a0H5eabwRAq7Tqo953ttiuBWwmUxfHhPq4B8GK9iFNmwXzuJtz2ufouf
	VSJ9jBsMVEidGjxj4UGrEFAIalEYjEy0q72W1/61jdb/vtIbFX2rg+WYjVhyV7Fm/+GvphXW2dL
	fs1Ku60JqdhIypWHIw98e5m244fbOyyHUeZH+J68EnM+YTfsfrYniVyOjzt6a7QEmOnwpFeRBaf
	W0JgLhn7iauJp2I51sHDYB94URIgotGM25YyXoD35jkXqZJlFL+OlBbXja89fVm40+4vuw==
X-Received: by 2002:a17:90b:2684:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-3342a318acbmr22583480a91.37.1759211425536;
        Mon, 29 Sep 2025 22:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUIQWH84fqllYLQOn6xvNXBsEPOR+cZgKu2hLJ5kpoceLfbQeC3W3x6mtJBPFDPhqUZSJFdQ==
X-Received: by 2002:a17:90b:2684:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-3342a318acbmr22583460a91.37.1759211425055;
        Mon, 29 Sep 2025 22:50:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be23412sm19029779a91.20.2025.09.29.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 22:50:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 11:18:10 +0530
Subject: [PATCH 05/17] drm/msm/a6xx: Rename and move a7xx_cx_mem_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-kaana-gpu-support-v1-5-73530b0700ed@oss.qualcomm.com>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759211380; l=2329;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=r9oQbEwLVJJDIQbYTusbpAt6OAJRxZxziR2i2dJYHBs=;
 b=XtsAQGS6JKr43XfgTE3f3PxKYwJMKqXqAQxlF0DEooff7/mkggdbd/tl5m3RDE7pPZll3vDo/
 khRRRuP4zrzCfhmz8gkqnP94SAjFhZEUgylnY6MbreRTFexF/VIk2LO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX4QpcYQJEskiX
 XMehafpOqzbJI9+ICgxOe6ZReFUr+20aOD3X1PluAaIg986EO3rZYqxqUT0Htszoxo8YYzTGKzq
 BnGX+LDfw2ePk0Jgvwyk3Cg5bHC+p36hgE1uH5rdHgo2anb5IfKSqH7vSFskzsBzDclxpsJ2oMh
 D8hhJDYBzl2AmmsvuTjd6A03MK48piWAHX8vWi8wORibUB8Kfpb3R6SMh4o6NL9gIndUn78UQek
 jwDvT5KAsp11RqF36KaOvlCP7ptXZM6ooL6UIbO7o2DuRrgSUUQMx2NenveCgVJenfz7Ofggyye
 Lm62ICJZrxK8CLA7HjkJSfdgze00hPiMbvnL6ZzHS313c3wf1X/NBEC2B0CDcX7LLOnsrzxdfzH
 L5Yr03TOZRYFFt2Y7mhqSIlgnvxbdg==
X-Proofpoint-GUID: 3Vkw3CeFQcbiSe7KAPW9fAa2qCwshAGT
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68db6fa2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HijK2bQ2CIbjB8v2WwsA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 3Vkw3CeFQcbiSe7KAPW9fAa2qCwshAGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

Rename to a7xx_gpu_feature_probe() and move it to adreno_gpu_func list
so that we can simplify the caller.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 11 ++++++-----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9cc2f008388929f0c8e8f70a3e3e79fb4d35ab38..4be0117c3ab1d56dc81b43ff00e3cc48b02b080f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2065,10 +2065,10 @@ static void a6xx_llc_slices_init(struct platform_device *pdev,
 		a6xx_gpu->llc_mmio = ERR_PTR(-EINVAL);
 }
 
-static int a7xx_cx_mem_init(struct a6xx_gpu *a6xx_gpu)
+static int a7xx_gpu_feature_probe(struct msm_gpu *gpu)
 {
-	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
-	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	u32 fuse_val;
 	int ret;
 
@@ -2621,6 +2621,7 @@ static const struct adreno_gpu_funcs funcs_a7xx = {
 	},
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.submit_flush = a6xx_flush,
+	.feature_probe = a7xx_gpu_feature_probe,
 };
 
 struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
@@ -2702,8 +2703,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
-	if (adreno_is_a7xx(adreno_gpu)) {
-		ret = a7xx_cx_mem_init(a6xx_gpu);
+	if (adreno_gpu->funcs->feature_probe) {
+		ret = adreno_gpu->funcs->feature_probe(gpu);
 		if (ret) {
 			a6xx_destroy(&(a6xx_gpu->base.base));
 			return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 77b1c73ff8946fb0f8ff279e16c973cade50c130..5abe442637e321fb996402fd833711f0a948e176 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -75,6 +75,7 @@ struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
 	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
 	void (*submit_flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+	int (*feature_probe)(struct msm_gpu *gpu);
 };
 
 struct adreno_reglist {

-- 
2.51.0


