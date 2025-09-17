Return-Path: <linux-kernel+bounces-821488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B2B81623
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E4D1765C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A32FFF92;
	Wed, 17 Sep 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltHWAdcy"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AA28505E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134789; cv=none; b=dk1cfSE3HzM24bJGysjkhebqkZrRFvE5397SCfXuk63z50fpcD4lro1qHehyP8PYVJ8NgPcYT5/UXDMfWizJi4G5PyM6KBMY/EtfL9xFveT0lN2T+iI8e/fQFEHSiIjyNz4A9XdnaPXA/ZcEglNyJP+uCwF2QJvfRIadS5NtxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134789; c=relaxed/simple;
	bh=btH0t94NpPvDHFTHl7A5rtmlTOTJwOQnsxlnzjc77To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP6L+WepoyeI98l1VEuELQNOs8CzrsEoGI9P5IxtmJp6sat7Jc2vMBaQhujy3sNrRM0WgPiyBmAT65kVN4J0c7K0aBe2ZqpKTdnZOizD4KHLfsbYDfbG/DgDAbJtRmMO1Ct+GMb+pT3jVoiqGHovbAvpS965pwfDbY5gLPirTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltHWAdcy; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso75953a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758134786; x=1758739586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CUH1cxrzGbtKg/vcM5DH0s3j2Zg6HTRa2VG9pGeCYA=;
        b=ltHWAdcyg9US6FADquD+LpfygC/dogU3iZ1Yhw5sBPQBSf88DcG0LOjadoWpIp1uRB
         b+2ZXUguQi0TEVgdhjg+9sUzY8RQr2cbF00LILS0UqCssYXV0jXSraqBnGhC/w37tn8p
         FvfyLGRELcG0jSuU3z6x3cLr8Li2IasqTiBipF39LSvhBhgTYm0RI50rQXCoNjjlWkiI
         mAho4RzhWXtyvSqSH1t2miMIZ5rzN+TJ6XLGVi+HOogyKVM7wry2FEZ85f203W6vNN5V
         TUhzNyYuhasP8x9Q1gkD1i6fZQUiGwm6416sI2AR4oEzeB5NPFb2zZ8Kcg+mHTMlMHlK
         lm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134786; x=1758739586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CUH1cxrzGbtKg/vcM5DH0s3j2Zg6HTRa2VG9pGeCYA=;
        b=GSff9WMWOcG8Kv5AKAgh4m8ArXCyltE6TMN8LvS9G/ysHqzX0oRnvS8j2tmHne8upf
         q7hDh7ZDRMetIQtJBjqu+S4WqQl3WzPYe6iJIewYCdv+rn18PKCyhK/HCzROidHlw5qo
         jw4B3JzWh2N6DEScjxL3cIwHwYCPwFDtcIRDywPNli29c+enCGo0IyIIfufADd04WTSF
         ZcytbfUnWklvArdPsNnPMpJ51c6Or6c9nFRxPzXjoB4p5LlxN77r6bn+jIEWJlt4oKV/
         zYL889EGDxaMzUREffgdA9OO4w/1K2xb95X6cRS7E4eB1tdKWd9eVoukMomlCg4P3bbF
         weDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWWkKtvuAFA0qXVy12sVfTlcjcxiIUAWUk7+mD48lggRR1+bS/MaOpoGA1buof9RkJZBDNJMkQRy4Sxls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuW/XT6kEfWd3j59K30PRSubugr6p082EH0VYyBxKGzVYgriH4
	APosKciunDsK/q5mjUUePCWTX1US9n7ApHJ4euHw4kSatM0M7DstCKKS
X-Gm-Gg: ASbGncs+4aDJGSaBZ4alz+Xdd3cNOZP2Kb/k2eLYOM0IHcPjVliYcuVOCVjE95+eFII
	WGeU48YDTx8tQGAM0t4p5w3sv86eBgrrcZWb5PVXbawQZaK/TcKhzeyxaUAJ6hZrjBEd+yBuk3e
	w30u0lpSo/IdsDF5CezX7pmFKop/GjIQmtuzcYdvsy6Q3AW8YsWDWYVt71zZIo68U86Ik3jtHVh
	REnnuQx913GckOSpgfhLNuEELfVhI7BfSgc4oZ2skQrRrV2yTJcieMTEKwwgRMN5cuLnZ8LJaPy
	lo7AAgh9z2y5M093U4i9FLBuDKfJEkHHohllCji/a0kj/wzTz4b0NJlDK/2eMIubdOQxpOzVf4h
	3pQgNr56GB+AflPK1lDpiUWZ4ZteHLkydCf80n5GpnA==
X-Google-Smtp-Source: AGHT+IEATHK4oZBUQ2XFmupV9qFdWwS+bGbZy20FnYjT9stAUVExIl1DxfPhf6kzlDTzmLMxk2zr3A==
X-Received: by 2002:a17:90b:4986:b0:32b:4c71:f423 with SMTP id 98e67ed59e1d1-32ee3f75457mr3359863a91.32.1758134786351;
        Wed, 17 Sep 2025 11:46:26 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306082eff4sm187852a91.25.2025.09.17.11.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:46:25 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	abhinav.kumar@linux.dev,
	jessica.zhang@oss.qualcomm.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/msm: Add NULL check in vm_op_enqueue
Date: Thu, 18 Sep 2025 00:16:14 +0530
Message-ID: <20250917184616.85797-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_op_enqueue allocates an msm_vm_op struct with kmalloc,
but the return value is not checked for NULL value which
can be returned by kmalloc under low-memory conditions.
This can result in NULL pointer dereference when the pointer
is dereferenced.

Add NULL check after the allocation and propagate -ENOMEM back
to the caller in case of a failure.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 00d0f3b7ba32..639425849d86 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -455,15 +455,20 @@ struct op_arg {
 	bool kept;
 };
 
-static void
+static int
 vm_op_enqueue(struct op_arg *arg, struct msm_vm_op _op)
 {
 	struct msm_vm_op *op = kmalloc(sizeof(*op), GFP_KERNEL);
+	if (!op)
+		return -ENOMEM;
+
 	*op = _op;
 	list_add_tail(&op->node, &arg->job->vm_ops);
 
 	if (op->obj)
 		drm_gem_object_get(op->obj);
+
+	return 0;
 }
 
 static struct drm_gpuva *
@@ -482,6 +487,7 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 	struct drm_gpuva *vma;
 	struct sg_table *sgt;
 	unsigned prot;
+	int ret;
 
 	if (arg->kept)
 		return 0;
@@ -493,8 +499,6 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 	vm_dbg("%p:%p:%p: %016llx %016llx", vma->vm, vma, vma->gem.obj,
 	       vma->va.addr, vma->va.range);
 
-	vma->flags = ((struct op_arg *)arg)->flags;
-
 	if (obj) {
 		sgt = to_msm_bo(obj)->sgt;
 		prot = msm_gem_prot(obj);
@@ -503,7 +507,7 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 		prot = IOMMU_READ | IOMMU_WRITE;
 	}
 
-	vm_op_enqueue(arg, (struct msm_vm_op){
+	ret = vm_op_enqueue(arg, (struct msm_vm_op){
 		.op = MSM_VM_OP_MAP,
 		.map = {
 			.sgt = sgt,
@@ -516,6 +520,10 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *_arg)
 		.obj = vma->gem.obj,
 	});
 
+	if (ret)
+		return ret;
+
+	vma->flags = ((struct op_arg *)arg)->flags;
 	to_msm_vma(vma)->mapped = true;
 
 	return 0;
@@ -531,6 +539,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 	struct drm_gpuvm_bo *vm_bo = orig_vma->vm_bo;
 	bool mapped = to_msm_vma(orig_vma)->mapped;
 	unsigned flags;
+	int ret;
 
 	vm_dbg("orig_vma: %p:%p:%p: %016llx %016llx", vm, orig_vma,
 	       orig_vma->gem.obj, orig_vma->va.addr, orig_vma->va.range);
@@ -540,7 +549,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 
 		drm_gpuva_op_remap_to_unmap_range(&op->remap, &unmap_start, &unmap_range);
 
-		vm_op_enqueue(arg, (struct msm_vm_op){
+		ret = vm_op_enqueue(arg, (struct msm_vm_op){
 			.op = MSM_VM_OP_UNMAP,
 			.unmap = {
 				.iova = unmap_start,
@@ -550,6 +559,9 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 			.obj = orig_vma->gem.obj,
 		});
 
+		if (ret)
+			return ret;
+
 		/*
 		 * Part of this GEM obj is still mapped, but we're going to kill the
 		 * existing VMA and replace it with one or two new ones (ie. two if
@@ -611,6 +623,7 @@ msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *_arg)
 	struct msm_vm_bind_job *job = arg->job;
 	struct drm_gpuva *vma = op->unmap.va;
 	struct msm_gem_vma *msm_vma = to_msm_vma(vma);
+	int ret;
 
 	vm_dbg("%p:%p:%p: %016llx %016llx", vma->vm, vma, vma->gem.obj,
 	       vma->va.addr, vma->va.range);
@@ -643,7 +656,7 @@ msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *_arg)
 	if (!msm_vma->mapped)
 		goto out_close;
 
-	vm_op_enqueue(arg, (struct msm_vm_op){
+	ret = vm_op_enqueue(arg, (struct msm_vm_op){
 		.op = MSM_VM_OP_UNMAP,
 		.unmap = {
 			.iova = vma->va.addr,
@@ -653,6 +666,9 @@ msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *_arg)
 		.obj = vma->gem.obj,
 	});
 
+	if (ret)
+		return ret;
+
 	msm_vma->mapped = false;
 
 out_close:
-- 
2.43.0


