Return-Path: <linux-kernel+bounces-767816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DEB25978
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7E3BE8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1D1255F52;
	Thu, 14 Aug 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTb3lHnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809315C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138165; cv=none; b=nmFDhdL5zRlKWlnbSfHDZ0dLF2jMV2B+A8GA/DdhxQAAasR4s6y9UfyPMIFHLXONkjHA55+lzBARBtSkEPPRy1X1kesoWIxYFT8ePgnfF0SOQnqy/ooKczAk4eonK0Q1zju9AycVFjM4iH3lZDGKhuKV1fBtP14FBEje9Cm8n9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138165; c=relaxed/simple;
	bh=34ypJRRpRao6a54n/Veipk1DcAh+opWEwlZ2ccnwB08=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M0wG//IGwz4LFlw4IMc0rU/qGbaVI2dwVGdrHc6ZEts9h5OYZ3/DYjJ7eDvenF80yEvB9L5vKyJXYIz1p8xb+AJ+8jr8reVPcDL+9e8qvTMaxGuVg0dfyqUpLUrC62lH8gy0x8M0Utkc9i/PLu5fcuRXzVLxpDuuwgv8YuOeD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTb3lHnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A22C4CEEB;
	Thu, 14 Aug 2025 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755138164;
	bh=34ypJRRpRao6a54n/Veipk1DcAh+opWEwlZ2ccnwB08=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cTb3lHnX4tO8kB9f2UhEvrlUpG0kyT0CGAWQI8GOOpAS1/BNOiR4vH4m4PG7Nshg6
	 LbpgUtoG3wmbG44k0G7yUYxEdURMpMf4+tWf/mYzB4eOTsfTetNmlB8dekKhY9l21U
	 PPpUUoAOUXCG4fGMgiQFqwV7EKZPNND/hNh1ePOvQOE5fHxRiunn5K49Ise7kICXKJ
	 lQyVc2R+7SgabJaYN3TA+q6UDfjb9NbbDEoycBTZAAZh5sZvJn5nA/OmuhkjdaPBMW
	 J3nCLo9JC7Sg2v3zAnk7+HKWbFbQa9eHJDkw19FGDZiEnx0F+fur19xnv/M+A5fdxb
	 54fqJtUcRY5hQ==
Message-ID: <c7b8c81e-c0fe-4edf-8ad0-e10df5d80bd5@kernel.org>
Date: Thu, 14 Aug 2025 10:22:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: show the list of donation files
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250812235814.960924-1-jaegeuk@kernel.org>
 <aJy8KS3fLQ452d2r@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJy8KS3fLQ452d2r@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 00:24, Jaegeuk Kim via Linux-f2fs-devel wrote:
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
>  v2: use inode_lock|unlock_shared
>  
>  fs/f2fs/sysfs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 1ffaf9e74ce9..9f90d1878ec6 100644
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
> +		inode_lock_shared(inode);
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

It needs to avoid overflow while left shift?

(loff_t)fi->donate_start << (PAGE_SHIFT - 10)
(loff_t)(fi->donate_end + 1) << (PAGE_SHIFT - 10)
(loff_t)inode->i_mapping->nrpages << (PAGE_SHIFT - 10))

Thanks,

> +				(fi->donate_end + 1) << (PAGE_SHIFT - 10),
> +				inode->i_mapping->nrpages << (PAGE_SHIFT - 10));
> +next:
> +		inode_unlock_shared(inode);
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


