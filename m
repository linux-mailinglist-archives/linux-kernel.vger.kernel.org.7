Return-Path: <linux-kernel+bounces-893275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD348C46FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3913BF1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3EB31282D;
	Mon, 10 Nov 2025 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dIYSIzds"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2EC3112B0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781877; cv=none; b=gW89PoML5vCG0ad9A1+28D0VCCVBXZ/vGWb9QHLFveiUBF2R8uPnbrA+ndmGlHv0KBmgBj+mNaiBnw5uQDXKABgyZeKMV65nyk3W8uq6r7cU3z6kT8d8aSOZ2aNMvGRAZSrGQSsmurRqbi0c68nRLlD8FWUqh2nygeKz/H3Gm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781877; c=relaxed/simple;
	bh=Agip5VIUckJwYmuzgyCmn5a8P5/d+Pkq0U2EkPbcvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOEVjAjZuB30ilvlpufJbWYurMcaKAuIZry7o+atgCMYCSfIJynsEXUeHgEAk8SmC32r8l8uzZbF4exznOjlAZJ7ydSV3gIf96mWUc+hZWUkzc4dEdoZKo6K0XwRqFqFH30b/rWJZ9Amhzp+/j2d/OvDnbQHWx/XUVPQ+s2s4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dIYSIzds; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mi
	a422mlEesoTBfhRn/yCjSqZVQ0iuEMVkMXEpjpE+Q=; b=dIYSIzdsw2ZcuMpA4h
	vABCCHm691nm4Pwq+QeyXDHnL3dXLmxMqqWp1Wk5uMI0WoCb0LaiMnDAqo35+GLr
	26k8xETGE0+mheoBCbzzLeccEauCAJiBHJRWbcJbJrTVMaXkNSBqqz1PS42dnsRK
	LDFa3YkeSOvZ6lnAqT6onNDpo=
Received: from hpz640.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3SMIl6BFpQXf_Ag--.45629S2;
	Mon, 10 Nov 2025 21:27:02 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaole He <hexiaole1994@126.com>,
	stable@kernel.org
Subject: [PATCH v1] f2fs: fix has_curseg_enough_space to check all data segments for dentry blocks
Date: Mon, 10 Nov 2025 21:26:54 +0800
Message-ID: <20251110132654.6485-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3SMIl6BFpQXf_Ag--.45629S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4xWFW3Ar4kCrWDXrWfAFb_yoWrtr43pF
	47CF9xKr4rur1xuasaq3W8AF1S93y8ur4UJr1Iq3sYyr4rWF1Skw1kt345XF1vkrs3Jr1x
	XFZIyFy5A3WDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUManUUUUU=
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbieh8CBmkR5xMTBwAAs5

When active_logs == 6, dentry blocks can be allocated to HOT, WARM, or
COLD segments based on various conditions in __get_segment_type_6():
- age extent cache (if enabled)
- FI_HOT_DATA flag (set when dirty_pages <= min_hot_blocks)
- rw_hint (defaults to WARM via f2fs_rw_hint_to_seg_type)
- file_is_hot(), FI_NEED_IPU, f2fs_is_cow_file(), etc.

However, has_curseg_enough_space() only checked CURSEG_HOT_DATA segment
for dentry blocks, which could lead to incorrect space calculation when
dentry blocks are actually allocated to WARM or COLD segments.

Reproducer:
Note: This reproducer requires adding a tracepoint to observe segment
type. Add the following tracepoint to include/trace/events/f2fs.h:

TRACE_EVENT(f2fs_allocate_data_block,
        TP_PROTO(struct f2fs_sb_info *sbi, struct inode *inode,
                enum log_type type, block_t blkaddr),

        TP_ARGS(sbi, inode, type, blkaddr),

        TP_STRUCT__entry(
                __field(dev_t, dev)
                __field(ino_t, ino)
                __field(int, type)
                __field(block_t, blkaddr)
                __field(int, is_dir)
        ),

        TP_fast_assign(
                __entry->dev = sbi->sb->s_dev;
                __entry->ino = inode ? inode->i_ino : 0;
                __entry->type = type;
                __entry->blkaddr = blkaddr;
                __entry->is_dir = inode ? S_ISDIR(inode->i_mode) : 0;
        ),

        TP_printk("dev = (%d,%d), ino = %lu, %s, blkaddr = %u, is_dir = %d",
                show_dev(__entry->dev),
                (unsigned long)__entry->ino,
                show_data_type(__entry->type),
                __entry->blkaddr,
                __entry->is_dir)
);

And add the tracepoint call in fs/f2fs/segment.c in
f2fs_allocate_data_block() function. Find the location after
locate_dirty_segment() calls and before IS_DATASEG() check:

	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));

	trace_f2fs_allocate_data_block(sbi, folio ? folio->mapping->host : NULL,
					type, *new_blkaddr);

	if (IS_DATASEG(curseg->seg_type))

1. Mount F2FS with active_logs=6 and age extent cache disabled:
   # mkfs.f2fs -f /dev/sdb1
   # mount -t f2fs -o active_logs=6 /dev/sdb1 /mnt/f2fs-test

2. Enable tracing and f2fs_allocate_data_block tracepoint:
   # echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_allocate_data_block/enable
   # echo 1 > /sys/kernel/debug/tracing/tracing_on
   # echo > /sys/kernel/debug/tracing/trace

3. Create a directory and write enough files to trigger dirty_pages >
   min_hot_blocks (default 16), which will clear FI_HOT_DATA flag:
   # mkdir /mnt/f2fs-test/testdir
   # cd /mnt/f2fs-test/testdir
   # seq 1 8192 | xargs touch
   # sync

4. Observe dentry block allocation:
   # cat /sys/kernel/debug/tracing/trace

   The trace output shows dentry blocks (is_dir = 1) allocated to WARM
   segment because FI_HOT_DATA is cleared when dirty_pages >
   min_hot_blocks (default 16). However, has_curseg_enough_space() only
   checked HOT_DATA segment space.

Fix by checking all three data segments (HOT, WARM, COLD) when
active_logs == 6, similar to how __get_segment_type_6() can return
any of these segment types for dentry blocks.

Fixes: ef095d19e82f ("f2fs: write small sized IO to hot log")
Cc: stable@kernel.org
Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
 fs/f2fs/segment.h | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 1ce2c8abaf48..c13400a53013 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -632,15 +632,34 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	}
 
 	/* check current data section for dentry blocks. */
-	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+	if (F2FS_OPTION(sbi).active_logs == 6) {
+		/*
+		 * With active_logs == 6, dentry blocks can be allocated to
+		 * HOT, WARM, or COLD segments based on age extent cache,
+		 * FI_HOT_DATA flag, rw_hint, etc. Check all three.
+		 */
+		for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+			segno = CURSEG_I(sbi, i)->segno;
+
+			if (unlikely(segno == NULL_SEGNO))
+				return false;
+
+			left_blocks = get_left_section_blocks(sbi, i, segno);
+
+			if (dent_blocks > left_blocks)
+				return false;
+		}
+	} else {
+		segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
 
-	if (unlikely(segno == NULL_SEGNO))
-		return false;
+		if (unlikely(segno == NULL_SEGNO))
+			return false;
 
-	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
+		left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
 
-	if (dent_blocks > left_blocks)
-		return false;
+		if (dent_blocks > left_blocks)
+			return false;
+	}
 	return true;
 }
 
-- 
2.43.0


