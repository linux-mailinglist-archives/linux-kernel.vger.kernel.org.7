Return-Path: <linux-kernel+bounces-740153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76952B0D0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875C03ACF08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54428983E;
	Tue, 22 Jul 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnj+56xr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA35223
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156621; cv=none; b=TeIUe18YIMIz+dS5aO4V6y9UeI18erHyYqhiRhbUpjOaUPYD6JW0oPO3uffFbFc0i6rN98YI1rbzMpQSlJ+T0/SLWNwuD4H/P8JniJS90zZqJvx4QACVspZ3zhuc4V7YgDXndtEsT3FtBEWVkyOVAHvqmTKfsEnD/XXK1y1pbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156621; c=relaxed/simple;
	bh=XXjqNY4eX+gG1Wzkx5jVH3Efas2zIJQsL2cm0SrIWoE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=begp2EfVExrCrT8rnPgY7ZSmqBkel/VSINLTqrIFoTN7ZTIBkrffAb3CxXdsxZOwm7MnBZTj+Nq76JQS84TVajbVxDMkZed6CYhk4MPfoPScYMS7eYgtmWUP+2gIy8PpSyTND1RAWj9TEVVlmrnSvFWSFdwOttSm7f44uQviWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnj+56xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22311C4CEF1;
	Tue, 22 Jul 2025 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753156621;
	bh=XXjqNY4eX+gG1Wzkx5jVH3Efas2zIJQsL2cm0SrIWoE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cnj+56xrEBRSztP9GL6FBsnCb5g6Xx1IiRoJ+hZ3jkgukMmu5PmqNIUit3OBx1O++
	 f76Czu2wQO7yAuRtgd75/OuwDl3Jaovpxj1QwlyBHxC1PUkIVsxuUBcPp/hsENFfMn
	 XYkiLYJNzm3Tx3uomVDpam+NfDn6++wzqDBvoAAnKbvAAZjjCgRnmBW/Jff1QfxZ4O
	 o8icbBLRjppB/3mqPBNbl5Y4rpUO1RwfYGzt2IKBd+CN5TxMAm3xXfDESCKP1H7fjJ
	 YMwNV4R/iOPqB3nR7UrxJRKAjeN4I53V2cMwdVw8X1yfeJBOyAoa59sR5Rz4motcNJ
	 akvTrLliNRd6w==
Message-ID: <fed85e52-2965-41d0-9e73-8f2e15dbef06@kernel.org>
Date: Tue, 22 Jul 2025 11:56:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, pilhyun.kim@sk.com
Subject: Re: [PATCH] f2fs: zone: wait for inflight dio completion, excluding
 pinned files
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org
References: <20250721054135.1919-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250721054135.1919-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 13:41, yohan.joung wrote:
> pinfile is excluded as it operates with direct I/O

pinfile can use buffer IO as well?

Thanks,

> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4039ccb5022c..cac8c9650a7a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4844,7 +4844,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  	/* In LFS mode, if there is inflight dio, wait for its completion */
>  	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
> -	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
> +	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE) &&
> +		!f2fs_is_pinned_file(inode))
>  		inode_dio_wait(inode);
>  
>  	if (f2fs_should_use_dio(inode, iocb, to)) {


