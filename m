Return-Path: <linux-kernel+bounces-729332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8E6B03511
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7E1737AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23D61DE3A7;
	Mon, 14 Jul 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qfqlp+/h"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC62178F26
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465299; cv=none; b=H2Dhzy2N/N9BPx5JS5waiK3LJqw1d/kWuTajXRa9DCXBZi1vcK1XkaiKTVhr9vuBqLIgGLMN+AQx+X/ljY5DWRlZ2W9FmyRz2wdK0HnVB8eeFDHc2HHdoMIZTfqJ8AFAq/KMCTr0Afn7Tu5/x1oEfJYlrMkeF2AWQJCMowNI8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465299; c=relaxed/simple;
	bh=CqWHBFnkvDWPBBdd9Fv8Undh75CIVB4T4DKRZrwX4t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQbP6ostC8Q+WdZAv58IDx3ixXC4U5jaEmdOlF5QXKn5BACj1gGIGps8TGEAXTPYU4diFaVCrS7NEBunFwaVPsFGWkA/sSskp5mwRrxf9mHc2e8MebJ7PUHW3RSOkqDVenCfgUGEIEJw+Z9dKecg56Wwu8cLA9A5zGvIooYCSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qfqlp+/h; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752465288; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ndtedV3xeHlGSyyPbawukZOShJ9c9Dr8tbzXkvBO1kY=;
	b=qfqlp+/hUgKcPp/G9mH3XG8wNaMMlnWFcqpJcH4CK4hP0LQiKoJcAlUa4LihXxyaYSPEtPrGlNxXPSdh4AxwSJ5f8KM8QLk1x1SCiHsmxTN9SCKC8hgchYmcMzmL0UPxmPdJS8A6SvmhmfDXgUeluPH2vshRJGDxW1Ly2Qmons8=
Received: from 30.221.131.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WioW9Ae_1752464970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Jul 2025 11:49:30 +0800
Message-ID: <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Date: Mon, 14 Jul 2025 11:49:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250714033450.58298-1-chao@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714033450.58298-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chao,

On 2025/7/14 11:34, Chao Yu wrote:
> This patch supports to readahead more blocks in erofs_readdir(), it can
> enhance readdir performance in large direcotry.
> 
> readdir test in a large directory which contains 12000 sub-files.
> 
> 		files_per_second
> Before:		926385.54
> After:		2380435.562
> 
> Meanwhile, let's introduces a new sysfs entry to control page count
> of readahead to provide more flexible policy for readahead of readdir().
> - location: /sys/fs/erofs/<disk>/dir_ra_pages
> - default value: 4
> - range: [0, 128]
> - disable readahead: set the value to 0
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - introduce sysfs node to control page count of readahead during
> readdir().
>   Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
>   fs/erofs/dir.c                           | 9 +++++++++
>   fs/erofs/internal.h                      | 5 +++++
>   fs/erofs/super.c                         | 2 ++
>   fs/erofs/sysfs.c                         | 5 +++++
>   5 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index bf3b6299c15e..500c93484e4c 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -35,3 +35,10 @@ Description:	Used to set or show hardware accelerators in effect
>   		and multiple accelerators are separated by '\n'.
>   		Supported accelerator(s): qat_deflate.
>   		Disable all accelerators with an empty string (echo > accel).
> +
> +What:		/sys/fs/erofs/<disk>/dir_ra_pages
> +Date:		July 2025
> +Contact:	"Chao Yu" <chao@kernel.org>
> +Description:	Used to set or show page count of readahead during readdir(),
> +		the range of value is [0, 128], by default it is 4, set it to
> +		0 to disable readahead.
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 3e4b38bec0aa..40f828d5b670 100644
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

why using DIV_ROUND_UP_POW2 rather than DIV_ROUND_UP here?

>   	int err = 0;
>   	bool initial = true;
>   
> @@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>   			break;
>   		}
>   
> +		/* readahead blocks to enhance performance in large directory */
> +		if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&

dbstart is a byte-oriented value, so I'm not sure if it
works as you expect..

> +		    !ra_has_index(ra, dbstart))
> +			page_cache_sync_readahead(dir->i_mapping, ra, f,
> +				dbstart, min(nr_pages - dbstart,

same here.

> +				(pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
> +
>   		de = erofs_bread(&buf, dbstart, true);
>   		if (IS_ERR(de)) {
>   			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0d19bde8c094..f0e5b4273aa8 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>   	/* sysfs support */
>   	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>   	struct completion s_kobj_unregister;
> +	unsigned int dir_ra_pages;
>   
>   	/* fscache support */
>   	struct fscache_volume *volume;
> @@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
>   #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
>   
> +/* default/maximum readahead pages of directory */
> +#define DEFAULT_DIR_RA_PAGES	4
> +#define MAX_DIR_RA_PAGES	128

better to add EROFS_ prefix for them.

Also could we setup those blocks or bytes instead
of pages?

If users would like to setup values, they may don't
care more the page size since they only care about
images.

Also why do we limit maximum number even if users
would like to readahead more? (such as fadvise
allows -1 too)

Thanks,
Gao Xiang

