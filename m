Return-Path: <linux-kernel+bounces-734899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E6B087DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA354A51D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9E27A468;
	Thu, 17 Jul 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v70p1N2h"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE653BE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740817; cv=none; b=VkSILU+pP1J8KNCAuV/zl6/JKi03L2DYNaz3g0BaA7DBvcd4oV0fPClati+fvhO5yzE9e52ndR60hT1Z3D0dysVzOXwWAW2/YCfzek/GJOHhInBnb8zbebNLLqXG7zCxtITQBAJVCPHYWo0rsdrzqGua84EsQlFPVnN3+wdud1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740817; c=relaxed/simple;
	bh=alXWagtsfCwaYnDnUlZB/tbsctC1eW98s/u7xEvYoe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dy0P1nA0UAyYBvjP7QZu4OZjC+2qxKCAvPMbYtjCQndqM2ZQVvfDUnqJewe7Ghilx2i2y2b4LbGoQTKNNzHd4yETKGYjS2m6aSsaTCvYfThpmbPrQOK26mjXaJFEXLUnhpNjH+orN60/HpHATDgS40dIpLfm57viyqjMJN7O834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v70p1N2h; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752740806; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J2Hks8QCYq4evKvuvI8+y/woADFExPZk3G6ixGR9F4o=;
	b=v70p1N2hoqvwWO0IgBQx/QFH5ajCx7L6rOwAugOTDTkrH1UMTDpO3SHHmD+u5bjCDFGnBVJUhI2JOoX2WrKndhw7kNk/1pU7WKWebHvQdlZH1LbzDzTczI0GiJD8Dzs+1Lq3DazK1PSWZM6ii0MSEv/esDj6K87pH/F2G9sTej8=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj7NBkg_1752740805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 16:26:46 +0800
Message-ID: <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Date: Thu, 17 Jul 2025 16:26:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714093935.200749-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714093935.200749-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chao,

On 2025/7/14 17:39, Chao Yu wrote:
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
> v3:
> - add EROFS prefix for macro
> - update new sysfs interface to 1) use bytes instead of pages
> 2) remove upper boundary limitation
> - fix bug of pageidx calculation
>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>   fs/erofs/dir.c                           | 13 +++++++++++++
>   fs/erofs/internal.h                      |  4 ++++
>   fs/erofs/super.c                         |  2 ++
>   fs/erofs/sysfs.c                         |  2 ++
>   5 files changed, 29 insertions(+)
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
> index 3e4b38bec0aa..950d6b0046f4 100644
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

	pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);

>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (EROFS_I_SB(dir)->dir_ra_bytes) {

		if (ra_pages) {

> +			unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
> +			pgoff_t ra_pages = DIV_ROUND_UP(
> +				EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);

			pgoff_t idx = PAGE_ALIGN(ctx->pos);
			pgoff_t pages = min(nr_pages - idx, ra_pages);

> +
> +			if (nr_pages - idx > 1 && !ra_has_index(ra, idx))

			if (pages > 1 && !ra_has_index(ra, idx))
				page_cache_sync_readahead(dir->i_mapping, ra,
							  f, idx, pages)?


> +				page_cache_sync_readahead(dir->i_mapping, ra,
> +					f, idx, min(nr_pages - idx, ra_pages));
> +		}
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0d19bde8c094..4399b9332307 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>   	/* sysfs support */
>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
> +	erofs_off_t dir_ra_bytes;
>   
>   	/* fscache support */
>   	struct fscache_volume *volume;
> @@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* default readahead size of directory */

/* default readahead size of directories */

Otherwise it looks good to me.

Thanks,
Gao Xiang

> +#define EROFS_DIR_RA_BYTES	16384

