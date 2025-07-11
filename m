Return-Path: <linux-kernel+bounces-726698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94DB01023
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C8D48140A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122DC946F;
	Fri, 11 Jul 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D9Z+absR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B584A28
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193426; cv=none; b=IOp+rBXLe5S8j/O56qEUiHFL+FSnEaDltrCgWb7lFFw4iCaKD+zUKmMU+YL5j0Lv5IF9/VdiHWRR8Nv8CpY4rHiI4yB4aqrMQuGtM7mwz8WoisN1V7KU7oQ83RhaprlVreNUynb7SKPk0NMbRzI3vh88AkXawks4G4VjZsPA/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193426; c=relaxed/simple;
	bh=n8H4a1S5PnlnPNlgs3zqAFYwZbnlypbXL9Hiei6TzZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C4iNzFYIptg15XLz0moHpNzKEHVgnMWy4RM8J4y16KG2UWcGVQflpB9bPTqm2qb13+70YQmYoSqB8gn6Ok50HZfN5CyMGmUDXLFKtF6KeraucoT+fTRJ1kfdF2ACHRP7iJyr/Sjco/J9+9wEZM3qbwAZxa1yJChDOJYxi1xV+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D9Z+absR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef29524fso1864955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752193422; x=1752798222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VpKL4Lr9lJYqhz/bcIZyuWD+5Yiwyuqv6Dq41oGuJ5w=;
        b=D9Z+absR2hAIRz9HuYsJsOntt9nxrmoKwR1q9lkYnssc8e0XpwbYnJr6pv4lxZDbiF
         febgA4pkUXiBfvEeMoxqHlavMCeQXor9r52BJiZ0fRRDy/dROea+dFnq+hYjy7n/XWTo
         l6JeM/9QUwBRbR0ONrLUWK7NVguCkavPl9gJDFwyAWT6FVjcbs71xtx3aT1estblQZaw
         5/QqOOveCazP18I+xzHu5Zp1OIoPAdNBdJu4k05FCTDSdbVCmO69x+jMwdN6itBsdDJF
         fSgpzJ2BDTDvm3gP4ox8PR3b0KxvI57+OYPpZrSZLGulKQWfKySeH55SJB5HWuG2adHX
         kNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752193422; x=1752798222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpKL4Lr9lJYqhz/bcIZyuWD+5Yiwyuqv6Dq41oGuJ5w=;
        b=IabZbw2xaXYsYSLxFBvws5Jv/G3yghDl3YJaaftc1MxB+EWxO7WAUxDSTeC8jRURnG
         GlBZQRHi69ap9bdUk4pNM0/SgSIH0JSj5cQBiFJvdSWjcPT6/bedMGsAHcj/5tatxrS2
         5+epKzwyWL6KImQLLNXtZmeiMtnRE+tRPdrDoVgLmzDFXE1Ypv9s4Otw4FobjyB69aTG
         E5P4zPrPfujY+6lJyHxcO9xGbIcYMsaRUUknsGGVkmbNYIMKsZe/PdslLIFNUd57oSOd
         4ZGmOzoWGWxh7OTdE41+8r8DcuzT8r2+oWKMa1vbuJg3GW4Yuj6968SAEK0y9Mvn9HqZ
         b6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUtA8LNFJLsbNqleaqy890o9urTFaRe5vHGKWISLnWDCzADIKSCA9E4Mpw5bernuxEG9lka61WnBxhQ7QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg60sGwKt54ygq7YFLNqgPPvdXh6xVTbNgd3gcdENYtLMMFpt6
	BFCBHd82rcEmIPlQxbeg3IzoqGluI68nNr7kGAeH6TVVk9e00cl7yirRy6d1YcKp95M=
X-Gm-Gg: ASbGncuqe7F255k15fBmysJtPxzFzzsQ+0ZPYXjPvlllTvqAVbBu1WHf/nynMhJWYpq
	s559P+ABja9jlZlDikb4BZZOF8W/IxTIRDTElURyj8iDcdBpt4bFTmk9Csw833OHFb1rZ56ck/q
	7193I23mdUzyNoBrLftwZT8i1ekGcgl3NL9ul2uG1S944seJ3EkunJ1H8JYIjNstbLudLwntkSX
	3BQE7kqwDy+7TrTHQ/fnl+MnfYazpPh1+FYelpppU1oA/usfl/Ak98paf04rNVk3unZ02Q6tmdu
	G5oFOvJG1LgOaTakNb76pZ5ypykGnN2y2njfrXnijSx8yczOhA62FZEMc3e7XF+NkxZ+oP0m+dp
	FJhIld2q8LRnB5UrT0lVuFNxA7acJklZ9L5HT7dH3lg==
X-Google-Smtp-Source: AGHT+IGe7tsbgRE+IJwc7kAz6u5dCKZoWA5wX6lbInccD12yyxOY+GM8OVHbAP/fh3Q6DuYbjuJ5mQ==
X-Received: by 2002:a17:903:41c4:b0:235:f1e4:3381 with SMTP id d9443c01a7336-23dede4e7b5mr5325275ad.8.1752193422279;
        Thu, 10 Jul 2025 17:23:42 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([2620:125:9007:640:ffff::5458])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4284898sm33601555ad.24.2025.07.10.17.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 17:23:41 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: akpm@linux-foundation.org,
	surenb@google.com
Cc: kent.overstreet@linux.dev,
	corbet@lwn.net,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	yzhong@purestorage.com,
	souravpanda@google.com,
	00107082@163.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH v3] alloc_tag: add per-NUMA node stats
Date: Thu, 10 Jul 2025 18:23:22 -0600
Message-Id: <20250711002322.1303421-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds per-NUMA node breakdown of memory allocation,
enabling more precise visibility into memory usage patterns across nodes.
It is particularly valuable in cloud environments,
where tracking asymmetric memory usage and identifying NUMA imbalances
down to the allocation caller helps optimize memory efficiency, avoid
CPU stranding, and improve system responsiveness under memory pressure.

As implementation, it adds per-NUMA node statistics in /proc/allocinfo.
Previously, each alloc_tag had a single set of counters (bytes and
calls), aggregated across all CPUs. With this change, each CPU can
maintain separate counters for each NUMA node, allowing finer-grained
memory allocation profiling.

This feature is controlled by the new
CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS option:

* When enabled (=y), the output includes per-node statistics following
  the total bytes/calls:

<size> <calls> <tag info>
...
315456       9858     mm/dmapool.c:338 func:pool_alloc_page
        nid0     94912        2966
        nid1     220544       6892
7680         60       mm/dmapool.c:254 func:dma_pool_create
        nid0     4224         33
        nid1     3456         27

* When disabled (=n), the output remains unchanged:
<size> <calls> <tag info>
...
315456       9858     mm/dmapool.c:338 func:pool_alloc_page
7680         60       mm/dmapool.c:254 func:dma_pool_create

To minimize memory overhead, per-NUMA stats counters are dynamically
allocated using the percpu allocator. PERCPU_DYNAMIC_RESERVE has been
increased to ensure sufficient space for in-kernel alloc_tag counters.

For in-kernel alloc_tag instances, pcpu_alloc_noprof() is used to
allocate counters. These allocations are excluded from the profiling
statistics themselves.

Link: https://lore.kernel.org/all/20250610233053.973796-1-cachen@purestorage.com
Link: https://lore.kernel.org/all/20250530003944.2929392-1-cachen@purestorage.com
Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Sourav Panda <souravpanda@google.com>
---
 Documentation/mm/allocation-profiling.rst |  3 ++
 include/linux/alloc_tag.h                 | 52 ++++++++++++++++------
 include/linux/codetag.h                   |  4 ++
 include/linux/percpu.h                    |  2 +-
 lib/Kconfig.debug                         |  7 +++
 lib/alloc_tag.c                           | 54 ++++++++++++++++++++---
 mm/page_alloc.c                           | 35 ++++++++-------
 mm/percpu.c                               |  8 +++-
 mm/show_mem.c                             | 25 ++++++++---
 mm/slub.c                                 | 11 +++--
 10 files changed, 150 insertions(+), 51 deletions(-)

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
index 316311240e6a..13d1d0cb91bf 100644
--- a/Documentation/mm/allocation-profiling.rst
+++ b/Documentation/mm/allocation-profiling.rst
@@ -17,6 +17,9 @@ kconfig options:
   adds warnings for allocations that weren't accounted because of a
   missing annotation
 
+- CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS
+  adds memory allocation profiling stats for each numa node, off by default.
+
 Boot parameter:
   sysctl.vm.mem_profiling={0|1|never}[,compressed]
 
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 9ef2633e2c08..f714f1a436ec 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -15,6 +15,12 @@
 #include <linux/static_key.h>
 #include <linux/irqflags.h>
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS
+#define ALLOC_TAG_NUM_NODES num_possible_nodes()
+#else
+#define ALLOC_TAG_NUM_NODES 1
+#endif
+
 struct alloc_tag_counters {
 	u64 bytes;
 	u64 calls;
@@ -134,16 +140,33 @@ static inline bool mem_alloc_profiling_enabled(void)
 				   &mem_alloc_profiling_key);
 }
 
+static inline struct alloc_tag_counters alloc_tag_read_nid(struct alloc_tag *tag, int nid)
+{
+	struct alloc_tag_counters v = { 0, 0 };
+	struct alloc_tag_counters *counters;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		counters = per_cpu_ptr(tag->counters, cpu);
+		v.bytes += counters[nid].bytes;
+		v.calls += counters[nid].calls;
+	}
+
+	return v;
+}
+
 static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 {
 	struct alloc_tag_counters v = { 0, 0 };
-	struct alloc_tag_counters *counter;
+	struct alloc_tag_counters *counters;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		counter = per_cpu_ptr(tag->counters, cpu);
-		v.bytes += counter->bytes;
-		v.calls += counter->calls;
+		counters = per_cpu_ptr(tag->counters, cpu);
+		for (int nid = 0; nid < ALLOC_TAG_NUM_NODES; nid++) {
+			v.bytes += counters[nid].bytes;
+			v.calls += counters[nid].calls;
+		}
 	}
 
 	return v;
@@ -179,7 +202,7 @@ static inline bool __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	return true;
 }
 
-static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag, int nid)
 {
 	if (unlikely(!__alloc_tag_ref_set(ref, tag)))
 		return false;
@@ -190,17 +213,18 @@ static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *t
 	 * Each new reference for every sub-allocation needs to increment call
 	 * counter because when we free each part the counter will be decremented.
 	 */
-	this_cpu_inc(tag->counters->calls);
+	this_cpu_inc(tag->counters[nid].calls);
 	return true;
 }
 
-static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
+static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
+				 int nid, size_t bytes)
 {
-	if (likely(alloc_tag_ref_set(ref, tag)))
-		this_cpu_add(tag->counters->bytes, bytes);
+	if (likely(alloc_tag_ref_set(ref, tag, nid)))
+		this_cpu_add(tag->counters[nid].bytes, bytes);
 }
 
-static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
+static inline void alloc_tag_sub(union codetag_ref *ref, int nid, size_t bytes)
 {
 	struct alloc_tag *tag;
 
@@ -215,8 +239,8 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 
 	tag = ct_to_alloc_tag(ref->ct);
 
-	this_cpu_sub(tag->counters->bytes, bytes);
-	this_cpu_dec(tag->counters->calls);
+	this_cpu_sub(tag->counters[nid].bytes, bytes);
+	this_cpu_dec(tag->counters[nid].calls);
 
 	ref->ct = NULL;
 }
@@ -228,8 +252,8 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
 #define DEFINE_ALLOC_TAG(_alloc_tag)
 static inline bool mem_alloc_profiling_enabled(void) { return false; }
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
-				 size_t bytes) {}
-static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
+				 int nid, size_t bytes) {}
+static inline void alloc_tag_sub(union codetag_ref *ref, int nid, size_t bytes) {}
 #define alloc_tag_record(p)	do {} while (0)
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 457ed8fd3214..35b314b36633 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -16,6 +16,10 @@ struct module;
 #define CODETAG_SECTION_START_PREFIX	"__start_"
 #define CODETAG_SECTION_STOP_PREFIX	"__stop_"
 
+enum codetag_flags {
+	CODETAG_PERCPU_ALLOC	= (1 << 0), /* codetag tracking percpu allocation */
+};
+
 /*
  * An instance of this structure is created in a special ELF section at every
  * code location being tagged.  At runtime, the special section is treated as
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 85bf8dd9f087..d92c27fbcd0d 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -43,7 +43,7 @@
 # define PERCPU_DYNAMIC_SIZE_SHIFT      12
 #endif /* LOCKDEP and PAGE_SIZE > 4KiB */
 #else
-#define PERCPU_DYNAMIC_SIZE_SHIFT      10
+#define PERCPU_DYNAMIC_SIZE_SHIFT      13
 #endif
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..b2a35cc78635 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1037,6 +1037,13 @@ config MEM_ALLOC_PROFILING_DEBUG
 	  Adds warnings with helpful error messages for memory allocation
 	  profiling.
 
+config MEM_ALLOC_PROFILING_PER_NUMA_STATS
+	bool "Memory allocation profiling per-NUMA stats"
+	default n
+	depends on MEM_ALLOC_PROFILING
+	help
+	  Display allocation stats on every NUMA node.
+
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
 source "lib/Kconfig.kmsan"
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index e9b33848700a..3b170847f547 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -40,6 +40,9 @@ struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
 unsigned long alloc_tag_ref_mask;
 int alloc_tag_ref_offs;
 
+/* Total size of all alloc_tag_counters of each CPU */
+static unsigned long pcpu_counters_size;
+
 struct allocinfo_private {
 	struct codetag_iterator iter;
 	bool print_header;
@@ -81,7 +84,7 @@ static void print_allocinfo_header(struct seq_buf *buf)
 {
 	/* Output format version, so we can change it. */
 	seq_buf_printf(buf, "allocinfo - version: 1.0\n");
-	seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
+	seq_buf_printf(buf, "<size> <calls> <tag info>\n");
 }
 
 static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
@@ -90,12 +93,32 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
 	struct alloc_tag_counters counter = alloc_tag_read(tag);
 	s64 bytes = counter.bytes;
 
-	seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
+	seq_buf_printf(out, "%-12lli %-8llu ", bytes, counter.calls);
 	codetag_to_text(out, ct);
 	seq_buf_putc(out, ' ');
 	seq_buf_putc(out, '\n');
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS
+static void alloc_tag_to_text_all_nids(struct seq_buf *out, struct codetag *ct)
+{
+	struct alloc_tag *tag = ct_to_alloc_tag(ct);
+	struct alloc_tag_counters counter;
+	s64 bytes;
+
+	for (int nid = 0; nid < ALLOC_TAG_NUM_NODES; nid++) {
+		counter = alloc_tag_read_nid(tag, nid);
+		bytes = counter.bytes;
+		seq_buf_printf(out, "        nid%-5u %-12lli %-8llu\n",
+				nid, bytes, counter.calls);
+	}
+}
+#else
+static void alloc_tag_to_text_all_nids(struct seq_buf *out, struct codetag *ct)
+{
+}
+#endif
+
 static int allocinfo_show(struct seq_file *m, void *arg)
 {
 	struct allocinfo_private *priv = (struct allocinfo_private *)arg;
@@ -109,6 +132,7 @@ static int allocinfo_show(struct seq_file *m, void *arg)
 		priv->print_header = false;
 	}
 	alloc_tag_to_text(&buf, priv->iter.ct);
+	alloc_tag_to_text_all_nids(&buf, priv->iter.ct);
 	seq_commit(m, seq_buf_used(&buf));
 	return 0;
 }
@@ -180,7 +204,7 @@ void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
 
 		if (get_page_tag_ref(folio_page(folio, i), &ref, &handle)) {
 			/* Set new reference to point to the original tag */
-			alloc_tag_ref_set(&ref, tag);
+			alloc_tag_ref_set(&ref, tag, folio_nid(folio));
 			update_page_tag_ref(handle, &ref);
 			put_page_tag_ref(handle);
 		}
@@ -247,15 +271,29 @@ void __init alloc_tag_sec_init(void)
 	if (!mem_profiling_support)
 		return;
 
-	if (!static_key_enabled(&mem_profiling_compressed))
-		return;
-
 	kernel_tags.first_tag = (struct alloc_tag *)kallsyms_lookup_name(
 					SECTION_START(ALLOC_TAG_SECTION_NAME));
 	last_codetag = (struct alloc_tag *)kallsyms_lookup_name(
 					SECTION_STOP(ALLOC_TAG_SECTION_NAME));
 	kernel_tags.count = last_codetag - kernel_tags.first_tag;
 
+	pcpu_counters_size = ALLOC_TAG_NUM_NODES * sizeof(struct alloc_tag_counters);
+	for (int i = 0; i < kernel_tags.count; i++) {
+		/* Each CPU has one alloc_tag_counters per numa node */
+		kernel_tags.first_tag[i].counters =
+			pcpu_alloc_noprof(pcpu_counters_size,
+					  sizeof(struct alloc_tag_counters),
+					  false, GFP_KERNEL | __GFP_ZERO);
+		if (!kernel_tags.first_tag[i].counters) {
+			while (--i >= 0)
+				free_percpu(kernel_tags.first_tag[i].counters);
+			panic("Failed to allocate per-cpu alloc_tag counters\n");
+		}
+	}
+
+	if (!static_key_enabled(&mem_profiling_compressed))
+		return;
+
 	/* Check if kernel tags fit into page flags */
 	if (kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
 		shutdown_mem_profiling(false); /* allocinfo file does not exist yet */
@@ -618,7 +656,9 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 	stop_tag = ct_to_alloc_tag(stop);
 	for (tag = start_tag; tag < stop_tag; tag++) {
 		WARN_ON(tag->counters);
-		tag->counters = alloc_percpu(struct alloc_tag_counters);
+		tag->counters = __alloc_percpu_gfp(pcpu_counters_size,
+						   sizeof(struct alloc_tag_counters),
+						   GFP_KERNEL | __GFP_ZERO);
 		if (!tag->counters) {
 			while (--tag >= start_tag) {
 				free_percpu(tag->counters);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 78ddf1d43c6c..7c4d10f6873c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1247,58 +1247,59 @@ void __clear_page_tag_ref(struct page *page)
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline
 void __pgalloc_tag_add(struct page *page, struct task_struct *task,
-		       unsigned int nr)
+		       int nid, unsigned int nr)
 {
 	union pgtag_ref_handle handle;
 	union codetag_ref ref;
 
 	if (get_page_tag_ref(page, &ref, &handle)) {
-		alloc_tag_add(&ref, task->alloc_tag, PAGE_SIZE * nr);
+		alloc_tag_add(&ref, task->alloc_tag, nid, PAGE_SIZE * nr);
 		update_page_tag_ref(handle, &ref);
 		put_page_tag_ref(handle);
 	}
 }
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
-				   unsigned int nr)
+				   int nid, unsigned int nr)
 {
 	if (mem_alloc_profiling_enabled())
-		__pgalloc_tag_add(page, task, nr);
+		__pgalloc_tag_add(page, task, nid, nr);
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline
-void __pgalloc_tag_sub(struct page *page, unsigned int nr)
+void __pgalloc_tag_sub(struct page *page, int nid, unsigned int nr)
 {
 	union pgtag_ref_handle handle;
 	union codetag_ref ref;
 
 	if (get_page_tag_ref(page, &ref, &handle)) {
-		alloc_tag_sub(&ref, PAGE_SIZE * nr);
+		alloc_tag_sub(&ref, nid, PAGE_SIZE * nr);
 		update_page_tag_ref(handle, &ref);
 		put_page_tag_ref(handle);
 	}
 }
 
-static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
+static inline void pgalloc_tag_sub(struct page *page, int nid, unsigned int nr)
 {
 	if (mem_alloc_profiling_enabled())
-		__pgalloc_tag_sub(page, nr);
+		__pgalloc_tag_sub(page, nid, nr);
 }
 
 /* When tag is not NULL, assuming mem_alloc_profiling_enabled */
-static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr)
+static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag,
+					 int nid, unsigned int nr)
 {
 	if (tag)
-		this_cpu_sub(tag->counters->bytes, PAGE_SIZE * nr);
+		this_cpu_sub(tag->counters[nid].bytes, PAGE_SIZE * nr);
 }
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
-				   unsigned int nr) {}
-static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
-static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
+				   int nid, unsigned int nr) {}
+static inline void pgalloc_tag_sub(struct page *page, int nid, unsigned int nr) {}
+static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, int nid, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
@@ -1337,7 +1338,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 		/* Do not let hwpoison pages hit pcplists/buddy */
 		reset_page_owner(page, order);
 		page_table_check_free(page, order);
-		pgalloc_tag_sub(page, 1 << order);
+		pgalloc_tag_sub(page, page_to_nid(page), 1 << order);
 
 		/*
 		 * The page is isolated and accounted for.
@@ -1394,7 +1395,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
-	pgalloc_tag_sub(page, 1 << order);
+	pgalloc_tag_sub(page, page_to_nid(page), 1 << order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -1850,7 +1851,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-	pgalloc_tag_add(page, current, 1 << order);
+	pgalloc_tag_add(page, current, page_to_nid(page), 1 << order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
@@ -5228,7 +5229,7 @@ static void ___free_pages(struct page *page, unsigned int order,
 	if (put_page_testzero(page))
 		__free_frozen_pages(page, order, fpi_flags);
 	else if (!head) {
-		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
+		pgalloc_tag_sub_pages(tag, page_to_nid(page), (1 << order) - 1);
 		while (order-- > 0)
 			__free_frozen_pages(page + (1 << order), order,
 					    fpi_flags);
diff --git a/mm/percpu.c b/mm/percpu.c
index 782cc148b39c..4c5369a40323 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1691,15 +1691,19 @@ static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
 				      size_t size)
 {
 	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
+		/* For percpu allocation, store all alloc_tag stats on numa node 0 */
 		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
-			      current->alloc_tag, size);
+			      current->alloc_tag, 0, size);
+		if (current->alloc_tag)
+			current->alloc_tag->ct.flags |= CODETAG_PERCPU_ALLOC;
 	}
 }
 
 static void pcpu_alloc_tag_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 {
+	/* percpu alloc_tag stats is stored on numa node 0 so subtract from node 0 */
 	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts))
-		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, size);
+		alloc_tag_sub(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag, 0, size);
 }
 #else
 static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..3939c58e55c4 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Johannes Weiner <hannes@saeurebad.de>
  */
 
+#include <linux/alloc_tag.h>
 #include <linux/blkdev.h>
 #include <linux/cma.h>
 #include <linux/cpuset.h>
@@ -426,6 +427,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
 		if (nr) {
 			pr_notice("Memory allocations:\n");
+			pr_notice("<size> <calls> <tag info>\n");
 			for (i = 0; i < nr; i++) {
 				struct codetag *ct = tags[i].ct;
 				struct alloc_tag *tag = ct_to_alloc_tag(ct);
@@ -433,16 +435,25 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 				char bytes[10];
 
 				string_get_size(counter.bytes, 1, STRING_UNITS_2, bytes, sizeof(bytes));
-
 				/* Same as alloc_tag_to_text() but w/o intermediate buffer */
 				if (ct->modname)
-					pr_notice("%12s %8llu %s:%u [%s] func:%s\n",
-						  bytes, counter.calls, ct->filename,
-						  ct->lineno, ct->modname, ct->function);
+					pr_notice("%-12s %-8llu %s:%u [%s] func:%s\n",
+						bytes, counter.calls, ct->filename,
+						ct->lineno, ct->modname, ct->function);
 				else
-					pr_notice("%12s %8llu %s:%u func:%s\n",
-						  bytes, counter.calls, ct->filename,
-						  ct->lineno, ct->function);
+					pr_notice("%-12s %-8llu %s:%u func:%s\n",
+						bytes, counter.calls,
+						ct->filename, ct->lineno, ct->function);
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS
+				for (int nid = 0; nid < ALLOC_TAG_NUM_NODES; nid++) {
+					counter = alloc_tag_read_nid(tag, nid);
+					string_get_size(counter.bytes, 1, STRING_UNITS_2,
+							bytes, sizeof(bytes));
+					pr_notice("        nid%-5u %-12s %-8llu\n",
+						  nid, bytes, counter.calls);
+				}
+#endif
 			}
 		}
 	}
diff --git a/mm/slub.c b/mm/slub.c
index c4b64821e680..1c7b10befa7c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2106,8 +2106,12 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_exts))
-		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	if (likely(obj_exts)) {
+		struct page *page = virt_to_page(object);
+
+		alloc_tag_add(&obj_exts->ref, current->alloc_tag,
+				page_to_nid(page), s->size);
+	}
 }
 
 static inline void
@@ -2135,8 +2139,9 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
+		struct page *page = virt_to_page(p[i]);
 
-		alloc_tag_sub(&obj_exts[off].ref, s->size);
+		alloc_tag_sub(&obj_exts[off].ref, page_to_nid(page), s->size);
 	}
 }
 
-- 
2.34.1


