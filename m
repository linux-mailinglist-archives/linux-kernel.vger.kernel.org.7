Return-Path: <linux-kernel+bounces-771167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D0B283B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C7CAE4C65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B83019C5;
	Fri, 15 Aug 2025 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOEkffsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3E1EE7DC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274832; cv=none; b=Ywo90lfzuN2wDQmWoXobM6VmQ6AJQaLY1BjrJvEcw6G178ij0Lp8huSIh9TZmueMq1b1asnTzXB/j95W2BjLA75I4jbLJL+wJlevoEPKlG8gy0TVgCVmIlqzgQ1+vobZ8UonuP31nCowR72z5C6BUijqpDRe380A5m37gDDxr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274832; c=relaxed/simple;
	bh=LiYEkGe4+vvYPDOoShkAaz5e8Puzmaj0zK3r3FwaX08=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqh7Z+c1LgigAEjwLbU1nE1Xa9nGNBgAVC0eZhD9GmBuWxP2uGI6kc9vjsaFnh7juOc8yuhodKIwwXCDG16tCG0IGZAI9NprndchDluWehvZO8f7lQz8+xp0qjLEeGTXsQdNZMat7p65SwLYkpan1xdowIPH7dpLpE0gbJ2O4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOEkffsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934CAC4CEEB;
	Fri, 15 Aug 2025 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755274831;
	bh=LiYEkGe4+vvYPDOoShkAaz5e8Puzmaj0zK3r3FwaX08=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=JOEkffsNYbw9wt45dnlbQnrTH4QXworbfNo7bhVRiOkP8BzbMfFBqRw81ApCIbWE9
	 HvUfJU53KhVz0nIhe1PRmf5NbBTXuA2F1EHz3A+VEHYr99NPYjvoVWdhvLja2SE2rm
	 GiR3xoY5y0bO8T0ICkz9fEVaD7o++QzRj/iIB9OY5daxn+nJvHfzetur3P8nUuDb2f
	 tROUIhKpYgiXyJRKSRPCebrKJ4oKvjDvZXVB3uJzE1/AG0oK+Kyc3T6zCWPbMyuKGg
	 yeM9OB7MZ+LkJqWi5CqsV2OaZTcboVMAoGMxNcqD7B8GOnykg56uQopapPi4tXQ6dK
	 Yz5Z3dV3TlVuQ==
Date: Fri, 15 Aug 2025 16:20:29 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: show the list of donation files
Message-ID: <aJ9eTaqNwkQZtA8E@google.com>
References: <20250812235814.960924-1-jaegeuk@kernel.org>
 <aJy8KS3fLQ452d2r@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJy8KS3fLQ452d2r@google.com>

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

 v3 - use loff_t

 fs/f2fs/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 1ffaf9e74ce9..5d0f7364dbb8 100644
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
+		seq_printf(seq, " %-50s %10s %15llu %15llu %20llu\n",
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
2.51.0.rc1.163.g2494970778-goog


