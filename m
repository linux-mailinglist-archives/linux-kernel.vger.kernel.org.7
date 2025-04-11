Return-Path: <linux-kernel+bounces-599786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB84A857E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A0E1BC396D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F729CB3B;
	Fri, 11 Apr 2025 09:17:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D9293B4C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363068; cv=none; b=nqF04P/D/qklxMFo8KVa1d36BkH3+TJkk58Ztgkc8fbxCIlY9j2xbYh2flpbCHt6UZU7SrAb3yDaoeTljjKRHJawYra2nApUf0yr6vRYiiCTQHqFPzOXptepl7u01M9qU/AVuDdG029eA6le59VtgB5EVsKXHhFWbedlGqI7dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363068; c=relaxed/simple;
	bh=l07SkFupXt7Fs+Ug86M6QqZPGPqN1LJQnhYAEHFmLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA9lBXU6Bcq9dbmWDcQOijcyQbBdNWrNS5jGgKoCU0THQfURz9DjSAfmX1uZR6m1GBiU+BTVfOf+6ZNPWvuHOG3qGM6MOV7xbGeVLYgYvsMprqBsAVV9Wn62MIBvM3yXSo2Riv4B0SFsWmOCcFj1e1qPr3Izbn8iy5PkTIsJekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30AA31596;
	Fri, 11 Apr 2025 02:17:46 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E54D3F6A8;
	Fri, 11 Apr 2025 02:17:42 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [RFC PATCH v4 12/18] mm: Allow __pagetable_ctor() to fail
Date: Fri, 11 Apr 2025 10:16:25 +0100
Message-ID: <20250411091631.954228-13-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250411091631.954228-1-kevin.brodsky@arm.com>
References: <20250411091631.954228-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding construction hooks (that may fail) to
__pagetable_ctor(), make __pagetable_ctor() return a bool,
propagate it to pagetable_*_ctor() and handle failure in
the generic {pud,p4d,pgd}_alloc.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/asm-generic/pgalloc.h | 15 ++++++++++++---
 include/linux/mm.h            | 21 ++++++++++-----------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..3e184f3ca37a 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -178,7 +178,10 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_pud_ctor(ptdesc);
+	if (!pagetable_pud_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __pud_alloc_one(...)	alloc_hooks(__pud_alloc_one_noprof(__VA_ARGS__))
@@ -232,7 +235,10 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_p4d_ctor(ptdesc);
+	if (!pagetable_p4d_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -276,7 +282,10 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
-	pagetable_pgd_ctor(ptdesc);
+	if (!pagetable_pgd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
+		return NULL;
+	}
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd1b918dc294..43e35d41b850 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3077,12 +3077,13 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
-static inline void __pagetable_ctor(struct ptdesc *ptdesc)
+static inline bool __pagetable_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+	return true;
 }
 
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
@@ -3105,8 +3106,7 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
 {
 	if (mm != &init_mm && !ptlock_init(ptdesc))
 		return false;
-	__pagetable_ctor(ptdesc);
-	return true;
+	return __pagetable_ctor(ptdesc);
 }
 
 pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
@@ -3213,8 +3213,7 @@ static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
 	if (mm != &init_mm && !pmd_ptlock_init(ptdesc))
 		return false;
 	ptdesc_pmd_pts_init(ptdesc);
-	__pagetable_ctor(ptdesc);
-	return true;
+	return __pagetable_ctor(ptdesc);
 }
 
 /*
@@ -3236,19 +3235,19 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 	return ptl;
 }
 
-static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pud_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
-static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_p4d_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
-static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+static inline bool pagetable_pgd_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
+	return __pagetable_ctor(ptdesc);
 }
 
 extern void __init pagecache_init(void);
-- 
2.47.0


