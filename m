Return-Path: <linux-kernel+bounces-720482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1EAFBC6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFD9165626
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AD21C9E9;
	Mon,  7 Jul 2025 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6LsP02O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C01EF091
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919480; cv=none; b=ja0qEGK1RxOa+HbH7nAZVe4eTL7Z10rG7QvtgO8GdEzxJHCfsd0vPw41+XIDySiR3niX4rxOX0I5NpCP+A4LlG68g3fZj/OaXllWgt9MQ+MoxCimSoVh/BMk/ehXCWsBvgfc3hMa+mGkVC7GjzxNvSVc46xF5L4WpEPrKC12ofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919480; c=relaxed/simple;
	bh=aIXBmAdWUwNlGVlHhAhauhgJJoZEEe0OuaCVWCLeJUw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MhKD8jI1TMLC38xRYLjNShBWAWV8i0b7S+F5XeU2P/4RXRvL+UJv8MP9OPGkxrCu2hxAxogWkoyJBAPt6GQpJt0R06UxC+p1t4Jb+ktkllOlF7kqURaKzDw1XCSzGGfUV2bbk1m7itDhzNHx+YSlk18SjQ3NpdHq3ZotgyYj3ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6LsP02O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751919477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KYg1WwBoipu4g1+Nb1g7zf334y5ktP9aU+f/eEdv4ak=;
	b=R6LsP02OzwR9yA5va4XW5OSIcVPLy5ItzO6ZhM3wN+KgEMPJwx4gDLNPgVSReBvGGJlIff
	UKJKeyiXeOGy4pwmcmwDoOu5Z0EkyBgrPMp8gO0EhYRwPXTVQEwAR47iJYksgasmgFaQnK
	y6r7SLPtTfcE6rcpJ5FMkW1aFQgrwec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-pwmFryWdO7Gl0WP12CXBbQ-1; Mon,
 07 Jul 2025 16:17:52 -0400
X-MC-Unique: pwmFryWdO7Gl0WP12CXBbQ-1
X-Mimecast-MFC-AGG-ID: pwmFryWdO7Gl0WP12CXBbQ_1751919470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADDB71800287;
	Mon,  7 Jul 2025 20:17:49 +0000 (UTC)
Received: from [10.22.80.10] (unknown [10.22.80.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C83718003FC;
	Mon,  7 Jul 2025 20:17:45 +0000 (UTC)
Date: Mon, 7 Jul 2025 22:17:42 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Dongsheng Yang <dongsheng.yang@linux.dev>
cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, 
    dan.j.williams@intel.com, Jonathan.Cameron@Huawei.com, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
    dm-devel@lists.linux.dev
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_00=2F11=5D_dm-pcache_=E2=80=93_pe?=
 =?UTF-8?Q?rsistent-memory_cache_for_block_devices?=
In-Reply-To: <85b5cb31-b272-305f-8910-c31152485ecf@redhat.com>
Message-ID: <621900fd-1b17-cab3-5c4a-a12631440cd3@redhat.com>
References: <20250707065809.437589-1-dongsheng.yang@linux.dev> <85b5cb31-b272-305f-8910-c31152485ecf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-pcache/backing_dev.c |   14 +++-----------
 drivers/md/dm-pcache/backing_dev.h |    1 -
 drivers/md/dm-pcache/cache.h       |    1 -
 drivers/md/dm-pcache/cache_key.c   |   13 ++-----------
 drivers/md/dm-pcache/dm_pcache.c   |   28 +++++++++++++++++++++++++++-
 drivers/md/dm-pcache/dm_pcache.h   |    3 +++
 6 files changed, 35 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/md/dm-pcache/backing_dev.h
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/backing_dev.h	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/backing_dev.h	2025-07-07 12:14:27.000000000 +0200
@@ -43,7 +43,6 @@ struct pcache_backing_dev {
 	struct pcache_cache		*cache;
 
 	struct dm_dev			*dm_dev;
-	struct kmem_cache		*backing_req_cache;
 	mempool_t			req_pool;
 
 	struct list_head		submit_list;
Index: linux-2.6/drivers/md/dm-pcache/cache.h
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/cache.h	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/cache.h	2025-07-07 12:14:48.000000000 +0200
@@ -102,7 +102,6 @@ struct pcache_cache_subtree {
 struct pcache_cache_tree {
 	struct pcache_cache		*cache;
 	u32				n_subtrees;
-	struct kmem_cache		*key_cache;
 	mempool_t			key_pool;
 	struct pcache_cache_subtree	*subtrees;
 };
Index: linux-2.6/drivers/md/dm-pcache/dm_pcache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/dm_pcache.c	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/dm_pcache.c	2025-07-07 12:23:13.000000000 +0200
@@ -9,6 +9,9 @@
 #include "cache.h"
 #include "dm_pcache.h"
 
+struct kmem_cache *backing_req_cache;
+struct kmem_cache *key_cache;
+
 void pcache_defer_reqs_kick(struct dm_pcache *pcache)
 {
 	struct pcache_cache *cache = &pcache->cache;
@@ -451,13 +454,36 @@ static struct target_type dm_pcache_targ
 
 static int __init dm_pcache_init(void)
 {
-	return dm_register_target(&dm_pcache_target);
+	int r;
+	backing_req_cache = KMEM_CACHE(pcache_backing_dev_req, 0);
+	if (!backing_req_cache) {
+		r = -ENOMEM;
+		goto err0;
+	}
+	key_cache = KMEM_CACHE(pcache_cache_key, 0);
+	if (!key_cache) {
+		r = -ENOMEM;
+		goto err1;
+	}
+	r = dm_register_target(&dm_pcache_target);
+	if (r)
+		goto err2;
+	return 0;
+
+err2:
+	kmem_cache_destroy(key_cache);
+err1:
+	kmem_cache_destroy(backing_req_cache);
+err0:
+	return r;
 }
 module_init(dm_pcache_init);
 
 static void __exit dm_pcache_exit(void)
 {
 	dm_unregister_target(&dm_pcache_target);
+	kmem_cache_destroy(key_cache);
+	kmem_cache_destroy(backing_req_cache);
 }
 module_exit(dm_pcache_exit);
 
Index: linux-2.6/drivers/md/dm-pcache/backing_dev.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/backing_dev.c	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/backing_dev.c	2025-07-07 12:21:27.000000000 +0200
@@ -11,7 +11,6 @@
 static void backing_dev_exit(struct pcache_backing_dev *backing_dev)
 {
 	mempool_exit(&backing_dev->req_pool);
-	kmem_cache_destroy(backing_dev->backing_req_cache);
 }
 
 static void req_submit_fn(struct work_struct *work);
@@ -21,15 +20,9 @@ static int backing_dev_init(struct dm_pc
 	struct pcache_backing_dev *backing_dev = &pcache->backing_dev;
 	int ret;
 
-	backing_dev->backing_req_cache = KMEM_CACHE(pcache_backing_dev_req, 0);
-	if (!backing_dev->backing_req_cache) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = mempool_init_slab_pool(&backing_dev->req_pool, 128, backing_dev->backing_req_cache);
+	ret = mempool_init_slab_pool(&backing_dev->req_pool, 128, backing_req_cache);
 	if (ret)
-		goto cache_destroy;
+		goto err;
 
 	INIT_LIST_HEAD(&backing_dev->submit_list);
 	INIT_LIST_HEAD(&backing_dev->complete_list);
@@ -39,8 +32,7 @@ static int backing_dev_init(struct dm_pc
 	INIT_WORK(&backing_dev->req_complete_work, req_complete_fn);
 
 	return 0;
-cache_destroy:
-	kmem_cache_destroy(backing_dev->backing_req_cache);
+
 err:
 	return ret;
 }
Index: linux-2.6/drivers/md/dm-pcache/cache_key.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/cache_key.c	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/cache_key.c	2025-07-07 12:22:17.000000000 +0200
@@ -836,15 +836,9 @@ int cache_tree_init(struct pcache_cache
 	cache_tree->cache = cache;
 	cache_tree->n_subtrees = n_subtrees;
 
-	cache_tree->key_cache = KMEM_CACHE(pcache_cache_key, 0);
-	if (!cache_tree->key_cache) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	ret = mempool_init_slab_pool(&cache_tree->key_pool, 1024, cache_tree->key_cache);
+	ret = mempool_init_slab_pool(&cache_tree->key_pool, 1024, key_cache);
 	if (ret)
-		goto destroy_key_cache;
+		goto err;
 
 	/*
 	 * Allocate and initialize the subtrees array.
@@ -868,8 +862,6 @@ int cache_tree_init(struct pcache_cache
 
 key_pool_exit:
 	mempool_exit(&cache_tree->key_pool);
-destroy_key_cache:
-	kmem_cache_destroy(cache_tree->key_cache);
 err:
 	return ret;
 }
@@ -896,5 +888,4 @@ void cache_tree_exit(struct pcache_cache
 	}
 	kvfree(cache_tree->subtrees);
 	mempool_exit(&cache_tree->key_pool);
-	kmem_cache_destroy(cache_tree->key_cache);
 }
Index: linux-2.6/drivers/md/dm-pcache/dm_pcache.h
===================================================================
--- linux-2.6.orig/drivers/md/dm-pcache/dm_pcache.h	2025-07-07 12:00:56.000000000 +0200
+++ linux-2.6/drivers/md/dm-pcache/dm_pcache.h	2025-07-07 12:19:42.000000000 +0200
@@ -32,6 +32,9 @@ struct dm_pcache {
 	atomic_t			state;
 };
 
+extern struct kmem_cache *backing_req_cache;
+extern struct kmem_cache *key_cache;
+
 static inline bool pcache_is_stopping(struct dm_pcache *pcache)
 {
 	return (atomic_read(&pcache->state) == PCACHE_STATE_STOPPING);


