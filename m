Return-Path: <linux-kernel+bounces-803655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D59B46364
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C95DA665C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544B27E7FC;
	Fri,  5 Sep 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyO8Prh3"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76827EFE7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099719; cv=none; b=gIvmqaKkLyNEgf0scxbrZsxRDGe945oKgV7eCBHPs65w/tlFmOb/MTXRfND8mhcgXNFOzYarVdo9h5HFTwr3hokWmbETy6Qfbs6ZQMF4iFdBsh5vcC4Yj4XzP1GLcUw22SiZyw4uYtVcqQ1yrcssFXoEEYZvDdBhltB8M5SsTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099719; c=relaxed/simple;
	bh=ZZVE6780Tc4CYdtj3mmdcqTBtUymc3eqy1ZEbeptUMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCzEEF/A7Sfr+76S3GzTZikT0eoZ4kY3e8C491Tcmy1VSidXjiS2HEE6l3t5CxuHjg4uEarVMP7tif6L6W4SMKOnTr66/tkUEx7LQg6J00bxhvTtp9SNGtXZq2Lobozeq3t/C6arbYc4bjT74vM/1tdIeT5BeYEtfVo9fBQyeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyO8Prh3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32d3e17d925so161705a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099717; x=1757704517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9s8hZ7R4zViy+wFgr3fw3L0ssVquOrWHeMQPoSASmCw=;
        b=KyO8Prh3STUipE/NuOEJak1rp/qZ+wbICdj/C8gVs260ZJ0LqNSa4CWYQcZUYNmbMr
         7hWsGE4XGZ2NYfCbf4692rvDZhNwA4t536lQygODh1ErUXBHS38o+mTlcIaat6ZnjQJ5
         xHtUfp08wG3or0Xebqm6FSxbZCEqrYm3OUVHV40tJdsCzYeOg+ga41N3Kj7/OsKkdFcx
         dtJvxU7ScbZqHfd9KKvm66GlGkBzIJHzVsmJINVJO2SqUMEieNyG2Ijs4Qy9LkeGmV3o
         hAWUFwUcGWkbrew3rtCD6aQpfQSukpEPIT/t6GhkwSn7c8ZJn+rpXhJZiZ2BHN2kAwWb
         xz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099717; x=1757704517;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s8hZ7R4zViy+wFgr3fw3L0ssVquOrWHeMQPoSASmCw=;
        b=AKCwZscEdYakwnxHi9nir84XJHDwojSnogJ59mBfosGbOt3UQqPU3H2PciMUAj5IiX
         HzxfsduJaMMk/vQpFQxF1lX4HSYRrN6WgEMYkL5F4ph2SSvF3rKiLnznbKXCQgPNyXzL
         huFYXuJzO8bfnapPCBJ69L6dU0ynvDNPgSRoJFRNXqGU4E7zUg/9D+0sjoJCpSj5ug7X
         RPPFr3SDtHvo5+zkGUWsYMcAubHksqiTcWCp/f2IJ/oMFPZDYZB7ublNDXG5htq/SYRP
         83Baf3KZ6CVWUme27WC8k7Oc8VGQZ9x7nwk98+CFoCxVjmEcHB1yp0cRqbiPDPwaPtl8
         u+bw==
X-Forwarded-Encrypted: i=1; AJvYcCVuHYJfpvrDenPKKX/b2vfL5vPo3FBB8rFKaefra9m6WChqmMNo/dyVtPJejgcBB/kjRhqvojj0HfY+1HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/j2mixG14iSl+4axFqmniHtDy52m5YR3gLidsdLQ7PRPklo3V
	AWS73ZlG2032+409ttDdWT0yrczoOorgLucFJyZrNzvVe7+I7hhtUW+1
X-Gm-Gg: ASbGncumJ2rgp6B3/Gda4Sc+0YrgOlqKlM4EUDq0BDMrnt/t40BBne9Ic+/Whc8iar1
	wUR5lCz0FXA/UgWXHsZawj0+efSiRdM/EkMNkU1GoHnk+obfj+08lB8PAReIdgYve69ZN1iNgm7
	RqtxO7Y/99pvIM2d0O4vDsgJIIIdlyp2Cn6M99Ab/4rQTPfp1X0UNpF9oa/SdI0PMdgsNaUQDOD
	RPxDpojNSlcK8c5rB85P/oBpShHSR+4kuurbUnLi/pj7PXsA7Z+qA1bXDP9vMZKNlpsX2SGFWn2
	nMZtW5v/xZx0vVcjKqZI0D8csuSV7UhXlfwxQg/A7l98WwRC3rFy6lTSv9QAUgIK9zhIwwcZjGa
	KAQApZc6+ftAfxMAJ/8+GAScwbVzTO61HagITTT7l+FcG4LfOzhCnQSSiHHW5/jQmRfGd
X-Google-Smtp-Source: AGHT+IEd9Oqt6BI578NyTBpy1CqRprvjkInlPYYiEsPmHlAXqsCDTLDSG3bcASc0W4CS/dAa/N/jHw==
X-Received: by 2002:a17:90b:1802:b0:32b:ca6f:1231 with SMTP id 98e67ed59e1d1-32d43f05005mr15140a91.1.1757099714590;
        Fri, 05 Sep 2025 12:15:14 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.15.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:15:14 -0700 (PDT)
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
Subject: [PATCH v2 12/15] mm, swap: mark swap address space ro and add context debug check
Date: Sat,  6 Sep 2025 03:13:54 +0800
Message-ID: <20250905191357.78298-13-ryncsn@gmail.com>
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

Swap cache is now backed by swap table, and the address space is not
holding any mutable data anymore. And swap cache is now protected by
the swap cluster lock, instead of the XArray lock. All access to swap
cache are wrapped by swap cache helpers. Locking is mostly handled
internally by swap cache helpers, only a few __swap_cache_* helpers
require the caller to lock the cluster by themselves.

Worth noting that, unlike XArray, the cluster lock is not IRQ safe.
The swap cache was very different compared to filemap, and now it's
completely separated from filemap. Nothing wants to mark or change
anything or do a writeback callback in IRQ.

So explicitly document this and add a debug check to avoid further
potential misuse. And mark the swap cache space as read-only to avoid
any user wrongly mixing unexpected filemap helpers with swap cache.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       | 12 +++++++++++-
 mm/swap_state.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index bf4e54f1f6b6..e48431a26f89 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -99,6 +99,16 @@ static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 {
 	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
 
+	/*
+	 * Nothing modifies swap cache in an IRQ context. All access to
+	 * swap cache is wrapped by swap_cache_* helpers, and swap cache
+	 * writeback is handled outside of IRQs. Swapin or swapout never
+	 * occurs in IRQ, and neither does in-place split or replace.
+	 *
+	 * Besides, modifying swap cache requires synchronization with
+	 * swap_map, which was never IRQ safe.
+	 */
+	VM_WARN_ON_ONCE(!in_task());
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	if (irq)
 		spin_lock_irq(&ci->lock);
@@ -191,7 +201,7 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 #define SWAP_ADDRESS_SPACE_SHIFT	14
 #define SWAP_ADDRESS_SPACE_PAGES	(1 << SWAP_ADDRESS_SPACE_SHIFT)
 #define SWAP_ADDRESS_SPACE_MASK		(SWAP_ADDRESS_SPACE_PAGES - 1)
-extern struct address_space swap_space;
+extern struct address_space swap_space __ro_after_init;
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
 	return &swap_space;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7147b390745f..209d5e9e8d90 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -37,7 +37,8 @@ static const struct address_space_operations swap_aops = {
 #endif
 };
 
-struct address_space swap_space __read_mostly = {
+/* Set swap_space as read only as swap cache is handled by swap table */
+struct address_space swap_space __ro_after_init = {
 	.a_ops = &swap_aops,
 };
 
-- 
2.51.0


