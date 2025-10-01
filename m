Return-Path: <linux-kernel+bounces-838347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCBBAF011
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F51194440B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9C2820A5;
	Wed,  1 Oct 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="L5DvjB1x"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4E271443
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285324; cv=pass; b=uDMufHD0SQbh/74c8vpZ0lTmAndMja9SilBQ72qcxx8LxuJBoswKy2eyIxxq5y75tcqgt+5E2eep07vmEv+tPm7rSQXL4OLMn9JrYoFPcZYSxcDL6ZMjVIe0jF9CF0mdLw7GIVEPWxXkKYU1liB4rf2OyJV05rumXe7Ngpis0JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285324; c=relaxed/simple;
	bh=yyK56qOmNRFC+NfrqZ40lpoJ67X1wG+ji+l4OQqrTs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECom/L2Ri3KDdZBJnGCpOwd7GCPLNWUVghj0wfcM4OcZSrXGxDUeCd02NVl3O3yBzbwuh+NnndXIWVvZ0RCnLrjdH/GeHhTM9KJM/ItTtBj0TBwL7KFtBFYLspP0d7s62DW1vmr4vRKppNuG7fWQvdcM19MwQLy8aZNqCy8KsCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=L5DvjB1x; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759285306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F8DJdWG4LnGVk6TSZgqDek9OwO6GbMQFvLWwrrfuf2ZwbubU9p+FCsoEONDXh5yQrUTgkzQG3t1Fp2VYrXl/DVt9fkgumkZ6vpKNU1DlSLn5WXIOeyHdrsQ8nIseBTMFKFR04fTPuuucWEHhmNT6ZG7nqOeD9Yo9HozyvtSRC9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759285306; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PfbbH6VlGDpJqhUO1dz5IqaBLdpFs8YvRKGzuiwikbQ=; 
	b=mvwxjx0JetOBJZ9aPfUvexoGIO0UqHC8+XyzO4j/4U8ORwa+g2RtXyW38Vl597mGI58jZqY6UC3ldXoRZoIQx60R23kHmq6XoUukrkGYKEOqWQXmYDYr9k7eWvYRSXgRzcg9Aq2qtgumtckfmMxGs1q0pmoS20h5wHgAcuhbN2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759285306;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PfbbH6VlGDpJqhUO1dz5IqaBLdpFs8YvRKGzuiwikbQ=;
	b=L5DvjB1x8IyGWzUySA34TMF4NqDsTSHDyQB1aYcnncz5E+jg2348V5peshroj0rp
	83zT/jsDMGmouq+WA3nf2nHch6uvcl/xXw9o+ivAo0/7jcn9RwhqQwYwrfX+m+w+ap3
	uhaSmf+cCkhn+QDaWvykIgiTXaQTW3hLNDQlKP3M=
Received: by mx.zohomail.com with SMTPS id 1759285304086518.5183245862718;
	Tue, 30 Sep 2025 19:21:44 -0700 (PDT)
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
Subject: [PATCH v4 09/10] drm/panfrost: Remove unused device property
Date: Wed,  1 Oct 2025 03:20:30 +0100
Message-ID: <20251001022039.1215976-10-adrian.larumbe@collabora.com>
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

The as_in_use_mask device state variable is no longer in use.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 45d77cda8b89..e61c4329fd07 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -147,7 +147,6 @@ struct panfrost_device {
 	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
 
 	spinlock_t as_lock;
-	unsigned long as_in_use_mask;
 	unsigned long as_alloc_mask;
 	unsigned long as_faulty_mask;
 	struct list_head as_lru_list;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index fb17c32855a5..d54cb7bbc1a2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -712,7 +712,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.51.0


