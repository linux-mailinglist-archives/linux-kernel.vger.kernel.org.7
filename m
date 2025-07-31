Return-Path: <linux-kernel+bounces-752120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD044B17175
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD70B3AE5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8422C08AD;
	Thu, 31 Jul 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="NQ91hoCi"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0692372
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965902; cv=none; b=jFmkdKt7DPTvlttbtTfheOq+a8ifYUMoeK+xopEqv+s3C+n8dCgxZz5pfdrerAwp30SH0XlitFPXLHLl2FlO0EL5RlaasK2XVuiWqyY0guzvLSlGlavlES8gixjyhScYp5JUEiwuH+ZJJXmQ+5rBkg/TT4yPLRwUR7U3zZlAhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965902; c=relaxed/simple;
	bh=CoTa1ptX+puUeW0KbXlZaxqyrwDq/pmc3F9p98bCKrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv4LGuFPGhAjB/xI54u2sXe2vBO210i3O6n9JZnzMYt6O7PB7ZBstCt83RdKW7fcEPrHSOR3W5v1Lnl6p3CeSRtoLTVu6mrlG6+S6L9z8XLG0DehZxjAAc3kofe9pV+rAsbLOrwbC7SkqBzxD8QyLeCKVDjn2JsWpTZyjUjKlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=NQ91hoCi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b77673fd78so270416f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1753965898; x=1754570698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv/CdD5sVojPynaT+sikiBkeVKwnYP1/2qPi04sxsSc=;
        b=NQ91hoCir+X/Bf2dpq0N+Qu8xk/GtTc0OJlSq6/0y8rj0caoz3XCjbDa0yOGim5Dzl
         zvzMI8/yQmH4PWQ58kVAAnxTEbzqbxTJge1xrzLs986lT2FRbZZkGHgbzTVi/ROWYXFd
         q23lkpAhOHv9GwLSZTgtx/OX5Ndb1lSBWhrHhIcqoIgZvShkimiZwmwAkGHmiOKsFh7W
         7U5VwL12D0/vk13NioxOrO1n0gwbWrJoueJSRVEaizQ7s9hQm/D3ena82dhKNFTXyCMC
         I5Jkv2ip8uTBUpQTaMxTVaiFoUrUdZ4n/pS+w+bY9yOJoSQXUthGFeVv6IS2JJxPYh6u
         hW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753965898; x=1754570698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gv/CdD5sVojPynaT+sikiBkeVKwnYP1/2qPi04sxsSc=;
        b=QgZJbAIjKuDCV5LMDMVFFNBE9K6pmohj879pN1NuK3XXtN/0hO/a3/34a8q6NWJy1/
         yhjdGafHh9wRwPa1XVU57+dVDN6gWRld1U1KtFfiPNmPQMceqIN1knUqou3Kul2Vh4IQ
         P1u/t9bx/ooRf0MBtVBR72B7sC5590DYvbrQGJiWdW2SFeAigEzxrTWNS81ksG6mIaub
         /L/eYUB2WL5pKWCC0PC+0ImyrKXU06lIF4ij1AB+XIPxHBzPNLdo4EuwoDkVb/U2WBNz
         D7hK/4hBq0XD31lgHbYFaFp/XBkPILgxMz87ZMGjRss7u5EPSDyiw+A/EqQd4oN+67pE
         mhPg==
X-Gm-Message-State: AOJu0YyboIcGtS7r/XI3QE8mTNwU5jqjoHWSjZm1gltqigwZzIyPcko2
	KTPgElAXHvfA9CjUtCzK+8XCIGe6vbUt2OSxT6beRrfOEOxMNSoMw3akMl/AOVyjFOY=
X-Gm-Gg: ASbGncvTidVBqib2eEEqgLLWDFsyOTo/Egq6X4svdc0ib1bsBGH9SLJYwhW3UygGn6e
	GWgx/Od6Ib/KkdX/wLo9vMOXDMUcO5PKQY+2Bzjv6w/gT2lGU33nsAs6it9Bv/s9gX2whsaFIo9
	scQRxY5+mETff3c0LqFYW3EPgCFAcKxZuQu4dp/HNMIgLnLNdbPspoNPStdbfr8wgTHRP6++En3
	fzAtfSXozwcurKUVtWCh1ETks84TpCeNFXmGUdCmd23aZxVbVYQz54UJo5eDo2lnvk4sY/pj30c
	Lx7KZiFnI5shg9sh0aXrDeo3SoBzs7Wd3yRCFmrc/i1boniVEhrCdtA1Ama+qHeyOzaN1we+oVk
	VU0rrnMAUwoUfHlFJku1GbEJv
X-Google-Smtp-Source: AGHT+IH0JwtaybSzAyKB9AS/Dy/z38iQ5rZnRu/groge1aLWet3ztGskSvvQLBDDVubdRiNKJEkMlQ==
X-Received: by 2002:a05:6000:24c9:b0:3b7:9c88:daac with SMTP id ffacd0b85a97d-3b79c88dbc7mr2111986f8f.53.1753965897919;
        Thu, 31 Jul 2025 05:44:57 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee5795esm25717765e9.25.2025.07.31.05.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:44:56 -0700 (PDT)
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
Subject: [PATCH v5] stackdepot: Make max number of pools boot-time configurable
Date: Thu, 31 Jul 2025 13:44:54 +0100
Message-Id: <20250731124454.2584318-1-matt@readmodwrite.com>
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

Acked-by: Marco Elver <elver@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---

Changes in v5:
 - Add Acked-by tags
 - Document magic number as STACK_MIN_POOLS
 - Clamp out of bounds stack_depot_max_pools values instead of using default
 - Don't blindly follow clang-format

Changes in v4:
 - Simplify initial stack_max_pools value courtesy of akpm

Changes in v3:
 - Switch from build-time to boot-time parameter

Changes in v2:
 - Replace BUILD_BUG_ON with static_assert()
 - Hide STACKDEPOT_MAX_POOLS behind EXPERT

 .../admin-guide/kernel-parameters.txt         |  5 ++
 lib/stackdepot.c                              | 64 ++++++++++++++++---
 2 files changed, 60 insertions(+), 9 deletions(-)

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
index 73d7b50924ef..a9dcfcdc9932 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,11 +36,13 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_POOLS_CAP 8192
-/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
-#define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
+#define STACK_MIN_POOLS 1024
+
+/*
+ * The pool_index is offset by 1 so the first record does not have a 0 handle.
+ */
+static unsigned int stack_max_pools __ro_after_init =
+	MIN((1LL << DEPOT_POOL_INDEX_BITS) - 1, 8192);
 
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
@@ -62,7 +64,7 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack records. */
-static void *stack_pools[DEPOT_MAX_POOLS];
+static void **stack_pools;
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
@@ -101,6 +103,32 @@ static int __init disable_stack_depot(char *str)
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
+	if (max_pools < STACK_MIN_POOLS) {
+		pr_err("stack_depot_max_pools value %u too low, clamping to %d\n",
+		       max_pools, STACK_MIN_POOLS);
+		max_pools = STACK_MIN_POOLS;
+	} else if (max_pools > limit) {
+		pr_err("stack_depot_max_pools value %u too high, clamping to %lld\n",
+		       max_pools, limit);
+		max_pools = limit;
+	}
+
+	stack_max_pools = max_pools;
+
+	return 0;
+}
+early_param("stack_depot_max_pools", parse_max_pools);
+
 void __init stack_depot_request_early_init(void)
 {
 	/* Too late to request early init now. */
@@ -182,6 +210,15 @@ int __init stack_depot_early_init(void)
 	}
 	init_stack_table(entries);
 
+	pr_info("allocating space for %u stack pools via memblock\n", stack_max_pools);
+	stack_pools = memblock_alloc(stack_max_pools * sizeof(void *), PAGE_SIZE);
+	if (!stack_pools) {
+		pr_err("stack pools allocation failed, disabling\n");
+		memblock_free(stack_table, entries * sizeof(struct list_head));
+		stack_depot_disabled = true;
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -231,6 +268,15 @@ int stack_depot_init(void)
 	stack_hash_mask = entries - 1;
 	init_stack_table(entries);
 
+	pr_info("allocating space for %u stack pools via kvcalloc\n", stack_max_pools);
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
 
@@ -245,9 +291,9 @@ static bool depot_init_pool(void **prealloc)
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
@@ -273,7 +319,7 @@ static bool depot_init_pool(void **prealloc)
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


