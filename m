Return-Path: <linux-kernel+bounces-882426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B507C2A725
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097F03B7E08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADF2C1587;
	Mon,  3 Nov 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="RNpBwAS4"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2742C158E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156403; cv=none; b=edjaA23KEiMg3QCgNvTovbW2QHibj1AgbMsYswoOSFAG3c3iUlQETa1qMqkd1PTSEe83EWjkaqOYdXD5x/RRKcU+SESxZin6kGpVbQQNRSRdLdWXZkcizWj507msZLPnTm+3G71Yfh8fM+ZiLNAZP8uThMEBAEsPH7oFs6115OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156403; c=relaxed/simple;
	bh=Lodb6rLROk4Q3CAebuv8vkqskVQL3XSySEbny+ty2Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5b1zIg46u7D4nlZ6HpHi1696skDC80Ms3q8OEgda6ns/LT6+4z/soXKRc6ANESP9upbEKy1E7ISZWlxpjwztGyrUmhF+EOPoncGSZ21hI0AlmjHr7/PhtiZP5VW6UkISjJ5vzJqXrK4CzcG23ct+QgyehYbiX/dmjP7ixKhoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=RNpBwAS4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340e525487eso822477a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156401; x=1762761201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbphvwlZY5Z8mMpRxJCeoPt3Sbe7fHbYhkrPsa2IkNg=;
        b=RNpBwAS4yESmrj9Weh9BEo1RboZ8PK06YEA0hxkj1PpR/zXz1nB8SdZa24ikNZFH8v
         I/+0hPUmOjIT1kmeg4JM9BUUR4MmAziopCMnJYfZJ96Yd8xjk+gUA8cR2zaKsRK8VBY4
         G/3BUoKW2hn4oKK2mb5LFyWsn5FBoRX0b7mlczVWgwIdY8aDae/GxBJwaZAKk9v+KZLF
         rNNZVSEdPS6Mfb2TyY4r9lo3Y+c6GRWsYCoSm49TiTbz5y317bhRCtdtYYKqTFzL25JI
         hOA/uEprySpMADE+pi2j8LC4pQgOPpWQB+t1EFzDR5HUyUUxZSBP5BGva3g/SdGR2o6B
         MtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156401; x=1762761201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbphvwlZY5Z8mMpRxJCeoPt3Sbe7fHbYhkrPsa2IkNg=;
        b=ZBAaTZcDJEDB1jBEBf4+vUSP9jEQ1kFXs8BacbYJk/hXYeM8Yk+nTCzSE715NssE1W
         eRmVKFGF6NmV/nzYWhQTr4ijOlOLb7OI9ITcf1EMZXBmyhvePD2ME7XUrQF54UB1/rzv
         9hEeYJF0FRf+R8GzvqFOKS2kAjx0D60hXcWyrthUibHo3F9Swc+OuDl4pI921jEVtZL3
         fFKxe82SUJ6NqgT5Fcav5KrMV9f2eEY90thMtvZClGTnE0rnqd3v38wflo2ARzR9fz+E
         Mn0j+4yuaSDpPFtayNYp8mQ+y+tseZ9acSntsNyO1kC+/Zl9+2MLU728+qIjmVjgTY9D
         x07A==
X-Forwarded-Encrypted: i=1; AJvYcCV0uemNetW14hwjyKgxTDHUIGaF7lCqcDaLgHXmcmXevO/OW5KpzWpeill/f2GwLP8FZKZFhWLoJ3rE6tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCsn8GCGFYTLO/yXhJdE7ENfVT7U+DMHXkSyBj2+Pwlv/DH9E
	G+VClrapjj4hyg9QHa/CGm1UH1/Dpc9QjOZ7ujeJfuwwJ+1WIu7ApwfcUJfrd3AgxT8=
X-Gm-Gg: ASbGnct50Se2PQhch/j1Y0LM4mhAqDRWbrNO1/KH/6WkiZzwRQ+qWg0dyGZcRsyU6FA
	72/aYg2VSXYRVEQ4S8ZndhRbgSfd/jG0Uaq0VOJ23ChZF+ricu8nU511kfw1iAaFN1vPZNTPL4I
	CuCfKMonyOe5lfHS4UlRIy5Nflz8rvPEYlF2xxgaW8XY2FYmU7BfTI/UTeWdaI2mNHSlLNCGtox
	z/K2ocMB/bvuzp+fO23gsA6Meh5fh0D9/mydXxcHDJZf5nV6IT6fBb3ToMqmN8KrE1p3ZuDKkcQ
	ljO3ZGS6F329OM6q+7Si2wNfrIcNGQt7UsZSAU9yAzcQVlVO/YzyeGXijTgQaseIdoEN+E283CK
	g5ZfINJ6pLjhQhGTRaqLnrm6FDWZKAb7vKXyoz0jhxQDeXe91ZhSMWa1jWFTNprssRDBTVi+8nI
	K3Csd/V5+HiXo0n55DLDD6QIwvkRTc4VjlGsc=
X-Google-Smtp-Source: AGHT+IESJtnYCC+6tKU/IMMlAFX3OXThvg7/IT5AO+qIlJZ6EL/qIntowvs3vVciOZabgFGZ7594Wg==
X-Received: by 2002:a17:90b:39cc:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-34082fcc5f5mr15216714a91.9.1762156400905;
        Sun, 02 Nov 2025 23:53:20 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:53:20 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chris Li <chrisl@kernel.org>,
	Greg Thelen <gthelen@google.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Wei Xu <weixugc@google.com>
Subject: [PATCH 6.6.y 4/7] mm: memcg: move vmstats structs definition above flushing code
Date: Mon,  3 Nov 2025 15:51:32 +0800
Message-ID: <20251103075135.20254-5-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit e0bf1dc859fdd08ef738824710770a30a8069433 ]

The following patch will make use of those structs in the flushing code,
so move their definitions (and a few other dependencies) a little bit up
to reduce the diff noise in the following patch.

No functional change intended.

Link: https://lkml.kernel.org/r/20231129032154.3710765-3-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Ivan Babrou <ivan@cloudflare.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Wei Xu <weixugc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 mm/memcontrol.c | 148 ++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 433cd273006d..157be6820fd1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -570,6 +570,80 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }

+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGPGIN,
+	PGPGOUT,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+	ZSWPWB,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
+#endif
+};
+
+#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
+static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+
+static void init_memcg_events(void)
+{
+	int i;
+
+	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
+		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
+}
+
+static inline int memcg_events_index(enum vm_event_item idx)
+{
+	return mem_cgroup_events_index[idx] - 1;
+}
+
+struct memcg_vmstats_percpu {
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_MEMCG_EVENTS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Non-hierarchical (CPU aggregated) page state & events */
+	long			state_local[MEMCG_NR_STAT];
+	unsigned long		events_local[NR_MEMCG_EVENTS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_MEMCG_EVENTS];
+};
+
 /*
  * memcg and lruvec stats flushing
  *
@@ -681,80 +755,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }

-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGPGIN,
-	PGPGOUT,
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSCAN_KHUGEPAGED,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGSTEAL_KHUGEPAGED,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-	ZSWPWB,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-	THP_SWPOUT,
-	THP_SWPOUT_FALLBACK,
-#endif
-};
-
-#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
-
-static void init_memcg_events(void)
-{
-	int i;
-
-	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
-		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-}
-
-static inline int memcg_events_index(enum vm_event_item idx)
-{
-	return mem_cgroup_events_index[idx] - 1;
-}
-
-struct memcg_vmstats_percpu {
-	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_MEMCG_EVENTS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
-};
-
-struct memcg_vmstats {
-	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_NR_STAT];
-	unsigned long		events_local[NR_MEMCG_EVENTS];
-
-	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_MEMCG_EVENTS];
-};
-
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	long x = READ_ONCE(memcg->vmstats->state[idx]);
--
2.50.1

