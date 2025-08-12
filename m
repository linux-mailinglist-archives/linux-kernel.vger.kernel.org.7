Return-Path: <linux-kernel+bounces-764368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A0B2222F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182D46E4F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B252E54AF;
	Tue, 12 Aug 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEGf6Wa8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB22E425E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988821; cv=none; b=qyPgS1Ed08lDfHTurbobtumqSNO4C3MDbwiPRXk/D8hZLmuTADkHMp/JDZi3dQooMtovkcjFrTZaLqnSz/3GHAnHX7jY1qnDEP1qKo7xIPvFzL12fBcTvx/BX6zA/EeG5nJ6E9dx1R5jv5xsre32U/u2+fhhtX9Rc4rdxQF1mMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988821; c=relaxed/simple;
	bh=q2OrfEa0/hqSk1C4Uj0WZG+bdxoGURzCevwAhFOq7KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8U+YxT20roEEexMWekk5wDiDsLF6E+ReYw1H9BAassxCfL5w39ytyPxxVaUGCSo42GY8A4TMc5skqTxvHj0fZuaCjzmEeSoxY8TYvJQdzrhq1ferwb99hVP+HdFI6XdZP0lEJ1beN1E74Tn7vtN0uvYF7PhomknID2nq+x7w5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WEGf6Wa8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24049d1643aso38299435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754988816; x=1755593616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLPnD+avccUvVR9e4PceX6HClVP6oiTocKcKtm4OPbU=;
        b=WEGf6Wa8hLiS8uA6NH9xw+Fcht0mtuQndKCOFMAtb/nMcxgx8VdQcX1LyrtB/5TFS8
         ouNVlRFdbWtLBgVm6C4JlSHDCznXrS+Wxqzi3BwY87fasl9Ie4Ti6F4DChfcGns91XdG
         O1KmbqsuNs3kDfrb3RjpWaTTUwJ4wXL7SPplE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988816; x=1755593616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLPnD+avccUvVR9e4PceX6HClVP6oiTocKcKtm4OPbU=;
        b=fQnmUE1NC583PKFJRI4feA+jGn64fo4pMX6Z7BAGNLI/w9a/KQBY0ZVyEctSyTjhHt
         0iCKw7N2+Su0GKD27yN1tXM0qVG6Y7AlWuK7bCvGFcTlYfFRhQ/G1Etb1Jxe7c9pD/Mf
         3OqQB6/k81avTIjIXguGZHUsDoGpwI0SWdNplinFomfnfIjB26A4XyFtfxW90g8w2KOl
         v40FbiJEj/lIJVaWOtT5vf6RAUHcHFofh32Ku2TugOhxOFe88NeYTMbnaKznb88UIofr
         TaTxl++9B2GZMNnS2FFNWIiLSHEYpbEuye7BoMBC/t+zm5OmHdN885Y/3QA3bT+JE5bo
         Zgpw==
X-Forwarded-Encrypted: i=1; AJvYcCUnOMEy0Gd5LwTTvoNU8mLzhYZnkU0vfeY/IydXXnlPamL46IHByoEgiAchjHMcSO2iebuJFbcmaG+b7KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxIDAioZ73YmlOoUnXXixrvOqciEPp8XJMn0RbR+kgnfmjFNB
	Of5jyyKcHTTqE+wsZc/ogsl06lWzgZxHCXwDafE0qxuKge3azr2nEBVoRiITj/gO8Q==
X-Gm-Gg: ASbGncsYdjol1WI5xoMLnOz+suQCwqUMSLRXfjk26BkrYpOqRfYwa/LFAIF/wwu0uh0
	hG0JoEkDRVpHvHMl8iklv3UgnqC6X/Hlt9jxcPZnbmytNWepL4OoZDVlTDmt30wvtu7XNYjX8Q/
	UcUHPPaqqg0uu9eEIVO+pjBkwcuZtw2IbCdxM2O00SO/HyTzaD8qplGzt4UQpXGwUiN6zY+joRk
	lkENY3lGUW1vJ3My2k4/Jl5nHzIYO+noz2pabd8C0ReVXtmahYclY9pNXeNTVQlCjD6P9pYYRyx
	ua5Tn7F4exXkHBLv7uF4U+1nox0JkkRhHjdOIoIbdPGCBZCB9qALrjtJeofjj5bkCjPGQuqIQqQ
	SzQhkYgXH/g6JfVq284bxCKuRDYJPIod6+m3zx2hw
X-Google-Smtp-Source: AGHT+IE9waI3iD48I1Icaq2kvnzZzP6L7x3PIwO1bJzi0aVtk4t1U+vF1hQKX5e9Odzlm0z9y5S+vw==
X-Received: by 2002:a17:903:a4d:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-242fc230ecamr26464165ad.7.1754988815724;
        Tue, 12 Aug 2025 01:53:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f81e:7c91:8fbf:672a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-243017dd480sm10014365ad.33.2025.08.12.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:53:35 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: Use hashtable for global clk lookups
Date: Tue, 12 Aug 2025 16:53:27 +0800
Message-ID: <20250812085328.3306705-2-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
In-Reply-To: <20250812085328.3306705-1-wenst@chromium.org>
References: <20250812085328.3306705-1-wenst@chromium.org>
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
 drivers/clk/clk.c | 50 +++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2eb63d610cbb..2d54224fb3ef 100644
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
+DEFINE_HASHTABLE(clk_hashtable, CLK_HASH_BITS);
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
2.51.0.rc0.215.g125493bb4a-goog


