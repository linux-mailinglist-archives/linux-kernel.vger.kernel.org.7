Return-Path: <linux-kernel+bounces-643384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB8AB2C05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E323B8D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431D264637;
	Sun, 11 May 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SNXSAAyp"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D12609D0
	for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747003706; cv=none; b=pcKvt09PYnuTFJ599f0JRsXc+YrmOx9Z8aLinHwAfW8eKQllTT6ME+6awWmklsm/6z9Ha1oNrf6LodpoLPIZg6gQRqIlBvNSHRCSojj5FhD5Pw8L1FkhtYHeqdJ2V2g6zejjhmRUsUW1WAeIy8h4jbjs8IBY2k2+xCa3KnMyPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747003706; c=relaxed/simple;
	bh=l2aKKheoNM2VedBuod528xfQApBl1SGB7BUiSrSlThM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TesflXIOQZTVEFS3afCgs2bsTIbHHV3uQAO/dmuwo6bvfrapuhJid5ZcH8bi9HEK6pLh712FUjuNAj0F7xabSrfmQM1uZ0CjdmzruS60h12FXoHOVx1CX7Awv8GhHY0eO9+NPFiw+UghJjRf4moM4+sU+7MpjVdh4T7LSr7Al+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SNXSAAyp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fYpjyOd2Yg0wDHzHvbeC5gHS5mcr9oma4AeYk2fvvk4=; b=SNXSAAypcRox5VcXFEfNh8Vt3u
	3BnSc4fI441fIniVMtp7T64NYRxvoIVTL9IcRY74H6uoRDJDEHvGHxxlxdHVXOkCyt/M9aKzLaG0j
	ErV+Uxf03vJFKblKt4FPCHu9MYHBbyFn7KTskk2fDKOz91atkhtH+5BfykKxlBQvDrdjW8a8sxieP
	wx/+ix3R0ofStJUgrh9AJHc1e2caTqUJDfDlTo+txa68RrJIiMABxA1Ar/X4V86DnIGR2PMhbyZvH
	sbhNKUPez9y4l/1sPQZuXdY/3Z9Nazsb81+I/EZ7T2kiaOPtByGypMQ5v2WGcowMYNinbY4GGl5gY
	Lnf1ZVaw==;
Received: from [191.204.192.64] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uEFNf-006nqn-Sa; Mon, 12 May 2025 00:48:00 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: "Alex Deucher" <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	siqueira@igalia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	"Raag Jadav" <raag.jadav@intel.com>,
	rodrigo.vivi@intel.com,
	jani.nikula@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 1/3] drm: Create an app info option for wedge events
Date: Sun, 11 May 2025 19:47:43 -0300
Message-ID: <20250511224745.834446-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511224745.834446-1-andrealmeid@igalia.com>
References: <20250511224745.834446-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a device get wedged, it might be caused by a guilty application.
For userspace, knowing which app was the cause can be useful for some
situations, like for implementing a policy, logs or for giving a chance
for the compositor to let the user know what app caused the problem.
This is an optional argument, when `PID=-1` there's no information about
the app caused the problem, or if any app was involved during the hang.

Sometimes just the PID isn't enough giving that the app might be already
dead by the time userspace will try to check what was this PID's name,
so to make the life easier also notify what's the app's name in the user
event.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
 drivers/gpu/drm/drm_drv.c                  | 16 +++++++++++++---
 drivers/gpu/drm/i915/gt/intel_reset.c      |  3 ++-
 drivers/gpu/drm/xe/xe_device.c             |  3 ++-
 include/drm/drm_device.h                   |  8 ++++++++
 include/drm/drm_drv.h                      |  3 ++-
 7 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc..c8a51418d0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6216,7 +6216,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	atomic_set(&adev->reset_domain->reset_res, r);
 
 	if (!r)
-		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce..a47b2eb301e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -166,7 +166,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
 			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3dc7acd56b1d..1816ef4251e7 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -542,6 +542,7 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
  * drm_dev_wedged_event - generate a device wedged uevent
  * @dev: DRM device
  * @method: method(s) to be used for recovery
+ * @info: optional information about the guilty app
  *
  * This generates a device wedged uevent for the DRM device specified by @dev.
  * Recovery @method\(s) of choice will be sent in the uevent environment as
@@ -554,13 +555,14 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
  *
  * Returns: 0 on success, negative error code otherwise.
  */
-int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
+int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
+			 struct drm_wedge_app_info *info)
 {
 	const char *recovery = NULL;
 	unsigned int len, opt;
 	/* Event string length up to 28+ characters with available methods */
-	char event_string[32];
-	char *envp[] = { event_string, NULL };
+	char event_string[32], pid_string[15], comm_string[TASK_COMM_LEN];
+	char *envp[] = { event_string, pid_string, comm_string, NULL };
 
 	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
 
@@ -582,6 +584,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
 	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
 		 "but recovered through reset" : "needs recovery");
 
+	if (info) {
+		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
+		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
+	} else {
+		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
+		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
+	}
+
 	return kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
 }
 EXPORT_SYMBOL(drm_dev_wedged_event);
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index dbdcfe130ad4..ba1d8fdc3c7b 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -1448,7 +1448,8 @@ static void intel_gt_reset_global(struct intel_gt *gt,
 		kobject_uevent_env(kobj, KOBJ_CHANGE, reset_done_event);
 	else
 		drm_dev_wedged_event(&gt->i915->drm,
-				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET,
+				     NULL);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index c02c4c4e9412..f329613e061f 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1168,7 +1168,8 @@ void xe_device_declare_wedged(struct xe_device *xe)
 
 		/* Notify userspace of wedged device */
 		drm_dev_wedged_event(&xe->drm,
-				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET,
+				     NULL);
 	}
 
 	for_each_gt(gt, xe, id)
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index e2f894f1b90a..b87401d5079e 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -30,6 +30,14 @@ struct pci_controller;
 #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
 #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
 
+/**
+ * struct drm_wedge_app_info - information about the guilty app of a wedge dev
+ */
+struct drm_wedge_app_info {
+	pid_t pid;
+	char *comm;
+};
+
 /**
  * enum switch_power_state - power state of drm device
  */
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index a43d707b5f36..8fc6412a6345 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -482,7 +482,8 @@ void drm_put_dev(struct drm_device *dev);
 bool drm_dev_enter(struct drm_device *dev, int *idx);
 void drm_dev_exit(int idx);
 void drm_dev_unplug(struct drm_device *dev);
-int drm_dev_wedged_event(struct drm_device *dev, unsigned long method);
+int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
+			 struct drm_wedge_app_info *info);
 
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
-- 
2.49.0


