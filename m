Return-Path: <linux-kernel+bounces-653125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECBABB521
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A23B7ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CD245032;
	Mon, 19 May 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOpPqdGw"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490201CF96
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636336; cv=none; b=jpo5VQDN0bet6M6gi+UFwqf8EYTM/kBw4MjTaxFV0j0l7CSMYNfU0L/tMaTqaXlS/PjiQSwP58CBrLoqMCcfMOjgWMAXnrXa5IrZFrzpVvWxldd8uwcKRIXI8A/4by8Wc/SXcEGqZgC5uz3amlnU5YN7g/+TZqd//MnxEKsn43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636336; c=relaxed/simple;
	bh=/jQh79tAgtQJLtj+eNyK2IrGdLJQsJ6BkRvDCw707AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T13/i5vRaKAnQKnVFMALdcjS1Drv7EMB+OwKmHII6sMc+6TUbh8Cg/vGape1iLSmG1FOi7Q0G0+8mI3M0yRdZ/lqgPhF4CNfAhFoldkRNkYD8uL1BD4qnYRR1Sg9q6KVGrpcRH8I9jJRSqTAUO+7lT7xmVmL76e8zM+YdPavxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOpPqdGw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747636329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4FZldpF4GqktzniwkIkdN9+wQAuTiNO6J7GT2TDHJM=;
	b=LOpPqdGwVTtIP0zbqyv0THgRp28es+d9NT9WIwpXgEYTvlXV4mQIB6Qk+B83teJozFhY72
	zuoQHmP1oW5upj8znNJGuMDX4O2BCkgKW4snGWa7YoRSAUKeXZFt7ej9Qungt/YyTUGtPq
	jQE+hdenHiYUJ/jG03tvDzsaE8s385s=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v4 1/5] memcg: disable kmem charging in nmi for unsupported arch
Date: Sun, 18 May 2025 23:31:38 -0700
Message-ID: <20250519063142.111219-2-shakeel.butt@linux.dev>
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg accounting and stats uses this_cpu* and atomic* ops. There are
archs which define CONFIG_HAVE_NMI but does not define
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, so
memcg accounting for such archs in nmi context is not possible to
support. Let's just disable memcg accounting in nmi context for such
archs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 init/Kconfig    | 7 +++++++
 mm/memcontrol.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4cdd1049283c..a2aa49cfb8bd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1006,6 +1006,13 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
+config MEMCG_NMI_UNSAFE
+	bool
+	depends on MEMCG
+	depends on HAVE_NMI
+	depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !ARCH_HAVE_NMI_SAFE_CMPXCHG
+	default y
+
 config MEMCG_V1
 	bool "Legacy cgroup v1 memory controller"
 	depends on MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e17b698f6243..532e2c06ea60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2652,6 +2652,9 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
+	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi())
+		return NULL;
+
 	if (in_task()) {
 		memcg = current->active_memcg;
 		if (unlikely(memcg))
-- 
2.47.1


