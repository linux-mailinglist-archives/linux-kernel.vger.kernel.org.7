Return-Path: <linux-kernel+bounces-720711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF67AFBF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACEB4A1CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295281D90AD;
	Tue,  8 Jul 2025 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eZD4+EdT"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D615C15F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751936180; cv=none; b=m6NQVBAXF1/trKAheNRCxk2LZjeyaOjus5K4Ib/UW925lyc+R0sZdMmqIqpGqvkafDAa8sgyObAOzW5NUNTyuw++zHMLJSI2gGk7iy2jwpeLAD5ok/4L3qzXPhc9iT5VwSF7oS4SqpC4LgQcmXwxWD1aoCwpDrznwBl1ZZU0bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751936180; c=relaxed/simple;
	bh=gKzYZKEM18iJ8wliO5ywfTKA/wRjzfDEXO1rWz0ze/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNnlH9tkZ1IAvpFAyRtohiyNwU4FyU+91UfIvfsQytu+WLS7tWuQMRxT0dGhHYJ5YpcPkF9FZIDAAg6y/ddmur6DDrWW7H34RZwBC9KUNWMHLyMNwuWrE+MXXAFcrY000ZiJ0LbsbvEp31V8kMXwRYGY++JxGNON61L0cgxdnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eZD4+EdT; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751936169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tQWA0OJ15gb+o59aK8rJt+7RU1yraqUvbj8vhnlJAq4=;
	b=eZD4+EdT/tGpU0AzCRLKV5mCB9bLQA+COgKkYkVz1j0IpjqgFdPMn57eyZ11BHRcqO4fQb4GkIQIyN61boHBlUwRCXEqqrl/2mRs5QFLlnGUVWKvHnMTlGm8i3z0azvgJMryOVDXkmg/XOVXlg+csEhM2TKWDLz5AZ681daPVP0=
Received: from 30.221.128.116(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WiI9BZO_1751936168 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 08:56:08 +0800
Message-ID: <44eb7510-2096-416d-b1b8-cbdc62313502@linux.alibaba.com>
Date: Tue, 8 Jul 2025 08:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ocfs2: avoid potential ABBA deadlock by reordering
 tl_inode lock
To: Ivan Pravdin <ipravdin.official@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
References: <20250708003519.379597-1-ipravdin.official@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250708003519.379597-1-ipravdin.official@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/8 08:35, Ivan Pravdin wrote:
> In ocfs2_move_extent(), tl_inode is currently locked after the global
> bitmap inode. However, in ocfs2_flush_truncate_log(), the lock order
> is reversed: tl_inode is locked first, followed by the global bitmap
> inode.
> 
> This creates a classic ABBA deadlock scenario if two threads attempt
> these operations concurrently and acquire the locks in different orders.
> 
> To prevent this, move the tl_inode locking earlier in
> ocfs2_move_extent(), so that it always precedes the global bitmap
> inode lock.
> 
> No functional changes beyond lock ordering.
> 
> Reported-by: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67d5645c.050a0220.1dc86f.0004.GAE@google.com/
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> ---
> v1 -> v2: Fixed unlocking order in ocfs2_move_extent.
> v2 -> v3: Added missing out_unlock_tl_inode and renamed out_unlock_gb_mutex to
> 		  out_unlock_gb_inode and out_unlock_gb_inode to out_unlock.
> 
>  fs/ocfs2/move_extents.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 369c7d27befd..9d1fa8ecd97e 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -617,6 +617,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	 */
>  	credits += OCFS2_INODE_UPDATE_CREDITS + 1;
>  
> +	inode_lock(tl_inode);
> +
>  	/*
>  	 * ocfs2_move_extent() didn't reserve any clusters in lock_allocators()
>  	 * logic, while we still need to lock the global_bitmap.
> @@ -626,7 +628,7 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	if (!gb_inode) {
>  		mlog(ML_ERROR, "unable to get global_bitmap inode\n");
>  		ret = -EIO;
> -		goto out;
> +		goto out_unlock_tl_inode;
>  	}
>  
>  	inode_lock(gb_inode);
> @@ -634,16 +636,14 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  	ret = ocfs2_inode_lock(gb_inode, &gb_bh, 1);
>  	if (ret) {
>  		mlog_errno(ret);
> -		goto out_unlock_gb_mutex;
> +		goto out_unlock_gb_inode;
>  	}
>  
> -	inode_lock(tl_inode);
> -
>  	handle = ocfs2_start_trans(osb, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		mlog_errno(ret);
> -		goto out_unlock_tl_inode;
> +		goto out_unlock;
>  	}
>  
>  	new_phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *new_phys_cpos);
> @@ -703,13 +703,12 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  out_commit:
>  	ocfs2_commit_trans(osb, handle);
>  	brelse(gd_bh);
> -
> -out_unlock_tl_inode:
> -	inode_unlock(tl_inode);
> -
> +out_unlock:
>  	ocfs2_inode_unlock(gb_inode, 1);
> -out_unlock_gb_mutex:
> +out_unlock_gb_inode:
>  	inode_unlock(gb_inode);
> +out_unlock_tl_inode:
> +	inode_unlock(tl_inode);

Ummm... I'd rather keep gb_inode cleanup together.

Thanks,
Joseph

>  	brelse(gb_bh);
>  	iput(gb_inode);
>  


