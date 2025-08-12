Return-Path: <linux-kernel+bounces-765692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB102B23CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9F5A06DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAE2E92AA;
	Tue, 12 Aug 2025 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV92m+vB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D32EA167
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043099; cv=none; b=BufdLj1d6d+Mf6E54qDyWdiEH9BfRttLTdEL5b+tz6TFWQtROSVbpTuIrrDLK8DkExfJ/gzzN9CcmAcHwU84YiKSbTLy2jsOVmXMsgk4IzuFeMoUw/2DEq5/4Ifx+29tUMIYAVMuJtoisj/zYt+DQrfytvy7u4V0TbAAeT6Dudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043099; c=relaxed/simple;
	bh=ReDrEs2QM9oVpwT4Ru+LnnZtyb0Z4Ptf81izg5DGuRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRjOLgU7QT5rsbfonRG1tXtqhTdkvIVRpye+lv54pfZUH/3F/MwIbC9eJ4bM9EJoff5pobPukaggKyNddnM8Su2j2+epjFf7ILI3UPEKSEguQgB9jLPLgCbRoXLF5CnBpXM35FvX6VGARcgLwJ9v5PeJkwwSVYdJuSY2VCA2R9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV92m+vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667E6C4CEF0;
	Tue, 12 Aug 2025 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755043099;
	bh=ReDrEs2QM9oVpwT4Ru+LnnZtyb0Z4Ptf81izg5DGuRY=;
	h=From:To:Cc:Subject:Date:From;
	b=pV92m+vBu4kzIOVpP84WGa0oclITdbAC+ipi4TGoQUOmbDmabbdhwnZSmvJ7CO3Zw
	 xeSf17QC/poNSvKv1MZmKFhZ6K8wIOBRXeeklSxt0dukgETcCZnE8PSZoyEEw8rXa2
	 5E9EYvpvten4nYWEJYk9b+sfm+F/soID+DA9A6iOxMZ9/8iaRClckAk21WH8BIV2TE
	 wnznxjJnqC6h0jA6q3cF6BJfmK++jbtBDf7i/jN7kOyweM5eDXghkBtsvv8U6Gu28U
	 rIHHDWha1nEfCd0SAu1ONV06cK9wBsJUSrh/Qg/3CDb/lUyM2LCAbZWw7+rksgp/fi
	 ebf4iMA57qzdA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: show the list of donation files
Date: Tue, 12 Aug 2025 23:58:14 +0000
Message-ID: <20250812235814.960924-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Donation List
 # of files  : 2
 File path                                              Status     Offset (kb)     Length (kb)    Cached pages (kb)
---
 /local/tmp/test2                                      Donated               0         1048576              2097152
 /local/tmp/test                                       Evicted               0         1048576              1048576

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 1ffaf9e74ce9..2de7557bfebf 100644
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
+	seq_printf(seq, " %-50s %10s %15s %15s %20s\n",
+			"File path", "Status", "Offset (kb)",
+			"Length (kb)", "Cached pages (kb)");
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
+		inode_lock(inode);
+
+		dentry = d_find_alias(inode);
+		if (!dentry) {
+			path = NULL;
+		} else {
+			path = dentry_path_raw(dentry, buf, PATH_MAX);
+			if (IS_ERR(path))
+				goto next;
+		}
+		seq_printf(seq, " %-50s %10s %15lu %15lu %20lu\n",
+				path ? path : "<unlinked>",
+				is_inode_flag_set(inode, FI_DONATE_FINISHED) ?
+				"Evicted" : "Donated",
+				fi->donate_start << (PAGE_SHIFT - 10),
+				(fi->donate_end + 1) << (PAGE_SHIFT - 10),
+				inode->i_mapping->nrpages << (PAGE_SHIFT - 10));
+next:
+		inode_unlock(inode);
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
2.51.0.rc1.163.g2494970778-goog


