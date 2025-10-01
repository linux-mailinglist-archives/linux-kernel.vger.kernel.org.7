Return-Path: <linux-kernel+bounces-838349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD9BAF017
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EDD4A42E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC42853EA;
	Wed,  1 Oct 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IlskAVcr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160A271443
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285329; cv=pass; b=O3taIh6GGDDyLaAQ92i0GPv4rVWHjcQx50oUdf+Z/Cte3+DyOO6RkGBXUy2ksl8IfBxFpxSD3O+IzjWtMKHcuBydz4q5fxOUX121zf9+vYFNGrqmSAUGu75l7UAAW+3zder0b2Fn7zNnXeZ1XuQ64ckulH92KK/G3A6MPRT8DFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285329; c=relaxed/simple;
	bh=gCiYHlbzN9EWcOtEF0N8Tm6uhJJne6xVDQKBt9unkaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPJM6GxRkWIxCaDp31JVwXcsBoaMRV4dliSNmy4MrasH4lDSPw3GRJ8/mbwaQdp7prZu9K4D03nUOiRnNWciF82QMzXRqO1MsAWKBPWjZugr3dg0a6YcbKnBrG2fTPOu0rjOzbaiypwLEkB6LomZOvZaC/Rmmbbfqmdj0uIiiW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=IlskAVcr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759285308; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lK4Epm440iM6S4A5w8MkYMU5flGTmTvZSyAfT+1C0u7ecHixZFB3JiDddm/TJ0PLVKTV9yomdf1y0V/PJyQ/yH5r8WJuuII8bGvCkM5cDBYLh9fASCirE5/enuIGAL/8iGemBXNf2whNMDo8YowHqsOqjNvnCO8dTMiJDYiNOro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759285308; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dupe+a/UM0jyDfupWTC8UTl6kGSeYSAeQTmvbruSlWE=; 
	b=QKyI1KWufmvATc0U1Tpom2e0/JTZAToN/WHxyunNgToLKukDQovV6XfskM/+wTcx4JaWKt1HSGgokcacZAHwVc0IYIXPusmG1OQJPs6Idf3Bx27zRPB/CCZnLD44NX8DcxVTqkRCoTeR0v2CEJihtSAPQIXBhqwzqcIiYC3fGNM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759285308;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Dupe+a/UM0jyDfupWTC8UTl6kGSeYSAeQTmvbruSlWE=;
	b=IlskAVcrUV5LZsdKsuX+2AVMz61If+Xo3feADSFPuqFRafjbcmDdwo6Wi7ZvXJIv
	rNpo0AkW0mfTqEZSN3mYqNk4IufeX743XwnHgA2wb3iIgEWhTp7+ZbsomYcjQgXr3Ap
	G96Id023Xij5uLO7v8isNerSWzPbKBqCRn14EUNo=
Received: by mx.zohomail.com with SMTPS id 1759285307468795.2467657665908;
	Tue, 30 Sep 2025 19:21:47 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 10/10] drm/panfrost: Rename panfrost_job functions to reflect real role
Date: Wed,  1 Oct 2025 03:20:31 +0100
Message-ID: <20251001022039.1215976-11-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
References: <20251001022039.1215976-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

panfrost_job_* prefixed functions in panfrost_job.c deal with both
panfrost_job objects and also the more general JM (Job Manager) side of
the device itself. This is confusing.

Reprefix functions that program the JM to panfrosot_jm_* instead.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++----
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  4 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 48 +++++++++++-----------
 drivers/gpu/drm/panfrost/panfrost_job.h    | 16 ++++----
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index f1d811a6de6c..c61b97af120c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -259,7 +259,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	if (err)
 		goto out_gpu;
 
-	err = panfrost_job_init(pfdev);
+	err = panfrost_jm_init(pfdev);
 	if (err)
 		goto out_mmu;
 
@@ -269,7 +269,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 	return 0;
 out_job:
-	panfrost_job_fini(pfdev);
+	panfrost_jm_fini(pfdev);
 out_mmu:
 	panfrost_mmu_fini(pfdev);
 out_gpu:
@@ -290,7 +290,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
 	panfrost_perfcnt_fini(pfdev);
-	panfrost_job_fini(pfdev);
+	panfrost_jm_fini(pfdev);
 	panfrost_mmu_fini(pfdev);
 	panfrost_gpu_fini(pfdev);
 	panfrost_devfreq_fini(pfdev);
@@ -407,9 +407,9 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
 
-	panfrost_job_reset_interrupts(pfdev);
+	panfrost_jm_reset_interrupts(pfdev);
 	if (enable_job_int)
-		panfrost_job_enable_interrupts(pfdev);
+		panfrost_jm_enable_interrupts(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
@@ -451,11 +451,11 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_job_is_idle(pfdev))
+	if (!panfrost_jm_is_idle(pfdev))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);
-	panfrost_job_suspend_irq(pfdev);
+	panfrost_jm_suspend_irq(pfdev);
 	panfrost_mmu_suspend_irq(pfdev);
 	panfrost_gpu_suspend_irq(pfdev);
 	panfrost_gpu_power_off(pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 2b57f6813714..3b79ebbccdf5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -606,7 +606,7 @@ panfrost_open(struct drm_device *dev, struct drm_file *file)
 		goto err_free;
 	}
 
-	ret = panfrost_job_open(file);
+	ret = panfrost_jm_open(file);
 	if (ret)
 		goto err_job;
 
@@ -625,7 +625,7 @@ panfrost_postclose(struct drm_device *dev, struct drm_file *file)
 	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
 
 	panfrost_perfcnt_close(file);
-	panfrost_job_close(file);
+	panfrost_jm_close(file);
 
 	panfrost_mmu_ctx_put(panfrost_priv->mmu);
 	kfree(panfrost_priv);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 3ae984f6290f..4a213db9962d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -426,18 +426,18 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
-void panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
+void panfrost_jm_reset_interrupts(struct panfrost_device *pfdev)
 {
 	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
 }
 
-void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
+void panfrost_jm_enable_interrupts(struct panfrost_device *pfdev)
 {
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
 	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
-void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
+void panfrost_jm_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
 
@@ -499,8 +499,8 @@ static void panfrost_job_handle_err(struct panfrost_device *pfdev,
 	}
 }
 
-static void panfrost_job_handle_done(struct panfrost_device *pfdev,
-				     struct panfrost_job *job)
+static void panfrost_jm_handle_done(struct panfrost_device *pfdev,
+				    struct panfrost_job *job)
 {
 	/* Set ->jc to 0 to avoid re-submitting an already finished job (can
 	 * happen when we receive the DONE interrupt while doing a GPU reset).
@@ -513,7 +513,7 @@ static void panfrost_job_handle_done(struct panfrost_device *pfdev,
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
-static void panfrost_job_handle_irq(struct panfrost_device *pfdev, u32 status)
+static void panfrost_jm_handle_irq(struct panfrost_device *pfdev, u32 status)
 {
 	struct panfrost_job *done[NUM_JOB_SLOTS][2] = {};
 	struct panfrost_job *failed[NUM_JOB_SLOTS] = {};
@@ -588,7 +588,7 @@ static void panfrost_job_handle_irq(struct panfrost_device *pfdev, u32 status)
 		}
 
 		for (i = 0; i < ARRAY_SIZE(done[0]) && done[j][i]; i++)
-			panfrost_job_handle_done(pfdev, done[j][i]);
+			panfrost_jm_handle_done(pfdev, done[j][i]);
 	}
 
 	/* And finally we requeue jobs that were waiting in the second slot
@@ -606,7 +606,7 @@ static void panfrost_job_handle_irq(struct panfrost_device *pfdev, u32 status)
 			struct panfrost_job *canceled = panfrost_dequeue_job(pfdev, j);
 
 			dma_fence_set_error(canceled->done_fence, -ECANCELED);
-			panfrost_job_handle_done(pfdev, canceled);
+			panfrost_jm_handle_done(pfdev, canceled);
 		} else if (!atomic_read(&pfdev->reset.pending)) {
 			/* Requeue the job we removed if no reset is pending */
 			job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_START);
@@ -614,7 +614,7 @@ static void panfrost_job_handle_irq(struct panfrost_device *pfdev, u32 status)
 	}
 }
 
-static void panfrost_job_handle_irqs(struct panfrost_device *pfdev)
+static void panfrost_jm_handle_irqs(struct panfrost_device *pfdev)
 {
 	u32 status = job_read(pfdev, JOB_INT_RAWSTAT);
 
@@ -622,7 +622,7 @@ static void panfrost_job_handle_irqs(struct panfrost_device *pfdev)
 		pm_runtime_mark_last_busy(pfdev->base.dev);
 
 		spin_lock(&pfdev->js->job_lock);
-		panfrost_job_handle_irq(pfdev, status);
+		panfrost_jm_handle_irq(pfdev, status);
 		spin_unlock(&pfdev->js->job_lock);
 		status = job_read(pfdev, JOB_INT_RAWSTAT);
 	}
@@ -703,7 +703,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		dev_err(pfdev->base.dev, "Soft-stop failed\n");
 
 	/* Handle the remaining interrupts before we reset. */
-	panfrost_job_handle_irqs(pfdev);
+	panfrost_jm_handle_irqs(pfdev);
 
 	/* Remaining interrupts have been handled, but we might still have
 	 * stuck jobs. Let's make sure the PM counters stay balanced by
@@ -748,7 +748,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	panfrost_job_enable_interrupts(pfdev);
+	panfrost_jm_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -813,11 +813,11 @@ static const struct drm_sched_backend_ops panfrost_sched_ops = {
 	.free_job = panfrost_job_free
 };
 
-static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
+static irqreturn_t panfrost_jm_irq_handler_thread(int irq, void *data)
 {
 	struct panfrost_device *pfdev = data;
 
-	panfrost_job_handle_irqs(pfdev);
+	panfrost_jm_handle_irqs(pfdev);
 
 	/* Enable interrupts only if we're not about to get suspended */
 	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
@@ -826,7 +826,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
+static irqreturn_t panfrost_jm_irq_handler(int irq, void *data)
 {
 	struct panfrost_device *pfdev = data;
 	u32 status;
@@ -842,7 +842,7 @@ static irqreturn_t panfrost_job_irq_handler(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-int panfrost_job_init(struct panfrost_device *pfdev)
+int panfrost_jm_init(struct panfrost_device *pfdev)
 {
 	struct drm_sched_init_args args = {
 		.ops = &panfrost_sched_ops,
@@ -875,8 +875,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		return js->irq;
 
 	ret = devm_request_threaded_irq(pfdev->base.dev, js->irq,
-					panfrost_job_irq_handler,
-					panfrost_job_irq_handler_thread,
+					panfrost_jm_irq_handler,
+					panfrost_jm_irq_handler_thread,
 					IRQF_SHARED, KBUILD_MODNAME "-job",
 					pfdev);
 	if (ret) {
@@ -899,8 +899,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		}
 	}
 
-	panfrost_job_reset_interrupts(pfdev);
-	panfrost_job_enable_interrupts(pfdev);
+	panfrost_jm_reset_interrupts(pfdev);
+	panfrost_jm_enable_interrupts(pfdev);
 
 	return 0;
 
@@ -912,7 +912,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 	return ret;
 }
 
-void panfrost_job_fini(struct panfrost_device *pfdev)
+void panfrost_jm_fini(struct panfrost_device *pfdev)
 {
 	struct panfrost_job_slot *js = pfdev->js;
 	int j;
@@ -927,7 +927,7 @@ void panfrost_job_fini(struct panfrost_device *pfdev)
 	destroy_workqueue(pfdev->reset.wq);
 }
 
-int panfrost_job_open(struct drm_file *file)
+int panfrost_jm_open(struct drm_file *file)
 {
 	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
 	int ret;
@@ -949,7 +949,7 @@ int panfrost_job_open(struct drm_file *file)
 	return 0;
 }
 
-void panfrost_job_close(struct drm_file *file)
+void panfrost_jm_close(struct drm_file *file)
 {
 	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
 	struct panfrost_jm_ctx *jm_ctx;
@@ -961,7 +961,7 @@ void panfrost_job_close(struct drm_file *file)
 	xa_destroy(&panfrost_priv->jm_ctxs);
 }
 
-int panfrost_job_is_idle(struct panfrost_device *pfdev)
+int panfrost_jm_is_idle(struct panfrost_device *pfdev)
 {
 	struct panfrost_job_slot *js = pfdev->js;
 	int i;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 30eda74e3c34..da96c674d62b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -60,16 +60,16 @@ void panfrost_jm_ctx_put(struct panfrost_jm_ctx *jm_ctx);
 struct panfrost_jm_ctx *panfrost_jm_ctx_get(struct panfrost_jm_ctx *jm_ctx);
 struct panfrost_jm_ctx *panfrost_jm_ctx_from_handle(struct drm_file *file, u32 handle);
 
-int panfrost_job_init(struct panfrost_device *pfdev);
-void panfrost_job_fini(struct panfrost_device *pfdev);
-int panfrost_job_open(struct drm_file *file);
-void panfrost_job_close(struct drm_file *file);
+int panfrost_jm_init(struct panfrost_device *pfdev);
+void panfrost_jm_fini(struct panfrost_device *pfdev);
+int panfrost_jm_open(struct drm_file *file);
+void panfrost_jm_close(struct drm_file *file);
+void panfrost_jm_reset_interrupts(struct panfrost_device *pfdev);
+void panfrost_jm_enable_interrupts(struct panfrost_device *pfdev);
+void panfrost_jm_suspend_irq(struct panfrost_device *pfdev);
+int panfrost_jm_is_idle(struct panfrost_device *pfdev);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
-void panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
-void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
-void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
-int panfrost_job_is_idle(struct panfrost_device *pfdev);
 
 #endif
-- 
2.51.0


