Return-Path: <linux-kernel+bounces-798967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85929B42562
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7281BC47A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF133277030;
	Wed,  3 Sep 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cb2GoSA0"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD34267B90;
	Wed,  3 Sep 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913030; cv=none; b=DZrJTnnX2uzJqX+mapaQh6VnhFghbirWmsUWxC313w8cg6vdoyXdO1v0B3AxYkJwykqULO7DAHOtA8sU2jCrD2cGO7WMAWhZEfvqmALfs5A1W0YIEaGL7lC0KgFxZZj9yIwvVlHhdE8WfGPcogIhib6px1cvf+1XHkH/Pmr6pEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913030; c=relaxed/simple;
	bh=IjIRNCIG10ceuJrXGZ+pP546TYoi0mrpn7n8IynCxMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXIgmUtBiLvVIu2tqgQxRk5drm9f7kezMWuXrgb2wZyuIRjCWECN3rIiyC+JbsrHPiNMgoDSVVQQK7HalsqxieHu94AZmPUjv/WufxpytsPYjwVLYxn0dmo/K1gPdrzyU+9WHF8OBmhsxZAhSs/PGhO0+xRN2RLJ7sbfFTD+hCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cb2GoSA0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wQnaZgS1dP3EwPvhkT/qy9guMTMDTS2EnDU2CurSO/o=; b=cb2GoSA0h9vmlZKNsEQqf3QO/+
	aevSkBxDtQ2i6k8g5KdUDwOLWMj0Ee7R8Zhh/Hdp3aywUWNsRk8JRcwWx0vOhBF8XiRfdsiqTu+Kq
	3WAj3d3zhkafrTR6bzzrvKr28XCTZGUPuDRzHPcKi2SiyW5ultmxzha4xiD9mComwHj9VzlgvEgV7
	i4AhXG9lTug0Ew1Rxjp2hQw+czTb+dqpsIneAmytpwjg7/Ne6YxkMcGJ7URyQOWIB4f35c7yhBlt2
	YSE9qi5cVl/KHiQ5hhWt9KwoOrwkm0VR77m+y6lxT285xNrZ1Qk2IysKsw5BIhr9zjJlmCQPzRuQR
	StMa8pkg==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKp-006GbC-Kg; Wed, 03 Sep 2025 17:23:43 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 17/21] drm/sched: Add helper for tracking entities per client
Date: Wed,  3 Sep 2025 16:23:23 +0100
Message-ID: <20250903152327.66002-18-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable adding DRM cgroup support to the DRM scheduler we need a way for
updating the relative scheduling weights per entity at the point the
controller invokes a call-back notifying the driver of a new relative
scheduling weight for a client.

We add two helpers which will allow drivers to opt-in into the tracking
and they are responsible to call them at the correct times respective to
the entity lifetime.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/drm_file.c               |  3 ++
 drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++
 include/drm/drm_file.h                   |  5 ++++
 include/drm/gpu_scheduler.h              | 38 ++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 1520436c5491..c584d97e5f6c 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -48,6 +48,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
+#include <drm/gpu_scheduler.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -162,6 +163,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	mutex_init(&file->event_read_lock);
 	mutex_init(&file->client_name_lock);
 
+	drm_sched_cgroup_init_drm_file(file);
+
 	if (drm_core_check_feature(dev, DRIVER_GEM))
 		drm_gem_open(dev, file);
 
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ba290143c95d..e0c748c4c10f 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 
+#include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
 
@@ -131,6 +132,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+	INIT_LIST_HEAD(&entity->drm_file_link);
+#endif
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_sched_entity_init);
@@ -606,3 +611,23 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
+
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+void drm_sched_cgroup_track_sched_entity(struct drm_file *file_priv,
+					 struct drm_sched_entity *entity)
+{
+	spin_lock(&file_priv->sched_entities.lock);
+	list_add_tail(&entity->drm_file_link, &file_priv->sched_entities.list);
+	spin_unlock(&file_priv->sched_entities.lock);
+}
+EXPORT_SYMBOL(drm_sched_cgroup_track_sched_entity);
+
+void drm_sched_cgroup_untrack_sched_entity(struct drm_file *file_priv,
+					   struct drm_sched_entity *entity)
+{
+	spin_lock(&file_priv->sched_entities.lock);
+	list_del(&entity->drm_file_link);
+	spin_unlock(&file_priv->sched_entities.lock);
+}
+EXPORT_SYMBOL(drm_sched_cgroup_untrack_sched_entity);
+#endif
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 3326246a2f06..04cad0c61513 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -299,6 +299,11 @@ struct drm_file {
 #if IS_ENABLED(CONFIG_CGROUP_DRM)
 	struct cgroup_subsys_state *__css;
 	struct list_head clink;
+
+	struct {
+		spinlock_t		lock;
+		struct list_head	list;
+	} sched_entities;
 #endif
 
 	/**
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 7fbcd121a6d3..003b5904927f 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -240,6 +240,9 @@ struct drm_sched_entity {
 	 */
 	struct rb_node			rb_tree_node;
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+	struct list_head	drm_file_link;
+#endif
 };
 
 /**
@@ -700,4 +703,39 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 				   struct drm_gpu_scheduler **sched_list,
 				   unsigned int num_sched_list);
 
+#if IS_ENABLED(CONFIG_CGROUP_DRM)
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+#include <drm/drm_file.h>
+
+/* Static inline to allow drm.ko and gpu-sched.ko as modules. */
+static inline void drm_sched_cgroup_init_drm_file(struct drm_file *file_priv)
+{
+	spin_lock_init(&file_priv->sched_entities.lock);
+	INIT_LIST_HEAD(&file_priv->sched_entities.list);
+}
+
+void drm_sched_cgroup_track_sched_entity(struct drm_file *file_priv,
+				  struct drm_sched_entity *entity);
+void drm_sched_cgroup_untrack_sched_entity(struct drm_file *file_priv,
+				    struct drm_sched_entity *entity);
+#else
+static inline void drm_sched_cgroup_init_drm_file(struct drm_file *file_priv)
+{
+}
+
+static inline void
+drm_sched_cgroup_track_sched_entity(struct drm_file *file_priv,
+				    struct drm_sched_entity *entity)
+{
+}
+
+static inline void
+drm_sched_cgroup_untrack_sched_entity(struct drm_file *file_priv,
+				      struct drm_sched_entity *entity)
+{
+}
+#endif
+
 #endif
-- 
2.48.0


