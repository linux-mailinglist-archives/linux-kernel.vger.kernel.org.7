Return-Path: <linux-kernel+bounces-776482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D37B2CDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A771BC2948
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DD27B325;
	Tue, 19 Aug 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipH53ll4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C320B80D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635450; cv=none; b=ozXkXXltu6+XLq+qZBYpVELo+DwLRM8w8GZymzzQCmdr07hu08xU2azjtc6X9SPzAJkxiFVPUR71u9vs+DNdzVIRG4XcOTrYm/QfcZe3+JKoeirfd0r8oseU6m4DXkHa+0P592gE5x2qmYNJpSJf8u6/lqJrWhGaemUvnC7pj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635450; c=relaxed/simple;
	bh=h1YbTQt6HVs1TaYX60E9hKi0mAlx5C9IOGf1jGLtX/0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY4KcRAu7nnJI8R5py3ElGYeEfvHy87kJVPOQk69nS91nw5UrpZqe+RlF1y1ofmowVL34lNQkCunDsnd/rFb3N8p9vT/C5v0QOxfZNgI5QFs8zIOExd47YgGpNnPttfvsizi8tOSg0Cogmec/5AScq+34fJ1MxFjSZJZVSY9CMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipH53ll4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58525C4CEF1;
	Tue, 19 Aug 2025 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755635449;
	bh=h1YbTQt6HVs1TaYX60E9hKi0mAlx5C9IOGf1jGLtX/0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ipH53ll4bEMEQKfg77op231qTnwVvsfuMiAuah0lWFe9zVrJihsOxx+rgkBX0lgiV
	 7vJ/zXzeaRVmbNo7LfI10tykZ6lHgYIUICVxffkUZS6N1Vs1nE9nwaQ8HzoXD0YIZT
	 iBeJjl8juCO/knIsui7x5JFPigIbPDecHbeWtXwwc4DnmVPUxB8TtmMWb+st4Th1wy
	 +Nu3AadxbXX7os0evHLxC8PTHexlfq1qMpn7j7XSBu0qqCKpqleQQghC/aCTCXrZ6p
	 uqzuAMFh/1uttZK1hF0f8tRABcm04yaI0TA7ZYNd/Mpqed9ChBRek08/tR7vZTimwj
	 c6IjUtxzYFqjQ==
Date: Tue, 19 Aug 2025 20:30:47 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: show the list of donation files
Message-ID: <aKTe9xi8rv1VUSIj@google.com>
References: <20250812235814.960924-1-jaegeuk@kernel.org>
 <aJy8KS3fLQ452d2r@google.com>
 <aJ9eTaqNwkQZtA8E@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9eTaqNwkQZtA8E@google.com>

This patch introduces a proc entry to show the currently enrolled donation
files.

- "File path" indicates a file.
- "Status"
 a. "Donated" means the file is registed in the donation list by
    fadvise(offset, length, POSIX_FADV_NOREUSE)
 b. "Evicted" means the donated pages were reclaimed.
- "Offset (kb)" and "Length (kb) show the registered donation range.
- "Cached pages (kb)" shows the amount of cached pages in the inode page cache.

For example,

 # of files  : 2
 File path                                              Status Donation offset (kb)   Donation size (kb)  File cached size (kb)
---
 /local/test2                                          Donated                    0              1048576                2097152
 /local/test                                           Evicted                    0              1048576                1048576

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 v4:
  - change the entry names clearly

 fs/f2fs/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 1ffaf9e74ce9..86ebe97c256d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1769,6 +1769,68 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused donation_list_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct inode *inode;
+	struct f2fs_inode_info *fi;
+	struct dentry *dentry;
+	char *buf, *path;
+	int i;
+
+	buf = f2fs_getname(sbi);
+	if (!buf)
+		return 0;
+
+	seq_printf(seq, "Donation List\n");
+	seq_printf(seq, " # of files  : %u\n", sbi->donate_files);
+	seq_printf(seq, " %-50s %10s %20s %20s %22s\n",
+			"File path", "Status", "Donation offset (kb)",
+			"Donation size (kb)", "File cached size (kb)");
+	seq_printf(seq, "---\n");
+
+	for (i = 0; i < sbi->donate_files; i++) {
+		spin_lock(&sbi->inode_lock[DONATE_INODE]);
+		if (list_empty(&sbi->inode_list[DONATE_INODE])) {
+			spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+			break;
+		}
+		fi = list_first_entry(&sbi->inode_list[DONATE_INODE],
+					struct f2fs_inode_info, gdonate_list);
+		list_move_tail(&fi->gdonate_list, &sbi->inode_list[DONATE_INODE]);
+		inode = igrab(&fi->vfs_inode);
+		spin_unlock(&sbi->inode_lock[DONATE_INODE]);
+
+		if (!inode)
+			continue;
+
+		inode_lock_shared(inode);
+
+		dentry = d_find_alias(inode);
+		if (!dentry) {
+			path = NULL;
+		} else {
+			path = dentry_path_raw(dentry, buf, PATH_MAX);
+			if (IS_ERR(path))
+				goto next;
+		}
+		seq_printf(seq, " %-50s %10s %20llu %20llu %22llu\n",
+				path ? path : "<unlinked>",
+				is_inode_flag_set(inode, FI_DONATE_FINISHED) ?
+				"Evicted" : "Donated",
+				(loff_t)fi->donate_start << (PAGE_SHIFT - 10),
+				(loff_t)(fi->donate_end + 1) << (PAGE_SHIFT - 10),
+				(loff_t)inode->i_mapping->nrpages << (PAGE_SHIFT - 10));
+next:
+		inode_unlock_shared(inode);
+		iput(inode);
+	}
+	f2fs_putname(buf);
+	return 0;
+}
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 static int __maybe_unused inject_stats_seq_show(struct seq_file *seq,
 						void *offset)
@@ -1878,6 +1940,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				discard_plist_seq_show, sb);
 	proc_create_single_data("disk_map", 0444, sbi->s_proc,
 				disk_map_seq_show, sb);
+	proc_create_single_data("donation_list", 0444, sbi->s_proc,
+				donation_list_seq_show, sb);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	proc_create_single_data("inject_stats", 0444, sbi->s_proc,
 				inject_stats_seq_show, sb);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


