Return-Path: <linux-kernel+bounces-776657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CBB2CFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F05205C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C638274FD3;
	Tue, 19 Aug 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrRQ4pbQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8A270EAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646158; cv=none; b=t9OUZql0bUxRxEZLKpqmEgpVAMJnE2g3RUFJN7PePjvlAkkxr808lTmPf1Fz1IJXCudCbhO/4uUysgocSyAXsfu5B2PKUbK4RwAvPMyGGYj7wVYF/bBHh8BKO+qQkowZ0of50y1htkmHACyeFHvHomClJofU+O/S368aopac/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646158; c=relaxed/simple;
	bh=TZW3VxvhUM24qUwSzazaXCqg9DEgEYWXWf+PtMArXF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRjQRWlAfA/Po6WK72xe2Qcu2gimmJjQ22cr4fiHBk5B0pN141ivZC63Raobhe3p9iE0d9VK960kT3guZgzmW+nz0/4S0bCCw9ALPFYelFi8/d6WGaiLZT2ONewZS7vBKAZNEau05Aq6EOlXbDf6oE4Y6fAcUZvvHip5AR8L6zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrRQ4pbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL139Z027571
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eorQnuKwFmy
	2NP3qxzCVt5IHD0p6HNwhfpue4EH5fbo=; b=PrRQ4pbQgGU3zIbwI6WUS/i+lbb
	QwgBCdLHKiuGmdVJhDU70Kzzp1XfZraBmqmhhuYi6zCCV8p1KjAyWLGclhjWB/NR
	49KOhpakQ1bvvAAUukhZBfOjZNt9pI+k9qjqiWuVu3GnPxCp7+5/Vioha3slOf0h
	GlyrLJyPTiSlG8ekygsd1yierTJ5YcC5KVA3X9lGADoFh++EbH9lAQHNea+GI6us
	HW/TtS8ePp56MxRIUYSF5obBvHOoW6DzXUhH3jZqnRgxTr+q9ByMpj7HR5ms32h/
	7MsxoC5x6smZzogi+ola7robDSTkdSki1Tsg6TvaF1LLqBinpE8iKJ8wuCw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0th08g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:29:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso64855985ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755646154; x=1756250954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eorQnuKwFmy2NP3qxzCVt5IHD0p6HNwhfpue4EH5fbo=;
        b=ISUYNJlicN2BVRolY3HATffsAvz4JsIY8Zi7J0vD03By//v2/+SCW1etjQVW1RyAPF
         i6jDmMnwEfcbYaWILCCL15I1XSvlAHryk//7u1cARCvsFbjeQIVOy7zBMzU58ZnTn55D
         84kGJlFBDmVkHns9eseAYm+ViJ9hXHwNQ3W5nZhh+DbGoqOk8eNDwFYVP61jsuSEOfMb
         NIQyYVYtmpzAf6xhiLVFUtSma/hfZNm/5XYroVGaKfBGRI8ftsMrGUemJKkypXY1mWql
         7KE2oUHhwlBg4I5hvdwdm5CMadd0EUh+wnZFz+kCZwcGAZwmvcAT23zbpqe0vbd9wFV/
         wFGw==
X-Forwarded-Encrypted: i=1; AJvYcCXwdZaac7RpdAWI1wFfp7f3JkeoK4XQfLCdG/reXRBNj78dE9Owaocik8+IGUkNEz0L/OOy6wN2yVxvh2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJ+hQMcCtsHv3CQc5++pk6gafVgg/z3M7UFdRC6Tzgjts7+8b
	czNaaK2qaK3gN9P4Akh1OtULlTZhuA8V5cX25OWxESoJTA8JulgCXcrl9FrJBHc9V2Q8WN5ai7u
	u2u0xSwS8gMdlTBM7flaD/VHgYX3oLpeAEFCB/9KO1jT4JcvgMl6WQfIEtAH9xGukUZyPBJZtqQ
	Q=
X-Gm-Gg: ASbGnctX6hcsSpCRxxZ12oh4tP+jQeNIVn0q8z6UdBWqcqGkMJetXp3aE+wFOimMkCw
	8dcrLo/T9yAaDB7UAswTvRAGrQX8b6vkYP9qYlaRWU10V313XYMrU3UMzu7MSEvgD6iry30uyi9
	RYQKy1LWK5DccKXcI/u4Y4ziatQj5N4dTWrKT8raQvM/2rbfOM6/oq80jL5A6eluamrBSqQkaHi
	pZGqXBvXrP+EPCxZKrMEHg6YfOoxwPaavEuvpNdw2tsUZPi4714R5NWg6DSMq96MZ9RC5GGbzMo
	eteaGIC6+q8Upfhk4EcpRwobsxdA/0D+UDjJRqacdvzzRwR1Nlc=
X-Received: by 2002:a17:903:234e:b0:243:963:2a70 with SMTP id d9443c01a7336-245ef156358mr8027595ad.25.1755646154004;
        Tue, 19 Aug 2025 16:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlmpOombDfq8VbEjWHWMgGH5Q1/mKcc7dH8Jm6GIHXrGX0qRiaR2T3uKoERFwvEKAF5ww/Bg==
X-Received: by 2002:a17:903:234e:b0:243:963:2a70 with SMTP id d9443c01a7336-245ef156358mr8027425ad.25.1755646153561;
        Tue, 19 Aug 2025 16:29:13 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ebc4esm8040925ad.115.2025.08.19.16.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 16:29:13 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm: Fix 32b size truncation
Date: Tue, 19 Aug 2025 16:29:03 -0700
Message-ID: <20250819232905.207547-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
References: <20250819232905.207547-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfX1E9L1dmLsY46
 fEgfLAdPGsQtE1MNnrGbOkM/jwZqzp/+D0Gy9Cd71GmSTZIlD+AMNtdoAoqQcjLD5DJRGjvujWT
 1irBOGFpLFp7SdgMfGx4kUiyaSWFM0QvNqkph2VM5sREGcVM5dvNwkIu970n+0GAFUgSVrv2r+C
 nkW2Qukl7oFG/ZPzaEGz2IEswa6M1toO4rYMd+4F6+EfynqgG8XDdDrh507nnqWGa6453vI3v56
 /pVyncbdDq6gBx8ZVsFAstydPewk9iPtgmE5tXY424v+rYDGGpiu1jADNbwXLtUCu41sTcBD4JO
 Xnb11u1yNOZaZQUaKw0IyFYIth/NYU+UEiTgBqBE6yGTLP9YfYXZMiJ4Ez7zXm95TNh9hQ85wrP
 KY6/eP3KNiMM99ogQmINIAn2GW1w8g==
X-Authority-Analysis: v=2.4 cv=dI7/WOZb c=1 sm=1 tr=0 ts=68a508cb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=EUspDBNiAAAA:8 a=Zku5-IFyaxskcEPfeVAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: zjaePvF83kTzHCj-GaYqIZWeFtpfg8Uc
X-Proofpoint-GUID: zjaePvF83kTzHCj-GaYqIZWeFtpfg8Uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

Somehow we never noticed this when arm64 became a thing, many years ago.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 17 ++++++++---------
 drivers/gpu/drm/msm/msm_gem.h |  6 +++---
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 958bac4e2768..9a935650e5e3 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1142,7 +1142,7 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 
 /* convenience method to construct a GEM buffer object, and userspace handle */
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
-		uint32_t size, uint32_t flags, uint32_t *handle,
+		size_t size, uint32_t flags, uint32_t *handle,
 		char *name)
 {
 	struct drm_gem_object *obj;
@@ -1208,9 +1208,8 @@ static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.vm_ops = &vm_ops,
 };
 
-static int msm_gem_new_impl(struct drm_device *dev,
-		uint32_t size, uint32_t flags,
-		struct drm_gem_object **obj)
+static int msm_gem_new_impl(struct drm_device *dev, uint32_t flags,
+			    struct drm_gem_object **obj)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
@@ -1244,7 +1243,7 @@ static int msm_gem_new_impl(struct drm_device *dev,
 	return 0;
 }
 
-struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32_t flags)
+struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
@@ -1259,7 +1258,7 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, uint32_t size, uint32
 	if (size == 0)
 		return ERR_PTR(-EINVAL);
 
-	ret = msm_gem_new_impl(dev, size, flags, &obj);
+	ret = msm_gem_new_impl(dev, flags, &obj);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1299,12 +1298,12 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
-	uint32_t size;
+	size_t size;
 	int ret, npages;
 
 	size = PAGE_ALIGN(dmabuf->size);
 
-	ret = msm_gem_new_impl(dev, size, MSM_BO_WC, &obj);
+	ret = msm_gem_new_impl(dev, MSM_BO_WC, &obj);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1347,7 +1346,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	return ERR_PTR(ret);
 }
 
-void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32_t flags,
+void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 struct drm_gpuvm *vm, struct drm_gem_object **bo,
 			 uint64_t *iova)
 {
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 751c3b4965bc..a4cf31853c50 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -297,10 +297,10 @@ bool msm_gem_active(struct drm_gem_object *obj);
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
 int msm_gem_cpu_fini(struct drm_gem_object *obj);
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
-		uint32_t size, uint32_t flags, uint32_t *handle, char *name);
+		size_t size, uint32_t flags, uint32_t *handle, char *name);
 struct drm_gem_object *msm_gem_new(struct drm_device *dev,
-		uint32_t size, uint32_t flags);
-void *msm_gem_kernel_new(struct drm_device *dev, uint32_t size, uint32_t flags,
+		size_t size, uint32_t flags);
+void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 struct drm_gpuvm *vm, struct drm_gem_object **bo,
 			 uint64_t *iova);
 void msm_gem_kernel_put(struct drm_gem_object *bo, struct drm_gpuvm *vm);
-- 
2.50.1


