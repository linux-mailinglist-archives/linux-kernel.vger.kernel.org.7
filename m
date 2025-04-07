Return-Path: <linux-kernel+bounces-590333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB5A7D1CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB4F3AD572
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA9212D63;
	Mon,  7 Apr 2025 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa0NHKvE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59699212B11
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990141; cv=none; b=NT/XhbbTE0VRg6aV0TZyBB2CJHac3EJzVq3fUu6S5xIxKQAmu+pQeWShCuQi/Atv7bBt8cXB4O091cIuRU5XwmcThb4qXrggRfjHpDhvlSkZTMoqLsVQz0Z6nt7T65ey87Vseu3zUjz47vagJP5CoafV04RxmCpWPu2lx56s4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990141; c=relaxed/simple;
	bh=cJWez704B+cYj0qCbcC4LlgC40LkagX8bCfp3RDI5Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJHxAl+ciPYeBfKJ4EODc0hmR4eyZnDCVIp/KlIKxy149Ju6W1fkyN8H8gFylf3fADc2q6mliaESgb0u+DANpj1ysRdryrngg1Eqzrj0qSjHo605VpKqr0q09yOsTqvslrO6yUMigNsuRHYxpthrJEPxd2Fk56i0Zh5L0NC8h2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa0NHKvE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743990137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L786tJBb4g/VUThOOO0WmZzQBkK4KkOjcLrm5qiQbdo=;
	b=Oa0NHKvEUS7DWruTy7+MwJKPvJCVxDX2MwBDe8H6hbDG0WjDkmkTLag70mB+a+YiXKUUM7
	6YZUJ8PerWDEzc0qfU1nQAw0n5CKGBKldWByyfgaL+4pXnjGpdGdtLL4L/tl4vJhGpsYpQ
	AnpW/Rju2fn+Q3/2Z06I4N8PS7rAQtw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-8GMhVFGLP-uksPJ5HSPxUg-1; Sun,
 06 Apr 2025 21:42:14 -0400
X-MC-Unique: 8GMhVFGLP-uksPJ5HSPxUg-1
X-Mimecast-MFC-AGG-ID: 8GMhVFGLP-uksPJ5HSPxUg_1743990132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B94818001DE;
	Mon,  7 Apr 2025 01:42:12 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 255181809B71;
	Mon,  7 Apr 2025 01:42:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
Date: Sun,  6 Apr 2025 21:41:58 -0400
Message-ID: <20250407014159.1291785-2-longman@redhat.com>
In-Reply-To: <20250407014159.1291785-1-longman@redhat.com>
References: <20250407014159.1291785-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test due to the fact that two of its test child cgroups which
have a memmory.low of 0 or an effective memory.low of 0 still have low
events generated for them since mem_cgroup_below_low() use the ">="
operator when comparing to elow.

The two failed use cases are as follows:

1) memory.low is set to 0, but low events can still be triggered and
   so the cgroup may have a non-zero low event count. I doubt users are
   looking for that as they didn't set memory.low at all.

2) memory.low is set to a non-zero value but the cgroup has no task in
   it so that it has an effective low value of 0. Again it may have a
   non-zero low event count if memory reclaim happens. This is probably
   not a result expected by the users and it is really doubtful that
   users will check an empty cgroup with no task in it and expecting
   some non-zero event counts.

In the first case, even though memory.low isn't set, it may still have
some low protection if memory.low is set in the parent. So low event may
still be recorded. The test_memcontrol.c test has to be modified to
account for that.

For the second case, it really doesn't make sense to have non-zero
low event if the cgroup has 0 usage. So we need to skip this corner
case in shrink_node_memcgs() by skipping the !usage case. The
"#ifdef CONFIG_MEMCG" directive is added to avoid problem with the
non-CONFIG_MEMCG case.

With this patch applied, the test_memcg_low sub-test finishes
successfully without failure in most cases. Though both test_memcg_low
and test_memcg_min sub-tests may still fail occasionally if the
memory.current values fall outside of the expected ranges.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/vmscan.c                                      | 10 ++++++++++
 tools/testing/selftests/cgroup/test_memcontrol.c |  7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b620d74b0f66..65dee0ad6627 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5926,6 +5926,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }
 
+#ifdef CONFIG_MEMCG
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
@@ -5963,6 +5964,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
+		/* Skip memcg with no usage */
+		if (!page_counter_read(&memcg->memory))
+			continue;
+
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
 			 * Hard protection.
@@ -6004,6 +6009,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		}
 	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
 }
+#else
+static inline void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
+{
+}
+#endif /* CONFIG_MEMCG */
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 16f5d74ae762..bab826b6b7b0 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -525,8 +525,13 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 	}
 
+	/*
+	 * Child 2 has memory.low=0, but some low protection is still being
+	 * distributed down from its parent with memory.low=50M. So the low
+	 * event count will be non-zero.
+	 */
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		int no_low_events_index = 1;
+		int no_low_events_index = 2;
 		long low, oom;
 
 		oom = cg_read_key_long(children[i], "memory.events", "oom ");
-- 
2.48.1


