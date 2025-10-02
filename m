Return-Path: <linux-kernel+bounces-840534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3732BB4A03
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B048A19E4477
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E9269CE6;
	Thu,  2 Oct 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dXM5k7f9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EA22758F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425136; cv=pass; b=GHFLda29NYK0/F3Q6i/EWgKC4ui9ZZXxvKvmT+Ww82dbLTjIigWkmjn7DBn+6xhvBXeE5GhnpNwTwXe/4pCkvMUmcrpR0QtmqZrMk7zMax2BSaAuMmW9nygAvwpONOjMRnz5ub+WTvQSu688f0Xy1fImUH/pcdfv5HX64GRcnIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425136; c=relaxed/simple;
	bh=LLKstXLmH508qUEsX1l704tztcvzRHAjC9Otl6C5hc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUjLKsnc+Na66GN7j3+Gb3fMqGLywSyiPa1/2QMbIj88OP/+DJL2XT6KxVx9fKb47OhwtZuW6kFw0+DqnTmvCQD+D4KJZgAChFyGxQu70dXkXh8OWFuzYJzBkaJP7R9EocdaDk7zfqsWa1rjgeoRGa1Giaxg62qIjhIU4T8Aysg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=dXM5k7f9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759425116; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fc79Y2nHiSHcnNulRhDiEi6r+XSlJxyAwpYYmFqHvpOuDYsbis1PkT0DvEXCJ/iHGXGZnQsCePkWK2pzqvILrFfVuMeyl4xRgQffV1hkHhK9zKehIUqcSxXKI8jN9+rI7sex6Ze3F+tRv+Bv9QG+JsypPCfJm1mYC6hEmk/MBUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759425116; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vEJPPTFhogSa3KCUS+TOyXr0VwMc+58qyo+RyNDimAY=; 
	b=j0Vky8bJtrghhR5ZIXbF199viv3DtUVNN9rm+Qbm6F+vUxRzD2bgIcBfxO7+Mqd9NDSDTBTG4DtsMQGHDPn/L6hLliQgJAmwiVawDBmedwZMA9DNnaMuWEDCj+do4DCB3PMAgP8vJd7KE6aJAkHVOX8QXXJvbyS0tNbRbH4ZHZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759425116;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vEJPPTFhogSa3KCUS+TOyXr0VwMc+58qyo+RyNDimAY=;
	b=dXM5k7f9BQv/uineiDLvQog1NZvQXT8W0FwppT26kVvicr46FA18YK0dSXwkO1i7
	zISGeilTvtu0gDqGLHefwtCwIE1h2D1iGd6TKFIOjJ5vicKtgUQE1jU3QY8OifvZm/l
	WodPJUv+1Vl2RCkkaUVdEZUNbWxfbI6b7t0GvCuc=
Received: by mx.zohomail.com with SMTPS id 1759425114428924.5561370853379;
	Thu, 2 Oct 2025 10:11:54 -0700 (PDT)
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
Subject: [PATCH] drm/panfrost: Name scheduler queues after their job slots
Date: Thu,  2 Oct 2025 18:11:37 +0100
Message-ID: <20251002171139.2067139-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drawing from commit d2624d90a0b7 ("drm/panthor: assign unique names to
queues"), give scheduler queues proper names that reflect the function
of their JM slot, so that this will be shown when gathering DRM
scheduler tracepoints.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 6 ------
 drivers/gpu/drm/panfrost/panfrost_job.c | 6 +++++-
 drivers/gpu/drm/panfrost/panfrost_job.h | 2 ++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 22350ce8a08f..d08c87bc63a2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -668,12 +668,6 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
 	 *   job spent on the GPU.
 	 */
 
-	static const char * const engine_names[] = {
-		"fragment", "vertex-tiler", "compute-only"
-	};
-
-	BUILD_BUG_ON(ARRAY_SIZE(engine_names) != NUM_JOB_SLOTS);
-
 	for (i = 0; i < NUM_JOB_SLOTS - 1; i++) {
 		if (pfdev->profile_mode) {
 			drm_printf(p, "drm-engine-%s:\t%llu ns\n",
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index c47d14eabbae..0f0340ffee19 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -28,6 +28,10 @@
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
+const char * const engine_names[] = {
+	"fragment", "vertex-tiler-compute", "compute-only"
+};
+
 struct panfrost_queue_state {
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
@@ -846,7 +850,6 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 2,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
-		.name = "pan_js",
 		.dev = pfdev->dev,
 	};
 	struct panfrost_job_slot *js;
@@ -887,6 +890,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);
+		args.name = engine_names[j];
 
 		ret = drm_sched_init(&js->queue[j].sched, &args);
 		if (ret) {
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 5a30ff1503c6..52ff10b8d3d0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -53,6 +53,8 @@ struct panfrost_jm_ctx {
 	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
 };
 
+extern const char * const engine_names[];
+
 int panfrost_jm_ctx_create(struct drm_file *file,
 			   struct drm_panfrost_jm_ctx_create *args);
 int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);

base-commit: 30531e9ca7cd4f8c5740babd35cdb465edf73a2d
-- 
2.51.0


