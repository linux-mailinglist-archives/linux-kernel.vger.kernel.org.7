Return-Path: <linux-kernel+bounces-846736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757EBC8E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DBF1892475
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846EB2DFA3A;
	Thu,  9 Oct 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YuIjomby"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8C2E090C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010225; cv=pass; b=ly1Tr88Gtao4239PP2T2Na4bBXPLLwlOsxTJns9cnTmqdhbbS7uY/kATKho99/4AJk8DyQjYo+ZEITGTR4Z6oka0o3F74qm8Ab2WAXecVExZVVHF9Jre/FeD6Nk9noDp0N+SNqjGHUb6NFoi6peXf6uLKlrKDmZi7V7pHupQs8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010225; c=relaxed/simple;
	bh=S+ENYA5gtsZF536T+gBRcYAuDhEzAIcFVS6jEdAPKh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHLTOneENvJ7Hripe3gicBnR3A4ZABzXddw55BOCRdHWuRjBXe93YbHWYNkZnVYf7Gm2NyyREpUzBX03caKJ8JhA20Kg+0HuUVwil2wIFPAZzvtc4Yv43LyBhtEJCiK3B4aXkpeOtvdrZQ/6+NonuNmUs7vFxmBSPtHbm8Jk23Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=YuIjomby; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760010210; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dpA5l7ftdFKWIIK2OexE05gFblMgrMpryGOYEKchoGxrNY9RIZCdtd6gkm0hFpu/7y5+/rlmNgNYhV9ZFMkaYps/IltMYzHLxBw/UEGH5jQ9Ao3nv9JHQOIpt/73EfFiqb4JCRbnYBzxTaKVX5+76HFmzv8CBCnZ0wWJUEA17RM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760010210; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c4zXG31VEmip+0b8RFc9/Hhvu/aREmShl6nTjypkjmY=; 
	b=loKMuPjdVEXkDPQggIF+Ir3Fys7OTPTcFkiYkVaKkhqZs09K7+xcrBYE2udISvjoNQvsJfoqqF5Kl9Skz60hyDwhEiXCVxaYMQJVTc6CTBq6H3Y0tkzVTjqAGcEyHZkCiT+QhhJbdiz6SM3ysmvS116a+MP+FolfdR421TKnY1I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760010210;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=c4zXG31VEmip+0b8RFc9/Hhvu/aREmShl6nTjypkjmY=;
	b=YuIjombym5u84o0G1ovH2QXfR6lhk+aeOmbS0FNgiwM1jmUtPxg8DY5dYTjQt27O
	eZyGfAZi/NJY1Z9mTT+erJw0rCPYj52r9wf/uUVSo0Wn/WOd0yHNnE85Dhd8kFnqg3t
	xseBZ07Yt08B7PWxU1zglPPCfPavaehp5OKMF2jU=
Received: by mx.zohomail.com with SMTPS id 1760010208813178.71792539993703;
	Thu, 9 Oct 2025 04:43:28 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: healych@amazon.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/panfrost: Name scheduler queues after their job slots
Date: Thu,  9 Oct 2025 12:43:00 +0100
Message-ID: <20251009114313.1374948-1-adrian.larumbe@collabora.com>
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
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++++++----------
 drivers/gpu/drm/panfrost/panfrost_job.c |  8 +++++++-
 drivers/gpu/drm/panfrost/panfrost_job.h |  2 ++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 22350ce8a08f..607a5b8448d0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -668,23 +668,19 @@ static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
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
-				   engine_names[i], panfrost_priv->engine_usage.elapsed_ns[i]);
+				   panfrost_engine_names[i],
+				   panfrost_priv->engine_usage.elapsed_ns[i]);
 			drm_printf(p, "drm-cycles-%s:\t%llu\n",
-				   engine_names[i], panfrost_priv->engine_usage.cycles[i]);
+				   panfrost_engine_names[i],
+				   panfrost_priv->engine_usage.cycles[i]);
 		}
 		drm_printf(p, "drm-maxfreq-%s:\t%lu Hz\n",
-			   engine_names[i], pfdev->pfdevfreq.fast_rate);
+			   panfrost_engine_names[i], pfdev->pfdevfreq.fast_rate);
 		drm_printf(p, "drm-curfreq-%s:\t%lu Hz\n",
-			   engine_names[i], pfdev->pfdevfreq.current_frequency);
+			   panfrost_engine_names[i], pfdev->pfdevfreq.current_frequency);
 	}
 }
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index c47d14eabbae..0cc80da12562 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -28,6 +28,10 @@
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
+const char * const panfrost_engine_names[] = {
+	"fragment", "vertex-tiler", "compute-only"
+};
+
 struct panfrost_queue_state {
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
@@ -846,12 +850,13 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 2,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
-		.name = "pan_js",
 		.dev = pfdev->dev,
 	};
 	struct panfrost_job_slot *js;
 	int ret, j;
 
+	BUILD_BUG_ON(ARRAY_SIZE(panfrost_engine_names) != NUM_JOB_SLOTS);
+
 	/* All GPUs have two entries per queue, but without jobchain
 	 * disambiguation stopping the right job in the close path is tricky,
 	 * so let's just advertise one entry in that case.
@@ -887,6 +892,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);
+		args.name = panfrost_engine_names[j];
 
 		ret = drm_sched_init(&js->queue[j].sched, &args);
 		if (ret) {
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 5a30ff1503c6..458666bf684b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -53,6 +53,8 @@ struct panfrost_jm_ctx {
 	struct drm_sched_entity slot_entity[NUM_JOB_SLOTS];
 };
 
+extern const char * const panfrost_engine_names[];
+
 int panfrost_jm_ctx_create(struct drm_file *file,
 			   struct drm_panfrost_jm_ctx_create *args);
 int panfrost_jm_ctx_destroy(struct drm_file *file, u32 handle);

base-commit: 30531e9ca7cd4f8c5740babd35cdb465edf73a2d
-- 
2.51.0


