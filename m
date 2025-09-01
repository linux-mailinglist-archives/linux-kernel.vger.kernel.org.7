Return-Path: <linux-kernel+bounces-795326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D91B3F013
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36191A86EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE4274B5A;
	Mon,  1 Sep 2025 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ry0w2JgS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59A27F00E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759853; cv=none; b=bR5K0cyu8quqZ4xxJOr2lla13kZqx9QzQPevlA619HSD3H7zSiN7tJhQUrwtILNa927AY2IMmV5gZ5EygRIqQgiB37YExEai/ma5rXHFOjR9RTJcU2MkiRcqayMhg377zjGqeV0T0/XrD65f6NGzV2IBKHFXuPH+WET7P/tg814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759853; c=relaxed/simple;
	bh=LVaqk7JPmnXrVJsNutgrz28SAVbYUhoJQ0pBQKyF5xE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dabc4MKm2T9AA/EsZKYDUGKQXqTw5GZ/sLF2/W/mF46WIwbBI6+QIN86NZJcUuwFtWdtM01A60V5SVlDvufE47QWKrZ0oKr/FYP9aP/Uny5TJtcpeqdYNJQdOq9+QyBABpDOh+MlAE6tWwrE5V+z3yEbbXwqKe53fHyl+9taWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ry0w2JgS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc3962aso160518266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759849; x=1757364649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWhGTSQHhd/eK/QU6yjkGMEyVAFgOEBOrFZYGj9rmco=;
        b=Ry0w2JgSZYo6mbYkimgAJ+2ogA+nhsCFxZ3NG8yr+a8tsvJoKiAO4wTvJKIziE7fA/
         DWS8USkUWppnpFJv6Kgthu3XTHc+KsTiNcnQgyvj1Bh7tWU4pYlemrqxINkS2KfFK9a8
         edyhufEvAWPjK3GN66Qb9eBgMO++uFm5FWO+9T0rJXUHEAhVRsE3fL0cOs6O1hVbwxYK
         zMEegfRCy9hsLQml7fhuAVBbpBeYmwfaz0519GR4lVmDvI3FznJVRvDiEDicVODgAz08
         J8121RnURncTws35A9irCE/bNsFeOkFTc+NoBhkmUwlcHQ0kIZ1wy3n/5PTAaRfnr7fh
         izmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759849; x=1757364649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWhGTSQHhd/eK/QU6yjkGMEyVAFgOEBOrFZYGj9rmco=;
        b=c8/ygjCenAcUDenvcXS7+ZuoOmLePK2ZYQ8gwayX2LM0XsjPwStTtoKnDQmI1K2ZBY
         bEMJFgaeKpwmqiMTA+EXmPlvNb36qhKj85GDsCM5V6JND3ly+tGMwuTXuFTJQTIh3azj
         7H6Brjq0tAyBpgz9OlJ3c9o96vp1DEbMbpnT+l8Ix2omf4oOWIAHMwQvVF5qcOni8sQP
         64tLX6rXNVOB3KFxMQx6dHgvKfJpMYiEdyaeSAQd4U840/39Zxf1OSQJyYRtQzufF7Y8
         AwhZVsnOxpRqcZymdyyx0HLCrWdw6d3Gvb81rgLunTPteGJw1iEwPOrUV0qMXMWUl0cB
         g47Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYW30sMpcK1NOe5Itq1+KUy9sxxljs+n1nEecVJQGh0HdZoOBKGmMTmctQg9xmfZfjdcDcekL2z0ID9Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9Xmm8ufEd+OQcWbj4oEkq+qcDug6f7Q7kXjWsOnJrX0qR3r8
	dCaPM16Sc3pKvOQWhHy8eBqqKtevSQ8LnDuTT3xq/vXiMxcVmt71mH9Ndh5Plac3sw4=
X-Gm-Gg: ASbGncvM35G+avdpszPAOatmgstnYkmp2SH6YA3YqxQKSHYVVC+WqkoKP9SQwEaO2PJ
	q4ferN0gTCMTNYwDLZl/GTVBv/369E2mN2+S3eaA4WUy5cAaeswvugJ9xqqZtzSX7fA+ENLeOXm
	FwZwrIlAIjBCxtNnn6b6HE5tkP/+4PiurqFLQYV01N7XTiQVWDAGHhilIm5gbHh/pFcAo+E8i2l
	OB8jpdYFq39N7NfaP3shVj7lg7ukoCJY2OEFYMhfT5C2M14TZ+j5vz5dj+ExRmCs1tqtiPXxM/U
	UM1jIez1UpN+0Toxs43ILQWp5NQ8f+RdARoYuht5UUWbyawTEU+6ag96W17t64omEHkX28d8chi
	ADQfz9dqFefVoeEiGHBe2uXFKRjPDbQXyYvC+dz7UZ/PwPGZoneI0pgVDwtC1aDqRHbTnZaE+Ps
	kow95axHilu85htJGAIGh7Og==
X-Google-Smtp-Source: AGHT+IEMQa/HknSd4gH88/51zayuXYOJi/tyPDkVuWYFrGs29hqpFzGFB6MpSNARYjZr5mEqvUnwhQ==
X-Received: by 2002:a17:907:1c23:b0:ae6:efe1:5baf with SMTP id a640c23a62f3a-b01d8a75cf5mr969826966b.19.1756759849048;
        Mon, 01 Sep 2025 13:50:49 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:48 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 11/12] mm: constify assert/test functions in mm.h
Date: Mon,  1 Sep 2025 22:50:20 +0200
Message-ID: <20250901205021.3573313-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

We select certain assert and test functions which either invoke each
other, functions that are already const-ified, or no further
functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 23864c3519d6..c3767688771c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -703,7 +703,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(const struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
 		vma_assert_locked(vmf->vma);
@@ -716,7 +716,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(const struct vm_fault *vmf)
 {
 	mmap_assert_locked(vmf->vma->vm_mm);
 }
@@ -859,7 +859,7 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 		vma->vm_end >= vma->vm_mm->start_stack;
 }
 
-static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
+static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
 {
 	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
 
@@ -873,7 +873,7 @@ static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_foreign(struct vm_area_struct *vma)
+static inline bool vma_is_foreign(const struct vm_area_struct *vma)
 {
 	if (!current->mm)
 		return true;
@@ -884,7 +884,7 @@ static inline bool vma_is_foreign(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_accessible(struct vm_area_struct *vma)
+static inline bool vma_is_accessible(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
@@ -895,7 +895,7 @@ static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 		(VM_SHARED | VM_MAYWRITE);
 }
 
-static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 {
 	return is_shared_maywrite(vma->vm_flags);
 }
@@ -1839,7 +1839,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 }
 
 #ifdef CONFIG_MMU
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+static inline pte_t mk_pte(const struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
@@ -1854,7 +1854,7 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
+static inline pte_t folio_mk_pte(const struct folio *folio, pgprot_t pgprot)
 {
 	return pfn_pte(folio_pfn(folio), pgprot);
 }
@@ -1870,7 +1870,7 @@ static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
+static inline pmd_t folio_mk_pmd(const struct folio *folio, pgprot_t pgprot)
 {
 	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
 }
@@ -1886,7 +1886,7 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
+static inline pud_t folio_mk_pud(const struct folio *folio, pgprot_t pgprot)
 {
 	return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
 }
@@ -3488,7 +3488,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
-static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_GROWSDOWN)
 		return stack_guard_gap;
@@ -3500,7 +3500,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 	return 0;
 }
 
-static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_start_gap(const struct vm_area_struct *vma)
 {
 	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
@@ -3511,7 +3511,7 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	return vm_start;
 }
 
-static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_end_gap(const struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
 
@@ -3523,7 +3523,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	return vm_end;
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
+static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 {
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
@@ -3540,7 +3540,7 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
-static inline bool range_in_vma(struct vm_area_struct *vma,
+static inline bool range_in_vma(const struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
@@ -3656,7 +3656,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
 					   unsigned int flags)
 {
 	/*
@@ -3786,7 +3786,7 @@ static inline bool debug_guardpage_enabled(void)
 	return static_branch_unlikely(&_debug_guardpage_enabled);
 }
 
-static inline bool page_is_guard(struct page *page)
+static inline bool page_is_guard(const struct page *page)
 {
 	if (!debug_guardpage_enabled())
 		return false;
@@ -3817,7 +3817,7 @@ static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool debug_guardpage_enabled(void) { return false; }
-static inline bool page_is_guard(struct page *page) { return false; }
+static inline bool page_is_guard(const struct page *page) { return false; }
 static inline bool set_page_guard(struct zone *zone, struct page *page,
 			unsigned int order) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
@@ -3899,7 +3899,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	/* number of pfns from base where pfn_to_page() is valid */
 	if (altmap)
@@ -3913,7 +3913,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 	altmap->alloc -= nr_pfns;
 }
 #else
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	return 0;
 }
-- 
2.47.2


