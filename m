Return-Path: <linux-kernel+bounces-859754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20236BEE7D9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60B944E9D37
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD082EB87A;
	Sun, 19 Oct 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JudBQZpP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD82EC0B5
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885611; cv=pass; b=dHWkUpJIFPMjjQx4WnmN2wRc80gYUTxGTdAHvlsnfSMVsdBCf5S90LKUdPJwQGVRN4/H6ivahPUjbQzXKx3J7gWuLUx90K+sN1EpPpOg2w5ub7G/9GbYnBNgVz7XqOijlrWxZeZHAsAv6rqQN2thDN0ofy5ylwm9zCzKIJ/RpHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885611; c=relaxed/simple;
	bh=iwSS9+KiGlBZgzjDKAHCIVjr8h+3zG6SPRW+ofArsSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSJYAMFwndf/kGaNPdoN2XVBXsb2tO+oEy2DuHaAGpXtDeUvls5CuNUuOS821CNVm3cAT8BnQXnyn4WzQb+RhYc+W6xgvIhZdFkeepIhdznTUCE8VlHmVF1atPwtYD8wz72gm3Hs8TbnU1HaS54QU40cJUnou4S3natN6HLv3js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=JudBQZpP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885590; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DEeOx2A8ti80/7m6C6Vk2vVteB4ljrQpa7Vnafcb+x7n2ecOEInV8dIMTcGEcUGqKNNIoCp7d3czto8t1vpf7EWuXb0kkJEwExcXFTK8EJblIXJpwsXhuTuvHiopPPQg48MkfeT7cXEZ+H6B7mXtjR9DHFU2YbUb8IaFWXGU2tI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885590; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=86De62sl/h2zB7jtg5Hk1mZCwtgtymgvUibwbMh8TXQ=; 
	b=RiyiudxomJVSPm/YzCBDQOBa+Pkoc3lYroE7aXiDmpy5NKtSxAhfK4fj3JMWC+qyKMcj0sno3zkCkbGkt3exNvDewU9gO2SdbqJLP37hnOJvnx+GZxD5i1bQdoXaWbyVB7Fk7rZKVlJjtHF/5Dp4jQCxO0L8MLZAgBAgrAzTaK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885590;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=86De62sl/h2zB7jtg5Hk1mZCwtgtymgvUibwbMh8TXQ=;
	b=JudBQZpPWBsR84ZNGRktpsZt49Nbp7UGa7FurvcMLLaawLtk4qpZZ+YBJtiiULn0
	tw7h9/V1etQTMLBLuVXPl5VVXyRyieQqAMyA/sHJuLEEVG7pRyOX9olp45+3TiYSoLz
	T70wgaqoy8ImQ/cpx9EDrpm9G1RsiuRRSRZDQkDY=
Received: by mx.zohomail.com with SMTPS id 1760885588745194.38070213945207;
	Sun, 19 Oct 2025 07:53:08 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 08/12] drm/panfrost: Make re-enabling job interrupts at device reset optional
Date: Sun, 19 Oct 2025 15:52:13 +0100
Message-ID: <20251019145225.3621989-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
References: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rather than remasking interrupts after a device reset in the main reset
path, allow selecting whether to do this with an additional bool parameter.

To this end, split reenabling job interrupts into two functions, one that
clears the interrupts and another one which unmasks them conditionally.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 17 ++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 733b728ec75f..f1d811a6de6c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -400,13 +400,16 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 	return false;
 }
 
-void panfrost_device_reset(struct panfrost_device *pfdev)
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-	panfrost_job_enable_interrupts(pfdev);
+
+	panfrost_job_reset_interrupts(pfdev);
+	if (enable_job_int)
+		panfrost_job_enable_interrupts(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
@@ -430,7 +433,7 @@ static int panfrost_device_runtime_resume(struct device *dev)
 		}
 	}
 
-	panfrost_device_reset(pfdev);
+	panfrost_device_reset(pfdev, true);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index ac7147ed806b..45d77cda8b89 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -250,7 +250,7 @@ int panfrost_unstable_ioctl_check(void);
 
 int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
-void panfrost_device_reset(struct panfrost_device *pfdev);
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
 extern const struct dev_pm_ops panfrost_pm_ops;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dc4228af78f9..39e919420aaf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -430,11 +430,14 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
+{
+	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
+}
+
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 {
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
-
-	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
 	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
@@ -727,12 +730,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev);
-
-	/* panfrost_device_reset() unmasks job interrupts, but we want to
-	 * keep them masked a bit longer.
-	 */
-	job_write(pfdev, JOB_INT_MASK, 0);
+	panfrost_device_reset(pfdev, false);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -754,7 +752,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
+	panfrost_job_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -907,6 +905,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		}
 	}
 
+	panfrost_job_reset_interrupts(pfdev);
 	panfrost_job_enable_interrupts(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 458666bf684b..f6d9960740ae 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -69,6 +69,7 @@ void panfrost_job_close(struct drm_file *file);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
 int panfrost_job_is_idle(struct panfrost_device *pfdev);
-- 
2.51.0


