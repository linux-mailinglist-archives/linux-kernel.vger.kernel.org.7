Return-Path: <linux-kernel+bounces-740217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01DB0D17D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E1D545572
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46A28D85D;
	Tue, 22 Jul 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtcuZvEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86428C877
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163518; cv=none; b=hhs54IcMk3Zy+WfTtgTbKROXdfQWCYKzHpVNJMKhtzqScYkYEvBFuJbyq2xa9eSwLqi44aLO/xHzTIui5VPCWgf4XmerW+EYTdi9AfKknk+yyP8dTSVXHRGgo2RfB2QRPSYiCS1cL49TCiaPYufbojsRPtx3ztiCLyDqnj3aNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163518; c=relaxed/simple;
	bh=ZBaWQtduHodYlO4mYxwXFmcc2F7X42TbHmgOgciFSwQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mV7zqo24jn0o8+df9n3+gedkOax4GMyVjfeoO1YokttLkzNcigrTjTvHNpwFAaMvzJESfsIPel41NRo0zDpJoDU8EVa0rLoHIvYrPJjoPV/oM+rCHss00crqsOX6/ucoljqJwLcm85pQp4wDxTtHzngZSGE8f37KbN1n+u6AHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtcuZvEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9042AC4CEEB;
	Tue, 22 Jul 2025 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753163517;
	bh=ZBaWQtduHodYlO4mYxwXFmcc2F7X42TbHmgOgciFSwQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AtcuZvEZk8YTs501SYNkZ+WHbd5Lvv9JzypLnMdXxJ8qnBU6FSnFPUPTzqUuWvl9e
	 xYboZowGVJ4x6qWyjFgROCPdcx0yKMMFGZtvjxVutgnENxkjSx68VujWwHcTnB8TIP
	 o3TrCjjfGaYGZPW/1664YBS3N1feVG1vR9DJgco4bVPK6uaeS4/arr0teFHA7E1ybX
	 39MtwFBb5CRbBlidpJm0jCvmZSTa0mt6UrxC2YuiPBlq74sAZ/oCffe2qDMISz4N/Z
	 IlCcgt1P3ruU8G5lyy1xqbkYtEpo7+wnpN4duCI4bE9FnX7DyUxnO9WI82FPve3Uiy
	 kFNZa19Vb29aw==
Message-ID: <33e75ec8-9bf4-4c45-b706-a2e6b6cd8413@kernel.org>
Date: Tue, 22 Jul 2025 13:51:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, pilhyun.kim@sk.com
Subject: Re: [PATCH v2] f2fs: zone: wait for inflight dio completion,
 excluding pinned files read using dio
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org
References: <20250722052046.1445-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250722052046.1445-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 13:20, yohan.joung wrote:
> read for the pinfile using Direct I/O do not wait for dio write.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4039ccb5022c..2b7e5c46c1ae 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4834,6 +4834,7 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	const loff_t pos = iocb->ki_pos;
>  	ssize_t ret;
> +	bool dio;
>  
>  	if (!f2fs_is_compress_backend_ready(inode))
>  		return -EOPNOTSUPP;
> @@ -4842,12 +4843,15 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
>  					iov_iter_count(to), READ);
>  
> +	dio = f2fs_should_use_dio(inode, iocb, to);
> +
>  	/* In LFS mode, if there is inflight dio, wait for its completion */
>  	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
> -	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
> +	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
> +		!(f2fs_is_pinned_file(inode) && dio))

How about?

(!f2fs_is_pinned_file(inode) || !dio)

Thanks,

>  		inode_dio_wait(inode);
>  
> -	if (f2fs_should_use_dio(inode, iocb, to)) {
> +	if (dio) {
>  		ret = f2fs_dio_read_iter(iocb, to);
>  	} else {
>  		ret = filemap_read(iocb, to, 0);


