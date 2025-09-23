Return-Path: <linux-kernel+bounces-828771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EEAB956BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DA82A45FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846131A057;
	Tue, 23 Sep 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="DXTz7jYg";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="uGFQgpd6"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0830FC11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623219; cv=none; b=KBH0ysQUxBFetTtuN8BVGiLrSu9ZqHzegVDyi3LRmSHpQXuZJ2aHogFnq7jDhlpZaJkuCWrENTc7ssf6Fcx84VcUdKSrv9luZdqIHXXD1uoNHxZRtVyRghZG85eOOE5I8VtnmaAOz5Kp7kot7vg9KDLfXugjx30VFzTtls480oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623219; c=relaxed/simple;
	bh=lexME5xiRnlFvBAZAYYNpzBxakwPchqRRKI2vv363nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5PrAHrMB59E7AMyczF0ZyXRyxXpCRUjp6UteDWaN7k86sw71UOR0TgHO37KPDNiAqbUpRtTj8zxz35/w10C18vXWZ7m/RjqT9eDOs3p5RYelpozhAwXndR0w2obLNfG2xRjdXArdyY+WBBs48fd2E2HwX9+zq5/jb51bnp/rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=DXTz7jYg; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=uGFQgpd6; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758623215; x=1759228015;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=B+mZt7xruU+QP/Nwj+csH0sZ/ySlSkT50GF0tvBG2TE=;
	b=DXTz7jYgLSFsNr4RsIpEeG7VpMABTQEddKwBcLGoz0TEGKfiJulhgf6DJlbvyIwl2Y0icanXN4qv0
	 mol3XpMiF1AbACWm6V1TBODgd9kRw2rGskTucsjfUcIVjiN3pIw14JH0dsFv6SPaX8lBNylzA0P56F
	 /E9n7ajZ/KqpCRY0zfziRajo1Pw+vXAcu7udV/LG9N9J1z7+MAE7ngO/Di4F+CAWreSLtdaFws2zui
	 5yvemFAoUz90q02wNz6QQWiQ696J33NhpEMPPUS6+9XZMCzhiDt2le6Hy2pD6WnO/CeS73auyaslV1
	 FJ5bSxUiKcFAwheNQP79A9ztEIoafMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1758623215; x=1759228015;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=B+mZt7xruU+QP/Nwj+csH0sZ/ySlSkT50GF0tvBG2TE=;
	b=uGFQgpd63w8k2HljT2aOzUlAcxhwA3noCuRb3GRsqK31z5gbjb4ngxIHHpoTPULYXufD2gSoodEPu
	 3jaouc/DQ==
X-HalOne-ID: d28f22ef-9867-11f0-843f-494313b7f784
Received: from localhost.localdomain (host-95-203-13-255.mobileonline.telia.com [95.203.13.255])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id d28f22ef-9867-11f0-843f-494313b7f784;
	Tue, 23 Sep 2025 10:26:54 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v6 1/2] mm: reinstate zpool as a thin API
Date: Tue, 23 Sep 2025 12:26:50 +0200
Message-Id: <20250923102650.2551106-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
References: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the removal of the zpool layer the opportunity to select an allocation
backend for zswap has been completely lost. While the flexibility zpool
used to provide may have seemed unjustified, the option to select an
alternative backend should still exist, especially with the recent
advancements in the vmap/vmalloc field that allow for faster and simple
allocation backends. This patch reinstates zpool API as a thin header-only
layer and provides the infrastructure for backend compile time selection.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 Documentation/admin-guide/mm/zswap.rst | 14 +++---
 MAINTAINERS                            |  1 +
 include/linux/zpool.h                  | 62 ++++++++++++++++++++++++++
 mm/Kconfig                             | 22 ++++++++-
 mm/zsmalloc.c                          |  3 ++
 mm/zswap.c                             | 30 ++++++-------
 6 files changed, 110 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/zpool.h

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 283d77217c6f..44075d35e512 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -53,16 +53,20 @@ Zswap receives pages for compression from the swap subsystem and is able to
 evict pages from its own compressed pool on an LRU basis and write them back to
 the backing swap device in the case that the compressed pool is full.
 
-Zswap makes use of zsmalloc for the managing the compressed memory pool.  Each
-allocation in zsmalloc is not directly accessible by address.  Rather, a handle is
+Zswap makes use of zpool API for the managing the compressed memory pool. Each
+allocation in zpool is not directly accessible by address. Rather, a handle is
 returned by the allocation routine and that handle must be mapped before being
 accessed.  The compressed memory pool grows on demand and shrinks as compressed
-pages are freed.  The pool is not preallocated.
+pages are freed. The pool is not preallocated.
+
+An allocator backend implementing zpool API can be selected during the build
+time as a kernel configuration option. Currently only one backend (zsmalloc) is
+supported and it is selected automatically.
 
 When a swap page is passed from swapout to zswap, zswap maintains a mapping
 of the swap entry, a combination of the swap type and swap offset, to the
-zsmalloc handle that references that compressed swap page.  This mapping is
-achieved with a red-black tree per swap type.  The swap offset is the search
+zpool handle that references that compressed swap page.  This mapping is
+achieved with a red-black tree per swap type. The swap offset is the search
 key for the tree nodes.
 
 During a page fault on a PTE that is a swap entry, the swapin code calls the
diff --git a/MAINTAINERS b/MAINTAINERS
index ca8e3d18eedd..149a06be4000 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27885,6 +27885,7 @@ R:	Chengming Zhou <chengming.zhou@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/zswap.rst
+F:	include/linux/zpool.h
 F:	include/linux/zswap.h
 F:	mm/zswap.c
 F:	tools/testing/selftests/cgroup/test_zswap.c
diff --git a/include/linux/zpool.h b/include/linux/zpool.h
new file mode 100644
index 000000000000..05406b00d734
--- /dev/null
+++ b/include/linux/zpool.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * zpool memory storage api
+ *
+ * Copyright (C) 2014 Dan Streetman
+ *
+ * This is a common frontend for the zswap compressed memory storage
+ * implementations.
+ */
+
+#ifndef _ZPOOL_H_
+#define _ZPOOL_H_
+
+struct zpool {
+	void *pool;
+};
+
+struct zpool *zpool_create_pool(const char *name);
+void zpool_destroy_pool(struct zpool *pool);
+unsigned long  zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp, const int nid);
+void zpool_free(struct zpool *pool, unsigned long handle);
+void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle, void *local_copy);
+void zpool_obj_read_end(struct zpool *zpool, unsigned long handle, void *handle_mem);
+void zpool_obj_write(struct zpool *zpool, unsigned long handle, void *handle_mem, size_t mem_len);
+u64 zpool_get_total_pages(struct zpool *zpool);
+
+#define DECLARE_ZPOOL(prefix) \
+	struct zpool *zpool_create_pool(const char *name) \
+	{ \
+		return (struct zpool *) prefix ## _create_pool(name); \
+	} \
+	void zpool_destroy_pool(struct zpool *pool) \
+	{ \
+		return prefix ## _destroy_pool(pool->pool); \
+	} \
+	unsigned long  zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp, const int nid) \
+	{ \
+		return prefix ## _malloc(pool->pool, size, gfp, nid); \
+	} \
+	void zpool_free(struct zpool *pool, unsigned long handle) \
+	{ \
+		return prefix ## _free(pool->pool, handle); \
+	} \
+	void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle, void *local_copy) \
+	{ \
+		return prefix ## _obj_read_begin(zpool->pool, handle, local_copy); \
+	} \
+	void zpool_obj_read_end(struct zpool *zpool, unsigned long handle, void *handle_mem) \
+	{ \
+		return prefix ## _obj_read_end(zpool->pool, handle, handle_mem); \
+	} \
+	void zpool_obj_write(struct zpool *zpool, unsigned long handle, \
+		     void *handle_mem, size_t mem_len) \
+	{ \
+		prefix ## _obj_write(zpool->pool, handle, handle_mem, mem_len); \
+	} \
+	u64 zpool_get_total_pages(struct zpool *zpool) \
+	{ \
+		return prefix ## _get_total_pages(zpool->pool); \
+	}
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index d1ed839ca710..f72483b91098 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -23,7 +23,7 @@ config ZSWAP
 	bool "Compressed cache for swap pages"
 	depends on SWAP
 	select CRYPTO
-	select ZSMALLOC
+	select ZPOOL_ALLOCATOR
 	help
 	  A lightweight compressed cache for swap pages.  It takes
 	  pages that are in the process of being swapped out and attempts to
@@ -122,8 +122,26 @@ config ZSWAP_COMPRESSOR_DEFAULT
        default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
        default ""
 
+config ZPOOL_ALLOCATOR
+	bool
+
+choice
+	prompt "Allocator for zswap"
+	default ZSMALLOC
+	help
+	  Allocator to be used for compressed object storage in zswap.
+	  Currently only zsmalloc is supported.
+
 config ZSMALLOC
-	tristate
+	bool "N:1 compression allocator (zsmalloc)"
+	select ZPOOL_ALLOCATOR
+	depends on MMU
+	help
+	  zsmalloc is a slab-based memory allocator designed to store
+	  pages of various compression levels efficiently. It achieves
+	  the highest storage density with the least amount of fragmentation.
+
+endchoice
 
 if ZSMALLOC
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5bf832f9c05c..c84e96fd30f9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
+#include <linux/zpool.h>
 #include <linux/fs.h>
 #include <linux/workqueue.h>
 #include "zpdesc.h"
@@ -432,6 +433,8 @@ static void record_obj(unsigned long handle, unsigned long obj)
 	*(unsigned long *)handle = obj;
 }
 
+DECLARE_ZPOOL(zs);
+
 static inline bool __maybe_unused is_first_zpdesc(struct zpdesc *zpdesc)
 {
 	return PagePrivate(zpdesc_page(zpdesc));
diff --git a/mm/zswap.c b/mm/zswap.c
index c1af782e54ec..a567cc16b9a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -34,7 +34,7 @@
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
 #include <linux/list_lru.h>
-#include <linux/zsmalloc.h>
+#include <linux/zpool.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -151,7 +151,7 @@ struct crypto_acomp_ctx {
  * needs to be verified that it's still valid in the tree.
  */
 struct zswap_pool {
-	struct zs_pool *zs_pool;
+	struct zpool *pool;
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
 	struct percpu_ref ref;
 	struct list_head list;
@@ -257,8 +257,8 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
-	pool->zs_pool = zs_create_pool(name);
-	if (!pool->zs_pool)
+	pool->pool = zpool_create_pool(name);
+	if (!pool->pool)
 		goto error;
 
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
@@ -295,8 +295,8 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
-	if (pool->zs_pool)
-		zs_destroy_pool(pool->zs_pool);
+	if (pool->pool)
+		zpool_destroy_pool(pool->pool);
 	kfree(pool);
 	return NULL;
 }
@@ -327,7 +327,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
 
-	zs_destroy_pool(pool->zs_pool);
+	zpool_destroy_pool(pool->pool);
 	kfree(pool);
 }
 
@@ -454,7 +454,7 @@ unsigned long zswap_total_pages(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		total += zs_get_total_pages(pool->zs_pool);
+		total += zpool_get_total_pages(pool->pool);
 	rcu_read_unlock();
 
 	return total;
@@ -717,7 +717,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	zpool_free(entry->pool->pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -907,13 +907,13 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	}
 
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
-	handle = zs_malloc(pool->zs_pool, dlen, gfp, page_to_nid(page));
+	handle = zpool_malloc(pool->pool, dlen, gfp, page_to_nid(page));
 	if (IS_ERR_VALUE(handle)) {
 		alloc_ret = PTR_ERR((void *)handle);
 		goto unlock;
 	}
 
-	zs_obj_write(pool->zs_pool, handle, dst, dlen);
+	zpool_obj_write(pool->pool, handle, dst, dlen);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -940,7 +940,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	u8 *src, *obj;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
-	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
+	obj = zpool_obj_read_begin(pool->pool, entry->handle, acomp_ctx->buffer);
 
 	/* zswap entries of length PAGE_SIZE are not compressed. */
 	if (entry->length == PAGE_SIZE) {
@@ -949,7 +949,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	}
 
 	/*
-	 * zs_obj_read_begin() might return a kmap address of highmem when
+	 * zpool_obj_read_begin() might return a kmap address of highmem when
 	 * acomp_ctx->buffer is not used.  However, sg_init_one() does not
 	 * handle highmem addresses, so copy the object to acomp_ctx->buffer.
 	 */
@@ -969,7 +969,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	dlen = acomp_ctx->req->dlen;
 
 read_done:
-	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
+	zpool_obj_read_end(pool->pool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
 	if (!decomp_ret && dlen == PAGE_SIZE)
@@ -1486,7 +1486,7 @@ static bool zswap_store_page(struct page *page,
 	return true;
 
 store_failed:
-	zs_free(pool->zs_pool, entry->handle);
+	zpool_free(pool->pool, entry->handle);
 compress_failed:
 	zswap_entry_cache_free(entry);
 	return false;
-- 
2.39.2


