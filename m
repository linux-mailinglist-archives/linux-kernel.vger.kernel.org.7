Return-Path: <linux-kernel+bounces-870593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0279C0B362
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798A03B3E31
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474B301006;
	Sun, 26 Oct 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUEHwBwm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440053002A5
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510994; cv=none; b=exh2OMRT0r3l9htPR6EyvL0oka9z8JhIMY4B22dCLjcAp4/rXlR4Pjf0xrhTgiqqsjpc4nGBwD7e4qpJv7MV6MN0EeQhPRH/KMsIfQDRQldTho+/gk1cwdndNFM9B3ICvkntx7qGBgiDiAm1H7rq75tYWCmYgZoVoDOaGy3RbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510994; c=relaxed/simple;
	bh=idCmvwnWfReOd35MC8s7rKZdTVl4Bh6zIiUE7CDDh78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tAUpVg3mxFjgfPvuyenAxTr/N6ykufRJ9usT/yxZg+khCiGiFFbatiAZBH+eP6i+CXJkuH+qCP+SfE7FlXf49S+ue6FfEiSoOISa/+oQ2qgVzzMm0n6PEFtzaT+eIHcln1QLQG6oVVNsb1p4he4FrQSMV9H0J+Cg/pE+VraBDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUEHwBwm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290c2d13a01so28481155ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510991; x=1762115791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8fKQJfeDm6lPLiecQTGQk23fhbVChRxMsUUt63Q0w4=;
        b=uUEHwBwmIjNdKGSTEbuzAVY8+RYy8fnetSxBSn9VEXYHZ8J9uN14bKB9yiXrOdE1SJ
         e/HlKaa3AOxQRdDppBrWC8TPIJKm8RvvGKS7ajN/APrAAKGLPi0s/xaHfAd0XsY/9eG3
         /Vo2hG+eJJzGUe+32RnwrfRdCoXyH+iSVxpEDnthDk11qHwSm77aeUkdl4dk7ncM5qOB
         rmkxX2reNkN+RzlHYNgYBEf7zP9PT6IdbE5q1P//AiMLNrlREhEL+91F8CcJcVuknGpY
         8Kqqa4KN4vhPSI79BhnUzIlm8xmQJyYROi4iALnD1X3k3haRGm9dGZHIDvsyHwLSkndZ
         vjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510991; x=1762115791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8fKQJfeDm6lPLiecQTGQk23fhbVChRxMsUUt63Q0w4=;
        b=ojV0pgM9tbk997juvPgjPW5cJ+kcGD+L31Y8868AAuwCWcEO+vHkdRXYmpVp3PI3FU
         dSDXQ76acaNKC/NFqFbxTyW42fX8pZ7+QHbyAPBlp6kr5TTJF0TjKyXDbnsSRAT5xrkt
         qEAgC/6OqDbLEdKyNPoLJRUbQo+J79t4u0aqNi3GRrkgjBhB47cZJjLV9Odse3ZG+SAq
         DJ4xRKcIaXgrsxHu3AGU4YhqkZ7wJKirDe3ZQ4ne4NCjkM8GAFT5zsni8KCa4Im+eoFA
         9DzXi4ya1TCnyQMaHgSX+ScLZfxDDp1DMuWQu6dwUr4mvbPArtXDjzGkbVAUyDREUbVL
         Jenw==
X-Forwarded-Encrypted: i=1; AJvYcCWn5p9BvYwCZPrGX1vq0kygLfZvav9giQoTGqJK13UjJ+mXXuSVZhtAQ1NQe+ryIcErrk2khJ5WxYasfVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3fKQnYroO2ZWVKFtGmqAXihz6V9MKqO1G64Vz0tTPOCh7vmF
	CnItqQBDq+Q9XFEHccV2+ieI/pILGX2qodSkHPRyckP75lVMQix21CX82U86Qpsk8cGzjLBR7V5
	VCm9vQg==
X-Google-Smtp-Source: AGHT+IF0KfskSdKLpVux68qy5bYP7cU8OOYanXrqoLeO8zCN1YVKm99EcrKefxwR8RyvHyXu3BZDAiNrGaY=
X-Received: from plgs4.prod.google.com ([2002:a17:902:ea04:b0:268:eb:3b3b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64b:b0:274:506d:7fcc
 with SMTP id d9443c01a7336-29489d71137mr117673365ad.6.1761510990611; Sun, 26
 Oct 2025 13:36:30 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:10 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-8-surenb@google.com>
Subject: [PATCH v2 7/8] mm: introduce GCMA
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Minchan Kim <minchan@google.com>

This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
cleacache backend which reserves some amount of memory at the boot
and then donates it to store clean file-backed pages in the cleancache.
GCMA aims to guarantee contiguous memory allocation success as well as
low and deterministic allocation latency.

Notes:
Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
Later Minchan reworked it to be used in Android as a reference for
Android vendors to use [2].

[1] https://lwn.net/Articles/619865/
[2] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS          |   2 +
 include/linux/gcma.h |  36 +++++++
 mm/Kconfig           |  15 +++
 mm/Makefile          |   1 +
 mm/gcma.c            | 244 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 298 insertions(+)
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/gcma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3aabed281b71..40de200d1124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16384,6 +16384,7 @@ F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
 F:	include/linux/cma.h
 F:	include/linux/dmapool.h
+F:	include/linux/gcma.h
 F:	include/linux/ioremap.h
 F:	include/linux/memory-tiers.h
 F:	include/linux/page_idle.h
@@ -16395,6 +16396,7 @@ F:	mm/dmapool.c
 F:	mm/dmapool_test.c
 F:	mm/early_ioremap.c
 F:	mm/fadvise.c
+F:	mm/gcma.c
 F:	mm/ioremap.c
 F:	mm/mapping_dirty_helpers.c
 F:	mm/memory-tiers.c
diff --git a/include/linux/gcma.h b/include/linux/gcma.h
new file mode 100644
index 000000000000..20b2c85de87b
--- /dev/null
+++ b/include/linux/gcma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GCMA_H__
+#define __GCMA_H__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_GCMA
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count);
+
+/*
+ * NOTE: allocated pages are still marked reserved and when freeing them
+ * the caller should ensure they are isolated and not referenced by anyone
+ * other than the caller.
+ */
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp);
+int gcma_free_range(unsigned long start_pfn, unsigned long count);
+
+#else /* CONFIG_GCMA */
+
+static inline int gcma_register_area(const char *name,
+				     unsigned long start_pfn,
+				     unsigned long count)
+		{ return -EOPNOTSUPP; }
+static inline int gcma_alloc_range(unsigned long start_pfn,
+				   unsigned long count, gfp_t gfp)
+		{ return -EOPNOTSUPP; }
+
+static inline int gcma_free_range(unsigned long start_pfn,
+				   unsigned long count)
+		{ return -EOPNOTSUPP; }
+
+#endif /* CONFIG_GCMA */
+
+#endif /* __GCMA_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index e1a169d5e5de..3166fde83340 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1097,6 +1097,21 @@ config CMA_AREAS
 
 	  If unsure, leave the default value "8" in UMA and "20" in NUMA.
 
+config GCMA
+       bool "GCMA (Guaranteed Contiguous Memory Allocator)"
+       depends on CLEANCACHE
+	help
+	  This enables the Guaranteed Contiguous Memory Allocator to allow
+	  low latency guaranteed contiguous memory allocations. Memory
+	  reserved by GCMA is donated to cleancache to be used as pagecache
+	  extension. Once GCMA allocation is requested, necessary pages are
+	  taken back from the cleancache and used to satisfy the request.
+	  Cleancache guarantees low latency successful allocation as long
+	  as the total size of GCMA allocations does not exceed the size of
+	  the memory donated to the cleancache.
+
+	  If unsure, say "N".
+
 #
 # Select this config option from the architecture Kconfig, if available, to set
 # the max page order for physically contiguous allocations.
diff --git a/mm/Makefile b/mm/Makefile
index 845841a140e3..05aee66a8b07 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_CLEANCACHE_SYSFS)	+= cleancache_sysfs.o
+obj-$(CONFIG_GCMA)	+= gcma.o
diff --git a/mm/gcma.c b/mm/gcma.c
new file mode 100644
index 000000000000..b86f82b8fe9d
--- /dev/null
+++ b/mm/gcma.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GCMA (Guaranteed Contiguous Memory Allocator)
+ *
+ */
+
+#define pr_fmt(fmt) "gcma: " fmt
+
+#include <linux/cleancache.h>
+#include <linux/gcma.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include "internal.h"
+
+#define MAX_GCMA_AREAS		64
+#define GCMA_AREA_NAME_MAX_LEN	32
+
+struct gcma_area {
+	int pool_id;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	char name[GCMA_AREA_NAME_MAX_LEN];
+};
+
+static struct gcma_area areas[MAX_GCMA_AREAS];
+static atomic_t nr_gcma_area = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(gcma_area_lock);
+
+static int free_folio_range(struct gcma_area *area,
+			     unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		err = cleancache_backend_put_folio(area->pool_id, pfn_folio(pfn));
+		if (err) {
+			pr_warn("PFN %lu: folio is still in use\n", pfn);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int alloc_folio_range(struct gcma_area *area,
+			      unsigned long start_pfn, unsigned long end_pfn,
+			      gfp_t gfp)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		err = cleancache_backend_get_folio(area->pool_id, pfn_folio(pfn));
+		if (err) {
+			free_folio_range(area, start_pfn, pfn);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct gcma_area *find_area(unsigned long start_pfn, unsigned long end_pfn)
+{
+	int nr_area = atomic_read_acquire(&nr_gcma_area);
+	int i;
+
+	for (i = 0; i < nr_area; i++) {
+		struct gcma_area *area = &areas[i];
+
+		if (area->end_pfn <= start_pfn)
+			continue;
+
+		if (area->start_pfn > end_pfn)
+			continue;
+
+		/* The entire range should belong to a single area */
+		if (start_pfn < area->start_pfn || end_pfn > area->end_pfn)
+			break;
+
+		/* Found the area containing the entire range */
+		return area;
+	}
+
+	return NULL;
+}
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count)
+{
+	LIST_HEAD(folios);
+	int i, pool_id;
+	int nr_area;
+	int ret = 0;
+
+	pool_id = cleancache_backend_register_pool(name);
+	if (pool_id < 0)
+		return pool_id;
+
+	for (i = 0; i < count; i++) {
+		struct folio *folio;
+
+		folio = pfn_folio(start_pfn + i);
+		folio_clear_reserved(folio);
+		folio_set_count(folio, 0);
+		list_add(&folio->lru, &folios);
+	}
+
+	cleancache_backend_put_folios(pool_id, &folios);
+
+	spin_lock(&gcma_area_lock);
+
+	nr_area = atomic_read(&nr_gcma_area);
+	if (nr_area < MAX_GCMA_AREAS) {
+		struct gcma_area *area = &areas[nr_area];
+
+		area->pool_id = pool_id;
+		area->start_pfn = start_pfn;
+		area->end_pfn = start_pfn + count;
+		strscpy(area->name, name);
+		/* Ensure above stores complete before we increase the count */
+		atomic_set_release(&nr_gcma_area, nr_area + 1);
+	} else {
+		ret = -ENOMEM;
+	}
+
+	spin_unlock(&gcma_area_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gcma_register_area);
+
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	struct folio *folio;
+	int err, order = 0;
+
+	gfp = current_gfp_context(gfp);
+	if (gfp & __GFP_COMP) {
+		if (!is_power_of_2(count))
+			return -EINVAL;
+
+		order = ilog2(count);
+		if (order >= MAX_PAGE_ORDER)
+			return -EINVAL;
+	}
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	err = alloc_folio_range(area, start_pfn, end_pfn, gfp);
+	if (err)
+		return err;
+
+	/*
+	 * GCMA returns pages with refcount 1 and expects them to have
+	 * the same refcount 1 when they are freed.
+	 */
+	if (order) {
+		folio = pfn_folio(start_pfn);
+		post_alloc_hook(&folio->page, order, gfp);
+		set_page_refcounted(&folio->page);
+		prep_compound_page(&folio->page, order);
+	} else {
+		for (unsigned long pfn = start_pfn; pfn < end_pfn; pfn++) {
+			folio = pfn_folio(pfn);
+			post_alloc_hook(&folio->page, order, gfp);
+			set_page_refcounted(&folio->page);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gcma_alloc_range);
+
+int gcma_free_range(unsigned long start_pfn, unsigned long count)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	unsigned long pfn;
+	int err = -EINVAL;
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	/* First pass checks and drops folio refcounts */
+	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct folio *folio = pfn_folio(pfn);
+		unsigned long nr_pages = folio_nr_pages(folio);
+
+		if (pfn + nr_pages > end_pfn) {
+			end_pfn = pfn;
+			goto error;
+
+		}
+		if (!folio_ref_dec_and_test(folio)) {
+			end_pfn = pfn + nr_pages;
+			goto error;
+		}
+		pfn += nr_pages;
+	}
+
+	/* Second pass prepares the folios */
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		struct folio *folio = pfn_folio(pfn);
+
+		free_pages_prepare(&folio->page, folio_order(folio));
+		pfn += folio_nr_pages(folio);
+	}
+
+	err = free_folio_range(area, start_pfn, end_pfn);
+	if (!err)
+		return 0;
+
+error:
+	/* Restore folio refcounts */
+	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct folio *folio = pfn_folio(pfn);
+
+		folio_ref_inc(folio);
+		pfn += folio_nr_pages(folio);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(gcma_free_range);
-- 
2.51.1.851.g4ebd6896fd-goog


