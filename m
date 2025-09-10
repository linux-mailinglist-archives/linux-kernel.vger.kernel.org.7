Return-Path: <linux-kernel+bounces-811137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB8B524D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FD1A05321
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF52F28E3;
	Wed, 10 Sep 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1Db7Ecp"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C20283CB5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548664; cv=none; b=Y0iJjSk/ITBjZsrB5rL8bFT4gtcqQHX33COz81kIs5JpOaxr3pehED9TQf8d+99AnnvNc+C2xtMrPVuyvHv48TFsqpMl9l2JIUML9ph5eMNbm8kl003xACjXpCOc6MtYSWDeLHlUUOy3SfBzaccxBk/2YFdA6oHlduXYdefckiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548664; c=relaxed/simple;
	bh=RAKRMgWwtIaRTYCDXz6ui8zqoTkb0gxlZp+dl5xc8KY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agtg75pIJ7aTyJejDWXfB9XMXJFQ/2KTvhB7SzCwPs4hIZW6FUF+mz0EQyIpL66ID1mhGwZgkWgEtVA5NDZ/aCt08icmahR6YBrkweQg+mD3qL7cuPsBs13NcXq+2W3nIaXsUoFg0Xa9MPbbv41W83sriItYGfZ6rUwwj0GC6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1Db7Ecp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24c8264a137so1012175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757548662; x=1758153462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGwQF+CXl3vYtzdP9mbgCIJA/DkcNggZlxUnpS7TgbA=;
        b=M1Db7EcpaaIkYOjJIVF+s64nO1jNRkqQiK2umCay2BTkC/lSZG9V5A2vOGCgKx0Kd6
         nQ8a7FhQj/c7E0r7Pgz51N/hbGmT/PszNhWILamLr+hKzATW4zCQRrWfQvzwsUQiw2lA
         HQ+EhKGXJojrYCOt+SAAPefpN+3tZFWdz27YfXVOsbKaGFS2dY0ss+9HWvtWVDULzW+F
         k7v/pKw2AQcVwiQdQsroepeIWxZeJAGKWao+R3qCNoamNFbe5EaPYvDEsCnMuKTltl3l
         APlQFzpmU6oGlY4OmN65X2CUO0Kk42B/LZfxBlYYiGecvAbnpSskINnEackTr1Hz1ZpQ
         F++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548662; x=1758153462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGwQF+CXl3vYtzdP9mbgCIJA/DkcNggZlxUnpS7TgbA=;
        b=Npwj65Z0A64frGKDyUN9XLw7r5SRB1hjRIFHjenLby7y0UJ+ekhtySHeCwRIGMeSUh
         5KcNZg6aC1YBQYASpRakPJsa7kRmplM0WhKKWnl4quX7lD7H7gFyxxpGssYgir1yplWB
         TNwr7xVgJ2/DAgKZB97MyeomSasgNMF/ilWUbmzqOdZc+eMOkAyN3BvI/YuYhNIQDUJt
         WzXEQDfdqE1vj99WYDF4XHTXlG5EiQMfgjeVtMZbsOIoPgWEW2S9b/OZZ88kt+F/1t24
         aUp3ftAwP6xFZk+d6cnXb2IDV+ye6Td232ed7khCRnDwktJznVTS/D+s8R0C16+MyxLq
         zqVA==
X-Forwarded-Encrypted: i=1; AJvYcCXmjZ1X44SHseNRzyqG+OUSAXEoP0xU2vLWDB6HavCpgqJMClHa7vtyBT2CNQTLQtQ1Mr+NAx75euhhw7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwREWUZN/9AItBANpxZjzX2J1gw93DEGeQ0vdH+DSib83QksU+W
	AsjMpDZfbhhb3yk7sEfqfoKc9gxUEXT/ot7rTJT+FvO2agNZxwGh7OfuoXGNYI+Kc81D3orZD6Q
	ssyLWk+5QqVbSOA==
X-Google-Smtp-Source: AGHT+IFgMc9+BRlDZ/xcmHEhHQ3WZP/Hvgh8+t59rNiHJPd+WEnbMa1Kj1RSd0TLn33KhEA3jAl11A/Teaqamg==
X-Received: from pljf9.prod.google.com ([2002:a17:902:ff09:b0:24c:b6ae:fcb0])
 (user=kinseyho job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3d05:b0:24c:a417:4490 with SMTP id d9443c01a7336-2516ce60006mr244218345ad.5.1757548661978;
 Wed, 10 Sep 2025 16:57:41 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:51:21 -0700
In-Reply-To: <20250910235121.2544928-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250910235121.2544928-1-kinseyho@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250910235121.2544928-3-kinseyho@google.com>
Subject: [RFC PATCH v2 2/2] mm: klruscand: use mglru scanning for page promotion
From: Kinsey Ho <kinseyho@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com, dave.hansen@intel.com, gourry@gourry.net, 
	hannes@cmpxchg.org, mgorman@techsingularity.net, mingo@redhat.com, 
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com, 
	rientjes@google.com, sj@kernel.org, weixugc@google.com, willy@infradead.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com, lorenzo.stoakes@oracle.com, 
	axelrasmussen@google.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev
Content-Type: text/plain; charset="UTF-8"

Introduce a new kernel daemon, klruscand, that periodically invokes the
MGLRU page table walk. It leverages the new callbacks to gather access
information and forwards it to the kpromoted daemon for promotion
decisions.

This benefits from reusing the existing MGLRU page table walk
infrastructure, which is optimized with features such as hierarchical
scanning and bloom filters to reduce CPU overhead.

As an additional optimization to be added in the future, we can tune
the scan intervals for each memcg.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/Kconfig     |   8 ++++
 mm/Makefile    |   1 +
 mm/klruscand.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 mm/klruscand.c

diff --git a/mm/Kconfig b/mm/Kconfig
index 8b236eb874cf..6d53c1208729 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1393,6 +1393,14 @@ config PGHOT
 	  by various sources. Asynchronous promotion is done by per-node
 	  kernel threads.
 
+config KLRUSCAND
+	bool "Kernel lower tier access scan daemon"
+	default y
+	depends on PGHOT && LRU_GEN_WALKS_MMU
+	help
+	  Scan for accesses from lower tiers by invoking MGLRU to perform
+	  page table walks.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index ecdd5241bea8..05a96ec35aa3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -148,3 +148,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_PGHOT) += pghot.o
+obj-$(CONFIG_KLRUSCAND) += klruscand.o
diff --git a/mm/klruscand.c b/mm/klruscand.c
new file mode 100644
index 000000000000..1ee2ac906771
--- /dev/null
+++ b/mm/klruscand.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/memcontrol.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/random.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/slab.h>
+#include <linux/sched/clock.h>
+#include <linux/memory-tiers.h>
+#include <linux/sched/mm.h>
+#include <linux/sched.h>
+#include <linux/pghot.h>
+
+#include "internal.h"
+
+#define KLRUSCAND_INTERVAL 2000
+#define BATCH_SIZE (2 << 16)
+
+static struct task_struct *scan_thread;
+static unsigned long pfn_batch[BATCH_SIZE];
+static int batch_index;
+
+static void flush_cb(void)
+{
+	int i;
+
+	for (i = 0; i < batch_index; i++) {
+		unsigned long pfn = pfn_batch[i];
+
+		pghot_record_access(pfn, NUMA_NO_NODE,
+					PGHOT_PGTABLE_SCAN, jiffies);
+
+		if (i % 16 == 0)
+			cond_resched();
+	}
+	batch_index = 0;
+}
+
+static bool accessed_cb(unsigned long pfn)
+{
+	WARN_ON_ONCE(batch_index == BATCH_SIZE);
+
+	if (batch_index < BATCH_SIZE)
+		pfn_batch[batch_index++] = pfn;
+
+	return batch_index == BATCH_SIZE;
+}
+
+static int klruscand_run(void *unused)
+{
+	struct lru_gen_mm_walk *walk;
+
+	walk = kzalloc(sizeof(*walk),
+		       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	if (!walk)
+		return -ENOMEM;
+
+	while (!kthread_should_stop()) {
+		unsigned long next_wake_time;
+		long sleep_time;
+		struct mem_cgroup *memcg;
+		int flags;
+		int nid;
+
+		next_wake_time = jiffies + msecs_to_jiffies(KLRUSCAND_INTERVAL);
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+			struct reclaim_state rs = { 0 };
+
+			if (node_is_toptier(nid))
+				continue;
+
+			rs.mm_walk = walk;
+			set_task_reclaim_state(current, &rs);
+			flags = memalloc_noreclaim_save();
+
+			memcg = mem_cgroup_iter(NULL, NULL, NULL);
+			do {
+				struct lruvec *lruvec =
+					mem_cgroup_lruvec(memcg, pgdat);
+				unsigned long max_seq =
+					READ_ONCE((lruvec)->lrugen.max_seq);
+
+				lru_gen_scan_lruvec(lruvec, max_seq, accessed_cb, flush_cb);
+				cond_resched();
+			} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+			memset(walk, 0, sizeof(*walk));
+		}
+
+		sleep_time = next_wake_time - jiffies;
+		if (sleep_time > 0 && sleep_time != MAX_SCHEDULE_TIMEOUT)
+			schedule_timeout_idle(sleep_time);
+	}
+	kfree(walk);
+	return 0;
+}
+
+static int __init klruscand_init(void)
+{
+	struct task_struct *task;
+
+	task = kthread_run(klruscand_run, NULL, "klruscand");
+
+	if (IS_ERR(task)) {
+		pr_err("Failed to create klruscand kthread\n");
+		return PTR_ERR(task);
+	}
+
+	scan_thread = task;
+	return 0;
+}
+module_init(klruscand_init);
-- 
2.51.0.384.g4c02a37b29-goog


