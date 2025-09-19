Return-Path: <linux-kernel+bounces-824985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D7B8AA16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEEF189AEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C831FEF8;
	Fri, 19 Sep 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dJ8WGonn"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A42264617
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300321; cv=pass; b=H7Aqiqv0MYJIBDhFJH//5+CKYXwY6OloZds6dXeYMule582HCADArGq8Qjl7u0zW/eanFpOeqZtsajrizDKDd+HTdK9C4czBZPOCfJEFX1M/QHRHoWI5xC2+DEwJCbZ54dghgMs8Q7+X+5x9W3FwRswyBSC2oz9KZqDB/hLoHqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300321; c=relaxed/simple;
	bh=eYbYJTyOBmZaa4wji18fy2G9SUA4SOUqceyb3LBb8jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qz9jzrdr8tpZ4Ep8kZD1/mHsyuMt95ky+o6yk8bPJrTwxcfAIQadK5srXBrbkCk8le7/m84gIErk6BD4KcRqA3m9AXxy+j3og0wg21OFH8H38fKXWxrkHuFm8rXHmlzahmdoQYEkzkfzYF+JDfD3h8saURaf50OWk0eCNGEb6xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=dJ8WGonn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758300298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQZjaYV32yBRAhVULxJX2VoCyAQF0YmxGq9Iz+VpE5PUHBwY+jhERUiEZkUoju3nwmeuGcVOzP/3tY6O9NNSQ8BG6eehlq81P7b+7Ga4VyfF8viMqlUsmQvzr2UObQ0lo1wsye7GHOi5SxHpnopl0bQTmqZ5laPtUhTq+p3WOi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758300298; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rkbul+5GmuUcM0b/MWyFiAkpc0VDM1F5kI2ZnfPs5a8=; 
	b=lj7ACw438mqV9CQe8+DsiAN171JgVIz/OLTnJ0tpO5tKCkRnEvLtcRNOjV4oqc41WGA1kBJ8T3GAigV3aHvpr6BHrubCasYmLMgpPco7mEphUdzoOUBc2uH6yJqv3P31u/Wz8RibSyMLm2rzeFBQhxpg3VBBYwPio7+RsBOpce4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758300298;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rkbul+5GmuUcM0b/MWyFiAkpc0VDM1F5kI2ZnfPs5a8=;
	b=dJ8WGonnv4HMqDd2D3N1MShnahK34JQ4+CVLVM1yRp7UXEhSxug61YtnhkULyfTN
	goXJm/Jf7YpkYYgEhB6fH3Sl80PVcXOzQmCExLkmqDQ9kZRkPB0j6cLFB2C2jFFzfI7
	25k7PBhltZ31xc2iL1ggPJrqC3Vp6NEHA74wiLn8=
Received: by mx.zohomail.com with SMTPS id 1758300297314473.47222430101465;
	Fri, 19 Sep 2025 09:44:57 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] drm/panthor: Defer scheduler entitiy destruction to queue release
Date: Fri, 19 Sep 2025 17:43:48 +0100
Message-ID: <20250919164436.531930-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit de8548813824 ("drm/panthor: Add the scheduler logical block")
handled destruction of a group's queues' drm scheduler entities early
into the group destruction procedure.

However, that races with the group submit ioctl, because by the time
entities are destroyed (through the group destroy ioctl), the submission
procedure might've already obtained a group handle, and therefore the
ability to push jobs into entities. This is met with a DRM error message
within the drm scheduler core as a situation that should never occur.

Fix by deferring drm scheduler entity destruction to queue release time.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0cc9055f4ee5..f5e01cb16cfc 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -898,8 +898,7 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (IS_ERR_OR_NULL(queue))
 		return;
 
-	if (queue->entity.fence_context)
-		drm_sched_entity_destroy(&queue->entity);
+	drm_sched_entity_destroy(&queue->entity);
 
 	if (queue->scheduler.ops)
 		drm_sched_fini(&queue->scheduler);
@@ -3609,11 +3608,6 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	if (!group)
 		return -EINVAL;
 
-	for (u32 i = 0; i < group->queue_count; i++) {
-		if (group->queues[i])
-			drm_sched_entity_destroy(&group->queues[i]->entity);
-	}
-
 	mutex_lock(&sched->reset.lock);
 	mutex_lock(&sched->lock);
 	group->destroyed = true;
-- 
2.51.0


