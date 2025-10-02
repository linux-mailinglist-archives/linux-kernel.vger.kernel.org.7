Return-Path: <linux-kernel+bounces-839990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BBDBB33E3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52C24C6B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1C2E11DD;
	Thu,  2 Oct 2025 08:16:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B92E2DFC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392985; cv=none; b=DJzM/94tcHqY5eSpTuYmvWkvrS9on7nkyCs/9YhNK7oue7SuNfLRWCIGP+0+VVZzuBfSSt2jImCwg8iHIDOl4z017DameYsacadlc+aFEqeWDfRMyOzQ0lk/7cI92RiS1FDwVUJA02xvqlig86WYjdibiUMYb01zzdCbTep7Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392985; c=relaxed/simple;
	bh=GcY4QqwdVFNFDaB8hsIOXOXdUOgb56BYgj8HFmrbbIg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L8mtmDvDsRHkrpkWc3mVcb2AWPoAXxrfZ7aY/a4IbP4C8nr1+a0sL8rmDGKPyHZAX4edwp8FhsHOVaDsGIYT7hXjzUEwt9zs6gNMMHQo9bZvWoZrmhz7rc+/QTTS4RoTdLjHoqX1yMgM1z70XOJqsNyOVUcjjdRuGVx7Rp9mZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-bf-68de34d63323
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	clameter@sgi.com,
	kravetz@us.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	max.byungchul.park@gmail.com,
	kernel_team@skhynix.com,
	harry.yoo@oracle.com,
	gwan-gyeong.mun@intel.com,
	yeoreum.yun@arm.com,
	syzkaller@googlegroups.com,
	ysk@kzalloc.com
Subject: [RFC] mm/migrate: make sure folio_unlock() before folio_wait_writeback()
Date: Thu,  2 Oct 2025 17:16:12 +0900
Message-Id: <20251002081612.53281-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXC9ZZnke41k3sZBu/+GVjMWb+GzWLXjRCL
	9Y3r2C2+rv/FbPHz7nF2i4uv/zBZ3F/2jMXi+NZ57BbX1x5lsri8aw6bxb01/1ktvvVJW1yY
	2MtqceRNN7PF3C+GFqvXZFh8Wb2KzWL20XvsDkIea+atYfTYOesuu8eeiSfZPLrbLrN7LN7z
	kslj06dJ7B4Lf79g9jgx4zeLx86Hlh69ze/YPD4+vcXi8X7fVTaPu9eBys5d62P2+LxJLoA/
	issmJTUnsyy1SN8ugSvjxdW5zAXTvCsu96s2ME6y7GLk5JAQMJF4f3MOcxcjB5jde84LJMwm
	oC5x48ZPZhBbREBWYurf8yxdjFwczAKXmSUWbr7DCpIQFgiUWPJ/KhNIL4uAqsTaReUgYV4B
	U4muNVfZIMbLS6zecIAZpFdC4DubxILNW6ASkhIHV9xgmcDIvYCRYRWjUGZeWW5iZo6JXkZl
	XmaFXnJ+7iZGYIgvq/0TvYPx04XgQ4wCHIxKPLwXVO9mCLEmlhVX5h5ilOBgVhLhTVhxJ0OI
	NyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo3DpnjcpD5sS
	NP3b2b22bFgv8bRU/u0pLhmLqE9nPz2bUX+k+kD0S8MfPSc+XTAynbL0824Z1sfdVySk5x5I
	0yq6/06kR3DlBZOL1d0lzveONambVi3pOr0h7qsrw5kJllOthbRrlU77SUrU6S2e01O+ZHq6
	5aTFa3MYGJfbp8kkn0hZZ+8fosRSnJFoqMVcVJwIAMhUt3ptAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAAwFZAqb9CAMSxgMaCGludGVybmFsIgYKBApOO4Mt1jTeaDDn7B84nK+sBji6
	2FQ4r4GuBzj1r/oDOPndxwc40ev8AjjfpuYEOMe1ngc4w53JBTjXrcUCONO6nAY43qz/BTj2
	jhs40JGNBTjC1ucFOMTsiwM4nfQxOKusaDj0q6oGOJvF3gdAFEisnqwBSLma3QdIvJHJBkiL
	htMHSKO86QJIsvKSB0ih++gDSMiY+wRIueE5SI2D7gZI8eXaBEjvvtUGSN3X6QJI9ttISKPo
	8AJIztaOA1ARWgo8ZGVsaXZlci8+YApo6NWdA3CWS3jTjyWAAZI5igEICBgQNBiNzkqKAQkI
	BhAnGNjY+QOKAQkIFBAdGJX9zwSKAQoIAxDTAxihs9wFigEJCBMQURik/5UCigEICAQQJRit
	oneKAQkIDRA1GIqs1QaKAQkIGBAfGKuwwAOQAQigAQCqARRpbnZtYWlsNS5za2h5bml4LmNv
	bbIBBgoEpn38kbgB9NNHwgEQCAEiDA3RJd1oEgVhdnN5bcIBGAgDIhQNYKjcaBINZGF5emVy
	b19ydWxlc8IBGwgEIhcNSldlYBIQZ2F0ZWtlZXBlcl9ydWxlc8IBAggJGoABmrQ6/dQGRW5m
	7tfqdxjvZxxMYkIS4he2oulSk9TUDjcbZqzBICj1qH6tY8JN3Yb3xgeIyoTRzzKOqW7NQmvn
	0YTBD2ur2CObjCx279mhMhGJVNYWjjEV8KduNgcNLh4zyRmPlBhuuyVvWhLofH43LqOK/uHz
	/4B+0aH5S7Gw4bwiBHNoYTEqA3JzYRffiDpZAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

DEPT(Dependency Tracker) reported a deadlock:

   ===================================================
   DEPT: Circular dependency has been detected.
   6.15.11-00046-g2c223fa7bd9a-dirty #13 Not tainted
   ---------------------------------------------------
   summary
   ---------------------------------------------------
   *** DEADLOCK ***

   context A
      [S] (unknown)(pg_locked_map:0)
      [W] dept_page_wait_on_bit(pg_writeback_map:0)
      [E] dept_page_clear_bit(pg_locked_map:0)

   context B
      [S] (unknown)(pg_writeback_map:0)
      [W] dept_page_wait_on_bit(pg_locked_map:0)
      [E] dept_page_clear_bit(pg_writeback_map:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable
   ---------------------------------------------------
   context A's detail
   ---------------------------------------------------
   context A
      [S] (unknown)(pg_locked_map:0)
      [W] dept_page_wait_on_bit(pg_writeback_map:0)
      [E] dept_page_clear_bit(pg_locked_map:0)

   [S] (unknown)(pg_locked_map:0):
   (N/A)

   [W] dept_page_wait_on_bit(pg_writeback_map:0):
   [<ffff800080589c94>] folio_wait_bit+0x2c/0x38
   stacktrace:
         folio_wait_bit_common+0x824/0x8b8
         folio_wait_bit+0x2c/0x38
         folio_wait_writeback+0x5c/0xa4
         migrate_pages_batch+0x5e4/0x1788
         migrate_pages+0x15c4/0x1840
         compact_zone+0x9c8/0x1d20
         compact_node+0xd4/0x27c
         sysctl_compaction_handler+0x104/0x194
         proc_sys_call_handler+0x25c/0x3f8
         proc_sys_write+0x20/0x2c
         do_iter_readv_writev+0x350/0x448
         vfs_writev+0x1ac/0x44c
         do_pwritev+0x100/0x15c
         __arm64_sys_pwritev2+0x6c/0xcc
         invoke_syscall.constprop.0+0x64/0x18c
         el0_svc_common.constprop.0+0x80/0x198

   [E] dept_page_clear_bit(pg_locked_map:0):
   [<ffff800080700914>] migrate_folio_undo_src+0x1b4/0x200
   stacktrace:
         migrate_folio_undo_src+0x1b4/0x200
         migrate_pages_batch+0x1578/0x1788
         migrate_pages+0x15c4/0x1840
         compact_zone+0x9c8/0x1d20
         compact_node+0xd4/0x27c
         sysctl_compaction_handler+0x104/0x194
         proc_sys_call_handler+0x25c/0x3f8
         proc_sys_write+0x20/0x2c
         do_iter_readv_writev+0x350/0x448
         vfs_writev+0x1ac/0x44c
         do_pwritev+0x100/0x15c
         __arm64_sys_pwritev2+0x6c/0xcc
         invoke_syscall.constprop.0+0x64/0x18c
         el0_svc_common.constprop.0+0x80/0x198
         do_el0_svc+0x28/0x3c
         el0_svc+0x50/0x220
   ---------------------------------------------------
   context B's detail
   ---------------------------------------------------
   context B
      [S] (unknown)(pg_writeback_map:0)
      [W] dept_page_wait_on_bit(pg_locked_map:0)
      [E] dept_page_clear_bit(pg_writeback_map:0)

   [S] (unknown)(pg_writeback_map:0):
   (N/A)

   [W] dept_page_wait_on_bit(pg_locked_map:0):
   [<ffff80008081e478>] bdev_getblk+0x58/0x120
   stacktrace:
         find_get_block_common+0x224/0xbc4
         bdev_getblk+0x58/0x120
         __ext4_get_inode_loc+0x194/0x98c
         ext4_get_inode_loc+0x4c/0xcc
         ext4_reserve_inode_write+0x74/0x158
         __ext4_mark_inode_dirty+0xd4/0x4e0
         __ext4_ext_dirty+0x118/0x164
         ext4_ext_map_blocks+0x1578/0x2ca8
         ext4_map_blocks+0x2a4/0xa60
         ext4_convert_unwritten_extents+0x1b0/0x3c0
         ext4_convert_unwritten_io_end_vec+0x90/0x1a0
         ext4_end_io_end+0x58/0x194
         ext4_end_io_rsv_work+0xc4/0x150
         process_one_work+0x3b4/0xac0
         worker_thread+0x2b0/0x53c
         kthread+0x1a0/0x33c

   [E] dept_page_clear_bit(pg_writeback_map:0):
   [<ffff8000809dfc5c>] ext4_finish_bio+0x638/0x820
   stacktrace:
         folio_end_writeback+0x140/0x488
         ext4_finish_bio+0x638/0x820
         ext4_release_io_end+0x74/0x188
         ext4_end_io_end+0xa0/0x194
         ext4_end_io_rsv_work+0xc4/0x150
         process_one_work+0x3b4/0xac0
         worker_thread+0x2b0/0x53c
         kthread+0x1a0/0x33c
         ret_from_fork+0x10/0x20

To simplify the scenario:

   context X (wq worker)	context Y (process context)

				migrate_pages_batch()
   ext4_end_io_end()		  ...
     ...			  migrate_folio_unmap()
     ext4_get_inode_loc()	    ...
       ...			    folio_lock() // hold the folio lock
       bdev_getblk()		    ...
         ...			    folio_wait_writeback() // wait forever
         __find_get_block_slow()
           ...			    ...
           folio_lock() // wait forever
           folio_unlock()	  migrate_folio_undo_src()
				    ...
     ...			    folio_unlock() // never reachable
     ext4_finish_bio()
	...
	folio_end_writeback() // never reachable

context X is waiting for the folio lock to be released by context Y,
while context Y is waiting for the writeback to end in context X.
Ultimately, two contexts are waiting for the event that will never
happen, say, deadlock.

*Only one* of the following two conditions should be allowed, or we
cannot avoid this kind of deadlock:

   1. while holding a folio lock (and heading for folio_unlock()),
      waiting for a writeback to end,
   2. while heading for the writeback end, waiting for the folio lock to
      be released,

Since allowing 2 and avoiding 1 sound more sensible than the other,
remove the first condition by making sure folio_unlock() before
folio_wait_writeback() in migrate_folio_unmap().

Fixes: 49d2e9cc45443 ("[PATCH] Swap Migration V5: migrate_pages() function")
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
Tested-by: Yunseong Kim <ysk@kzalloc.com>
---

Hi,

Thanks to Yunseong for reporting the issue, testing, and confirming if
this patch can resolve the issue.  We used the latest version of DEPT
to detect the issue:

   https://lore.kernel.org/all/20251002081247.51255-1-byungchul@sk.com/

I mentioned in the commit message above like:

   *Only one* of the following two conditions should be allowed, or we
   cannot avoid this kind of deadlock:
   
      1. while holding a folio lock (and heading for folio_unlock()),
         waiting for a writeback to end,
      2. while heading for the writeback end, waiting for the folio lock
         to be released,

Honestly, I'm not convinced which one we should choose between two, I
chose 'allowing 2 and avoiding 1' to resolve this issue though.

However, please let me know if I was wrong and we should go for
'allowing 1 and avoiding 2'.  If so, I should try a different approach,
for example, to fix by preventing folio_lock() or using folio_try_lock()
while heading for writeback end in ext4_end_io_end() or something.

To Yunseong,

The link you shared for a system hang is:

   https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5

I think an important stacktrace for this issue, this is, waiting for
PG_writeback, was missed in the log.

	Byungchul

---
 mm/migrate.c | 57 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9e5ef39ce73a..60b0b054f27a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1215,6 +1215,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	dst->private = NULL;
 
+retry_wait_writeback:
+	/*
+	 * Only in the case of a full synchronous migration is it
+	 * necessary to wait for PageWriteback.  In the async case, the
+	 * retry loop is too short and in the sync-light case, the
+	 * overhead of stalling is too much.  Plus, do not write-back if
+	 * it's in the middle of direct compaction
+	 */
+	if (folio_test_writeback(src) && mode == MIGRATE_SYNC)
+		folio_wait_writeback(src);
+
 	if (!folio_trylock(src)) {
 		if (mode == MIGRATE_ASYNC)
 			goto out;
@@ -1245,27 +1256,41 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 		folio_lock(src);
 	}
-	locked = true;
-	if (folio_test_mlocked(src))
-		old_page_state |= PAGE_WAS_MLOCKED;
 
 	if (folio_test_writeback(src)) {
-		/*
-		 * Only in the case of a full synchronous migration is it
-		 * necessary to wait for PageWriteback. In the async case,
-		 * the retry loop is too short and in the sync-light case,
-		 * the overhead of stalling is too much
-		 */
-		switch (mode) {
-		case MIGRATE_SYNC:
-			break;
-		default:
-			rc = -EBUSY;
-			goto out;
+		if (mode == MIGRATE_SYNC) {
+			/*
+			 * folio_unlock() is required before trying
+			 * folio_wait_writeback().  Or it leads a
+			 * deadlock like:
+			 *
+			 *   context x		context y
+			 *   in XXX_io_end()	in migrate_folio_unmap()
+			 *
+			 *   ...		...
+			 *   bdev_getblk();	folio_lock();
+			 *
+			 *     // wait forever	// wait forever
+			 *     folio_lock();	folio_wait_writeback();
+			 *
+			 *     ...		...
+			 *     folio_unlock();
+			 *   ...		// never reachable
+			 *			folio_unlock();
+			 *   // never reachable
+			 *   folio_end_writeback();
+			 */
+			folio_unlock(src);
+			goto retry_wait_writeback;
 		}
-		folio_wait_writeback(src);
+		rc = -EBUSY;
+		goto out;
 	}
 
+	locked = true;
+	if (folio_test_mlocked(src))
+		old_page_state |= PAGE_WAS_MLOCKED;
+
 	/*
 	 * By try_to_migrate(), src->mapcount goes down to 0 here. In this case,
 	 * we cannot notice that anon_vma is freed while we migrate a page.

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.17.1


