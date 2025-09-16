Return-Path: <linux-kernel+bounces-819205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3FB59CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F99173E00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D973304BAE;
	Tue, 16 Sep 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX4Hp+c7"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963B2C11CE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038499; cv=none; b=qGlvixmSSHbpUnkXcKonpogF306mNd+r/QWvKxvcoyprzg0zvT4/G4GBppe39DdgsDkL/u/xuBHPbVyE+gwLTOWrkgx6JTwMRishvWQrvQjEClkZpiBcjd+esmZmCh4JwErdD5PZ5y+nU8MUogVXcuvKPcJ42ciklXps3thq05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038499; c=relaxed/simple;
	bh=iOB1NvD3fZfO+f3XO4KmMG2pU/dIrJPJARyo3yMa57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgYe7DMUeeKGxG635DMB2p+b369+7Z3MLnDUmVmOB2sYaNIP5y1mP+HFLMgwtCNL6ywTyvyFO1TY9MY7nik8vGmjeOhpHE+eOweSlyp2Ork/bf6pkcbexOPrpJOo5zvjVlsK9LoMpC3k+jz+G5HopVbz6ni0LlV28EB4svqveL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX4Hp+c7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-82884bb66d6so1395085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038497; x=1758643297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHfOln/VR8uFzgqsT6uF/KmaET9pjaPTDRMh4vKV700=;
        b=AX4Hp+c7q4+WhBptyRPOA7mMOxCztPfkSo4wJGDTcCFbBWG1zTzzrz9W8Bi0280dpm
         O98HhTKx2glF/3XSSkrmunyOWJddqo0aSf2ZpwA/VW5QiXabUwyjTn2YmO6SDb7HhJW7
         5i4l0t/CV1mH5AymE89NZ3FqL1KSuLczAZ9csDdfRCsQGp3J7gkrankF1I+1Gw1TMiMo
         CE2oKpscvBzgUkoklCuKx+8Rgt9KebF7nx7aM/CtOjFXCYFRWediIioO7lwTQvAIGE9g
         d1MPBCG+D2YZfSvwfCQVxKZfDvNquVHZTioxK66ahNt3XK1h73kVyxnHoSn9DNAvYM9S
         Imow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038497; x=1758643297;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHfOln/VR8uFzgqsT6uF/KmaET9pjaPTDRMh4vKV700=;
        b=twUZmE3E7iSXY5UGgMe30AvrdB58uYuRq352QQDC9vroLvde+pooSEzzbHGgQQqaMn
         G3dx0LaqdOd38nQ0/57+A+iIjCFu0xQ5bjJXUSmNannuQrXGhGbZg5vbpXH9M/WszS57
         vs8/QTdMgoVqEBUASGtkhfdGdapJmTkgkcStpje2SYTRLr/PGXt8cztbg0WU2U3F3yQc
         Q1TxBeZ3Ofk5GgaJVauyjNGB96FO9WTHTyJVs+OUKB5SFN005usIp/SvlhCAzOrN0am2
         TGJ33DfGN0JGglxqNJBFaNMHZfbRS3XTikS8IRc0D9fagSQGyjlDhVgD5qa/kg/ovuIY
         9Ixg==
X-Forwarded-Encrypted: i=1; AJvYcCXGMjMCgbom97sD5Ks4X94/3nrUQgB0xDAONU8wKmvL/98XFGfr0G7mxuvf1j3SI1VQIMmI6zAsOeSUj7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyxswoHXaqZKFtXm9JfEm8aYH0s+W9xdzbjGtXBq2ir6xIbpc
	vwwn15tH8ScZUmAt+C/AO7HNSRwh0ojY2OmXdy20SB7QlXc21PqwPACL
X-Gm-Gg: ASbGncvMZgMrI4fBns7wVZxN7DUzLKKfBjI2NWdtuHKL9Tr1Auub+OptUNEjADExcUu
	TlYvvDD3sjVnv9qrIuN1LE0Ta1MOYgHv0SclgbcpUDhjhSS9HSR7CSjpyd771wni3uXpi5meZ/C
	HFpoRP92QBBu3Z/HM3y8ZPoSZjnVziBKhAPGwwUqbrL55U2KdHNoDHML1jxDeg+6Xrcn9jeDVLE
	GUaGssfnXhAT7Sf/vtvSPm/ktnL6JORXOQ8Uo0l4jsHci6HrQmOttS/KNNX+uVp7Xp3qs2lz8q9
	L/KqSSpQICWtm5ycXEqozH52jC8GlwEMJAKuSsD72Gd+eUSOXLhG0uPCA6s9x6MfJFubVo4YIhA
	fLUshKuKRNxrHwlCt87nuy6cHMQRiBq2mO3Qxo6LuPI7xJPI=
X-Google-Smtp-Source: AGHT+IGAZRkBIeKRz5NtoJB/djuVWVXhL/G4pUd3uLXDSdbMDwhCdTxwRhwBYAhwJr9GLp1bon/fKg==
X-Received: by 2002:a05:620a:2a08:b0:81d:9079:3d22 with SMTP id af79cd13be357-82b9c180de5mr320092785a.8.1758038496724;
        Tue, 16 Sep 2025 09:01:36 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:01:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v4 04/15] mm, swap: check page poison flag after locking it
Date: Wed, 17 Sep 2025 00:00:49 +0800
Message-ID: <20250916160100.31545-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
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
Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
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


