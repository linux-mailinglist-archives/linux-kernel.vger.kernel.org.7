Return-Path: <linux-kernel+bounces-868456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE19C053BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38BB4E91D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D673081DA;
	Fri, 24 Oct 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SoDYFXHL"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383C302162
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296715; cv=none; b=a2TTNlbEBOk+/PmplCvHtnKnjjABALIQd6qqiYwjF6p3lUHjwDZKOb/0GGU6rsNTmZE4wojqhnUBB8VvPvbNHuWbngOjgIuhwt3qc0fxCNFv76r8Ga16fF5aIftqVHnH+qL99yXboJd3RQ8jNr9r+Kv08DpyJQkSKd7SWkE08p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296715; c=relaxed/simple;
	bh=ymO0o4Ev+efZ6uTLHPMrvkJMyI81gAD46z5c6c4pKOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4MJZOAuOGt0yR7pdLK8U/E3uk6PUYK2oY1JPqonOoNACqup/oYZryMH4T3dJnOSfHr0w7Rd/3nrBweIwBPcfCvwLX2B6kJnkg2TBv/A9X23s6SNx8nk+ji8HYzjRCZxGZcTV1z50y/dEAHFYr8sC0lUWwHn3+mTYVACbthiARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SoDYFXHL; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761296709; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vBS/sy8hIvdg6pdyqaf8XlsWh8LXpRJ1Obj39CR0eqg=;
	b=SoDYFXHLHvI6rDMVidBirls4NzkVbABTW0ECObmm4H7IrNswCE/1yl3roCRNNI6tJ5NFMY+AG0rfMeh7ipD7QHnd04I+f+cjIXwXDDN8A/sJqR7o7265ITlXxjnkD75b1y8b4YOO8lRZHJdEx1QjlTSZ135TS6UpGNl2igzu7jE=
Received: from 30.221.128.124(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Wqtt5Kc_1761296708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 17:05:09 +0800
Message-ID: <de0c14c4-5565-4366-a75a-f99d4380777c@linux.alibaba.com>
Date: Fri, 24 Oct 2025 17:05:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: Invalidate inode if i_mode is zero after block
 read
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
 Albin Babu Varghese <albinbabuvarghese20@gmail.com>
References: <20251022222752.46758-2-eraykrdg1@gmail.com>
 <20251024023056.29275-2-eraykrdg1@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20251024023056.29275-2-eraykrdg1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/24 10:30, Ahmet Eray Karadag wrote:
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
> ---
> v2:
>  - Reviewed how ext4 handling same situation and we come up with this
>    solution
> ---

The version change log should be after your SOB.

> Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
>  fs/ocfs2/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 14bf440ea4df..6c936f62b169 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1455,7 +1455,15 @@ int ocfs2_validate_inode_block(struct super_block *sb,
>  		     (unsigned long long)bh->b_blocknr);
>  		goto bail;
>  	}
> -
> +	if (di->i_links_count == 0) {
> +		if (le16_to_cpu(di->i_mode) == 0 ||
> +			!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {

Why not put those in a single check?
BTW, i_links_count is little endian and should convert to host endian first.
And we'd prefer the following alignment:

if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
    !(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL))
	......

Thanks,
Joseph


> +			mlog(ML_ERROR, "Invalid dinode #%llu: i_mode is zero!\n",
> +			           (unsigned long long)bh->b_blocknr);
> +			rc = -EFSCORRUPTED;
> +			goto bail;
> +		}
> +	}
>  	/*
>  	 * Errors after here are fatal.
>  	 */


