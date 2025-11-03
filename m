Return-Path: <linux-kernel+bounces-883378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B314AC2D3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6366C4E61FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838031A7FD;
	Mon,  3 Nov 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fSjVfOXw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5E3164C7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188496; cv=none; b=C+z4HnnKC6K3BHVZYem/ws2nIkUULTMKc+wlxkjgP+REDN4qffiEUBdHbIt+8ECjx6X21gNDWSRZZ1GXis9RfQ74wVS7TpM0GGQlY4fm6XvsdnC6YmQ2JuGLeEMxB8MuaWjje25n8LeuA9YcYnjVM3feI2vWVHrIO6mc4BkGSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188496; c=relaxed/simple;
	bh=DQnu/qx+bbCujSDYnCMYQREzuNsj4U50G09gP7JCdQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVaoDWnmDteT291EZ2BDtltDKiQjmnehlK+XTNtF7ktrAhY3HXVL/0AbzvRe4YX6Tecd3f3GeAYl/74Sy1w9eFArWM4TOYdwvfekGhopbH/6TkvS4PSqlJOuuOQZVZHsQYbjpMjk94dSCXMlPq3B1VyUPY8ihRDJWFLKx3Iu5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fSjVfOXw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47114a40161so55366725e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762188491; x=1762793291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnDoeoK2NTgGTdYKzRnISsCxrs1i8naDYEdlbOfltL4=;
        b=fSjVfOXwRZrwbm8emwHXRU1y8CMWOKXSlhYhHr1ywJJjUqXW5ONamAj9/zB0Yw6xdl
         D1acf//TOT05ghey2w4HLOaEsOavIzLOOBSRNU0foI/dyjwrlMHYonE0oBFZa2anNS6/
         zkp38DYOfTey8sM8evY2ECUMcgQrGmMO3jyAqqFgd317QBGrgxJ7GAbbExOgWGJc8j72
         v9JWmq9E+cX3JyspZIKgFKnPTLy18YjSQn8FrJ5VDzUyBZ82YEbId6zCYjh1ZXuj3DCd
         oLKBLNJtqKw+rwzjSUa3brvLvzoQlZvtce02iptKoWNKNTys7SMvtHOm9g9X4ryPECee
         TINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188491; x=1762793291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnDoeoK2NTgGTdYKzRnISsCxrs1i8naDYEdlbOfltL4=;
        b=p+s/yxHCQEjVta80j7UqpIG2d//75OMqKWDCmmr5MNvcadnMzQouJ8c0x8XCHxVQI9
         c64ZvWbMDt1j1FP+fGonx3QYa9u+ToyTKXsMk2E4Hpz+UuCMyuG49cWPeAjSsd5WVmMA
         51+dQsVD5Yp00wwyFAwWPug5WLmzYnVkgmJp4SsSgzQYgC6s01fKgXa0+TlZWzdTFv/A
         y24IdnNDymE6XpL/HZAx2ILHeCYurL9+Uxl6TqXQIRo9ydFL0y6Ec1VRor/nQPqbH/bM
         XYZQcp2z6vE2m9Tr2fYA3NGZiLcz3wf5sQC6Z6PExoytlMlNFY+KXwQb1Zboeh4Y7cMv
         mmug==
X-Gm-Message-State: AOJu0YzQNG819YwEUcNYXJ60HrfOP2Ea5sR70qKna1a4O4JENmFMyr6O
	K2VbNaRVlMwQy3O08XYV9DtoCOoUil4gfcOABJgkcYjHpNlhKipT2i87F0NHFH3zGnX/kWEz3lW
	k56V4
X-Gm-Gg: ASbGnct8/6LFfLKqSeqBlen5Km0HZiKHuSBMStX+HSCis8De4f/GjR6BSLfFlgR0lND
	yKhZjGjWG5VK/BkuXrsq8CIwnFOzOjL0L0e3iUMX/z0+zumannE0vwqoGXjOrT6vDI7Q6YWbAfO
	g0g0ffOLea3clKUHhZ0gHQj6AiihwfmSQi9odeJ0vEt1F8/sI2dzzzPhZfTndjvrNBzEVLuyZQo
	RT/DJsOmKohorRgVFN5BKmVUIZIMQFsrq4mIQZoZCrujU1vTonE2LuPsSIzwE0iK9sy7GLDkc8k
	b0vYrdar3VZFegpG5+2nOE/QEpt/4wEmsEAUpAMwzxUHGBj7XbDTIAyuv3W5CWAipp6KXY2y7k5
	0DB7pBoMR/NicFtawfE27Z0BwI2j7+PUTsjNXUbkWnF+mfXq3YYF70l7tsEbJAW3CfLMUmwiH/e
	WetPw0iI4jMEGYAL7ObOkfYogkw4ULEEGEjfQ=
X-Google-Smtp-Source: AGHT+IEoMWlnAzZ6Q93iFmKD/1VAYQs/bBXVX/NXkOfj3V1jV2QspY1vQAEvUyQerWKj+OKKTmuS+Q==
X-Received: by 2002:a05:600c:470c:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-477307e4890mr120428575e9.13.1762188490677;
        Mon, 03 Nov 2025 08:48:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm9864899f8f.24.2025.11.03.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:10 -0800 (PST)
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
Subject: [PATCH v2 1/3] drm/i915: replace use of system_unbound_wq with system_dfl_wq
Date: Mon,  3 Nov 2025 17:47:58 +0100
Message-ID: <20251103164800.294729-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103164800.294729-1-marco.crivellari@suse.com>
References: <20251103164800.294729-1-marco.crivellari@suse.com>
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

The above change to the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

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


