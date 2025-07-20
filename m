Return-Path: <linux-kernel+bounces-738334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C95B0B733
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4400D3BEA61
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAC239E8B;
	Sun, 20 Jul 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7URi843"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24404239562;
	Sun, 20 Jul 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031832; cv=none; b=TQUmMeKt8FZWoGWe1ae06zHvq33K6KVrRVaCTsX1rlXObNrhpUumbo1xBdckcZwolo1KcfsVeAG6M7ljTwjmNZzJJY8BWH9UsIlg3Sh6m3DF9oaKxR8GrNljHpqp9BNvBGoEEujRtEdCYBsTdOYdDDN56JPI75l/7EwJn2l3W38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031832; c=relaxed/simple;
	bh=kZP9TMK44j+18HVVnFB5kNP/rbjB4yM/tzS9BLvJR7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEYDcwkmkVkwKTup0qDW4QFHFNl7eoH3yvegmVeMRiJIdODZYq5od2Buj06SEOiPsVJIScw2F3bvCi0PYY+7shfmpQg87KfNvDjZwihIZg9bmoySiHnyE6FRGQRF9+m3e7x0Z5agMMULnl/ptn388hecIVFuL69mdhFI97U0ubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7URi843; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8340BC4CEE7;
	Sun, 20 Jul 2025 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031831;
	bh=kZP9TMK44j+18HVVnFB5kNP/rbjB4yM/tzS9BLvJR7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7URi843ye5z+FYnT5BlTEizCjI5a7L/inkAcz+qOdP3nV0HjVFbUM2oDweGXvjK4
	 DsOgf0HimSDZnjX1VF5VpxGMBfZab7VheCvgpESZIPfR6h3/r6xRIM0At9EdfyXVLI
	 nueEeNBt9h0tUZ72XHVidSoMzo9G9s5VYRKHDnCZPFySmtgVXE+huEB/5FaXU3u8fm
	 gSScyR8q5ojarz26PFQTX4g2Y/o6pqEuHW3c+LjLywBZDblU5fdHRQGUYZHTEhFx3Y
	 0MpA1Raifm+YLhKfucKL6iZlbsMNuTbeKn1TQ4r2JnQgfOTj63ExdCGaA0GfzF1mAi
	 7MBBxVxXpQh5A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/22] selftests/damon/sysfs.py: test quota goal commitment
Date: Sun, 20 Jul 2025 10:16:44 -0700
Message-Id: <20250720171652.92309-15-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current DAMOS quota commitment assertion is not testing quota goal
commitment.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index dbe9f1a3b976..93f20c5c6780 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -41,12 +41,28 @@ def assert_watermarks_committed(watermarks, dump):
     assert_true(dump['mid'] == watermarks.mid, 'mid', dump)
     assert_true(dump['low'] == watermarks.low, 'low', dump)
 
+def assert_quota_goal_committed(qgoal, dump):
+    metric_val = {
+            'user_input': 0,
+            'some_mem_psi_us': 1,
+            'node_mem_used_bp': 2,
+            'node_mem_free_bp': 3,
+            }
+    assert_true(dump['metric'] == metric_val[qgoal.metric], 'metric', dump)
+    assert_true(dump['target_value'] == qgoal.target_value, 'target_value',
+                dump)
+    if qgoal.metric == 'user_input':
+        assert_true(dump['current_value'] == qgoal.current_value,
+                    'current_value', dump)
+    assert_true(dump['nid'] == qgoal.nid, 'nid', dump)
+
 def assert_quota_committed(quota, dump):
     assert_true(dump['reset_interval'] == quota.reset_interval_ms,
                 'reset_interval', dump)
     assert_true(dump['ms'] == quota.ms, 'ms', dump)
     assert_true(dump['sz'] == quota.sz, 'sz', dump)
-    # TODO: assert goals are committed
+    for idx, qgoal in enumerate(quota.goals):
+        assert_quota_goal_committed(qgoal, dump['goals'][idx])
     assert_true(dump['weight_sz'] == quota.weight_sz_permil, 'weight_sz', dump)
     assert_true(dump['weight_nr_accesses'] == quota.weight_nr_accesses_permil,
                 'weight_nr_accesses', dump)
-- 
2.39.5

