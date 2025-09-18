Return-Path: <linux-kernel+bounces-821536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E60B81937
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229FA4A6F49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0E3002C3;
	Wed, 17 Sep 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YtAkpsHF"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8427978C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136779; cv=pass; b=jjrLst4rBXLugUfNQBMsYqOTNerHtCVr5UG7fxlRrJYLQjj3iPWM0639TyXAbKqAq5+y/0THohrObxIhjX+6v/aphciilB4eQQrc+ThwWhA9yz+LWl+oHPYD0WCqoXGtccq2bpeH73TFSR9nHJI9QfrFBxSk2tq2penQxSfW7gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136779; c=relaxed/simple;
	bh=Nv+T2Esl1pxYpBB2Gb7+IChJ9tkzdyU81a5E2yDt6Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU/PvssmrhntvtzNuv/9iiaYsXEfYMhVGik5v3yBl2PjEhdqYuu5JFwSz+uh9n/7xk+Npz41DB/0fZylMh6NsIF+IwiQLTvUxkzbDsPEAV8o1kUgL6QuaZlwX4OdxK+6A4GaCDnxQxElvHPBYZgkvJJ4cGjgwix2GyMcZAo9yR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=YtAkpsHF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758136760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LcvquBw0uFy4cebjAD3IzK9k/YD9xPCb25P+J4ElVaaOF6r6v1Cv4uhiR14gCW8p4dV8f9TqLB0rBuxZ0EJyXTKsxJmpx2/moFQFVoA/0q2kpeTnTxGffu0ootBUPh9gN+6wHyfbNfiTvjrRTBZeTGb8IVl9E9fA3b+imrJDf2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758136760; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LEO1j1wZVL4S0A4tDWMknNCfE30zV0Rfp+/DjLUgLhg=; 
	b=BhdwmnM5orIRR4K5AiAIkKl9kPFT58rZtks2NOqnXJUXwINGhDWI78rZ2ZuPH9ElCxNW9Zhzb8t3nko4pEgn215SdYKwzqIQKP9tNx7fgMp8dfCWU8kQe/QFXH/V2VR5oKlEfn4z4vYXOTxV69nD3y0l6sglbaFCjX6VqtSlRqE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758136760;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LEO1j1wZVL4S0A4tDWMknNCfE30zV0Rfp+/DjLUgLhg=;
	b=YtAkpsHFY4yCn23CeRksN5gVD3RXEin7L+MqYVwXErz/uLSC9YGpRWq+cCv9bZDI
	zL/EjvOG8SJOPr5l/X16COMvWDVgv0emKV40dikH1l0pSnSwUJ/WOWEloYoZ3naGGzu
	v09tu4hy8/TlDjR5fJM+HcPDlh/sqTrLRKJk3HBE=
Received: by mx.zohomail.com with SMTPS id 1758136759246594.2119539264078;
	Wed, 17 Sep 2025 12:19:19 -0700 (PDT)
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
Subject: [PATCH v4 2/4] drm/panfrost: Introduce JM contexts for manging job resources
Date: Wed, 17 Sep 2025 20:18:38 +0100
Message-ID: <20250917191859.500279-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917191859.500279-1-adrian.larumbe@collabora.com>
References: <20250917191859.500279-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

A JM context describes user-requested priorities for the JM queues.

Context creation leads to the initialization of scheduling entities of
the same priority for all the device's job slots.

Until context creation and destruction are exposed to UM, all issued
jobs shall be bound to the default Panfrost file context, which has
medium priority.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  11 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c    |  24 ++-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 195 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
 4 files changed, 215 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 077525a3ad68..1e73efad02a8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -10,11 +10,13 @@
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
+#include <drm/drm_auth.h>
 #include <drm/drm_device.h>
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
 
 #include "panfrost_devfreq.h"
+#include "panfrost_job.h"
 
 struct panfrost_device;
 struct panfrost_mmu;
@@ -22,7 +24,6 @@ struct panfrost_job_slot;
 struct panfrost_job;
 struct panfrost_perfcnt;
 
-#define NUM_JOB_SLOTS 3
 #define MAX_PM_DOMAINS 5
 
 enum panfrost_drv_comp_bits {
@@ -206,13 +207,19 @@ struct panfrost_engine_usage {
 struct panfrost_file_priv {
 	struct panfrost_device *pfdev;
 
-	struct drm_sched_entity sched_entity[NUM_JOB_SLOTS];
+	struct xarray jm_ctxs;
 
 	struct panfrost_mmu *mmu;
 
 	struct panfrost_engine_usage engine_usage;
 };
 
+static inline bool panfrost_high_prio_allowed(struct drm_file *file)
+{
+	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
+	return (capable(CAP_SYS_NICE) || drm_is_current_master(file));
+}
+
 static inline struct panfrost_device *to_panfrost_device(struct drm_device *ddev)
 {
 	return ddev->dev_private;
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 1ea6c509a5d5..be384b18e8fd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -279,9 +279,16 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	struct panfrost_file_priv *file_priv = file->driver_priv;
 	struct drm_panfrost_submit *args = data;
 	struct drm_syncobj *sync_out = NULL;
+	struct panfrost_jm_ctx *jm_ctx;
 	struct panfrost_job *job;
 	int ret = 0, slot;
 
+	if (args->pad)
+		return -EINVAL;
+
+	if (args->jm_ctx_handle)
+		return -EINVAL;
+
 	if (!args->jc)
 		return -EINVAL;
 
@@ -294,10 +301,16 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 			return -ENODEV;
 	}
 
+	jm_ctx = panfrost_jm_ctx_from_handle(file, args->jm_ctx_handle);
+	if (!jm_ctx) {
+		ret = -EINVAL;
+		goto out_put_syncout;
+	}
+
 	job = kzalloc(sizeof(*job), GFP_KERNEL);
 	if (!job) {
 		ret = -ENOMEM;
-		goto out_put_syncout;
+		goto out_put_jm_ctx;
 	}
 
 	kref_init(&job->refcount);
@@ -307,12 +320,13 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 	job->requirements = args->requirements;
 	job->flush_id = panfrost_gpu_get_latest_flush_id(pfdev);
 	job->mmu = file_priv->mmu;
+	job->ctx = panfrost_jm_ctx_get(jm_ctx);
 	job->engine_usage = &file_priv->engine_usage;
 
 	slot = panfrost_job_get_slot(job);
 
 	ret = drm_sched_job_init(&job->base,
-				 &file_priv->sched_entity[slot],
+				 &jm_ctx->slot_entity[slot],
 				 1, NULL, file->client_id);
 	if (ret)
 		goto out_put_job;
@@ -338,6 +352,8 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
 		drm_sched_job_cleanup(&job->base);
 out_put_job:
 	panfrost_job_put(job);
+out_put_jm_ctx:
+	panfrost_jm_ctx_put(jm_ctx);
 out_put_syncout:
 	if (sync_out)
 		drm_syncobj_put(sync_out);
@@ -564,7 +580,7 @@ panfrost_open(struct drm_device *dev, struct drm_file *file)
 		goto err_free;
 	}
 
-	ret = panfrost_job_open(panfrost_priv);
+	ret = panfrost_job_open(file);
 	if (ret)
 		goto err_job;
 
@@ -583,7 +599,7 @@ panfrost_postclose(struct drm_device *dev, struct drm_file *file)
 	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
 
 	panfrost_perfcnt_close(file);
-	panfrost_job_close(panfrost_priv);
+	panfrost_job_close(file);
 
 	panfrost_mmu_ctx_put(panfrost_priv->mmu);
 	kfree(panfrost_priv);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 82acabb21b27..c47d14eabbae 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -22,6 +22,7 @@
 #include "panfrost_mmu.h"
 #include "panfrost_dump.h"
 
+#define MAX_JM_CTX_PER_FILE 64
 #define JOB_TIMEOUT_MS 500
 
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
@@ -359,6 +360,7 @@ static void panfrost_job_cleanup(struct kref *ref)
 		kvfree(job->bos);
 	}
 
+	panfrost_jm_ctx_put(job->ctx);
 	kfree(job);
 }
 
@@ -383,6 +385,9 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
 
+	if (job->ctx->destroyed)
+		return ERR_PTR(-ECANCELED);
+
 	if (unlikely(job->base.s_fence->finished.error))
 		return NULL;
 
@@ -917,39 +922,176 @@ void panfrost_job_fini(struct panfrost_device *pfdev)
 	destroy_workqueue(pfdev->reset.wq);
 }
 
-int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
+int panfrost_job_open(struct drm_file *file)
+{
+	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
+	int ret;
+
+	struct drm_panfrost_jm_ctx_create default_jm_ctx = {
+		.priority = PANFROST_JM_CTX_PRIORITY_MEDIUM,
+	};
+
+	xa_init_flags(&panfrost_priv->jm_ctxs, XA_FLAGS_ALLOC);
+
+	ret = panfrost_jm_ctx_create(file, &default_jm_ctx);
+	if (ret)
+		return ret;
+
+	/* We expect the default context to be assigned handle 0. */
+	if (WARN_ON(default_jm_ctx.handle))
+		return -EINVAL;
+
+	return 0;
+}
+
+void panfrost_job_close(struct drm_file *file)
+{
+	struct panfrost_file_priv *panfrost_priv = file->driver_priv;
+	struct panfrost_jm_ctx *jm_ctx;
+	unsigned long i;
+
+	xa_for_each(&panfrost_priv->jm_ctxs, i, jm_ctx)
+		panfrost_jm_ctx_destroy(file, i);
+
+	xa_destroy(&panfrost_priv->jm_ctxs);
+}
+
+int panfrost_job_is_idle(struct panfrost_device *pfdev)
 {
-	struct panfrost_device *pfdev = panfrost_priv->pfdev;
 	struct panfrost_job_slot *js = pfdev->js;
-	struct drm_gpu_scheduler *sched;
-	int ret, i;
+	int i;
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		sched = &js->queue[i].sched;
-		ret = drm_sched_entity_init(&panfrost_priv->sched_entity[i],
-					    DRM_SCHED_PRIORITY_NORMAL, &sched,
-					    1, NULL);
-		if (WARN_ON(ret))
-			return ret;
+		/* If there are any jobs in the HW queue, we're not idle */
+		if (atomic_read(&js->queue[i].sched.credit_count))
+			return false;
+	}
+
+	return true;
+}
+
+static void panfrost_jm_ctx_release(struct kref *kref)
+{
+	struct panfrost_jm_ctx *jm_ctx = container_of(kref, struct panfrost_jm_ctx, refcnt);
+
+	WARN_ON(!jm_ctx->destroyed);
+
+	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++)
+		drm_sched_entity_destroy(&jm_ctx->slot_entity[i]);
+
+	kfree(jm_ctx);
+}
+
+void
+panfrost_jm_ctx_put(struct panfrost_jm_ctx *jm_ctx)
+{
+	if (jm_ctx)
+		kref_put(&jm_ctx->refcnt, panfrost_jm_ctx_release);
+}
+
+struct panfrost_jm_ctx *
+panfrost_jm_ctx_get(struct panfrost_jm_ctx *jm_ctx)
+{
+	if (jm_ctx)
+		kref_get(&jm_ctx->refcnt);
+
+	return jm_ctx;
+}
+
+struct panfrost_jm_ctx *
+panfrost_jm_ctx_from_handle(struct drm_file *file, u32 handle)
+{
+	struct panfrost_file_priv *priv = file->driver_priv;
+	struct panfrost_jm_ctx *jm_ctx;
+
+	xa_lock(&priv->jm_ctxs);
+	jm_ctx = panfrost_jm_ctx_get(xa_load(&priv->jm_ctxs, handle));
+	xa_unlock(&priv->jm_ctxs);
+
+	return jm_ctx;
+}
+
+static int jm_ctx_prio_to_drm_sched_prio(struct drm_file *file,
+					 enum drm_panfrost_jm_ctx_priority in,
+					 enum drm_sched_priority *out)
+{
+	switch (in) {
+	case PANFROST_JM_CTX_PRIORITY_LOW:
+		*out = DRM_SCHED_PRIORITY_LOW;
+		return 0;
+	case PANFROST_JM_CTX_PRIORITY_MEDIUM:
+		*out = DRM_SCHED_PRIORITY_NORMAL;
+		return 0;
+	case PANFROST_JM_CTX_PRIORITY_HIGH:
+		if (!panfrost_high_prio_allowed(file))
+			return -EACCES;
+
+		*out = DRM_SCHED_PRIORITY_HIGH;
+		return 0;
+	default:
+		return -EINVAL;
 	}
+}
+
+int panfrost_jm_ctx_create(struct drm_file *file,
+			   struct drm_panfrost_jm_ctx_create *args)
+{
+	struct panfrost_file_priv *priv = file->driver_priv;
+	struct panfrost_device *pfdev = priv->pfdev;
+	enum drm_sched_priority sched_prio;
+	struct panfrost_jm_ctx *jm_ctx;
+	int ret;
+
+	jm_ctx = kzalloc(sizeof(*jm_ctx), GFP_KERNEL);
+	if (!jm_ctx)
+		return -ENOMEM;
+
+	kref_init(&jm_ctx->refcnt);
+
+	ret = jm_ctx_prio_to_drm_sched_prio(file, args->priority, &sched_prio);
+	if (ret)
+		goto err_put_jm_ctx;
+
+	for (u32 i = 0; i < NUM_JOB_SLOTS; i++) {
+		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
+
+		ret = drm_sched_entity_init(&jm_ctx->slot_entity[i], sched_prio,
+					    &sched, 1, NULL);
+		if (ret)
+			goto err_put_jm_ctx;
+	}
+
+	ret = xa_alloc(&priv->jm_ctxs, &args->handle, jm_ctx,
+		       XA_LIMIT(0, MAX_JM_CTX_PER_FILE), GFP_KERNEL);
+	if (ret)
+		goto err_put_jm_ctx;
+
 	return 0;
+
+err_put_jm_ctx:
+	jm_ctx->destroyed = true;
+	panfrost_jm_ctx_put(jm_ctx);
+	return ret;
 }
 
-void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
+int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle)
 {
-	struct panfrost_device *pfdev = panfrost_priv->pfdev;
-	int i;
+	struct panfrost_file_priv *priv = file->driver_priv;
+	struct panfrost_device *pfdev = priv->pfdev;
+	struct panfrost_jm_ctx *jm_ctx;
 
-	for (i = 0; i < NUM_JOB_SLOTS; i++)
-		drm_sched_entity_destroy(&panfrost_priv->sched_entity[i]);
+	jm_ctx = xa_erase(&priv->jm_ctxs, handle);
+	if (!jm_ctx)
+		return -EINVAL;
+
+	jm_ctx->destroyed = true;
 
 	/* Kill in-flight jobs */
 	spin_lock(&pfdev->js->job_lock);
-	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		struct drm_sched_entity *entity = &panfrost_priv->sched_entity[i];
-		int j;
+	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slot_entity); i++) {
+		struct drm_sched_entity *entity = &jm_ctx->slot_entity[i];
 
-		for (j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
+		for (int j = ARRAY_SIZE(pfdev->jobs[0]) - 1; j >= 0; j--) {
 			struct panfrost_job *job = pfdev->jobs[i][j];
 			u32 cmd;
 
@@ -980,18 +1122,7 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
 		}
 	}
 	spin_unlock(&pfdev->js->job_lock);
-}
-
-int panfrost_job_is_idle(struct panfrost_device *pfdev)
-{
-	struct panfrost_job_slot *js = pfdev->js;
-	int i;
 
-	for (i = 0; i < NUM_JOB_SLOTS; i++) {
-		/* If there are any jobs in the HW queue, we're not idle */
-		if (atomic_read(&js->queue[i].sched.credit_count))
-			return false;
-	}
-
-	return true;
+	panfrost_jm_ctx_put(jm_ctx);
+	return 0;
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index ec581b97852b..5a30ff1503c6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -18,6 +18,7 @@ struct panfrost_job {
 
 	struct panfrost_device *pfdev;
 	struct panfrost_mmu *mmu;
+	struct panfrost_jm_ctx *ctx;
 
 	/* Fence to be signaled by IRQ handler when the job is complete. */
 	struct dma_fence *done_fence;
@@ -39,10 +40,30 @@ struct panfrost_job {
 	u64 start_cycles;
 };
 
+struct panfrost_js_ctx {
+	struct drm_sched_entity sched_entity;
+	bool enabled;
+};
+
+#define NUM_JOB_SLOTS 3
+
+struct panfrost_jm_ctx {
+	struct kref refcnt;
+	bool destroyed;
+	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
+};
+
+int panfrost_jm_ctx_create(struct drm_file *file,
+			   struct drm_panfrost_jm_ctx_create *args);
+int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);
+void panfrost_jm_ctx_put(struct panfrost_jm_ctx *jm_ctx);
+struct panfrost_jm_ctx *panfrost_jm_ctx_get(struct panfrost_jm_ctx *jm_ctx);
+struct panfrost_jm_ctx *panfrost_jm_ctx_from_handle(struct drm_file *file, u32 handle);
+
 int panfrost_job_init(struct panfrost_device *pfdev);
 void panfrost_job_fini(struct panfrost_device *pfdev);
-int panfrost_job_open(struct panfrost_file_priv *panfrost_priv);
-void panfrost_job_close(struct panfrost_file_priv *panfrost_priv);
+int panfrost_job_open(struct drm_file *file);
+void panfrost_job_close(struct drm_file *file);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
-- 
2.51.0


