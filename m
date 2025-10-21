Return-Path: <linux-kernel+bounces-862961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DB7BF6A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11B6545ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD5334C28;
	Tue, 21 Oct 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f6cd+2xw"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93280337118
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051706; cv=none; b=SXyXDm7IhwsKf716x76uGoE01Oe2+bO++j6zWUnlJ747TQRbgxqj8vmtgt1L0VxPkRmlD9xTQ3tNQCkJs8SQsm6MvayyECFO8chQOUIvlKrMZbt4ciPed/eKEySc/JNOnu+EtmauRP2xzarL8wDHbh6yvz0ts3BeyBKFs5fnM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051706; c=relaxed/simple;
	bh=Ks8XgcKXndycUbTm+Uu8wrGFfOzPcCjYJzyE9/UppCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLjL/tDL81Nn2412tC/dIewxX4rQ3dp877L54+sJn836tofK6SAvQD/weI3Mcj//RDLu3lGCj1WHJujhGF+D4FV1/ETMCXOYokXwn23Q85H4W8a8IJUw5KLbwcs7EOpaXm4+FVliD9GHFa0KIrz+3uMHmbgg4mYCqd7X8t5lFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f6cd+2xw; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761051700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HMOIo9bj01WGBspEBVjROmQ/WIesyC/CiLx2+1Px6os=;
	b=f6cd+2xwsXVPbNBOvwP6vVi2Fh28Qu3ogj031tAn3CO1qqbwpOekVPJKINGg7fP8p2HFLu6FSgbJv4qnsO3S17WgQ9PYM+aGNUyNMBfDzKVQs0xNKW2+C9RpntRyzRcnLare3AaUqE9qf9000PAFg2RgM7ak+nZxR+6GBEGhPiA=
Received: from 30.180.79.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqjB-52_1761051698 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 21:01:39 +0800
Message-ID: <96569039-1d93-45bc-a0e0-631b71bbb41f@linux.alibaba.com>
Date: Tue, 21 Oct 2025 21:01:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 5/7] erofs: support unencoded inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>, brauner@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
 <20251021104815.70662-6-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251021104815.70662-6-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/21 18:48, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds inode page cache sharing functionality for unencoded
> files.
> 
> I conducted experiments in the container environment. Below is the
> memory usage for reading all files in two different minor versions
> of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> [hongbo: forward port, minor fixes and cleanup]
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c     | 81 ++++++++++++++++++++++++++++++++++++++-----
>   fs/erofs/inode.c    |  5 +++
>   fs/erofs/internal.h |  4 +++
>   fs/erofs/ishare.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/ishare.h   | 18 ++++++++++
>   fs/erofs/super.c    |  7 ++++
>   6 files changed, 190 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 8ca29962a3dd..438d43c959aa 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "internal.h"
> +#include "ishare.h"
>   #include <linux/sched/mm.h>
>   #include <trace/events/erofs.h>
>   
> @@ -266,25 +267,55 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>   }
>   
> +struct erofs_iomap {
> +	void *base;
> +	struct inode *realinode;
> +};
> +
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>   {
>   	int ret;
> -	struct super_block *sb = inode->i_sb;
> +	struct super_block *sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
> +	struct inode *realinode = inode;
> +	struct erofs_iomap *erofs_iomap;
> +	bool is_ishare = erofs_is_ishare_inode(inode);
> +
> +	if (is_ishare) {
> +		if (!iomap->private) {

I tend to pass in `iomap->private` and allocate on disk
as I mentioned in
https://lore.kernel.org/r/20250829235627.4053234-14-joannelkoong@gmail.com

to avoid unnecessary kzalloc.

Thanks,
Gao Xiang

> +			erofs_iomap = kzalloc(sizeof(*erofs_iomap),
> +					      GFP_KERNEL);
> +			if (!erofs_iomap)
> +				return -ENOMEM;
> +			erofs_iomap->realinode = erofs_ishare_iget(inode);
> +			if (!erofs_iomap->realinode) {
> +				kfree(erofs_iomap);
> +				return -EINVAL;
> +			}
> +			iomap->private = erofs_iomap;
> +		}
> +		erofs_iomap = iomap->private;
> +		realinode = erofs_iomap->realinode;
> +	}
>   
> +	sb = realinode->i_sb;
>   	map.m_la = offset;
>   	map.m_llen = length;
> -	ret = erofs_map_blocks(inode, &map);
> +	ret = erofs_map_blocks(realinode, &map);
>   	if (ret < 0)
>   		return ret;
>   
>   	iomap->offset = map.m_la;
>   	iomap->length = map.m_llen;
>   	iomap->flags = 0;
> -	iomap->private = NULL;
>   	iomap->addr = IOMAP_NULL_ADDR;
> +
> +	if (is_ishare)
> +		erofs_iomap->base = NULL;
> +	else
> +		iomap->private = NULL;
>   	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>   		iomap->type = IOMAP_HOLE;
>   		return 0;
> @@ -318,7 +349,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		if (IS_ERR(ptr))
>   			return PTR_ERR(ptr);
>   		iomap->inline_data = ptr;
> -		iomap->private = buf.base;
> +		if (is_ishare)
> +			erofs_iomap->base = buf.base;
> +		else
> +			iomap->private = buf.base;
>   	} else {
>   		iomap->type = IOMAP_MAPPED;
>   	}
> @@ -328,7 +362,17 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>   		ssize_t written, unsigned int flags, struct iomap *iomap)
>   {
> -	void *ptr = iomap->private;
> +	struct erofs_iomap *erofs_iomap;
> +	bool is_ishare;
> +	void *ptr;
> +
> +	is_ishare = erofs_is_ishare_inode(inode);
> +	if (is_ishare) {
> +		erofs_iomap = iomap->private;
> +		ptr = erofs_iomap->base;
> +	} else {
> +		ptr = iomap->private;
> +	}
>   
>   	if (ptr) {
>   		struct erofs_buf buf = {
> @@ -341,6 +385,12 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>   	} else {
>   		DBG_BUGON(iomap->type == IOMAP_INLINE);
>   	}
> +
> +	if (is_ishare) {
> +		erofs_ishare_iput(erofs_iomap->realinode);
> +		kfree(erofs_iomap);
> +		iomap->private = NULL;
> +	}
>   	return written;
>   }
>   
> @@ -369,17 +419,32 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct erofs_read_ctx rdctx = {
> +		.file = file,
> +		.inode = folio_inode(folio),
> +	};
> +	int ret;
> +
> +	erofs_read_begin(&rdctx);
> +	ret = iomap_read_folio(folio, &erofs_iomap_ops);
> +	erofs_read_end(&rdctx);
>   	trace_erofs_read_folio(folio, true);
>   
> -	return iomap_read_folio(folio, &erofs_iomap_ops);
> +	return ret;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	struct erofs_read_ctx rdctx = {
> +		.file = rac->file,
> +		.inode = rac->mapping->host,
> +	};
> +
> +	erofs_read_begin(&rdctx);
> +	iomap_readahead(rac, &erofs_iomap_ops);
> +	erofs_read_end(&rdctx);
>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
> -
> -	return iomap_readahead(rac, &erofs_iomap_ops);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index cb780c095d28..fe45e6c18f8e 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "xattr.h"
> +#include "ishare.h"
>   #include <linux/compat.h>
>   #include <trace/events/erofs.h>
>   
> @@ -215,6 +216,10 @@ static int erofs_fill_inode(struct inode *inode)
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
>   		inode->i_fop = &erofs_file_fops;
> +#ifdef CONFIG_EROFS_FS_INODE_SHARE
> +		if (erofs_ishare_fill_inode(inode))
> +			inode->i_fop = &erofs_ishare_fops;
> +#endif
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 158bda6ba784..9ce6e5753978 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -322,11 +322,15 @@ struct erofs_inode {
>   			spinlock_t lock;
>   			/* all backing inodes */
>   			struct list_head backing_head;
> +			/* processing list */
> +			struct list_head processing_head;
>   		};
>   
>   		struct {
>   			struct inode *ishare;
>   			struct list_head backing_link;
> +			struct list_head processing_link;
> +			atomic_t processing_count;
>   		};
>   	};
>   #endif
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 910b732bf8e7..73432b13bf75 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -72,6 +72,7 @@ static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>   
>   	vi->fingerprint = data;
>   	INIT_LIST_HEAD(&vi->backing_head);
> +	INIT_LIST_HEAD(&vi->processing_head);
>   	spin_lock_init(&vi->lock);
>   	return 0;
>   }
> @@ -124,7 +125,9 @@ bool erofs_ishare_fill_inode(struct inode *inode)
>   	}
>   
>   	INIT_LIST_HEAD(&vi->backing_link);
> +	INIT_LIST_HEAD(&vi->processing_link);
>   	vi->ishare = idedup;
> +
>   	spin_lock(&EROFS_I(idedup)->lock);
>   	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
>   	spin_unlock(&EROFS_I(idedup)->lock);
> @@ -234,3 +237,83 @@ const struct file_operations erofs_ishare_fops = {
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
>   };
> +
> +void erofs_read_begin(struct erofs_read_ctx *rdctx)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +
> +	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
> +		return;
> +
> +	vi = rdctx->file->private_data;
> +	vi_dedup = EROFS_I(file_inode(rdctx->file));
> +
> +	spin_lock(&vi_dedup->lock);
> +	if (!list_empty(&vi->processing_link)) {
> +		atomic_inc(&vi->processing_count);
> +	} else {
> +		list_add(&vi->processing_link,
> +			 &vi_dedup->processing_head);
> +		atomic_set(&vi->processing_count, 1);
> +	}
> +	spin_unlock(&vi_dedup->lock);
> +}
> +
> +void erofs_read_end(struct erofs_read_ctx *rdctx)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +
> +	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
> +		return;
> +
> +	vi = rdctx->file->private_data;
> +	vi_dedup = EROFS_I(file_inode(rdctx->file));
> +
> +	spin_lock(&vi_dedup->lock);
> +	if (atomic_dec_and_test(&vi->processing_count))
> +		list_del_init(&vi->processing_link);
> +	spin_unlock(&vi_dedup->lock);
> +}
> +
> +/*
> + * erofs_ishare_iget - find the backing inode.
> + */
> +struct inode *erofs_ishare_iget(struct inode *inode)
> +{
> +	struct erofs_inode *vi, *vi_dedup;
> +	struct inode *realinode;
> +
> +	if (!erofs_is_ishare_inode(inode))
> +		return igrab(inode);
> +
> +	vi_dedup = EROFS_I(inode);
> +	spin_lock(&vi_dedup->lock);
> +	/* try processing inodes first */
> +	if (!list_empty(&vi_dedup->processing_head)) {
> +		list_for_each_entry(vi, &vi_dedup->processing_head,
> +				    processing_link) {
> +			realinode = igrab(&vi->vfs_inode);
> +			if (realinode) {
> +				spin_unlock(&vi_dedup->lock);
> +				return realinode;
> +			}
> +		}
> +	}
> +
> +	/* fall back to all backing inodes */
> +	DBG_BUGON(list_empty(&vi_dedup->backing_head));
> +	list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
> +		realinode = igrab(&vi->vfs_inode);
> +		if (realinode)
> +			break;
> +	}
> +	spin_unlock(&vi_dedup->lock);
> +
> +	DBG_BUGON(!realinode);
> +	return realinode;
> +}
> +
> +void erofs_ishare_iput(struct inode *realinode)
> +{
> +	iput(realinode);
> +}
> diff --git a/fs/erofs/ishare.h b/fs/erofs/ishare.h
> index 54f2251c8179..b85fa240507b 100644
> --- a/fs/erofs/ishare.h
> +++ b/fs/erofs/ishare.h
> @@ -9,6 +9,11 @@
>   #include <linux/spinlock.h>
>   #include "internal.h"
>   
> +struct erofs_read_ctx {
> +	struct file *file; /* may be NULL */
> +	struct inode *inode;
> +};
> +
>   #ifdef CONFIG_EROFS_FS_INODE_SHARE
>   
>   int erofs_ishare_init(struct super_block *sb);
> @@ -16,6 +21,13 @@ void erofs_ishare_exit(struct super_block *sb);
>   bool erofs_ishare_fill_inode(struct inode *inode);
>   void erofs_ishare_free_inode(struct inode *inode);
>   
> +/* read/readahead */
> +void erofs_read_begin(struct erofs_read_ctx *rdctx);
> +void erofs_read_end(struct erofs_read_ctx *rdctx);
> +
> +struct inode *erofs_ishare_iget(struct inode *inode);
> +void erofs_ishare_iput(struct inode *realinode);
> +
>   #else
>   
>   static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
> @@ -23,6 +35,12 @@ static inline void erofs_ishare_exit(struct super_block *sb) {}
>   static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
>   static inline void erofs_ishare_free_inode(struct inode *inode) {}
>   
> +static inline void erofs_read_begin(struct erofs_read_ctx *rdctx) {}
> +static inline void erofs_read_end(struct erofs_read_ctx *rdctx) {}
> +
> +static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
> +static inline void erofs_ishare_iput(struct inode *realinode) {}
> +
>   #endif // CONFIG_EROFS_FS_INODE_SHARE
>   
>   #endif
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index f067633c0072..cba3da383558 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -97,6 +97,7 @@ static void erofs_free_inode(struct inode *inode)
>   		erofs_free_dedup_inode(vi);
>   		return;
>   	}
> +	erofs_ishare_free_inode(inode);
>   	if (inode->i_op == &erofs_fast_symlink_iops)
>   		kfree(inode->i_link);
>   	kfree(vi->xattr_shared_xattrs);
> @@ -762,6 +763,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		return err;
>   
> +	err = erofs_ishare_init(sb);
> +	if (err)
> +		return err;
> +
>   	sbi->dir_ra_bytes = EROFS_DIR_RA_BYTES;
>   	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
>   	return 0;
> @@ -911,6 +916,7 @@ static void erofs_kill_sb(struct super_block *sb)
>   		kill_anon_super(sb);
>   	else
>   		kill_block_super(sb);
> +
>   	erofs_drop_internal_inodes(sbi);
>   	fs_put_dax(sbi->dif0.dax_dev, NULL);
>   	erofs_fscache_unregister_fs(sb);
> @@ -922,6 +928,7 @@ static void erofs_put_super(struct super_block *sb)
>   {
>   	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>   
> +	erofs_ishare_exit(sb);
>   	erofs_unregister_sysfs(sb);
>   	erofs_shrinker_unregister(sb);
>   	erofs_xattr_prefixes_cleanup(sb);


