Return-Path: <linux-kernel+bounces-712501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B4AF0A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 07:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42F117682D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BE230BC5;
	Wed,  2 Jul 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpCZFPmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2322F74F;
	Wed,  2 Jul 2025 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433368; cv=none; b=j477Um0nEqOTsdw1oQvASIw1gNEjRUwOUiL1LkcTEmdMZQCA4GGj2AcMxUCIMjSA1uMhuTTEtkNKOly2+LUBxM030QvoOJHP9UFc6y99BeD5RZ5uMjbLfgL0E4FW9XrybZKd1dAd9GhiNECLFPJeps7rPxtQSrrq1BF9wxo0h4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433368; c=relaxed/simple;
	bh=NXC7V5X3FMbwc1GLLQCWiBZv7p+8RjgN4vG6hiuSoDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fL/mQQZ165pqQtdHh5JdVViwDRRCjejXSNIEqa70r7077LpOc3pQuf6v4t+ZX+lLT5SUvuyIZSsZ3yJu0kwuxYosMYRgspc8848LWUPa7XJvCHUl/t7/EegxciHmB5rtIEOUBuJlRbem7wMs9ZNIgfwUdXJnChVpIKu/QavQ4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpCZFPmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E9DC4CEEE;
	Wed,  2 Jul 2025 05:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433368;
	bh=NXC7V5X3FMbwc1GLLQCWiBZv7p+8RjgN4vG6hiuSoDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpCZFPmZwK/QOUz7maPmsOXQbD7D1Wy7ZVA+MtfsllEjCEZPjGKQtaPtbNilbihS3
	 IZN44M6R7a/CCE9UXc3Bel4ZOUEfYz/Jno/xBS4nNyDbsBjC78bjUJ+r4ftkTpbT7m
	 eftGF13ud+UoXyXfrpOgJU9A6u/0OX7t1BqhObXYjh6lhGKNoQRKeXQac81DT1kGjk
	 cieWk1vku2nd5vMt+NgpAIfBvWx2ncdppAl0RV6CRnGaGHhksLdq4TBfpycOuXuB0l
	 Cka5t6y9Xm60o3psnM8AUVJLVO5fOQQZ5p9NpIjNgJVzwqcZ3hxG8CE5I9S+Vl+nbD
	 H7Hg9deOTtSOA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/6] mm/damon/core: add damos->migrate_dest field
Date: Tue,  1 Jul 2025 22:15:54 -0700
Message-Id: <20250702051558.54138-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702051558.54138-1-sj@kernel.org>
References: <20250702051558.54138-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new field to 'struct damos', namely migrate_dest, to allow DAMON
API callers specify multiple migration destination nodes and their
weights.  Also update 'struct damos' creation and destruction functions
accordingly to initialize the new field and free up the API
caller-allocated buffers on those, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 13 ++++++++++---
 mm/damon/core.c       |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d60addd0b7c8..6370cf44486f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -470,6 +470,7 @@ struct damos_migrate_dest {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @migrate_dest:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
@@ -488,9 +489,12 @@ struct damos_migrate_dest {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @migrate_dest specifies multiple migration target nodes with different
+ * weights for migrate_hot or migrate_cold actions.  @target_nid is ignored if
+ * this is set.
+ *
  * @target_nid is used to set the migration target node for migrate_hot or
- * migrate_cold actions, which means it's only meaningful when @action is either
- * "migrate_hot" or "migrate_cold".
+ * migrate_cold actions, and @migrate_dest is unset.
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
@@ -533,7 +537,10 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		int target_nid;
+		struct {
+			int target_nid;
+			struct damos_migrate_dest migrate_dest;
+		};
 	};
 	struct list_head filters;
 	struct list_head ops_filters;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 979b29e16ef4..185aafa2e401 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -407,6 +407,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->migrate_dest = (struct damos_migrate_dest){};
 	scheme->target_nid = target_nid;
 
 	return scheme;
@@ -449,6 +450,9 @@ void damon_destroy_scheme(struct damos *s)
 
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
+
+	kfree(s->migrate_dest.node_id_arr);
+	kfree(s->migrate_dest.weight_arr);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.39.5

