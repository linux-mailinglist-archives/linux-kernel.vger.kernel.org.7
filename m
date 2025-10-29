Return-Path: <linux-kernel+bounces-876784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6BC1C50C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44866188C995
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CA347FE9;
	Wed, 29 Oct 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AM+/DvZH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52B24113D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757020; cv=none; b=m4hLuC830sd+gdFT53xEtkkUTm9Kl/KUDchRFjEiKiiRmUaHHiD7h8/2MGMe3Se/UgzQf6nOc7E3mq0FOShxzZlj+mPc9F0szKNvwfO6MOgCOsA+WONvxc5v3CSM2fOJmcOzIeT+fLiiJW8BoKBogVQwHjZVAjM7zeZ7plgZWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757020; c=relaxed/simple;
	bh=UdkIFT8Mz+YY05TxFB6sgViwAHvshuyk/X86KPsz8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl7NPLJzN18KFg4MhUq2oLGuby1Je14sxPJVVta/pjCj0HdQ1F/W8I7X9LmAlID/fc1cS2j8Tz24QHvrs1iI7GG1holg/uDklDogrcXSKxYZL9vptsVJM5Ee6SRcDaUV/kgOd4FuQT8vpYc6CGqbWgawSRAF4XIrGCQJi2m6tPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AM+/DvZH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so358085e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761757017; x=1762361817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3fwimJIAawa0pjVoXec35/1jofr54T3nJPQIURfOc0=;
        b=AM+/DvZHZ/hvpkY1+VMrgjSMGLfOd7bSgGTGQUJrIJhxoxfInHOhn99T6pwpfhXcXO
         h59WvJb/Z4teNWDA1SgivNu3QgLtEKnpERwkdYMTLMQmAcNOmP7ovui3yX9iAnLRd8vS
         FqVEgrM1MskRr+gGHRyVL7M2wUHVfbr3LerbwU3hXi7iWhfZmXd5w86sJhMI6CIwf3L1
         tKRbTtPmTeGAgu2qzOnm4fi4/+sDia0JvDWRgnkPoXFqRV4QZsWSHtgfYNguRQprDtny
         FEswTFbhByUGhR2Bry58uJPu4b9x5+ovebs6ZRbHpvfkirvSKuMGviBo/lJKwB0xBm1t
         fr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757017; x=1762361817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3fwimJIAawa0pjVoXec35/1jofr54T3nJPQIURfOc0=;
        b=M3bm865ta7P4/ZHnSrwICzOcVVDvy2oPcDTaSRDwFS6tGibL/Bp0Tg+7sbaNBzQ8n8
         fdIBFV+hbIggrtGpbx3J+As19IHdqMwy08py3Kb9Iil2DI1rQXmpBiSJjo+zzn9pa0X8
         6mYteMQ9injb63FUlMZOzw8pDses0YuxUhPCzfeGuX3yNV6gCTpkQsRxjqHc3G3Xcp2E
         SBYWuulDeOeN+OJeCn2fM6e4fWKjqkuOY0wpXy+kDo9rYu27Ed9JXNp+QuyWcOi6wJ/I
         7D9QlhDDQAXZJpOEpHLN02KU3h9tMcjrwaZAEZC13sj/S7scTlnQRbVz6njsmmbu3vDf
         pnZA==
X-Gm-Message-State: AOJu0YyI+esKtraqHu4TMO6knlLmvgAu5IK0bJzsaaODhL5xJNfX27fC
	/uCAVTGPIv4YN3zxzhmV/bVOxlmb/W2ZutNxc/CGHuyp+U/oIVb7jG7Ff8+hxU8r19paYbQ/aqI
	E/rmH
X-Gm-Gg: ASbGncuMamoNI4ek+FfpHeqDUw8oNSPYUt1faaLNq2qxbS9mwu0uYYcMgbsidF4MSNu
	rojmcMsq/unUJQVYYBUbpYIr3z+JSnOSG9TjREx8jcawpnJHXgml/aIGh4Dn73sfHmSptm3chcH
	vRvJkxibPHCawjO2s6o/rwwuBpfKP782a+2fuX9KqMRMHGi7sc3Noo+P2N0qDN9jbexaTdjeywg
	wQJRqYqO+h8b8D3onEpx9K2Dc1oxsMyYlAQ/bFSCi69psxTdUgkisUuKjoFeouvJvMQyGQK/dHC
	J/TLhrs98Yb6wLxgfQDDqCIHu9AUyeNOqbE8eUquJeiZQna8MycLLK9HvfyfY7CeTl+F+jiMLWT
	Y8dUkp9qW8etjvwQEc7pL1rdhOlkD0uvqLaMiKYieWBpAAdXsIKVXUiCObga/3pCe+26STGG+Xb
	SxEWv0H83Ph3hoUag=
X-Google-Smtp-Source: AGHT+IGlBdH3KaL6DIZZtMv4E8cuqpaFJbIPOQcIbg0DFvQj0ChGVMMLIYHLgSHaNIaXDylAVv6IJA==
X-Received: by 2002:a05:600c:190e:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-4771e165a18mr34957175e9.3.1761757016715;
        Wed, 29 Oct 2025 09:56:56 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fc0335sm48393845e9.2.2025.10.29.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:56:56 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH v2 2/2] accel/ivpu: replace use of system_wq with system_percpu_wq
Date: Wed, 29 Oct 2025 17:56:42 +0100
Message-ID: <20251029165642.364488-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029165642.364488-1-marco.crivellari@suse.com>
References: <20251029165642.364488-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
 drivers/accel/ivpu/ivpu_ipc.c     | 2 +-
 drivers/accel/ivpu/ivpu_job.c     | 2 +-
 drivers/accel/ivpu/ivpu_mmu.c     | 2 +-
 drivers/accel/ivpu/ivpu_pm.c      | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index afdb3b2aa72a..27a345f3befe 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -673,7 +673,7 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, SURV_ERR, status)) {
 		ivpu_dbg(vdev, IRQ, "Survivability IRQ\n");
-		queue_work(system_wq, &vdev->irq_dct_work);
+		queue_work(system_percpu_wq, &vdev->irq_dct_work);
 	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 5f00809d448a..1f13bf95b2b3 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -459,7 +459,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 		}
 	}
 
-	queue_work(system_wq, &vdev->irq_ipc_work);
+	queue_work(system_percpu_wq, &vdev->irq_ipc_work);
 }
 
 void ivpu_ipc_irq_work_fn(struct work_struct *work)
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 060f1fc031d3..7a1f78b84b09 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -574,7 +574,7 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 		 * status and ensure both are handled in the same way
 		 */
 		job->file_priv->has_mmu_faults = true;
-		queue_work(system_wq, &vdev->context_abort_work);
+		queue_work(system_percpu_wq, &vdev->context_abort_work);
 		return 0;
 	}
 
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 5ea010568faa..e1baf6b64935 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -970,7 +970,7 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 		}
 	}
 
-	queue_work(system_wq, &vdev->context_abort_work);
+	queue_work(system_percpu_wq, &vdev->context_abort_work);
 }
 
 void ivpu_mmu_evtq_dump(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index ffa2ba7cafe2..9ecba05ce7db 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -226,7 +226,8 @@ void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
 	unsigned long timeout_ms = ivpu_tdr_timeout_ms ? ivpu_tdr_timeout_ms : vdev->timeout.tdr;
 
 	/* No-op if already queued */
-	queue_delayed_work(system_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
+	queue_delayed_work(system_percpu_wq, &vdev->pm->job_timeout_work,
+			   msecs_to_jiffies(timeout_ms));
 }
 
 void ivpu_stop_job_timeout_detection(struct ivpu_device *vdev)
-- 
2.51.0


