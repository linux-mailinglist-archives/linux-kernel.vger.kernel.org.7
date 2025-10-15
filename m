Return-Path: <linux-kernel+bounces-853515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1ABDBE13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFD514F1FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA81D5151;
	Wed, 15 Oct 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="JX/8RxZL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEF1BD035
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487055; cv=pass; b=Mby+SEc1EvJthWJtrlIYc5DqxG5XR7fxJBEUKBByMqJx7OoFshKSkXVjMI2w3c83cW+w/77jwNA/BUtWwaWHliENto0GrQODAzYydQVHhBTg6h80LsRrpmp+ZaddxCYTqjObd80yRoFC+7aYSSWSxVslWvulw+BMn71KjVAGgNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487055; c=relaxed/simple;
	bh=Cqise2UqoFod2wZpAyNvMZXOT3PVnDPCZEGdsryJr0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKYIHMOw5cku8QY3VyCvIvIVsatgbq8m0g6HucBpJi0ht39ItpJAepTNSmTfSTOoxQCIwiR6lo473zhW/PmwakCqFDW2Igii2YY/PVDPFT1EaL/7NfefRAjnYgB1M/83WZyvowIKgIOF0wLfvJyXzy49EsrD040hH3siKGpSrgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=JX/8RxZL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iC6zVvW1Vk1fou8pLQScip8x4ZSdZ/TephdeQ0kGRSkZeilVS45qw+9V5tKzY4Xhe7+i1hn+uPevckWuA2d2B5jZunr0HZwD+XRTIdO1UK0lwqKrS8g+uSl+JkwFKY+rvhtTkrXtCz5az6D7WBTBtU2q0jKIrYkThqXvBc6cQ8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487037; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ck5yvI05ewR7fJHKZX7f4sdZz2YTp3nTlFLVKdPWGMQ=; 
	b=dW6UQIcgBNV2FS1m0yi9ns/JmFNALcLR/Ef1/6NiIXx0il8AjsXGOOolwfB1QSLFyyV80aRTxDbIzoMAzkOK0rHDdgMTNYwPH8bTM8Q9SQhP0bd0oLPFQHD0XylhKThGgsIH17G9QYBJqkTVO0i4FXp+KkEbqUsYN5Cxs/36abQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487037;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ck5yvI05ewR7fJHKZX7f4sdZz2YTp3nTlFLVKdPWGMQ=;
	b=JX/8RxZLE+XUvxmeCYnHU4pL0kEEEBX+F2FJQfOK3rqdckpECyZbV/ewRf1S9CJo
	K9P4nns3+dgrBqqgHE4jkwbmlyesVXCkd44qTp1Tzu0mIPcRz3LbNdrN5yOmNIn3DhI
	EQ1GykMntan0/M5CmSVuu9XGl/RWsVYzCA9iBdQM=
Received: by mx.zohomail.com with SMTPS id 1760487035882441.7807053237426;
	Tue, 14 Oct 2025 17:10:35 -0700 (PDT)
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
Subject: [PATCH v6 07/12] drm/panfrost: Don't rework job IRQ enable mask in the enable path
Date: Wed, 15 Oct 2025 01:09:13 +0100
Message-ID: <20251015000930.356073-8-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Up until now, panfrost_job_enable_interrupts() would always recalculate the
same job IRQ enablement mask, which is effectively a constant.

Replace it with a compile-time constant value, and also in another couple
places where an equivalent expression was being used.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h |  4 ++++
 drivers/gpu/drm/panfrost/panfrost_job.c    | 19 ++++---------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 474b232bb38e..ac7147ed806b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -26,6 +26,10 @@ struct panfrost_perfcnt;
 
 #define MAX_PM_DOMAINS 5
 
+#define ALL_JS_INT_MASK					\
+	(GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |		\
+	 GENMASK(NUM_JOB_SLOTS - 1, 0))
+
 enum panfrost_drv_comp_bits {
 	PANFROST_COMP_BIT_GPU,
 	PANFROST_COMP_BIT_JOB,
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index d53e9db945ad..dc4228af78f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -432,17 +432,10 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 {
-	int j;
-	u32 irq_mask = 0;
-
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
 
-	for (j = 0; j < NUM_JOB_SLOTS; j++) {
-		irq_mask |= MK_JS_MASK(j);
-	}
-
-	job_write(pfdev, JOB_INT_CLEAR, irq_mask);
-	job_write(pfdev, JOB_INT_MASK, irq_mask);
+	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
+	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev)
@@ -761,9 +754,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK,
-		  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-		  GENMASK(NUM_JOB_SLOTS - 1, 0));
+	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -836,9 +827,7 @@ static irqreturn_t panfrost_job_irq_handler_thread(int irq, void *data)
 
 	/* Enable interrupts only if we're not about to get suspended */
 	if (!test_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended))
-		job_write(pfdev, JOB_INT_MASK,
-			  GENMASK(16 + NUM_JOB_SLOTS - 1, 16) |
-			  GENMASK(NUM_JOB_SLOTS - 1, 0));
+		job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 
 	return IRQ_HANDLED;
 }
-- 
2.51.0


