Return-Path: <linux-kernel+bounces-793661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1814DB3D685
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6431790F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853251F4C87;
	Mon,  1 Sep 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6r5rwrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37E4594A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692260; cv=none; b=ST3c76Dlv9yuQG+VCPXgmxvbxOOV9oluu/2nEzWoJIRZdAtrqac4CEHAD8qAFAFIPnSUHoXQ/74GwqFIUS9CbmUhOCaxuTFbzgTLSkJj4hw0rXELRBS6vGUok/6fPcM7ycshKVrRSpDHp9jIuME9MULwwb/hwvxxjw+39o67nQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692260; c=relaxed/simple;
	bh=ausF7AVg0t1Vf+HSZjrDosL4uEuyprEfDFeCeFJ4G2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZ2R4aAOCl9PBmLfWElF65i440RsdawMqPNSnbwZkTk8EePiNbNUROijKn3EbpSHTJC3XnhVlHpsuXuWxgfr2geUNiJ1uBeHWUb5zGSFiPC7s49FzkYGhbzQ9MmfgqRxO9O0EVz83PBXnMhy8WJjau1vx/ZtVhvlHlDwnJNmumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6r5rwrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE3C4CEED;
	Mon,  1 Sep 2025 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756692260;
	bh=ausF7AVg0t1Vf+HSZjrDosL4uEuyprEfDFeCeFJ4G2o=;
	h=From:To:Cc:Subject:Date:From;
	b=g6r5rwrVnOoPscDz45G0jlVqx6GCrUkDBXO3/9amBMoMwmLhLRLc3DMcNTXlASmV6
	 t5Riq2j3Km5b2zf65klx7F+5AXLZZAKtrC0VMM5D3tKMhfWLjz4X3bpw0+gXBcO4ui
	 jf+yzHWPK1Cv89sIrcL8Wcn9OGq3l9RXwLXNWII2UYeBdPnNOKnPFZQajJ62iLxcOE
	 +TtkgL3asfD6p4zysQPjKp8bMAwxxy7SXFM+Qd7v8URKga1v+M78Z/7U4sL3+Iukf8
	 88+ZQ122u9Nqvu/YYgDKy5sSgE0sCb/Qg9tEJa8JjXtC5Zc+ZhI0Mvo38HpC2IQQZE
	 Ogeb1NynZDlsg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix to avoid migrating empty section
Date: Mon,  1 Sep 2025 10:04:15 +0800
Message-ID: <20250901020416.2172182-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It reports a bug from device w/ zufs:

F2FS-fs (dm-64): Inconsistent segment (173822) type [1, 0] in SSA and SIT
F2FS-fs (dm-64): Stopped filesystem due to reason: 4

Thread A				Thread B
- f2fs_expand_inode_data
 - f2fs_allocate_pinning_section
  - f2fs_gc_range
   - do_garbage_collect w/ segno #x
					- writepage
					 - f2fs_allocate_data_block
					  - new_curseg
					   - allocate segno #x

The root cause is: fallocate on pinning file may race w/ block allocation
as above, result in do_garbage_collect() from fallocate() may migrate
segment which is just allocated by a log, the log will update segment type
in its in-memory structure, however GC will get segment type from on-disk
SSA block, once segment type changes by log, we can detect such
inconsistency, then shutdown filesystem.

In this case, on-disk SSA shows type of segno #173822 is 1 (SUM_TYPE_NODE),
however segno #173822 was just allocated as data type segment, so in-memory
SIT shows type of segno #173822 is 0 (SUM_TYPE_DATA).

Change as below to fix this issue:
- check whether current section is empty before gc
- add sanity checks on do_garbage_collect() to avoid any race case, result
in migrating segment used by log.
- btw, it fixes misc issue in printed logs: "SSA and SIT" -> "SIT and SSA".

Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ed3acbfc83ca..a7708cf80c04 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1794,6 +1794,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
 					GET_SUM_BLOCK(sbi, segno));
 
+		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
+			f2fs_err(sbi, "%s: segment %u is used by log",
+							__func__, segno);
+			f2fs_bug_on(sbi, 1);
+			goto skip;
+		}
+
 		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto freed;
 		if (gc_type == BG_GC && __is_large_section(sbi) &&
@@ -1805,7 +1812,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		sum = folio_address(sum_folio);
 		if (type != GET_SUM_TYPE((&sum->footer))) {
-			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
+			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SIT and SSA",
 				 segno, type, GET_SUM_TYPE((&sum->footer)));
 			f2fs_stop_checkpoint(sbi, false,
 				STOP_CP_REASON_CORRUPTED_SUMMARY);
@@ -2068,6 +2075,13 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
+		/*
+		 * avoid migrating empty section, as it can be allocated by
+		 * log in parallel.
+		 */
+		if (!get_valid_blocks(sbi, segno, true))
+			continue;
+
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
 			continue;
 
-- 
2.49.0


