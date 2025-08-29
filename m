Return-Path: <linux-kernel+bounces-792296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61931B3C278
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FCD1C87D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D079345728;
	Fri, 29 Aug 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Y/yLeIIE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4E2749CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492332; cv=none; b=MAmBMBVKJl4fzHN4hPIYo0dAulEAlbUFvBPsj7bHVjPSWs+UCcrlIa/3nRJykSZWv6i3u0BkgZNqJM6YSAGrc1EC1zuF7BXQoA/UJDwTSnKRZGMgGpKH0cqFel2gk90+uQolLkswLSdiq+B4uAnk47EQywLzrN0H+v4SC+pEPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492332; c=relaxed/simple;
	bh=d53W0PAMwqxqDV7iqxU0J6guyLEFfIoIuFOwA5UdDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD/nHMAB1mZtcDVtybgqcxsFi5g3DpwEGPUtR/jH2yCy4XvkNwM6IJ1iql8tfdCpxtq9UEFTVnAyGJYBWEOMA8aR5amRY3Dm1J7ulc1gxUYsIawWo8IINiNDXz4fDARoOiTMuMpC28Ly6eCLIwCjKnAw/fXFZK+LMyp97Hb0Pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Y/yLeIIE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb72d51dcso358060966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492329; x=1757097129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EDFLxjASQVlPYlwefEaYkxxqYLA/xYc3thBaHxBLgU=;
        b=Y/yLeIIE/JA6s6eW2/+shCab9+z0nnHxMi91nR1OhGVbl6b44fBpdwkB2fEbhSxHSm
         iGSyBAeJgoeWZv/Jo14tCphhh/GObwHVmFcEy2rnnPPsKUKKXc9b5b5wd6m6uDy211Qb
         qQF2CR8XfiqIUQW0qV1HTKro3Gfmq4THa+vYkLnkhAyxVquXTvRC/Rc8JZjIq96luUbL
         bfKoYk9oAq3p9ISOSY6eiK7GdnQoidEBVnMJeCMUq2sk83qAL7VVUAJ8TNH3V/6lBAq2
         C0gjcHWtIOw0pYaYVM5nPsYMaLZzbWLtFLFRx4HaKCdMr0pZKoYpYqpQp653kuhNO3Vs
         Wrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492329; x=1757097129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EDFLxjASQVlPYlwefEaYkxxqYLA/xYc3thBaHxBLgU=;
        b=u9PagjeLCqhZd/1prC0oZyAKOagPoONkGOyNjkyA/3JqxzTIrzgT0xolngx3cVE+bm
         AN/MvaBJ3w9uqp6InV0vQvlTK07H8kVCRY/Otu3AjqDUwS1y9KkkflJ0nScMqWMIttEY
         zLA4YPYMTUl7lzw1OfomeENvr2ClBvCjhuPlSSbS5OuUHb5zzvNk3B+xFttee3qRlOck
         cmD0KSSFHhSolg0cFZ53zwMmeXUtpzDyaMZOUOsbP6pOugBrhr+vvEKsaZzRuT+sDAgy
         f3hPtHM079CVuulKZWD9GhgcS6mvjtMrfAgXu6JjzcT7VMh969MptNpKVN8vEam2Gyz8
         Xn1w==
X-Forwarded-Encrypted: i=1; AJvYcCX9W+KCsOW5r/Ypo2PF4c1ujNFhntO97hB75BLENwe64HtRPYfyfsxwRpCY+yZ2lonWZcSD9UFYyANkaMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1T9VeZk9qXqGF9gNXUggbz6Sjpp7mcyvLceRhGIiLKgeinDI
	527+yZRtmwMJY4b4QBeHIjuHonbu1RjL2mcviof9bwZByMemV93ZTQnUiDcwtMPxsH4=
X-Gm-Gg: ASbGncvBD9thV9uSMUV472MYkQ2wZ2bmk7Mg+eNuFRjG0lxu1b+jZTrr0nZSHD3wrrW
	bVYgpocaBIZKD/RtK7Y3zkNLSiq8F02FFpMpgKqAaxf4a+2xkqCOwaO3hJofC1CymYSzAHXMVbL
	eUGG2zk/Zb7VjFvEXA7BN0e1bbGSmHLlaxD2YsYIL+TbsWxd9T9okPh7zSj+nEnAAU4yaGN+qvg
	0jWq/xyO/c9C1xG4pXQ88LNKufprBoW9KW6S/rC0HaW09eHC7IfY6MNqquE5ymhydhmJMnOUBCl
	sN7YipXko23XITAwCBiTvVYckbHtx49KoF5zBA/p3dMN510a4XXXtV6Lq/14E3JVktDebzU26Sf
	nyIlzQ2Bw3+ENTDrsbbbgyUGuI6r44rbtdR5+dOLEMGLt6gMpWUh0kaue7oZSIutSNVyycM0sbk
	VbExIfnKdIw6rXpt/gpyX49CXfP6j8GLcw
X-Google-Smtp-Source: AGHT+IFaQVLopBnCCBBDM0Romedws7uBJkIEz8t6oa7iUZXqU9TSme0dCXrhxot8zn/IF0CKbdciOQ==
X-Received: by 2002:a17:907:7eaa:b0:afe:c795:9ad5 with SMTP id a640c23a62f3a-afec795cea3mr1008772366b.2.1756492328561;
        Fri, 29 Aug 2025 11:32:08 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:08 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 02/12] include/pagemap.h: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:49 +0200
Message-ID: <20250829183159.2223948-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/pagemap.h | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c9ba69e02e3e..87411e7f2dba 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -140,7 +140,7 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
-static inline bool mapping_empty(struct address_space *mapping)
+static inline bool mapping_empty(const struct address_space *mapping)
 {
 	return xa_empty(&mapping->i_pages);
 }
@@ -166,7 +166,7 @@ static inline bool mapping_empty(struct address_space *mapping)
  * refcount and the referenced bit, which will be elevated or set in
  * the process of adding new cache pages to an inode.
  */
-static inline bool mapping_shrinkable(struct address_space *mapping)
+static inline bool mapping_shrinkable(const struct address_space *mapping)
 {
 	void *head;
 
@@ -265,7 +265,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
 	clear_bit(AS_UNEVICTABLE, &mapping->flags);
 }
 
-static inline bool mapping_unevictable(struct address_space *mapping)
+static inline bool mapping_unevictable(const struct address_space *mapping)
 {
 	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
 }
@@ -275,7 +275,7 @@ static inline void mapping_set_exiting(struct address_space *mapping)
 	set_bit(AS_EXITING, &mapping->flags);
 }
 
-static inline int mapping_exiting(struct address_space *mapping)
+static inline int mapping_exiting(const struct address_space *mapping)
 {
 	return test_bit(AS_EXITING, &mapping->flags);
 }
@@ -285,7 +285,7 @@ static inline void mapping_set_no_writeback_tags(struct address_space *mapping)
 	set_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
 
-static inline int mapping_use_writeback_tags(struct address_space *mapping)
+static inline int mapping_use_writeback_tags(const struct address_space *mapping)
 {
 	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
@@ -331,7 +331,7 @@ static inline void mapping_set_inaccessible(struct address_space *mapping)
 	set_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
-static inline bool mapping_inaccessible(struct address_space *mapping)
+static inline bool mapping_inaccessible(const struct address_space *mapping)
 {
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
@@ -341,18 +341,18 @@ static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_
 	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *mapping)
 {
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
+static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
 }
 
 /* Restricts the given gfp_mask to what the mapping allows. */
-static inline gfp_t mapping_gfp_constraint(struct address_space *mapping,
+static inline gfp_t mapping_gfp_constraint(const struct address_space *mapping,
 		gfp_t gfp_mask)
 {
 	return mapping_gfp_mask(mapping) & gfp_mask;
@@ -475,7 +475,7 @@ mapping_min_folio_order(const struct address_space *mapping)
 }
 
 static inline unsigned long
-mapping_min_folio_nrpages(struct address_space *mapping)
+mapping_min_folio_nrpages(const struct address_space *mapping)
 {
 	return 1UL << mapping_min_folio_order(mapping);
 }
@@ -495,7 +495,7 @@ mapping_min_folio_nrbytes(struct address_space *mapping)
  * new folio to the page cache and need to know what index to give it,
  * call this function.
  */
-static inline pgoff_t mapping_align_index(struct address_space *mapping,
+static inline pgoff_t mapping_align_index(const struct address_space *mapping,
 					  pgoff_t index)
 {
 	return round_down(index, mapping_min_folio_nrpages(mapping));
@@ -505,7 +505,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
  */
-static inline bool mapping_large_folio_support(struct address_space *mapping)
+static inline bool mapping_large_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
 	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
@@ -520,7 +520,7 @@ static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 	return PAGE_SIZE << mapping_max_folio_order(mapping);
 }
 
-static inline int filemap_nr_thps(struct address_space *mapping)
+static inline int filemap_nr_thps(const struct address_space *mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	return atomic_read(&mapping->nr_thps);
@@ -934,7 +934,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  *
  * Return: The index of the folio which follows this folio in the file.
  */
-static inline pgoff_t folio_next_index(struct folio *folio)
+static inline pgoff_t folio_next_index(const struct folio *folio)
 {
 	return folio->index + folio_nr_pages(folio);
 }
@@ -963,7 +963,7 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  * e.g., shmem did not move this folio to the swap cache.
  * Return: true or false.
  */
-static inline bool folio_contains(struct folio *folio, pgoff_t index)
+static inline bool folio_contains(const struct folio *folio, pgoff_t index)
 {
 	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
 	return index - folio->index < folio_nr_pages(folio);
@@ -1040,12 +1040,12 @@ static inline loff_t page_offset(struct page *page)
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
  */
-static inline pgoff_t folio_pgoff(struct folio *folio)
+static inline pgoff_t folio_pgoff(const struct folio *folio)
 {
 	return folio->index;
 }
 
-static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
+static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
@@ -1466,7 +1466,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
  * readahead_pos - The byte offset into the file of this readahead request.
  * @rac: The readahead request.
  */
-static inline loff_t readahead_pos(struct readahead_control *rac)
+static inline loff_t readahead_pos(const struct readahead_control *rac)
 {
 	return (loff_t)rac->_index * PAGE_SIZE;
 }
@@ -1475,7 +1475,7 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
  * readahead_length - The number of bytes in this readahead request.
  * @rac: The readahead request.
  */
-static inline size_t readahead_length(struct readahead_control *rac)
+static inline size_t readahead_length(const struct readahead_control *rac)
 {
 	return rac->_nr_pages * PAGE_SIZE;
 }
@@ -1484,7 +1484,7 @@ static inline size_t readahead_length(struct readahead_control *rac)
  * readahead_index - The index of the first page in this readahead request.
  * @rac: The readahead request.
  */
-static inline pgoff_t readahead_index(struct readahead_control *rac)
+static inline pgoff_t readahead_index(const struct readahead_control *rac)
 {
 	return rac->_index;
 }
@@ -1493,7 +1493,7 @@ static inline pgoff_t readahead_index(struct readahead_control *rac)
  * readahead_count - The number of pages in this readahead request.
  * @rac: The readahead request.
  */
-static inline unsigned int readahead_count(struct readahead_control *rac)
+static inline unsigned int readahead_count(const struct readahead_control *rac)
 {
 	return rac->_nr_pages;
 }
@@ -1502,12 +1502,12 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
  * readahead_batch_length - The number of bytes in the current batch.
  * @rac: The readahead request.
  */
-static inline size_t readahead_batch_length(struct readahead_control *rac)
+static inline size_t readahead_batch_length(const struct readahead_control *rac)
 {
 	return rac->_batch_count * PAGE_SIZE;
 }
 
-static inline unsigned long dir_pages(struct inode *inode)
+static inline unsigned long dir_pages(const struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
 			       PAGE_SHIFT;
@@ -1521,8 +1521,8 @@ static inline unsigned long dir_pages(struct inode *inode)
  * Return: the number of bytes in the folio up to EOF,
  * or -EFAULT if the folio was truncated.
  */
-static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
-					      struct inode *inode)
+static inline ssize_t folio_mkwrite_check_truncate(const struct folio *folio,
+					      const struct inode *inode)
 {
 	loff_t size = i_size_read(inode);
 	pgoff_t index = size >> PAGE_SHIFT;
@@ -1553,7 +1553,7 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
  * Return: The number of filesystem blocks covered by this folio.
  */
 static inline
-unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
+unsigned int i_blocks_per_folio(const struct inode *inode, const struct folio *folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
-- 
2.47.2


