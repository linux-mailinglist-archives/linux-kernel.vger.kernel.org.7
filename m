Return-Path: <linux-kernel+bounces-891126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE8C41E69
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 827394EE8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3233CEAC;
	Fri,  7 Nov 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JsXbbN0S"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA933B6C4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555834; cv=none; b=AGNJajAvRyWG/8WA0S1hQHiEZivAd6yp43BIAK/hwx5qvrIxQOm/fExtI4w/3PzLBTLxFu1WQQDZs440ioPpTq9+hKe28kocNiZYafgfa0SNiYUUIVy73iOHDQgSM3OAOhEMXJKWtX6jJxr9nZw7FlZvFeyC7AHIJwy4LmCAg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555834; c=relaxed/simple;
	bh=OKl0yBHUY2HDyHAzrayh15w08hguionxpa8ckFMJLi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjkzX6q4tqF3nFKcIr2VNlN6UtlVyKIxpaqp9i0R88tt2LHErA7BMSrXO5++pQIyyVhPJMTheoLyzgNvJKup37kzHNWaTomQoH4k8MuLHiSXEB1g6/0rOv8BYx17Z5YBuxFlH3aOVpXSerBqToGG7cwPJlTl2D1blDzqD2EkcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JsXbbN0S; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed79ad2846so12302301cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555830; x=1763160630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9lQPmHHEcXtG9PcD1wB7xt838yvOXXROIsvBhfuZzo=;
        b=JsXbbN0Sm0Gp9Im7l8efJR3anggyEPz4GxYy2/jOm7VAq6KVCjqW9ysG//zWK4Dlrc
         Alox5RvnKNeHohMRKzV7MSNSIbr6PZNcOYMIvSa0/Cbeu1jH/KXlLshN6mNbikS5V+45
         0YwEilWPyJ60PkfgNu9BC+Szwkx6bQektMPdVxPsX6gEqFqo9XmSn+7WzGBW192q3t4u
         knGir6N3Rt3UmTeoQdqibk/hKPIMzJmkCLLVwvQXGURD63cIsRdBunfx3E+x9UvqIqNK
         Okwu4Wurq7kltARAshGCxokpWH2kzY/QmqCoyftmmkeCaEfED2Qbg4h8Al/bvp0zJlv2
         mIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555830; x=1763160630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9lQPmHHEcXtG9PcD1wB7xt838yvOXXROIsvBhfuZzo=;
        b=YmoFY95p06N5AEaer5xvlyMZ1K9MOe6/0SJIiWnsQH8zecoIfzl2s93AIYKpbonGJK
         wpqASryiAEeCktminD1wcYyc7ZzE0zQfxau8Pm2h7WtbnF2DacCiyInM3fWgcQP/LdLc
         w+3pqy6vDPGkYKBHHkto6vmtOUCcyV7ze94+oHGsgiqLuPq/47UJv26U6IhL4QAkNhyY
         jP3EpysWag1veF8VzIZNwB+xoHFg8ZEz264EMswE8+xZa+bHPLeFwrC1rrzRzHwJOdci
         OiUSx8Pj9vSCXNMUVaxkxmCtLkCOzRAyDXPn4l1yZKPYmyNZFO6LJMKwFjYA/ZcT+UPj
         mZHw==
X-Forwarded-Encrypted: i=1; AJvYcCVhw9q+5GM1oulc3Ccp4Yh55De8ZAcprLkLwhmsPEe62PAH/uKUra06ahbfDKnILhSQCKqBYqWLiqKFY9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4J/asDcjGwV/0NWYQrFuDRCLkYjsQPC9p99sWaS0z3GUYW+4
	FzLykG4xLQ8d+0gmwYj2gIjWlWRi+BtPwKHpD/as3txZZ8HHwoN++OzgiNm27jTohdQ=
X-Gm-Gg: ASbGncszvGVFBGOXRsvxfSftbxqecolF1iozW3RyRtnijE8zCraKBOONj4vRmR+rJsZ
	519POXFuX7OTAiqZ2Vxzt2i3JjuYCxzBxtOXFrFt7RDxxM/GWj38UW4Ok/w619z9GO2LfUe+TTT
	cyMgXnDurr7a18hd7OsIidD8pmAiqvV+Jk3OHyM0QwA5XbJMmPe1Ehi+8ESI6+Z0z+WRhikKcAq
	B0AxiZl96LZlofspDE803cuyYIsR1KiN+t9lMUhrHlGsqKlBg8uwIv9x5P/+7T63ZIxUfs16tZf
	aXQfyPFVJNWwS5ohoNbAb7G/DrYwmqr2G9xrgoTexe+71VaMm5yisDMYiGpCYJbK0rU4NZXL6xG
	7V2SWwmRaI3rvUIVOXN8ioRT4qFMb1KsRA1tiS2/iRz/I/eiAYiP2HNp1oPivgsx8JOiSYelGpV
	RceOu+3DdROL8dXSU8duX5CzUcuHz7jJN4rRKRjQnbw+pnJlXmID3apqcNbDvno5SIl7niSnMtA
	p1dNffAGLlcLw==
X-Google-Smtp-Source: AGHT+IGiz0rmAqkF080s48owgkrlhIDOgmhn7Uh2wWe1SA/ZeGElIvqZ5FF6lfn2BTWxOTuvNIrg9w==
X-Received: by 2002:ac8:5e47:0:b0:4e8:9683:3a35 with SMTP id d75a77b69052e-4eda4d392e9mr11493571cf.0.1762555830443;
        Fri, 07 Nov 2025 14:50:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:29 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 9/9] [HACK] mm/zswap: compressed ram integration example
Date: Fri,  7 Nov 2025 17:49:54 -0500
Message-ID: <20251107224956.477056-10-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is an example of how you might use a protected memory node.

We hack in an mt_compressed_nodelist to memory-tiers.c as a standin
for a proper compressed-ram component, and use that nodelist to
determine if compressed ram is available in the zswap_compress
function.

If there is compressed ram available, we skip the entire software
compression process and shunt memcpy directly to a compressed memory
folio, and store the newly allocated compressed memory page as the
zswap entry->handle.

On decompress we do the opposite: copy directly from the stored
compressed page to the new destination, and free the compressed
memory page.

Note: We do not integrate any compressed memory device checks at
this point because this is a stand-in to demonstrate how the protected
node allocation mechanism works.  See the "TODO" comment in
`zswap_compress_direct()` for more details on how that would work.

In reality, we would want to make this mechanism out of zswap into
its own component (cram.c?), and enable a more direct migrate_page()
call that actually re-maps the page read-only into any mappings, and
then provides a write-fault handler which promotes the page on write.

This prevents any run-away compression ratio failures, since the
compression ratio would be checked on allocation, rather than allowed
to silently decrease on writes until the device becomes unstable.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            |  3 ++
 mm/memory_hotplug.c          |  2 ++
 mm/zswap.c                   | 65 +++++++++++++++++++++++++++++++++++-
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 3d3f3687d134..ff2ab7990e8f 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -42,6 +42,7 @@ extern nodemask_t default_dram_nodes;
 extern nodemask_t default_sysram_nodelist;
 #define default_sysram_nodes (nodes_empty(default_sysram_nodelist) ? NULL : \
 			      &default_sysram_nodelist)
+extern nodemask_t mt_compressed_nodelist;
 struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index b2ee4f73ad54..907635611f17 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -51,6 +51,9 @@ nodemask_t default_dram_nodes = NODE_MASK_NONE;
 /* default_sysram_nodelist is the list of nodes with RAM at __init time */
 nodemask_t default_sysram_nodelist = NODE_MASK_NONE;
 
+/* compressed memory nodes */
+nodemask_t mt_compressed_nodelist = NODE_MASK_NONE;
+
 static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
 	.dev_name = "memory_tier",
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index ceab56b7231d..8fcd894de93c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1592,6 +1592,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/* At this point if not protected, we can add node to sysram nodes */
 	if (!(mhp_flags & MHP_PROTECTED_MEMORY))
 		node_set(nid, *default_sysram_nodes);
+	else /* HACK: We would create a proper interface for something like this */
+		node_set(nid, mt_compressed_nodelist);
 
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
diff --git a/mm/zswap.c b/mm/zswap.c
index c1af782e54ec..09010ba2440c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -25,6 +25,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mempolicy.h>
 #include <linux/mempool.h>
+#include <linux/memory-tiers.h>
 #include <crypto/acompress.h>
 #include <linux/zswap.h>
 #include <linux/mm_types.h>
@@ -191,6 +192,7 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	bool referenced;
+	bool direct;
 	struct zswap_pool *pool;
 	unsigned long handle;
 	struct obj_cgroup *objcg;
@@ -717,7 +719,8 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zs_free(entry->pool->zs_pool, entry->handle);
+	if (!entry->direct)
+		zs_free(entry->pool->zs_pool, entry->handle);
 	zswap_pool_put(entry->pool);
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
@@ -851,6 +854,43 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 	mutex_unlock(&acomp_ctx->mutex);
 }
 
+static struct page *zswap_compress_direct(struct page *src,
+					  struct zswap_entry *entry)
+{
+	int nid = first_node(mt_compressed_nodelist);
+	struct page *dst;
+	gfp_t gfp;
+
+	if (nid == NUMA_NO_NODE)
+		return NULL;
+
+	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE |
+	      __GFP_PROTECTED;
+	dst = __alloc_pages(gfp, 0, nid, &mt_compressed_nodelist);
+	if (!dst)
+		return NULL;
+
+	/*
+	 * TODO: check that the page is safe to use
+	 *
+	 * In a real implementation, we would not be using ZSWAP to demonstrate this
+	 * and instead would implement a new component (compressed_ram, cram.c?)
+	 *
+	 * At this point we would check via some callback that the device's memory
+	 * is actually safe to use - and if not, free the page (without writing to
+	 * it), and kick off kswapd for that node to make room.
+	 *
+	 * Alternatively, if the compressed memory device(s) report a watermark
+	 * crossing via interrupt, a flag can be set that is checked here rather
+	 * that calling back into a device driver.
+	 *
+	 * In this case, we're testing with normal memory, so the memory is always
+	 * safe to use (i.e. no compression ratio to worry about).
+	 */
+	copy_mc_highpage(dst, src);
+	return dst;
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -862,6 +902,19 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 	bool mapped = false;
+	struct page *zpage;
+
+	/* Try to shunt directly to compressed ram */
+	if (!nodes_empty(mt_compressed_nodelist)) {
+		zpage = zswap_compress_direct(page, entry);
+		if (zpage) {
+			entry->handle = (unsigned long)zpage;
+			entry->length = PAGE_SIZE;
+			entry->direct = true;
+			return true;
+		}
+		/* otherwise fallback to normal zswap */
+	}
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
@@ -939,6 +992,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	int decomp_ret = 0, dlen = PAGE_SIZE;
 	u8 *src, *obj;
 
+	/* compressed ram page */
+	if (entry->direct) {
+		struct page *src = (struct page*)entry->handle;
+		struct folio *zfolio = page_folio(src);
+		memcpy_folio(folio, 0, zfolio, 0, PAGE_SIZE);
+		__free_page(src);
+		goto direct_done;
+	}
+
 	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	obj = zs_obj_read_begin(pool->zs_pool, entry->handle, acomp_ctx->buffer);
 
@@ -972,6 +1034,7 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	zs_obj_read_end(pool->zs_pool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
 
+direct_done:
 	if (!decomp_ret && dlen == PAGE_SIZE)
 		return true;
 
-- 
2.51.1


