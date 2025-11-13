Return-Path: <linux-kernel+bounces-898455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B8C5555F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB2633493C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C62D2499;
	Thu, 13 Nov 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kI8E//OL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A38296BC4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998424; cv=none; b=o4/Wrq+botJ40VS1tIhtZJayF7wBWcHt1aF4/nawApUQqjVPDm5cfYbpEJ5a4dvDKG0CLuoFl0f39/16x5zXMFROMOdmLEehQqoySZYl0iqOEVzuBLFsU+Udb2CwVsbeTANpRnU7rlSoNkHmJbjzbyeVufXThYQ3PZbwyfgviSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998424; c=relaxed/simple;
	bh=ZJRXoNK6NlJYUiv4dcbkBDt1UpeLKJVItB0z0KLWp0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvYswU/jhFq3ZpJA2Bo/U8KKbsSbfWKTwQ0GBJrZtBDX415Pe+TjbP43NFOzYUKTah00ZnO1ZMOBO3xCCQy17JmH/TX1jjWQ0WnLDhOo36EBchhFOtKaW9bwtjbWV7lG2mii2n1fUgSiOfj7wJc0h0qb2kmIwdihyShkBs2JoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kI8E//OL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29586626fbeso2735455ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998422; x=1763603222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK0WcjEaQwvPVjRkMLc2/R9gHzLJpbaLIGkWXKqwGcI=;
        b=kI8E//OLYgprPYYAWxaK/iZYHGJCDlRfu52jqs0FA4ZGHGM6//6lALhgIZpElHy4NV
         WvQRHk8ucHkaGjLWPC58687Ei27tca/f0w36pusrfm0rncfkFfMoQiC6rAP1tXeH7xq4
         e5JEks5JYEGxFAX+8E4mCNJjbrQjUneK0c8jmXTnrldfI47IprGVhWslj+eR0H03S1wd
         MneX7Q6Y56xEqdYCZmnB8JltUrv4T1UCm8rbj7uFF+ctRwtzUHMp3BSIXkJnWpACKlYB
         g6EVXS7v6dvrxiaw375lE3auJwTMO2R4tGsm1mCLMQkfwGnAsXlKWkX/UZ9EOd9OdBZn
         p4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998422; x=1763603222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XK0WcjEaQwvPVjRkMLc2/R9gHzLJpbaLIGkWXKqwGcI=;
        b=eCVhkBRhE+3rN8ECBiKjW3sBm9up3WWVcwguxttCAKrJJJp5sgqtekOSU1JawNUclm
         yr6BWEcL4YbUl6bzl1pGC85DqQ1TPWYhjASq6Inn8zGW3BRzGZkfcLHYpU6Istkbgzq+
         ofqw/pYbt8UtgmwKUebazOFVRJ9boR5h7T8vq/t0XRuN3FF9ENhNVQpC5VjmpY2WcF5v
         5+AoQ2Rv2N9AZfqK921Biui7D9JLoUXQ+jT87H/J2fVVPz7W16NGZzu0VbM90quBWZML
         2Q3VCtW7sVMcxzFNX94rMSuIDgmE8EbHj6jcFUpALj76jT42VSHzWK9lad4buwinJPpZ
         zVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgXGdav2reONRivRetXOOrn8E/RcVZJZWf98DDg3dEngftvHArwdwJwonyR9L/3JLjLsmexs5gkKbp5AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFC5zcfAqvqcuSHhKkSJXXKNRogw57KU2AfGr6yemOyBsov4wr
	fLUubWLu7NnAW5KRAeyzhoIoRnjNIncH+JkyBUxoBLbq/SSXJWg8JqZXuezFFzFo0RA=
X-Gm-Gg: ASbGncs+lwrwyAYXfaj61xCLBa2JtYri1afG/h0xmNzuDdlwtdGgS54AfYZxRLo4jKo
	4YYo9km2Gjrprs2iSyxFNxnV4NeTpbRR6b2uzgNSND9+0DX/9UfLl1MZYmxG8VZeutK1aLKOZIl
	vkr/7N2qjLJtqWtRMGDTkKDlgZHTFyyNdDlwxWtVYXZ3Jwlv65M3HlaCVAE3kyv4xN7EdpcQswh
	Yv2QjHVR1fROfBoTeKOu9tc41y/N9nuxWnD/DYA/WN1qXrj+dwbXz6b+Ol8sUzByy/G93Yoha44
	29O+/hia6gmlEQY46uZyOYtRCdQIBr0x7WKoy/lxu7dNGDr8XcQ5l4ksooMzKXugcFPMXaPePLd
	IxwcGgPQcVzOcKTgJXtSoHAnfs4hBjPJFbjneT3boFV6cLaVKP9El7VT+fbegmk3McG1zO6Njtw
	KENOyquS/r51W3fZxtNTHZGQ==
X-Google-Smtp-Source: AGHT+IGdLwQpJ+C02LpNGU1KZK8FopHeRZPwq9hf7+jq0mst5qCQq34alBPH74+bRQy7F+ajxgP+5A==
X-Received: by 2002:a17:902:dac3:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2984ed27ec5mr64198655ad.6.1762998421878;
        Wed, 12 Nov 2025 17:47:01 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:01 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 02/22] mm: replace READ_ONCE() with standard page table accessors
Date: Wed, 12 Nov 2025 17:45:15 -0800
Message-ID: <20251113014656.2605447-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Khandual <anshuman.khandual@arm.com>

Replace all READ_ONCE() with a standard page table accessors i.e
pxdp_get() that defaults into READ_ONCE() in cases where platform does not
override.

Link: https://lkml.kernel.org/r/20251007063100.2396936-1-anshuman.khandual@arm.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - New patch for v3 (cherry-picked from linux-next)

 mm/gup.c            | 10 +++++-----
 mm/hmm.c            |  2 +-
 mm/memory.c         |  4 ++--
 mm/mprotect.c       |  2 +-
 mm/sparse-vmemmap.c |  2 +-
 mm/vmscan.c         |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a8ba5112e4d0..b46112d36f7e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -950,7 +950,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
 	if (pud_leaf(pud)) {
@@ -975,7 +975,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d_t *p4dp, p4d;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
 	if (!p4d_present(p4d) || p4d_bad(p4d))
@@ -3060,7 +3060,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 
 	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
-		pud_t pud = READ_ONCE(*pudp);
+		pud_t pud = pudp_get(pudp);
 
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
@@ -3086,7 +3086,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 
 	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
-		p4d_t p4d = READ_ONCE(*p4dp);
+		p4d_t p4d = p4dp_get(p4dp);
 
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(p4d))
@@ -3108,7 +3108,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset(current->mm, addr);
 	do {
-		pgd_t pgd = READ_ONCE(*pgdp);
+		pgd_t pgd = pgdp_get(pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
diff --git a/mm/hmm.c b/mm/hmm.c
index 87562914670a..a56081d67ad6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -491,7 +491,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (!pud_present(pud)) {
 		spin_unlock(ptl);
 		return hmm_vma_walk_hole(start, end, -1, walk);
diff --git a/mm/memory.c b/mm/memory.c
index b59ae7ce42eb..0c295e2fe8e8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6690,12 +6690,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 		goto out;
 
 	p4dp = p4d_offset(pgdp, address);
-	p4d = READ_ONCE(*p4dp);
+	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
 		goto out;
 
 	pudp = pud_offset(p4dp, address);
-	pud = READ_ONCE(*pudp);
+	pud = pudp_get(pudp);
 	if (pud_none(pud))
 		goto out;
 	if (pud_leaf(pud)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 113b48985834..988c366137d5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -599,7 +599,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			break;
 		}
 
-		pud = READ_ONCE(*pudp);
+		pud = pudp_get(pudp);
 		if (pud_none(pud))
 			continue;
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index dbd8daccade2..37522d6cb398 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -439,7 +439,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(READ_ONCE(*pmd))) {
+		if (pmd_none(pmdp_get(pmd))) {
 			void *p;
 
 			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..2239de111fa6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3773,7 +3773,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 	pud = pud_offset(p4d, start & P4D_MASK);
 restart:
 	for (i = pud_index(start), addr = start; addr != end; i++, addr = next) {
-		pud_t val = READ_ONCE(pud[i]);
+		pud_t val = pudp_get(pud + i);
 
 		next = pud_addr_end(addr, end);
 
-- 
2.47.2


