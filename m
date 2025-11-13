Return-Path: <linux-kernel+bounces-898460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B8C55589
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0576634D00B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F022D9482;
	Thu, 13 Nov 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kxvJLmVG"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2742DC320
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998433; cv=none; b=jYsiWunsTBN9PMKxP98S3USYmRJb5lEkQVGkYGvamz4P2uJJWljWYo2AttBDQwW7P5fXvoqBPuTC6ou86Aig/ngUqQHy4kOB4I0bBOmdcrOnLAQ2333+qHoQHGEBo1r9Izo44J6joTPtIcwwB8EDQ8SJ2lYyvHyD3uJ1rX4n710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998433; c=relaxed/simple;
	bh=+C06/zSjfGX1udawurUHHB8xzM56WaF73/3egno5ghs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhdEeY/HExXSSYwQIiXa4yapRiDY0yG/go7yenVU0Myr1MNJXdxfdzojO1/ev21oY/ZxeypGqmV9Px9ec8L6Fk6eLkqnUzAHHdR6ZREfU/kMiyl7xqjP+Udyupty/gZxDJpKwsvgVxbC4QgnUldPSi8lXeNbCdlYr+0SIowyoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kxvJLmVG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ef378069so2423865ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998431; x=1763603231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpe1iExYP0zyH90A/cjYKaPPTKIVrHTbjuAaN9Ted2E=;
        b=kxvJLmVGMWRqcvcrzMoM9K30KzD+FDPR0W5XPhoiULzT72RMz8HO91Ney/r3Q52mBi
         NPcIRtB83emaSt6QfUJcJM/IDnRQubmgN6EV6IH17ozUQo5aSsBXVwkQ2GKgSR5vDn9O
         MMPTJ/nr6UnqHLgLc2FYLpESGJBK8l8KzNQK84UlyGbaXl+3UovLm/1vLAk35dvtADaC
         lYIfBGn1yC6X93zpFT2FedtMbAdHPfkIN6qGGBXsiyJ9cjD2Y6SZJv71Z2TZMsf+6TQS
         U+6apNTOUQE8fPYCbV0cJRTnZRfsewm8gX2gc7Om7W5GYKn887j1Ax32J5lLn7HYk+6S
         BR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998431; x=1763603231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpe1iExYP0zyH90A/cjYKaPPTKIVrHTbjuAaN9Ted2E=;
        b=W3bkkWSLuUoLPK1Ahm0RPjIAoolIPsGUHDG53rbcgJZ8ehyTvvKbKMCeboaGQrJLhf
         fLfLta4QmEyHG1uF0dhEHl9WB9ole6fuAYjntAQ3DEntkfvCBtKOg7hwubZnvQdwEjiL
         Ybw5NxOV28oRoJTEvrknCCb4y41rMbE05vT0tQqRvH7mmmbhRJ9u4Xoi7uhdbeZh3GC8
         QuXyPw3qBflTB4wPfShiIgsE66+FPnwjkqG/5kP/KqSGMmBVbwjt4Jyi2uEnUy3M3usK
         h1xB/ejSb2lrCI35hRGAzkyl0N99XbCnJ1tmdmnPjqgR0GOqkyDEZi8H58IfJg08oy5E
         uIWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdmsHdxuYQBYJflZ/qijJgIdsKAjCz6KKT+2ysTahEAXQ0YSletB1t+1vL4ES69kieIBNjUQVWDmeais=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvCzpjIsm+RI+cbE4pAQR1gTIgYRACJ4G0ZfEFry3wU79sDwc
	tTFOtbKugC6KqAJAoh+2CuXriOnCB1nLkeLviKQi4os9Q1sJoM2F0+1S3zpMEvM4RyA=
X-Gm-Gg: ASbGncueTyIVNwlp4vVOAa53UZEbpDAGvkpR4FNcGxeBvfXbcEHibW6qx2sD7/8h1Sb
	GaA+mBkNxOKaqxi+3LTpRIe91dXQhPPdxUjypPAsgPCRvX3Kl3npiRDp1+pgcVJl8SR5y3ZFkvJ
	OpVlfwO8NugoJR/qx7v7hoXS/0sNd5cxPymtma83HocY+hn7rc38AbroixySDDEhddWRoCigoBS
	X8ZYMkxCeVJZah+fIZB1DCf6ZyRajoRf+/mJtikUEUTD0FAxbBX0Vd3HiRh06EqQ5odWBxmmRdj
	a/kUAXmGmFmJR4R0Utvn2LguSyTeXneLvwBxgSwAXuno0P4IaGXzePG+43+28TdwjfLAuwA0SCH
	itO17zeO6KU/CaFIHzg/axqSyt9xWzRRJBXHrMHuwTT8T2sEqlun5/fsw4gl1j4bXCDXZUzhfg/
	9jfFmh8AP7lja2Y1514EZfIg==
X-Google-Smtp-Source: AGHT+IHfQlkxOaBsnfDtOhaN9Eg9wG5LhwHH/6CgE2hK5xO5V/1h7VmoyWUWgcNESoHw3XrIzaUDgw==
X-Received: by 2002:a17:902:ebc7:b0:298:481c:cbd4 with SMTP id d9443c01a7336-2984eda4101mr66654135ad.26.1762998431452;
        Wed, 12 Nov 2025 17:47:11 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:11 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 08/22] mm: Allow page table accessors to be non-idempotent
Date: Wed, 12 Nov 2025 17:45:21 -0800
Message-ID: <20251113014656.2605447-9-samuel.holland@sifive.com>
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

Currently, some functions such as pte_offset_map() are passed both
pointers to hardware page tables, and pointers to previously-read PMD
entries on the stack. To ensure correctness in the first case, these
functions must use the page table accessor function (pmdp_get()) to
dereference the supplied pointer. However, this means pmdp_get() is
called twice in the second case. This double call must be avoided if
pmdp_get() applies some non-idempotent transformation to the value.

Avoid the double transformation by calling set_pmd() on the stack
variables where necessary to keep set_pmd()/pmdp_get() calls balanced.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 kernel/events/core.c  | 2 ++
 mm/gup.c              | 3 +++
 mm/khugepaged.c       | 6 ++++--
 mm/page_table_check.c | 3 +++
 mm/pgtable-generic.c  | 2 ++
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fa4f9165bd94..7969b060bf2d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8154,6 +8154,8 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	if (pmd_leaf(pmd))
 		return pmd_leaf_size(pmd);
 
+	/* transform pmd as if &pmd pointed to a hardware page table */
+	set_pmd(&pmd, pmd);
 	ptep = pte_offset_map(&pmd, addr);
 	if (!ptep)
 		goto again;
diff --git a/mm/gup.c b/mm/gup.c
index 549f9e868311..aba61704049e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2844,7 +2844,10 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	int ret = 0;
 	pte_t *ptep, *ptem;
 
+	/* transform pmd as if &pmd pointed to a hardware page table */
+	set_pmd(&pmd, pmd);
 	ptem = ptep = pte_offset_map(&pmd, addr);
+	pmd = pmdp_get(&pmd);
 	if (!ptep)
 		return 0;
 	do {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1bff8ade751a..ab1f68a7bc83 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1724,7 +1724,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		struct mmu_notifier_range range;
 		struct mm_struct *mm;
 		unsigned long addr;
-		pmd_t *pmd, pgt_pmd;
+		pmd_t *pmd, pgt_pmd, pmdval;
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool success = false;
@@ -1777,7 +1777,9 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 */
 		if (check_pmd_state(pmd) != SCAN_SUCCEED)
 			goto drop_pml;
-		ptl = pte_lockptr(mm, pmd);
+		/* pte_lockptr() needs a value, not a pointer to a page table */
+		pmdval = pmdp_get(pmd);
+		ptl = pte_lockptr(mm, &pmdval);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 31f4c39d20ef..77d6688db0de 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -260,7 +260,10 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		return;
 
 	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
+		/* transform pmd as if &pmd pointed to a hardware page table */
+		set_pmd(&pmd, pmd);
 		pte_t *ptep = pte_offset_map(&pmd, addr);
+		pmd = pmdp_get(&pmd);
 		unsigned long i;
 
 		if (WARN_ON(!ptep))
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 63a573306bfa..6602deb002f1 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -299,6 +299,8 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		pmd_clear_bad(pmd);
 		goto nomap;
 	}
+	/* transform pmdval as if &pmdval pointed to a hardware page table */
+	set_pmd(&pmdval, pmdval);
 	return __pte_map(&pmdval, addr);
 nomap:
 	rcu_read_unlock();
-- 
2.47.2


