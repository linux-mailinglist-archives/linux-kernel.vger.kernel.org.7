Return-Path: <linux-kernel+bounces-800346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B17DB4368F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B879483BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6712D5C95;
	Thu,  4 Sep 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE/8Rl5n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0F2D3721
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976671; cv=none; b=cr4qb2UqWZDiXftggAuLEGRQhkS1Egae9wYW02y9kpSZWu+NDyyC4HhD92Fw2Qy92EDvlkj/QfVaRV+o7OgB6r0ANzNbQkBrOg5pW4WNNNbTkLUVVk+9MHhIm+m6G9QdcvB/JZPvD6D+ivcnfddSRTwQPyCfYne7DYSv+6rbw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976671; c=relaxed/simple;
	bh=l6j2BAL8B9Jl9DGCMUcF7Ikqoa6pnHZsWN8KE462QuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jY4reSMlt+RVKd9OW2bkQhlY98+JvBREHw9/UWSGGprHFH9pDeAozSI2IrYuIX7bQVTCoDWFLxdwI8yKS7VT30eElQmIvZ6qkIAFX5YFWAJl8r00WQLG4PBp4sRkx3x+qhrLl50Qyov6mZ3IPrjPg5uc2pQcCJnbipYXDWmu2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE/8Rl5n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756976670; x=1788512670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l6j2BAL8B9Jl9DGCMUcF7Ikqoa6pnHZsWN8KE462QuA=;
  b=jE/8Rl5nvqi7VabHpgn62OCMMb9q7g3PdomSkAYTGVJ0vd9o2gKjj9iE
   LjumagJ3HMnVAHqAtASPtCk8JxaNnf5pQIzOxKn+vEEK8YgFLJSH9VKUc
   u94JmuSdlDyuLMtC1i/HukAknn4z2qxwTXr9RAQJSOtoooWThD4PjQHlO
   ETWpj71Xlrc85+HqGHilkTHC9iiQah3GnryLV5SOm/7TGO0xYWKDhF64f
   Sw952O8MwlZfNQGg0W9NIuQbKfAlA3Z2iEX/Z3scO904HVemih5XksuT6
   dZsC8TBu7LfXtUJ7R9D4L63CySaGNh3ue59Gp4EyzVtAXEw3ztSsmn1im
   Q==;
X-CSE-ConnectionGUID: n0OxwEI2QQiuIOMFAb7/4w==
X-CSE-MsgGUID: jxIdkPOZRBqQAU0+SfzjGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59418322"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59418322"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:04:29 -0700
X-CSE-ConnectionGUID: /g8fJMWZRRO37IE8lAdetQ==
X-CSE-MsgGUID: mHNykIaaS0KaF3glhfuDAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="171771381"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 04 Sep 2025 02:04:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0321794; Thu, 04 Sep 2025 11:04:25 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mapple_tree: Fix build error (`make W=1`)
Date: Thu,  4 Sep 2025 11:04:23 +0200
Message-ID: <20250904090423.2293933-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang complains about unused function:

lib/maple_tree.c:179:19: error: unused function 'mt_alloc_bulk' [-Werror,-Wunused-function]

Fix this by removing unused code.

Fixes: a48d52b2d21b ("maple_tree: Convert forking to use the sheaf interface")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/maple_tree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fce329d6c1b2..ca8b3c2e0362 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -176,11 +176,6 @@ static inline struct maple_node *mt_alloc_one(gfp_t gfp)
 	return kmem_cache_alloc(maple_node_cache, gfp);
 }
 
-static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
-{
-	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
-}
-
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
-- 
2.50.1


