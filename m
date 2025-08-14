Return-Path: <linux-kernel+bounces-767886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A3B25A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6AA1C03F55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71B18786A;
	Thu, 14 Aug 2025 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cE1OH47Y"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3496D2836F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143605; cv=none; b=i6d+FQN3Ms9pO8SEdL68khHO8HtEl2cuiGwhHl67cLLPRP1VPiy75A2Y2BFJ8CTvk6a4ai9cDymM0NJLB6JGyYZRszJhqApEqetF2fHvMHFLU6pwZu0j8XNwR/nYYLqlP489kHn9tLpqhs6hRgqR8ZEbEjhphdHY/Zb628wicbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143605; c=relaxed/simple;
	bh=YjZjxan+726tMVfjFRoet5oSBGRbOVT0WR2k5lcKq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdFNbzKZtIbzb53EkFW+rSa6FHK9Dha8DJh2dZvX1kLZHGcGujrIJFsBlMduWichf6dM/Xv3t2XgJNSB+ZxJumyQeHs/fqO0RHXDesYXR8vji6xHYZLUnIG+zf4aMYE7jHYumct/agm+DbosNnlmL9rhgV4EV1aeg7dxawehy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cE1OH47Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244581cc971so8428065ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143603; x=1755748403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOFtgXblvXLvQMiqNX/nSaOt0iX24nILKNRle7lgCw0=;
        b=cE1OH47YDgQZrun008sPxQZHokUGnGc9uyjp8p7YIH9u9RkauTbTuhMCcf1SCt95IP
         D3erB6hPBGf54gfU73zGSvRGS1yZep+EeIxoc9YZijKE/aUAWEUySI+IBCJ1FFNYBi/2
         mQ5zXxs0yiQ+G1wms/jUSu3nCFquJGkEKEs9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143603; x=1755748403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOFtgXblvXLvQMiqNX/nSaOt0iX24nILKNRle7lgCw0=;
        b=Gl2+rTIgt2ZYM8cH+SCMT3lLVSsKUaicDUAaHtpWRWwEPvSwZLMUEpM3LgYJQxhE5Z
         3fNz9TYn/BI/YeV3tylRuMouh1t/JcFWjzbiuWBMJd7+maQ6ZLVgjgua63JFk5gVH9np
         wnFtbo/OZl+U7plhRaRDv5uI3EIpC4fErKMBuL8kCfFHxq3H3Je5XK0boZe4HD4mt1dY
         kPBZLf0tq390VjGEbk6O7SJKKhKzgYg42hiXUYc7ijVTG1veQu8VyzRpweK23KFgQdnQ
         2af5Bi6NTfjVFvNPoBuKWdZJ0RYoNpjNwMoTbVDY+IC+5XCTAQavTxhun9JmUICrQSua
         wp1w==
X-Forwarded-Encrypted: i=1; AJvYcCWN9fYa6RddkDfzBcHG8hff7yNtMG+bi4JpkYBhoD4qSAK9ficAOXs8jNr9vWRI0bxU4QQ0DwbHVRc1wSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROVGa0fmzCKWX0fh5jJTWlR1Vm/wMOJHNzEjd1nrUULPqgEVl
	UNnBQOqbrPPmQF0441dsvQ5iATVZBSiFkH7lmrzkD9UYFL2CjzEMyGAKeQYvbFt3lg==
X-Gm-Gg: ASbGncvcGpmPnSHh6txTpGjEGcV7XAqw0F++ICkL1+salLC4Yo6lF2G/epmcFkqnE+v
	1Y3U5QVzzOJIdyz2485+c1L7TX/O6WAsCdhwEMmmufTl29NDM6cHOztIT/DoeJCR8+FPz7Vcqat
	d/BrV9KbDN15u4Au4Zw1wELkhHfsSXQgLWC/Qbe9ql0GmrfSs4k8h3IH9k16LklSyzH4zjlJ/W0
	V5LzJU9zL0mAPhGkHNOyKueWyQfU6c8yU1dJ5hXlx5IeC093j3EAF+KukPkVZN3Q2OkCERUzrSz
	oTHr+qp1RrPnVRImrA+zaq9QQnhnNSSMbNj6SWhCs+ALVihyVlgYXyGkeb3pF858Uy5BNRKP3LV
	ylDM67yZ2SlUVy+/buV9ep3dn7hC3jfPUBUx5xsIuLtSK1tXHREY=
X-Google-Smtp-Source: AGHT+IEHqqgL7gnJ9ZHmq6s9ZQxtBH50CdmeXYydDEbOFKWhOpTUig9K37M/wEt9/Gb9Pz9QeiLeew==
X-Received: by 2002:a17:903:2acc:b0:240:52c8:2556 with SMTP id d9443c01a7336-244586da603mr22577075ad.39.1755143603414;
        Wed, 13 Aug 2025 20:53:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c44f:5805:6bc2:66d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm342150205ad.73.2025.08.13.20.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 20:53:23 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: Use hashtable for global clk lookups
Date: Thu, 14 Aug 2025 11:53:16 +0800
Message-ID: <20250814035317.4112336-2-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814035317.4112336-1-wenst@chromium.org>
References: <20250814035317.4112336-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A clk lookup using clk_core_lookup() is currently somewhat expensive
since it has to walk the whole clk tree to find a match. This is
extremely bad in the clk_core_init() function where it is used to look
for clk name conflicts, which is always the worst case of walking the
whole tree. Moreover, the number of clks checked increases as more
clks are registered, causing each subsequent clk registration becoming
slower.

Add a hashtable for doing clk lookups to replace the tree walk method.
On arm64 this increases kernel memory usage by 4 KB for the hashtable,
and 16 bytes (2 pointers) for |struct hlist_node| in each clk. On a
platform with around 800 clks, this reduces the time spent in
clk_core_lookup() significantly:

          |      PID 0      |     kworker     |
          | before |  after | before |  after |
    -------------------------------------------
    avg   | 203 us | 2.7 us | 123 us | 1.5 us |
    -------------------------------------------
    min   | 4.7 us | 2.3 us | 102 us | 0.9 us |
    -------------------------------------------
    max   | 867 us | 4.8 us | 237 us | 3.5 us |
    -------------------------------------------
    culm  | 109 ms | 1.5 ms |  21 ms | 0.3 ms |

This in turn reduces the time spent in clk_hw_register(), and
ultimately, boot time. On a different system with close to 700 clks,
This reduces boot time by around 110 ms. While this doesn't seem like
a lot, this helps in cases where minimizing boot time is important.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- marked hash table as static
---
 drivers/clk/clk.c | 50 +++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2eb63d610cbb..85d2f2481acf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -12,6 +12,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/hashtable.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -21,6 +22,8 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/stringhash.h>
 
 #include "clk.h"
 
@@ -33,6 +36,9 @@ static struct task_struct *enable_owner;
 static int prepare_refcnt;
 static int enable_refcnt;
 
+#define CLK_HASH_BITS 9
+static DEFINE_HASHTABLE(clk_hashtable, CLK_HASH_BITS);
+
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
@@ -87,6 +93,7 @@ struct clk_core {
 	struct clk_duty		duty;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
+	struct hlist_node	hashtable_node;
 	struct hlist_head	clks;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
@@ -395,45 +402,20 @@ struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_parent);
 
-static struct clk_core *__clk_lookup_subtree(const char *name,
-					     struct clk_core *core)
-{
-	struct clk_core *child;
-	struct clk_core *ret;
-
-	if (!strcmp(core->name, name))
-		return core;
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		ret = __clk_lookup_subtree(name, child);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
-}
-
 static struct clk_core *clk_core_lookup(const char *name)
 {
-	struct clk_core *root_clk;
-	struct clk_core *ret;
+	struct clk_core *core;
+	u32 hash;
 
 	if (!name)
 		return NULL;
 
-	/* search the 'proper' clk tree first */
-	hlist_for_each_entry(root_clk, &clk_root_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
-		if (ret)
-			return ret;
-	}
+	hash = full_name_hash(NULL, name, strlen(name));
 
-	/* if not found, then search the orphan tree */
-	hlist_for_each_entry(root_clk, &clk_orphan_list, child_node) {
-		ret = __clk_lookup_subtree(name, root_clk);
-		if (ret)
-			return ret;
-	}
+	/* search the hashtable */
+	hash_for_each_possible(clk_hashtable, core, hashtable_node, hash)
+		if (!strcmp(core->name, name))
+			return core;
 
 	return NULL;
 }
@@ -4013,6 +3995,8 @@ static int __clk_core_init(struct clk_core *core)
 		hlist_add_head(&core->child_node, &clk_orphan_list);
 		core->orphan = true;
 	}
+	hash_add(clk_hashtable, &core->hashtable_node,
+		 full_name_hash(NULL, core->name, strlen(core->name)));
 
 	/*
 	 * Set clk's accuracy.  The preferred method is to use
@@ -4089,6 +4073,7 @@ static int __clk_core_init(struct clk_core *core)
 	clk_pm_runtime_put(core);
 unlock:
 	if (ret) {
+		hash_del(&core->hashtable_node);
 		hlist_del_init(&core->child_node);
 		core->hw->core = NULL;
 	}
@@ -4610,6 +4595,7 @@ void clk_unregister(struct clk *clk)
 
 	clk_core_evict_parent_cache(clk->core);
 
+	hash_del(&clk->core->hashtable_node);
 	hlist_del_init(&clk->core->child_node);
 
 	if (clk->core->prepare_count)
-- 
2.51.0.rc1.163.g2494970778-goog


