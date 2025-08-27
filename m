Return-Path: <linux-kernel+bounces-788160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E19B3807F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E83680C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2225934DCC9;
	Wed, 27 Aug 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBq85VXs"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD972610
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292690; cv=none; b=LuY4TU/6GNLNb8Bemil31ZkIJIMTd2e/O6BOE+H3YGQUaXofdsAb8DYoQCluZV68Qrfh4lbH4kJSMPKbkR2YfUu+3B0yJkvBptWG1t31Yh6fnhLs5tkcId6DNrF9KfuFStLD8wE1/lghxz6ZRV6VkccQcs21uN32GUxLER8Y0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292690; c=relaxed/simple;
	bh=gUJIPIaJXkDeLBNzJ+jbvX1ZWY6PwjW3+iZyq0+2v5s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyBv+0SWMnRD6kJFjFIppqSIu/SpG1kosfwd465Roo+K1BNPVi5gcHGGw1RcK9NAMR8j5j2eny2OB2jBZhapem6gsP0RwXe/kea6F629ezyNHY16qaYcFNUZtWcHtuOpe1je5zXow8cG1hf2EDsfuRxLsu/MAGs6SrZxTKsQcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBq85VXs; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afeb71cc67cso106549766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756292687; x=1756897487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAE5CII86KHK3JlA1J37woP/VEU59D1d2hbqyEmTE24=;
        b=iBq85VXsOOMM20HILFUCUwddvx+f21RAPhplQlulUXXg3pbOVh5wMnKNd0gI1Oo++M
         bqEN2Cs5pirNS7Ch17Y2xa/EmJTkt7bM1paJUoENd8LjWOvwOM8Z7Kil06UKXJaTMO8j
         pmbS7m9TdmoW9WHMO8jO5Ae5yqJFNvfqjDhsGgx0hwEUVvC/0tnr6sna+74v7Ebve3VU
         TBWFLiFpqcsvFKBom+tmNaePCRjiiLIsGlLuM+8wYYJM02uJHe3I0bZ/MD2JLlty3VhX
         Z5DHEJT/GT9PgG9zQj3aKbvZox3Uv2HbXeDju/cL9c2cbt/ixWKFy5NaSRC9QStGbQH8
         ZBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756292687; x=1756897487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAE5CII86KHK3JlA1J37woP/VEU59D1d2hbqyEmTE24=;
        b=ZE74nZDuq0ygwRwiooGNI8BAHAwuRci8Cvkg26WqOqaFhfUmXOYwbiA/naJlqV5ziP
         98Ge3OEbkeh7huRI06TEXBrVU1mfXqbC52ster40dSkucjNAlP426QCpRPEMIhmuRc8h
         vBMS3BoJQt7gtPQffSgHBy9QaJzMFJnIbkCUK7F2O/xp/rDCgsQ1IFY6Q8+BAHN1o3YY
         twVD/vEL7Dk3QsPjBl230jVnGCa//JiwJv5SDLb7qZhZxNITZAG5+lm/f9FDdK5DWoLM
         BuXxXu+d7eKCZqbPI/+CQ0Co2mGJMFL7fLMfogfnu379hN6UJ1Lu0y9HSz89XKu3YaYD
         8lfQ==
X-Gm-Message-State: AOJu0YzWzeohGbG+VTb7mb985l2Kk186v/9qC9xVlShk50q/3yC1oeBP
	STVQXghUoQMniX2i/RFod0iNYLnvfGKgdIoG8dIny64LdXV2pzAHu0DKgV4iJkqFsI4GcrlPRMl
	sha2RcSK1jZ+sTg==
X-Google-Smtp-Source: AGHT+IFps824G1+9A1E1L6AAWpNXIwur9m1JpZYdYKH4pXCtjT5yIMTBrMWE7hKq5tOG/iUqapsb98A/ivv/rA==
X-Received: from ejctk13.prod.google.com ([2002:a17:907:c28d:b0:afe:94a7:8b97])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c93:b0:af9:d80f:645d with SMTP id a640c23a62f3a-afe29793340mr1744344266b.57.1756292686965;
 Wed, 27 Aug 2025 04:04:46 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:04:42 +0000
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250827-b4-vma-no-atomic-h-v1-2-5d3a94ae670f@google.com>
Subject: [PATCH 2/3] tools: testing: Use existing atomic.h for vma/radix-tree tests
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

The shared userspace logic used for unit-testing radix-tree and VMA code
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
API. On non-x86 archs this is implemented using
__sync_val_compare_and_swap(). It's not clear why the old version uses
the bool variant instead of the generic "val" one, for now it's assumed
that this was a mistake.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/shared/linux/maple_tree.h |  6 ++----
 tools/testing/vma/linux/atomic.h        | 17 -----------------
 tools/testing/vma/vma_internal.h        |  3 ++-
 3 files changed, 4 insertions(+), 22 deletions(-)

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
index 3639aa8dd2b06ebe5b9cfcfe6669994fd38c482d..a720a4e6bada83e6b32e76762089eeec35ba8fac 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -21,6 +21,7 @@
 
 #include <stdlib.h>
 
+#include <linux/atomic.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
@@ -1381,7 +1382,7 @@ static inline int mapping_map_writable(struct address_space *mapping)
 	do {
 		if (c < 0)
 			return -EPERM;
-	} while (!__sync_bool_compare_and_swap(&mapping->i_mmap_writable, c, c+1));
+	} while (!atomic_cmpxchg(&mapping->i_mmap_writable, c, c+1));
 
 	return 0;
 }

-- 
2.50.1


