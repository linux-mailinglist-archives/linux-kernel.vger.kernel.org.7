Return-Path: <linux-kernel+bounces-735357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16308B08E34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F771AA7807
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF312E543F;
	Thu, 17 Jul 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsHcZe/x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2662E540D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758804; cv=none; b=hSWFO3KwPDNwfLwW4v1+7TCLEanFuDnIkoKTdBO6eLzwzRx6yQx6ac3PEQzYuAHrjOaHztO5qL9jZe3ny0OPMP89ZulPsfwgr4jIFZ6/y8nP3vFbZO0liwGIaHxx9U4fE4qKEhssvaDHQRnGgbrRiCQsZToc8dt1PNyZMsyUpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758804; c=relaxed/simple;
	bh=xwH9KsVkA9xR3sdKvSoirJ1o44ujVkiSADhgE4jH1cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfmqXl79IqugoveRDGXoPORVy6fV8UJziqUktcY1vdwm8SZMkGR/lacxkwT/N3m05iDOmwA2ENWU0aZFkqbQK33sr2+9nbB/FNZkdf6X+pPQqnWG54FWY4ibce8TW6XBMNc7W+s1iR2fnQy9bnkMeWc7qMgpzgXGf6rNQnz5VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsHcZe/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399EFC4CEEB;
	Thu, 17 Jul 2025 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758803;
	bh=xwH9KsVkA9xR3sdKvSoirJ1o44ujVkiSADhgE4jH1cA=;
	h=From:To:Cc:Subject:Date:From;
	b=BsHcZe/xmFtJQuC3is2g8dqOg6oTys7hTJb5VVqNhx3RFbWHKoK2innuiDnsyckwf
	 DDrmgyEUsk7BBD7FgAt1kRuChlk7vum/DUThYuL/eIrvqsn7Bp8dUgzribxQsa6Hpy
	 8BZy0LNHkLqfS5X8XpXjWN++Bd4Lg/EZanMzhBhyfyfFwY5g2AlgZn5h/S7Oo3lpr3
	 0D91bQvLqJLVrn6RFaLRodx8zszmUmrS0CPGTnhXFtmVzUiMtLfZrX8qZkz8UR6oT+
	 uYfCLkqefWza4fIe/XjR8BR69uci+KHsnjVMW0zhjFZwuJj9v+EyNQbGYjjIWX5pnZ
	 r4vU+RM9Y2p0A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jiaming Zhang <r772577952@gmail.com>
Subject: [PATCH] f2fs: fix to avoid out-of-boundary access in dnode page
Date: Thu, 17 Jul 2025 21:26:33 +0800
Message-ID: <20250717132633.1339965-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Jiaming Zhang reported:

 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x17e/0x800 mm/kasan/report.c:480
 kasan_report+0x147/0x180 mm/kasan/report.c:593
 data_blkaddr fs/f2fs/f2fs.h:3053 [inline]
 f2fs_data_blkaddr fs/f2fs/f2fs.h:3058 [inline]
 f2fs_get_dnode_of_data+0x1a09/0x1c40 fs/f2fs/node.c:855
 f2fs_reserve_block+0x53/0x310 fs/f2fs/data.c:1195
 prepare_write_begin fs/f2fs/data.c:3395 [inline]
 f2fs_write_begin+0xf39/0x2190 fs/f2fs/data.c:3594
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 f2fs_buffered_write_iter fs/f2fs/file.c:4988 [inline]
 f2fs_file_write_iter+0x1ec8/0x2410 fs/f2fs/file.c:5216
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x546/0xa90 fs/read_write.c:686
 ksys_write+0x149/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x3d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is in the corrupted image, there is a dnode has the same
node id w/ its inode, so during f2fs_get_dnode_of_data(), it tries to
access block address in dnode at offset 934, however it parses the dnode
as inode node, so that get_dnode_addr() returns 360, then it tries to
access page address from 360 + 934 * 4 = 4096 w/ 4 bytes.

To fix this issue, let's add sanity check for node id of all direct nodes
during f2fs_get_dnode_of_data().

Cc: stable@kernel.org
Reported-by: Jiaming Zhang <r772577952@gmail.com>
Closes: https://groups.google.com/g/syzkaller/c/-ZnaaOOfO3M
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 651537598759..12cab5c69fcd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -815,6 +815,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err_ratelimited(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
-- 
2.49.0


