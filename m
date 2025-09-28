Return-Path: <linux-kernel+bounces-835379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C2BA6F06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED4217CC17
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838E2DCBF3;
	Sun, 28 Sep 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0w1x+sS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271729E115
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055074; cv=none; b=njhxH5ni3EBTExLRMKn/6hFCdmFCzxO5Gy0TtV2EFch9phFO2nDwf/UCJHvAeaygcOcUCEE+h3Onx/0bomDP7mVciP5GeGYGvw6upNQznpJ0t80wGeNEfcTJV6A0iY4jntcmzGZgrLq6PWdxyLvUvodNvn5+Wll9GvR5iVWuZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055074; c=relaxed/simple;
	bh=0SFpAeRsj+73ToPc1OCYE3veDt4HP4vYJm03fBRLVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fc+GnAjGZCwk1plFxYnOvNw/c71I3VUfMn5W3M/nO045P7KKjAKIGv0mTnqmrmcGf0/9ijXRfMrTNe7dUw9dHEwDJoBP7Jxn0zlZjkWuX/Mx8gkN+B0EqDLOSxq0T/m6WzHoZc1uerSi8KWPLtv18CAvgVOUxUID3Qj8nxOISQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0w1x+sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55264C4CEF0;
	Sun, 28 Sep 2025 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759055073;
	bh=0SFpAeRsj+73ToPc1OCYE3veDt4HP4vYJm03fBRLVFE=;
	h=From:To:Cc:Subject:Date:From;
	b=M0w1x+sSdZtVvYm0WP1ebGpHK0/h2vx/PYXiyih7hcXRENwvq/tHs3H5tCQG47n2G
	 ZMkt8QrzTerKDYx9+Zec+DvaZg4+p1ermiQRK9jxMKWHqAcA4BnkU0IMNhqu+bIPZx
	 CgSHwnbldWWwwBE7jyr6LoF2ZIUJdEFexve3BtSj9cle9wFRahYJEHJQyTYH40M/0L
	 YSYq1QIwrbb89KiyzhybVzqiOsCVUDTsKixmhgyD1h4TA1iUG/V0qU3ufJN2pFZJ+3
	 buvVnSu7k/cstow3Up5U8yIKpMdePiZKX5JM43fz52mWl4c/gtDi1Oo5yIb+liBy6I
	 uGGhxtX6u4B2A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	JY <JY.Ho@mediatek.com>
Subject: [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
Date: Sun, 28 Sep 2025 18:24:22 +0800
Message-ID: <20250928102422.300429-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As JY reported in bugzilla [1],

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
pc : [0xffffffe51d249484] f2fs_is_cp_guaranteed+0x70/0x98
lr : [0xffffffe51d24adbc] f2fs_merge_page_bio+0x520/0x6d4
CPU: 3 UID: 0 PID: 6790 Comm: kworker/u16:3 Tainted: P    B   W  OE      6.12.30-android16-5-maybe-dirty-4k #1 5f7701c9cbf727d1eebe77c89bbbeb3371e895e5
Tainted: [P]=PROPRIETARY_MODULE, [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Workqueue: writeback wb_workfn (flush-254:49)
Call trace:
 f2fs_is_cp_guaranteed+0x70/0x98
 f2fs_inplace_write_data+0x174/0x2f4
 f2fs_do_write_data_page+0x214/0x81c
 f2fs_write_single_data_page+0x28c/0x764
 f2fs_write_data_pages+0x78c/0xce4
 do_writepages+0xe8/0x2fc
 __writeback_single_inode+0x4c/0x4b4
 writeback_sb_inodes+0x314/0x540
 __writeback_inodes_wb+0xa4/0xf4
 wb_writeback+0x160/0x448
 wb_workfn+0x2f0/0x5dc
 process_scheduled_works+0x1c8/0x458
 worker_thread+0x334/0x3f0
 kthread+0x118/0x1ac
 ret_from_fork+0x10/0x20

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220575

The panic was caused by UAF issue w/ below race condition:

kworker
- writepages
 - f2fs_write_cache_pages
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #1 into bio & cache bio in
        io->bio_list
  - f2fs_write_single_data_page
   - f2fs_do_write_data_page
    - f2fs_inplace_write_data
     - f2fs_merge_page_bio
      - add_inu_page
      : cache page #2 into bio which is linked
        in io->bio_list
						write
						- f2fs_write_begin
						: write page #1
						 - f2fs_folio_wait_writeback
						  - f2fs_submit_merged_ipu_write
						   - f2fs_submit_write_bio
						   : submit bio which inclues page #1 and #2

						software IRQ
						- f2fs_write_end_io
						 - fscrypt_free_bounce_page
						 : freed bounced page which belongs to page #2
      - inc_page_count( , WB_DATA_TYPE(data_folio), false)
      : data_folio points to fio->encrypted_page
        the bounced page can be freed before
        accessing it in f2fs_is_cp_guarantee()

It can reproduce w/ below testcase:
Run below script in shell #1:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

Run below script in shell #2:
for ((i=1;i>0;i++)) do xfs_io -f /mnt/f2fs/enc/file \
-c "pwrite 0 32k" -c "fdatasync"

So, in f2fs_merge_page_bio(), let's avoid using fio->encrypted_page after
commit page into internal ipu cache.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Reported-by: JY <JY.Ho@mediatek.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 82ae31b8ecc4..9d1d439e2650 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -919,7 +919,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(data_folio, false));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(folio, false));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
-- 
2.49.0


