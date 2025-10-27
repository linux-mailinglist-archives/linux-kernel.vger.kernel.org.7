Return-Path: <linux-kernel+bounces-871215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68BC0CA47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC954EF562
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006D1C1F02;
	Mon, 27 Oct 2025 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Nv+qhXxZ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECC2E717C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557060; cv=none; b=srVzv03CDTybGK/H3cU9BKwQ2jYzTTwHAON9is69klUYBXH7olX8885VZWMqrTZocgoSuUzezgaEQ+qYEfkWBRbLxTwXcClGx9wRutja9SAaAXWXNFxqFCn1CRsD5YqjpPstGNlTTNp4UrWTflhtiBMZFfeEg0HjG3RIm8EZ3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557060; c=relaxed/simple;
	bh=53CKdD4ogqQhr2ms2TfSWhL3ujfqvSEgJ3WZQhEy8io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFe7H8blAyzeC5y3yBoUAyaMCJM7+3kn/Lhrkbvwtu5VuCv4ZS0EEi+CdQL9YPLzLixufYVAi9bub5Bi13YmnRADBzpzrkthBzO/X9jO3w3LL8Qjf+2wRN+r4ajjCLfVVHneh6/58KWb+GIWU9umJS6ahzitJcs8UD2sIB84q68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Nv+qhXxZ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oB
	P7+tHGxe9BmbqxkJRcuHmO2ZjvxtiBHaeh2QGjUL0=; b=Nv+qhXxZzR7Ok2d+VM
	Ix7vgAHJHdeai35Z4TQP0OYIS3o/8/12wAD7VDZZ129mRvkv77oPm+fNsfgRLvPS
	IIs9tGlVtt/Z8EFiJ9EyBOKtpbXRbGs/MIxtXmoXxhDPXVdcSI0WxRH5hGf+7LM3
	SuXVPGzLpyiE9XNjx/+bzQq5Y=
Received: from gt-ubuntu22-04-cmd-v3-0-64gb-25m.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3p5YgOv9otPZyAg--.9797S2;
	Mon, 27 Oct 2025 17:23:45 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	stable@kernel.org,
	Xiaole He <hexiaole1994@126.com>
Subject: [PATCH v2] f2fs: fix age extent cache insertion skip on counter overflow
Date: Mon, 27 Oct 2025 17:23:41 +0800
Message-Id: <20251027092341.5011-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023035416.7943-1-hexiaole1994@126.com>
References: <20251023035416.7943-1-hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3p5YgOv9otPZyAg--.9797S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr43CFWDXrW7ur4fCw4Durg_yoW7CrWDp3
	4xCF15Kr45uw48Xa92vr1kCF1S9w4kJFWxGrZFy34jva45X34fWF1kt345ZrWvqF4rXF1D
	Za1Y934UJw1UGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziK0PfUUUUU=
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbijgnzBmj-NLOCkQAAsx

The age extent cache uses last_blocks (derived from
allocated_data_blocks) to determine data age. However, there's a
conflict between the deletion
marker (last_blocks=0) and legitimate last_blocks=0 cases when
allocated_data_blocks overflows to 0 after reaching ULLONG_MAX.

In this case, valid extents are incorrectly skipped due to the
"if (!tei->last_blocks)" check in __update_extent_tree_range().

This patch fixes the issue by:
1. Reserving ULLONG_MAX as an invalid/deletion marker
2. Limiting allocated_data_blocks to range [0, ULLONG_MAX-1]
3. Using F2FS_EXTENT_AGE_INVALID for deletion scenarios
4. Adjusting overflow age calculation from ULLONG_MAX to (ULLONG_MAX-1)

Reproducer (using a patched kernel with allocated_data_blocks
initialized to ULLONG_MAX - 3 for quick testing):

Step 1: Mount and check initial state
  # dd if=/dev/zero of=/tmp/test.img bs=1M count=100
  # mkfs.f2fs -f /tmp/test.img
  # mkdir -p /mnt/f2fs_test
  # mount -t f2fs -o loop,age_extent_cache /tmp/test.img /mnt/f2fs_test
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 18446744073709551612 # ULLONG_MAX - 3
  Inner Struct Count: tree: 1(0), node: 0

Step 2: Create files and write data to trigger overflow
  # touch /mnt/f2fs_test/{1,2,3,4}.txt; sync
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 18446744073709551613 # ULLONG_MAX - 2
  Inner Struct Count: tree: 5(0), node: 1

  # dd if=/dev/urandom of=/mnt/f2fs_test/1.txt bs=4K count=1; sync
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 18446744073709551614 # ULLONG_MAX - 1
  Inner Struct Count: tree: 5(0), node: 2

  # dd if=/dev/urandom of=/mnt/f2fs_test/2.txt bs=4K count=1; sync
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 18446744073709551615 # ULLONG_MAX
  Inner Struct Count: tree: 5(0), node: 3

  # dd if=/dev/urandom of=/mnt/f2fs_test/3.txt bs=4K count=1; sync
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 0 # Counter overflowed!
  Inner Struct Count: tree: 5(0), node: 4

Step 3: Trigger the bug - next write should create node but gets skipped
  # dd if=/dev/urandom of=/mnt/f2fs_test/4.txt bs=4K count=1; sync
  # cat /sys/kernel/debug/f2fs/status | grep -A 4 "Block Age"
  Allocated Data Blocks: 1
  Inner Struct Count: tree: 5(0), node: 4

  Expected: node: 5 (new extent node for 4.txt)
  Actual: node: 4 (extent insertion was incorrectly skipped due to
  last_blocks = allocated_data_blocks = 0 in __get_new_block_age)

After this fix, the extent node is correctly inserted and node count
becomes 5 as expected.

Fixes: 71644dff4811 ("f2fs: add block_age-based extent cache")
Cc: stable@kernel.org
Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
Changes in v2:
- Added Fixes tag and Cc stable
- Updated reproducer to use 'grep -A 4' for better output clarity
---
 fs/f2fs/extent_cache.c | 5 +++--
 fs/f2fs/f2fs.h         | 6 ++++++
 fs/f2fs/segment.c      | 9 +++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 33e09c453c70..0ed84cc065a7 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -808,7 +808,7 @@ static void __update_extent_tree_range(struct inode *inode,
 	}
 	goto out_read_extent_cache;
 update_age_extent_cache:
-	if (!tei->last_blocks)
+	if (tei->last_blocks == F2FS_EXTENT_AGE_INVALID)
 		goto out_read_extent_cache;
 
 	__set_extent_info(&ei, fofs, len, 0, false,
@@ -912,7 +912,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 			cur_age = cur_blocks - tei.last_blocks;
 		else
 			/* allocated_data_blocks overflow */
-			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
+			cur_age = (ULLONG_MAX - 1) - tei.last_blocks + cur_blocks;
 
 		if (tei.age)
 			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
@@ -1114,6 +1114,7 @@ void f2fs_update_age_extent_cache_range(struct dnode_of_data *dn,
 	struct extent_info ei = {
 		.fofs = fofs,
 		.len = len,
+		.last_blocks = F2FS_EXTENT_AGE_INVALID,
 	};
 
 	if (!__may_extent_tree(dn->inode, EX_BLOCK_AGE))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5b4e9548a231..fa3c676adc30 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -707,6 +707,12 @@ enum extent_type {
 	NR_EXTENT_CACHES,
 };
 
+/*
+ * Reserved value to mark invalid age extents, hence valid block range
+ * from 0 to ULLONG_MAX-1
+ */
+#define F2FS_EXTENT_AGE_INVALID	ULLONG_MAX
+
 struct extent_info {
 	unsigned int fofs;		/* start offset in a file */
 	unsigned int len;		/* length of the extent */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..a473cd1fb37d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3863,8 +3863,13 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
 	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
 
-	if (IS_DATASEG(curseg->seg_type))
-		atomic64_inc(&sbi->allocated_data_blocks);
+	if (IS_DATASEG(curseg->seg_type)) {
+		unsigned long long new_val;
+
+		new_val = atomic64_inc_return(&sbi->allocated_data_blocks);
+		if (unlikely(new_val == ULLONG_MAX))
+			atomic64_set(&sbi->allocated_data_blocks, 0);
+	}
 
 	up_write(&sit_i->sentry_lock);
 
-- 
2.34.1


