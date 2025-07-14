Return-Path: <linux-kernel+bounces-730242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58908B041C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D99A1896FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774C25228D;
	Mon, 14 Jul 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="kYzX2Nm9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CD248F72
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503619; cv=none; b=f8Tr7a+6BkE/xq2nDxJrUdbGvcf0BX5qNlJryYliwU4KU4FT2YOF1byvFnscXoBrfXEo3edFiT5hioMBEeF/VOCQ+6tSPcqNp/5VUpoXVZAQYQBxxS3p6UJ2iQCld7TX0Pb6i7qS/KHa5AjMIvTvhvg4GJSNH07qWJQKPidAND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503619; c=relaxed/simple;
	bh=EzR89/ZKlpIkjzthOy50Fps3KUMoaxG4XdPa6EX+pLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mxIFQQWgiqDE2Sr2+tau6XWUvWO6/HUVNYjVhzNmKrxc3rFTZGecovb7+he9drJm/+e6H/MJV87ZcN521t3MpvMFUWmeNJvN7z2vFf4OXnN6uotZMlPuBlgj6Df3NsGHGF+g/7WWvEx5h6g4uJ5IBPdXWfEtM98+qkiYyRQ4bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=kYzX2Nm9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so30578135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1752503616; x=1753108416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjD3qNRffV1fPCxAkyiPd3YMx1zGbdbkxYO0A6y57I0=;
        b=kYzX2Nm9Ta3k2CkrqMco3TzagSbD7gugeQcJPql/FgyB41L/Scrw4k5YFb/DZYTTrq
         Es3F30SRhwt3sl4RixMr6bnxG78FyPbhIzLEH1apxv4jsDvu0k9ovEncCwkyi3SRJoAi
         EcuqR3Gi3KGCkhdTUXl7dOo3O3liHFMc59xkEMZGwibJv8kFRTuAfxm7O4UUyaIcczmS
         Y9UpTcB744zrIZ0F8JdixHWKcDllehUHBZSQhBfh+jWSOVhLwPNN2s5so6PrZ7jeBBu7
         gOY5bb2mJdRZgdfETahY+erOUpJuFfbm8AJR0n2VfRww2ZXTc0EyiGl4XmeSEGLTuTRd
         Nj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503616; x=1753108416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjD3qNRffV1fPCxAkyiPd3YMx1zGbdbkxYO0A6y57I0=;
        b=Sbt6X93hgs+P0j4QKblXuhzDAC6I1Zup5UPuNjVRBhcUm2c2dAgJ57CmdOaMUXiUB7
         boyzkdq2Ump0RUC52D0P9FXt4IqzC3FwzkIGpoHSd58JOavYnTwh6uXIj9C/+I80lPRs
         MfityVkVOAYKjdBEjX6l4NKI5vx7dc/pjJD2V3/rWLkp+so2PD29PWvGjT5STKylW89X
         QAdguNTxdOtGPMMEm4JUpLjmf3cWic+hbuXHFpOKVabXSseE9xXi+CduIbzh2+h5F8aC
         N5aKcf7mbDB+8Vg33JftgUamsWg8l0t2gXxl/MmScf8ck3SQ1qNBaJfWVavsLtTTGud+
         I8YA==
X-Gm-Message-State: AOJu0YznfRpeMvllzWc7diFTef8OMK/vDWFCsqxHFkxpoUVYYbXTCsqb
	i/Q6azj9GZ1Hu9SlgK2RJ+99NOGAnKR5FL5AsQmWFPT/dmFzMcf08PkGosCwDoreZ90=
X-Gm-Gg: ASbGncsbRDOOSMj2wJpLcZSzo5mVIPOBN0P/brnsUIHqoSH80g5gvrzTPS+/+b9iRiO
	xHsuFZ1H07QWEPnddAFRCOnl2K30VOKo01LW14DKMv32ZVuecLUYXlMB29KJvJM5bfbp5h7Dl7F
	/PWW3E4TmLM9yABjKK9QWE3dw2eXNEw4E6y6EH3PnRdAuCDnpyhu4H99wqnZuTD5uBFi3RdEAsJ
	5txehUtWG6Rfyt/fguUzy5fcuEb7d0pIqyqAdecpJAznonI/aHhfYTu1Inx2izKjluZHiycJ5Wg
	uM2VnUgtjiIeAd7AxfUGowlnt6dS0VKAljf1Lm8Dgvw2koc+O7IWE2x58+E3q6T6rtIIG0i1a8W
	0jc8CUOVav9QLTU4/GtBX1W4=
X-Google-Smtp-Source: AGHT+IHTr5Gho4NUdo+vFql/luwvswl0EbO5oRq2brlzlSf9x0q9cmkpo37KQP1JjIfdW0J5PWJ0tA==
X-Received: by 2002:a05:6000:4a09:b0:3a4:e672:deef with SMTP id ffacd0b85a97d-3b5f35785abmr10164071f8f.36.1752503615784;
        Mon, 14 Jul 2025 07:33:35 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::3d9:33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45624651a09sm3577045e9.12.2025.07.14.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:33:34 -0700 (PDT)
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
Subject: [PATCH] stackdepot: Make max number of pools boot-time configurable
Date: Mon, 14 Jul 2025 15:33:32 +0100
Message-Id: <20250714143332.264997-1-matt@readmodwrite.com>
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
 .../admin-guide/kernel-parameters.txt         |  5 ++
 lib/stackdepot.c                              | 55 +++++++++++++++++--
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5cb36148554..6a6d60de4530 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6542,6 +6542,11 @@
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
index 245d5b416699..f66b1d572efb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -42,6 +42,8 @@
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
 
+static unsigned int stack_max_pools = DEPOT_MAX_POOLS;
+
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
@@ -62,7 +64,7 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack records. */
-static void *stack_pools[DEPOT_MAX_POOLS];
+static void **stack_pools;
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
@@ -101,6 +103,33 @@ static int __init disable_stack_depot(char *str)
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
+		pr_err("stack_depot_max_pools too low, using default\n");
+		goto out;
+	}
+
+	if (max_pools > limit) {
+		pr_err("stack_depot_max_pools too high, using default\n");
+		goto out;
+
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
@@ -182,6 +211,15 @@ int __init stack_depot_early_init(void)
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
 
@@ -231,6 +269,15 @@ int stack_depot_init(void)
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
 
@@ -245,9 +292,9 @@ static bool depot_init_pool(void **prealloc)
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
@@ -273,7 +320,7 @@ static bool depot_init_pool(void **prealloc)
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


