Return-Path: <linux-kernel+bounces-826523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF517B8EB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8E9189AAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2852EC0B7;
	Mon, 22 Sep 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o/N6Onyv"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52C2C08BB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505753; cv=none; b=JP54raHd7RoFTqwHicNUTEpYoo0cJWi9WrGGL0ZRlkXWxhaePFw0enCAc4yhX6i4rSD9ho1feN9HKILWwf3VbxXl6FtdYl42k26n/9fvSx6Ml2NS6cuK1D6hGjcX7mZ9TBzWZ6fejV9zfzkhFUOvGsq5B1HnKhqcuGHtNp7maNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505753; c=relaxed/simple;
	bh=DjXsKCPvKzL+TruddAAT3u0OAJ+OZ0NAoRsUkk0jhW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmQYQVKJ6aO+B32T93q0pl5ryfkeghKBRaMuC0FPZz5T8O3n5EIr/7Sy0p0ELYteQEOX0+4RU62bPUejj/J1RbSl6+5bGCtLl4XrAoDvETSSwH9gKwiT11MsNLE64chySSUwu4mRCGDMQr2KV/Rd/GRK+f0ah4Wg7S6As92K+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o/N6Onyv; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758505742; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Poayc0RqgwJy1pB7pq1QbfeCMD4BfPBzJE20vpS6iYk=;
	b=o/N6OnyvLRs5is61+zS6OWGuWEcne5ajvtJiIPQnDZPFEiaMopaKtag8CC7Htn73avP6g/l4b9xLuZV34p+ImXJwu/gIQlCP3sKfSDCN+tW8okbmvhXW98FYPwvn+ZsTIlTHeCKVO5hh/BZhnJ9D1hv/yHYYHbr8gZc9jdhnlfY=
Received: from 30.221.131.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoQX48k_1758505741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 09:49:02 +0800
Message-ID: <47107a3c-44d5-4937-bc35-2e01605bdb98@linux.alibaba.com>
Date: Mon, 22 Sep 2025 09:49:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20250920060455.24002-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250920060455.24002-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/20 14:04, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> ---
> 
> v1: https://lore.kernel.org/linux-erofs/63904ade56634923ba734dcdab3c45d0@inspur.com/T/#t
> v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/T/#u
> 
> Changes since v2:
> - remove unnecessary code
> 
>   fs/erofs/Makefile   |  2 +-
>   fs/erofs/data.c     |  4 ++++
>   fs/erofs/dir.c      |  4 ++++
>   fs/erofs/inode.c    |  5 +----
>   fs/erofs/internal.h |  7 +++++++
>   fs/erofs/ioctl.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  8 ++++++++
>   7 files changed, 66 insertions(+), 5 deletions(-)
>   create mode 100644 fs/erofs/ioctl.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..5be6cc4acc1c 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3b1ba571c728..8ca29962a3dd 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
>   const struct file_operations erofs_file_fops = {
>   	.llseek		= erofs_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   	.mmap_prepare	= erofs_file_mmap_prepare,
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index debf469ad6bd..32b4f5aa60c9 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read		= generic_read_dir,
>   	.iterate_shared	= erofs_readdir,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 9a2f59721522..a7ec17eec4b2 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			inode->i_fop = &generic_ro_fops;
> -		else
> -			inode->i_fop = &erofs_file_fops;
> +		inode->i_fop = &erofs_file_fops;
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ccc5f0ee8df..311346a017a7 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -166,6 +166,9 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	/* volume name */

The comment is useless, just drop this line.

> +	char *volume_name;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -535,6 +538,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg);
> +
>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
>   
>   #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c
> new file mode 100644
> index 000000000000..fbcbf820c4d7
> --- /dev/null
> +++ b/fs/erofs/ioctl.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/fs.h>
> +#include <linux/compat.h>
> +#include <linux/file.h>
> +
> +#include "internal.h"
> +
> +static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)

Can we just move these functions into inode.c instead?

Since there is no need to introduce a new file just for
a few new lines.

Otherwise it looks good to me.

Thanks,
Gao Xiang

