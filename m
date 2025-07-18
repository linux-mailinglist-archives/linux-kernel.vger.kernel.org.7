Return-Path: <linux-kernel+bounces-737110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCBB0A7D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E04F3B01AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0372DECCC;
	Fri, 18 Jul 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="pg7eZaXV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB462DECD8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853176; cv=none; b=W3BkOLSW0JvGUHDNg/w89V4114Kz/AEJLuS/nalC/1J7BfMRLZAKckeV7tbW5mOGV5BwN+FcMc3KhB6g/P/4sam5LI+Fmuxp1HtQohOS30hRgApEi6cBf3GowwzSuQNQlRWnH9ZE82OMMHc1PL0cHPb+16BCNrgytkzy1zxNfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853176; c=relaxed/simple;
	bh=/YavjfLolcjX+5MumKIDqXVLonw2AWhkcQfJhFILlaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CeCmrHfoDW2ycBXNN0HBRzT3b10WQSn4OVDMoEWPTQGOf+0hnYHUy7SxtQBO+HB7gm/adeRm5jGbRWStTLOU6/Gx1g8kHS2LpFlHd0ZckZDDmfo7ux3YCcfwI4pNIOoh5ONrb8Sskef1UYLeWC1Bu1RIm2UbCCQ3NsFN6+vizFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=pg7eZaXV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so21760595e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1752853173; x=1753457973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Be+DLTGtS0yt63YUYopae2oPNezoDOPucTjp27ghVeA=;
        b=pg7eZaXV0GwUGjpPKwHPwY8/8QwASVhCv5qZzaajaG9F+WGCGhakuh1sNXBIZwkz2I
         c8Thyx538NHjbLxivV9Rz6VCgKhAMvlKJAOESYzH6mt+M3KITxROrdI/E9hHrvJBPO8g
         1H6uztY1V2wFs/F/hE7pEN4LAuTPaL2mLyxOHLEuXqXb1FK+V+jnOvxZ2jyL5+7+WSr5
         aAFZog5zlqq7+6mpsYDNM+g3oMk/dcl0G6fsFHSa8ifa8yqWusrGB/n7MpgGA9jpLJm7
         sVSf578SQbvIGFeHHpkurEu/Na/NWslFDIZ/j2B7mAWT/EK7Zu1xg+WqDnjT0fRrI6lS
         O6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853173; x=1753457973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be+DLTGtS0yt63YUYopae2oPNezoDOPucTjp27ghVeA=;
        b=nOYLeOTafkLraHogjS6vquTskI+0/QGcHedGYPf8vVYH3gfl6VQA+SCoktTCmUWFdO
         lL24JzlU1uWa2rGyyACwAKdWd8YTmO0QKq4dGGeNQdwvElz2BMsKVUwxVwl22HY4O5/N
         I9R8vcqUkYF9Gkng7GhPu9/VSlEQx3WGcEPH6V3ounSMfbkagYqyi0sUH+BpikMO3SrD
         Ip7fsVdrKjMJ6eOQhKgqrfxeCO9mW20VbbzMbO8E3zLqVshc64ZWSN0788KGcua546SV
         r9Ks9SqqQ/KXXmh4SzDMUisTcfYHrlJ3212MIWr2nfPtQVAj2E3qgZ+s/kwHgE+8+tZI
         AHJA==
X-Gm-Message-State: AOJu0YxSdCg50kshJb0IzvYU1OZGEeohQ+keE1z2Uzv12hcLz9Pr4xt5
	cKP6Os7cAz+Whkjoeal2L5IT0jyZbemGsihNVrn/mBlvdtQzfdho5X8/7JmwnrtDRSo=
X-Gm-Gg: ASbGncuLBs/jt/wtmPa0MWb9pVa8hX2/BxiJs8Jz4lQvoIlOxxmHP5VusCYYCxRqB65
	scrvG2UV2luS0GiVz7rAIy7m/yliqrmPAKaNPGvXNsi5CGvJdcBR8oru5/WxcaSZrh1tFJFG2T2
	dlClZ5jUb3gpwb0yXJh3WWq7vGMj8XsTRk/sAd7EWJvReoPe67UYUvxg/rE8+pmq0b9Ynk2721O
	PC0UrSqknPTfEho7feoqfMGSoxR5jaWWq98ZE5dZyX/vZJ4Z2iuo/S4Sap7asKydnRQOtjIoamM
	HCMbsdI3fvHzH7Uj3ByJGfkU2GVE41iEvNsSRDSEE0iI3p7W7ZyqynegaoQLRhpr1CL0TQlBQm9
	KdOhUPohEaMTaiO66JK9ZSq8=
X-Google-Smtp-Source: AGHT+IHurkTnkMwyruC7sGSniU6GmXrvp9NgqhlSUCNi0ioo2xYwgATj542PyL9iGey3I1mKYr9CYQ==
X-Received: by 2002:a05:600c:a009:b0:456:13d8:d141 with SMTP id 5b1f17b1804b1-456389d8690mr50600395e9.27.1752853172527;
        Fri, 18 Jul 2025 08:39:32 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::3df:4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5b8117sm23714855e9.9.2025.07.18.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:39:30 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH v4] stackdepot: Make max number of pools boot-time configurable
Date: Fri, 18 Jul 2025 16:39:28 +0100
Message-Id: <20250718153928.94229-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

We're hitting the WARN in depot_init_pool() about reaching the stack
depot limit because we have long stacks that don't dedup very well.

Introduce a new start-up parameter to allow users to set the number of
maximum stack depot pools.

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---

Changes in v4:
 - Simplify initial stack_max_pools value courtesy of akpm

Changes in v3:
 - Switch from build-time to boot-time parameter

Changes in v2:
 - Replace BUILD_BUG_ON with static_assert()
 - Hide STACKDEPOT_MAX_POOLS behind EXPERT

 .../admin-guide/kernel-parameters.txt         |  5 ++
 lib/stackdepot.c                              | 67 ++++++++++++++++---
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..273f6bbd56c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6988,6 +6988,11 @@
 			consumed by the stack hash table. By default this is set
 			to false.
 
+	stack_depot_max_pools= [KNL,EARLY]
+			Specify the maximum number of pools to use for storing
+			stack traces. Pools are allocated on-demand up to this
+			limit. Default value is 8191 pools.
+
 	stacktrace	[FTRACE]
 			Enabled the stack tracer on boot up.
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 73d7b50924ef..de0b0025af2b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,11 +36,11 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_POOLS_CAP 8192
-/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
-#define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
+/*
+ * The pool_index is offset by 1 so the first record does not have a 0 handle.
+ */
+static unsigned int stack_max_pools __read_mostly =
+	MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
 
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
@@ -62,7 +62,7 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack records. */
-static void *stack_pools[DEPOT_MAX_POOLS];
+static void **stack_pools;
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
@@ -101,6 +101,34 @@ static int __init disable_stack_depot(char *str)
 }
 early_param("stack_depot_disable", disable_stack_depot);
 
+static int __init parse_max_pools(char *str)
+{
+	const long long limit = (1LL << (DEPOT_POOL_INDEX_BITS)) - 1;
+	unsigned int max_pools;
+	int rv;
+
+	rv = kstrtouint(str, 0, &max_pools);
+	if (rv)
+		return rv;
+
+	if (max_pools < 1024) {
+		pr_err("stack_depot_max_pools below 1024, using default of %u\n",
+		       stack_max_pools);
+		goto out;
+	}
+
+	if (max_pools > limit) {
+		pr_err("stack_depot_max_pools exceeds %lld, using default of %u\n",
+		       limit, stack_max_pools);
+		goto out;
+	}
+
+	stack_max_pools = max_pools;
+out:
+	return 0;
+}
+early_param("stack_depot_max_pools", parse_max_pools);
+
 void __init stack_depot_request_early_init(void)
 {
 	/* Too late to request early init now. */
@@ -182,6 +210,17 @@ int __init stack_depot_early_init(void)
 	}
 	init_stack_table(entries);
 
+	pr_info("allocating space for %u stack pools via memblock\n",
+		stack_max_pools);
+	stack_pools =
+		memblock_alloc(stack_max_pools * sizeof(void *), PAGE_SIZE);
+	if (!stack_pools) {
+		pr_err("stack pools allocation failed, disabling\n");
+		memblock_free(stack_table, entries * sizeof(struct list_head));
+		stack_depot_disabled = true;
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -231,6 +270,16 @@ int stack_depot_init(void)
 	stack_hash_mask = entries - 1;
 	init_stack_table(entries);
 
+	pr_info("allocating space for %u stack pools via kvcalloc\n",
+		stack_max_pools);
+	stack_pools = kvcalloc(stack_max_pools, sizeof(void *), GFP_KERNEL);
+	if (!stack_pools) {
+		pr_err("stack pools allocation failed, disabling\n");
+		kvfree(stack_table);
+		stack_depot_disabled = true;
+		ret = -ENOMEM;
+	}
+
 out_unlock:
 	mutex_unlock(&stack_depot_init_mutex);
 
@@ -245,9 +294,9 @@ static bool depot_init_pool(void **prealloc)
 {
 	lockdep_assert_held(&pool_lock);
 
-	if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
+	if (unlikely(pools_num >= stack_max_pools)) {
 		/* Bail out if we reached the pool limit. */
-		WARN_ON_ONCE(pools_num > DEPOT_MAX_POOLS); /* should never happen */
+		WARN_ON_ONCE(pools_num > stack_max_pools); /* should never happen */
 		WARN_ON_ONCE(!new_pool); /* to avoid unnecessary pre-allocation */
 		WARN_ONCE(1, "Stack depot reached limit capacity");
 		return false;
@@ -273,7 +322,7 @@ static bool depot_init_pool(void **prealloc)
 	 * NULL; do not reset to NULL if we have reached the maximum number of
 	 * pools.
 	 */
-	if (pools_num < DEPOT_MAX_POOLS)
+	if (pools_num < stack_max_pools)
 		WRITE_ONCE(new_pool, NULL);
 	else
 		WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
-- 
2.34.1


