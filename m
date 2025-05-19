Return-Path: <linux-kernel+bounces-654310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EEABC6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 20:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140CB7A3239
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1C28B4E1;
	Mon, 19 May 2025 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Xlq0LN"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25528E606;
	Mon, 19 May 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677531; cv=none; b=afsGHG+Pd/Eb7UTF/RGwlinOxYJaOJtN122eDiKD9AYQInxf/mqa5PoCNz3hAZC4mbq2ZhxpWa6fVEhXKk4Wox/TlnX968x7taGSymiG4JPWRxhZhZIhd2058z2RXwArovSVNl+tzXgTMIzrU6MOY3QW1NsRMEzMH9J3mQc4oGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677531; c=relaxed/simple;
	bh=dKdw8DHdr4de+pLf0G0fohs0iChjVU8bfF+DE91GQnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8ODfkeg8kE3qFyIwo0VdkYCvAsqBBMIY+bD+jJiC29SA+j0+beQF3pQPb5EtMJ+58AtzM8UNGlUo29LP1CVaaUHGHfi/v1mVbwxKxYMDTKhEUo/ty4LRhAsoKUXX3mFC5/LLMLA39rXWVJwzdHpqyzTMBYg3tA/R1ayecU8Aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1Xlq0LN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30820167b47so3873537a91.0;
        Mon, 19 May 2025 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747677529; x=1748282329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlkCAAKtM3wOcQWyTtWQWVVEqfus5C6fj3S4qB7dQ/Y=;
        b=F1Xlq0LNnCXVjsmfaxOLADKXY8WZS6g9MFvHPPnQXKQFzvCJJAzfbPxoDwJJzxnUNz
         +HESzpPTvkq2+0cCuU9hBuweZYxR2Fwd/xrduXA+0rMGAuu76FLdyzrS/0y3JEGb4qbh
         8ES+SsHd5gV8FvXNdUpm5vagwJSq1fomiUn3hLZQziQ/e3n2eR5E3+98FF3+NO8Hk7Vq
         boRg6iUE6mG0lHe5Yx4JYoyvTuq68Hzk9HzG/74DGLV/r2DWwHHcZAxQO/8BApD35yoh
         PsDIfIsLXKB7AIzqZ+vT1DClUu+q+yJ34NZXxQ7GI7Ku9l2DGDM6EG1ZnBHG3ilixEYl
         OvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677529; x=1748282329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlkCAAKtM3wOcQWyTtWQWVVEqfus5C6fj3S4qB7dQ/Y=;
        b=Bpdar8Cfs8+LBIRN/2/v2OPXkrsLXh/I9UgvLJwL/kGFT6j9Ak4Pycudl8R2Wr8Y1w
         1avlugB/WW29qhcoEcaKydtl3z67vgULDNBx3sBQMoVQzxZSFWNbLvKb33TxyqhGe0Dn
         Nm3zZsn9bWsBdn8+yInwWgD2R1VkMA0E4zKmEUmdK/q1OtoudrZfhKSrziKks9XgAiw/
         Aykoyp9jZ+56hjWKVKDqNEtux1sScu61WNtwiQY0ylHJ6RL5XWNa0ZMJoEMNmnsJqjeZ
         5R9/IIzPprHs08UYifTKyqbWxEWC8LSu0gDEx/ikXUqYg1GD/4aL7zJCLH4uVcIP9zRt
         nNrA==
X-Forwarded-Encrypted: i=1; AJvYcCU2pM2i7LuRZSyTikgnhlK4uUeakQ//UuIIknwkpgsKjpuFytVaymqJo6nsAHhVygrqQM0j4lDXbTyQvBGS@vger.kernel.org, AJvYcCWgjYUsiq8+3xWZttswDJYzp5xFjeOyS+ru/DfDm0OLLP6Rn+72cmLvnpUzMNS/gA1x8anwiCJ7CG3aj21S@vger.kernel.org
X-Gm-Message-State: AOJu0YwhbR6y1gQgG8Bys/WFsGqAy334SDLjOPLovdv6+oeduz7qRwWL
	gyJffZAzyI0M2Q0QtRtgsQ/aw8m/TaN25Hc3tNHbdwanoPBaMjqkjffy
X-Gm-Gg: ASbGnctTCGWsVxg9ec/5cNtsqVrXdcYa847LzPjved7DJ0FxmzZyhcur+FO/R/8in9B
	79/pq4V0qfblMoaxoFn68sLSnhmbVWAPLLqEsF2K4A0FonPz5DLHc5XDS/VMr6GG4IZC8Pu3krP
	gwfR+3VkDs3aoAjpnRJlkhJbYcF398d6EYH3G+Ij/iSKYb06VKiD+4mNsJoj0b9HU+oVN2p2JFR
	Kwupu3xdvLYLZI7ajl6Q5k1rxXnnQXGCsP5Cxp8H9KdpkicGXhxtJn3O8OiaKkYtKRAjyF/xebX
	sVIddqkthyT3PJdofKC3fU3lVERSwuVYx26GiOXR0VBYF09/Ldub9kEyIb7kXI9ksKxfJWktT1w
	lz8mVxgSBJdaX2M14c6u4uxxVFQ==
X-Google-Smtp-Source: AGHT+IHi3lW4kYLwbdf1uvFbUhc2rF9CF6d0zFjk8XG4rGHx76qnW4OPrzSggWJ5k2qzKMlnIyNJ3Q==
X-Received: by 2002:a17:90b:524c:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-30e4dac99b4mr24907480a91.3.1747677528711;
        Mon, 19 May 2025 10:58:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:3e00:2601:3afc:446b:f0df:eadc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e9239aaeesm5861729a91.15.2025.05.19.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:58:46 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 36/40] drm/msm: Add VM logging for VM_BIND updates
Date: Mon, 19 May 2025 10:57:33 -0700
Message-ID: <20250519175755.13037-24-robdclark@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175755.13037-1-robdclark@gmail.com>
References: <20250519175348.11924-1-robdclark@gmail.com>
 <20250519175755.13037-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

When userspace opts in to VM_BIND, the submit no longer holds references
keeping the VMA alive.  This makes it difficult to distinguish between
UMD/KMD/app bugs.  So add a debug option for logging the most recent VM
updates and capturing these in GPU devcoredumps.

The submitqueue id is also captured, a value of zero means the operation
did not go via a submitqueue (ie. comes from msm_gem_vm_close() tearing
down the remaining mappings when the device file is closed.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  11 +++
 drivers/gpu/drm/msm/msm_gem.h           |  24 +++++
 drivers/gpu/drm/msm/msm_gem_vma.c       | 124 ++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c           |  52 +++++++++-
 drivers/gpu/drm/msm/msm_gpu.h           |   4 +
 5 files changed, 202 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index efe03f3f42ba..12b42ae2688c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -837,6 +837,7 @@ void adreno_gpu_state_destroy(struct msm_gpu_state *state)
 	for (i = 0; state->bos && i < state->nr_bos; i++)
 		kvfree(state->bos[i].data);
 
+	kfree(state->vm_logs);
 	kfree(state->bos);
 	kfree(state->comm);
 	kfree(state->cmd);
@@ -977,6 +978,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 			   info->ptes[0], info->ptes[1], info->ptes[2], info->ptes[3]);
 	}
 
+	if (state->vm_logs) {
+		drm_puts(p, "vm-log:\n");
+		for (i = 0; i < state->nr_vm_logs; i++) {
+			struct msm_gem_vm_log_entry *e = &state->vm_logs[i];
+			drm_printf(p, "  - %s:%d: 0x%016llx-0x%016llx\n",
+				   e->op, e->queue_id, e->iova,
+				   e->iova + e->range);
+		}
+	}
+
 	drm_printf(p, "rbbm-status: 0x%08x\n", state->rbbm_status);
 
 	drm_puts(p, "ringbuffer:\n");
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index bfeb0f584ae5..4dc9b72b9193 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -24,6 +24,20 @@
 #define MSM_BO_STOLEN        0x10000000    /* try to use stolen/splash memory */
 #define MSM_BO_MAP_PRIV      0x20000000    /* use IOMMU_PRIV when mapping */
 
+/**
+ * struct msm_gem_vm_log_entry - An entry in the VM log
+ *
+ * For userspace managed VMs, a log of recent VM updates is tracked and
+ * captured in GPU devcore dumps, to aid debugging issues caused by (for
+ * example) incorrectly synchronized VM updates
+ */
+struct msm_gem_vm_log_entry {
+	const char *op;
+	uint64_t iova;
+	uint64_t range;
+	int queue_id;
+};
+
 /**
  * struct msm_gem_vm - VM object
  *
@@ -85,6 +99,15 @@ struct msm_gem_vm {
 	/** @last_fence: Fence for last pending work scheduled on the VM */
 	struct dma_fence *last_fence;
 
+	/** @log: A log of recent VM updates */
+	struct msm_gem_vm_log_entry *log;
+
+	/** @log_shift: length of @log is (1 << @log_shift) */
+	uint32_t log_shift;
+
+	/** @log_idx: index of next @log entry to write */
+	uint32_t log_idx;
+
 	/** @faults: the number of GPU hangs associated with this address space */
 	int faults;
 
@@ -115,6 +138,7 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 		  u64 va_start, u64 va_size, bool managed);
 
 void msm_gem_vm_close(struct drm_gpuvm *gpuvm);
+void msm_gem_vm_unusable(struct drm_gpuvm *gpuvm);
 
 struct msm_fence_context;
 
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index fe41b7a042c3..d349025924b4 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -17,6 +17,10 @@
 
 #define vm_dbg(fmt, ...) pr_debug("%s:%d: "fmt"\n", __func__, __LINE__, ##__VA_ARGS__)
 
+static uint vm_log_shift = 0;
+MODULE_PARM_DESC(vm_log_shift, "Length of VM op log");
+module_param_named(vm_log_shift, vm_log_shift, uint, 0600);
+
 /**
  * struct msm_vm_map_op - create new pgtable mapping
  */
@@ -31,6 +35,13 @@ struct msm_vm_map_op {
 	struct sg_table *sgt;
 	/** @prot: the mapping protection flags */
 	int prot;
+
+	/**
+	 * @queue_id: The id of the submitqueue the operation is performed
+	 * on, or zero for (in particular) UNMAP ops triggered outside of
+	 * a submitqueue (ie. process cleanup)
+	 */
+	int queue_id;
 };
 
 /**
@@ -41,6 +52,13 @@ struct msm_vm_unmap_op {
 	uint64_t iova;
 	/** @range: size of region to unmap */
 	uint64_t range;
+
+	/**
+	 * @queue_id: The id of the submitqueue the operation is performed
+	 * on, or zero for (in particular) UNMAP ops triggered outside of
+	 * a submitqueue (ie. process cleanup)
+	 */
+	int queue_id;
 };
 
 /**
@@ -144,16 +162,87 @@ msm_gem_vm_free(struct drm_gpuvm *gpuvm)
 		vm->mmu->funcs->destroy(vm->mmu);
 	dma_fence_put(vm->last_fence);
 	put_pid(vm->pid);
+	kfree(vm->log);
 	kfree(vm);
 }
 
+/**
+ * msm_gem_vm_unusable() - Mark a VM as unusable
+ * @vm: the VM to mark unusable
+ */
+void
+msm_gem_vm_unusable(struct drm_gpuvm *gpuvm)
+{
+	struct msm_gem_vm *vm = to_msm_vm(gpuvm);
+	uint32_t vm_log_len = (1 << vm->log_shift);
+	uint32_t vm_log_mask = vm_log_len - 1;
+	uint32_t nr_vm_logs;
+	int first;
+
+	vm->unusable = true;
+
+	/* Bail if no log, or empty log: */
+	if (!vm->log || !vm->log[0].op)
+		return;
+
+	mutex_lock(&vm->mmu_lock);
+
+	/*
+	 * log_idx is the next entry to overwrite, meaning it is the oldest, or
+	 * first, entry (other than the special case handled below where the
+	 * log hasn't wrapped around yet)
+	 */
+	first = vm->log_idx;
+
+	if (!vm->log[first].op) {
+		/*
+		 * If the next log entry has not been written yet, then only
+		 * entries 0 to idx-1 are valid (ie. we haven't wrapped around
+		 * yet)
+		 */
+		nr_vm_logs = MAX(0, first - 1);
+		first = 0;
+	} else {
+		nr_vm_logs = vm_log_len;
+	}
+
+	pr_err("vm-log:\n");
+	for (int i = 0; i < nr_vm_logs; i++) {
+		int idx = (i + first) & vm_log_mask;
+		struct msm_gem_vm_log_entry *e = &vm->log[idx];
+		pr_err("  - %s:%d: 0x%016llx-0x%016llx\n",
+		       e->op, e->queue_id, e->iova,
+		       e->iova + e->range);
+	}
+
+	mutex_unlock(&vm->mmu_lock);
+}
+
 static void
-vm_unmap_op(struct msm_gem_vm *vm, const struct msm_vm_unmap_op *op)
+vm_log(struct msm_gem_vm *vm, const char *op, uint64_t iova, uint64_t range, int queue_id)
 {
+	int idx;
+
 	if (!vm->managed)
 		lockdep_assert_held(&vm->mmu_lock);
 
-	vm_dbg("%p: %016llx %016llx", vm, op->iova, op->iova + op->range);
+	vm_dbg("%s:%p:%d: %016llx %016llx", op, vm, queue_id, iova, iova + range);
+
+	if (!vm->log)
+		return;
+
+	idx = vm->log_idx;
+	vm->log[idx].op = op;
+	vm->log[idx].iova = iova;
+	vm->log[idx].range = range;
+	vm->log[idx].queue_id = queue_id;
+	vm->log_idx = (vm->log_idx + 1) & ((1 << vm->log_shift) - 1);
+}
+
+static void
+vm_unmap_op(struct msm_gem_vm *vm, const struct msm_vm_unmap_op *op)
+{
+	vm_log(vm, "unmap", op->iova, op->range, op->queue_id);
 
 	vm->mmu->funcs->unmap(vm->mmu, op->iova, op->range);
 }
@@ -161,10 +250,7 @@ vm_unmap_op(struct msm_gem_vm *vm, const struct msm_vm_unmap_op *op)
 static int
 vm_map_op(struct msm_gem_vm *vm, const struct msm_vm_map_op *op)
 {
-	if (!vm->managed)
-		lockdep_assert_held(&vm->mmu_lock);
-
-	vm_dbg("%p: %016llx %016llx", vm, op->iova, op->iova + op->range);
+	vm_log(vm, "map", op->iova, op->range, op->queue_id);
 
 	return vm->mmu->funcs->map(vm->mmu, op->iova, op->sgt, op->offset,
 				   op->range, op->prot);
@@ -382,6 +468,7 @@ vma_from_op(struct op_arg *arg, struct drm_gpuva_op_map *op)
 static int
 msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *arg)
 {
+	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
 	struct drm_gem_object *obj = op->map.gem.obj;
 	struct drm_gpuva *vma;
 	struct sg_table *sgt;
@@ -412,6 +499,7 @@ msm_gem_vm_sm_step_map(struct drm_gpuva_op *op, void *arg)
 			.range = vma->va.range,
 			.offset = vma->gem.offset,
 			.prot = prot,
+			.queue_id = job->queue->id,
 		},
 		.obj = vma->gem.obj,
 	});
@@ -445,6 +533,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 			.unmap = {
 				.iova = unmap_start,
 				.range = unmap_range,
+				.queue_id = job->queue->id,
 			},
 			.obj = orig_vma->gem.obj,
 		});
@@ -506,6 +595,7 @@ msm_gem_vm_sm_step_remap(struct drm_gpuva_op *op, void *arg)
 static int
 msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *arg)
 {
+	struct msm_vm_bind_job *job = ((struct op_arg *)arg)->job;
 	struct drm_gpuva *vma = op->unmap.va;
 	struct msm_gem_vma *msm_vma = to_msm_vma(vma);
 
@@ -520,6 +610,7 @@ msm_gem_vm_sm_step_unmap(struct drm_gpuva_op *op, void *arg)
 		.unmap = {
 			.iova = vma->va.addr,
 			.range = vma->va.range,
+			.queue_id = job->queue->id,
 		},
 		.obj = vma->gem.obj,
 	});
@@ -584,7 +675,7 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	 * now the VM is in an undefined state.  Game over!
 	 */
 	if (ret)
-		vm->unusable = true;
+		msm_gem_vm_unusable(job->vm);
 
 	job_foreach_bo (obj, job) {
 		msm_gem_lock(obj);
@@ -697,6 +788,23 @@ msm_gem_vm_create(struct drm_device *drm, struct msm_mmu *mmu, const char *name,
 
 	drm_mm_init(&vm->mm, va_start, va_size);
 
+	/*
+	 * We don't really need vm log for kernel managed VMs, as the kernel
+	 * is responsible for ensuring that GEM objs are mapped if they are
+	 * used by a submit.  Furthermore we piggyback on mmu_lock to serialize
+	 * access to the log.
+	 *
+	 * Limit the max log_shift to 8 to prevent userspace from asking us
+	 * for an unreasonable log size.
+	 */
+	if (!managed)
+		vm->log_shift = MIN(vm_log_shift, 8);
+
+	if (vm->log_shift) {
+		vm->log = kmalloc_array(1 << vm->log_shift, sizeof(vm->log[0]),
+					GFP_KERNEL | __GFP_ZERO);
+	}
+
 	return &vm->base;
 
 err_free_dummy:
@@ -1143,7 +1251,7 @@ vm_bind_job_prepare(struct msm_vm_bind_job *job)
 			 * state the vm is in.  So throw up our hands!
 			 */
 			if (i > 0)
-				vm->unusable = true;
+				msm_gem_vm_unusable(job->vm);
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index b70355fc8570..210e756cb563 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -259,9 +259,6 @@ static void crashstate_get_bos(struct msm_gpu_state *state, struct msm_gem_submi
 {
 	extern bool rd_full;
 
-	if (!submit)
-		return;
-
 	if (msm_context_is_vmbind(submit->queue->ctx)) {
 		struct drm_exec exec;
 		struct drm_gpuva *vma;
@@ -318,6 +315,48 @@ static void crashstate_get_bos(struct msm_gpu_state *state, struct msm_gem_submi
 	}
 }
 
+static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_vm *vm)
+{
+	uint32_t vm_log_len = (1 << vm->log_shift);
+	uint32_t vm_log_mask = vm_log_len - 1;
+	int first;
+
+	/* Bail if no log, or empty log: */
+	if (!vm->log || !vm->log[0].op)
+		return;
+
+	mutex_lock(&vm->mmu_lock);
+
+	/*
+	 * log_idx is the next entry to overwrite, meaning it is the oldest, or
+	 * first, entry (other than the special case handled below where the
+	 * log hasn't wrapped around yet)
+	 */
+	first = vm->log_idx;
+
+	if (!vm->log[first].op) {
+		/*
+		 * If the next log entry has not been written yet, then only
+		 * entries 0 to idx-1 are valid (ie. we haven't wrapped around
+		 * yet)
+		 */
+		state->nr_vm_logs = MAX(0, first - 1);
+		first = 0;
+	} else {
+		state->nr_vm_logs = vm_log_len;
+	}
+
+	state->vm_logs = kmalloc_array(
+		state->nr_vm_logs, sizeof(vm->log[0]), GFP_KERNEL);
+	for (int i = 0; i < state->nr_vm_logs; i++) {
+		int idx = (i + first) & vm_log_mask;
+
+		state->vm_logs[i] = vm->log[idx];
+	}
+
+	mutex_unlock(&vm->mmu_lock);
+}
+
 static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		struct msm_gem_submit *submit, char *comm, char *cmd)
 {
@@ -349,7 +388,10 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		msm_iommu_pagetable_walk(mmu, info->iova, info->ptes);
 	}
 
-	crashstate_get_bos(state, submit);
+	if (submit) {
+		crashstate_get_vm_logs(state, to_msm_vm(submit->vm));
+		crashstate_get_bos(state, submit);
+	}
 
 	/* Set the active crash state to be dumped on failure */
 	gpu->crashstate = state;
@@ -449,7 +491,7 @@ static void recover_worker(struct kthread_work *work)
 		 * VM_BIND)
 		 */
 		if (!vm->managed)
-			vm->unusable = true;
+			msm_gem_vm_unusable(submit->vm);
 	}
 
 	get_comm_cmdline(submit, &comm, &cmd);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9cbf155ff222..31b83e9e3673 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -20,6 +20,7 @@
 #include "msm_gem.h"
 
 struct msm_gem_submit;
+struct msm_gem_vm_log_entry;
 struct msm_gpu_perfcntr;
 struct msm_gpu_state;
 struct msm_context;
@@ -609,6 +610,9 @@ struct msm_gpu_state {
 
 	struct msm_gpu_fault_info fault_info;
 
+	int nr_vm_logs;
+	struct msm_gem_vm_log_entry *vm_logs;
+
 	int nr_bos;
 	struct msm_gpu_state_bo *bos;
 };
-- 
2.49.0


