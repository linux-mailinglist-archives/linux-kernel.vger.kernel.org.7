Return-Path: <linux-kernel+bounces-894708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C4C4BA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF77834EAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634E42D1F4E;
	Tue, 11 Nov 2025 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DIVrFzWA"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA092D193F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842090; cv=none; b=Uyoiz6A3Eg+4kx2sWUS7lxYy9u7CSfCB4Ggiz3m9Vgicvjrl26HTh0PLVV/R901P04tbfYcGlmqFuNv4aVswjyEBhnGvbMH1Tp17mgGhkgrb9B5tp+oaJvfKpzepbxbvWT7ZHygDADMNJUGrm1dcmSKvx2e3UVFipBOd3wiLzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842090; c=relaxed/simple;
	bh=KC7nOZAlIg2S+t5k+Iegh6RsFAGS8zFqkBIlUlW2mxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKYLPWIDCuH5szwug/cT6WFXRfM5E76a97TBhL5NbIshCcIcC/pzxoTFWhsiVIjwi+UzSJ8fjl5ZGPCw+qzF2XsJA0Kwv6jTQLiBT4QnG0GZHp+Lz1AqlEZCnfwtHui2EJwgm7t6nw9DVsP23rN/j+lxyrFHqyghTyrRUdc5FiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DIVrFzWA; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SQ
	NThmc7X74qfNRIdMXWU8JaAm5dM9fXnQhj2wzlK1Y=; b=DIVrFzWA4nnWn24ZRo
	XE9IO6g1j6WAITBYeFqd5axL2WLAa/D8lPGwmyrzt6pr/X6YXSF6ekI9gd1BbW8S
	7bm9GpsUw/0YKWjTNmTODepdBD5vSftg1SIjNDaHs74tF6WPID4yUSL2U641Sl8K
	IGUiVDA7sjMkg0F8g1MMJGLqk=
Received: from hpz640.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3DsRu0xJpNZcpAw--.15039S2;
	Tue, 11 Nov 2025 14:10:55 +0800 (CST)
From: Xiaole He <hexiaole1994@126.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaole He <hexiaole1994@126.com>,
	stable@kernel.org
Subject: [PATCH v2] f2fs: fix has_curseg_enough_space to check all data segments for dentry blocks
Date: Tue, 11 Nov 2025 14:10:51 +0800
Message-ID: <20251111061051.337547-1-hexiaole1994@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111060557.337514-1-hexiaole1994@126.com>
References: <20251111060557.337514-1-hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3DsRu0xJpNZcpAw--.15039S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar15KFy5CFy7urWkurWxJFb_yoW7GF1xpF
	47CFy3Krs5ur18Was2q3WUG3WS93yUur4UJr1jgw1vyrWfWF1Ikwn7ta45XF1vkrs3XFn7
	ZasIkry5A3WDuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR6Vb9UUUUU=
X-CM-SenderInfo: 5kh0xt5rohimizu6ij2wof0z/1tbiegIDBmkS0LpJvQAAsY

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

Fix by merging the dentry block check into the main data/node block
check loop and checking data_blocks + dent_blocks for data segments,
since both regular data blocks and dentry blocks can be written to the
same segment. When active_logs == 6, dentry blocks can be allocated to
any of the three data segments (HOT, WARM, COLD), so all three segments
need to account for dentry blocks. When active_logs != 6, dentry blocks
are always allocated to HOT_DATA segment only, so only HOT_DATA segment
needs to account for dentry blocks, while WARM and COLD segments only
check data_blocks.

Fixes: ef095d19e82f ("f2fs: write small sized IO to hot log")
Cc: stable@kernel.org
Signed-off-by: Xiaole He <hexiaole1994@126.com>
---
Changes in v2 (per Yongpeng's feedback):
- Merged dentry block check into the main loop to avoid duplication
- Check data_blocks + dent_blocks for data segments (both can write to same segment)
---
 fs/f2fs/segment.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 1ce2c8abaf48..acda720a54eb 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -626,21 +626,21 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 
 		left_blocks = get_left_section_blocks(sbi, i, segno);
 
-		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
+		if (i <= CURSEG_COLD_DATA) {
+			blocks = data_blocks;
+			/*
+			 * With active_logs == 6, dentry blocks can be allocated to
+			 * any data segment. With active_logs != 6, dentry blocks
+			 * are always allocated to HOT_DATA segment.
+			 */
+			if ((F2FS_OPTION(sbi).active_logs == 6) || (i == CURSEG_HOT_DATA))
+				blocks += dent_blocks;
+		} else {
+			blocks = node_blocks;
+		}
 		if (blocks > left_blocks)
 			return false;
 	}
-
-	/* check current data section for dentry blocks. */
-	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-
-	if (unlikely(segno == NULL_SEGNO))
-		return false;
-
-	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
-
-	if (dent_blocks > left_blocks)
-		return false;
 	return true;
 }
 
-- 
2.43.0


