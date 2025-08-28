Return-Path: <linux-kernel+bounces-789955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C0B39D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C462B1C26903
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BEA3101CE;
	Thu, 28 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZ+Rhb9B"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA730F7F5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384092; cv=none; b=CaFHm1vwc6At6r6hniygKR0YFiTgs46O3LAuirvMi/c7JbLvls/J4untEzZK6JdvHZj+zgshfcghWWsMN58GstwhzVN+6NTgXWVaQIALRWp1fxn0HPoK35oq3UgfMj1eu/CgwxJVObs15sQZ2XAXwH4QgT2RGTrmW39ULpTwe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384092; c=relaxed/simple;
	bh=DpUor3KEsPz2OnQ+Y4omnUce5SVbQSwW5xNxUaGt4Xg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLU5DSxo10Zi3TW1Wr9lLsxsFVxXG+Esk3+SMBQ3nZ3oUkPlEPbwhLA1Ue87+iRcXzTyZOnW2j6svJCCLCYs2trHTsUu5ywmkviIQ7w1hwNJoWklGyanu+DTs5Yxkxj1ZL1JrMGRZnuB+PeMenbPPCRLpB1fyYfU3UCUtHETRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZ+Rhb9B; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afcb72a8816so74948066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384089; x=1756988889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7cTx8YnEK6PXjAxYIM2TxKBSe00LYvnBB3H2O1o/mY=;
        b=eZ+Rhb9B5cuYJ8wD5DXbrnu/Q2qfwRimVpZBB8XMccc+kfx1ixAyLgJb5n5naKSVuk
         BE8N58vEVDK1rYPvYUjMgpzv4l4HJRS3bNq2hag0RGQwMJRDv+fEaqnEbJfNJWQx9UV1
         VkI+9g8rQb1L4UzpvxpxpeasP7dzGPoEqqVlLeG4q818ikCXvmM+uUAGmTg4L7psN9/8
         eberFN8txNYacSdAKCG+iBSnRShRr5i4ksf3fjn3xDJiy4tuD72sBRu4KXP5jHLktwjQ
         yTzSLgieWE7Pguip/KKj1vpR5D/Z48Suk5Fp5OCpWLb180BHrSu6s8NB2eYiqDUQME6t
         4xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384089; x=1756988889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7cTx8YnEK6PXjAxYIM2TxKBSe00LYvnBB3H2O1o/mY=;
        b=Pjf1/lBHGhMkb2iDLr1UoyiphlWxSw9EZo/t+NsH+f+I47srAjOnlz1sspi9xWVoGb
         wdysRmERle/KFVtuwAF09E8T+j6xspNweOManSXiy+FDv/KBpzYLIgAIlmuQBqTi937+
         SncAZQj65ANcUYOrfic8QQkGNhX8bbwz8m65BKsscY5bXm/HiDDwD1B56ivgBzVszi1e
         nbRZS/dTCaiIw9G7c9tJVF2i3Ymm4zZRULKuABZcwO3kBqz/egJehoXkjvzaSZeo7YwK
         T+gfEWlqJqlqsHbk6sbmVbaCQOS+jrLWL090vqMXlqPLXanFIY29rhYaUMMbd9/8ZC5f
         zlKw==
X-Gm-Message-State: AOJu0YzhHgjBtZ5Avm+4nfL6fZXTX8wfAA7lNb4ihaGFb1XtWad+ne0P
	ykKskE9Rjn632SvRjTZVzMwLVr4TpZdwwZgn42mdGaY+9NTfIAJWFEkPhCC/zSpg0XDaYzWNZik
	w4/o5aULMwjVoxw==
X-Google-Smtp-Source: AGHT+IEjpL3mL9YVYzvlFjpNuB2q7yGo5muV6qRmjgMsPd3KcbfmlJV+kvknHo72hH9YYv52hL3iJ2LhDTES2w==
X-Received: from ejcvj16.prod.google.com ([2002:a17:907:d490:b0:afe:af3c:d8b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7e9c:b0:af9:8c1f:b290 with SMTP id a640c23a62f3a-afe28f6a866mr1820910266b.29.1756384089249;
 Thu, 28 Aug 2025 05:28:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:28:01 +0000
In-Reply-To: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250828-b4-vma-no-atomic-h-v2-4-02d146a58ed2@google.com>
Subject: [PATCH v2 4/4] tools: testing: Use existing atomic.h for vma/maple tests
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

The shared userspace logic used for unit-testing maple tree and VMA code
currently has its own replacements for atomics helpers. This is not
needed as the necessary APIs already have userspace implementations in
the tools tree. Switching over to that allows deleting a bit of code.

Note that the implementation is different; while the version being
deleted here is implemented using liburcu, the existing version in tools
uses either x86 asm or compiler builtins. It's assumed that both are
equally likely to be correct.

The tools tree's version of atomic_t is a struct type while the version
being deleted was just a typedef of an integer. This means it's no
longer valid to call __sync_bool_compare_and_swap() directly on it. One
option would be to just peek into the struct and call it on the field,
but it seems a little cleaner to just use the corresponding atomic.h
API whic has been added recently. Now the fake mapping_map_writable() is
copied from the real one.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/shared/linux/maple_tree.h |  6 ++----
 tools/testing/vma/linux/atomic.h        | 17 -----------------
 tools/testing/vma/vma_internal.h        | 12 +++---------
 3 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/tools/testing/shared/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
index f67d47d32857cee296c2784da57825c9a31cd340..7d0fadef0f11624dbb110ad351aabdc79a19dcd2 100644
--- a/tools/testing/shared/linux/maple_tree.h
+++ b/tools/testing/shared/linux/maple_tree.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-#define atomic_t int32_t
-#define atomic_inc(x) uatomic_inc(x)
-#define atomic_read(x) uatomic_read(x)
-#define atomic_set(x, y) uatomic_set(x, y)
+#include <linux/atomic.h>
+
 #define U8_MAX UCHAR_MAX
 #include "../../../../include/linux/maple_tree.h"
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
deleted file mode 100644
index 788c597c4fdea7392307de93ff4459453b96179b..0000000000000000000000000000000000000000
--- a/tools/testing/vma/linux/atomic.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef _LINUX_ATOMIC_H
-#define _LINUX_ATOMIC_H
-
-#define atomic_t int32_t
-#define atomic_inc(x) uatomic_inc(x)
-#define atomic_read(x) uatomic_read(x)
-#define atomic_set(x, y) uatomic_set(x, y)
-#define U8_MAX UCHAR_MAX
-
-#ifndef atomic_cmpxchg_relaxed
-#define  atomic_cmpxchg_relaxed		uatomic_cmpxchg
-#define  atomic_cmpxchg_release         uatomic_cmpxchg
-#endif /* atomic_cmpxchg_relaxed */
-
-#endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index f13354bf0a1e3839327da7927c4a7da1530a1693..437d2a1013be418c6d3e77534fa19b0ee1518c9b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -21,6 +21,7 @@
 
 #include <stdlib.h>
 
+#include <linux/atomic.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
@@ -1398,15 +1399,8 @@ static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 
 static inline int mapping_map_writable(struct address_space *mapping)
 {
-	int c = atomic_read(&mapping->i_mmap_writable);
-
-	/* Derived from the raw_atomic_inc_unless_negative() implementation. */
-	do {
-		if (c < 0)
-			return -EPERM;
-	} while (!__sync_bool_compare_and_swap(&mapping->i_mmap_writable, c, c+1));
-
-	return 0;
+	return atomic_inc_unless_negative(&mapping->i_mmap_writable) ?
+		0 : -EPERM;
 }
 
 static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)

-- 
2.50.1


