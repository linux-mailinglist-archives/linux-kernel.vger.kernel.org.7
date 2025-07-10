Return-Path: <linux-kernel+bounces-725144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B7AFFB46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645841C835E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC8289832;
	Thu, 10 Jul 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ej0CbxEL"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9891DFFC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133610; cv=none; b=mdYVIELTL/vfkhbF2omPw8Ftq2wXadoIBSj94K/VF4iRuCkIHpSeXcKir+QHx5r7dwEsE+C3nOA4M5iZV2ZSR6cLNK9Tiig7VJO2/5QAuIFcApnvtJa/UAn2LiGtqBLEscYcLXN4HujeAu6jduazKXBbpt20mL1tiW4J3B8Tz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133610; c=relaxed/simple;
	bh=dDuHzuuilF1rfXmappGHHnIFPLV2cINkcTgow+/K3XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU3SNf4OIRXec6f8WqxVtRzuD2g3Fg3zzptdmimlDhFSW6vqZsyBbXTN5HREg5hQmLTKFlN1Mt6NAq2ZVPDPZXCNkT0HtlqklNkVp0piU0OrbB/DgLxQatn1zGhshmdlC93QdJNkAeKGhl/eqk5sc+sicrlG6o6NSOJ1RC3qOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ej0CbxEL; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752133605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0s3D/I0IgWK1k4rhAjUlxCvBQXJhoNVSk7AvaiTRwC0=;
	b=ej0CbxEL+PlaodYlniH6SBVETJw85XWJt3b7Lpph2yuMs3/SK7T77A2nBozI45VSK3KiCVcBIr+ZNdFtwvxQ3s8F3wLEy+leYIMUxQKpPq14SoyNVJu6uTSK3ljCf9+TGLhccma2qzfZEMt5pkmCR1eRkcfa3Whm6/f46j3pRuI=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WibzTBy_1752133604 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 15:46:44 +0800
Message-ID: <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
Date: Thu, 10 Jul 2025 15:46:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250710073619.4083422-2-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chao,

On 2025/7/10 15:36, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(),
> it can enhance performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/erofs/dir.c      | 8 ++++++++
>   fs/erofs/internal.h | 3 +++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index cff61c5a172b..04113851fc0f 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   	struct inode *dir = file_inode(f);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct super_block *sb = dir->i_sb;
> +	struct file_ra_state *ra = &f->f_ra;
>   	unsigned long bsz = sb->s_blocksize;
>   	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
> +	unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>   	int err = 0;
>   	bool initial = true;
>   
> @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   		}
>   		cond_resched();
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
> +			page_cache_sync_readahead(dir->i_mapping, ra, f,
> +				dbstart, min(nr_pages - dbstart,
> +				(pgoff_t)MAX_DIR_RA_PAGES));
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index a32c03a80c70..ef9d1ee8c688 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* maximum readahead pages of directory */
> +#define MAX_DIR_RA_PAGES	4

Could we set it as a per-sb sysfs configuration for users to config?

Thanks,
Gao Xiang

