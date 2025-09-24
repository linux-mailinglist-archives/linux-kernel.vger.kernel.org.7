Return-Path: <linux-kernel+bounces-830747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C0B9A716
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3916432789B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D081309EF4;
	Wed, 24 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vx0UKi/A"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336830AAC4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726013; cv=none; b=oY9IXi5IvUlYCaWWQQ3af+bs/zrPiBIDlPIcY6mgc63GsDlX7I/NDdq4zV0l1t3KkKfDyj7IEBO5+wmrTm962cJkUFRrM+JWII3sbpvy4G5SvBqTsQpiQGVGU7GRlJ1SEPWreJoVWc1X0O9Erqwa/aIKvjKrLX6s0amy7qu+ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726013; c=relaxed/simple;
	bh=EYLPQH5oehnbYPc5sxBDHhm4ClGMnbLmbBqQann3GQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jMh9crv5/cHmvZymftbGtwLRH6LY7jZnfUdJL/ryhD4egIxrmMNHbgvcbr8fSE8lGlmixqNO3d3abtlNThg3bSgJynx+nD9SmSPos3cOQY+U649cEFQX/JrXt7QN2MpXNDp48q2aiqm0vSelAN+MPOHqJ9YYlwuxlbBO/iEiego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vx0UKi/A; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ee888281c3so3986265f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726010; x=1759330810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sQ+0/NTgmoYJ7zvD18U+frXGZZeEnJJzFJ7cE/2yig=;
        b=vx0UKi/AOg4yDr0YyRqDSrnXMTTtLjGNWG1r79ZqqnnpTH7CmNrSPWvsqN8PtPaGe8
         4JjQEQ8lVj1rF87HCv2ndCjY5V+um83lMKoZgb6Q/d4a1bYnFYRaC67EtF4dy/9uiaHS
         1d4+ATfBiTIYiKcqSFetp3d9afGyvFy5yIvzJb1566amx6N0yz9hk1F858uo91sDsYAj
         zU0LSZsP6VVGL4ywzgx/7UROLc42SpPDppp4a6qXHJt9mfOuz9f5R5fSD7pabRma7ynX
         aLgvTytEYQNZy0VNyPIBK9rRKJn1z0ukNfC6p5+tI9MZUcOazzwXIpg4dmobUxoSYvZB
         d4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726010; x=1759330810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sQ+0/NTgmoYJ7zvD18U+frXGZZeEnJJzFJ7cE/2yig=;
        b=GyyI/4gwoSy40uetIzZtYlJa+cBRedwTgVQjOugunzaxgSz/ph4olOrORgacxPygRb
         twAUqWTJ8FJ8NK3YwOHwl1/k5eR8HP7gtjLfyPdz2YRCf+fGWIlptTwZ4OCFzAHP9UVK
         xruR1Fb72t77jRsamTZ/AcoCODJ3NaYDiBCNRwr/qczX9Novqr0Mys2NPcLc8iN3xctZ
         utM0ktdJxTU2rz/RiFqJ5OqDBhbAHSD3pKhxCXrN/Rf48AmCxvincoQXJ2tbhylL59au
         ju6xfdMaY9VVsi0MhkZXjLzbSlBAeUPH7UfR+dpmdNKh3gM0KoqbEk+Ggm1QqvKYDGsu
         vEXA==
X-Forwarded-Encrypted: i=1; AJvYcCUgS843G+I5fU2eC4CqxRhEHekba9pQ5NwioUheEnhPZVOl2hGKzpTI9ZWoZQFLUgmYuwIhMVspeBAsjXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLwMnxVtFN9SUN15SBdEi3tRO9SzH+bSbfY9a3ozDYAc6Neq+
	PFaMmL+BMYttKq2eVm0hucBkKDGG+GAOHjD+HaGRx4/FGYr1ZlnLNFkAsTQAHw2m9m9s+UekGXT
	OBAsoNEm0fKdpAw==
X-Google-Smtp-Source: AGHT+IFqsEQb7cIi2yGxxJ+MfZzjIIfAO9RpfOWtkftlHXz5t7D+GW6T5K74X995LeYOztbN6pZKuqk/SB6tcQ==
X-Received: from wrty13.prod.google.com ([2002:a5d:614d:0:b0:402:ec26:76f8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f85:0:b0:3e9:ad34:2b2e with SMTP id ffacd0b85a97d-40e4cb6e211mr232236f8f.46.1758726010290;
 Wed, 24 Sep 2025 08:00:10 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:38 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com>
Subject: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
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

__kernel_physical_mapping_init() will soon need to work on multiple
PGDs, so factor out something similar to phys_p4d_init() and friends,
which takes the base of the PGD as an argument.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0e4270e20fadb578c7fd6bf5c5e4762027c36c45..e98e85cf15f42db669696ba8195d8fc633351b26 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -741,21 +741,20 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 }
 
 static unsigned long __meminit
-__kernel_physical_mapping_init(unsigned long paddr_start,
-			       unsigned long paddr_end,
-			       unsigned long page_size_mask,
-			       pgprot_t prot, bool init)
+phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_end,
+	      unsigned long page_size_mask, pgprot_t prot, bool init, bool *pgd_changed)
 {
-	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
 
+	*pgd_changed = false;
+
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
 	vaddr_start = vaddr;
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
-		pgd_t *pgd = pgd_offset_k(vaddr);
+		pgd_t *pgd = pgd_offset_pgd(pgd_page, vaddr);
 		p4d_t *p4d;
 
 		vaddr_next = (vaddr & PGDIR_MASK) + PGDIR_SIZE;
@@ -781,15 +780,29 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 					  (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		pgd_changed = true;
+		*pgd_changed = true;
 	}
 
-	if (pgd_changed)
-		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
 	return paddr_last;
 }
 
+static unsigned long __meminit
+__kernel_physical_mapping_init(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask,
+			       pgprot_t prot, bool init)
+{
+	bool pgd_changed;
+	unsigned long paddr_last;
+
+	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
+				   prot, init, &pgd_changed);
+	if (pgd_changed)
+		sync_global_pgds((unsigned long)__va(paddr_start),
+				 (unsigned long)__va(paddr_end) - 1);
+
+	return paddr_last;
+}
 
 /*
  * Create page table mapping for the physical memory for specific physical

-- 
2.50.1


