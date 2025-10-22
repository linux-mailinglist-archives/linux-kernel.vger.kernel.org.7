Return-Path: <linux-kernel+bounces-865228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D2BFCAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41C26E7ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E234C150;
	Wed, 22 Oct 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgAll6X8"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97134BA5C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143488; cv=none; b=fCQEc9RBRkgqiWmBerLwLnPK+XMcMtQgenOAlakDrHnjXKwBCpnO1IwS/x/i8hpQNZLqQapLqLqke2/S9OoSmE1YTcbjhdj2MYq5Buo3wzDRbyaYFMth/ukn8S+DVV8CjtPkAoVaRieSw5M7gOf+zubr7bUmJNk23W+mqEdE+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143488; c=relaxed/simple;
	bh=tnc5FiA967TzDSOUF/qEEk/iVLS0Pj85cN/78gd2LZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwEpA1hwUrRw/pxhAQLaB0BsUbM+DkWkgDB9ym1La1Sl4iDq2BZTNtcraFcUtnHnQkS/0F4CF4kkFyaw1zT/zB8M3jHFieLNZJAaBs7ZsOOuMEPr3xJay2i3Q58B7uxgJn/2uKc6uZ36Vanvb2ZkavjG2k7P6n9RjpqFjEPsF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgAll6X8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b457d93c155so1057469766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143485; x=1761748285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZVbOsrcpFKXZ5HCfRr1gdQwhg4fxogWEkiSTw5M1to=;
        b=EgAll6X89Q+0Azj1jCG4bDJxzv1eHs+RMoMqajlQZQULP9gZzC8idG/XIDpN7mVMnF
         sCp0B91FzuooN8JygDyXeq87K6vC91tLpReQxSBs4Mv5GtiP66UlIDLaCXqcsvext2ti
         6KWIQBE0DpLLXhGe8JcFH2XcOxQS6AkG9ks4IgAiA2749hAuZ1CD7ogQunladBU0epg9
         hbLSHu9gbFI7rcSlHpbrPWqiziXv7jYBPxywFRU1lprrForzzrq44ooNtnMydRxVjDgn
         7iwgQqEJdo03L/FLCq0b6BMjv68D1+qRvlKBQmOvVwnLutp5bB3W9f8qffn1J0GOwVI2
         YRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143485; x=1761748285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZVbOsrcpFKXZ5HCfRr1gdQwhg4fxogWEkiSTw5M1to=;
        b=aHiTiUpl0vBMTYKkvY3l6snyXQL/+J95QWvXcf8PJSgK6JmSBk1/Y44CBGtb+OsJQv
         1ejcFhhmE+7A9/48ef/aCRJBVGxgPBrRTDSW7UBOEVgDUPNQBFfC0YdQx0p7dCfZEhfg
         qecmAaAAnmheU12rr/oPn+10S8MPcPHwdMSDsYkDleMiRLDjN6Twt5AXqO17slHSBu86
         zBsxzxB3qnmI9Kf5E3T00ySZhxHy+/LYPXJxXapDzwlAJQ7/sw1bee/vuY1AdPsoFmT1
         ezrxiiZWayTHw9xIcL0BDpidQdB1iWqwAC8VLcNfNjeqbU97BPST4i2iwTUtUGcku+Fq
         IK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRbhqcXR+lz5dY3bGNLJNGugHUgihlRT1EXvJSwO5VIDiDFJIhCygOPbXblW02vwdOpWl/Er1NZze+lmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnHUcE4uV1jftTdv0c0F6PuNodQMzJRZGLOj81HnAjXoPzcky
	RTvkcob0jI8sOU8toOeAdqP0vr5BLnqHk09q7tkoDYI5M3tvqIf7Hvnn
X-Gm-Gg: ASbGncvIyoEhMX3Uyd8jgyE9f1qTI+3Ju5ieRs/8eykK71j/t5GglNWOxS4tjzQjDl+
	mh3/l+8wxEA1d0Ijpnr0e7cO+HUR8YwDEelYj7NEsVcuGcf6Z5pFqbfOvdiMXfJoOPmFjOdNI3l
	8sckhngRQKbCkr361+/2ascu0SBxvIUItxwkfN0DyJjb7Vuma6o8dm62J/C7Y7qDaJBKXyFispX
	Z6exSLIWnce93RztHiKjQSJFRjmL958p5EUIyD+lUeAaY3+YIER5qFS6xiztLtPtODf175DyXrC
	FqKIDzQmpy7ejtZDcuYOU/oYkCb8PdDeNGtB7OvQq36IlLNKgUlHW/MBNpRjmsrjaCmZEPlCYTS
	V6qApDgdiUGjvEih1M+Um7ud6A2eIW0dNLB5bzIsd10JRLlEIMFS6o88BEg78EzIZ1gqcmpygpG
	ZsnCZ+FnwEfWTsgbLmSnIOGn4l9D+MILcBBCto3b1kblDAUmsIQ2w=
X-Google-Smtp-Source: AGHT+IEur7NyOcilDGxGLBVMrnSiU4bLI+kty4WImYiYYNachvpA18Zbs+ddEDNYYMImWfHnVYkXQw==
X-Received: by 2002:a17:907:7e94:b0:b6d:3fc9:e60c with SMTP id a640c23a62f3a-b6d3fc9e86amr52616566b.20.1761143484532;
        Wed, 22 Oct 2025 07:31:24 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1335188066b.74.2025.10.22.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:31:24 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] fs: cosmetic fixes to lru handling
Date: Wed, 22 Oct 2025 16:31:12 +0200
Message-ID: <20251022143112.3303937-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022143112.3303937-1-mjguzik@gmail.com>
References: <20251022143112.3303937-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. inode_bit_waitqueue() was somehow placed between __inode_add_lru() and
   inode_add_lru(). move it up
2. assert ->i_lock is held in __inode_add_lru instead of just claiming it is
   needed
3. s/__inode_add_lru/__inode_lru_list_add/ for consistency with itself
   (inode_lru_list_del()) and similar routines for sb and io list
   management
4. push list presence check into inode_lru_list_del(), just like sb and
   io list

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c  |  2 +-
 fs/inode.c         | 40 +++++++++++++++++++++-------------------
 include/linux/fs.h |  2 +-
 mm/filemap.c       |  4 ++--
 mm/truncate.c      |  6 +++---
 mm/vmscan.c        |  2 +-
 mm/workingset.c    |  2 +-
 7 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5dccbe5fb09d..c81fffcb3648 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1455,7 +1455,7 @@ static void inode_sync_complete(struct inode *inode)
 
 	inode_state_clear(inode, I_SYNC);
 	/* If inode is clean an unused, put it into LRU now... */
-	inode_add_lru(inode);
+	inode_lru_list_add(inode);
 	/* Called with inode->i_lock which ensures memory ordering. */
 	inode_wake_up_bit(inode, __I_SYNC);
 }
diff --git a/fs/inode.c b/fs/inode.c
index 274350095537..5f18221b5534 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -530,8 +530,21 @@ void ihold(struct inode *inode)
 }
 EXPORT_SYMBOL(ihold);
 
-static void __inode_add_lru(struct inode *inode, bool rotate)
+struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
+					    struct inode *inode, u32 bit)
+{
+	void *bit_address;
+
+	bit_address = inode_state_wait_address(inode, bit);
+	init_wait_var_entry(wqe, bit_address, 0);
+	return __var_waitqueue(bit_address);
+}
+EXPORT_SYMBOL(inode_bit_waitqueue);
+
+static void __inode_lru_list_add(struct inode *inode, bool rotate)
 {
+	lockdep_assert_held(&inode->i_lock);
+
 	if (inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
 		return;
 	if (icount_read(inode))
@@ -547,29 +560,19 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 		inode_state_set(inode, I_REFERENCED);
 }
 
-struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
-					    struct inode *inode, u32 bit)
-{
-	void *bit_address;
-
-	bit_address = inode_state_wait_address(inode, bit);
-	init_wait_var_entry(wqe, bit_address, 0);
-	return __var_waitqueue(bit_address);
-}
-EXPORT_SYMBOL(inode_bit_waitqueue);
-
 /*
  * Add inode to LRU if needed (inode is unused and clean).
- *
- * Needs inode->i_lock held.
  */
-void inode_add_lru(struct inode *inode)
+void inode_lru_list_add(struct inode *inode)
 {
-	__inode_add_lru(inode, false);
+	__inode_lru_list_add(inode, false);
 }
 
 static void inode_lru_list_del(struct inode *inode)
 {
+	if (list_empty(&inode->i_lru))
+		return;
+
 	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru))
 		this_cpu_dec(nr_unused);
 }
@@ -1894,7 +1897,7 @@ static void iput_final(struct inode *inode)
 	if (!drop &&
 	    !(inode_state_read(inode) & I_DONTCACHE) &&
 	    (sb->s_flags & SB_ACTIVE)) {
-		__inode_add_lru(inode, true);
+		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
@@ -1918,8 +1921,7 @@ static void iput_final(struct inode *inode)
 		inode_state_replace(inode, I_WILL_FREE, I_FREEING);
 	}
 
-	if (!list_empty(&inode->i_lru))
-		inode_lru_list_del(inode);
+	inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
 
 	evict(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21c73df3ce75..018287664571 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3510,7 +3510,7 @@ static inline void remove_inode_hash(struct inode *inode)
 }
 
 extern void inode_sb_list_add(struct inode *inode);
-extern void inode_add_lru(struct inode *inode);
+extern void inode_lru_list_add(struct inode *inode);
 
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..add5228a7d97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -256,7 +256,7 @@ void filemap_remove_folio(struct folio *folio)
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	filemap_free_folio(mapping, folio);
@@ -335,7 +335,7 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 	page_cache_delete_batch(mapping, fbatch);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	for (i = 0; i < folio_batch_count(fbatch); i++)
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..ad9c0fa29d94 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -46,7 +46,7 @@ static void clear_shadow_entries(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 }
 
@@ -111,7 +111,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 out:
 	folio_batch_remove_exceptionals(fbatch);
@@ -622,7 +622,7 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 	__filemap_remove_folio(folio, NULL);
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
+		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
 
 	filemap_free_folio(mapping, folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..bb4a96c7b682 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -811,7 +811,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		__filemap_remove_folio(folio, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
+			inode_lru_list_add(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 
 		if (free_folio)
diff --git a/mm/workingset.c b/mm/workingset.c
index 68a76a91111f..d32dc2e02a61 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -755,7 +755,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping->host != NULL) {
 		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
+			inode_lru_list_add(mapping->host);
 		spin_unlock(&mapping->host->i_lock);
 	}
 	ret = LRU_REMOVED_RETRY;
-- 
2.34.1


