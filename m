Return-Path: <linux-kernel+bounces-803646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E873B46354
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B283A4278
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A427CCCD;
	Fri,  5 Sep 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8mo2bsR"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2427B32B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099673; cv=none; b=a6M1DelTN5MSdTrWbq9w8zzhUTAPAjlxyXEV4lDQ5zH6pppJ8u+KZ3/YmEew/WdU7dZEpKguirqL4hsJcl+3jI2NjvF5/AhvWzha9XZjBXO0dkNka8oTH6lIQ4A79+z/sAwSy03fvgCEWghSEPqE5ZNlrHknOgQasPPPHP/6Fac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099673; c=relaxed/simple;
	bh=cdVNCZWUbrIO+GqQrsJ3wMQ2ulxyBF4oP4toSJvz1Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni+MiATWlxjPkDk7wCQ9wdoXsnIqqdPVqw0aAfI8KOeJtmrK9iOVevRSSLj4JZ+hhU7qNYFhlrFj9WGs0UGD2UwBabuf66RWQZ3UC0JbSCMXGYjWGv5J0cWLIMPGqAaL6yZTrQEbkOw2ccqTKQj8Tjdye/MKCZxaRrhgUEupCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8mo2bsR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77287fb79d3so2219335b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099671; x=1757704471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hz/rwuCJ+AfNnA/+slxKdJ9Vt8t8OYTTKbWi35Lmcc=;
        b=T8mo2bsRtz38GJIcxKYcTHgb0co1EWHGgJjpqiAcWHJhuPumElp6W/g9bzbzwy2YQG
         PNnnwCIgQ31S5RhGsgjH31v+IepJTdVy7t72ClRz8F7XhnJdhbh9x3uonD6nvKtqwcWn
         s1jblVJ8uhRSZ4DqenJgw1AYugwDhJGroxI90Z6lvRKYYxWO9rIw/o3Lg7s++xc8dKNE
         KMKLT56uGCsF+CTFk0YRMZEQQkR6iVrBiApi2TkCxAio4eGHfqzZqmaG4mKl5Yn1Nlxd
         hllBsPiWjf3mYr/uqIAUSN+Td7qMpkZFFXorrk/G34mmTaMNJXgsm62lNS9u4aAjSCox
         6qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099671; x=1757704471;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hz/rwuCJ+AfNnA/+slxKdJ9Vt8t8OYTTKbWi35Lmcc=;
        b=iyQGWZFSjtGQr1OXd+8siBFUzf4vMKrsA5a3swX+dOopTRmPwrDpnVdSSiwT8cL7/G
         fE6NhEqOxCaohhneYAug2R79cmYCjtMY3QLWZgQdMdNbLlbl1ObVlL3ByTv0nstTYApM
         9JOgcf2ionqUnGjnKiSdLmtyFaBylvFlCEq+R7a5kV1CXvrNi4FWE03QY1nM34qs93wu
         K7mgSnqcQyd8komQVlSdM49+M+ZQSQnfMZU1wVrrNxh0oHKmIRKs7jNAlwQ5PaDJYf32
         E0gQt0nynolnq25oXqwXHKJdpYfJAR9iyVn2hz28D6Q8jNOLU1nChoJWSyKh+yQRRU1W
         F0oA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+XYpC9fCk97q8k+8LB/L1zWmrvr65ZUsSKLDQmP3AUUaE1xcwFgdA5OWyneI1TsVbBA+zPp4ZUJemiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtg8t2IyI4J4ntDSWTMx9+qHbktLxM0gqTF2xlsrGHMbILoGns
	VARu7Ai3b84jcp18hDPkNuvd70kWLdmncWdTlECclC/TvjQ+lIE1QCzf
X-Gm-Gg: ASbGncsVAkLi2mihKYCMOacc5bKtP9Ubl4nykq+otH9PSlnEpu62r99Gwnf/+HZWANq
	RTkNnwGR+9uf1L2EJSmsfNXgxCwjHprBXUOTbUT/S4IEvoPoEAYS3+BM2yXvKPUGlUXcNz2e8kR
	SL1LK8gv/De6uj1p6SEeQ2X7/eCvqpa9JsnL0xhzj/MwgTFcu7sw2pKCkAOUJzLRu2BldB+LNU4
	TVdQYb3nXfKzDjnctADKXpK2FMUh5RumSSY/8BJ+5V6Pft1gYlFd1mL7jZF2fIs+1IDiKmlsYvE
	5irtfvqCf+n1iIG5IYGIxLgpxIsHZvoNS9l9EmOI0jwrypMJPefQ3ZVS7GPgNqZ3rj2Oc4zIlK7
	bfzLZ8a/9kGyX2Z2TogtrYwvFewVg14SFwFHuhT/b4CgQse4lEPxmBQoEiQ==
X-Google-Smtp-Source: AGHT+IGfH9fV1AgSl0wv8tqYCRcHQb5tSEyNj8zQqgrgjfFl5SnhdLgFSlUza4Y9ihJjnD8NLMJuyQ==
X-Received: by 2002:a05:6a00:984:b0:772:5a3f:7cbb with SMTP id d2e1a72fcca58-7725a3f84f0mr27740818b3a.6.1757099671272;
        Fri, 05 Sep 2025 12:14:31 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:30 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 04/15] mm, swap: check page poison flag after locking it
Date: Sat,  6 Sep 2025 03:13:46 +0800
Message-ID: <20250905191357.78298-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of checking the poison flag only in the fast swap cache lookup
path, always check the poison flags after locking a swap cache folio.

There are two reasons to do so.

The folio is unstable and could be removed from the swap cache anytime,
so it's totally possible that the folio is no longer the backing folio
of a swap entry, and could be an irrelevant poisoned folio. We might
mistakenly kill a faulting process.

And it's totally possible or even common for the slow swap in path
(swapin_readahead) to bring in a cached folio. The cache folio could be
poisoned, too. Only checking the poison flag in the fast path will miss
such folios.

The race window is tiny, so it's very unlikely to happen, though.
While at it, also add a unlikely prefix.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 10ef528a5f44..94a5928e8ace 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	folio = swap_cache_get_folio(entry);
-	if (folio) {
+	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
-		page = folio_file_page(folio, swp_offset(entry));
-	}
 	swapcache = folio;
 
 	if (!folio) {
@@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
-		page = folio_file_page(folio, swp_offset(entry));
-	} else if (PageHWPoison(page)) {
-		/*
-		 * hwpoisoned dirty swapcache pages are kept for killing
-		 * owner processes (which may be unknown at hwpoison time)
-		 */
-		ret = VM_FAULT_HWPOISON;
-		goto out_release;
 	}
 
 	ret |= folio_lock_or_retry(folio, vmf);
 	if (ret & VM_FAULT_RETRY)
 		goto out_release;
 
+	page = folio_file_page(folio, swp_offset(entry));
 	if (swapcache) {
 		/*
 		 * Make sure folio_free_swap() or swapoff did not release the
@@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			     page_swap_entry(page).val != entry.val))
 			goto out_page;
 
+		if (unlikely(PageHWPoison(page))) {
+			/*
+			 * hwpoisoned dirty swapcache pages are kept for killing
+			 * owner processes (which may be unknown at hwpoison time)
+			 */
+			ret = VM_FAULT_HWPOISON;
+			goto out_page;
+		}
+
 		/*
 		 * KSM sometimes has to copy on read faults, for example, if
 		 * folio->index of non-ksm folios would be nonlinear inside the
-- 
2.51.0


