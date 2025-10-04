Return-Path: <linux-kernel+bounces-842017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F665BB8C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5163188E624
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E026B971;
	Sat,  4 Oct 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZFuwMC0"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22661E9B0D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759575668; cv=none; b=kVHynvImgT1jIJsAJHlX2gUpM34TPHrCyK1CKl02PBFcYNBLbxNU4+mDtnDbtXZxt/ebOX/UUUQKBmGeFhNWyICrpl6kt0oMZbHlNokM2HOoIm8UXnpCALoMLwvNxhBUZlvTWNiPMVtsEjdabr5TS4EOht8M8YzY74adNQuOIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759575668; c=relaxed/simple;
	bh=mVhiB3XjjKvwry4rXBNKAAqKtNFxuZaSL16L+E/uJMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEb7XIr9MzUix3a63xOxw7OrdUjMEgxfKgaxjXUtftojI4yjM01KJfqXBbh6/0dAnBfil2yTuLLSQNnJulfLwaMbF1ZLrf/C9FW3Y5KBYmaw2TsR/AGiwdpVughja/KPpJsT3ryE2Zj3cLfnjUQ+SG0u1Lmn6xU7kbS+VH2alkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZFuwMC0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33082aed31dso3570759a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759575663; x=1760180463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCTDlQEGUynoAVbLn6xjoRk5lU8FKtAz6xcB6i4LhPk=;
        b=NZFuwMC0p4BRAMKbheVfCeyBIxhIde3fn/HwnYez4jsNqdh0/PJZ9Tsl4t1gfr77FS
         z5KoQ6qd0Qz3riApiXOb9GhdymJUqENbr/rRTRNMg3bhDRphV0RiO/L7QymqN9EgTlHS
         CAc1wgi7ael/frtaPI53b8zt0gX90ol4QEne6pNMq0xyXBqOiUb8GKey7e8tAz7PNyBM
         rcPHWE0bE8gdQBGnCL2dzQoOM8IyE8gTR7y0H+PTxw6LZpsgTIFccEheW3t/hC/PZDqM
         laOR66GlT1iDBFKYa9/ZuYYc58v5CXjsN5h4nhO7PKp+mvgyvZBJyR1EuNEnf+FuFHK3
         SV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759575663; x=1760180463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCTDlQEGUynoAVbLn6xjoRk5lU8FKtAz6xcB6i4LhPk=;
        b=IK+X5R0rrFr5ovcADk4UqDnw/iHL/OxY8XlkR/0GTQ94VXlcbS+mpdUkPf38hyxNk9
         Ifp6gqa89y4uL2kVctY7cxlg0nv04nF4VEJORZ8ydob18GmOJZa+HWdnzGyDx+b8Poe8
         rOG0LfnR1uoDHQFXYpdM8HPO1cX9YtSUBEgPATx8J/ax6bZisBmBZIx/UBuVAOJs2sJD
         uGpzH6mY0uDb80v/QEWmwDeuBo+O/IKJFMJvXdhKsgUIHnhMd6vwrAGd/NCarPbAM1lM
         zwePglhE5b1OStUwUDEvR4obNjmF4Bxx5sIjlETKA8R6MLlqnets86wJgwFLQsmsqos8
         itkg==
X-Forwarded-Encrypted: i=1; AJvYcCXc652N7hXqyjUr8tbjh6Rah8jbhqiOBiJ7gWGbZYCi77X588qzknbJivwFIMKlPGrJ0GHGBQab4iH8TGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uyHNoz/M7hwwPakKp/puK6okIA6bmHi0IWXDw/x+hJhNF+na
	zvxbu0QZqairaLqtEtBC37Dt7U/c3UW/XUiLHogNcvTSRUXWG7cjI3y9
X-Gm-Gg: ASbGncu+b0HQPRtcQt7JsBhlkvdHDZePqDBeH7JHNUXIBMIsxkXNA43GsY1PIkN6644
	vdX5lvAKw1EkqRIsD1F/9SfZk8xtKafbSQaHxBOon/uU5dS8H8HIWnc40VC0DGnZKjHIo0BZ/yl
	N98Hm38KymyWW1nWiq8sEMQ+HeCROeiyfLU1udKSRhL6mBQApv76hXn8PfYmgFsYN0qfmELHz6c
	xoyOrpEWYuMi0LNlbxOY284kgd6hf3r/REou9r74/RnbAgU1onCeqP6UYdi21fyvMlK3dzYRw04
	NGwR372Avwemn9noiWaJkr4wNJrvGcvpF/P3pVQ3qHsmj5yGiFATE7sZsChsbmg1u7dGt5J4X+a
	jwC8/faqQJinIr7zhzLP/LdHpkwhZq3YaSSJDdzT3XchGiQkdLv1Ta5lNdC3pR63zMliCQYqnCx
	Qxv+JlVze9WKc=
X-Google-Smtp-Source: AGHT+IF6KW+o3hALRSt3TlfMffAw7CjzidHyGOok+NoPUVDP1KnNL8mme1hIyP6Bkou2nnamx1XkdQ==
X-Received: by 2002:a17:90b:4f4c:b0:32e:a54a:be53 with SMTP id 98e67ed59e1d1-339c27348f6mr7738086a91.16.1759575662886;
        Sat, 04 Oct 2025 04:01:02 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099b1cf08sm7046135a12.22.2025.10.04.04.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 04:01:02 -0700 (PDT)
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
Subject: [PATCH RFT] drm/msm: Add NULL check in vm_op_enqueue()
Date: Sat,  4 Oct 2025 16:30:04 +0530
Message-ID: <20251004110044.204269-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917184616.85797-1-krishnagopi487@gmail.com>
References: <20250917184616.85797-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_op_enqueue() allocates an msm_vm_op struct with kmalloc,
but the return value is not checked for NULL value which
can be returned by kmalloc under low-memory conditions.
This can result in NULL pointer dereference when the pointer
is dereferenced.

Add NULL check after the allocation and propagate -ENOMEM back
to the caller in case of a failure.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---

This patch is marked as RFT since the changes haven't been tested. 

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


