Return-Path: <linux-kernel+bounces-707885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3BAEC8E5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DAE6E1502
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9F25B66A;
	Sat, 28 Jun 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1lVM4NS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B825B2E1;
	Sat, 28 Jun 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129514; cv=none; b=ECRVdDCTf0n1GaLMTMNcpgFjiCFDThk7DTA76E233P7HuJIpnxmKA13wSez1zdSUy8Oy0NMxc47OtQIQoYcxLp5IKlz386BZhYRoW6mkgskuRq6kFroNpOVAOy8ZomEJjmxuOTv0x00vg+nQzEsDWDCl4h6nJ7jFkA0eqFX47Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129514; c=relaxed/simple;
	bh=E987cFasn0aqFLcb3GG3lT/UpsHEEEapIGli+ANI810=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FuWTH0SbY0bl524oMBJO6SbgSsC2Pvf4OMIAiRYS6uf+k+0NTvbYQ1amoTB8rjvmWsfY09gGUJdfSw7P045O51V6c1Wm31nYD/eVzOZUX+MyDUgN5J9jiO95GIokK7BW9HCOWrfIbTFCgirF2NspLq5ev5mHdLNyQwYlpzqi2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1lVM4NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E917DC4CEF6;
	Sat, 28 Jun 2025 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129514;
	bh=E987cFasn0aqFLcb3GG3lT/UpsHEEEapIGli+ANI810=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1lVM4NSUYz57/XIFzh98DET1M+tq3DGlEpvOq5EyyXUJzIS08ity62fiVFsUyC2B
	 ys0uSWXMHJnZsW42GVjJYJxKTpKgp6wIJ3fDzhtuo6i+b593VRJlUZS/c4vm2uc5Vb
	 cnVqsfY0QKcM2Q5oCXKSn5fLmgkgF3m0arKqYF7ToUdZdGGYg9EFhANn5h+iJkJF8x
	 LU5xzKMX+RYx3H4LNyeNEIZU/uAPIfoJCVsPREoDt+zM1CA139tZ62W4c19LT0/y6E
	 OXIJCp68CdGcLpKKlSxSwhZSbF+lXH/eVij3ARttTY+mx6nhDmyZwTT1ZR5Q7NOTjw
	 LuOI2NlK5XJeQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/11] mm/damon/lru_sort: support young page filters
Date: Sat, 28 Jun 2025 09:51:39 -0700
Message-Id: <20250628165144.55528-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors access pattern in the region level, and hence there could
be some page level mismatches.  A few hot pages could be located in cold
region, and vice versa.  Young page filter can be useful for doing
additional page level access check before applying some DAMOS action.

DAMON_LRU_SORT is not using young page filters, though.  Add a parameter
for using it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7513ebc6aeef..3ccde23a8566 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -41,6 +41,21 @@ static bool enabled __read_mostly;
 static bool commit_inputs __read_mostly;
 module_param(commit_inputs, bool, 0600);
 
+/*
+ * Filter [none-]young pages accordingly for LRU [de]prioritizations.
+ *
+ * If this is set, check page level access (youngness) once again before each
+ * LRU [de]prioritization operation.  LRU prioritization operation is skipped
+ * if the page has not accessed since the last check (not young).  LRU
+ * deprioritization operation is skipped if the page has accessed since the
+ * last check (young).  The feature is enabled or disabled if this parameter is
+ * set as ``Y`` or ``N``, respectively.
+ *
+ * Disabled by default.
+ */
+static bool filter_young_pages __read_mostly;
+module_param(filter_young_pages, bool, 0600);
+
 /*
  * Access frequency threshold for hot memory regions identification in permil.
  *
@@ -186,6 +201,28 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
+static int damon_lru_sort_add_filters(struct damos *hot_scheme,
+		struct damos *cold_scheme)
+{
+	struct damos_filter *filter;
+
+	if (!filter_young_pages)
+		return 0;
+
+	/* disallow prioritizing not-young pages */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, false, false);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(hot_scheme, filter);
+
+	/* disabllow de-prioritizing young pages */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(cold_scheme, filter);
+	return 0;
+}
+
 static int damon_lru_sort_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
@@ -219,6 +256,10 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(param_ctx, &hot_scheme, 1);
 	damon_add_scheme(param_ctx, cold_scheme);
 
+	err = damon_lru_sort_add_filters(hot_scheme, cold_scheme);
+	if (err)
+		goto out;
+
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end);
-- 
2.39.5

