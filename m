Return-Path: <linux-kernel+bounces-795325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B1B3F010
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5285E1A86B65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A41427F003;
	Mon,  1 Sep 2025 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CjQiT/Ae"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFF27E07E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759852; cv=none; b=lU/zkd+YwQ6rotZcxwFZ0d3FM1nXa8s3xeX3a2bjMf0KNgxw3ZUaUTR7h/DhLlxzfVU+PXWixChA/7VLxlKCZ2iN5Kyrrs3rc5rsZTVbV7Dubavw7E5BJosN091r9KjaXEnbNpUG1zuxi1XOlJo1SOGzGNB3ZWWvAP3e1ar46G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759852; c=relaxed/simple;
	bh=KwxE9HKC3R6D7OzhhihjlkWCGsr1cIfp5nBhsVf+4Dw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNMFVBMKhnKLw6mTOGYeW20OWb7g1VW08eQn7ONtMo49PaHmSepgv+5bEEMmuKoCSVzqfF7fk8Qb7+pppNcANfzzDPwLi8XCf92UCgk2T6fe3WndOBC5iOAN2z7MgK2y0DvkyR0meDRSpnFgQfGwagAqpVcI6uJyQfQ0EgBiJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CjQiT/Ae; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b043a33b060so133022866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759847; x=1757364647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKRurRT2BneWHgryFTDswdmsEJpe2aYTsThQQXosiss=;
        b=CjQiT/Aey60m6cHqynB2oCIS05TMVglRXUPa+tofOoe+FfRkS71VkhEyNatsJ3CQdV
         ogDej4p+JSz+LVrHUfDrlfULe2qLWS0JG4CkpGjvkYMLbt2WjyorHoY7pyMnUJTORKn+
         nXTbAi3POobkEfpl1WfZ2vCEYt3TNKuOb49Ar0v4M7zA9VWO88mpEn/tqUcJ5UQtM6Ag
         AxRoS5S+KdrZ2YuMOOdXl9Lgw0ylWNnb5KhYGZ0Jxz8ZJdctJQ9cl6RxzTQvC34VnF0A
         XstymQnTpT3hod6E9Qq6wmFrgyZpygqy4Kz1sE22Aljyo+NJwN4TvYuRFfDbgBVuqoxb
         wwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759847; x=1757364647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKRurRT2BneWHgryFTDswdmsEJpe2aYTsThQQXosiss=;
        b=U2+R0AC5TRI5A5lgcqsZBElBcXlWi0flPs/vjcuO1ZUNyW3DuJb6fwOtk8zB929LWq
         70KgVK7+bLfH3wxELaSRyDf6NB+cJfwGNPjw4419zP8DRTU6kdyQ/5m0e2fT+Gc0pJgm
         32idy8QuigrP89zNJ+rkjqT9clHswI+i8eJ4+4S2r0CYa6Vbkb63kyIpyrCJ8z0xs6G9
         lO9Qm/mDYLSFSqWswViUs2CCGLzZPZPZWhbX/t14vP2/eBEi/685jpacD/Mw84BYjlHk
         vdjgwZ4bqdaDoMKQeIqIFGhbp0kPeL0Sqs9tqldwTTMDs5c4VVCCIr2+G5dmRt/9uZPo
         ZMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoYTPENyagq1eRU/x5xCEvIeGC+TM/OLcFhSweA/m23TaUqptWZNqx1vuBpbY+Q9z153OaLLUL6LBf5aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHeZtFb/QuGNewbq7P0xRtQzK8DwvIFvqaf4QoeW7+Wr4p5grP
	UYidxLErjePkJjuG14kAsA+Yj9NtQxo/B3kfSS756bwHbVEgBV7r16rvDWE0J/drGDE=
X-Gm-Gg: ASbGncsXT3fsICLegakh8gQQVtmRsrO7sxUUGcod11UQw1P/AEj5SpXcIsYnTOwvHHo
	dERMQuTpGI+xWAfdcrtDbXwlB+PJGzXhUcThADs6OMqYfMBkWAoL2ngWqmjIGpCDUTqVJbSN9k4
	P/0cA7tm1Y1YqTUxQTUyeMCE8GRsxkP1CQMHEyMhw0H7LmGUouJBqG+j7SgUiK8JVpyVw6AyGBE
	T3bb5cS7HfqWYgObvA6yGciICnnti198E9owy1ESy0pVSy5UBHQsh6jIFP11hP/CJ/GhmUlUsTO
	b/FsOab3jL8RctMqyHAduWnfe7aupOdGXveEJyfJtMFuO3SpM2E79/aWOKTlNHzUSFE/Kt58V2R
	pxGzcjRqieaTfODcu5a7nCn2iYixLaFrC+s5qcW5+MQ+eVzqfLjgiUkOpy88Bq+dmnke0v6H8pX
	aRN0pcfFH0SHf2B01pNhKLsg==
X-Google-Smtp-Source: AGHT+IHCmCpvv2lfwK+DFxb+meLDHCpwG00GZqDzUwq/QLfpGxtMz0YN/b/xauU+UDddCcikhmU4Cw==
X-Received: by 2002:a17:907:c04:b0:adf:f8f4:2001 with SMTP id a640c23a62f3a-b01d9772281mr939362966b.49.1756759847019;
        Mon, 01 Sep 2025 13:50:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:46 -0700 (PDT)
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
Subject: [PATCH v6 10/12] mm: constify various inline functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:19 +0200
Message-ID: <20250901205021.3573313-11-max.kellermann@ionos.com>
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

We select certain test functions plus folio_migrate_refs() from
mm_inline.h which either invoke each other, functions that are already
const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

One exception is the function folio_migrate_refs() which does write to
the "new" folio pointer; there, only the "old" folio pointer is being
constified; only its "flags" field is read, but nothing written.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_inline.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 150302b4a905..d6c1011b38f2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -25,7 +25,7 @@
  * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
  * ram or swap backed folio.
  */
-static inline int folio_is_file_lru(struct folio *folio)
+static inline int folio_is_file_lru(const struct folio *folio)
 {
 	return !folio_test_swapbacked(folio);
 }
@@ -84,7 +84,7 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
  * Return: The LRU list a folio should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list folio_lru_list(struct folio *folio)
+static __always_inline enum lru_list folio_lru_list(const struct folio *folio)
 {
 	enum lru_list lru;
 
@@ -141,7 +141,7 @@ static inline int lru_tier_from_refs(int refs, bool workingset)
 	return workingset ? MAX_NR_TIERS - 1 : order_base_2(refs);
 }
 
-static inline int folio_lru_refs(struct folio *folio)
+static inline int folio_lru_refs(const struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags.f);
 
@@ -154,14 +154,14 @@ static inline int folio_lru_refs(struct folio *folio)
 	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + 1;
 }
 
-static inline int folio_lru_gen(struct folio *folio)
+static inline int folio_lru_gen(const struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags.f);
 
 	return ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
 }
 
-static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
+static inline bool lru_gen_is_active(const struct lruvec *lruvec, int gen)
 {
 	unsigned long max_seq = lruvec->lrugen.max_seq;
 
@@ -217,12 +217,13 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
 }
 
-static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct folio *folio,
+static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
+					      const struct folio *folio,
 					      bool reclaiming)
 {
 	int gen;
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	/*
 	 * +-----------------------------------+-----------------------------------+
@@ -302,7 +303,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return true;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
 {
 	unsigned long refs = READ_ONCE(old->flags.f) & LRU_REFS_MASK;
 
@@ -330,7 +331,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
 {
 
 }
@@ -508,7 +509,7 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
 	atomic_dec(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
+static inline bool mm_tlb_flush_pending(const struct mm_struct *mm)
 {
 	/*
 	 * Must be called after having acquired the PTL; orders against that
@@ -521,7 +522,7 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
+static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
 {
 	/*
 	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
@@ -605,7 +606,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static inline bool vma_has_recency(struct vm_area_struct *vma)
+static inline bool vma_has_recency(const struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
 		return false;
-- 
2.47.2


