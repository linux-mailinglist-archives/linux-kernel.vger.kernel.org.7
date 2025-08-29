Return-Path: <linux-kernel+bounces-792304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 406FFB3C27F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD541C88445
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB9352092;
	Fri, 29 Aug 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FfRwVXCx"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07648350828
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492339; cv=none; b=KB953KFjOz9lj+JCPr9bxutSq5abitK52rtu0mo2bxpDqKXYsWDnAj8nxv4nbA0qonsH/1NvkPIrYMHT5oQbj0RtrIp+Dzlp6SkOEncEmHPYxLBFu9mYjzl+Pj3fBeK1nHZVDYvZqxBxOyLlpzWqrku7JoaskK662y+GOd7NFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492339; c=relaxed/simple;
	bh=0A3KukRP6WUH29qIfq2HOM7b55LtojY9TjySuP/oa/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROHK9YxcxTYqUFz+IuAQD0OfaI0Z8lip4G6aJXCVrKERO8GqqY3rP+x/pWVFvOI/o3p1IS4jXWyJgeMfqGUzQyftDm2wAYbSfW/DZqWNc1+BUbnc4LiwZ+CLpOAtEwhS6yQ9WH+lG7yPF9whGz1g5oZaZWhIkroldJRcVjinmZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FfRwVXCx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so373562166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492336; x=1757097136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0olIYmWE+/dr5Hm5adY9R1HGCCQ1xC2gIdwvYkk/po=;
        b=FfRwVXCxCVcMMrRXUUEfE5qwNO4rtrfp011RNUJKdOj3TjNSp54xP5isJQitq8/Cx1
         2i9AyCqM7lSkleNPu2HPL8YZ2zvByQvMXfXx5vzXp36nVMNYr4cECwMkwwoZkm7zVUrA
         KLhxcSE43/fb2ehZn75sxMfMaxK2YAS0mj0BjOEtEs1l1+xhDx0YgP2+A+KK1eGgpsrL
         vLsO1NUJqV8sSwen7+vP8KXLwWN7ajuj6iVfRYVcNIWGr59jN2Bb8tTMlaxIddica9PN
         nM6Tpoywm5HMRa8QlyjrlTesueOMD5wCGX89mhvgFK3r6h7cyTd9Wh5LGmAxP24cp1dC
         0qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492336; x=1757097136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0olIYmWE+/dr5Hm5adY9R1HGCCQ1xC2gIdwvYkk/po=;
        b=CXE6quZ/KhzHZNEKdY8xh9E7Ac4cQxW0BrhKBGkb9AaLMlagZk/2fvOD2F6BD0+2iE
         JPsOVcKiziuKyQfrfVJF1KQKXcuxEuh4k93u3zbp556uEnTvcIhsKc2K0aUGEUWHAVlW
         LaAubMkGhoo7LU+LOXPfVAvbJM0HFsUiYkw7MWoO9VWo+u4KR89iPtqxNzqci4JxKoOU
         nMXwi6LIn4jEdmD7euU8YNdkDmj2hHRQYIMvDgqr6ftAZnP0xHnYTB3f/E7EgkkRBcAl
         avte/GEtDzVJ4eep9VnCpstqrrulGvB3lhe+Ojt5wTe6uL8hXk2O7DplHJtoeSfWsSfu
         NePw==
X-Forwarded-Encrypted: i=1; AJvYcCV22xKrIwxGwoi58HTpUQyiCQYE9+kwdNu4QRUxrGhtWfvbcoN/ERi1hEeV542clxFMBnPoa24eB837Wy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/5n+GadQce12lTtyPg2C6cbdG8cqZaGvtDSEG6u3PWNfvt/m
	wKoQWti4dktSwOhaP+X9jXp3w7hRStWDExUk3ZJLOOQ2P/3DUZxdKx3ptnPGuVTKKWw=
X-Gm-Gg: ASbGncsEPLKfrvaZDJyjU0kWXJm6ozgKB7PWw7SOMdrqy+UbboelDDftIn5yc17zDr0
	tN11E+LpMz6vG0gsuMVF0kpWEX3Z3DeLLgOBSDdrBUFt62+f2voyHt4IuFBeeN5+PgdvYGGyXwF
	PsameUg467EoC6PyPlo5C9ASXaZuAiwTr4dyZh0RJnrsCNNB5tojlZUvSnXqsFhFX8tw1Nzvrmp
	4pBALSWi5QPrGynrsrq/Cu/D1wuq37XDLQTbumGnWIiZNxQFMM5YxDHHKSz6IucGbUq/UF9pX/L
	eR5++E1YGb0QCNH2h5QE2g9Nl1PPrZrosexX/d5Ce9is0SKHELMNQBEfuXWF7XYmJbGxHnqeTXJ
	gUfk0M2lrY69yw80jzM1FIRKowUfAQ+LtnBxi/HkZCWD6bq8V+wz4NqjrKb2fdrSp05VxCsYNeU
	I1nh613rydQlI5y9JbXwDYLVxWjbF7y6K4
X-Google-Smtp-Source: AGHT+IG+akp2S6/jmEqkov0WGAZfNqim0Qj1piYjiMIZdZrxJ9Nq62SrMoJjcQmw810z5k2DCtP7Kg==
X-Received: by 2002:a17:907:980b:b0:afe:e9ca:8ec0 with SMTP id a640c23a62f3a-afee9ca97b3mr620810866b.47.1756492336083;
        Fri, 29 Aug 2025 11:32:16 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:15 -0700 (PDT)
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
Subject: [PATCH 10/12] include/mm_inline.h: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:57 +0200
Message-ID: <20250829183159.2223948-11-max.kellermann@ionos.com>
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


