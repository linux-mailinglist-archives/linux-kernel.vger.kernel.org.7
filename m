Return-Path: <linux-kernel+bounces-708196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9FAECD75
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA73B4213
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562872367AF;
	Sun, 29 Jun 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRyjiezf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36D226D0B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751206063; cv=none; b=EYIoYLri5cA6TXJaZqd06LhttmXahlEbWX1DPSB+VncmKFCWuUmhyVKzC4hZZnS+gyVJ0j4R2qLAF9lqwYXTz7trRghlpJNQInoGNT9V3oFYru5k+0WHZF15eDwXjc5hwVxnzSUekBu9F/ruKHjKrmGV7F894Ryl8dTv1Guz1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751206063; c=relaxed/simple;
	bh=IQIepr+3BXC4bz/2Itj+gYOSxVibtVXlxV/RLH8W7Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMXHPrEAu7OPprXs0BnA8Yds4QvKg0SAFuXNUn8/muDy+V1WBExqh2Jfg8uaynjEBG3+Nd1OreXywNkdbjZBoKUqUHMeHcNJ2q/Wi8tGJO8mzL1xbZ7RsPKY2tCW9w/NfqED46ir5F40eZ9gnjCh+xPcIy4HstUaYvt/Csk7VNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRyjiezf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TADXsI028542
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 14:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rew9/IzVuWZ
	58MgfUMBVonrci/Um8bB8O/66NNJAsB0=; b=SRyjiezfc1aEyawoW2Gfi/MA9tw
	6QDoh8spjnezKUpjZ38HVXeMH1OZT38dnga0Gwfm1d4ltJ/Gf9IAEnYgUhFSiSa8
	+eza1mzf6k9b0LCd7yQ7ZOmRiwr/GVCMmR5zB+h+BoEQoAlPD+PQfTtTs2sMVm4X
	dRnKqLQbmd2EC16jXLOLGgXgIZJhGPo/+YERJDnnCckzxzijN/lhzud+zzP5facq
	fBA6TqBno+O+Dql7ZbtzGy2XVHPmEiGdvA9lC0piO7P+RolyNRdB9cBA/rzZW0dp
	x5KWax5accK3pqYUfigCkAlu16BKdgMDqZq0Adm+w0HQSCimAmP4d6G/vKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7d9t9cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 14:07:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23692793178so28917645ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 07:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751206058; x=1751810858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rew9/IzVuWZ58MgfUMBVonrci/Um8bB8O/66NNJAsB0=;
        b=p2yXRbocFDa7d2l9u2s6Yg+jFFcSJybo/spZNkZjXkrf1jJmQoqkVhAKRCSVtTMlPj
         myUozW2LnIP7vM9JmHNfx6pVZ2ryLmszyKJ1RHh+aI/WOnAibNppqPVahMb0nBIcHMI9
         4hhBPmXQp3eksiNJjOyhR4+WYJV4+PvYQe9mbMAiCCWSQlJH6t1lNaxH7bj5zv5kH1an
         HYWgYTPn1bpSduwmt4bYFHkSTopTioS+W5TeYA/GKHqk2VJS+iKe3B+ijJiYZ7F7RKeF
         GRfrzbphlSUHUTzlmdmcr1CBfoYEAPoMxgAyEm3SWCHlfjAt+tTRR59iifG3GTjYg4uq
         YaHw==
X-Forwarded-Encrypted: i=1; AJvYcCUDquVv9+dS42F0bYVtQcO5m65F4CCMvWyzJb6Ihhre1kpJwdFP6lHDrKipKAr2mIf05xSBpx/ZEVDkRLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAJ6rf+azjSLx6HsLGO2kUZ50I/vUZ3X5KyHGIr6IGQnOdo6L
	ziRRCztJ4iVLXNJl1sTk/nWOkBvdQHIf9rfkHlhRMOE4fVCilrgasEXJDebrqc/4Vo0YHPbhYPR
	hwUR6ySirG0UdYLheX1qxo+b///LlCac7FOgKNCVjK4x6aiYc335TxvwHJdon/s+1VD0=
X-Gm-Gg: ASbGncvPkj5AICxfoSHDTs3THEHuyv7zNPKNYicPuFpopGlmrH7KrIh9sm3dW5lpVyd
	NttgmfN9GZt68xYeFfLc6cYhFp+GdfWdHme5M9TNAZas1dMTs51M1Nth5Obi9fSSqsQ0dmNJsin
	op3pcOkrRFmdZX/tQTGEZTuRqK8kPs5rW0zF4VrnV9herO7v90qyMzqD1CMSLmprbUNCi9EbQlX
	qq4NDfitxeuJyNu43H6Z9utgxU11adJo+kufX3ohmMX87jvEkReDHTXXmdlOut2nUemIpSrl/VC
	qWblG9TNL8bJRr3t/v2ycxzJkm9psNLN
X-Received: by 2002:a17:902:ce81:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23ac48b493emr140953965ad.45.1751206058300;
        Sun, 29 Jun 2025 07:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEln3KZC96Bl9UQ1Llwn2SAAoEMXpWTe2DCPd/DPm+a5d8vhXsT9aMZVvCfnJyhWhnKf+/xCw==
X-Received: by 2002:a17:902:ce81:b0:234:f6ba:e68a with SMTP id d9443c01a7336-23ac48b493emr140953425ad.45.1751206057626;
        Sun, 29 Jun 2025 07:07:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39ba6bsm58535135ad.104.2025.06.29.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 07:07:37 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH v8 14/42] drm/msm: Convert vm locking
Date: Sun, 29 Jun 2025 07:03:17 -0700
Message-ID: <20250629140537.30850-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629140537.30850-1-robin.clark@oss.qualcomm.com>
References: <20250629140537.30850-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDExOSBTYWx0ZWRfX556p8MswsPMd
 DgOB+NPpvCSpQ6OOsAeVypDdrRt6a9s0vCKCUmjisoCyMtSx9w5c8JywANhoJxwcbWZ8jvWhCsf
 5Vscnl1naAzblrKMsOTiZEpPs7oXC4WG4MPqOFcDsbvCzIfwDAoXnXgG9Z1u+4gjRhAQkvtYKxT
 4VurCo7qxO4Tb7P9JpThXzqyeVP+42L5oQ8vqhSXvLao8fCnPjHhdyxLmMH3TcVybmTmk6HJyg2
 lLgWX996jWI6OhXe9dOmX92cf2VPBPnGiUcmAMxKIFPdYRz1PuIc41FbXENqqs7a3qUexglS27A
 t+YO4/rWz5aTTd6OSe8p2vXGghh3+xsev9hY3UbRSNIAl5ncbniXEQ8yLOXJ4f3Mpkb3g8/nGq/
 ubGalpRDvElByT6l1K8fK4Q4YIB425FaKpcmRovD0GeonWjSHbeyHhMMbOwlMzUIhyxr/P2x
X-Proofpoint-GUID: 43sEAP1_wI-TxhBC1RopxRAJBsez2Epr
X-Authority-Analysis: v=2.4 cv=RrbFLDmK c=1 sm=1 tr=0 ts=686148ab cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=1nDRvngas_nmfiIOXgsA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 43sEAP1_wI-TxhBC1RopxRAJBsez2Epr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506290119

From: Rob Clark <robdclark@chromium.org>

Convert to using the gpuvm's r_obj for serializing access to the VM.
This way we can use the drm_exec helper for dealing with deadlock
detection and backoff.

This will let us deal with upcoming locking order conflicts with the
VM_BIND implmentation (ie. in some scenarious we need to acquire the obj
lock first, for ex. to iterate all the VMs an obj is bound in, and in
other scenarious we need to acquire the VM lock first).

Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Antonino Maniscalco <antomani103@gmail.com>
Reviewed-by: Antonino Maniscalco <antomani103@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem.c          | 41 +++++++++----
 drivers/gpu/drm/msm/msm_gem.h          | 37 ++++++++++--
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 80 +++++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_gem_submit.c   |  9 ++-
 drivers/gpu/drm/msm/msm_gem_vma.c      | 24 +++-----
 5 files changed, 152 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 664fb801c221..82293806219a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -48,6 +48,7 @@ static void put_iova_spaces(struct drm_gem_object *obj, struct drm_gpuvm *vm, bo
 static void detach_vm(struct drm_gem_object *obj, struct msm_gem_vm *vm)
 {
 	msm_gem_assert_locked(obj);
+	drm_gpuvm_resv_assert_held(&vm->base);
 
 	struct drm_gpuvm_bo *vm_bo = drm_gpuvm_bo_find(&vm->base, obj);
 	if (vm_bo) {
@@ -68,6 +69,7 @@ static void detach_vm(struct drm_gem_object *obj, struct msm_gem_vm *vm)
 static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 {
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_exec exec;
 
 	update_ctx_mem(file, -obj->size);
 
@@ -86,10 +88,10 @@ static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 	dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_READ, false,
 			      msecs_to_jiffies(1000));
 
-	msm_gem_lock(obj);
+	msm_gem_lock_vm_and_obj(&exec, obj, ctx->vm);
 	put_iova_spaces(obj, &ctx->vm->base, true);
 	detach_vm(obj, ctx->vm);
-	msm_gem_unlock(obj);
+	drm_exec_fini(&exec);     /* drop locks */
 }
 
 /*
@@ -551,11 +553,12 @@ int msm_gem_get_and_pin_iova_range(struct drm_gem_object *obj,
 		struct msm_gem_vm *vm, uint64_t *iova,
 		u64 range_start, u64 range_end)
 {
+	struct drm_exec exec;
 	int ret;
 
-	msm_gem_lock(obj);
+	msm_gem_lock_vm_and_obj(&exec, obj, vm);
 	ret = get_and_pin_iova_range_locked(obj, vm, iova, range_start, range_end);
-	msm_gem_unlock(obj);
+	drm_exec_fini(&exec);     /* drop locks */
 
 	return ret;
 }
@@ -575,16 +578,17 @@ int msm_gem_get_iova(struct drm_gem_object *obj,
 		struct msm_gem_vm *vm, uint64_t *iova)
 {
 	struct msm_gem_vma *vma;
+	struct drm_exec exec;
 	int ret = 0;
 
-	msm_gem_lock(obj);
+	msm_gem_lock_vm_and_obj(&exec, obj, vm);
 	vma = get_vma_locked(obj, vm, 0, U64_MAX);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 	} else {
 		*iova = vma->base.va.addr;
 	}
-	msm_gem_unlock(obj);
+	drm_exec_fini(&exec);     /* drop locks */
 
 	return ret;
 }
@@ -613,9 +617,10 @@ static int clear_iova(struct drm_gem_object *obj,
 int msm_gem_set_iova(struct drm_gem_object *obj,
 		     struct msm_gem_vm *vm, uint64_t iova)
 {
+	struct drm_exec exec;
 	int ret = 0;
 
-	msm_gem_lock(obj);
+	msm_gem_lock_vm_and_obj(&exec, obj, vm);
 	if (!iova) {
 		ret = clear_iova(obj, vm);
 	} else {
@@ -628,7 +633,7 @@ int msm_gem_set_iova(struct drm_gem_object *obj,
 			ret = -EBUSY;
 		}
 	}
-	msm_gem_unlock(obj);
+	drm_exec_fini(&exec);     /* drop locks */
 
 	return ret;
 }
@@ -642,14 +647,15 @@ void msm_gem_unpin_iova(struct drm_gem_object *obj,
 		struct msm_gem_vm *vm)
 {
 	struct msm_gem_vma *vma;
+	struct drm_exec exec;
 
-	msm_gem_lock(obj);
+	msm_gem_lock_vm_and_obj(&exec, obj, vm);
 	vma = lookup_vma(obj, vm);
 	if (vma) {
 		msm_gem_unpin_locked(obj);
 	}
 	detach_vm(obj, vm);
-	msm_gem_unlock(obj);
+	drm_exec_fini(&exec);     /* drop locks */
 }
 
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
@@ -1021,12 +1027,27 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct drm_device *dev = obj->dev;
 	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_exec exec;
 
 	mutex_lock(&priv->obj_lock);
 	list_del(&msm_obj->node);
 	mutex_unlock(&priv->obj_lock);
 
+	/*
+	 * We need to lock any VMs the object is still attached to, but not
+	 * the object itself (see explaination in msm_gem_assert_locked()),
+	 * so just open-code this special case:
+	 */
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked (&exec) {
+		struct drm_gpuvm_bo *vm_bo;
+		drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
+			drm_exec_lock_obj(&exec, drm_gpuvm_resv_obj(vm_bo->vm));
+			drm_exec_retry_on_contention(&exec);
+		}
+	}
 	put_iova_spaces(obj, NULL, true);
+	drm_exec_fini(&exec);     /* drop locks */
 
 	if (drm_gem_is_imported(obj)) {
 		GEM_WARN_ON(msm_obj->vaddr);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 4112370baf34..33885a08cdd7 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -62,12 +62,6 @@ struct msm_gem_vm {
 	 */
 	struct drm_mm mm;
 
-	/** @mm_lock: protects @mm node allocation/removal */
-	struct spinlock mm_lock;
-
-	/** @vm_lock: protects gpuvm insert/remove/traverse */
-	struct mutex vm_lock;
-
 	/** @mmu: The mmu object which manages the pgtables */
 	struct msm_mmu *mmu;
 
@@ -246,6 +240,37 @@ msm_gem_unlock(struct drm_gem_object *obj)
 	dma_resv_unlock(obj->resv);
 }
 
+/**
+ * msm_gem_lock_vm_and_obj() - Helper to lock an obj + VM
+ * @exec: the exec context helper which will be initalized
+ * @obj: the GEM object to lock
+ * @vm: the VM to lock
+ *
+ * Operations which modify a VM frequently need to lock both the VM and
+ * the object being mapped/unmapped/etc.  This helper uses drm_exec to
+ * acquire both locks, dealing with potential deadlock/backoff scenarios
+ * which arise when multiple locks are involved.
+ */
+static inline int
+msm_gem_lock_vm_and_obj(struct drm_exec *exec,
+			struct drm_gem_object *obj,
+			struct msm_gem_vm *vm)
+{
+	int ret = 0;
+
+	drm_exec_init(exec, 0, 2);
+	drm_exec_until_all_locked (exec) {
+		ret = drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&vm->base));
+		if (!ret && (obj->resv != drm_gpuvm_resv(&vm->base)))
+			ret = drm_exec_lock_obj(exec, obj);
+		drm_exec_retry_on_contention(exec);
+		if (GEM_WARN_ON(ret))
+			break;
+	}
+
+	return ret;
+}
+
 static inline void
 msm_gem_assert_locked(struct drm_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index de185fc34084..5faf6227584a 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -43,6 +43,75 @@ msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 	return count;
 }
 
+static bool
+with_vm_locks(struct ww_acquire_ctx *ticket,
+	      void (*fn)(struct drm_gem_object *obj),
+	      struct drm_gem_object *obj)
+{
+	/*
+	 * Track last locked entry for for unwinding locks in error and
+	 * success paths
+	 */
+	struct drm_gpuvm_bo *vm_bo, *last_locked = NULL;
+	int ret = 0;
+
+	drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
+		struct dma_resv *resv = drm_gpuvm_resv(vm_bo->vm);
+
+		if (resv == obj->resv)
+			continue;
+
+		ret = dma_resv_lock(resv, ticket);
+
+		/*
+		 * Since we already skip the case when the VM and obj
+		 * share a resv (ie. _NO_SHARE objs), we don't expect
+		 * to hit a double-locking scenario... which the lock
+		 * unwinding cannot really cope with.
+		 */
+		WARN_ON(ret == -EALREADY);
+
+		/*
+		 * Don't bother with slow-lock / backoff / retry sequence,
+		 * if we can't get the lock just give up and move on to
+		 * the next object.
+		 */
+		if (ret)
+			goto out_unlock;
+
+		/*
+		 * Hold a ref to prevent the vm_bo from being freed
+		 * and removed from the obj's gpuva list, as that would
+		 * would result in missing the unlock below
+		 */
+		drm_gpuvm_bo_get(vm_bo);
+
+		last_locked = vm_bo;
+	}
+
+	fn(obj);
+
+out_unlock:
+	if (last_locked) {
+		drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
+			struct dma_resv *resv = drm_gpuvm_resv(vm_bo->vm);
+
+			if (resv == obj->resv)
+				continue;
+
+			dma_resv_unlock(resv);
+
+			/* Drop the ref taken while locking: */
+			drm_gpuvm_bo_put(vm_bo);
+
+			if (last_locked == vm_bo)
+				break;
+		}
+	}
+
+	return ret == 0;
+}
+
 static bool
 purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
 {
@@ -52,9 +121,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
 	if (msm_gem_active(obj))
 		return false;
 
-	msm_gem_purge(obj);
-
-	return true;
+	return with_vm_locks(ticket, msm_gem_purge, obj);
 }
 
 static bool
@@ -66,9 +133,7 @@ evict(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
 	if (msm_gem_active(obj))
 		return false;
 
-	msm_gem_evict(obj);
-
-	return true;
+	return with_vm_locks(ticket, msm_gem_evict, obj);
 }
 
 static bool
@@ -100,6 +165,7 @@ static unsigned long
 msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
 	struct msm_drm_private *priv = shrinker->private_data;
+	struct ww_acquire_ctx ticket;
 	struct {
 		struct drm_gem_lru *lru;
 		bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
@@ -124,7 +190,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 			drm_gem_lru_scan(stages[i].lru, nr,
 					 &stages[i].remaining,
 					 stages[i].shrink,
-					 NULL);
+					 &ticket);
 		nr -= stages[i].freed;
 		freed += stages[i].freed;
 		remaining += stages[i].remaining;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 2de5a07392eb..bd8e465e8049 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -256,11 +256,18 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 /* This is where we make sure all the bo's are reserved and pin'd: */
 static int submit_lock_objects(struct msm_gem_submit *submit)
 {
+	unsigned flags = DRM_EXEC_IGNORE_DUPLICATES | DRM_EXEC_INTERRUPTIBLE_WAIT;
 	int ret;
 
-	drm_exec_init(&submit->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, submit->nr_bos);
+// TODO need to add vm_bind path which locks vm resv + external objs
+	drm_exec_init(&submit->exec, flags, submit->nr_bos);
 
 	drm_exec_until_all_locked (&submit->exec) {
+		ret = drm_exec_lock_obj(&submit->exec,
+					drm_gpuvm_resv_obj(&submit->vm->base));
+		drm_exec_retry_on_contention(&submit->exec);
+		if (ret)
+			goto error;
 		for (unsigned i = 0; i < submit->nr_bos; i++) {
 			struct drm_gem_object *obj = submit->bos[i].obj;
 			ret = drm_exec_prepare_obj(&submit->exec, obj, 1);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 1f4c9b5c2e8f..ccb20897a2b0 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -92,15 +92,13 @@ void msm_gem_vma_close(struct msm_gem_vma *vma)
 
 	GEM_WARN_ON(vma->mapped);
 
-	spin_lock(&vm->mm_lock);
+	drm_gpuvm_resv_assert_held(&vm->base);
+
 	if (vma->base.va.addr)
 		drm_mm_remove_node(&vma->node);
-	spin_unlock(&vm->mm_lock);
 
-	mutex_lock(&vm->vm_lock);
 	drm_gpuva_remove(&vma->base);
 	drm_gpuva_unlink(&vma->base);
-	mutex_unlock(&vm->vm_lock);
 
 	kfree(vma);
 }
@@ -114,16 +112,16 @@ msm_gem_vma_new(struct msm_gem_vm *vm, struct drm_gem_object *obj,
 	struct msm_gem_vma *vma;
 	int ret;
 
+	drm_gpuvm_resv_assert_held(&vm->base);
+
 	vma = kzalloc(sizeof(*vma), GFP_KERNEL);
 	if (!vma)
 		return ERR_PTR(-ENOMEM);
 
 	if (vm->managed) {
-		spin_lock(&vm->mm_lock);
 		ret = drm_mm_insert_node_in_range(&vm->mm, &vma->node,
 						obj->size, PAGE_SIZE, 0,
 						range_start, range_end, 0);
-		spin_unlock(&vm->mm_lock);
 
 		if (ret)
 			goto err_free_vma;
@@ -137,9 +135,7 @@ msm_gem_vma_new(struct msm_gem_vm *vm, struct drm_gem_object *obj,
 	drm_gpuva_init(&vma->base, range_start, range_end - range_start, obj, 0);
 	vma->mapped = false;
 
-	mutex_lock(&vm->vm_lock);
 	ret = drm_gpuva_insert(&vm->base, &vma->base);
-	mutex_unlock(&vm->vm_lock);
 	if (ret)
 		goto err_free_range;
 
@@ -149,18 +145,14 @@ msm_gem_vma_new(struct msm_gem_vm *vm, struct drm_gem_object *obj,
 		goto err_va_remove;
 	}
 
-	mutex_lock(&vm->vm_lock);
 	drm_gpuvm_bo_extobj_add(vm_bo);
 	drm_gpuva_link(&vma->base, vm_bo);
-	mutex_unlock(&vm->vm_lock);
 	GEM_WARN_ON(drm_gpuvm_bo_put(vm_bo));
 
 	return vma;
 
 err_va_remove:
-	mutex_lock(&vm->vm_lock);
 	drm_gpuva_remove(&vma->base);
-	mutex_unlock(&vm->vm_lock);
 err_free_range:
 	if (vm->managed)
 		drm_mm_remove_node(&vma->node);
@@ -191,6 +183,11 @@ struct msm_gem_vm *
 msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 		  u64 va_start, u64 va_size, bool managed)
 {
+	/*
+	 * We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
+	 * makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
+	 * tracking that an extobj is evicted) :facepalm:
+	 */
 	enum drm_gpuvm_flags flags = 0;
 	struct msm_gem_vm *vm;
 	struct drm_gem_object *dummy_gem;
@@ -213,9 +210,6 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 		       va_start, va_size, 0, 0, &msm_gpuvm_ops);
 	drm_gem_object_put(dummy_gem);
 
-	spin_lock_init(&vm->mm_lock);
-	mutex_init(&vm->vm_lock);
-
 	vm->mmu = mmu;
 	vm->managed = managed;
 
-- 
2.50.0


