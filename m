Return-Path: <linux-kernel+bounces-733076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A039AB06FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CA18910CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947F28ECD7;
	Wed, 16 Jul 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uw1IAaXF"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C727144B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653166; cv=none; b=AvbMr9A8fEEOsQftYjwPcg/A/XGlT60/jwhgxvmqMIJMNv9ML8006PbWgmXhBasx15MGxgN4J05MutnFbJaaz/5QzjdAD56l9SPLXXdSvISWtFguZWCHxPQ1dsPLkVIql0bpE2VLsqkur+r+6h/+o3DUAO+6XnZEloERQ5UyGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653166; c=relaxed/simple;
	bh=y6YpRjek3EuKx6SriMMREdUGujpRl5lW/PT32afEw6c=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=TzzLGfrJJANBjXKQlC4e3PCsUc9CFMVZQQgljaetBpu0/VDJycCg5Y5+RPJ6dfXFIS0wLtl/ETYCoIS2dvw8UGLf/t8ZrGzYIXO6xTemBQ5hqDmRDKh9TiNvmSbEEyxxnYexH/XndT6PhScwCL6y0feuaWnaOjhKwU4EufgRoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uw1IAaXF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8187601f85so5593599276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752653163; x=1753257963; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bqtxBqtN8vQ8p/jPa38XSR40F5AnDNFFUmJHLtEITu8=;
        b=Uw1IAaXFNNty1iealE/hXIOJvryp4c953piGE+SYqA0eiVgAR3iafO3kNm/9VWqMi4
         p12p2HTlodE3bp7nuXaIEvknuqKev8M+9uolo1KuYplx1B0Oz276p5jCftim9/9J2+nY
         pztumf5ipU639LzUB3peGCfUegW7pdGQxKabqvx/c1VKDkfQN8sTPNKTKxeqaVZkjxux
         m4Z04gRDCzKdIKcQyqCf6scP5eavdrGURjcuyyk3yHQU5QA1jrkXmHycZd06e/b8HZXL
         W/MriGVyzHjdNEcvMrnEFmKQXBNj5fw8IvfxfEZBqyHpUM3kMX6zUM/Mi2XYIzMHf/JY
         yFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653163; x=1753257963;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqtxBqtN8vQ8p/jPa38XSR40F5AnDNFFUmJHLtEITu8=;
        b=cfBSPAGtYmGtNPhaVG1FVO3uBLChq693TiKSC4roFgRMoXWrfzhe+IP1hdX7LC8jv0
         bRW5OC8sBFQuV6L1zNmaKZcWa/wFMrar0ldavQ/4gWqAIsgFuLqpixWT6oMUJecg8VCl
         efeKPu4PZf6B8UiZpW0UAvJBoUoU4wpZTZxdQHc3hj2G+YTzZaXFB4U+4nPr9uQpvVwb
         pIY+aE7Geu/2YbUfQCc5u+qj09Inyk/PaHYRhkiVNzmxaVdhHrQ4DyovFQ06dqb2iy5C
         LO7613C8CbhA6KgAQRLge/vWIgPpKhGF039+ViKrecP3AC+ZuNg7HEQiScpiHs2/SNSU
         4s2g==
X-Forwarded-Encrypted: i=1; AJvYcCUC7bGbhT2jAIpWetHhNnptzZ0c988Dykio020YPzGTFjjk97WNU/ic9CmLGDS7JGa57uVEDsMO6dJwtjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6onsQcTxoUQh2v3o6xDwMpAVZ2MiGK1adE43gn5F+FtxoGmVU
	Dub26dv6oYmAm0E3r/0WzGwPuP97rhQ7KSk04r4UcFEi//vG2gWNYC/vS+MGAGZvGA==
X-Gm-Gg: ASbGncuEE+CJxVhB3CbQEXUeNhcT7icfzPZJBw3ibUJ5KYIKaZtR5NJco8OG4OhnouO
	QB5va4tl0IYI3/7csk4xKuTyrF5BcBl1kx/HRc2jJIuIWNIWncFeM24XXd7sXn9+8XMPVFJHd73
	eKmiyXQayoPmphHDtO36bfvvsE/R31PUDr8gkil8OAW6uwYte9uqMfvJ5AQ8CcrbzpQkHtp3hSz
	LU6/d24lbv2gkduC7Ibg4W11sZXIMT/0wd5+CXh8iHl5h8zR68Tux6qUjOfxWslecG0Jg/AUtIs
	Le2rHWxvIF9JuaXOEZBSjXz/hps7lZ3dW6oMJmrgeQ/FIV2KscpBwZG54NANykJ+BIvrZFqvmkn
	qBYeJGxkriX6/Sfb7sE912BI3Cb3+0iJak6TQVs8LFqN6wJDVBlq+5ke6czf9INExsWPEHUX9T0
	apFmTyODA=
X-Google-Smtp-Source: AGHT+IFBVzdIK9GW0gSHL3NVXNkmY6WyahhMky4UyM9jrdqIZPfwYSuC5koJmIQUN+dX6es3hs2lkw==
X-Received: by 2002:a05:690c:4d41:b0:712:cc11:af8 with SMTP id 00721157ae682-71835163330mr29495957b3.27.1752653163026;
        Wed, 16 Jul 2025 01:06:03 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c61b4b7dsm28117337b3.58.2025.07.16.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:06:01 -0700 (PDT)
Date: Wed, 16 Jul 2025 01:05:50 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
    David Rientjes <rientjes@google.com>, Kairui Song <ryncsn@gmail.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH mm-new 1/2] mm/shmem: hold shmem_swaplist spinlock (not mutex)
 much less
Message-ID: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

A flamegraph (from an MGLRU load) showed shmem_writeout()'s use of the
global shmem_swaplist_mutex worryingly hot: improvement is long overdue.

3.1 commit 6922c0c7abd3 ("tmpfs: convert shmem_writepage and enable swap")
apologized for extending shmem_swaplist_mutex across add_to_swap_cache(),
and hoped to find another way: yes, there may be lots of work to allocate
radix tree nodes in there.  Then 6.15 commit b487a2da3575 ("mm, swap:
simplify folio swap allocation") will have made it worse, by moving
shmem_writeout()'s swap allocation under that mutex too (but the worrying
flamegraph was observed even before that change).

There's a useful comment about pagelock no longer protecting from eviction
once moved to swap cache: but it's good till shmem_delete_from_page_cache()
replaces page pointer by swap entry, so move the swaplist add between them.

We would much prefer to take the global lock once per inode than once per
page: given the possible races with shmem_unuse() pruning when !swapped
(and other tasks racing to swap other pages out or in), try the swaplist
add whenever swapped was incremented from 0 (but inode may already be on
the list - only unuse and evict bother to remove it).

This technique is more subtle than it looks (we're avoiding the very lock
which would make it easy), but works: whereas an unlocked list_empty()
check runs a risk of the inode being unqueued and left off the swaplist
forever, swapoff only completing when the page is faulted in or removed.

The need for a sleepable mutex went away in 5.1 commit b56a2d8af914
("mm: rid swapoff of quadratic complexity"): a spinlock works better now.

This commit is certain to take shmem_swaplist_mutex out of contention,
and has been seen to make a practical improvement (but there is likely
to have been an underlying issue which made its contention so visible).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 59 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 60247dc48505..33675361031b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -292,7 +292,7 @@ bool vma_is_shmem(struct vm_area_struct *vma)
 }
 
 static LIST_HEAD(shmem_swaplist);
-static DEFINE_MUTEX(shmem_swaplist_mutex);
+static DEFINE_SPINLOCK(shmem_swaplist_lock);
 
 #ifdef CONFIG_TMPFS_QUOTA
 
@@ -432,10 +432,13 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  *
  * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
  * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
+ *
+ * Return: true if swapped was incremented from 0, for shmem_writeout().
  */
-static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	bool first_swapped = false;
 	long freed;
 
 	spin_lock(&info->lock);
@@ -450,8 +453,11 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 	 * to stop a racing shmem_recalc_inode() from thinking that a page has
 	 * been freed.  Compensate here, to avoid the need for a followup call.
 	 */
-	if (swapped > 0)
+	if (swapped > 0) {
+		if (info->swapped == swapped)
+			first_swapped = true;
 		freed += swapped;
+	}
 	if (freed > 0)
 		info->alloced -= freed;
 	spin_unlock(&info->lock);
@@ -459,6 +465,7 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 	/* The quota case may block */
 	if (freed > 0)
 		shmem_inode_unacct_blocks(inode, freed);
+	return first_swapped;
 }
 
 bool shmem_charge(struct inode *inode, long pages)
@@ -1399,11 +1406,11 @@ static void shmem_evict_inode(struct inode *inode)
 			/* Wait while shmem_unuse() is scanning this inode... */
 			wait_var_event(&info->stop_eviction,
 				       !atomic_read(&info->stop_eviction));
-			mutex_lock(&shmem_swaplist_mutex);
+			spin_lock(&shmem_swaplist_lock);
 			/* ...but beware of the race if we peeked too early */
 			if (!atomic_read(&info->stop_eviction))
 				list_del_init(&info->swaplist);
-			mutex_unlock(&shmem_swaplist_mutex);
+			spin_unlock(&shmem_swaplist_lock);
 		}
 	}
 
@@ -1526,7 +1533,7 @@ int shmem_unuse(unsigned int type)
 	if (list_empty(&shmem_swaplist))
 		return 0;
 
-	mutex_lock(&shmem_swaplist_mutex);
+	spin_lock(&shmem_swaplist_lock);
 start_over:
 	list_for_each_entry_safe(info, next, &shmem_swaplist, swaplist) {
 		if (!info->swapped) {
@@ -1540,12 +1547,12 @@ int shmem_unuse(unsigned int type)
 		 * (igrab() would protect from unlink, but not from unmount).
 		 */
 		atomic_inc(&info->stop_eviction);
-		mutex_unlock(&shmem_swaplist_mutex);
+		spin_unlock(&shmem_swaplist_lock);
 
 		error = shmem_unuse_inode(&info->vfs_inode, type);
 		cond_resched();
 
-		mutex_lock(&shmem_swaplist_mutex);
+		spin_lock(&shmem_swaplist_lock);
 		if (atomic_dec_and_test(&info->stop_eviction))
 			wake_up_var(&info->stop_eviction);
 		if (error)
@@ -1556,7 +1563,7 @@ int shmem_unuse(unsigned int type)
 		if (!info->swapped)
 			list_del_init(&info->swaplist);
 	}
-	mutex_unlock(&shmem_swaplist_mutex);
+	spin_unlock(&shmem_swaplist_lock);
 
 	return error;
 }
@@ -1646,30 +1653,30 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		folio_mark_uptodate(folio);
 	}
 
-	/*
-	 * Add inode to shmem_unuse()'s list of swapped-out inodes,
-	 * if it's not already there.  Do it now before the folio is
-	 * moved to swap cache, when its pagelock no longer protects
-	 * the inode from eviction.  But don't unlock the mutex until
-	 * we've incremented swapped, because shmem_unuse_inode() will
-	 * prune a !swapped inode from the swaplist under this mutex.
-	 */
-	mutex_lock(&shmem_swaplist_mutex);
-	if (list_empty(&info->swaplist))
-		list_add(&info->swaplist, &shmem_swaplist);
-
 	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
-		shmem_recalc_inode(inode, 0, nr_pages);
+		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
+
+		/*
+		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
+		 * if it's not already there.  Do it now before the folio is
+		 * removed from page cache, when its pagelock no longer
+		 * protects the inode from eviction.  And do it now, after
+		 * we've incremented swapped, because shmem_unuse() will
+		 * prune a !swapped inode from the swaplist.
+		 */
+		if (first_swapped) {
+			spin_lock(&shmem_swaplist_lock);
+			if (list_empty(&info->swaplist))
+				list_add(&info->swaplist, &shmem_swaplist);
+			spin_unlock(&shmem_swaplist_lock);
+		}
+
 		swap_shmem_alloc(folio->swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
-		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(folio_mapped(folio));
 		return swap_writeout(folio, plug);
 	}
-	if (!info->swapped)
-		list_del_init(&info->swaplist);
-	mutex_unlock(&shmem_swaplist_mutex);
 	if (nr_pages > 1)
 		goto try_split;
 redirty:
-- 
2.43.0

