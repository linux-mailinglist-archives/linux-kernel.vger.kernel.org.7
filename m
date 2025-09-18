Return-Path: <linux-kernel+bounces-823582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0644B86E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2733ADFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337AE31D72E;
	Thu, 18 Sep 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CcC1IRdg"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366E2D3756
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227116; cv=none; b=Hf8SOhhuV6JZ4EtUFJjh30IUYRfYBIB2hM7AAFVwE+kuOIUCk4pZY8MgA2OUJ6gasV5WGfOoaEv+AXlOSW7Jb+Wst1vz8mvS2mLirkPrPTWjwDKjmav84OKo3bXlF+oyiddL60JPEtICQQ4mEqX9DPEQDF02EES9wWuKttKasJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227116; c=relaxed/simple;
	bh=9aV22t7bk0UoXv46bvhEAZ57WjI7exArwzm9mKqjLrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGuXxB5VwctqZjbmAqwKdIHnYglnCxOIR/33CmmyN7y6cYBoASqZNe+73Hbga7aEU7FzDmKwz7kDLLAGK+rPZvX7M3df6DqOQXKsGfue8X+AqeubjOvxTV34rw+5HI3285+r9YRn5RQz9/icBSw2CYKI39K+WdsLfIyK26+8w1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CcC1IRdg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ViZFP+fI0QUjz41MCfkYglrEpSnPBiVf0zcZpjHQNag=; b=CcC1IRdgN/vL0VAeTkcmPM5Bie
	EUDpdBKBACIc7ceGeW2cLgHijzkek/V8CAUBbJWqTPL76EELT+Op32ZkUDvisHTSspAigPu2ruE1y
	kctGVOBiovJRF1MZvrHdHajqhRxu6uK2Th3Mk+5Jevx4Bi0BRtAwTyOX3E27xKvbbGuQqJMcODIy6
	Yel7B4n+EcnReL22baVazXCHGI/ZcuIbrNU5Fhg1bcOYAInTvqpNyJtobe3/WhQA2e9UBcP4Fi5w1
	AResCDeZX3VPYxUMoU7cIoE7lWwSrZEHyGQ3y+k4abP7P61RAz7dBIIp1zWO55nOQ1G3M5WAdj+7f
	GZxHcWgA==;
Received: from 179-125-87-227-dinamico.pombonet.net.br ([179.125.87.227] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uzLBl-00Dp3q-01; Thu, 18 Sep 2025 22:25:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 18 Sep 2025 17:09:24 -0300
Subject: [PATCH RFC v2 1/3] ttm: pool: allow requests to prefer latency
 over throughput
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ttm_pool_no_direct_reclaim-v2-1-135294e1f8a2@igalia.com>
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

The TTM pool allocator prefer to allocate higher order pages such that the
GPU will spend less time walking page tables and provide better throughput.

There were cases where too much fragmented memory led to a 30% change in
the throughput of a given GPU workload on a datacenter.

On a desktop workload on a low-memory system, though, allocating such
higher order pages might put the system under memory pressure, triggering
direct reclaim and leading to latency in certain desktop operations, while
allocating lower order pages would be possible and avoid such reclaims.

This was seen on ChromeOS when opening multiple tabs and switching
desktops, leading to high latency in such operations.

Add an option to the ttm operation context that allows the behavior to be
set system wide or per TTM object.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +++++++----
 include/drm/ttm/ttm_bo.h       |  5 +++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index baf27c70a4193a121fbc8b4e67cd6feb4c612b85..02c622a103fcece003bd70ce6b5833ada70f5228 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -133,7 +133,8 @@ static DECLARE_RWSEM(pool_shrink_rwsem);
 
 /* Allocate pages of size 1 << order with the given gfp_flags */
 static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
-					unsigned int order)
+					unsigned int order,
+					const struct ttm_operation_ctx *ctx)
 {
 	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
 	struct ttm_pool_dma *dma;
@@ -144,9 +145,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 * Mapping pages directly into an userspace process and calling
 	 * put_page() on a TTM allocated page is illegal.
 	 */
-	if (order)
+	if (order) {
 		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
 			__GFP_THISNODE;
+		if (ctx->alloc_method == ttm_op_alloc_latency)
+			gfp_flags &= ~__GFP_DIRECT_RECLAIM;
+	}
 
 	if (!pool->use_dma_alloc) {
 		p = alloc_pages_node(pool->nid, gfp_flags, order);
@@ -745,7 +749,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		if (!p) {
 			page_caching = ttm_cached;
 			allow_pools = false;
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
+			p = ttm_pool_alloc_page(pool, gfp_flags, order, ctx);
 		}
 		/* If that fails, lower the order if possible and retry. */
 		if (!p) {
@@ -815,7 +819,6 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		return -EINVAL;
 
 	ttm_pool_alloc_state_init(tt, &alloc);
-
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, NULL);
 }
 EXPORT_SYMBOL(ttm_pool_alloc);
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 479b7ed075c0ffba21df971db7fef914c531a51d..8531f8e8bb9b079927d0e4759a12819303542f62 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -184,6 +184,11 @@ struct ttm_operation_ctx {
 	bool no_wait_gpu;
 	bool gfp_retry_mayfail;
 	bool allow_res_evict;
+	enum {
+		ttm_op_alloc_default = 0,
+		ttm_op_alloc_latency = 2,
+		ttm_op_alloc_throughput = 3,
+	} alloc_method;
 	struct dma_resv *resv;
 	uint64_t bytes_moved;
 };

-- 
2.47.3


