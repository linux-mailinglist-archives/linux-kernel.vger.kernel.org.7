Return-Path: <linux-kernel+bounces-872760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4EC11FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C844228EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43B33032D;
	Mon, 27 Oct 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pacyHFTh"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811E32F777
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607076; cv=none; b=MGKrTKshLZLI3NH4dSOuTOGbkNAGsWF5CquWDRLliknhNE4AQf4oBMs/R6ChrlAzdp55+HAMQ8JrBMWLyEaF/LvGNvq8aEW+Cd3gODczJGnOn9eNIuMR9EbHgsq99H0ctWY9DMe2BNkCvt9k3whCk/UiUKKQbnbVI+FsKE6FJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607076; c=relaxed/simple;
	bh=0B+X9FpNu4kGkQG0w7cX0dsTwpSio7rx+GX3WF0gOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYlBx4UInnqs1NDw7pr9AEsvhuvrffCXgeecyj2pXBiYMTyXio9ypXcH3yI4uzUld2t06wwMM5dZkmtSUGYqBelT9wUxusEweaOneMkypTqEpEkJfLuUnU8sE9KPDrfJByxCt+EjKV2+kiI6AOYMK+aKxDnyl7wCzyKpj0dZPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pacyHFTh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0l0t2z6jhNE2z17NKK8gjaGASdsEhVg9kL49c/ISKE=;
	b=pacyHFThuJC47YY9Mr3wRKzrbF0AwB6lU0s2BdtV2dFfiEDufmHfV5ZwlzRWX/d/23k/L0
	F4AO04GiE/rOnYDt8ohD7rimZelbe8iL0wtlTpOTeuFb0KitV8nTFwjwZVnA+9F9krd2qV
	c7mmNiUB9zx4dMX/t50olXVyoMx0Szs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 04/23] mm: define mem_cgroup_get_from_ino() outside of CONFIG_SHRINKER_DEBUG
Date: Mon, 27 Oct 2025 16:17:07 -0700
Message-ID: <20251027231727.472628-5-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mem_cgroup_get_from_ino() can be reused by the BPF OOM implementation,
but currently depends on CONFIG_SHRINKER_DEBUG. Remove this dependency.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..9af9ae28afe7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -832,9 +832,9 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
 }
+#endif
 
 struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
-#endif
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1331,12 +1331,12 @@ static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return 0;
 }
+#endif
 
 static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 {
 	return NULL;
 }
-#endif
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..5d27cd5372aa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3618,7 +3618,6 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return xa_load(&mem_cgroup_ids, id);
 }
 
-#ifdef CONFIG_SHRINKER_DEBUG
 struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 {
 	struct cgroup *cgrp;
@@ -3639,7 +3638,6 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 
 	return memcg;
 }
-#endif
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
 {
-- 
2.51.0


