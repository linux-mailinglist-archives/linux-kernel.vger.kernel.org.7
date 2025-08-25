Return-Path: <linux-kernel+bounces-785214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13994B347A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79B52A5EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE403009E6;
	Mon, 25 Aug 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+pRLAoe"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1D289802
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139849; cv=none; b=mICLuPjo+W1tvdam/Od5sIhLAUxLstLLuAkV8Qt9HW2x/wpQnXeyRbaFAOVD76O5HJhoIcHcYx9OikJRF+Kf39OHmSqivpgVc+pYxssGCahqhjn5ygZq2PoLg69rtp6vjSCyDQ6Xlb3zTJZop6xTvoGZ4e3lcT6qfIjtmqSbvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139849; c=relaxed/simple;
	bh=BHA8j6itK3Xz5hCcAHmxdo8MDOWaiHqgIPvbsOFE7+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNEsq21Xqk5UlYZfXZt8LA0eRSX3dyKQLFf8Yd7OlT5obMTDtxid+56PXVzCUYXE/8w56/nXJSL61YyOPEqpMIZVDnJ99Ug4FQT5wy9Zx1Mq7nz3VWaHuFoxGRR3wCsb0gzfN32024TdadmWz6YpXnOnNHXEQJBSqpilDyipT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+pRLAoe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47173749dbso3249636a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756139848; x=1756744648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VWBN5hI6vm4GSJb+4hWySQHfw8R9VEOfGfW5RFaYvQ=;
        b=Q+pRLAoeyUW+t0Svf0r0QY8NF3oCgKs+CPeWIPyPndYkWG7WCl3t3CbWzA2MIij3w2
         PNBjYRgShVJy6t1uyIBao5p9sLgheV5poPssQs0WzVGoM1YRyH2KLaaBca0QC6JUsdFV
         g3XneLy0TVAPKOqUgrHB5D2nh7/T0azU5VlNjar1Me9SMsAwor7JYfgLgHmDoFEHJGMl
         Ay+xZ8iYMw7lEZIDmr2Uyondcr4FGsmyS2EBnUkifyHOBwowWwrH1tuv8SXd+GG7c9Z7
         i+og0rn0b1RWgjxzAd8K+ypH5rlk3fRNick+v+YTcIFYzHQLSEaGX5DuiGLjSY6vY4+W
         z8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756139848; x=1756744648;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VWBN5hI6vm4GSJb+4hWySQHfw8R9VEOfGfW5RFaYvQ=;
        b=r1S3aiB76R18KmfBpazH6joau4c3tLFRvgP8LiFxMBWBr+ZsDHr0tXj7/jVjZ14jLQ
         O8O8iRkLy23/FvlnVFOXhQZrK3NHGS2eHOLoHF2O8ImjIonTfWTwX5Y48URF4jTOPAFH
         6fyPKW7f8CzKhEHugHsTRyixNFHFhHe/7+ympbH2FfEATwSI/+7jOXr3kk8/pROtLsNj
         L5oltpbCi3iOTVGlIneL9MlF5ha7pg1KirTzEyB8Cb+pGpuRVbKM/IDWqqtMBp0BNXNf
         cq8nZS1ti0wnooblGUO7mKYHwyQkbHJUqj4Y9tR0IdQlGv7ljIff8IkS82nMLWVGG4FU
         aM4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLcsTBWoVMCuyttcyGegeS+i6pBQFyT7urzrRbeL5WhS8TtQyeBz/s5IJZeAAriGLIqYpmFaGulr3LUFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwI8S/1t6oKwFhBcp5vzFsKYvo8d/citin4lwc2z2oBMW63VU
	HQQtiTDZKduT1hgkFKq74SweZqsYvCX4OoAGeyJbKaX+cD0RDII7rbejTUf4gPA7LiQ=
X-Gm-Gg: ASbGncukR3KIL0OrKAiySWUq9iXNnBbcy+5eWZAelNCU4isxjxsMXZ9Zv5eMg+XGkEc
	Iv47b+WR5/Or53ak2An2mmXit1BJz83uQiDbhRaZMQt/GtorZuWhiM6rmKyteUGf0NfhAeiGygx
	SwB3tAw/zc9UlbIbWPYwJXolEeLN/EZHuGPeA7k3RfX6gWNryVDGokdq0vb2O0opr7EM4k0m4qN
	3PAc9xRUJXM/oTrpbwNyN0q4LY1Kf0TrUgzVPDP88cbQkpLghiuTtuUhSZYXPEt7XcHW36DPlUL
	+jFRbXqzq0xO5GXFu0aardm/JXddna3s1SvLUlL8ZKYoBDHwIH89hKBz9kWXx6KsXdhw79rJf+x
	cFwnF9+w2VJx+bM1bJHU+ACUiFAylaemyRRIgGoHUamQ=
X-Google-Smtp-Source: AGHT+IGMln+AnEhe4Xop32BwsGkP1vKS/jDJKfzqYQDYkoJiSelQYB6QRw5vsdnxLnjupDrzw+FuiA==
X-Received: by 2002:a17:903:1ca:b0:235:779:edfa with SMTP id d9443c01a7336-2462ef219dfmr135753915ad.32.1756139847374;
        Mon, 25 Aug 2025 09:37:27 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a01fsm73382505ad.16.2025.08.25.09.37.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 09:37:26 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2] mm/page-writeback: drop usage of folio_index
Date: Tue, 26 Aug 2025 00:37:21 +0800
Message-ID: <20250825163721.17734-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap cache.
The remaining three caller in page-writeback are for page cache tag
marking. Swap cache space doesn't use tag (explicitly sets
mapping_set_no_writeback_tags), so use folio->index here directly.

Signed-off-by: Kairui Song <kasong@tencent.com>

---

Changes in V2:
- Add a VM_WARN_ON_ONCE and some comment about why we don't use
  folio_index for __folio_mark_dirty. Other helpers all calls
  mapping_use_writeback_tags which tells the reason clearly.
- V1: https://lore.kernel.org/linux-mm/20250815121252.41315-1-ryncsn@gmail.com/

 mm/page-writeback.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e1e798e7213..5f90fd6a7137 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -38,10 +38,10 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/mm_inline.h>
+#include <linux/shmem_fs.h>
 #include <trace/events/writeback.h>
 
 #include "internal.h"
-#include "swap.h"
 
 /*
  * Sleep at most 200ms at a time in balance_dirty_pages().
@@ -2705,12 +2705,18 @@ void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 {
 	unsigned long flags;
 
+	/*
+	 * Shmem writeback relies on swap, and swap writeback is LRU based,
+	 * not using the dirty mark.
+	 */
+	VM_WARN_ON_ONCE(folio_test_swapcache(folio) || shmem_mapping(mapping));
+
 	xa_lock_irqsave(&mapping->i_pages, flags);
 	if (folio->mapping) {	/* Race with truncate? */
 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
 		folio_account_dirtied(folio, mapping);
-		__xa_set_mark(&mapping->i_pages, folio_index(folio),
-				PAGECACHE_TAG_DIRTY);
+		__xa_set_mark(&mapping->i_pages, folio->index,
+			      PAGECACHE_TAG_DIRTY);
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
@@ -2989,7 +2995,7 @@ bool __folio_end_writeback(struct folio *folio)
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
-		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
+		__xa_clear_mark(&mapping->i_pages, folio->index,
 					PAGECACHE_TAG_WRITEBACK);
 		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
 			struct bdi_writeback *wb = inode_to_wb(inode);
@@ -3026,7 +3032,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
-		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
+		XA_STATE(xas, &mapping->i_pages, folio->index);
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
-- 
2.51.0


