Return-Path: <linux-kernel+bounces-765778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E2B23E27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1527B4E1552
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481F1DD0C7;
	Wed, 13 Aug 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiBfmS7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133EBE65
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051657; cv=none; b=N4J/64w65LjD9unIi38eEpa4XEEXyUZnQ+2HOMxTgbdLn2yhsQRE77GeNUIoLW+GjR+P0IGl1d0B8eOshNdsIjLQ3djIXcHjqhLwmMFgpmJweKHfQRpWwPqN9Olv7DDlFBGBQ7ySD5TQYLvUbESHruQ5PgOBFrU535I1Kpy1F7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051657; c=relaxed/simple;
	bh=e02xSPTv4pzn8b5aJnjvESHgTs885TC3nvIQauqARPw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bRwgnW6m9Mnr1VHnn7/vyrBGbqNmdROQ8laldccJRSE+oHw+Xnhb49cLwin6moic1ZQXPDdLSALfeC8U7GQ151ub1T3cgI2xRyFc3hD/PDPDqaF7kKkV9AW5zf6SxMSucHOVhA8x7aPAKK1Fr7ICuORivgcXqAS03xXRL1sP7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiBfmS7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F290C4CEF0;
	Wed, 13 Aug 2025 02:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755051656;
	bh=e02xSPTv4pzn8b5aJnjvESHgTs885TC3nvIQauqARPw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RiBfmS7SbOgiNBwLpJ319zj/MwOHKjq1mqQixvxLbyJM24ePgxkMFQ8s8M7lIpOPS
	 o4EeC9Opg0Q9B6PygpJ7Qco61XAC4Qm4KJ1Ky+uKsd6mqcDpdooY8N4+PsYryQp0yv
	 MkpCTKrl87nGmtGX3LV/+xtSWu+2f1XSI2mM4Q5JUSeZUw3/aFfQWUzBuLjSmOB/No
	 VoXmcR8manIOW4V+0aIuMCMEHWPcWEWnwWvynJNOEbkN4PReVV71NzgDIEPo1mZ1LT
	 M2bg56k1xe9zwo0wXeQuQU4VwyELsyk/tLkSdizIi7Na+yX51YKv2B8Ja/+aCpGC5s
	 K39Zoyl02o87Q==
Message-ID: <8ac33b02-b5ea-4c58-8e60-5411bf0ae62c@kernel.org>
Date: Wed, 13 Aug 2025 10:20:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: show the list of donation files
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250812235814.960924-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250812235814.960924-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 07:58, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch introduces a proc entry to show the currently enrolled donation
> files.
> 
> - "File path" indicates a file.
> - "Status"
>  a. "Donated" means the file is registed in the donation list by
>     fadvise(offset, length, POSIX_FADV_NOREUSE)
>  b. "Evicted" means the donated pages were reclaimed.
> - "Offset (kb)" and "Length (kb) show the registered donation range.
> - "Cached pages (kb)" shows the amount of cached pages in the inode page cache.
> 
> For example,
> 
> Donation List
>  # of files  : 2
>  File path                                              Status     Offset (kb)     Length (kb)    Cached pages (kb)
> ---
>  /local/tmp/test2                                      Donated               0         1048576              2097152
>  /local/tmp/test                                       Evicted               0         1048576              1048576
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 1ffaf9e74ce9..2de7557bfebf 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1769,6 +1769,68 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
>  	return 0;
>  }
>  
> +static int __maybe_unused donation_list_seq_show(struct seq_file *seq,
> +						void *offset)
> +{
> +	struct super_block *sb = seq->private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	struct inode *inode;
> +	struct f2fs_inode_info *fi;
> +	struct dentry *dentry;
> +	char *buf, *path;
> +	int i;
> +
> +	buf = f2fs_getname(sbi);
> +	if (!buf)
> +		return 0;
> +
> +	seq_printf(seq, "Donation List\n");
> +	seq_printf(seq, " # of files  : %u\n", sbi->donate_files);
> +	seq_printf(seq, " %-50s %10s %15s %15s %20s\n",
> +			"File path", "Status", "Offset (kb)",
> +			"Length (kb)", "Cached pages (kb)");
> +	seq_printf(seq, "---\n");
> +
> +	for (i = 0; i < sbi->donate_files; i++) {
> +		spin_lock(&sbi->inode_lock[DONATE_INODE]);
> +		if (list_empty(&sbi->inode_list[DONATE_INODE])) {
> +			spin_unlock(&sbi->inode_lock[DONATE_INODE]);
> +			break;
> +		}
> +		fi = list_first_entry(&sbi->inode_list[DONATE_INODE],
> +					struct f2fs_inode_info, gdonate_list);
> +		list_move_tail(&fi->gdonate_list, &sbi->inode_list[DONATE_INODE]);
> +		inode = igrab(&fi->vfs_inode);
> +		spin_unlock(&sbi->inode_lock[DONATE_INODE]);
> +
> +		if (!inode)
> +			continue;
> +
> +		inode_lock(inode);

The following flow doesn't update any fields in inode structure, so what about
using inode_lock_shared() instead?

Thanks,

> +
> +		dentry = d_find_alias(inode);
> +		if (!dentry) {
> +			path = NULL;
> +		} else {
> +			path = dentry_path_raw(dentry, buf, PATH_MAX);
> +			if (IS_ERR(path))
> +				goto next;
> +		}
> +		seq_printf(seq, " %-50s %10s %15lu %15lu %20lu\n",
> +				path ? path : "<unlinked>",
> +				is_inode_flag_set(inode, FI_DONATE_FINISHED) ?
> +				"Evicted" : "Donated",
> +				fi->donate_start << (PAGE_SHIFT - 10),
> +				(fi->donate_end + 1) << (PAGE_SHIFT - 10),
> +				inode->i_mapping->nrpages << (PAGE_SHIFT - 10));
> +next:
> +		inode_unlock(inode);
> +		iput(inode);
> +	}
> +	f2fs_putname(buf);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  static int __maybe_unused inject_stats_seq_show(struct seq_file *seq,
>  						void *offset)
> @@ -1878,6 +1940,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>  				discard_plist_seq_show, sb);
>  	proc_create_single_data("disk_map", 0444, sbi->s_proc,
>  				disk_map_seq_show, sb);
> +	proc_create_single_data("donation_list", 0444, sbi->s_proc,
> +				donation_list_seq_show, sb);
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	proc_create_single_data("inject_stats", 0444, sbi->s_proc,
>  				inject_stats_seq_show, sb);


