Return-Path: <linux-kernel+bounces-802425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7DB45248
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004207B6BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23217308F11;
	Fri,  5 Sep 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QRXhuNiu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DC3002D1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062702; cv=none; b=WB80MoJjLD9sPP683H6COyd36FFS15mUZgupLHWu/dNLmp/nwFYxAMRjCt2hY4FcvXDLuhce6NOB2TDcTtoDrTyU701R6xVsiDFU1epjra6zBbMhpeWBttnD3A2uNgfqHLOF3xmHO/XMSKK9USAlsRsdYoT5QKd3SO8c1/bjsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062702; c=relaxed/simple;
	bh=05DpSF4B+rc9ubuOBVlAebm08IRjTQQ20n3nYqYF0hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9PAPPRoBtXzIR92vjRO2gp1n9YltNAEmoaamQZkTK3O+yz/zXS6JE/zgSjXCMKxHcM13HqHWlsJAnuLkBZIyqC9DuMI2fGkOaLXeANIbMhQp6OXD6TgYixh7h9rvkLN8WA1+HMLncvdLj96Jv482pywKqTuTbz3FHyMBITFRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QRXhuNiu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so11868015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062697; x=1757667497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5oC5dcNIZcHUh4bYRNlUj/eufsmsR52FROMjZBL1CI=;
        b=QRXhuNiuzDg6a5vCTYzPgrri6xmM58aF/Do/FcNMxHJ4ry+ne68sFoyl4X11LlmECH
         6SdrHNtul2/67iadN+uhRxEiVdPmcSnHokAk7kNdY7YvL3A7P6bCK7XF+BMpfW4N3V+6
         OjLQnPcnMV32w5od+X6Oae6mFXH3DsIB8amSAnzheaYwEdk1WRJfkZ2rQVMq77foqx7u
         BXzUITmh25eZy6cirAaGTrvb9yMm3Z7XcY5dFrThjUCudb7Kps8S7rBZ3f0Dm4DoWp1B
         NOs7VMRYN5JLmIO/r+k8CY1z5mzjct0xjuVBVBubSnzJHnotPN00ttSZBuMw06/lzjxA
         F0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062697; x=1757667497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5oC5dcNIZcHUh4bYRNlUj/eufsmsR52FROMjZBL1CI=;
        b=Ut/fCxMPi6VF+1DeHw1Ykjv9NVAz3bmhbBmkSm3OXTAjZg9/TpNchWqWD9nDffoykb
         MMJQg4xoiCCW7HmQ9o22nN3QmcDQcjUuIEkcbPPTV1Z7ykffpFVQXiYfarknKfKFlxvl
         fucxbwusH7OPsdjHkp7ynXNIAR3QeD3no5aLyyeZabh/s+ruse37Bore4/2Jc6B5oyTt
         v1yHj2CbA7Yd/f5p4xEnKw3isOnzHS+aq5wzrGkmeyE/p6WcFl5rwk7QdRCjC8p7oXex
         cyP9DwCARnb0dhij7O86pjJd91mIYOcrbWa2Pfw2HyvIwWyxyVZ7fuESej69L48y3318
         1IOQ==
X-Gm-Message-State: AOJu0YxHDwUJcId/8ezHsI+jrI/VGb9nkrQcwMOFPhAMfuR4dqowSICo
	YPP9rFtGhxDbu2IoOojkb3Kz8GenFNvUClP5bQlRAha2YYTPM6SxVzfN9CRMcnF5jLEsjDhYbmc
	30V6v
X-Gm-Gg: ASbGncvefRqrLYOFasmVAd3tdPY22BHa9R4lMifnLbR+qdHBKzBGer7pCxBIGLqQ5ws
	glY1ogo9XY6d9NQJO92wO2mPQZkxSARCAatkPlVFMkmQrokk5OAXxm0dfgo9ehLPGJTncPSnxrj
	WgV0dlyPasUzfV4PAuuT9KpzIyO/LVmupbwhrQ/HU2lh0n7rFAyMsl0hfg+QgDrVvHYwwSAWxtg
	oG/i1vdT8JqyvuSZlbwnrSqHRlTTZ4BJ596nwmj9NNpVBmjetpVVguOhMlBUUCP7BcA0czQK7iL
	uNviKnOWF7T1o4szJNW6gFHlimzrlC5L1L1vnJ56MFZfOcUvjGc8Gkdllza8KzdEhKIjc/iEN8u
	9l46Bx7nz7dgCHbR67p/y0Vq6vQ4QlyJWCAvRughKug9v4vs=
X-Google-Smtp-Source: AGHT+IEFaHcxDKLZFgnVPd/F/uLddBeL8VLtZ1ONDt2J+6nCxN9Bq8OR50Xs/TPBQzuVZPOiwxa8fA==
X-Received: by 2002:a05:600c:3587:b0:45b:804a:a65e with SMTP id 5b1f17b1804b1-45b8559a928mr170975025e9.28.1757062696696;
        Fri, 05 Sep 2025 01:58:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm334698915e9.18.2025.09.05.01.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:58:16 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drivers: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:58:00 +0200
Message-ID: <20250905085801.98754-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085801.98754-1-marco.crivellari@suse.com>
References: <20250905085801.98754-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/accel/ivpu/ivpu_hw_btrs.c             |  2 +-
 drivers/accel/ivpu/ivpu_ipc.c                 |  2 +-
 drivers/accel/ivpu/ivpu_job.c                 |  2 +-
 drivers/accel/ivpu/ivpu_mmu.c                 |  2 +-
 drivers/accel/ivpu/ivpu_pm.c                  |  2 +-
 drivers/acpi/osl.c                            |  2 +-
 drivers/base/devcoredump.c                    |  2 +-
 drivers/cxl/pci.c                             |  2 +-
 drivers/extcon/extcon-intel-int3496.c         |  4 ++--
 drivers/gpio/gpiolib-cdev.c                   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++--
 drivers/gpu/drm/bridge/ite-it6505.c           |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c            |  2 +-
 drivers/gpu/drm/drm_probe_helper.c            |  2 +-
 drivers/gpu/drm/drm_self_refresh_helper.c     |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c          |  2 +-
 drivers/gpu/drm/i915/i915_driver.c            |  2 +-
 drivers/gpu/drm/i915/i915_drv.h               |  2 +-
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  4 ++--
 drivers/gpu/drm/scheduler/sched_main.c        |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                |  4 ++--
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c   |  6 +++---
 drivers/gpu/drm/xe/xe_pt.c                    |  2 +-
 drivers/iio/adc/pac1934.c                     |  2 +-
 drivers/input/keyboard/gpio_keys.c            |  2 +-
 drivers/input/misc/palmas-pwrbutton.c         |  2 +-
 drivers/input/mouse/synaptics_i2c.c           |  8 ++++----
 drivers/leds/trigger/ledtrig-input-events.c   |  2 +-
 drivers/md/bcache/super.c                     | 20 +++++++++----------
 drivers/mmc/host/mtk-sd.c                     |  4 ++--
 drivers/nvdimm/security.c                     |  4 ++--
 drivers/nvme/target/admin-cmd.c               |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c        |  2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |  2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         | 14 ++++++-------
 .../platform/cznic/turris-omnia-mcu-gpio.c    |  2 +-
 .../surface/aggregator/ssh_packet_layer.c     |  2 +-
 .../surface/aggregator/ssh_request_layer.c    |  2 +-
 drivers/platform/x86/gpd-pocket-fan.c         |  4 ++--
 .../x86/x86-android-tablets/vexia_atla10_ec.c |  2 +-
 drivers/ras/cec.c                             |  2 +-
 drivers/regulator/irq_helpers.c               |  2 +-
 drivers/regulator/qcom-labibb-regulator.c     |  4 ++--
 drivers/thunderbolt/tb.c                      |  2 +-
 drivers/usb/dwc3/gadget.c                     |  2 +-
 drivers/usb/host/xhci-dbgcap.c                |  8 ++++----
 drivers/usb/host/xhci-ring.c                  |  2 +-
 drivers/xen/events/events_base.c              |  6 +++---
 49 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
index 56c56012b980..62f9dd7dceed 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.c
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
@@ -630,7 +630,7 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, SURV_ERR, status)) {
 		ivpu_dbg(vdev, IRQ, "Survivability IRQ\n");
-		queue_work(system_wq, &vdev->irq_dct_work);
+		queue_work(system_percpu_wq, &vdev->irq_dct_work);
 	}
 
 	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status))
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 0e096fd9b95d..247dbb64b4d5 100644
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
index 004059e4f1e8..f63eba4c9d9f 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -549,7 +549,7 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
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
index 118e6ca9a3de..f6a5c494621e 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -198,7 +198,7 @@ void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
 	unsigned long timeout_ms = ivpu_tdr_timeout_ms ? ivpu_tdr_timeout_ms : vdev->timeout.tdr;
 
 	/* No-op if already queued */
-	queue_delayed_work(system_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
+	queue_delayed_work(system_percpu_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
 }
 
 void ivpu_stop_job_timeout_detection(struct ivpu_device *vdev)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..a79a5d47bdb8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -398,7 +398,7 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 	list_del_rcu(&map->list);
 
 	INIT_RCU_WORK(&map->track.rwork, acpi_os_map_remove);
-	queue_rcu_work(system_wq, &map->track.rwork);
+	queue_rcu_work(system_percpu_wq, &map->track.rwork);
 }
 
 /**
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 03a39c417dc4..8c4844ad7c6b 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -125,7 +125,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	mutex_lock(&devcd->mutex);
 	if (!devcd->delete_work) {
 		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+		mod_delayed_work(system_percpu_wq, &devcd->del_wk, 0);
 	}
 	mutex_unlock(&devcd->mutex);
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7b14a154463c..c610551b41bf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -136,7 +136,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
 		mutex_lock(&cxl_mbox->mbox_mutex);
 		if (mds->security.sanitize_node)
-			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
 		mutex_unlock(&cxl_mbox->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index ded1a85a5549..7d16d5b7d58f 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -106,7 +106,7 @@ static irqreturn_t int3496_thread_isr(int irq, void *priv)
 	struct int3496_data *data = priv;
 
 	/* Let the pin settle before processing it */
-	mod_delayed_work(system_wq, &data->work, DEBOUNCE_TIME);
+	mod_delayed_work(system_percpu_wq, &data->work, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -181,7 +181,7 @@ static int int3496_probe(struct platform_device *pdev)
 	}
 
 	/* process id-pin so that we start with the right status */
-	queue_delayed_work(system_wq, &data->work, 0);
+	queue_delayed_work(system_percpu_wq, &data->work, 0);
 	flush_delayed_work(&data->work);
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 107d75558b5a..3e9c037ff4cd 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -700,7 +700,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 	if (READ_ONCE(line->sw_debounced)) {
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
-		mod_delayed_work(system_wq, &line->work,
+		mod_delayed_work(system_percpu_wq, &line->work,
 		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
@@ -841,7 +841,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 {
 	struct line *line = p;
 
-	mod_delayed_work(system_wq, &line->work,
+	mod_delayed_work(system_percpu_wq, &line->work,
 		usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4a2886d8c58..14ebfcd1636a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4610,7 +4610,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 		/* must succeed. */
 		amdgpu_ras_resume(adev);
-		queue_delayed_work(system_wq, &adev->delayed_init_work,
+		queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
@@ -5085,7 +5085,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto exit;
 
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
+	queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
 	if (amdgpu_sriov_vf(adev)) {
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8a607558ac89..433e6620dad8 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2082,7 +2082,7 @@ static void it6505_start_hdcp(struct it6505 *it6505)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "start");
 	it6505_reset_hdcp(it6505);
-	queue_delayed_work(system_wq, &it6505->hdcp_work,
+	queue_delayed_work(system_percpu_wq, &it6505->hdcp_work,
 			   msecs_to_jiffies(2400));
 }
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 79ab5da827e1..d798c951ddcc 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -115,7 +115,7 @@ static void tfp410_hpd_callback(void *arg, enum drm_connector_status status)
 {
 	struct tfp410 *dvi = arg;
 
-	mod_delayed_work(system_wq, &dvi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &dvi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 }
 
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 7ba16323e7c2..30e8d3467c83 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -625,7 +625,7 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			mod_delayed_work(system_wq,
+			mod_delayed_work(system_percpu_wq,
 					 &dev->mode_config.output_poll_work,
 					 0);
 	}
diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
index dd33fec5aabd..12f5af633da3 100644
--- a/drivers/gpu/drm/drm_self_refresh_helper.c
+++ b/drivers/gpu/drm/drm_self_refresh_helper.c
@@ -217,7 +217,7 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
 			 ewma_psr_time_read(&sr_data->exit_avg_ms)) * 2;
 		mutex_unlock(&sr_data->avg_mutex);
 
-		mod_delayed_work(system_wq, &sr_data->entry_work,
+		mod_delayed_work(system_percpu_wq, &sr_data->entry_work,
 				 msecs_to_jiffies(delay));
 	}
 }
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 01813e11e6c6..8e76ac8ee4e2 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1692,7 +1692,7 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
 {
 	struct hdmi_context *hdata = arg;
 
-	mod_delayed_work(system_wq, &hdata->hotplug_work,
+	mod_delayed_work(system_percpu_wq, &hdata->hotplug_work,
 			msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ce3cc93ea211..79b98ba4104e 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -141,7 +141,7 @@ static int i915_workqueues_init(struct drm_i915_private *dev_priv)
 	/*
 	 * The unordered i915 workqueue should be used for all work
 	 * scheduling that do not require running in order, which used
-	 * to be scheduled on the system_wq before moving to a driver
+	 * to be scheduled on the system_percpu_wq before moving to a driver
 	 * instance due deprecation of flush_scheduled_work().
 	 */
 	dev_priv->unordered_wq = alloc_workqueue("i915-unordered", 0, 0);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index ffc346379cc2..b2c194b17eae 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -264,7 +264,7 @@ struct drm_i915_private {
 	 *
 	 * This workqueue should be used for all unordered work
 	 * scheduling within i915, which used to be scheduled on the
-	 * system_wq before moving to a driver instance due
+	 * system_percpu_wq before moving to a driver instance due
 	 * deprecation of flush_scheduled_work().
 	 */
 	struct workqueue_struct *unordered_wq;
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 3d1dddb34603..b115fe655a4b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -274,7 +274,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 
 	val = HIWORD_UPDATE(RK3576_HDMI_HPD_INT_CLR, RK3576_HDMI_HPD_INT_CLR);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
-	mod_delayed_work(system_wq, &hdmi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	val = HIWORD_UPDATE(0, RK3576_HDMI_HPD_INT_MSK);
@@ -321,7 +321,7 @@ static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
 				    RK3588_HDMI0_HPD_INT_CLR);
 	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
 
-	mod_delayed_work(system_wq, &hdmi->hpd_work,
+	mod_delayed_work(system_percpu_wq, &hdmi->hpd_work,
 			 msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
 
 	if (hdmi->port_id)
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index bfea608a7106..d3c0a1ca0b2c 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1260,7 +1260,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	sched->name = args->name;
 	sched->timeout = args->timeout;
 	sched->hang_limit = args->hang_limit;
-	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_wq;
+	sched->timeout_wq = args->timeout_wq ? args->timeout_wq : system_percpu_wq;
 	sched->score = args->score ? args->score : &sched->_score;
 	sched->dev = args->dev;
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index b5f60b2b2d0e..57518a4ab4e1 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -985,7 +985,7 @@ irqreturn_t tilcdc_crtc_irq(struct drm_crtc *crtc)
 				dev_err(dev->dev,
 					"%s(0x%08x): Sync lost flood detected, recovering",
 					__func__, stat);
-				queue_work(system_wq,
+				queue_work(system_percpu_wq,
 					   &tilcdc_crtc->recover_work);
 				tilcdc_write(dev, LCDC_INT_ENABLE_CLR_REG,
 					     LCDC_SYNC_LOST);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 37238a12baa5..4ee5f4d6371e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -744,7 +744,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 
 	vc4_hdmi->scdc_enabled = true;
 
-	queue_delayed_work(system_wq, &vc4_hdmi->scrambling_work,
+	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
 			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
 }
 
@@ -793,7 +793,7 @@ static void vc4_hdmi_scrambling_wq(struct work_struct *work)
 	drm_scdc_set_high_tmds_clock_ratio(connector, true);
 	drm_scdc_set_scrambling(connector, true);
 
-	queue_delayed_work(system_wq, &vc4_hdmi->scrambling_work,
+	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
 			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
 }
 
diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 03072e094991..2b27621a36e5 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -99,7 +99,7 @@ static void xe_gt_tlb_fence_timeout(struct work_struct *work)
 		invalidation_fence_signal(xe, fence);
 	}
 	if (!list_empty(&gt->tlb_invalidation.pending_fences))
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_percpu_wq,
 				   &gt->tlb_invalidation.fence_tdr,
 				   tlb_timeout_jiffies(gt));
 	spin_unlock_irq(&gt->tlb_invalidation.pending_lock);
@@ -218,7 +218,7 @@ static int send_tlb_invalidation(struct xe_guc *guc,
 				      &gt->tlb_invalidation.pending_fences);
 
 			if (list_is_singular(&gt->tlb_invalidation.pending_fences))
-				queue_delayed_work(system_wq,
+				queue_delayed_work(system_percpu_wq,
 						   &gt->tlb_invalidation.fence_tdr,
 						   tlb_timeout_jiffies(gt));
 		}
@@ -512,7 +512,7 @@ int xe_guc_tlb_invalidation_done_handler(struct xe_guc *guc, u32 *msg, u32 len)
 	}
 
 	if (!list_empty(&gt->tlb_invalidation.pending_fences))
-		mod_delayed_work(system_wq,
+		mod_delayed_work(system_percpu_wq,
 				 &gt->tlb_invalidation.fence_tdr,
 				 tlb_timeout_jiffies(gt));
 	else
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index ffaf0d02dc7d..228e25e98be1 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -1474,7 +1474,7 @@ static void invalidation_fence_cb(struct dma_fence *fence,
 
 	trace_xe_gt_tlb_invalidation_fence_cb(xe, &ifence->base);
 	if (!ifence->fence->error) {
-		queue_work(system_wq, &ifence->work);
+		queue_work(system_percpu_wq, &ifence->work);
 	} else {
 		ifence->base.base.error = ifence->fence->error;
 		xe_gt_tlb_invalidation_fence_signal(&ifence->base);
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 20802b7f49ea..77f4679aadbd 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -767,7 +767,7 @@ static int pac1934_retrieve_data(struct pac1934_chip_info *info,
 		 * Re-schedule the work for the read registers on timeout
 		 * (to prevent chip registers saturation)
 		 */
-		mod_delayed_work(system_wq, &info->work_chip_rfsh,
+		mod_delayed_work(system_percpu_wq, &info->work_chip_rfsh,
 				 msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
 	}
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5c39a217b94c..815f58e70671 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -434,7 +434,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 			      ms_to_ktime(bdata->software_debounce),
 			      HRTIMER_MODE_REL);
 	} else {
-		mod_delayed_work(system_wq,
+		mod_delayed_work(system_percpu_wq,
 				 &bdata->work,
 				 msecs_to_jiffies(bdata->software_debounce));
 	}
diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 39fc451c56e9..2d471165334a 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -91,7 +91,7 @@ static irqreturn_t pwron_irq(int irq, void *palmas_pwron)
 	pm_wakeup_event(input_dev->dev.parent, 0);
 	input_sync(input_dev);
 
-	mod_delayed_work(system_wq, &pwron->input_work,
+	mod_delayed_work(system_percpu_wq, &pwron->input_work,
 			 msecs_to_jiffies(PALMAS_PWR_KEY_Q_TIME_MS));
 
 	return IRQ_HANDLED;
diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..d42c562c05e3 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -372,7 +372,7 @@ static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 {
 	struct synaptics_i2c *touch = dev_id;
 
-	mod_delayed_work(system_wq, &touch->dwork, 0);
+	mod_delayed_work(system_percpu_wq, &touch->dwork, 0);
 
 	return IRQ_HANDLED;
 }
@@ -448,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
 	 * if error is detected, we try to reset and reconfigure the touchpad.
 	 */
-	mod_delayed_work(system_wq, &touch->dwork, delay);
+	mod_delayed_work(system_percpu_wq, &touch->dwork, delay);
 }
 
 static int synaptics_i2c_open(struct input_dev *input)
@@ -461,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		return ret;
 
 	if (polling_req)
-		mod_delayed_work(system_wq, &touch->dwork,
+		mod_delayed_work(system_percpu_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
@@ -620,7 +620,7 @@ static int synaptics_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_wq, &touch->dwork,
+	mod_delayed_work(system_percpu_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
diff --git a/drivers/leds/trigger/ledtrig-input-events.c b/drivers/leds/trigger/ledtrig-input-events.c
index 1c79731562c2..3c6414259c27 100644
--- a/drivers/leds/trigger/ledtrig-input-events.c
+++ b/drivers/leds/trigger/ledtrig-input-events.c
@@ -66,7 +66,7 @@ static void input_events_event(struct input_handle *handle, unsigned int type,
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	mod_delayed_work(system_wq, &data->work, led_off_delay);
+	mod_delayed_work(system_percpu_wq, &data->work, led_off_delay);
 }
 
 static int input_events_connect(struct input_handler *handler, struct input_dev *dev,
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e42f1400cea9..de0a8e5f5c49 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1388,7 +1388,7 @@ static CLOSURE_CALLBACK(cached_dev_flush)
 	bch_cache_accounting_destroy(&dc->accounting);
 	kobject_del(&d->kobj);
 
-	continue_at(cl, cached_dev_free, system_wq);
+	continue_at(cl, cached_dev_free, system_percpu_wq);
 }
 
 static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
@@ -1400,7 +1400,7 @@ static int cached_dev_init(struct cached_dev *dc, unsigned int block_size)
 	__module_get(THIS_MODULE);
 	INIT_LIST_HEAD(&dc->list);
 	closure_init(&dc->disk.cl, NULL);
-	set_closure_fn(&dc->disk.cl, cached_dev_flush, system_wq);
+	set_closure_fn(&dc->disk.cl, cached_dev_flush, system_percpu_wq);
 	kobject_init(&dc->disk.kobj, &bch_cached_dev_ktype);
 	INIT_WORK(&dc->detach, cached_dev_detach_finish);
 	sema_init(&dc->sb_write_mutex, 1);
@@ -1513,7 +1513,7 @@ static CLOSURE_CALLBACK(flash_dev_flush)
 	bcache_device_unlink(d);
 	mutex_unlock(&bch_register_lock);
 	kobject_del(&d->kobj);
-	continue_at(cl, flash_dev_free, system_wq);
+	continue_at(cl, flash_dev_free, system_percpu_wq);
 }
 
 static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
@@ -1525,7 +1525,7 @@ static int flash_dev_run(struct cache_set *c, struct uuid_entry *u)
 		goto err_ret;
 
 	closure_init(&d->cl, NULL);
-	set_closure_fn(&d->cl, flash_dev_flush, system_wq);
+	set_closure_fn(&d->cl, flash_dev_flush, system_percpu_wq);
 
 	kobject_init(&d->kobj, &bch_flash_dev_ktype);
 
@@ -1828,7 +1828,7 @@ static CLOSURE_CALLBACK(__cache_set_unregister)
 
 	mutex_unlock(&bch_register_lock);
 
-	continue_at(cl, cache_set_flush, system_wq);
+	continue_at(cl, cache_set_flush, system_percpu_wq);
 }
 
 void bch_cache_set_stop(struct cache_set *c)
@@ -1858,10 +1858,10 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 
 	__module_get(THIS_MODULE);
 	closure_init(&c->cl, NULL);
-	set_closure_fn(&c->cl, cache_set_free, system_wq);
+	set_closure_fn(&c->cl, cache_set_free, system_percpu_wq);
 
 	closure_init(&c->caching, &c->cl);
-	set_closure_fn(&c->caching, __cache_set_unregister, system_wq);
+	set_closure_fn(&c->caching, __cache_set_unregister, system_percpu_wq);
 
 	/* Maybe create continue_at_noreturn() and use it here? */
 	closure_set_stopped(&c->cl);
@@ -2493,7 +2493,7 @@ static void register_device_async(struct async_reg_args *args)
 		INIT_DELAYED_WORK(&args->reg_work, register_cache_worker);
 
 	/* 10 jiffies is enough for a delay */
-	queue_delayed_work(system_wq, &args->reg_work, 10);
+	queue_delayed_work(system_percpu_wq, &args->reg_work, 10);
 }
 
 static void *alloc_holder_object(struct cache_sb *sb)
@@ -2874,11 +2874,11 @@ static int __init bcache_init(void)
 	/*
 	 * Let's not make this `WQ_MEM_RECLAIM` for the following reasons:
 	 *
-	 * 1. It used `system_wq` before which also does no memory reclaim.
+	 * 1. It used `system_percpu_wq` before which also does no memory reclaim.
 	 * 2. With `WQ_MEM_RECLAIM` desktop stalls, increased boot times, and
 	 *    reduced throughput can be observed.
 	 *
-	 * We still want to user our own queue to not congest the `system_wq`.
+	 * We still want to user our own queue to not congest the `system_percpu_wq`.
 	 */
 	bch_flush_wq = alloc_workqueue("bch_flush", 0, 0);
 	if (!bch_flush_wq)
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 345ea91629e0..f99fdef0253d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1190,7 +1190,7 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_command *cmd,
 	host->data = data;
 	read = data->flags & MMC_DATA_READ;
 
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
+	mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
 	msdc_dma_setup(host, &host->dma, data);
 	sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
@@ -1420,7 +1420,7 @@ static void msdc_start_command(struct msdc_host *host,
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
+	mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
 	if (!msdc_cmd_is_ready(host, mrq, cmd))
 		return;
 
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index a03e3c45f297..c8095cd1cf1c 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -427,7 +427,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 		 * query.
 		 */
 		get_device(dev);
-		queue_delayed_work(system_wq, &nvdimm->dwork, 0);
+		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, 0);
 	}
 
 	return rc;
@@ -460,7 +460,7 @@ static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 
 		/* setup delayed work again */
 		tmo += 10;
-		queue_delayed_work(system_wq, &nvdimm->dwork, tmo * HZ);
+		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, tmo * HZ);
 		nvdimm->sec.overwrite_tmo = min(15U * 60U, tmo);
 		return;
 	}
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index acc138bbf8f2..af3ec44a6490 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1613,7 +1613,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bf01ec414c55..8f504bf891de 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -390,7 +390,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d712c7a866d2..45462af6100d 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -638,7 +638,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 	kfree(epf_name);
 
 	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
+	queue_delayed_work(system_percpu_wq, &epf_group->cfs_work,
 			   msecs_to_jiffies(1));
 
 	return &epf_group->group;
diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 29b8fd4b9351..0f9887fda584 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -359,7 +359,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		/* Force ISCR and cable state updates */
 		data->id_det = -1;
 		data->vbus_det = -1;
-		queue_delayed_work(system_wq, &data->detect, 0);
+		queue_delayed_work(system_percpu_wq, &data->detect, 0);
 	}
 
 	return 0;
@@ -482,7 +482,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
 	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
 }
@@ -503,7 +503,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
 	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, POLL_TIME);
 
 	return 0;
 }
@@ -542,7 +542,7 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
 
 	data->id_det = -1; /* Force reprocessing of id */
 	data->force_session_end = true;
-	queue_delayed_work(system_wq, &data->detect, 0);
+	queue_delayed_work(system_percpu_wq, &data->detect, 0);
 
 	return 0;
 }
@@ -654,7 +654,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
 
 	if (sun4i_usb_phy0_poll(data))
-		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
+		queue_delayed_work(system_percpu_wq, &data->detect, POLL_TIME);
 }
 
 static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
@@ -662,7 +662,7 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
 	struct sun4i_usb_phy_data *data = dev_id;
 
 	/* vbus or id changed, let the pins settle and then scan them */
-	mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+	mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -676,7 +676,7 @@ static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
 
 	/* Properties on the vbus_power_supply changed, scan vbus_det */
 	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/platform/cznic/turris-omnia-mcu-gpio.c b/drivers/platform/cznic/turris-omnia-mcu-gpio.c
index 5f35f7c5d5d7..18f7e1c41a86 100644
--- a/drivers/platform/cznic/turris-omnia-mcu-gpio.c
+++ b/drivers/platform/cznic/turris-omnia-mcu-gpio.c
@@ -883,7 +883,7 @@ static bool omnia_irq_read_pending_old(struct omnia_mcu *mcu,
 
 	if (status & OMNIA_STS_BUTTON_PRESSED) {
 		mcu->button_pressed_emul = true;
-		mod_delayed_work(system_wq, &mcu->button_release_emul_work,
+		mod_delayed_work(system_percpu_wq, &mcu->button_release_emul_work,
 				 msecs_to_jiffies(FRONT_BUTTON_RELEASE_DELAY_MS));
 	} else if (mcu->button_pressed_emul) {
 		status |= OMNIA_STS_BUTTON_PRESSED;
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 6081b0146d5f..3dd22856570f 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -671,7 +671,7 @@ static void ssh_ptl_timeout_reaper_mod(struct ssh_ptl *ptl, ktime_t now,
 	/* Re-adjust / schedule reaper only if it is above resolution delta. */
 	if (ktime_before(aexp, ptl->rtx_timeout.expires)) {
 		ptl->rtx_timeout.expires = expires;
-		mod_delayed_work(system_wq, &ptl->rtx_timeout.reaper, delta);
+		mod_delayed_work(system_percpu_wq, &ptl->rtx_timeout.reaper, delta);
 	}
 
 	spin_unlock(&ptl->rtx_timeout.lock);
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index 879ca9ee7ff6..a356e4956562 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -434,7 +434,7 @@ static void ssh_rtl_timeout_reaper_mod(struct ssh_rtl *rtl, ktime_t now,
 	/* Re-adjust / schedule reaper only if it is above resolution delta. */
 	if (ktime_before(aexp, rtl->rtx_timeout.expires)) {
 		rtl->rtx_timeout.expires = expires;
-		mod_delayed_work(system_wq, &rtl->rtx_timeout.reaper, delta);
+		mod_delayed_work(system_percpu_wq, &rtl->rtx_timeout.reaper, delta);
 	}
 
 	spin_unlock(&rtl->rtx_timeout.lock);
diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 7a20f68ae206..c9236738f896 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -112,14 +112,14 @@ static void gpd_pocket_fan_worker(struct work_struct *work)
 	gpd_pocket_fan_set_speed(fan, speed);
 
 	/* When mostly idle (low temp/speed), slow down the poll interval. */
-	queue_delayed_work(system_wq, &fan->work,
+	queue_delayed_work(system_percpu_wq, &fan->work,
 			   msecs_to_jiffies(4000 / (speed + 1)));
 }
 
 static void gpd_pocket_fan_force_update(struct gpd_pocket_fan_data *fan)
 {
 	fan->last_speed = -1;
-	mod_delayed_work(system_wq, &fan->work, 0);
+	mod_delayed_work(system_percpu_wq, &fan->work, 0);
 }
 
 static int gpd_pocket_fan_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 5d02af1c5aaa..94465a62f7e7 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -183,7 +183,7 @@ static void atla10_ec_external_power_changed(struct power_supply *psy)
 	struct atla10_ec_data *data = power_supply_get_drvdata(psy);
 
 	/* After charger plug in/out wait 0.5s for things to stabilize */
-	mod_delayed_work(system_wq, &data->work, HZ / 2);
+	mod_delayed_work(system_percpu_wq, &data->work, HZ / 2);
 }
 
 static const enum power_supply_property atla10_ec_psy_props[] = {
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..15f7f043c8ef 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -166,7 +166,7 @@ static void cec_mod_work(unsigned long interval)
 	unsigned long iv;
 
 	iv = interval * HZ;
-	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
+	mod_delayed_work(system_percpu_wq, &cec_work, round_jiffies(iv));
 }
 
 static void cec_work_fn(struct work_struct *work)
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5742faee8071..54dd19e1e94c 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -146,7 +146,7 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 
 reschedule:
 	if (!d->high_prio)
-		mod_delayed_work(system_wq, &h->isr_work,
+		mod_delayed_work(system_percpu_wq, &h->isr_work,
 				 msecs_to_jiffies(tmo));
 	else
 		mod_delayed_work(system_highpri_wq, &h->isr_work,
diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
index ba3f9391565f..ad65d264cfe0 100644
--- a/drivers/regulator/qcom-labibb-regulator.c
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -230,7 +230,7 @@ static void qcom_labibb_ocp_recovery_worker(struct work_struct *work)
 	return;
 
 reschedule:
-	mod_delayed_work(system_wq, &vreg->ocp_recovery_work,
+	mod_delayed_work(system_percpu_wq, &vreg->ocp_recovery_work,
 			 msecs_to_jiffies(OCP_RECOVERY_INTERVAL_MS));
 }
 
@@ -510,7 +510,7 @@ static void qcom_labibb_sc_recovery_worker(struct work_struct *work)
 	 * taking action is not truly urgent anymore.
 	 */
 	vreg->sc_count++;
-	mod_delayed_work(system_wq, &vreg->sc_recovery_work,
+	mod_delayed_work(system_percpu_wq, &vreg->sc_recovery_work,
 			 msecs_to_jiffies(SC_RECOVERY_INTERVAL_MS));
 }
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 8c527af98927..e842dda55f71 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2617,7 +2617,7 @@ static int tb_alloc_dp_bandwidth(struct tb_tunnel *tunnel, int *requested_up,
 				 * the 10s already expired and we should
 				 * give the reserved back to others).
 				 */
-				mod_delayed_work(system_wq, &group->release_work,
+				mod_delayed_work(system_percpu_wq, &group->release_work,
 					msecs_to_jiffies(TB_RELEASE_BW_TIMEOUT));
 			}
 		}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 47e73c4ed62d..17c6fb417231 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3888,7 +3888,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	case DEPEVT_STREAM_NOSTREAM:
 		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
 		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
-			queue_delayed_work(system_wq, &dep->nostream_work,
+			queue_delayed_work(system_percpu_wq, &dep->nostream_work,
 					   msecs_to_jiffies(100));
 		break;
 	}
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index fd7895b24367..8b3052954530 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -365,7 +365,7 @@ int dbc_ep_queue(struct dbc_request *req)
 		ret = dbc_ep_do_queue(req);
 	spin_unlock_irqrestore(&dbc->lock, flags);
 
-	mod_delayed_work(system_wq, &dbc->event_work, 0);
+	mod_delayed_work(system_percpu_wq, &dbc->event_work, 0);
 
 	trace_xhci_dbc_queue_request(req);
 
@@ -637,7 +637,7 @@ static int xhci_dbc_start(struct xhci_dbc *dbc)
 		return ret;
 	}
 
-	return mod_delayed_work(system_wq, &dbc->event_work,
+	return mod_delayed_work(system_percpu_wq, &dbc->event_work,
 				msecs_to_jiffies(dbc->poll_interval));
 }
 
@@ -964,7 +964,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 		return;
 	}
 
-	mod_delayed_work(system_wq, &dbc->event_work,
+	mod_delayed_work(system_percpu_wq, &dbc->event_work,
 			 msecs_to_jiffies(poll_interval));
 }
 
@@ -1215,7 +1215,7 @@ static ssize_t dbc_poll_interval_ms_store(struct device *dev,
 
 	dbc->poll_interval = value;
 
-	mod_delayed_work(system_wq, &dbc->event_work, 0);
+	mod_delayed_work(system_percpu_wq, &dbc->event_work, 0);
 
 	return size;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5d64c297721c..79704fbbba50 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -434,7 +434,7 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 
 static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+	return mod_delayed_work(system_percpu_wq, &xhci->cmd_timer,
 			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 41309d38f78c..114c2af0857a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -581,7 +581,7 @@ static void lateeoi_list_add(struct irq_info *info)
 					eoi_list);
 	if (!elem || info->eoi_time < elem->eoi_time) {
 		list_add(&info->eoi_list, &eoi->eoi_list);
-		mod_delayed_work_on(info->eoi_cpu, system_wq,
+		mod_delayed_work_on(info->eoi_cpu, system_percpu_wq,
 				    &eoi->delayed, delay);
 	} else {
 		list_for_each_entry_reverse(elem, &eoi->eoi_list, eoi_list) {
@@ -666,7 +666,7 @@ static void xen_irq_lateeoi_worker(struct work_struct *work)
 			break;
 
 		if (now < info->eoi_time) {
-			mod_delayed_work_on(info->eoi_cpu, system_wq,
+			mod_delayed_work_on(info->eoi_cpu, system_percpu_wq,
 					    &eoi->delayed,
 					    info->eoi_time - now);
 			break;
@@ -782,7 +782,7 @@ static void xen_free_irq(struct irq_info *info)
 
 	WARN_ON(info->refcnt > 0);
 
-	queue_rcu_work(system_wq, &info->rwork);
+	queue_rcu_work(system_percpu_wq, &info->rwork);
 }
 
 /* Not called for lateeoi events. */
-- 
2.51.0


