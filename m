Return-Path: <linux-kernel+bounces-883414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE5C2D64A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC983BDA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88831A579;
	Mon,  3 Nov 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LeKmHTCk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379023161A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189581; cv=none; b=b4diHnVPMliC0L3Cw+dcRmyYBgAhv6uUjAb5JNK0QNmiDNHDu0nzAEK2BXJp8acicYbkOTXbCFwYb6qpmMkNH6REnUsYb3AIr/1hymKY96gXkJfF3xrL3c/T4fyMoDMoqfhonR/dBDqWewo6kv+v8CzGWHE2fAMXBmjitpKhklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189581; c=relaxed/simple;
	bh=toDsmIzhzZX65TZE+8tj9oBgYeeNLfVJxFIKUrqC1qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kf4ZA1EidEOrqUeCLmnyQqbx4eDf2SksJWNX6iWIi+gWFlng9z8lgqTAxT1pD+gSxAeOQmAK2xfZ64VOiRFv3cnBu0FuSCd5Sr/VyY6zztPdK6CeoNhYqAkPBcWjYg9vk0U7YDbOl6skBn4oTixC5kFAS0FBf50SclI76Cn2X+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LeKmHTCk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso34981185e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762189577; x=1762794377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GOfKt62NngZqZbp/cL7xKq9Fj6qCjeL7NUgIdEHh5M=;
        b=LeKmHTCk2NQKfK1uaSxJyGOmYlcJ1R6pIgqNQi6OsiSs8SHMob/cprIS9t8L4saQac
         8QVHTEaILlUKG55Trr4k5rWhbyeuFoUCA1tcZfMVDdvJWAkenDxhrKnRIVUmtriH4t7b
         U0H0rwh865a9qU+XjbaujHa5gM0WNC9/VbkNj9ukYyLk8ZPno/iz9UBtndB1N8RYdAvY
         wI9y2CRDOpOEYBuQ5LKHUsUNACS01MoYMq3EpLBv8Yw6Cp6kToL2Rn3mZuGGV/LFddaK
         0kTq4BMMTJ7GBVjHDpX/cGCwPXXwS2fxwWkQBosMo0C4owtK0MmGHBU8OuAK3yb1MUkp
         lbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189577; x=1762794377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GOfKt62NngZqZbp/cL7xKq9Fj6qCjeL7NUgIdEHh5M=;
        b=XujZlLdtUJodUZxUvSKE7BbWIMBqpEuvAIvqT7wWVCJ366nWiBKYNgesElNfjviCTs
         L5VIXU1R7JqkVX7sb86ILJyp4xOwN74v33RJV+H518UAsTCU/VENS9m10v+UNIpaiw7w
         b2IZB3w5c+xeK6lamySOw64iX0usMSVaNhES8EtANXfq3x26hlcXIFilW9/4eT/slq/j
         1bt+l8q7Axl9QkeqJmSBekBOei7/qN3sqS9YfTEtakq11EOBIs0EDbShashNyu5Nqe5m
         Nv7wmvlk2JkvgoRAVPV4QxmpHw0lD7uVd7ek0EJGn9pa8X9NZZG57OS3S7RBj9mw+bu1
         gd3Q==
X-Gm-Message-State: AOJu0YzPKTfHvPPryKDb/fr0/L4F3q3dBbMYnA5Iclq9EnXULf+qOowi
	/ZJ4OGpcXs+pIy7PnQ34+oAamCs/+uxmSHhJVex1UIxgZL1hjhz1HbnFgfwo+h8gJniIEd5TuvG
	r1zv3
X-Gm-Gg: ASbGnctifGMQFSJ/tSNQqsB3efWVFmhfsTV7MwqRh3bHVJ8ehvKO/JJhT9Mikk/xomF
	1OzhypDi5GcXrj8K3MGo4K2loFO+oUQmkos1NDWGDRwp74meK/7NCDxqrE1oKOOQI8opSedX4UA
	UfTJMoLl/NKRzkTcnNcfbwNrVQiBMz5G7sHyUBTixnaECcSEnQ871nmYpyt5WpFNgaz54Zhc/Dl
	nPZ1h6v/oO6feinWaNlCjceGCxd3O2AlD3HlQA1khkhLm2390dH6XGr9PEMRU83BRXk2eDdrYTs
	h8QlmtK404J66fMB3LvAuIjg8AKzZmtrqS23MkPBPWX1+nCKQp3blFQ5hqkGPRU481pyOdpRS6D
	mlsJ0+YAX0Vx6rbffIRGT30Yky9zygzoa1OXSY2OUc1iOSki1O7Nwtew/lOSpU2l9eezdEVW7vV
	/9x6b9Od+RE1eIMNJy4jtF5Q8fd2j5eCm7be71Y4q5nfy1yQ==
X-Google-Smtp-Source: AGHT+IHS8Qrqk4wb0RBUS4KE1K98X0engVur3nZE1XsUogokU8LVC28F9cBYglCJbJ9kw5feZmAX1g==
X-Received: by 2002:a05:600d:8399:b0:477:1709:1f2f with SMTP id 5b1f17b1804b1-477328727d7mr77486185e9.5.1762189577025;
        Mon, 03 Nov 2025 09:06:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc524ddsm89799895e9.7.2025.11.03.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:06:16 -0800 (PST)
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
Subject: [PATCH v2 1/2] drm/xe: replace use of system_unbound_wq with system_dfl_wq
Date: Mon,  3 Nov 2025 18:06:03 +0100
Message-ID: <20251103170604.310895-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103170604.310895-1-marco.crivellari@suse.com>
References: <20251103170604.310895-1-marco.crivellari@suse.com>
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

The above change to the Workqueue API has been introduced by:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

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
index 63c65e3d207b..d3a0e0231cd1 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1064,7 +1064,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
 	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
 
 	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
-	queue_work(system_unbound_wq, &vma->destroy_work);
+	queue_work(system_dfl_wq, &vma->destroy_work);
 }
 
 static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
@@ -1823,7 +1823,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/* To destroy the VM we need to be able to sleep */
-	queue_work(system_unbound_wq, &vm->destroy_work);
+	queue_work(system_dfl_wq, &vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
-- 
2.51.1


