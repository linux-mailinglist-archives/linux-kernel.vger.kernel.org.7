Return-Path: <linux-kernel+bounces-884544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0086C3065A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F7B18859B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8452D63F8;
	Tue,  4 Nov 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fQycvRkt"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C072749FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250451; cv=none; b=TsVbZjSfdDlM+V3DezWd9wtqR4vo//anwof9/bUGLnWEyHhBu2CYN1Pdqm/nVZi5lwbRyiBezJvnYraLDH/nT5oCvxNH3/FQ94FnPWBKAY228yPGsND8v9jE5dklShiQwGK3DpXG7hyd+MgTocIJI/k2tJcTr6MgcoGP39BcLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250451; c=relaxed/simple;
	bh=sRUHO0V6v4IiVJzfutqZl4rxkSrjNVBaQeQcAY66YYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx9tB0ZPhlr1Vie0eUc/l7O4j6elqGHomhhM4Su+EYVSXxeP4z4ZBpbKQ7lE6Yv2nzPQ/5FnjfQBIvCbDvrOe09KXKKV527YZ8kr0p5AhA1RA2QcanPU5VaPLOCWddLtlU6EXqTsNOlTLdFlTZS6JWxnpBjKr0ykW4g98oQYDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fQycvRkt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dae5d473so3827865e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762250446; x=1762855246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrVpl3E/6s5NsKKkervHgQ2NBXOPhErz4T5O28Dt8oI=;
        b=fQycvRktF7uYOooHw9kh5kptshG7GfzYLC551Yahb+gHDtgnm+a0X4Rxv9ZqOswHKj
         mH7S+QevQJVF2gmwzhouVY/OQ+tN+Gu491r/RhqBCeYIJFAuKP/UQL/jUfVKwogjfOQa
         R53ZXrfh4JOhWu6ch4In2+U/4ECVX7Xda63gaJkzQ9O/TlgXetlunqPP7e7t07GQd5tv
         VIKi1Ols0U5Tt05srFUhY0GXuvg8jegUcVQyIwSTAqWuvehg9M99Z7ckTL38OLR6mrFj
         qcG19Fi8uhbE7DN5HyuofdKz+d5ncMdfkUax6WexZ9Cu8fcNDhNPKwQ+NIyAkQy34J67
         uWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250446; x=1762855246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrVpl3E/6s5NsKKkervHgQ2NBXOPhErz4T5O28Dt8oI=;
        b=IJYNDbrOk+vPN8N5+jAQ3rS3U6MwpJlp7qZcCan3JiTmJKfo05EKVrha5xjpkuwP7P
         KAL0OMQE3LQWhBq4cDe6mx5kN0A4p+6TsD/QTpqRaPMBmWwQgzfwea/XPJT7o+qOXHWd
         +PU2Q+4lWZLgcddOG4luk/gGnY06J7smXMVNhN3ga7sQtVUCJIWRbtF6pYUB1ZF+za1V
         OF0wrr10/9Jqm6CCGbtb+JYGvt5B6I0Hg+/9R9s/wKa3WnsO/z9SFAdg5n+Bhn/+yd1/
         viXn1u6KofUnOkvSrnJErCCOpu+YO0Wbi3BdafPt7ityGem10cgvShDpT2jNKJMKX6Cg
         Meqw==
X-Gm-Message-State: AOJu0Yxur5VE8fe6HdxtJBk2vV3c7xbhPCDmWAWakXLJ8dNEFWy3z7B6
	dO/mZLW3hY5/XCktPn9twKr2N8nXXKF+EHV3ZVY3rDi/TdKD+0l7sRXIz5oF0VEK1YSzfXEk9Ha
	DUpaK
X-Gm-Gg: ASbGncs5eAU6tcRY4cPp5BviCJQe9B94u1J7tMQFfpwNTCEP8otS9eULVbzv6/2mf6i
	xtLGfYgVlE8RAktRAAdbCpPDk542s7SOtdvabpU1uLA8BqILhD1Eu6N63eUiYB3MYzVnxm7Zgu8
	VrVfdzZJ6IaYKcxdyotzPbNAOV6SsIkeEhTkeqwGhylRei82NtlKA1DxVatv/xb45JDFHBgWPj3
	ec8Qw8n8Jzm7OCkj6EuaRMUIHzfZmDVeBamDNVMy3FjKcRTwHkCmC51eWOu/SFY5bkb8/glOIXm
	iI/cqJglDUggYKR1PRetUw3Nuydmslw2qSkuNmgv+zWZaXqnxl/+tkDmdi5Xsuq1mX7T6IvHswf
	94uiCoPIO3846ZfcXCMBRlGjj3TtXVQjolKVWPs7xbsxtFKGhODmWdeIdUjLLk63Wki//5/ZIRo
	gq1Yx2Mrx+J/62qJN0YyJanwOU
X-Google-Smtp-Source: AGHT+IFHudT2BHt5J4+8Tt/0BeBl+nlhZIDT/GiCDjhW/6ivQk+R8BThr8cKjE4mSXq67ExedwdaKA==
X-Received: by 2002:a05:600c:8b6b:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477307c1fc6mr173126175e9.8.1762250445726;
        Tue, 04 Nov 2025 02:00:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm14325865e9.5.2025.11.04.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:00:45 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 1/3] drm/i915: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:00:30 +0100
Message-ID: <20251104100032.61525-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104100032.61525-1-marco.crivellari@suse.com>
References: <20251104100032.61525-1-marco.crivellari@suse.com>
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

This patch continues the effort to refactor worqueue APIs, which has
begun with the change introducing new workqueues:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 2 +-
 drivers/gpu/drm/i915/display/intel_tc.c            | 4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c       | 2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  | 6 +++---
 drivers/gpu/drm/i915/i915_active.c                 | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          | 2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c           | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp.c               | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_irq.c           | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index da4babfd6bcb..002a7ba6f630 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -645,7 +645,7 @@ queue_async_put_domains_work(struct i915_power_domains *power_domains,
 						     power.domains);
 	drm_WARN_ON(display->drm, power_domains->async_put_wakeref);
 	power_domains->async_put_wakeref = wakeref;
-	drm_WARN_ON(display->drm, !queue_delayed_work(system_unbound_wq,
+	drm_WARN_ON(display->drm, !queue_delayed_work(system_dfl_wq,
 						      &power_domains->async_put_work,
 						      msecs_to_jiffies(delay_ms)));
 }
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index c4a5601c5107..2677e25c42f2 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1838,7 +1838,7 @@ bool intel_tc_port_link_reset(struct intel_digital_port *dig_port)
 	if (!intel_tc_port_link_needs_reset(dig_port))
 		return false;
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &to_tc_port(dig_port)->link_reset_work,
 			   msecs_to_jiffies(2000));
 
@@ -1919,7 +1919,7 @@ void intel_tc_port_unlock(struct intel_digital_port *dig_port)
 	struct intel_tc_port *tc = to_tc_port(dig_port);
 
 	if (!tc->link_refcount && tc->mode != TC_PORT_DISCONNECTED)
-		queue_delayed_work(system_unbound_wq, &tc->disconnect_phy_work,
+		queue_delayed_work(system_dfl_wq, &tc->disconnect_phy_work,
 				   msecs_to_jiffies(1000));
 
 	mutex_unlock(&tc->lock);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 2f6b33edb9c9..008d5909a010 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -408,7 +408,7 @@ static void __memcpy_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 
 	if (unlikely(fence->error || I915_SELFTEST_ONLY(fail_gpu_migration))) {
 		INIT_WORK(&copy_work->work, __memcpy_work);
-		queue_work(system_unbound_wq, &copy_work->work);
+		queue_work(system_dfl_wq, &copy_work->work);
 	} else {
 		init_irq_work(&copy_work->irq_work, __memcpy_irq_work);
 		irq_work_queue(&copy_work->irq_work);
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
index 52ec4421a211..1c2764440323 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -624,7 +624,7 @@ int intel_guc_crash_process_msg(struct intel_guc *guc, u32 action)
 	else
 		guc_err(guc, "Unknown crash notification: 0x%04X\n", action);
 
-	queue_work(system_unbound_wq, &guc->dead_guc_worker);
+	queue_work(system_dfl_wq, &guc->dead_guc_worker);
 
 	return 0;
 }
@@ -646,7 +646,7 @@ int intel_guc_to_host_process_recv_msg(struct intel_guc *guc,
 		guc_err(guc, "Received early exception notification!\n");
 
 	if (msg & (INTEL_GUC_RECV_MSG_CRASH_DUMP_POSTED | INTEL_GUC_RECV_MSG_EXCEPTION))
-		queue_work(system_unbound_wq, &guc->dead_guc_worker);
+		queue_work(system_dfl_wq, &guc->dead_guc_worker);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 2c651ec024ef..e015ff042c46 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -31,7 +31,7 @@ static void ct_dead_ct_worker_func(struct work_struct *w);
 	do { \
 		if (!(ct)->dead_ct_reported) { \
 			(ct)->dead_ct_reason |= 1 << CT_DEAD_##reason; \
-			queue_work(system_unbound_wq, &(ct)->dead_ct_worker); \
+			queue_work(system_dfl_wq, &(ct)->dead_ct_worker); \
 		} \
 	} while (0)
 #else
@@ -1241,7 +1241,7 @@ static int ct_handle_event(struct intel_guc_ct *ct, struct ct_incoming_msg *requ
 	list_add_tail(&request->link, &ct->requests.incoming);
 	spin_unlock_irqrestore(&ct->requests.lock, flags);
 
-	queue_work(system_unbound_wq, &ct->requests.worker);
+	queue_work(system_dfl_wq, &ct->requests.worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 68f2b8d363ac..364879a4d1d8 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -3385,7 +3385,7 @@ static void guc_context_sched_disable(struct intel_context *ce)
 	} else if (!intel_context_is_closed(ce) && !guc_id_pressure(guc, ce) &&
 		   delay) {
 		spin_unlock_irqrestore(&ce->guc_state.lock, flags);
-		mod_delayed_work(system_unbound_wq,
+		mod_delayed_work(system_dfl_wq,
 				 &ce->guc_state.sched_disable_delay_work,
 				 msecs_to_jiffies(delay));
 	} else {
@@ -3611,7 +3611,7 @@ static void guc_context_destroy(struct kref *kref)
 	 * take the GT PM for the first time which isn't allowed from an atomic
 	 * context.
 	 */
-	queue_work(system_unbound_wq, &guc->submission_state.destroyed_worker);
+	queue_work(system_dfl_wq, &guc->submission_state.destroyed_worker);
 }
 
 static int guc_context_alloc(struct intel_context *ce)
@@ -5382,7 +5382,7 @@ int intel_guc_engine_failure_process_msg(struct intel_guc *guc,
 	 * A GT reset flushes this worker queue (G2H handler) so we must use
 	 * another worker to trigger a GT reset.
 	 */
-	queue_work(system_unbound_wq, &guc->submission_state.reset_fail_worker);
+	queue_work(system_dfl_wq, &guc->submission_state.reset_fail_worker);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 6b0c1162505a..582e5099e980 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -193,7 +193,7 @@ active_retire(struct i915_active *ref)
 		return;
 
 	if (ref->flags & I915_ACTIVE_RETIRE_SLEEPS) {
-		queue_work(system_unbound_wq, &ref->work);
+		queue_work(system_dfl_wq, &ref->work);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
index d2e56b387993..366418108f78 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
@@ -38,7 +38,7 @@ fence_notify(struct i915_sw_fence *fence, enum i915_sw_fence_notify state)
 			if (test_bit(DMA_FENCE_WORK_IMM, &f->dma.flags))
 				fence_work(&f->work);
 			else
-				queue_work(system_unbound_wq, &f->work);
+				queue_work(system_dfl_wq, &f->work);
 		} else {
 			fence_complete(f);
 		}
diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
index 53d619ef0c3d..a8f2112ce81f 100644
--- a/drivers/gpu/drm/i915/i915_vma_resource.c
+++ b/drivers/gpu/drm/i915/i915_vma_resource.c
@@ -202,7 +202,7 @@ i915_vma_resource_fence_notify(struct i915_sw_fence *fence,
 			i915_vma_resource_unbind_work(&vma_res->work);
 		} else {
 			INIT_WORK(&vma_res->work, i915_vma_resource_unbind_work);
-			queue_work(system_unbound_wq, &vma_res->work);
+			queue_work(system_dfl_wq, &vma_res->work);
 		}
 		break;
 	case FENCE_FREE:
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp.c b/drivers/gpu/drm/i915/pxp/intel_pxp.c
index 27d545c4e6a5..b188c4deafb3 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp.c
@@ -276,7 +276,7 @@ static void pxp_queue_termination(struct intel_pxp *pxp)
 	spin_lock_irq(gt->irq_lock);
 	intel_pxp_mark_termination_in_progress(pxp);
 	pxp->session_events |= PXP_TERMINATION_REQUEST;
-	queue_work(system_unbound_wq, &pxp->session_work);
+	queue_work(system_dfl_wq, &pxp->session_work);
 	spin_unlock_irq(gt->irq_lock);
 }
 
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_irq.c b/drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
index d81750b9bdda..735325e828bc 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
@@ -48,7 +48,7 @@ void intel_pxp_irq_handler(struct intel_pxp *pxp, u16 iir)
 		pxp->session_events |= PXP_TERMINATION_COMPLETE | PXP_EVENT_TYPE_IRQ;
 
 	if (pxp->session_events)
-		queue_work(system_unbound_wq, &pxp->session_work);
+		queue_work(system_dfl_wq, &pxp->session_work);
 }
 
 static inline void __pxp_set_interrupts(struct intel_gt *gt, u32 interrupts)
-- 
2.51.1


