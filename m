Return-Path: <linux-kernel+bounces-891123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED33C41E42
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE243A475F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC2329376;
	Fri,  7 Nov 2025 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e6hAHDYb"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3A32A3CA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555825; cv=none; b=R51RzINWfNCYAwlds7cfaWGY74oHo/mhnA506RoIUGfw5ov/m+KKRQyhL+LW7fxhk5nvY0IbWYBoXHBrnL9KxHxJnmFSL2jC2WGxwc/xDRvR12v/wUIGtJ9HUGzfDuRza2Fr3YzukI2t2WFEY/zg8NynCr8kWUKGfRUcsA1dFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555825; c=relaxed/simple;
	bh=aVCsq29TRfkUneUg7VcXHP54fL2RXfk+IKU2j2Nc0iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgFCflOycANaN638Vrncs1lXw6SoP7I15koJFhzPmkDS30hdyYWcfW4j8258FKOcV2bwXhRm5mxruAEohuz7r/E/g9SYyEVy/FI0tqMf3+hPSED6weaNQiuymAKBb4YaN94keWTTuyoT2gL/SJSzpHpYyCorFXLgwyZ6VJ/SHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e6hAHDYb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed612ac7a7so12441401cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555822; x=1763160622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THbr/Y85WnAbuULOZYzy4wMGCXZ829d22z7gMjfvDN0=;
        b=e6hAHDYbggGHZBmB7mlRbzfSodbsoab5X40BEKEdAZvtChHGvKVRcvsW5cBVzpmC9x
         OZ5p3FN0XBihQtUZjxEnRfyP3CFOmBDiMqevLId7SOIRZJOYBxCMnOqG9pfQqvUHcNQz
         LALKEXIIu3Rdrq6orTaIUizrjCrPbUVJM5DMPIJzAexPDeD1DpH080r5glEhUBRVhai0
         O1wndC7SXAr0bJb6OVH5PHJuzBos3O7+uxHK+zct1Unv6Ip5yTEJJSsUhWkwXaUVp6VZ
         vpHU0n9xzukHCYQaUBpYna1FRNPmN7Vwu7ZP3iNP+Uz+S6srFH9d6g7cc4VSxBWlwkYL
         Nrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555822; x=1763160622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THbr/Y85WnAbuULOZYzy4wMGCXZ829d22z7gMjfvDN0=;
        b=F9PI9EwPfk4FRpVgPP6QF1swYpEZy7Z+gqBkPFQ+8MSa+2yAOxwMm/z6CDyGgjW4/u
         i+6NOsQ8+6hyuUW8aX7WUzvQgixJmlRx5TitDD8IMDhluaV3q3SgO+Ug8m0VTYD1w/XJ
         8aO9fW0cO2SGdPT49b+a05T1/EytrX6xlNpvGrv2zVsjGAa+aehzV7/UipyJrqoEx4FF
         CHd+zGmrRub6rjtXEQg63WRFFvenVPAp3SKAnYPQuPMn+qRzOXkes+iE/j6UMM47X7mg
         6P1ftzrHizEjWH0UA11Jysmnd+pJAJygB0EwVZU3hKvsaI1/pr4tilyL3Ole4XpgCciF
         MiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXphsVkXirVtG50UZf92dE2ekcMmKRccCIyUUEADDhTQaQMgXjB6pUqgPiWTlQTshFKEyvL7IWIIHXmclU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz871IKgOFLv7yNVzSGzm1a1YN9lRqhGNeF4on3iuz0lnedhJVM
	ywOd+BUMOpIrPFzg/hvNEpFx+kq4NJU4YYD2jciyr9LiM/1mZEYL2hNtrHjeJlIUPjk=
X-Gm-Gg: ASbGncs5SXnrfNxSTTBHNOZ78IThYKx41i9uxnYlPFb5dxACXboSQ2tjV7ktoTDy5iD
	+tU/dDPADxBXxAvhCsPNxrqwYsJvUaU9vBj1B4AfSQV+GP97tkLTq5pdTwePt1tku14HvKPjKog
	62nxsnpHVFOlLmqjxUM4NRdI6ZsZfNUAJVl48RMVxfdijY28B1/15u8goJCNFf+No42sJk+5hju
	mH2EwklQfLs3k16Vu9lwjvdetsbWeyvpHfafq90pLKy2QhebXn2z2tDJtRxAhQ88NTNihiRhpSC
	DXviXRYtyCgJFT9YlpOOYQ29kMuNlQHYA8HlOM/2CxoeTJXDjPbsPSgNyFVuzau+05t0yBgJ6wS
	jMm7rB+BLYYVuEAOed+v2ErXRldzzkkoJ18yHGqCyok3UNWSUy7ycw0MTpdPCh2D/rDtRc0mlDV
	aeG3tqKROXqRevkNws3vTqmILb4Q9/zXDrWwdcK5ucHJEAZ5PQcvm0CGI58ghimqLo5mN1amlfF
	CqCJu+wNhGCxA==
X-Google-Smtp-Source: AGHT+IFWQljTxYPO6CFPNauC805q+VElYGBru+/DO5QGOLDAxl11WHp9VZk3rhHcoNcRJaJ5IM73qw==
X-Received: by 2002:a05:622a:386:b0:4ec:a564:3e66 with SMTP id d75a77b69052e-4eda4ec8aa5mr11288381cf.29.1762555821864;
        Fri, 07 Nov 2025 14:50:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:21 -0800 (PST)
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
Subject: [RFC PATCH 6/9] mm/memory_hotplug: add MHP_PROTECTED_MEMORY flag
Date: Fri,  7 Nov 2025 17:49:51 -0500
Message-ID: <20251107224956.477056-7-gourry@gourry.net>
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

Add support for protected memory blocks/nodes, which signal to
memory_hotplug that a given memory block is considered "protected".

A protected memory block/node is not exposed as SystemRAM by default
via default_sysram_nodes.  Protected memory cannot be added to sysram
nodes, and non-protected memory cannot be added to protected nodes.

This enables these memory blocks to be protected from allocation by
general actions (page faults, demotion, etc) without explicit
integration points which are memory-tier aware.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 23f038a16231..89f4e5b7054d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -74,6 +74,16 @@ typedef int __bitwise mhp_t;
  * helpful in low-memory situations.
  */
 #define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
+/*
+ * The hotplugged memory can only be added to a NUMA node which is
+ * not in default_sysram_nodes.  This prevents the node from be accessible
+ * by the page allocator (mm/page_alloc.c) by way of userland configuration.
+ *
+ * Attempting to hotplug protected memory into a node in default_sysram_nodes
+ * will result in an -EINVAL, and attempting to hotplug non-protected memory
+ * into protected memory node will also result in an -EINVAL.
+ */
+#define MHP_PROTECTED_MEMORY	((__force mhp_t)BIT(4))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..ceab56b7231d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -20,6 +20,7 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -1506,6 +1507,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	struct memory_group *group = NULL;
 	u64 start, size;
 	bool new_node = false;
+	bool node_has_blocks, protected_mem, node_is_sysram;
 	int ret;
 
 	start = res->start;
@@ -1529,6 +1531,19 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
+	/*
+	 * If the NUMA node already has memory blocks, then we can only allow
+	 * additional memory blocks of the same protection type (protected or
+	 * un-protected).  Online/offline does not matter at this point.
+	 */
+	node_has_blocks = node_has_memory_blocks(nid);
+	protected_mem = !!(mhp_flags & MHP_PROTECTED_MEMORY);
+	node_is_sysram = node_isset(nid, *default_sysram_nodes);
+	if (node_has_blocks && (protected_mem ^ node_is_sysram)) {
+		ret = -EINVAL;
+		goto error_mem_hotplug_end;
+	}
+
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 			memblock_flags = MEMBLOCK_DRIVER_MANAGED;
@@ -1574,6 +1589,10 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	register_memory_blocks_under_node_hotplug(nid, PFN_DOWN(start),
 					  PFN_UP(start + size - 1));
 
+	/* At this point if not protected, we can add node to sysram nodes */
+	if (!(mhp_flags & MHP_PROTECTED_MEMORY))
+		node_set(nid, *default_sysram_nodes);
+
 	/* create new memmap entry */
 	if (!strcmp(res->name, "System RAM"))
 		firmware_map_add_hotplug(start, start + size, "System RAM");
@@ -2274,6 +2293,10 @@ static int try_remove_memory(u64 start, u64 size)
 	if (nid != NUMA_NO_NODE)
 		try_offline_node(nid);
 
+	/* If no more memblocks, remove node from default sysram nodemask */
+	if (!node_has_memory_blocks(nid))
+		node_clear(nid, *default_sysram_nodes);
+
 	mem_hotplug_done();
 	return 0;
 }
-- 
2.51.1


