Return-Path: <linux-kernel+bounces-793876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3999B3D993
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C201899FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF402505AF;
	Mon,  1 Sep 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QyErU35i"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAB23C513
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707158; cv=none; b=Cjs8ZnXw654O7JtqhzcYn9Sj+kDlTapPl4vbCy6S8vYtG5CD4yrHPRlxlkBrqC2WVdm6HjknMdbomV2a3LM5mIEnt/U3VROpYwywJ0k3tdZ32phbCO0yRtWEVL+h1cz3KRbelCIlLguYV2LKYni6kkFK6Vb8PpCZpqgbIUxUAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707158; c=relaxed/simple;
	bh=/lbuJGSSu9s1xep3m1vDibaxvsuVWqN3rvdpURz10dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTFWAasl4oLhDDzMf+VGugDMjvq2VWtluy03v5imDfz7Fruz6d0hCsXHiTzk51iSUBnjN4R3+3jNRkVvNWzGAp0QEYssh6G2/FE0PDM2/G+yq4aZ/hhJ82MXYyWPvGMtZkcESZ2jgKxRaAOV1WPni/dA3b5kmesY1a0J0OLXdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QyErU35i; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so6178998a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707154; x=1757311954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbOxTOmsEJ7WcickPs/Dyo+zW1ULm2UsA/dTtkyEV5o=;
        b=QyErU35iIbSpn8srw5iP+ui+VT4vU9ZcejhfaE9uqjCQAICtp9nKgv8ubSMlmp+ZOC
         c83ueQnxtAvqxrlm9Cm5utQh3wLDM+wXII/bhvEskn+10tE5qXjatdRFRKam7ySKrcsH
         cyjuf/QhRo7tUkA0ILyUbNJXfY04w5noJQpiJpRHBdAAiKPLC+roCVCr/cBdozmgdhNO
         7Lzeq4H+g0AppVN6nPKfEWo2E66F1OxvoXeEHXSodC+za5sjPf1DljkFqo40dlNK7R3B
         vwakc/cKWXOPJZaSYklaeRbQOXlsUqH6NvK5Vx2nL1D8ERTsbZ3rrnJz48flPDwaykgn
         2UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707154; x=1757311954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbOxTOmsEJ7WcickPs/Dyo+zW1ULm2UsA/dTtkyEV5o=;
        b=luph/AlDAZ9JjNnoYVYR8mJZjKsCcOznYSFTC8iXEHz33l+bFr4Os0OscAMOP5VwEi
         tEsJUBZ5dYrqjMTFxLB7kH1hXNwQMj7vtLX/9U7yyqZOQ0SH/ZQr0WylDLrhAo+6OK8L
         PiIQUptMtBS/VY432ZcHxSV8yS53twW81e2OsRLCO++GDLStgdopVIhROH5VNVv+qOBe
         m9nCzkZSnn8wfg4GeS2SEZyBKwb27JW0JD/oWW4PreWRRnPE/6o4Nd8l6ly7neGgsc/e
         Ez6ju11DbWBNKslG04BQx4CdRIjnZ7/6zdtXFLxfo2R/mE/YX7lAAXwX825Hi9B37zxQ
         YX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWybpdfUNTN6fIeBwT9f63ExnzkE6nV77dU5nJv4iFLiJTrlN6q9mwSt8VO/rz5O4BYOUXUEQS9xPLWOKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLqbdfAUbgpJetQSd5T5EghScPzR2xzHMhftliXbnsyJ3VuPq
	H/ddXjSOngvtFhvo2BrHxyy2LGYdr5IGC1Dyj380q7oRaZvOHB/nnFNnjndq4zAA0Vs=
X-Gm-Gg: ASbGnct+7EUMtQqqTYvMwB2NaJiWIB2U7wW5WCSIB7IcD3juirnBAAmKWoqjLF7qbja
	CHwTj08UAunZYpA8InJ6/FJgZ1dUGURbdlNOpsf/s7YiNINyDo4SfrkpMqgUfGqbDPCZ+flRQu4
	RTEFtEtUBn9Fi7Di5SBaSLDk5+V4DYFgfPn+rlyb0lrO7WmL3eoiyCtBnlc1OYzYj/omdhiKc87
	mZQqW+l5MqnuSZ5TssVbBTl4E6cb4/9ddHLf6NCV12vXgaOVVk4EZEtzesVBazNdMEzNi57OrGI
	utCV2jCMwFB9Gz0697Too8l5/tfzMVmAumZdl8Bp10Rodr/p48JwSs9rDdKyPmqUFXIL6+0F1To
	TtkIV4GqykuqU/M1oYKnOSYlnbwjOkmUXJvECnHxbaijVdqnL1XOK9YhHFKSvbjm113ooa8ts5j
	fpzi5ffO8Unog3DDcuGNS3Dg==
X-Google-Smtp-Source: AGHT+IGunCnqYebXshKmhp69hbzsKN6RWeNNdfy7R5uCmjqSaO23xnCPBnHHUeEvtpUMwNy7FNQfdQ==
X-Received: by 2002:a05:6402:13d1:b0:61a:9385:c785 with SMTP id 4fb4d7f45d1cf-61d26eb5db1mr6033186a12.36.1756707154327;
        Sun, 31 Aug 2025 23:12:34 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:33 -0700 (PDT)
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
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 02/12] mm/pagemap: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:13 +0200
Message-ID: <20250901061223.2939097-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 57 +++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a3e16d74792f..1d35f9e1416e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -140,7 +140,7 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
-static inline bool mapping_empty(struct address_space *mapping)
+static inline bool mapping_empty(const struct address_space *const mapping)
 {
 	return xa_empty(&mapping->i_pages);
 }
@@ -166,7 +166,7 @@ static inline bool mapping_empty(struct address_space *mapping)
  * refcount and the referenced bit, which will be elevated or set in
  * the process of adding new cache pages to an inode.
  */
-static inline bool mapping_shrinkable(struct address_space *mapping)
+static inline bool mapping_shrinkable(const struct address_space *const mapping)
 {
 	void *head;
 
@@ -267,7 +267,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
 	clear_bit(AS_UNEVICTABLE, &mapping->flags);
 }
 
-static inline bool mapping_unevictable(struct address_space *mapping)
+static inline bool mapping_unevictable(const struct address_space *const mapping)
 {
 	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
 }
@@ -277,7 +277,7 @@ static inline void mapping_set_exiting(struct address_space *mapping)
 	set_bit(AS_EXITING, &mapping->flags);
 }
 
-static inline int mapping_exiting(struct address_space *mapping)
+static inline int mapping_exiting(const struct address_space *const mapping)
 {
 	return test_bit(AS_EXITING, &mapping->flags);
 }
@@ -287,7 +287,7 @@ static inline void mapping_set_no_writeback_tags(struct address_space *mapping)
 	set_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
 
-static inline int mapping_use_writeback_tags(struct address_space *mapping)
+static inline int mapping_use_writeback_tags(const struct address_space *const mapping)
 {
 	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
@@ -333,7 +333,7 @@ static inline void mapping_set_inaccessible(struct address_space *mapping)
 	set_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
-static inline bool mapping_inaccessible(struct address_space *mapping)
+static inline bool mapping_inaccessible(const struct address_space *const mapping)
 {
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
@@ -343,18 +343,18 @@ static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_
 	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *const mapping)
 {
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
+static inline gfp_t mapping_gfp_mask(const struct address_space *const mapping)
 {
 	return mapping->gfp_mask;
 }
 
 /* Restricts the given gfp_mask to what the mapping allows. */
-static inline gfp_t mapping_gfp_constraint(struct address_space *mapping,
+static inline gfp_t mapping_gfp_constraint(const struct address_space *mapping,
 		gfp_t gfp_mask)
 {
 	return mapping_gfp_mask(mapping) & gfp_mask;
@@ -477,13 +477,13 @@ mapping_min_folio_order(const struct address_space *mapping)
 }
 
 static inline unsigned long
-mapping_min_folio_nrpages(struct address_space *mapping)
+mapping_min_folio_nrpages(const struct address_space *const mapping)
 {
 	return 1UL << mapping_min_folio_order(mapping);
 }
 
 static inline unsigned long
-mapping_min_folio_nrbytes(struct address_space *mapping)
+mapping_min_folio_nrbytes(const struct address_space *const mapping)
 {
 	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
 }
@@ -497,7 +497,7 @@ mapping_min_folio_nrbytes(struct address_space *mapping)
  * new folio to the page cache and need to know what index to give it,
  * call this function.
  */
-static inline pgoff_t mapping_align_index(struct address_space *mapping,
+static inline pgoff_t mapping_align_index(const struct address_space *const mapping,
 					  pgoff_t index)
 {
 	return round_down(index, mapping_min_folio_nrpages(mapping));
@@ -507,7 +507,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
  */
-static inline bool mapping_large_folio_support(struct address_space *mapping)
+static inline bool mapping_large_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
 	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
@@ -522,7 +522,7 @@ static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 	return PAGE_SIZE << mapping_max_folio_order(mapping);
 }
 
-static inline int filemap_nr_thps(struct address_space *mapping)
+static inline int filemap_nr_thps(const struct address_space *const mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	return atomic_read(&mapping->nr_thps);
@@ -936,7 +936,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  *
  * Return: The index of the folio which follows this folio in the file.
  */
-static inline pgoff_t folio_next_index(struct folio *folio)
+static inline pgoff_t folio_next_index(const struct folio *const folio)
 {
 	return folio->index + folio_nr_pages(folio);
 }
@@ -965,7 +965,7 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  * e.g., shmem did not move this folio to the swap cache.
  * Return: true or false.
  */
-static inline bool folio_contains(struct folio *folio, pgoff_t index)
+static inline bool folio_contains(const struct folio *const folio, pgoff_t index)
 {
 	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
 	return index - folio->index < folio_nr_pages(folio);
@@ -1042,13 +1042,13 @@ static inline loff_t page_offset(struct page *page)
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
  */
-static inline pgoff_t folio_pgoff(struct folio *folio)
+static inline pgoff_t folio_pgoff(const struct folio *const folio)
 {
 	return folio->index;
 }
 
-static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
-					unsigned long address)
+static inline pgoff_t linear_page_index(const struct vm_area_struct *const vma,
+					const unsigned long address)
 {
 	pgoff_t pgoff;
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
@@ -1468,7 +1468,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
  * readahead_pos - The byte offset into the file of this readahead request.
  * @rac: The readahead request.
  */
-static inline loff_t readahead_pos(struct readahead_control *rac)
+static inline loff_t readahead_pos(const struct readahead_control *const rac)
 {
 	return (loff_t)rac->_index * PAGE_SIZE;
 }
@@ -1477,7 +1477,7 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
  * readahead_length - The number of bytes in this readahead request.
  * @rac: The readahead request.
  */
-static inline size_t readahead_length(struct readahead_control *rac)
+static inline size_t readahead_length(const struct readahead_control *const rac)
 {
 	return rac->_nr_pages * PAGE_SIZE;
 }
@@ -1486,7 +1486,7 @@ static inline size_t readahead_length(struct readahead_control *rac)
  * readahead_index - The index of the first page in this readahead request.
  * @rac: The readahead request.
  */
-static inline pgoff_t readahead_index(struct readahead_control *rac)
+static inline pgoff_t readahead_index(const struct readahead_control *const rac)
 {
 	return rac->_index;
 }
@@ -1495,7 +1495,7 @@ static inline pgoff_t readahead_index(struct readahead_control *rac)
  * readahead_count - The number of pages in this readahead request.
  * @rac: The readahead request.
  */
-static inline unsigned int readahead_count(struct readahead_control *rac)
+static inline unsigned int readahead_count(const struct readahead_control *const rac)
 {
 	return rac->_nr_pages;
 }
@@ -1504,12 +1504,12 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
  * readahead_batch_length - The number of bytes in the current batch.
  * @rac: The readahead request.
  */
-static inline size_t readahead_batch_length(struct readahead_control *rac)
+static inline size_t readahead_batch_length(const struct readahead_control *const rac)
 {
 	return rac->_batch_count * PAGE_SIZE;
 }
 
-static inline unsigned long dir_pages(struct inode *inode)
+static inline unsigned long dir_pages(const struct inode *const inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
 			       PAGE_SHIFT;
@@ -1523,8 +1523,8 @@ static inline unsigned long dir_pages(struct inode *inode)
  * Return: the number of bytes in the folio up to EOF,
  * or -EFAULT if the folio was truncated.
  */
-static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
-					      struct inode *inode)
+static inline ssize_t folio_mkwrite_check_truncate(const struct folio *const folio,
+						   const struct inode *const inode)
 {
 	loff_t size = i_size_read(inode);
 	pgoff_t index = size >> PAGE_SHIFT;
@@ -1555,7 +1555,8 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
  * Return: The number of filesystem blocks covered by this folio.
  */
 static inline
-unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
+unsigned int i_blocks_per_folio(const struct inode *const inode,
+				const struct folio *const folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
-- 
2.47.2


