Return-Path: <linux-kernel+bounces-859747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D6BBEE7A6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0150F4E8591
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A02E03E0;
	Sun, 19 Oct 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Zp9EKPE2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5B1DF742
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885592; cv=pass; b=TqFmhVxSG0F6qV/OuGiY1hrBKWsqO2pnyG7pRAmPdwsSZQdKzhlS5b33y6WJKsnGhNbIAj22rBsViKWvNvHLG3TenZQllYsRbdtCfWPsWi2y7zuJynzYH9NIPnPalONqoqJRRIds0MN29mXD+N79Khv1WoghrsVaqRVdEu/MA6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885592; c=relaxed/simple;
	bh=kDpIdbi3oCh+PoWY+iLVp1i7qxHz5zaQLoS4MzYB4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmHS49nacZN+l3oF4Z2QNEJT1KLhCAgZ0193cnHIE6ZCmHuEl/IYFqbAeKwMPocF4NvUBvwQFMqatlIq3CPoz+1hEk2sfvw8jyHisBBRlSLTxnPNJjZimYu8m/ntryaeIH7in40h+QrrEGxz5hSz6XkpBS+e3MGDjxPwKkdIxVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Zp9EKPE2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J78Yzb7DPWgLlSttaX4LpJ8LiAXSbKbccVd+xtjTZ9+qJ+GqYf61Sc+3LdVojn5syH8JOmr9+OfSdx3HtGUxu1ZX4OQO/Jx5n5uzlhnmZFg1rsXNDizJqjnAWDnv2NwUnQO/FxuJQKEJiVLQ5ziD0BLfo3UQymuMjdfCC8E/P3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885572; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=soGMCnhjfrfxzaF7vGaUw4f75xveX1BoH/rY5gJE6wA=; 
	b=OYll0162zIcazYgEoiC1O8zNMpXoEbkNwdracFShEs+s/Tp3MuKsJIt4N8LFI0DM63YxljjVhLtnEKaIewWPOTizukH+lBeYBjY3ffcDMMibIOSwBd3vALsxGvGvBKVjh/pIcWqB2XrouQSNBbyT1GWfq7HIT8jUeaH729arlOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885572;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=soGMCnhjfrfxzaF7vGaUw4f75xveX1BoH/rY5gJE6wA=;
	b=Zp9EKPE2aKmOGnuhBGpRwjN0Vf76A/BTkpfFWND66jKZnsdWTCDhf7TrnOpbAH5Z
	Lti7TEYrlVEQt7ftzG79Th3mQHvKrK/FbQOzLES/ai5hwHY9CP8iuGDvy30ZrVgzRvl
	+hLWo3a+56nYJylzNNbTingnm0LBNu4UWGYa3M78=
Received: by mx.zohomail.com with SMTPS id 1760885571276142.64593102797403;
	Sun, 19 Oct 2025 07:52:51 -0700 (PDT)
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
Subject: [PATCH v7 03/12] drm/panfrost: Handle job HW submit errors
Date: Sun, 19 Oct 2025 15:52:08 +0100
Message-ID: <20251019145225.3621989-4-adrian.larumbe@collabora.com>
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

Avoid waiting for the DRM scheduler job timedout handler, and instead, let
the DRM scheduler core signal the error fence immediately when HW job
submission fails.

That means we must also decrement the runtime-PM refcnt for the device,
because the job will never be enqueued or inflight.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 01fcba4e0d57..0722f297d142 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -200,7 +200,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	unsigned int subslot;
@@ -208,18 +208,19 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	u64 jc_head = job->jc;
 	int ret;
 
-	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
-
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
-		return;
+		goto err_hwsubmit;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		ret = -EINVAL;
+		goto err_hwsubmit;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
 
+	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
+
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
 
@@ -266,6 +267,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
 	spin_unlock(&pfdev->js->job_lock);
+
+	return 0;
+
+err_hwsubmit:
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+	return ret;
 }
 
 static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -388,6 +395,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (job->ctx->destroyed)
 		return ERR_PTR(-ECANCELED);
@@ -409,7 +417,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	panfrost_job_hw_submit(job, slot);
+	ret = panfrost_job_hw_submit(job, slot);
+	if (ret) {
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	return fence;
 }
-- 
2.51.0


