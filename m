Return-Path: <linux-kernel+bounces-869922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1F3C09024
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E091C20797
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AFD2F83AC;
	Sat, 25 Oct 2025 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gQuJROW8"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62C81DE2A7
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395081; cv=none; b=lUa0yCYt2m/tzv0XTAeLaiSG3eBLBhnNNwEiE6ya7T6JMwTQO1eqY4gKwhocxcDvW2GprSGocGqmBA80SmorXoh2QjPYQCv0P/DVJpFhMjQlltluPI9zDbJfqWlcAakpvsXvFy/ETcA7W1UmWDs27IsJq0tCN+rTrZGmXRR9Xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395081; c=relaxed/simple;
	bh=2583AJYDJNkBUrFMwfw3UO/9QBRLf7JT7gJQRZKA7lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx5VPInIZo/6CJ3hOLS7x9LwhMA+0aUEztCNHq7K0NakzWPh3LXxuBmHp2WitSQAUwaS2FGxttIG0/j+3blNMQYZkg0EhqjI9u8/G+uNYU5U9rwzLrGJ2HGnlumzTL/3aKfNYDkNQj0wlft8u89bnvO1vlNiwmrRWZzBxRhJkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gQuJROW8; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761395070; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QBkOSh4GSFWfzEtwF628TabusJ5AWIKyvv1Mv/HXDb4=;
	b=gQuJROW8UCjql5Iaejtx75jDRtG0a0HCaX3+13GuIfGkM8ZEiPhMqpdf7VNIakbe7FYAVF27PEvO+avaSbCGxcLtqqDME/O3K8IZ8GYtwo0S8bFOkY12B2JuK+Y9D9ubcNZFiVAlpFjnYRG76fv6VgiEPfwl9RzHigtCaWbu9c0=
Received: from 30.41.143.132(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wqwtpv1_1761395069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 25 Oct 2025 20:24:30 +0800
Message-ID: <192fd326-2963-4839-8a4b-79abfc4ad3bd@linux.alibaba.com>
Date: Sat, 25 Oct 2025 20:24:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ocfs2: Invalidate inode if i_mode is zero after block
 read
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
References: <20251022222752.46758-2-eraykrdg1@gmail.com>
 <20251025111355.32045-2-eraykrdg1@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251025111355.32045-2-eraykrdg1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/25 19:13, Ahmet Eray Karadag wrote:
> A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
> handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.
> 
> This "zombie" inode is created because ocfs2_read_locked_inode proceeds
> even after ocfs2_validate_inode_block successfully validates a block
> that structurally looks okay (passes checksum, signature etc.) but
> contains semantically invalid data (specifically i_mode=0). The current
> validation function doesn't check for i_mode being zero.
> 
> This results in an in-memory inode with i_mode=0 being added to the VFS
> cache, which later triggers the panic during unlink.
> 
> Prevent this by adding an explicit check for i_mode == 0 within
> ocfs2_validate_inode_block. If i_mode is zero, return -EFSCORRUPTED to signal
> corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
> make_bad_inode(), correctly preventing the zombie inode from entering
> the cache.
> 
> ---
> [RFC]:
> The current fix handles i_mode=0 corruption detected during inode read
> by returning -EFSCORRUPTED from ocfs2_validate_inode_block, which leads to
> make_bad_inode() being called, preventing the corrupted inode from
> entering the cache. This approach avoids immediately forcing the entire
> filesystem read-only, assuming the corruption might be localized to
> this inode.
> 
> Is this less aggressive error handling strategy appropriate for i_mode=0
> corruption? Or is this condition considered severe enough that we *should*
> explicitly call ocfs2_error() within the validation function to guarantee
> the filesystem is marked read-only immediately upon detection?
> Feedback and testing on the correct severity assessment and error
> handling for this type of corruption would be appreciated.
> 
> Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
> v2:
>  - Reviewed how ext4 handling same situation and we come up with this
>    solution
> ---
> v3:
>  - Implement combined check for nlink=0, mode=0 and non-orphan
>    as requested.
> ---
>  fs/ocfs2/inode.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 14bf440ea4df..3feeaa475b62 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1455,7 +1455,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  		     (unsigned long long)bh->b_blocknr);
>  		goto bail;
>  	}
> -
> +	if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
> +		!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {

	    ^Better to align here.

> +			mlog(ML_ERROR, "Invalid dinode #%llu: "

One tab is engough.

Joseph
> +				"Corrupt state (nlink=0, mode=0, !orphan) detected!\n",
> +			        (unsigned long long)bh->b_blocknr);
> +			rc = -EFSCORRUPTED;
> +			goto bail;
> +	}
>  	/*
>  	 * Errors after here are fatal.
>  	 */


