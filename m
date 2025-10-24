Return-Path: <linux-kernel+bounces-868547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A2C056F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8976F4FD10A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300530DEB6;
	Fri, 24 Oct 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRTZNBDo"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96430CD80
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299542; cv=none; b=XFQrUUXz+xgKbUkdjcArm/+0lNitfvX/dTg+Xhhvfjh4sLph+QN3eCIOiiM1SkdVgA+n4eH+Ny4UhQWGWQCUKFfhFfYkGRFN0IDgz1dXF3BhmTtcnr7sslm8LsbdD/jKgTx2s9NUb2xHWfxx4dXSvL06wqNsjB9nxItiSBgRwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299542; c=relaxed/simple;
	bh=ep901+m/r4rHXs7yIDCYpyHGBdSsovQkMkllnz1rrDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3Zi/d1p8d3ci5zyhZqIxU53bIQin4CBanCbknkllTkoMRfqkNncXOkwCVTJxFyaLD6Nf4cAtN5ioU/3+BQrNZjsMc3YcDKvycSFppK6hFPkjh4/TK7W2tZnwFi3xkQXcrIP6gCxFLUlFFJKwg/DKStFh51lok2x7lnoIBwULy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PRTZNBDo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4298a028de6so1153401f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761299538; x=1761904338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL6t4wl66/AcShNCdZ7n7LoevEBAIZyasNbsi4B8v3s=;
        b=PRTZNBDoX39nsdf7LbO+ZIXe7BIDbTYRsJvjNTtK2vNIUH7CdjzopFhUsZ+k9K3bGx
         kG3hnOFDODfBtxnczjeGf7M1DwdH9PcexEKuJ5QlzfmJDM6gkiONHEViQQ+hUsQBNHzA
         Lm1LIMLpvZcukexdlLCKpZ+z3c6PrWguoMWNrawKBuXhIY7f9RYZfzhR5bTEfmsFTDw8
         JRAOg2RFpoeLLBlZavyLBSEVDYX+BegdV+p41GIxPs0PPpsFQbcggVtxLohRIHxAKY9Q
         jAP8Y4Chc1F/CPo7zJs0N5XrpPgxfKlW7QGrTeKyb1gkFVWVmU1eArdMCdYA2ladyOlp
         QaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761299538; x=1761904338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL6t4wl66/AcShNCdZ7n7LoevEBAIZyasNbsi4B8v3s=;
        b=R6LjCl4kQ0+BW3xoPm1i1TbvDyNJANCtkZJ9cMQVDT52HeHtfgqK4issc4gX0VMqg1
         4vjy8vgO6oOET4o1qN1rds4MEo4UA+vrn3/Ls+sXQQagOQyOqkdC9BsEWozBDCQpJ2hQ
         xLmuqlDdxeFHWpXeTtpJerA96HscrSYdM6rt9fz0C2IIyfhLra1cLWPmLwZ/Qdt+WTC3
         0MxhrFK93YV80BlRjWROHoCiYhEdfthBD27WqCVL4Jey0XFOBsmO4a8htXsWcuDn05Sm
         IQ/CDfc/CRuh4XiYIH35yTsOAsVh5rYQg1aEO8IQTBhr+Xk5l77Qnoiponp9qAFFiyFo
         g/2Q==
X-Gm-Message-State: AOJu0YwR1cPCbeGwunvhCQNPe55VVbqEgflr7l92HOe0Ei/qTfxq9Wq8
	OOPLQ1iRH9/YHZefCUt/Tb90d36ZEHU2NGclALEysaPPWgkPhBDHiYBx5KWLnKbLucmjTq44FA+
	w10+f
X-Gm-Gg: ASbGncv3ptIEGGwbK4RZKYfpnbpSLPjnKARDxE8vzGfCGnVtQ7QdUUSuWrxI8vPU3p9
	hliqRqC7xX3fcbX+kKL55IrBUiqTIiAzd+NYStOM9mXiY1PpaQaxJotqzMaWpAs3cgcOYctQDLC
	QUrT9dDI9kC5DcTaF/z3o2T9ScQtrI7kY3XCmhvpAip0bsrM4xSvcAE/N0hXCqHalmyldicSgbt
	RLaFTpY7brx9d0AbRYRzxPtJ2EjYdH6sXZ7UT9OqswLM/J1T20XROnSFUlNevNX3QFupOmD3FZJ
	yuzLBErvYPh0ettDAD6A8d/0YOpv8re8mXiUQe+a6qjp2guomJwe377FVxZ5SrxUcNt/+xantiQ
	NF0sg+LNA32Dd7nmmgxkMFPnEhHhi74taZklQ5gPpkvzbkwkw00hq/dhvDt1GcmSpPFWLu8llyt
	epJbcV81Imz2dz9+/xiVfqWkrG
X-Google-Smtp-Source: AGHT+IFQ9F5xlltb7vARep/Fm2WMuyxTknf+tJucO4GujtQcq6ALeTqrvlnlEwRyCUiBHpuH8ccDvw==
X-Received: by 2002:a05:6000:2dc6:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-4298f563076mr1617789f8f.18.1761299538086;
        Fri, 24 Oct 2025 02:52:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57b7sm8402376f8f.16.2025.10.24.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:52:17 -0700 (PDT)
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
Subject: [PATCH 2/2] accel/ivpu: replace use of system_wq with system_percpu_wq
Date: Fri, 24 Oct 2025 11:52:05 +0200
Message-ID: <20251024095205.123123-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024095205.123123-1-marco.crivellari@suse.com>
References: <20251024095205.123123-1-marco.crivellari@suse.com>
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

This lack of consistentcy cannot be addressed without refactoring the API.

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
 drivers/accel/ivpu/ivpu_pm.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
index ffa2ba7cafe2..0cff8f808429 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -226,7 +226,7 @@ void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
 	unsigned long timeout_ms = ivpu_tdr_timeout_ms ? ivpu_tdr_timeout_ms : vdev->timeout.tdr;
 
 	/* No-op if already queued */
-	queue_delayed_work(system_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
+	queue_delayed_work(system_percpu_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
 }
 
 void ivpu_stop_job_timeout_detection(struct ivpu_device *vdev)
-- 
2.51.0


