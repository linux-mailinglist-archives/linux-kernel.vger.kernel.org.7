Return-Path: <linux-kernel+bounces-802424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32745B45247
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7511C82A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D583306D37;
	Fri,  5 Sep 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RLPiPT6J"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CF2F744B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062702; cv=none; b=MnBo9t2VEGHbaiZyWrEz9Ztj6p7oeXtV5JpNzPgQbZKrJpNPA9WMDF084AU9Kg3h3AyzKerGCojI10ChtCXiZgRDJW/lIlw11UwRsMsrAHF+ZYkxLVPSw9q6GozOAYsiw8Ukrj4L3s34eyDiBaysoEjGMxxqdujG0OlUuxQNhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062702; c=relaxed/simple;
	bh=tF242wQiq0s2VjfBhaD6BuhbNUTYvFfKOIZhpWcLxfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JobBdCiYBtpR9u/eobWOR3oSodntYgsb+OBOkCWgY1IYSADPt5rNEs3e6sDx4tYXYLpFG49BhWm//NS22djb1EvTGWOIvz5GbSp+yXRbEiBVY6atpW6Bgdv69b0rzhEo6u4cuC1rhDGKaoc2XKuXEtfNluKEnMvV2VhJ3maY3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RLPiPT6J; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so7163345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062696; x=1757667496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qf/wKXybwj4KBwf4y1z4rbclrACQum4L0J8eR2SCtk=;
        b=RLPiPT6JzlX2QF1DlpWRdhCpC42WnA8Iv21zqTKRxsHf+8l8cwYXfVSs11aVw4uVfl
         N0ocBWDNbF/+lGMOJsY7WKXSdwUYO+HZg0nINKZQpEsYQhMC7Hij+1rJso9l/fCdv69M
         +6SJyNZP31yF6CLjKTbPu/6HBt3k7EZn4nNmGss7PvM3XaFnikjJY/FrsHmY6Btip/GW
         loy7pHwJZJKdINdfpk5V0pIxlU64e2lZornFDMrBupGnzzVK+9H9pOI/0YkFm6xGJgFR
         7AavGWz2BfA+WPIj3uSkP0v3AIRNohReGMKBlQQCK8SPBX+v0fdANvr9M4bcTjGf1/AW
         VUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062696; x=1757667496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Qf/wKXybwj4KBwf4y1z4rbclrACQum4L0J8eR2SCtk=;
        b=FUJb3CCRq9eq0muLuLo4b8tIxZw3KjDfFwDScqqsC7gIkI3KhWwZBmbPRBbAiOTI47
         6xnZC2E+l1aLdwpk7sRQ/2IFmOOiCicrW/DuEtdZkE5NlYnFlZA5TaPKMfYav/iwfFGs
         EpIizFMyDKvNZcXhFa/ySONUe1YZcNeQmXzanUsIFBMFrXDE2nthGvW/kO62iS0znxy1
         QRDXxNaFgx78stLDqPQr1qBDN1/fbxCN6ikfhgpahUslnC2F1Qov8Uy6gO7wMpynHu7+
         Xm3Vfdn1x5CXjOfpOK+X7+5+d94Eh4uauK/7DGkeaXY5wgUjZhxNSxhImQ1VKj718pHG
         aMEA==
X-Gm-Message-State: AOJu0YwhUwb1/MF7emNXZBoqb0CyE8ryc6hQSm7aRgHqLuWKYS5nE+YS
	m0eFbxRcgCdGSuF1b+pWrvpGE4kStCAQvBNVLC35uRi8BAb8wwO3BRbLuCq+mTc9dJidhXE3Qke
	rNINe
X-Gm-Gg: ASbGnctHRMFB65CQygTfuciyQXG/lpWuZym/gNxXq8mvUxJ9x40dvjl7Jcunl36HxzY
	zcfdc69v2z4g9DK8oqketDtm1xwW+A2x3zTBkueuJXB2Me16ZVWDm2O0zbLU/BORH8JnBlXI9JR
	/QFcBTrNoThQ6djs/lAdrPkz/cVqXh6JN0vT15vaysZQM1sq7TtbO7R+B4GEt1m/blrFZoPHN+z
	OIg0HVUzs3XFg+YrS324PyIQ14sh65qc7ZUVY4HEpSs7edaPILRYSSSFw1e+O1s4JmVBbJtqaqW
	6RmeySXNkGjg0PJvLAbNoO89MbZlmlwfACylm+ndMZNX10RFLap8g54Z8RMURnKLLta74XMKQrs
	nGRkjhBU/dWnKkL5MYsmciZdvT6aXMdzrvEYKAiMI8EDgISzxCrJ3UQPTFw==
X-Google-Smtp-Source: AGHT+IEGRegOu2yPFo7rH87XVO1sN+JByvnCkG0k+rirq75sl8++4jV0FHt6f6aJW9W0I/ZBaMV+hg==
X-Received: by 2002:a05:600c:4513:b0:45b:7eb4:cee4 with SMTP id 5b1f17b1804b1-45b8557b769mr158819535e9.32.1757062695754;
        Fri, 05 Sep 2025 01:58:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b81a9e971sm334698915e9.18.2025.09.05.01.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:58:15 -0700 (PDT)
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
Subject: [PATCH 1/3] drivers: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 10:57:59 +0200
Message-ID: <20250905085801.98754-2-marco.crivellari@suse.com>
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
 drivers/accel/ivpu/ivpu_pm.c                         | 2 +-
 drivers/acpi/scan.c                                  | 2 +-
 drivers/base/dd.c                                    | 2 +-
 drivers/char/random.c                                | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/aldebaran.c               | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c            | 2 +-
 drivers/gpu/drm/drm_atomic_helper.c                  | 6 +++---
 drivers/gpu/drm/i915/display/intel_display_power.c   | 2 +-
 drivers/gpu/drm/i915/display/intel_tc.c              | 4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c         | 2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c               | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c            | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c    | 6 +++---
 drivers/gpu/drm/i915/i915_active.c                   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c            | 2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c             | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp.c                 | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_irq.c             | 2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c              | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c          | 2 +-
 drivers/gpu/drm/xe/xe_devcoredump.c                  | 2 +-
 drivers/gpu/drm/xe/xe_execlist.c                     | 2 +-
 drivers/gpu/drm/xe/xe_guc_ct.c                       | 4 ++--
 drivers/gpu/drm/xe/xe_oa.c                           | 2 +-
 drivers/gpu/drm/xe/xe_vm.c                           | 4 ++--
 drivers/hte/hte.c                                    | 2 +-
 drivers/infiniband/core/ucma.c                       | 2 +-
 drivers/infiniband/hw/mlx5/odp.c                     | 4 ++--
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 8 ++++----
 drivers/scsi/qla2xxx/qla_os.c                        | 2 +-
 drivers/scsi/scsi_transport_iscsi.c                  | 2 +-
 drivers/soc/xilinx/zynqmp_power.c                    | 6 +++---
 drivers/target/sbp/sbp_target.c                      | 8 ++++----
 drivers/tty/serial/8250/8250_dw.c                    | 4 ++--
 drivers/tty/tty_buffer.c                             | 8 ++++----
 36 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index b5891e91f7ab..118e6ca9a3de 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -181,7 +181,7 @@ void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
 	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
 		ivpu_hw_diagnose_failure(vdev);
 		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
-		queue_work(system_unbound_wq, &vdev->pm->recovery_work);
+		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
 	}
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..14fbac0b65c8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2389,7 +2389,7 @@ static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 	 * initial enumeration of devices is complete, put it into the unbound
 	 * workqueue.
 	 */
-	queue_work(system_unbound_wq, &cdw->work);
+	queue_work(system_dfl_wq, &cdw->work);
 
 	return true;
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..fc778ed5552d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -192,7 +192,7 @@ void driver_deferred_probe_trigger(void)
 	 * Kick the re-probe thread.  It may already be scheduled, but it is
 	 * safe to kick it again.
 	 */
-	queue_work(system_unbound_wq, &deferred_probe_work);
+	queue_work(system_dfl_wq, &deferred_probe_work);
 }
 
 /**
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38f2fab29c56..97435cd6b819 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -259,8 +259,8 @@ static void crng_reseed(struct work_struct *work)
 	u8 key[CHACHA_KEY_SIZE];
 
 	/* Immediately schedule the next reseeding, so that it fires sooner rather than later. */
-	if (likely(system_unbound_wq))
-		queue_delayed_work(system_unbound_wq, &next_reseed, crng_reseed_interval());
+	if (likely(system_dfl_wq))
+		queue_delayed_work(system_dfl_wq, &next_reseed, crng_reseed_interval());
 
 	extract_entropy(key, sizeof(key));
 
@@ -739,8 +739,8 @@ static void __cold _credit_init_bits(size_t bits)
 
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
-		if (static_key_initialized && system_unbound_wq)
-			queue_work(system_unbound_wq, &set_ready);
+		if (static_key_initialized && system_dfl_wq)
+			queue_work(system_dfl_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM
 		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index e13fbd974141..d6acacfb6f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -164,7 +164,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-			if (!queue_work(system_unbound_wq,
+			if (!queue_work(system_dfl_wq,
 					&tmp_adev->reset_cntl->reset_work))
 				r = -EALREADY;
 		} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a30111d2c3ea..d4a2886d8c58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5762,7 +5762,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_unbound_wq,
+				if (!queue_work(system_dfl_wq,
 						&tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..1596b94b110d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -116,7 +116,7 @@ static int amdgpu_reset_xgmi_reset_on_init_perform_reset(
 	/* Mode1 reset needs to be triggered on all devices together */
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
-		if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
+		if (!queue_work(system_dfl_wq, &tmp_adev->xgmi_reset_work))
 			r = -EALREADY;
 		if (r) {
 			dev_err(tmp_adev->dev,
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5302ab324898..aa539f316bf8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2100,13 +2100,13 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 * current layout.
 	 *
 	 * NOTE: Commit work has multiple phases, first hardware commit, then
-	 * cleanup. We want them to overlap, hence need system_unbound_wq to
+	 * cleanup. We want them to overlap, hence need system_dfl_wq to
 	 * make sure work items don't artificially stall on each another.
 	 */
 
 	drm_atomic_state_get(state);
 	if (nonblock)
-		queue_work(system_unbound_wq, &state->commit_work);
+		queue_work(system_dfl_wq, &state->commit_work);
 	else
 		commit_tail(state);
 
@@ -2139,7 +2139,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
  *
  * Asynchronous workers need to have sufficient parallelism to be able to run
  * different atomic commits on different CRTCs in parallel. The simplest way to
- * achieve this is by running them on the &system_unbound_wq work queue. Note
+ * achieve this is by running them on the &system_dfl_wq work queue. Note
  * that drivers are not required to split up atomic commits and run an
  * individual commit in parallel - userspace is supposed to do that if it cares.
  * But it might be beneficial to do that for modesets, since those necessarily
diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index f7171e6932dc..ff5166037ab5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -611,7 +611,7 @@ queue_async_put_domains_work(struct i915_power_domains *power_domains,
 						     power.domains);
 	drm_WARN_ON(display->drm, power_domains->async_put_wakeref);
 	power_domains->async_put_wakeref = wakeref;
-	drm_WARN_ON(display->drm, !queue_delayed_work(system_unbound_wq,
+	drm_WARN_ON(display->drm, !queue_delayed_work(system_dfl_wq,
 						      &power_domains->async_put_work,
 						      msecs_to_jiffies(delay_ms)));
 }
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index b8d14ed8a56e..7de1006f844d 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1760,7 +1760,7 @@ bool intel_tc_port_link_reset(struct intel_digital_port *dig_port)
 	if (!intel_tc_port_link_needs_reset(dig_port))
 		return false;
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &to_tc_port(dig_port)->link_reset_work,
 			   msecs_to_jiffies(2000));
 
@@ -1842,7 +1842,7 @@ void intel_tc_port_unlock(struct intel_digital_port *dig_port)
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
index 9df80c325fc1..8dbf6c82e241 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.c
@@ -617,7 +617,7 @@ int intel_guc_crash_process_msg(struct intel_guc *guc, u32 action)
 	else
 		guc_err(guc, "Unknown crash notification: 0x%04X\n", action);
 
-	queue_work(system_unbound_wq, &guc->dead_guc_worker);
+	queue_work(system_dfl_wq, &guc->dead_guc_worker);
 
 	return 0;
 }
@@ -639,7 +639,7 @@ int intel_guc_to_host_process_recv_msg(struct intel_guc *guc,
 		guc_err(guc, "Received early exception notification!\n");
 
 	if (msg & (INTEL_GUC_RECV_MSG_CRASH_DUMP_POSTED | INTEL_GUC_RECV_MSG_EXCEPTION))
-		queue_work(system_unbound_wq, &guc->dead_guc_worker);
+		queue_work(system_dfl_wq, &guc->dead_guc_worker);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
index 0d5197c0824a..2575f380d17d 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
@@ -30,7 +30,7 @@ static void ct_dead_ct_worker_func(struct work_struct *w);
 	do { \
 		if (!(ct)->dead_ct_reported) { \
 			(ct)->dead_ct_reason |= 1 << CT_DEAD_##reason; \
-			queue_work(system_unbound_wq, &(ct)->dead_ct_worker); \
+			queue_work(system_dfl_wq, &(ct)->dead_ct_worker); \
 		} \
 	} while (0)
 #else
@@ -1240,7 +1240,7 @@ static int ct_handle_event(struct intel_guc_ct *ct, struct ct_incoming_msg *requ
 	list_add_tail(&request->link, &ct->requests.incoming);
 	spin_unlock_irqrestore(&ct->requests.lock, flags);
 
-	queue_work(system_unbound_wq, &ct->requests.worker);
+	queue_work(system_dfl_wq, &ct->requests.worker);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index f8cb7c630d5b..54d17548d4aa 100644
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
@@ -3600,7 +3600,7 @@ static void guc_context_destroy(struct kref *kref)
 	 * take the GT PM for the first time which isn't allowed from an atomic
 	 * context.
 	 */
-	queue_work(system_unbound_wq, &guc->submission_state.destroyed_worker);
+	queue_work(system_dfl_wq, &guc->submission_state.destroyed_worker);
 }
 
 static int guc_context_alloc(struct intel_context *ce)
@@ -5371,7 +5371,7 @@ int intel_guc_engine_failure_process_msg(struct intel_guc *guc,
 	 * A GT reset flushes this worker queue (G2H handler) so we must use
 	 * another worker to trigger a GT reset.
 	 */
-	queue_work(system_unbound_wq, &guc->submission_state.reset_fail_worker);
+	queue_work(system_dfl_wq, &guc->submission_state.reset_fail_worker);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 0dbc4e289300..4b7238db08c4 100644
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
index f8da693ad3ce..df854c961c6e 100644
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
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 504cb3f2054b..d179c81d8306 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2466,7 +2466,7 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 	pm_runtime_get_noresume(dev->dev);
 
 	if (nonblock)
-		queue_work(system_unbound_wq, &state->commit_work);
+		queue_work(system_dfl_wq, &state->commit_work);
 	else
 		nv50_disp_atomic_commit_tail(state);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e3596e2b557d..a13098ec5df0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1771,7 +1771,7 @@ static void vop_handle_vblank(struct vop *vop)
 	spin_unlock(&drm->event_lock);
 
 	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
-		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
+		drm_flip_work_commit(&vop->fb_unref_work, system_dfl_wq);
 }
 
 static irqreturn_t vop_isr(int irq, void *data)
diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index 81b9d9bb3f57..02ca9abd9e76 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -316,7 +316,7 @@ static void devcoredump_snapshot(struct xe_devcoredump *coredump,
 
 	xe_engine_snapshot_capture_for_queue(q);
 
-	queue_work(system_unbound_wq, &ss->work);
+	queue_work(system_dfl_wq, &ss->work);
 
 	xe_force_wake_put(gt_to_fw(q->gt), fw_ref);
 	dma_fence_end_signalling(cookie);
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index 788f56b066b6..171a5796e0fb 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -416,7 +416,7 @@ static void execlist_exec_queue_kill(struct xe_exec_queue *q)
 static void execlist_exec_queue_fini(struct xe_exec_queue *q)
 {
 	INIT_WORK(&q->execlist->fini_async, execlist_exec_queue_fini_async);
-	queue_work(system_unbound_wq, &q->execlist->fini_async);
+	queue_work(system_dfl_wq, &q->execlist->fini_async);
 }
 
 static int execlist_exec_queue_set_priority(struct xe_exec_queue *q,
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 72ad576fc18e..4e239d8195cd 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -472,7 +472,7 @@ int xe_guc_ct_enable(struct xe_guc_ct *ct)
 	spin_lock_irq(&ct->dead.lock);
 	if (ct->dead.reason) {
 		ct->dead.reason |= (1 << CT_DEAD_STATE_REARM);
-		queue_work(system_unbound_wq, &ct->dead.worker);
+		queue_work(system_dfl_wq, &ct->dead.worker);
 	}
 	spin_unlock_irq(&ct->dead.lock);
 #endif
@@ -1811,7 +1811,7 @@ static void ct_dead_capture(struct xe_guc_ct *ct, struct guc_ctb *ctb, u32 reaso
 
 	spin_unlock_irqrestore(&ct->dead.lock, flags);
 
-	queue_work(system_unbound_wq, &(ct)->dead.worker);
+	queue_work(system_dfl_wq, &(ct)->dead.worker);
 }
 
 static void ct_dead_print(struct xe_dead_ct *dead)
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 7ffc98f67e69..1878e50eb687 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -956,7 +956,7 @@ static void xe_oa_config_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 	struct xe_oa_fence *ofence = container_of(cb, typeof(*ofence), cb);
 
 	INIT_DELAYED_WORK(&ofence->work, xe_oa_fence_work_fn);
-	queue_delayed_work(system_unbound_wq, &ofence->work,
+	queue_delayed_work(system_dfl_wq, &ofence->work,
 			   usecs_to_jiffies(NOA_PROGRAM_ADDITIONAL_DELAY_US));
 	dma_fence_put(fence);
 }
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 60303998bd61..3e25b71749d4 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1289,7 +1289,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
 	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
 
 	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
-	queue_work(system_unbound_wq, &vma->destroy_work);
+	queue_work(system_dfl_wq, &vma->destroy_work);
 }
 
 static void xe_vma_destroy(struct xe_vma *vma, struct dma_fence *fence)
@@ -1973,7 +1973,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
 	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
 
 	/* To destroy the VM we need to be able to sleep */
-	queue_work(system_unbound_wq, &vm->destroy_work);
+	queue_work(system_dfl_wq, &vm->destroy_work);
 }
 
 struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 23a6eeb8c506..e2804636f2bd 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -826,7 +826,7 @@ int hte_push_ts_ns(const struct hte_chip *chip, u32 xlated_id,
 
 	ret = ei->cb(data, ei->cl_data);
 	if (ret == HTE_RUN_SECOND_CB && ei->tcb) {
-		queue_work(system_unbound_wq, &ei->cb_work);
+		queue_work(system_dfl_wq, &ei->cb_work);
 		set_bit(HTE_TS_QUEUE_WK, &ei->flags);
 	}
 
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..ccfcf8e4b712 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -361,7 +361,7 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
 		xa_lock(&ctx_table);
 		if (xa_load(&ctx_table, ctx->id) == ctx)
-			queue_work(system_unbound_wq, &ctx->close_work);
+			queue_work(system_dfl_wq, &ctx->close_work);
 		xa_unlock(&ctx_table);
 	}
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 86d8fa63bf69..24efd9a2d82b 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -253,7 +253,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
-	queue_work(system_unbound_wq, &mr->odp_destroy.work);
+	queue_work(system_dfl_wq, &mr->odp_destroy.work);
 }
 
 static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
@@ -2062,6 +2062,6 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 		destroy_prefetch_work(work);
 		return rc;
 	}
-	queue_work(system_unbound_wq, &work->work);
+	queue_work(system_dfl_wq, &work->work);
 	return 0;
 }
diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 3d2913de9a86..8c5142fc80ef 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -1735,7 +1735,7 @@ static void process_signal_change(struct snps_hdmirx_dev *hdmirx_dev)
 			   FIFO_UNDERFLOW_INT_EN |
 			   HDMIRX_AXI_ERROR_INT_EN, 0);
 	hdmirx_reset_dma(hdmirx_dev);
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_res_change,
 			   msecs_to_jiffies(50));
 }
@@ -2190,7 +2190,7 @@ static void hdmirx_delayed_work_res_change(struct work_struct *work)
 
 		if (hdmirx_wait_signal_lock(hdmirx_dev)) {
 			hdmirx_plugout(hdmirx_dev);
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(system_dfl_wq,
 					   &hdmirx_dev->delayed_work_hotplug,
 					   msecs_to_jiffies(200));
 		} else {
@@ -2209,7 +2209,7 @@ static irqreturn_t hdmirx_5v_det_irq_handler(int irq, void *dev_id)
 	val = gpiod_get_value(hdmirx_dev->detect_5v_gpio);
 	v4l2_dbg(3, debug, &hdmirx_dev->v4l2_dev, "%s: 5v:%d\n", __func__, val);
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_hotplug,
 			   msecs_to_jiffies(10));
 
@@ -2441,7 +2441,7 @@ static void hdmirx_enable_irq(struct device *dev)
 	enable_irq(hdmirx_dev->dma_irq);
 	enable_irq(hdmirx_dev->det_irq);
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_hotplug,
 			   msecs_to_jiffies(110));
 }
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b44d134e7105..87eeb8607b60 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5292,7 +5292,7 @@ void qla24xx_sched_upd_fcport(fc_port_t *fcport)
 	qla2x00_set_fcport_disc_state(fcport, DSC_UPD_FCPORT);
 	spin_unlock_irqrestore(&fcport->vha->work_lock, flags);
 
-	queue_work(system_unbound_wq, &fcport->reg_work);
+	queue_work(system_dfl_wq, &fcport->reg_work);
 }
 
 static
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 9c347c64c315..e2754c1cb0a5 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3957,7 +3957,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			list_del_init(&session->sess_list);
 			spin_unlock_irqrestore(&sesslock, flags);
 
-			queue_work(system_unbound_wq, &session->destroy_work);
+			queue_work(system_dfl_wq, &session->destroy_work);
 		}
 		break;
 	case ISCSI_UEVENT_UNBIND_SESSION:
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index ae59bf16659a..6145c4fe192e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -82,7 +82,7 @@ static void subsystem_restart_event_callback(const u32 *payload, void *data)
 	memcpy(zynqmp_pm_init_restart_work->args, &payload[0],
 	       sizeof(zynqmp_pm_init_restart_work->args));
 
-	queue_work(system_unbound_wq, &zynqmp_pm_init_restart_work->callback_work);
+	queue_work(system_dfl_wq, &zynqmp_pm_init_restart_work->callback_work);
 }
 
 static void suspend_event_callback(const u32 *payload, void *data)
@@ -95,7 +95,7 @@ static void suspend_event_callback(const u32 *payload, void *data)
 	memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
 	       sizeof(zynqmp_pm_init_suspend_work->args));
 
-	queue_work(system_unbound_wq, &zynqmp_pm_init_suspend_work->callback_work);
+	queue_work(system_dfl_wq, &zynqmp_pm_init_suspend_work->callback_work);
 }
 
 static irqreturn_t zynqmp_pm_isr(int irq, void *data)
@@ -140,7 +140,7 @@ static void ipi_receive_callback(struct mbox_client *cl, void *data)
 		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
 		       sizeof(zynqmp_pm_init_suspend_work->args));
 
-		queue_work(system_unbound_wq,
+		queue_work(system_dfl_wq,
 			   &zynqmp_pm_init_suspend_work->callback_work);
 
 		/* Send NULL message to mbox controller to ack the message */
diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index 3b89b5a70331..b8457477cee9 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -730,7 +730,7 @@ static int tgt_agent_rw_orb_pointer(struct fw_card *card, int tcode, void *data,
 		pr_debug("tgt_agent ORB_POINTER write: 0x%llx\n",
 				agent->orb_pointer);
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 
 		return RCODE_COMPLETE;
 
@@ -764,7 +764,7 @@ static int tgt_agent_rw_doorbell(struct fw_card *card, int tcode, void *data,
 
 		pr_debug("tgt_agent DOORBELL\n");
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 
 		return RCODE_COMPLETE;
 
@@ -990,7 +990,7 @@ static void tgt_agent_fetch_work(struct work_struct *work)
 
 		if (tgt_agent_check_active(agent) && !doorbell) {
 			INIT_WORK(&req->work, tgt_agent_process_work);
-			queue_work(system_unbound_wq, &req->work);
+			queue_work(system_dfl_wq, &req->work);
 		} else {
 			/* don't process this request, just check next_ORB */
 			sbp_free_request(req);
@@ -1618,7 +1618,7 @@ static void sbp_mgt_agent_rw(struct fw_card *card,
 		agent->orb_offset = sbp2_pointer_to_addr(ptr);
 		agent->request = req;
 
-		queue_work(system_unbound_wq, &agent->work);
+		queue_work(system_dfl_wq, &agent->work);
 		rcode = RCODE_COMPLETE;
 	} else if (tcode == TCODE_READ_BLOCK_REQUEST) {
 		addr_to_sbp2_pointer(agent->orb_offset, ptr);
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1..50a5ee546373 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -361,7 +361,7 @@ static int dw8250_clk_notifier_cb(struct notifier_block *nb,
 	 * deferred event handling complication.
 	 */
 	if (event == POST_RATE_CHANGE) {
-		queue_work(system_unbound_wq, &d->clk_work);
+		queue_work(system_dfl_wq, &d->clk_work);
 		return NOTIFY_OK;
 	}
 
@@ -678,7 +678,7 @@ static int dw8250_probe(struct platform_device *pdev)
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
 		if (err)
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
-		queue_work(system_unbound_wq, &data->clk_work);
+		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00..60066ece9d96 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -76,7 +76,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 	mutex_unlock(&buf->lock);
 
 	if (restart)
-		queue_work(system_unbound_wq, &buf->work);
+		queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
@@ -531,7 +531,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -561,7 +561,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 		tty_flip_buffer_commit(buf->tail);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(system_dfl_wq, &buf->work);
 
 	return size;
 }
@@ -614,7 +614,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
 
 bool tty_buffer_restart_work(struct tty_port *port)
 {
-	return queue_work(system_unbound_wq, &port->buf.work);
+	return queue_work(system_dfl_wq, &port->buf.work);
 }
 
 bool tty_buffer_cancel_work(struct tty_port *port)
-- 
2.51.0


