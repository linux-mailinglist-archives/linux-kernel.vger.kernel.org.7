Return-Path: <linux-kernel+bounces-793304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36685B3D1AF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE48441E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAF25EFB6;
	Sun, 31 Aug 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FgqURCmA"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D3247295
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633188; cv=none; b=iEJPqPUB1EgcIO4JgrdTk8iFuDANaJjZPuv5WScfx7FySVW0umPgZBGeFG+qCWeDW3XKuEJXoEdxqE2nB1JDH+2VMQRXvQJh9tNxHrBOLQ+cLvwG8Pji/3+ocmFwOsbrGoo34WuOfR8DESl1WY8Xdwd4Ye3/K8AzXWTmmLGnvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633188; c=relaxed/simple;
	bh=uKr9NzYjTPyr2LoMtq+P+dwP9S6wWCmSDu9T3D5QFQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W79VIQYQo10cQoRugbqXqZRyC1OFgTjSqY1khy94BHqShrCjF2WBaxsB2AzQjJnWJ4jRDMQCMCRiVNUGzNxmz3VeLSN3QmUasT5jIZz6HE4yjywKCKcx0vRFsPRSOwVECHcNra3rD4c4xraayGh0wFlm6MQMaYDfSOzqQUSm59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FgqURCmA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0428b537e5so5141166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633185; x=1757237985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG8qInwJ7HC+M9uFXGeO7jifDwFcNxLl5I1yIPskFEM=;
        b=FgqURCmAnolRvQ4km1bDriCRcczTHK1gjdY8vdJyvoaDKKpY528yMd2v8bHq/V1V4U
         tl2EWwUimMLh0twnr66Hgf7uVoamwWObizGv/lOgFRqRXhi+IZLuK/RlcxsJnp5UEknN
         +ROwLS4J2QhDLB4oxCVto7JoMpioMQOhZFYBkFTWygxeplXB9M3403uRUf0cUV3fHdKV
         3K0nx5lDqj5AGFCsll08q3exbwcBQM/ELYnDH4lvowym1JZ/Jw2WVOZpPPV9CzAgqBQ6
         nVYyBhwoE6M7enUg8raoFEG28CEsMyzPKyIHclAmkBkSdfp/2eyol7kO+oMNCmMLOCER
         DcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633185; x=1757237985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG8qInwJ7HC+M9uFXGeO7jifDwFcNxLl5I1yIPskFEM=;
        b=JLCdvcHzbpml/glfKtqKCzGgWsJK238g6D5/fh02kh4OOj3PsU1mjKr1LT1t+CB40f
         ai9o8Iu7g3DylNRMowqykA7INF3/T3SKx93bkg51ZVPOcSdQSz4TPfK4NJyLRpvkM0Sy
         3J4JyDWwH7XeC1TTlKI9PKoR9fS66Odxg2PXRMGU61xI05oLPV3O9LtSvqqCJIryG/4p
         F8k3mSiOmA/Hyo0j32IqOLKMrmSwCqcsHjg/nWoT4CEMgeq5O4MFDW0lqwf4ZuZhSr/Q
         y+TV6XU4NlWAf+nALK28z1GJkG7DzQS+QFbUb+o/ZcjM4gqMAmihLcMeSBZfhGLJTspm
         c5RA==
X-Forwarded-Encrypted: i=1; AJvYcCVK7c/HMZjsAFCSXystIrc3g3krNy7yEIq4rUs1S32tU6fD3lXtSk1+QZcUbSk4Mvf92A57Qdh+WJeD/K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RfqZuzU7B+lhEmE/Tt+PZ7Awgz8Rj9goFiZZtznd0++lmtYI
	EBrMbzhmRwBjpHgOTa3OBO3eLSM11BVhA5dL0ue9IGljrDipi3y9KU3vmIsRhmIIR0Y=
X-Gm-Gg: ASbGncuy+hxLYegCwswBDh8/cXGqsQdurqNkFovV1Tyz4qaLLZgl9gXlQnqWHqf264Y
	1UDNg48djdy10k9fJlzLbhur2MiTJ1Fn7v1nDvC299d1qGCnjzf9yEO+xykoTHvl9oKBjA4colB
	yCxe/7j1LUnCKmvf6DK0aNCDAEvDYDpcoH2Omk2UX1Ki6GB7eLq3NbqePnrfnu6yGvVzgz02YdZ
	+G63bNV2b4dGQNGVDoDlPl3SEAJ7h40fxZOiVkdr8acv0wa10Wvdo9sXTs8rHQKuwdqEUQeVHYV
	HHWr3yLGcutQSKyBfCFk7b6AbxQqhEhx3QS5p2rwtHaGAvdstNoiACvfa3+Yta4yRx/2sCL87Ty
	OxNiXR3SwT6hOd5LJIQGwKTMa0YUpUwGnzXgwjfuVzOyUT2BB1QHjrJMfT/5uMHhDtA5dKlWt/r
	c5f7Q2OsupAXc8cZxSXRTdEQ==
X-Google-Smtp-Source: AGHT+IEItZu5qd/uBWt3kniekyRuMwuRZURgEX22zC0t6tG3oVHjRNN/jljliIFQxqA84wsrfCrfkA==
X-Received: by 2002:a17:906:f586:b0:afe:e744:3058 with SMTP id a640c23a62f3a-b01d976d94dmr412983566b.50.1756633185141;
        Sun, 31 Aug 2025 02:39:45 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:44 -0700 (PDT)
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
Subject: [PATCH v2 10/12] include/mm_inline.h: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:16 +0200
Message-ID: <20250831093918.2815332-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
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
 include/linux/mm_inline.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 150302b4a905..8c4f6f95ba9f 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -25,7 +25,7 @@
  * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
  * ram or swap backed folio.
  */
-static inline int folio_is_file_lru(struct folio *folio)
+static inline int folio_is_file_lru(const struct folio *const folio)
 {
 	return !folio_test_swapbacked(folio);
 }
@@ -84,7 +84,7 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
  * Return: The LRU list a folio should be on, as an index
  * into the array of LRU lists.
  */
-static __always_inline enum lru_list folio_lru_list(struct folio *folio)
+static __always_inline enum lru_list folio_lru_list(const struct folio *const folio)
 {
 	enum lru_list lru;
 
@@ -141,7 +141,7 @@ static inline int lru_tier_from_refs(int refs, bool workingset)
 	return workingset ? MAX_NR_TIERS - 1 : order_base_2(refs);
 }
 
-static inline int folio_lru_refs(struct folio *folio)
+static inline int folio_lru_refs(const struct folio *const folio)
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
+static inline bool lru_gen_is_active(const struct lruvec *const lruvec, const int gen)
 {
 	unsigned long max_seq = lruvec->lrugen.max_seq;
 
@@ -217,12 +217,13 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
 }
 
-static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct folio *folio,
+static inline unsigned long lru_gen_folio_seq(const struct lruvec *const lruvec,
+					      const struct folio *const folio,
 					      bool reclaiming)
 {
 	int gen;
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	/*
 	 * +-----------------------------------+-----------------------------------+
@@ -302,7 +303,8 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return true;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *const new,
+				      const struct folio *const old)
 {
 	unsigned long refs = READ_ONCE(old->flags.f) & LRU_REFS_MASK;
 
@@ -330,7 +332,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
 	return false;
 }
 
-static inline void folio_migrate_refs(struct folio *new, struct folio *old)
+static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
 {
 
 }
@@ -508,7 +510,7 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
 	atomic_dec(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
+static inline bool mm_tlb_flush_pending(const struct mm_struct *const mm)
 {
 	/*
 	 * Must be called after having acquired the PTL; orders against that
@@ -521,7 +523,7 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending);
 }
 
-static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
+static inline bool mm_tlb_flush_nested(const struct mm_struct *const mm)
 {
 	/*
 	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
@@ -605,7 +607,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static inline bool vma_has_recency(struct vm_area_struct *vma)
+static inline bool vma_has_recency(const struct vm_area_struct *const vma)
 {
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
 		return false;
-- 
2.47.2


