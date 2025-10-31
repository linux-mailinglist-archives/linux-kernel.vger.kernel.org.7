Return-Path: <linux-kernel+bounces-880016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC2C24A97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB991A204CA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06708343D90;
	Fri, 31 Oct 2025 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C7eU+YWT"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8C3431F6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908398; cv=none; b=e5SI7w0CuZfoY6601QOaT4nCwV1SiUj+UHvCVVKLmbH2nGTHms3R8e9BPzx1N1YjxEMKB1F+cEHFrf1YVFpcrSXMKgBfIERM+2PHcBBh1p/IzJljW08IE8m2CrB1RRmDZqisUscPGyz8ROfankse69A4eOEMratm1Vzoo1NEQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908398; c=relaxed/simple;
	bh=VOurxl+sVQjyGc1Q+0VgIqhM8VdRBNx9ftIipnjy+u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laXBcwQOauxJod2HKhf+BQftdMvp601/IuvsBZZEnZGlvbCyx23KqmJKkTAtxkMrfucuoiuUY1JgaS/vipHMTjrQA3G03Tfx9ri8fVYpLK2NSzd/ZpwecZ15/FmBucwBdF8nW2ZOyxn2RJV8BLDJarJgIqfCtm3qgPfDnCkxvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C7eU+YWT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4298b49f103so854631f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761908394; x=1762513194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meReBaQ99dOF1c+7jSgsU4KTZxApPi6bDuZ+XPUjUx4=;
        b=C7eU+YWTAFp+UeuoaSIKlO61AL1uhqDg4amTmUkvULikQ63xMfXCKIIZcUiWD6/hHa
         qfcUT24BeLqjkPoR9KPYJextGzQjWAvK1IbfSlbxn5Z+mdhKx6aWGkOnl7gUpFbd/0i8
         YxcbpUbwcPXCmKQil7KjSxkc3Pg4shfJeqhmUHfgZTbilpc72fr0GwZUvkPsNxgTKcuT
         lUM+SWGPCEDRMkcZviIh0gFDzocN9LDnOWid2C9CGqRB5f4dpkMrsOfgR8Xx7PbQP+HB
         Ts8i11sRxFgnFWI0VzYPHw4eisgMn+FvZkVi0rg/0LzbAlJwqDWXjmdm4+p4vSKY69qk
         Ryyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908394; x=1762513194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meReBaQ99dOF1c+7jSgsU4KTZxApPi6bDuZ+XPUjUx4=;
        b=egF9dA5NqkdD7O+ROQTheyOgvxuksIIsVTGSlAcymqfsEIPxC/iq8hweQMFbosD7Pq
         SgzOcBzxRlQGsqUJTWcD6ZXai3pFrI0BP9flklzSulR/jjzTYOGUbXyb6mZBwDMmEbPc
         ju5IXCb/2Ux/lQxD/iAA/bEPtYIrm45MA1yC0OOSVfvYGDHwcOAeA+xDzcBTXgUUKN3D
         x2cvAXYpzH+DGmRh7sQEiBGsA4tjtpqsJgMdKfZUmOalmcyiQAu7ABW9Kn9Vc+YE80BE
         SLM1R+qmFB1P0ZH0/4iccUPQNz5JAhRbHUcCr3xY6GM1LrdAP51sZu+TN55uSuKP22Fz
         b9Rg==
X-Gm-Message-State: AOJu0YwCejuNXGhk6lXltW4DWG03aroeMZkzvkFeGstmECcWpMtO/NQX
	e2bwAhgXgadIFayQv/sY++QKSLVxZcBXumKAZD7UKEMzrBKxAWFiJNpHqmTjRl2WDyY/w9nKaYG
	Pjewf
X-Gm-Gg: ASbGncsv6Tk7N0qHVmN2hdRsVy49QE8eC8kAJBgZxwzTRPdertWpkuN5WG+KENfwUKZ
	kuE9eTKa6v9Q7fJ6VJY00wna3hwi+lu8bnP9BZgjuc6JIAGTe1qhLnVQEj+IRs6NkIefvIrvMHo
	IQ0y8ojGXyLr9Vsa4YX4RLDOBhxg1n0+evZZFCJnSvMQcCVcGHA4qyiSVG8TOZkqBLmS4kM5J+w
	03llxVUCmz4AE8kYSqQRAx2Wf2bqQGOm/QL/z6gw9zMIiqSZhi7kpE2kliM7Y+x5Z8NGYHsV/b+
	sNTGloWsvv4Du+5rysM+PS7hdG5JzZKFWLwTLu0TLJ2BzXGyupQYBhlrk14we+dT8Y4VQNxNxrf
	HBpEmaebzem8aHPpjLNxM3G1i/hc6hC3pNgIITGUNBMYi44xZt43ifBg7pBJR6bLNLwmjw3tDyi
	uDW0nxldm4XlVCNF6VdNHQHppG
X-Google-Smtp-Source: AGHT+IFdGTxG3bZ9hI1ZvBKqkA/ZCyuorhXgGNfQCxf182NXCKhTyNIAS3xqjvn2tp4aiso7n8hemw==
X-Received: by 2002:a05:6000:40ca:b0:426:d820:a3f9 with SMTP id ffacd0b85a97d-429bd5eea69mr2252061f8f.0.1761908393997;
        Fri, 31 Oct 2025 03:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110035esm2965528f8f.6.2025.10.31.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:59:53 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/2] drm/xe: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 31 Oct 2025 11:59:38 +0100
Message-ID: <20251031105939.129200-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031105939.129200-1-marco.crivellari@suse.com>
References: <20251031105939.129200-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 2 +-
 drivers/gpu/drm/xe/xe_execlist.c    | 2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c      | 4 ++--
 drivers/gpu/drm/xe/xe_oa.c          | 2 +-
 drivers/gpu/drm/xe/xe_vm.c          | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 203e3038cc81..806335487021 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -362,7 +362,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 
 	xe_engine_snapshot_capture_for_queue(q);
 
-	queue_work(system_unbound_wq, &ss->work);
+	queue_work(system_dfl_wq, &ss->work);
 
 	xe_force_wake_put(gt_to_fw(q->gt), fw_ref);
 	dma_fence_end_signalling(cookie);
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index f83d421ac9d3..99010709f0d2 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -422,7 +422,7 @@ static void execlist_exec_queue_kill(struct xe_exec_queue *q)
 static void execlist_exec_queue_destroy(struct xe_exec_queue *q)
 {
 	INIT_WORK(&q->execlist->destroy_async, execlist_exec_queue_destroy_async);
-	queue_work(system_unbound_wq, &q->execlist->destroy_async);
+	queue_work(system_dfl_wq, &q->execlist->destroy_async);
 }
 
 static int execlist_exec_queue_set_priority(struct xe_exec_queue *q,
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 18f6327bf552..bc2ec3603e7b 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -543,7 +543,7 @@ int xe_guc_ct_enable(struct xe_guc_ct *ct)
 	spin_lock_irq(&ct->dead.lock);
 	if (ct->dead.reason) {
 		ct->dead.reason |= (1 << CT_DEAD_STATE_REARM);
-		queue_work(system_unbound_wq, &ct->dead.worker);
+		queue_work(system_dfl_wq, &ct->dead.worker);
 	}
 	spin_unlock_irq(&ct->dead.lock);
 #endif
@@ -2186,7 +2186,7 @@ static void ct_dead_capture(struct xe_guc_ct *ct, struct guc_ctb *ctb, u32 reaso
 
 	spin_unlock_irqrestore(&ct->dead.lock, flags);
 
-	queue_work(system_unbound_wq, &(ct)->dead.worker);
+	queue_work(system_dfl_wq, &(ct)->dead.worker);
 }
 
 static void ct_dead_print(struct xe_dead_ct *dead)
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index a4894eb0d7f3..4e362cd43d51 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -967,7 +967,7 @@ static void xe_oa_config_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 	struct xe_oa_fence *ofence = container_of(cb, typeof(*ofence), cb);
 
 	INIT_DELAYED_WORK(&ofence->work, xe_oa_fence_work_fn);
-	queue_delayed_work(system_unbound_wq, &ofence->work,
+	queue_delayed_work(system_dfl_wq, &ofence->work,
 			   usecs_to_jiffies(NOA_PROGRAM_ADDITIONAL_DELAY_US));
 	dma_fence_put(fence);
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 027e6ce648c5..94827ca4b7dc 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1073,7 +1073,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
 	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
 
 	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
-	queue_work(system_unbound_wq, &vma->destroy_work);
+	queue_work(system_dfl_wq, &vma->destroy_work);
 }
 
 static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
@@ -1832,7 +1832,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/* To destroy the VM we need to be able to sleep */
-	queue_work(system_unbound_wq, &vm->destroy_work);
+	queue_work(system_dfl_wq, &vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
-- 
2.51.0


