Return-Path: <linux-kernel+bounces-823583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80854B86E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706663B5957
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160631BC86;
	Thu, 18 Sep 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BPICQt7z"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286C31D37A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227119; cv=none; b=nvmcCkmMb9pG/pwazR1Hd2IA+MXE4R4XfJrP+X5oblXgkgFYW4sTDXWVWCZ4RwDRFa+8vcVJytcjqID34dKo+QPKEOTiSRuVUv6/wLYqnHOsHDaG3QTrV6vKyIxNqREvnkB3va3cae/wtlMxOCKEHrUyoiSt5/4i0WuYRpn2/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227119; c=relaxed/simple;
	bh=BGec5hRHCdYo1tz3XrXo1BbiWzyDNTSvVdqyIAcrfYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcmyjQzFZdE2dgRXf897Ib9ByybqhmcLK6OyIgskgWwbB+j7GsECY7k3Ed9ZLOFIVOWcR5BnatjWyrreyyM6VVc8GC+RjmZRE3ajimY165pCyb/A4cAxduXueDxFKB28Fyd4iKF6FBQfVQkLXdi4Hb6U8qVYKe/SW9L2BwuEqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BPICQt7z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=woVS27yiYLORVThWbfEQkqZ5Ig2PmX/E6zj72wklklk=; b=BPICQt7zw+lEmchMwkXG065zLd
	WlcCBQbhDtkeMqpBEs6nQSofJmdnkAAJR5jUoXx9nncI/hK/5fVFySTy42O5NvLwRZGcJ6lRg8K2r
	V3OozTQ51zkuklzHsRMcRqTuT7JdQSkxdalVFBNsTs7qzN/w5M5L7w4DDhAMe5IcM4BspmU4H8WNU
	kmj7Gr/+DPHV6Em9EvhQSgYCO5IASqzpIrAIrJvCbVyhF07NyrUglOZkqI4PVIAwQ9Ol/xBu9hsbW
	nQYMTg619AtU3y56khX7KpGI62dBbrsU/7l0Ucfwqt1IiMkikNBjdk0+JOXCVt6Zo9YnqIS/z6rJo
	wCzWHfFA==;
Received: from 179-125-87-227-dinamico.pombonet.net.br ([179.125.87.227] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uzLBp-00Dp3q-I8; Thu, 18 Sep 2025 22:25:13 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 18 Sep 2025 17:09:25 -0300
Subject: [PATCH RFC v2 2/3] ttm: pool: add a module parameter to set
 latency preference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ttm_pool_no_direct_reclaim-v2-2-135294e1f8a2@igalia.com>
References: <20250918-ttm_pool_no_direct_reclaim-v2-0-135294e1f8a2@igalia.com>
In-Reply-To: <20250918-ttm_pool_no_direct_reclaim-v2-0-135294e1f8a2@igalia.com>
To: Christian Koenig <christian.koenig@amd.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

This allows a system-wide setting for allocations of higher order pages not
to use direct reclaim. The default setting is to keep existing behavior and
allow direct reclaim when allocating higher order pages.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++++--
 drivers/gpu/drm/ttm/ttm_tt.c   |  2 +-
 include/drm/ttm/ttm_pool.h     |  2 +-
 include/drm/ttm/ttm_tt.h       |  2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 02c622a103fcece003bd70ce6b5833ada70f5228..39203f2c247a36b0389682d7fb841088f4c8a95b 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -56,6 +56,11 @@ static DECLARE_FAULT_ATTR(backup_fault_inject);
 #define should_fail(...) false
 #endif
 
+static unsigned int ttm_alloc_method;
+
+MODULE_PARM_DESC(alloc_method, "TTM allocation method (0 - throughput, 1 - latency");
+module_param_named(alloc_method, ttm_alloc_method, uint, 0644);
+
 /**
  * struct ttm_pool_dma - Helper object for coherent DMA mappings
  *
@@ -702,7 +707,7 @@ static unsigned int ttm_pool_alloc_find_order(unsigned int highest,
 }
 
 static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
-			    const struct ttm_operation_ctx *ctx,
+			    struct ttm_operation_ctx *ctx,
 			    struct ttm_pool_alloc_state *alloc,
 			    struct ttm_pool_tt_restore *restore)
 {
@@ -717,6 +722,9 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
 	WARN_ON(alloc->dma_addr && !pool->dev);
 
+	if (ctx->alloc_method == ttm_op_alloc_default && ttm_alloc_method == 1)
+		ctx->alloc_method = ttm_op_alloc_latency;
+
 	if (tt->page_flags & TTM_TT_FLAG_ZERO_ALLOC)
 		gfp_flags |= __GFP_ZERO;
 
@@ -837,7 +845,7 @@ EXPORT_SYMBOL(ttm_pool_alloc);
  * Returns: 0 on successe, negative error code otherwise.
  */
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
-			       const struct ttm_operation_ctx *ctx)
+			       struct ttm_operation_ctx *ctx)
 {
 	struct ttm_pool_alloc_state alloc;
 
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 506e257dfba8501815f8416e808f437e5f17aa8f..e1975d740b948f9b7fe1d35d913a458026d2c783 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -294,7 +294,7 @@ long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
 }
 
 int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
-		   const struct ttm_operation_ctx *ctx)
+		   struct ttm_operation_ctx *ctx)
 {
 	int ret = ttm_pool_restore_and_alloc(&bdev->pool, tt, ctx);
 
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 54cd34a6e4c0ac5e17844b50fd08e72143b460c1..08f9a1388754fac352058ac2beb2b59bb944477c 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -95,7 +95,7 @@ void ttm_pool_drop_backed_up(struct ttm_tt *tt);
 long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *ttm,
 		     const struct ttm_backup_flags *flags);
 int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
-			       const struct ttm_operation_ctx *ctx);
+			       struct ttm_operation_ctx *ctx);
 
 int ttm_pool_mgr_init(unsigned long num_pages);
 void ttm_pool_mgr_fini(void);
diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
index 406437ad674bf1a96527b45c5a81c58a747271c1..3575e20b77f3ccbc3d9aad0afbb762055b3cb139 100644
--- a/include/drm/ttm/ttm_tt.h
+++ b/include/drm/ttm/ttm_tt.h
@@ -296,7 +296,7 @@ long ttm_tt_backup(struct ttm_device *bdev, struct ttm_tt *tt,
 		   const struct ttm_backup_flags flags);
 
 int ttm_tt_restore(struct ttm_device *bdev, struct ttm_tt *tt,
-		   const struct ttm_operation_ctx *ctx);
+		   struct ttm_operation_ctx *ctx);
 
 int ttm_tt_setup_backup(struct ttm_tt *tt);
 

-- 
2.47.3


