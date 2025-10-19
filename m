Return-Path: <linux-kernel+bounces-859749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48973BEE7BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2875B4E9E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BE2EBB83;
	Sun, 19 Oct 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Yx6nUEQR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3422EA74D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885594; cv=pass; b=P/EMGcMyydHohuuo4MOhkzyPULUj0rC1+l8v+p898HUAzD8LzOUHacq77MvoE7C94GnoKwKtoV9qD2F0E2SOHu0h7sIt6aTd68XZef5pNngBgbn7Q9xEfq4CknrNE/TKh2/H7bMC9cqEKbuAWr+uJdDl+d0//SaECd4PF1DycYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885594; c=relaxed/simple;
	bh=/UzitfHWe5C2cUIMVFUhtWjgNDS5LKsi5BMkfTlk3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V54M3kQ99wv0bd2V/fhPJ9RPa4+Q8Liel28vn7ShwABVQjjiJ+eT1sCVl717cs1t90jnXZvlfax7Xr7PoMhd0YlGmv98mhxlYzn75C/nw0sMiL9oE3YEEwfzHPBxsUnZ6+sgux+vtI0iSUTj9HJhMeUPutHZss8+jwfslblnuh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Yx6nUEQR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885576; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JSO9b83E22rH3n35l82JmTRZl5XuVyeViFVAF+VhpVsdkNSReIF9mA5QzBn1HcGZu1lqY5GLwccOwNeat/AcNXG1mhjPB+e6GHyqEnTcHfk5nVtDvP4rnev4/ucLM1hMRH7fnPJACtHoBL87pV4PJu54Y9VFI3I53g39T3ud3uw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885576; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CwtNQuXVjE/Tvw7Mk7AVrqrmCjh/9Y2/ym3rni+rhoU=; 
	b=KkdOp6cjZXCAjOtndmGuGXVMIcXrfRSqu5cIXKqqfHittpT5zHkocbM1ADFbKwTeYDi9hMrapqGQVvVsKJkSIKVHvdeS5fKVGi9GXmEoQ3Hxhlk1TF6GFiwLTDoTlzo0Y0HEx4wNFHDRQa4H0qRA3iGsRhQ2kJpH0Z09MA18j7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885576;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CwtNQuXVjE/Tvw7Mk7AVrqrmCjh/9Y2/ym3rni+rhoU=;
	b=Yx6nUEQRzH+1d+6UuZ4R+1Zn86pf4cqwRv3Wo3Ni8aemoVd6AMXwxyVp55UPiVf7
	wVq9xalSJ9h+l3cOYrdrd+wuA2xm3YaTs+OLAAdK4eXpEF7L/9tLWkr8wQDYvaGs4jz
	Poq9fJiId8v3W02UHQjzHoKQsspAakqgaidHzH9o=
Received: by mx.zohomail.com with SMTPS id 176088557440913.543686059443075;
	Sun, 19 Oct 2025 07:52:54 -0700 (PDT)
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
Subject: [PATCH v7 04/12] drm/panfrost: Handle error when allocating AS number
Date: Sun, 19 Oct 2025 15:52:09 +0100
Message-ID: <20251019145225.3621989-5-adrian.larumbe@collabora.com>
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

If we reach the beginning of the LRU AS list, then return an error.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 7 +++++--
 drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 8 ++++++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 0722f297d142..d53e9db945ad 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -217,7 +217,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 		goto err_hwsubmit;
 	}
 
-	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
+	ret = panfrost_mmu_as_get(pfdev, job->mmu);
+	if (ret < 0)
+		goto err_hwsubmit;
+
+	cfg = ret;
 
 	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 1d696eeea2fa..fd148d5746c0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -258,7 +258,7 @@ static int panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
 	}
 }
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 {
 	int as;
 
@@ -300,7 +300,10 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 			if (!atomic_read(&lru_mmu->as_count))
 				break;
 		}
-		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
+		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list)) {
+			as = -EBUSY;
+			goto out;
+		}
 
 		list_del_init(&lru_mmu->list);
 		as = lru_mmu->as;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 022a9a74a114..e6e6966a0cca 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 
 struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 718eb44b40f8..7020c0192e18 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -130,9 +130,11 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 		goto err_vunmap;
 	}
 
-	perfcnt->user = user;
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	if (ret < 0)
+		goto err_vunmap;
 
-	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	as = ret;
 	cfg = GPU_PERFCNT_CFG_AS(as) |
 	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
 
@@ -164,6 +166,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	/* The BO ref is retained by the mapping. */
 	drm_gem_object_put(&bo->base);
 
+	perfcnt->user = user;
+
 	return 0;
 
 err_vunmap:
-- 
2.51.0


