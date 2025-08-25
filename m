Return-Path: <linux-kernel+bounces-783888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B5B333E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A8B17D61A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BFE212D7C;
	Mon, 25 Aug 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ospu5ZmW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87EB2AE90
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088210; cv=none; b=cEj6SgOySyrmYfHxPne5nUs9mz7ee09jRZ3ylVx56Cukfo64zg4ngFsvVqomUze/fEpWa+SOLb3QVUkV7lkTQWlSPA65ymyukaX7M19PDq96K7NfTJtGT/VPuXiYyF55lWis6oBQw4u841bGOEi5z3NSBCZh1k+yD2qe4I0JWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088210; c=relaxed/simple;
	bh=gGGAZ+JPhYwwTaiJE7d8qsqUjoBWCoBFSwjG0FlZdwY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n1MEonEdeSSDKo2ePXZ8rsgekdMM3pjID1r90uaI879zCMAdM+AGbTwpH/HrNURnT0ZDWMbYXaPuKI3bYh9J/gK9lcSkJXa3hGqR9pvtKt1uJ7oXiahlw/mgBwnowWGdc3M51JLfU41sWKDAl5cJoDGxbNuSYbpBYXFtYwgOpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ospu5ZmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD631C4CEF4;
	Mon, 25 Aug 2025 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756088210;
	bh=gGGAZ+JPhYwwTaiJE7d8qsqUjoBWCoBFSwjG0FlZdwY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ospu5ZmW3GjXXp9OZguLhvSXOSU8+kuN5MzIV4kr+GyBgWAQG5t6ZQtPMrs2Dljzd
	 d4dDaib9LOKIPIWOHrQjq00X9FubG54QraUarHHsLZXu48OEdi0CjYscQrvhKu1ft5
	 uyd5fWX0q/NEXJFljGjqizzzP1kNXUIflJhIqdB9i1LV3iEFKvmhedVh6YxeWgncu8
	 /nOig6dkc0g/T5R+oc4Ye86AmOszNhBy9jYWkVX9McWVpxEUtBm4VF2EJLjwwMmLuA
	 JjBjw9JB5/MHSPSAye58YuE1iSRzLvskZqm8zS9Z73Iuy9SFgFCA2TPXBWtxU3SBPz
	 q95fqT7etWlaw==
Message-ID: <862f9f1e-1deb-48e6-b31b-96e9a8398544@kernel.org>
Date: Mon, 25 Aug 2025 10:16:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Tao Zeng <tao.zeng@amlogic.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Tuan Zhang <tuan.zhang@amlogic.com>
Subject: Re: [PATCH] f2fs: skip checkpoint for compressed file write
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250821-dev-v1-1-17895dcd6de5@amlogic.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250821-dev-v1-1-17895dcd6de5@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 10:40, Jiucheng Xu via B4 Relay wrote:
> From: Tao Zeng <tao.zeng@amlogic.com>
> 
> Always do checkpoint is a heavy behavior for compressed file.
> But for contiguous writing of a file, checkpoint need to be
> skipped to help improve performance.
> 
> Tested with iozone for always do check point on compressed data,
> results are:
> 
> File stride size set to 17 * record size.
>                                                   random  random
>     KB  reclen   write rewrite    read    reread    read   write
> 102400       4    1314   35488   234231  1683793 1212394   35334
> 102400       8    2387   54133   244584  1871789 1644952   52478
> 102400      16    5060    7059   298052  1901792 1894929    6600
> 102400      32    9315   13118   424723  1825565 1924235   12041
> 102400      64   17028   22258   491181  1844443 1968247   22115
> 102400     128   30551   38008   445192  1796615 1917466   38527
> 102400     256   46944   55006   509625  1630910 1715586   56201
> 102400     512   63355   70432   434639  1406089 1487569   72718
> 102400    1024   83036   86742   447141  1420505 1503320   88913
> 102400    2048   98577  101971   450287  1434918 1522294  106374
> 102400    4096  113300  116994   451286  1435321 1527404  119579
> 102400    8192  132532  133044   488503  1458688 1540595  141167
> 102400   16384  143246  143857   489376  1469878 1556530  151362
> 
> We can see that writing speed of small pieces of data(less than 16KB) is
> very slow.
> 
> With this change, iozone data are on the same hardware:
>                                                   random  random
>     KB  reclen   write rewrite    read    reread    read   write
> 102400       4   14658   34796   232797  1985764 1219513   34509
> 102400       8   25980   53695   233218  2419198 1788989   51927
> 102400      16   49556   50325   266754  2780871 2256746   50593
> 102400      32   79947   80783   393452  2755413 2467949   77681
> 102400      64  104866  105830   531853  2816504 2596812  106223
> 102400     128  142097  142034   651876  2885805 2728473  143296
> 102400     256  146972  144822   535727  2542080 2450922  157390
> 102400     512  126591  152480   571581  2055442 2052839  156512
> 102400    1024  135164  143667   654547  2052594 2045214  130488
> 102400    2048  127587  124889   491258  2058457 2059454  141273
> 102400    4096  124280  123959   660713  2067394 2056889  131967
> 102400    8192  138240  136233   509709  2102040 2090773  149215
> 102400   16384  146524  145333   576519  2118162 2096482  158704
> 
> We can see that speed of write with small pieces of data increased a lot.
> 
> Signed-off-by: Tao Zeng <tao.zeng@amlogic.com>
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  fs/f2fs/f2fs.h |  1 +
>  fs/f2fs/file.c | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d6a49de1b7e919eda12354c074b8b253b2a9ea3f..2f820d531cdb32c0fc050aca05ffd3d00395a618 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1531,6 +1531,7 @@ enum compress_algorithm_type {
>  
>  enum compress_flag {
>  	COMPRESS_CHKSUM,
> +	COMPRESS_SKIP_WRITE_CP,
>  	COMPRESS_MAX_FLAG,
>  };
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 42faaed6a02da01f2bd117a5c55e1761beaffde6..3561b407f45e7aa97c7dcf911d4dddbc01ec2ca4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -212,7 +212,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  
>  	if (!S_ISREG(inode->i_mode))
>  		cp_reason = CP_NON_REGULAR;
> -	else if (f2fs_compressed_file(inode))
> +	else if (f2fs_compressed_file(inode) &&
> +		 !(F2FS_I(inode)->i_compress_flag &
> +			 BIT(COMPRESS_SKIP_WRITE_CP)))
>  		cp_reason = CP_COMPRESSED;

IIRC, we can not avoid checkpoint for fsync on compressed file w/ this way,
since we haven't supported compressed file recovery yet.

You can check this w/ the way as below:

write -> fsync -> shutdown -> recovery -> check data&meta

Thanks,

>  	else if (inode->i_nlink != 1)
>  		cp_reason = CP_HARDLINK;
> @@ -5234,6 +5236,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			f2fs_dio_write_iter(iocb, from, &may_need_sync) :
>  			f2fs_buffered_write_iter(iocb, from);
>  
> +		/* skip checkpoint for normal write compress file */
> +		if (f2fs_compressed_file(inode))
> +			F2FS_I(inode)->i_compress_flag |=
> +				BIT(COMPRESS_SKIP_WRITE_CP);
> +
>  		trace_f2fs_datawrite_end(inode, orig_pos, ret);
>  	}
>  
> @@ -5250,14 +5257,17 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	}
>  
>  	clear_inode_flag(inode, FI_PREALLOCATED_ALL);
> +
> +	if (ret > 0 && may_need_sync)
> +		ret = generic_write_sync(iocb, ret);
> +
> +	if (f2fs_compressed_file(inode))
> +		F2FS_I(inode)->i_compress_flag &= ~BIT(COMPRESS_SKIP_WRITE_CP);
>  out_unlock:
>  	inode_unlock(inode);
>  out:
>  	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
>  
> -	if (ret > 0 && may_need_sync)
> -		ret = generic_write_sync(iocb, ret);
> -
>  	/* If buffered IO was forced, flush and drop the data from
>  	 * the page cache to preserve O_DIRECT semantics
>  	 */
> 
> ---
> base-commit: 3ea4ad0a1df0bcbfd5ccdcea56d57ca4678ae2a8
> change-id: 20250820-dev-31b792e8e1fb
> 
> Best regards,


