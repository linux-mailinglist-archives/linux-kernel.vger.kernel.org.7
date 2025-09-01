Return-Path: <linux-kernel+bounces-793884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C99B3D99F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5078E17A202
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AF26738B;
	Mon,  1 Sep 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RkhshYBk"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EC25FA0E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707166; cv=none; b=TxSbxIDs/Cs15++ZWkaOK0ByTeUYyx4oJClfh7j6WEu4c01Y/fFBXnsuq72qls3e0wfWlNJKygnjITmdbGL0Oeyq+cbJ/TcNdJxN3z0jlGEzNjNKikfv1OXRvh8X4o3ulic8JSQXTXzjAOVKAs7DYMy3AKWVCQpngaOnFMvjFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707166; c=relaxed/simple;
	bh=uKr9NzYjTPyr2LoMtq+P+dwP9S6wWCmSDu9T3D5QFQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rexQM4rSlwewb96kQrocVFlIKn9aozh8cw8F8hn2GpFl1fsVFGtSO8S9lyThWKIIHe0edrb3y8BPw3gj8r9AFjjB45gN73AQHsASxeeMdci8ssdvq1kc6QT2ZtGKIXAF7JXkQIJvNlROkgGFf6dTkYzT6EWs4kv1SS9NS0MjTns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RkhshYBk; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso1257694a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707162; x=1757311962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG8qInwJ7HC+M9uFXGeO7jifDwFcNxLl5I1yIPskFEM=;
        b=RkhshYBkS0oV2fnFeUTfVE+/7Os/IDN8Vwjp1wW8TqICpyQML0nIVG0/V3DqBFtp/U
         P6DO49T29Z3EST3MUCGylnzfHqAOabvi3E0Jj9o+VRYjcX8PwR3AQpqFVD2Xp9rL3sQ5
         xUz2MucWZ5z9J7lB+ZvhNUTThKuSsRyrJgh24uZaog4cLOFyKB2Zm+CbBbDL6U1mdwr/
         8fkOqil4B8zxAKt9wF5JmjBKTDRpA4CBsJwDYdW7THP4b+5gEJFGe8SUz3mfJuZNyj7f
         PSJO9eOXg4094gV1tCwsVm7+8NtJ1LP8APQKJxKdeQeqTCjSlaNieaUDfMI+E4UDWC/j
         RVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707162; x=1757311962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG8qInwJ7HC+M9uFXGeO7jifDwFcNxLl5I1yIPskFEM=;
        b=t81z7TL3AFDpLt94R9MX6a5OemaJ8IZcnQXTBq6r5+QZ4mxaB8wlHhxBmahMdWOXa9
         8QHFXKnyW+mZJR78ob9czqvQP/pmaHCSKWW4nFlORDnnDFk0kjZbejAv1JMPHZdV2AUl
         c4q18nTbKqEBBs7HQSQdKBCmyL6QL/IRWBXlgl4u3xaJlBw4vZ/E4YtOygO8P6sd+Rvb
         jY6bfzhR4rX+jrArflnj2eqjVeXy6jWGyrY9WBnlrJPRB5W6MiHuxi+8TLb8Csq77D4h
         yLKIzzhgG6dPAf4f9UqF3H+1ZDD5c0y9wTtJleF4tOHFYXWQ6YDDKRZe/ltY3A5fsuH6
         ZAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGzwGpDirieF66GZVzgQtW2URBJ9tO9gy66BNp4o+R7GrBeuktcbOpOTSXvS40X4jmAFGfAD0nVsRlYzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IYF6IAsShl/dEjK68YRmo7GAifWKhGTnV2yWlxKtmD9fj4Ta
	7fkEq8yQAegerUYDwpJT6Hqc2xYYasHHmX09Md6m6JLrL9L9m6wn+mvuPZAl5xboY/Y=
X-Gm-Gg: ASbGncvCvuSA8QtvLg+YsCm1SxUZ3V6TDltDv5hlNNGgEVu7Vm47cOtgv5zigJG2Y6+
	eEcsQgoZSKVoRXIvDbXnHMWC+YmIxwqkk1ttAcT2oD8O1YzVuKP44eSSpb1WRWoli0JEbuMNUkm
	gKuGXIaltWhjkE3SUtFWR3N3mS/j5XsqFQiuRdeM4DIp824jYNxF1Z63glYlf6w3BoEPNQLA4nK
	MdyJJLnvQbitMBf3JaXYvlYDT7eNEQNj5vPLaD4iY/QvYURj1SJY9UT41uMSRCIj/Ro2UcmR3ym
	RDa+oohWM91x4HP0y8GpnIRAMcJcNgLNVFGBuBtKFNPjyN9L6vDmjQQL8oDtZ1rP/ItAzkBSw5J
	fZhpYJG+UfS99+PQ0LJOD0RNh3TSPXz3OZ1/hJFuyvzU/8fUYTOz/Pur1zPHR1HLCuNKIfZ7wK9
	DHjufqKF9rZriaiRA7K8V8sHRdaP+5vvjm
X-Google-Smtp-Source: AGHT+IFAtjmwZ4hK4x1JPevho811XP+EdM9fOjsV5Bznkx8JWR1z6DDHqQxBXROOVg06TaWqpog9Hw==
X-Received: by 2002:a05:6402:274d:b0:61e:95b0:c95d with SMTP id 4fb4d7f45d1cf-61e95b11582mr2278334a12.19.1756707162259;
        Sun, 31 Aug 2025 23:12:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:41 -0700 (PDT)
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
Subject: [PATCH v3 10/12] mm/mm_inline: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:21 +0200
Message-ID: <20250901061223.2939097-11-max.kellermann@ionos.com>
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


