Return-Path: <linux-kernel+bounces-708445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35837AED0AE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 22:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5613AFE97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B90522A;
	Sun, 29 Jun 2025 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHTvEF1K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503E238C3D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228179; cv=none; b=Jw59Vv6fB5vIA+Q1T+d1FIxD0EbgD1bO6khqZLsH9uM01PdQDBXndqDgDVY0ljLsLlI+a97xsCyt+vmlKzt0XXqwCOY6Q/R9z0885i440NZl9PlaM96GW/SIj+7Ejp2hg8oRrrDSVNJOwW78fXY9deuanHJ6RQAbXtBYbDayGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228179; c=relaxed/simple;
	bh=Gm6UhJ7UKI9DiYCOXoBXcpqw8slOxn54iQtmUjp8vaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCKBeMie+6QKxObPxlvNCxioRAMdR9VMpqZaEnMU+uYMvJgNPt5G4bJj0Q6L63DBK8Ks2OMPJWCJFLhaX1YsoqSGxLGxfiENvCIHdRNa+bRJfww5O4OQW6WXyf97nIj4qf+FVLKNgmU5PLXjt/P7In1K5uThy6hVcTwkMnvcunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHTvEF1K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TJQL3V008381
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sVxQxqcInWG
	kGdZkfQeRJ3wtUjNtIfv/ihKTiUvsmA8=; b=oHTvEF1KOTyRjmBitWtjfyQi9d7
	RWH6rjdkIlBV0XTeCgeLLsdytj+I2h8iRsq5ZXt3woWHsIBIAlYwnWC5pIGWbw0o
	ZiXFiW785yJdqMj5CFcyo/iNaBlSLA5xenwkDLVPjOZ9KokrCtJo3Rvveqps172R
	wFIIvgRBbZcSfkVKWjZFHyi73rxUvvzSoDTNYfO6PJbfq8aarZjNUl3MWGQsskv6
	Z1MuJU505tXlFRNXb6983TlIBz2QBCJm7nAKcmnlLeagch0T4gfIXJHT1b4sc0jG
	9dUBcqbIPwsTc0w38wHUWmvWqP4i5XCYTtubdQls+Ctsm2eoU+FhAPHriJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j9pcjjc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 20:16:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2355651d204so29539185ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 13:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751228176; x=1751832976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVxQxqcInWGkGdZkfQeRJ3wtUjNtIfv/ihKTiUvsmA8=;
        b=YI+IARqXXo+WLo9DFy9CET7VLS+qDBNNRNj38ozxfzxrUOvCATzdaTgOULtJuVJHxN
         qAFonOz2ninDicK6zEJkxpxR5SRSBdjy2bu/l6qadBA4cTy6GIHl22SsbjKrZjG4Q1ji
         UZTOIMhBmu1Rlo7QftCEkHzihODH5XL0e2eraaj/tSQB9RtBSRYY3FoAKGzxkb278OEA
         59CBx6KBrgvhbdr7wHQ3ZXdmy42xJE6Q0MFwRPOGXWQ4OfAJkeWPyNcvnhzl0C6rPvdA
         CRGmFgUZSJjRiTdKf3aNNN4TTGQjG35BfvgD9+UeMepBX6IgiQMCY/K7nG/w6wu/gF5A
         ByVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs4jvAkW+4ZC7tyafdzIS0VXy70YMMaQyk31ByN5JLflVdO/NV3KCAHXPZjcybT+xwwzswubW0I14WLuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVwttk4tfdIeilgA2tMrM0Q4gI/JRNEZyHGOtGPw9I93zyHav
	7Ea5Tg2IVBBHNnSq0cupi/PJHTjvuWSeZfrv0BMxRofZLNrqRKsDPsbkt/rmb0YWYY9lohaodgK
	0Lm+FV8OL0gtHCG9yHSKjslLf3xdADydrJGQEMn0ZY3RqQkdBXwkP9LwsOuGRA2XKVTM=
X-Gm-Gg: ASbGncuAQ2BbhtqzJpCS7N2xme00AfTwzkoIF2Fx2OBiWZDP2n9Y+Zk6mxXFjMJ7wch
	EqnG/rNJhd6+UQNlGwJxTKoxmtubyUjLIQvHe7kMVroIvVJbhQzSG9RPvICHvviz5rzyTwnVlZE
	HODOAA9KkqEqcE4GIfpGOsLX8qdIeHxufgTq6F2Mc07/e5DXQ7S4gGwbXcGDC7Q/C/CEUZ943Rc
	J5uhrKDloieJbO3hVEKvoudhMxPL1+hXU241d9gNwRocf2EglRDNxMHxHkF5jEWvb7qiuxBPiT+
	1bjVxJ47I3rvchlBnC20ENMeC4jZuOldbA==
X-Received: by 2002:a17:902:ebc7:b0:235:f298:cbbe with SMTP id d9443c01a7336-23ac40e028bmr169451605ad.12.1751228175848;
        Sun, 29 Jun 2025 13:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNbJUtGP9MrWR24HPcC4/u3xJtP1wRXJgvFGUHLgeKLArllLw9NNHdWnW/5xcDbywPkb6T0g==
X-Received: by 2002:a17:902:ebc7:b0:235:f298:cbbe with SMTP id d9443c01a7336-23ac40e028bmr169451305ad.12.1751228175405;
        Sun, 29 Jun 2025 13:16:15 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c6953sm67738195ad.226.2025.06.29.13.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 13:16:14 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Connor Abbott <cwabbott0@gmail.com>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Danilo Krummrich <dakr@redhat.com>, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 08/42] drm/msm: Collapse vma allocation and initialization
Date: Sun, 29 Jun 2025 13:12:51 -0700
Message-ID: <20250629201530.25775-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
References: <20250629201530.25775-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IfrCuKUYkCNnXjf4OOBWh0AywAY9mTN0
X-Proofpoint-ORIG-GUID: IfrCuKUYkCNnXjf4OOBWh0AywAY9mTN0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDE3MiBTYWx0ZWRfX6HVN2cHCcqtm
 yVIo3C86yzLqx248zfNHEWTXgu6O8EIYLabOPXKxHetwxPzs7h4i8ChmCub53r1zE135a0c7/77
 Nk4ylO1zQBqUK0XX/YEILmPvRtyWFPV58GWlJuCiZlX8Djsmk5Ren0qgFLRPKg8hyYocPItz9/h
 sU/Y4NcmlnIYSwW42vzEWuZ12B89s1OZNY5E4wAcMOgve/WQ3In6CalsEOZ3A0F/ukx5PZVDCq/
 zYZfHt+xl40Ta6PoIcO9iz8sDtl3d1w3PYLVkwYGBD+03JL0qJbPxpP/ljEbbMZ66xeT0RMT/1v
 miIk/mBVNX70Q2jMqgTLaWS8LBOcf0Z5kooGVt04fa2YQNJ+vcZogWZbxnYa5fDOXHDeaw0udrF
 ZRd2X71sFQFA6o8eaMGYeDcnsiMTYAN1lkuxxt4RCghkCH6C7BQpuk8XUDZ9C/HOwjhWAKp3
X-Authority-Analysis: v=2.4 cv=QMFoRhLL c=1 sm=1 tr=0 ts=68619f10 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=amM6-9Z1s-9IjK5NNPIA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506290172

From: Rob Clark <robdclark@chromium.org>

Now that we've dropped vram carveout support, we can collapse vma
allocation and initialization.  This better matches how things work
with drm_gpuvm.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Antonino Maniscalco <antomani103@gmail.com>
Reviewed-by: Antonino Maniscalco <antomani103@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.c     | 30 +++-----------------------
 drivers/gpu/drm/msm/msm_gem.h     |  4 ++--
 drivers/gpu/drm/msm/msm_gem_vma.c | 36 +++++++++++++------------------
 3 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b83790cc08df..9fa830209b1e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -333,23 +333,6 @@ uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj)
 	return offset;
 }
 
-static struct msm_gem_vma *add_vma(struct drm_gem_object *obj,
-		struct msm_gem_vm *vm)
-{
-	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct msm_gem_vma *vma;
-
-	msm_gem_assert_locked(obj);
-
-	vma = msm_gem_vma_new(vm);
-	if (!vma)
-		return ERR_PTR(-ENOMEM);
-
-	list_add_tail(&vma->list, &msm_obj->vmas);
-
-	return vma;
-}
-
 static struct msm_gem_vma *lookup_vma(struct drm_gem_object *obj,
 		struct msm_gem_vm *vm)
 {
@@ -416,6 +399,7 @@ static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
 		struct msm_gem_vm *vm,
 		u64 range_start, u64 range_end)
 {
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct msm_gem_vma *vma;
 
 	msm_gem_assert_locked(obj);
@@ -423,18 +407,10 @@ static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
 	vma = lookup_vma(obj, vm);
 
 	if (!vma) {
-		int ret;
-
-		vma = add_vma(obj, vm);
+		vma = msm_gem_vma_new(vm, obj, range_start, range_end);
 		if (IS_ERR(vma))
 			return vma;
-
-		ret = msm_gem_vma_init(vma, obj->size,
-			range_start, range_end);
-		if (ret) {
-			del_vma(vma);
-			return ERR_PTR(ret);
-		}
+		list_add_tail(&vma->list, &msm_obj->vmas);
 	} else {
 		GEM_WARN_ON(vma->iova < range_start);
 		GEM_WARN_ON((vma->iova + obj->size) > range_end);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index e47e187ecd00..cf1e86252219 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -66,8 +66,8 @@ struct msm_gem_vma {
 	bool mapped;
 };
 
-struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_vm *vm);
-int msm_gem_vma_init(struct msm_gem_vma *vma, int size,
+struct msm_gem_vma *
+msm_gem_vma_new(struct msm_gem_vm *vm, struct drm_gem_object *obj,
 		u64 range_start, u64 range_end);
 void msm_gem_vma_purge(struct msm_gem_vma *vma);
 int msm_gem_vma_map(struct msm_gem_vma *vma, int prot, struct sg_table *sgt, int size);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 9419692f0cc8..6d18364f321c 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -106,47 +106,41 @@ void msm_gem_vma_close(struct msm_gem_vma *vma)
 	msm_gem_vm_put(vm);
 }
 
-struct msm_gem_vma *msm_gem_vma_new(struct msm_gem_vm *vm)
+/* Create a new vma and allocate an iova for it */
+struct msm_gem_vma *
+msm_gem_vma_new(struct msm_gem_vm *vm, struct drm_gem_object *obj,
+		u64 range_start, u64 range_end)
 {
 	struct msm_gem_vma *vma;
+	int ret;
 
 	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
 	if (!vma)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	vma->vm = vm;
 
-	return vma;
-}
-
-/* Initialize a new vma and allocate an iova for it */
-int msm_gem_vma_init(struct msm_gem_vma *vma, int size,
-		u64 range_start, u64 range_end)
-{
-	struct msm_gem_vm *vm = vma->vm;
-	int ret;
-
-	if (GEM_WARN_ON(!vm))
-		return -EINVAL;
-
-	if (GEM_WARN_ON(vma->iova))
-		return -EBUSY;
-
 	spin_lock(&vm->lock);
 	ret = drm_mm_insert_node_in_range(&vm->mm, &vma->node,
-					  size, PAGE_SIZE, 0,
+					  obj->size, PAGE_SIZE, 0,
 					  range_start, range_end, 0);
 	spin_unlock(&vm->lock);
 
 	if (ret)
-		return ret;
+		goto err_free_vma;
 
 	vma->iova = vma->node.start;
 	vma->mapped = false;
 
+	INIT_LIST_HEAD(&vma->list);
+
 	kref_get(&vm->kref);
 
-	return 0;
+	return vma;
+
+err_free_vma:
+	kfree(vma);
+	return ERR_PTR(ret);
 }
 
 struct msm_gem_vm *
-- 
2.50.0


