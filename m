Return-Path: <linux-kernel+bounces-738588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B0B0BAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9115C189D023
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72922288AD;
	Mon, 21 Jul 2025 02:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MM//zVY5"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D321DF751
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064711; cv=none; b=Q5RgaZJ/5Emms6nGROhhL0etkQF2QOwp6UufFVFuid+jgZO40IxNrsAoxB49b3239K7sooxpRLm6m+2e9pJkrM6OYFRKLEbhEuH2GO5hS1ErMDrC9brN+gqC0zmw1Xs7HNl3wHCEdo6bu7F8yUa4c2/H/Ncoheo+k/0ccpO8Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064711; c=relaxed/simple;
	bh=SPULyHNQKxx+vaTYoNOnC5xoly8ezLk/vhZBw+fAg4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSUI7AelaZkSaBY+q65NjvEnARzBuPy8ntaDov/Htt7i089ipq1KF++G/Fbm0663SeUzEkxAFe6cTdggVvX7jinaaAa9wgztLCoO8oKjmD4jh065Jsu68mjgHthSU0C3Wkx8J0+InWj2zNhJA1UxMIWdodK8KKcR+ntsiQCp7qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MM//zVY5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753064700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yrQVfN36myljSGt7KhTp+J0XIr4q1ZCI43iHYtn5FWY=;
	b=MM//zVY5uU2FigqYnfypZ33Vjykf0nQW+J6GFA45hAjSJT37HZDjAl7WTzGVkMj5DI3+4NdIsoHP7DgvDf5x5JufBJA3zIkpv2zGpQewbhkfaiqVL0ab8cvr57mBuJwzFFOBznpVE4ePMucBkpDpXJyugqN4APFkO8QghxRKLYY=
Received: from 30.221.132.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjIW.Ah_1753064697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 10:24:58 +0800
Message-ID: <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Date: Mon, 21 Jul 2025 10:24:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250721021352.2495371-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250721021352.2495371-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/21 10:13, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(), it can
> enhance readdir performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Meanwhile, let's introduces a new sysfs entry to control readahead
> bytes to provide more flexible policy for readahead of readdir().
> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
> - default value: 16384
> - disable readahead: set the value to 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - clean up codes and comments
>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>   fs/erofs/dir.c                           | 14 ++++++++++++++
>   fs/erofs/internal.h                      |  4 ++++
>   fs/erofs/super.c                         |  2 ++
>   fs/erofs/sysfs.c                         |  2 ++
>   5 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bf3b6299c15e..85fa56ca092c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -35,3 +35,11 @@ Description:	Used to set or show hardware accelerators in effect
>   		and multiple accelerators are separated by '\n'.
>   		Supported accelerator(s): qat_deflate.
>   		Disable all accelerators with an empty string (echo > accel).
> +
> +What:		/sys/fs/erofs/<disk>/dir_ra_bytes
> +Date:		July 2025
> +Contact:	"Chao Yu" <chao@kernel.org>
> +Description:	Used to set or show readahead bytes during readdir(), by
> +		default the value is 16384.
> +
> +		- 0: disable readahead.
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 3e4b38bec0aa..99745c272b60 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   	struct inode *dir = file_inode(f);
>   	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>   	struct super_block *sb = dir->i_sb;
> +	struct file_ra_state *ra = &f->f_ra;
>   	unsigned long bsz = sb->s_blocksize;
>   	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
> +	pgoff_t ra_pages = DIV_ROUND_UP_POW2(
> +			EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
> +	pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (ra_pages) {
> +			pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);

Can we use DIV_ROUND_UP_POW2 here too? If it's okay,
I will update the patch manually when applied.

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

