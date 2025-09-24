Return-Path: <linux-kernel+bounces-830748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA3B9A71F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EC74A4550
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48930CD94;
	Wed, 24 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKRkWjD4"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0730BF63
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726016; cv=none; b=RQgv8tcMsknSyGJryFWTtnU97av1sOawhToZ/0osHE4YYQh0y395RQMMb6jHK7aY99i7r++ZiuMtQzoLBcO4TrBl1l3dIvcL3XVCb8cfXzsqmmu5szI+94wU5xQMwaOmSskyhGbQeL+GeT9iCoapBuvJw8n7LDVJJqZZa5abFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726016; c=relaxed/simple;
	bh=iVEfUkagpTd8ShTdeYE6IfpxRs8e6FjbaJNwIS6zNps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YAPXh0WJnVnwnadU8e6dYLoglcRK4W1Vsh+4X7mk0pTHv8ebtZeTSH++yZNdH4MVRp4ZuilJ8UuMq9lhQAp8y5jjtnk3I9NAwgHRuHV+HA4nX6TI+SmGGiRdqHlDruPbbtc0gg41HCOWgHcd9ESRXywLkvJPDB6qyrQpDQEzGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKRkWjD4; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62fce1f3fa8so4716688a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726013; x=1759330813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lMKL0dag2cTvl5zrGDAXdNMfc9wzwq11ZbZ3BSylYk=;
        b=VKRkWjD4bdD+WZ5XD8bUleo3jJN1gZRXPTB78N/BD5UX3QzuUyQ4cPROrBoEiYDl3U
         nbZNTPwNU6j9mkXFK7YfhSUwiSs4vqUU8As7d52JV0LVB4UGx/0vO0KvyGeArkgh+c8c
         IPe+ktbffXMi00/TWrLmvgMUmIzmZCG53qbT1czJe1MXnQrBGtlnTwWHO/iyGizoOdA5
         vKSNW2z5VQpi4tfsuHu0iZcnRl1TcBz1JSbfq2b1PTYr1f+2AL0VJUzrEEcZ49J7qlG6
         MXAboNgPWv6u0PhQjAZTBOIplFWxESZTlcYv4Sezv+lzxv8vmj/8dV9MsGprnCkfLZK+
         ry4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726013; x=1759330813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lMKL0dag2cTvl5zrGDAXdNMfc9wzwq11ZbZ3BSylYk=;
        b=soo4jQwVRm/ZLDbGVs9KfgthQG+42Zx17Ls6MIc5573YFPFw2d/QJP/rzu6ZlMy6Jk
         Iew0nuqEnIc0xhSAc9zY1CwfuOvJZvX8YbN12BuTHDhIu62Z6p+Z9aUz0/0n2I3wPZCT
         k2RhqiC8ulnnq0XTbel4HpZ+Lz5mafMwvcEcf7o1GX1U9JbFuPChFMQ0X8zGjNJBQ5P2
         MO6NApiUHHy2QDVzPAlu5n26S4xuiSHCmvVu/EbXo9nE85WbyyJnOdomBdsz2qgQ6XDv
         5Hq8sx59nIzIJnMJNt/vXuwa7gGJ3O0pM3eOTSO8uu5lMD7VOiCGVfCXHb3U5/oYYh2F
         vW1g==
X-Forwarded-Encrypted: i=1; AJvYcCX7cN4TdtbUlpvbTWKTMfT9prMSGcY/QIWy4l+sEhdi+TGaBJt23h/9sq/nWSo/EkjIUl1zZwpnQ+O6uuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/o0CqK1GuL2dh5OINjedS+me0G3V+h3R77dYZmcuw+HGzgtaU
	rnzsXBpPHt3aLoyE/yta7HWNq7gLfhW8HDdQVMzDBQMQFz9DaNj+3xqv3LafQ4Y7vsnuTM16C3m
	hvpIe3PaApKTxxw==
X-Google-Smtp-Source: AGHT+IFVSQFxUV/mTSePnmrlINV4I944f6eUP8KCpi3pssIRknrIWSkYfW/GfKVJFIh3a3hgc0TE+MDy6SWe2w==
X-Received: from edbm26.prod.google.com ([2002:a50:999a:0:b0:634:9b3d:9588])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1d24:b0:634:5722:cc3f with SMTP id 4fb4d7f45d1cf-6346779876dmr4825674a12.16.1758726011350;
 Wed, 24 Sep 2025 08:00:11 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:39 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-4-2d861768041f@google.com>
Subject: [PATCH 04/21] x86/mm/asi: set up asi_nonsensitive_pgd
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Create the initial shared pagetable to hold all the mappings that will
be shared among ASI domains.

Mirror the physmap into the ASI pagetables, but with a maximum
granularity that's guaranteed to allow changing pageblock sensitivity
without having to allocate pagetables, and with everything as
non-present.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h |  4 ++++
 arch/x86/mm/asi.c          | 19 +++++++++++++++++++
 arch/x86/mm/init.c         |  2 ++
 arch/x86/mm/init_64.c      | 25 +++++++++++++++++++++++--
 include/linux/asi.h        |  4 ++++
 init/main.c                |  1 +
 6 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 32a4c04c4be0f6f425c7cbcff4c58f1827a4b4c4..85062f2a23e127c736a92bb0d49e54f6fdcc2a5b 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -12,4 +12,8 @@ static inline bool asi_enabled_static(void)
 	return cpu_feature_enabled(X86_FEATURE_ASI);
 }
 
+void asi_init(void);
+
+extern pgd_t *asi_nonsensitive_pgd;
+
 #endif /* _ASM_X86_ASI_H */
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 8c907f3c84f43f66e412ecbfa99e67390d31a66f..7225f6aec936eedf98cd263d791dd62263d62575 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -1,11 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/asi.h>
 #include <linux/init.h>
+#include <linux/memblock.h>
 #include <linux/string.h>
 
 #include <asm/cmdline.h>
 #include <asm/cpufeature.h>
 
+#include "mm_internal.h"
+
+/*
+ * This is a bit like init_mm.pgd, it holds mappings shared among all ASI
+ * domains.
+ */
+pgd_t *asi_nonsensitive_pgd;
+
 void __init asi_check_boottime_disable(void)
 {
 	bool enabled = false;
@@ -26,3 +35,13 @@ void __init asi_check_boottime_disable(void)
 	if (enabled)
 		setup_force_cpu_cap(X86_FEATURE_ASI);
 }
+
+void __init asi_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ASI))
+		return;
+
+	asi_nonsensitive_pgd = alloc_low_page();
+	if (WARN_ON(!asi_nonsensitive_pgd))
+		setup_clear_cpu_cap(X86_FEATURE_ASI);
+}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index b877a41fc291284eb271ebe764a52730d51da3fc..8fd34475af7ccd49d0124e13a87342d3bfef3e05 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -773,6 +773,8 @@ void __init init_mem_mapping(void)
 	end = max_low_pfn << PAGE_SHIFT;
 #endif
 
+	asi_init();
+
 	/* the ISA range is always mapped regardless of memory holes */
 	init_memory_mapping(0, ISA_END_ADDRESS, PAGE_KERNEL);
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e98e85cf15f42db669696ba8195d8fc633351b26..7e0471d46767c63ceade479ae0d1bf738f14904a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2002,2003 Andi Kleen <ak@suse.de>
  */
 
+#include <linux/asi.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -746,7 +747,8 @@ phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_en
 {
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
 
-	*pgd_changed = false;
+	if (pgd_changed)
+		*pgd_changed = false;
 
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
@@ -780,7 +782,8 @@ phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_en
 					  (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		*pgd_changed = true;
+		if (pgd_changed)
+			*pgd_changed = true;
 	}
 
 	return paddr_last;
@@ -797,6 +800,24 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
 				   prot, init, &pgd_changed);
+
+	/*
+	 * Set up ASI's unrestricted physmap. This needs to mapped at minimum 2M
+	 * size so that regions can be mapped and unmapped at pageblock
+	 * granularity without requiring allocations.
+	 */
+	if (asi_nonsensitive_pgd) {
+		/*
+		 * Since most memory is expected to end up sensitive, start with
+		 * everything unmapped in this pagetable.
+		 */
+		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
+
+		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
+		phys_pgd_init(asi_nonsensitive_pgd, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
+			      prot_np, init, NULL);
+	}
+
 	if (pgd_changed)
 		sync_global_pgds((unsigned long)__va(paddr_start),
 				 (unsigned long)__va(paddr_end) - 1);
diff --git a/include/linux/asi.h b/include/linux/asi.h
index 1832feb1b14d63f05bbfa3f87dd07753338ed70b..cc4bc957274dbf92ce5bf6185a418d0a8d1b7748 100644
--- a/include/linux/asi.h
+++ b/include/linux/asi.h
@@ -11,5 +11,9 @@
 static inline void asi_check_boottime_disable(void) { }
 static inline bool asi_enabled_static(void) { return false; }
 
+#define asi_nonsensitive_pgd NULL
+
+static inline void asi_init(void) { };
+
 #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
 #endif /* _INCLUDE_ASI_H */
diff --git a/init/main.c b/init/main.c
index 07a3116811c5d72cbab48410493b3d0f89d1f1b2..0ec230ba123613c89c4dfbede27e0441207b2f88 100644
--- a/init/main.c
+++ b/init/main.c
@@ -12,6 +12,7 @@
 
 #define DEBUG		/* Enable initcall_debug */
 
+#include <linux/asi.h>
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/extable.h>

-- 
2.50.1


