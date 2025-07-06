Return-Path: <linux-kernel+bounces-715671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC7AF7C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31076E319F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16914B092;
	Thu,  3 Jul 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i/Mqu74A"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F22E2F03
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556695; cv=none; b=lzEqUL7mpJ3wIM1l8VDsv0IDaVppGwLHX0aCs9UfpI4QIkfJKOhY14Ay7g2dW7kVja1sdHFdxK6otnTpMvkH2kxQxC4v4bbZqW+PozORvPmgUHPJ+pWjvdXNvMfJ3+AsdEllgs/NHdl4LljMDLlgE7g5cvA1PvRN1x47waASCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556695; c=relaxed/simple;
	bh=LM2qFcNqZHKhjcBXVtExdepMcEbEni0Jn8+DH0K6CI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZaUt4cJf0ZVVFuc3093K0oo6rcZmYKAe2aMGCYwab7jzdDf1FitSTrK5gyMmpuLpCQ6ciiS1MKXlt8YtChDzJugJ4lAddBIm2y/IIgbN9SQvB8QdMq1JLXnbRwq5uJVIAm95aD7L3kGclMkhP5MC99neD1kMJDPliE13C5ZfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i/Mqu74A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751556691;
	bh=LM2qFcNqZHKhjcBXVtExdepMcEbEni0Jn8+DH0K6CI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/Mqu74ABjKGpAOC5hcsMvdChwF9++j7IPATKGNnCY7j5nPzc3Y8CXHQzGeOioces
	 Rijo0zs7iqf6aLGKRPOujIzw+4VQy4Ema97tzPg1dGZZldxpdn8JnHItu8o6ZeV5Im
	 MV0Xes+l/5Zyk14MZaHkXnYx30A7hkUoElT54XrV2fWKOz3BJq5BwDCtZI0NgCqafJ
	 e0fcXxjzVArdi3qFlmdKVNcSCUKkRVFSeb1FBvEiJPoBQGcicGZA7+Pdc4jTJH8PDK
	 cYHFjsi/ruhiTGeW/4d2xXzFXcGnZvVYsfZ3nRXG4Dx+YemeMCe3jhoZMp0JdpRsNu
	 bWlABbqemlUCA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [90.168.160.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nanokatze)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3201D17E080D;
	Thu,  3 Jul 2025 17:31:30 +0200 (CEST)
From: Caterina Shablia <caterina.shablia@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: kernel@collabora.com,
	Caterina Shablia <caterina.shablia@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2 3/7] drm/gpuvm: Pass map arguments through a struct
Date: Thu,  3 Jul 2025 15:28:56 +0000
Message-ID: <20250703152908.16702-5-caterina.shablia@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703152908.16702-2-caterina.shablia@collabora.com>
References: <20250703152908.16702-2-caterina.shablia@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

We are about to pass more arguments to drm_gpuvm_sm_map[_ops_create](),
so, before we do that, let's pass arguments through a struct instead
of changing each call site every time a new optional argument is added.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c            | 77 +++++++++++---------------
 drivers/gpu/drm/imagination/pvr_vm.c   | 15 +++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 11 ++--
 drivers/gpu/drm/panthor/panthor_mmu.c  | 13 ++++-
 drivers/gpu/drm/xe/xe_vm.c             | 13 ++++-
 include/drm/drm_gpuvm.h                | 34 ++++++++++--
 6 files changed, 98 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index e89b932e987c..ae201d45e6b8 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2054,16 +2054,15 @@ EXPORT_SYMBOL_GPL(drm_gpuva_unmap);
 
 static int
 op_map_cb(const struct drm_gpuvm_ops *fn, void *priv,
-	  u64 addr, u64 range,
-	  struct drm_gem_object *obj, u64 offset)
+	  const struct drm_gpuvm_map_req *req)
 {
 	struct drm_gpuva_op op = {};
 
 	op.op = DRM_GPUVA_OP_MAP;
-	op.map.va.addr = addr;
-	op.map.va.range = range;
-	op.map.gem.obj = obj;
-	op.map.gem.offset = offset;
+	op.map.va.addr = req->va.addr;
+	op.map.va.range = req->va.range;
+	op.map.gem.obj = req->gem.obj;
+	op.map.gem.offset = req->gem.offset;
 
 	return fn->sm_step_map(&op, priv);
 }
@@ -2102,17 +2101,16 @@ op_unmap_cb(const struct drm_gpuvm_ops *fn, void *priv,
 static int
 __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		   const struct drm_gpuvm_ops *ops, void *priv,
-		   u64 req_addr, u64 req_range,
-		   struct drm_gem_object *req_obj, u64 req_offset)
+		   const struct drm_gpuvm_map_req *req)
 {
 	struct drm_gpuva *va, *next;
-	u64 req_end = req_addr + req_range;
+	u64 req_end = req->va.addr + req->va.range;
 	int ret;
 
-	if (unlikely(!drm_gpuvm_range_valid(gpuvm, req_addr, req_range)))
+	if (unlikely(!drm_gpuvm_range_valid(gpuvm, req->va.addr, req->va.range)))
 		return -EINVAL;
 
-	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req_addr, req_end) {
+	drm_gpuvm_for_each_va_range_safe(va, next, gpuvm, req->va.addr, req_end) {
 		struct drm_gem_object *obj = va->gem.obj;
 		u64 offset = va->gem.offset;
 		u64 addr = va->va.addr;
@@ -2120,9 +2118,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		u64 end = addr + range;
 		bool merge = !!va->gem.obj;
 
-		if (addr == req_addr) {
-			merge &= obj == req_obj &&
-				 offset == req_offset;
+		if (addr == req->va.addr) {
+			merge &= obj == req->gem.obj &&
+				 offset == req->gem.offset;
 
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge);
@@ -2141,9 +2139,9 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 			if (end > req_end) {
 				struct drm_gpuva_op_map n = {
 					.va.addr = req_end,
-					.va.range = range - req_range,
+					.va.range = range - req->va.range,
 					.gem.obj = obj,
-					.gem.offset = offset + req_range,
+					.gem.offset = offset + req->va.range,
 				};
 				struct drm_gpuva_op_unmap u = {
 					.va = va,
@@ -2155,8 +2153,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					return ret;
 				break;
 			}
-		} else if (addr < req_addr) {
-			u64 ls_range = req_addr - addr;
+		} else if (addr < req->va.addr) {
+			u64 ls_range = req->va.addr - addr;
 			struct drm_gpuva_op_map p = {
 				.va.addr = addr,
 				.va.range = ls_range,
@@ -2165,8 +2163,8 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 			};
 			struct drm_gpuva_op_unmap u = { .va = va };
 
-			merge &= obj == req_obj &&
-				 offset + ls_range == req_offset;
+			merge &= obj == req->gem.obj &&
+				 offset + ls_range == req->gem.offset;
 			u.keep = merge;
 
 			if (end == req_end) {
@@ -2189,7 +2187,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.va.range = end - req_end,
 					.gem.obj = obj,
 					.gem.offset = offset + ls_range +
-						      req_range,
+						      req->va.range,
 				};
 
 				ret = op_remap_cb(ops, priv, &p, &n, &u);
@@ -2197,10 +2195,10 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					return ret;
 				break;
 			}
-		} else if (addr > req_addr) {
-			merge &= obj == req_obj &&
-				 offset == req_offset +
-					   (addr - req_addr);
+		} else if (addr > req->va.addr) {
+			merge &= obj == req->gem.obj &&
+				 offset == req->gem.offset +
+					   (addr - req->va.addr);
 
 			if (end == req_end) {
 				ret = op_unmap_cb(ops, priv, va, merge);
@@ -2228,6 +2226,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 					.keep = merge,
 				};
 
+
 				ret = op_remap_cb(ops, priv, NULL, &n, &u);
 				if (ret)
 					return ret;
@@ -2236,9 +2235,7 @@ __drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm,
 		}
 	}
 
-	return op_map_cb(ops, priv,
-			 req_addr, req_range,
-			 req_obj, req_offset);
+	return op_map_cb(ops, priv, req);
 }
 
 static int
@@ -2302,11 +2299,8 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 /**
  * drm_gpuvm_sm_map() - creates the &drm_gpuva_op split/merge steps
  * @gpuvm: the &drm_gpuvm representing the GPU VA space
- * @req_addr: the start address of the new mapping
- * @req_range: the range of the new mapping
- * @req_obj: the &drm_gem_object to map
- * @req_offset: the offset within the &drm_gem_object
  * @priv: pointer to a driver private data structure
+ * @req: map request information
  *
  * This function iterates the given range of the GPU VA space. It utilizes the
  * &drm_gpuvm_ops to call back into the driver providing the split and merge
@@ -2333,8 +2327,7 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
  */
 int
 drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm, void *priv,
-		 u64 req_addr, u64 req_range,
-		 struct drm_gem_object *req_obj, u64 req_offset)
+		 const struct drm_gpuvm_map_req *req)
 {
 	const struct drm_gpuvm_ops *ops = gpuvm->ops;
 
@@ -2343,9 +2336,7 @@ drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm, void *priv,
 		       ops->sm_step_unmap)))
 		return -EINVAL;
 
-	return __drm_gpuvm_sm_map(gpuvm, ops, priv,
-				  req_addr, req_range,
-				  req_obj, req_offset);
+	return __drm_gpuvm_sm_map(gpuvm, ops, priv, req);
 }
 EXPORT_SYMBOL_GPL(drm_gpuvm_sm_map);
 
@@ -2485,10 +2476,7 @@ static const struct drm_gpuvm_ops gpuvm_list_ops = {
 /**
  * drm_gpuvm_sm_map_ops_create() - creates the &drm_gpuva_ops to split and merge
  * @gpuvm: the &drm_gpuvm representing the GPU VA space
- * @req_addr: the start address of the new mapping
- * @req_range: the range of the new mapping
- * @req_obj: the &drm_gem_object to map
- * @req_offset: the offset within the &drm_gem_object
+ * @req: map request arguments
  *
  * This function creates a list of operations to perform splitting and merging
  * of existent mapping(s) with the newly requested one.
@@ -2516,8 +2504,7 @@ static const struct drm_gpuvm_ops gpuvm_list_ops = {
  */
 struct drm_gpuva_ops *
 drm_gpuvm_sm_map_ops_create(struct drm_gpuvm *gpuvm,
-			    u64 req_addr, u64 req_range,
-			    struct drm_gem_object *req_obj, u64 req_offset)
+			    const struct drm_gpuvm_map_req *req)
 {
 	struct drm_gpuva_ops *ops;
 	struct {
@@ -2535,9 +2522,7 @@ drm_gpuvm_sm_map_ops_create(struct drm_gpuvm *gpuvm,
 	args.vm = gpuvm;
 	args.ops = ops;
 
-	ret = __drm_gpuvm_sm_map(gpuvm, &gpuvm_list_ops, &args,
-				 req_addr, req_range,
-				 req_obj, req_offset);
+	ret = __drm_gpuvm_sm_map(gpuvm, &gpuvm_list_ops, &args, req);
 	if (ret)
 		goto err_free_ops;
 
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 2896fa7501b1..abfdcd279363 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -185,12 +185,17 @@ struct pvr_vm_bind_op {
 static int pvr_vm_bind_op_exec(struct pvr_vm_bind_op *bind_op)
 {
 	switch (bind_op->type) {
-	case PVR_VM_BIND_TYPE_MAP:
+	case PVR_VM_BIND_TYPE_MAP: {
+		const struct drm_gpuvm_map_req map_req = {
+			.va.addr = bind_op->device_addr,
+			.va.range = bind_op->size,
+			.gem.obj = gem_from_pvr_gem(bind_op->pvr_obj),
+			.gem.offset = bind_op->offset,
+		};
+
 		return drm_gpuvm_sm_map(&bind_op->vm_ctx->gpuvm_mgr,
-					bind_op, bind_op->device_addr,
-					bind_op->size,
-					gem_from_pvr_gem(bind_op->pvr_obj),
-					bind_op->offset);
+					bind_op, &map_req);
+	}
 
 	case PVR_VM_BIND_TYPE_UNMAP:
 		return drm_gpuvm_sm_unmap(&bind_op->vm_ctx->gpuvm_mgr,
diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 48f105239f42..b481700be666 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1276,6 +1276,12 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			break;
 		case OP_MAP: {
 			struct nouveau_uvma_region *reg;
+			struct drm_gpuvm_map_req map_req = {
+				.va.addr = op->va.addr,
+				.va.range = op->va.range,
+				.gem.obj = op->gem.obj,
+				.gem.offset = op->gem.offset,
+			};
 
 			reg = nouveau_uvma_region_find_first(uvmm,
 							     op->va.addr,
@@ -1301,10 +1307,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 			}
 
 			op->ops = drm_gpuvm_sm_map_ops_create(&uvmm->base,
-							      op->va.addr,
-							      op->va.range,
-							      op->gem.obj,
-							      op->gem.offset);
+							      &map_req);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
 				goto unwind_continue;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 1e58948587a9..a7852485e638 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2236,15 +2236,22 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 		goto out;
 
 	switch (op_type) {
-	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
+	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
+		const struct drm_gpuvm_map_req map_req = {
+			.va.addr = op->va.addr,
+			.va.range = op->va.range,
+			.gem.obj = op->map.vm_bo->obj,
+			.gem.offset = op->map.bo_offset,
+		};
+
 		if (vm->unusable) {
 			ret = -EINVAL;
 			break;
 		}
 
-		ret = drm_gpuvm_sm_map(&vm->base, vm, op->va.addr, op->va.range,
-				       op->map.vm_bo->obj, op->map.bo_offset);
+		ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
 		break;
+	}
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
 		ret = drm_gpuvm_sm_unmap(&vm->base, vm, op->va.addr, op->va.range);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 861577746929..80bc741bdb6b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -2246,10 +2246,17 @@ vm_bind_ioctl_ops_create(struct xe_vm *vm, struct xe_bo *bo,
 
 	switch (operation) {
 	case DRM_XE_VM_BIND_OP_MAP:
-	case DRM_XE_VM_BIND_OP_MAP_USERPTR:
-		ops = drm_gpuvm_sm_map_ops_create(&vm->gpuvm, addr, range,
-						  obj, bo_offset_or_userptr);
+	case DRM_XE_VM_BIND_OP_MAP_USERPTR: {
+		struct drm_gpuvm_map_req map_req = {
+			.va.addr = addr,
+			.va.range = range,
+			.gem.obj = obj,
+			.gem.offset = bo_offset_or_userptr,
+		};
+
+		ops = drm_gpuvm_sm_map_ops_create(&vm->gpuvm, &map_req);
 		break;
+	}
 	case DRM_XE_VM_BIND_OP_UNMAP:
 		ops = drm_gpuvm_sm_unmap_ops_create(&vm->gpuvm, addr, range);
 		break;
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 6fdf2aff3e90..a6e6c33fc10b 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1049,10 +1049,37 @@ struct drm_gpuva_ops {
  */
 #define drm_gpuva_next_op(op) list_next_entry(op, entry)
 
+/**
+ * struct drm_gpuvm_map_req - arguments passed to drm_gpuvm_sm_map[_ops_create]()
+ */
+struct drm_gpuvm_map_req {
+	/** @va: virtual address related fields */
+	struct {
+		/** @va.addr: start of the virtual address range to map to */
+		u64 addr;
+
+		/** @va.size: size of the virtual address range to map to */
+		u64 range;
+	} va;
+
+	/** @gem: GEM related fields */
+	struct {
+		/**
+		 * @obj: GEM object to map.
+		 *
+		 * Can be NULL if the virtual range is not backed by a GEM object.
+		 */
+		struct drm_gem_object *obj;
+
+		/** @offset: offset in the GEM */
+		u64 offset;
+	} gem;
+};
+
 struct drm_gpuva_ops *
 drm_gpuvm_sm_map_ops_create(struct drm_gpuvm *gpuvm,
-			    u64 addr, u64 range,
-			    struct drm_gem_object *obj, u64 offset);
+			    const struct drm_gpuvm_map_req *req);
+
 struct drm_gpuva_ops *
 drm_gpuvm_sm_unmap_ops_create(struct drm_gpuvm *gpuvm,
 			      u64 addr, u64 range);
@@ -1198,8 +1225,7 @@ struct drm_gpuvm_ops {
 };
 
 int drm_gpuvm_sm_map(struct drm_gpuvm *gpuvm, void *priv,
-		     u64 addr, u64 range,
-		     struct drm_gem_object *obj, u64 offset);
+		     const struct drm_gpuvm_map_req *req);
 
 int drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm, void *priv,
 		       u64 addr, u64 range);
-- 
2.47.2


