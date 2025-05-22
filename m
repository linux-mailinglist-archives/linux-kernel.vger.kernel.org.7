Return-Path: <linux-kernel+bounces-659040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A53AC0AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972471891DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1C28982B;
	Thu, 22 May 2025 11:31:42 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9D1C32
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747913502; cv=none; b=aYcebVwq1MuBrEafPVaIxbVtcGQ/Cx5d2IpMxwpV0k4vWbnaXwd6wba2CpbibGkiB/n1Ag5xffPSOIoHc/bQDWhie4g3RLl0Ciun4gsikus0v7QxVNQPHyDeBHO51JuxlHn9CT50UUslwTXJq0968BvzHNMiMOGE8HKdpiKkjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747913502; c=relaxed/simple;
	bh=rXIIQdFF8vZ/5FOkeYUhJZfPrHTUkAYBsVb/5x//3UQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv26uSs0LzYb17/ImDa1nI03v9RlhKbgeqVHtXMUfX0D8a3e0/y3RrrUAEPmE6pahltyhgzW7UbvRKDyyrmUOwBojBA2BnrFzzUJy1uV8xqcPguDPNzS1W9wS4WWSSeaigiBcRNxI5oILBewKEH1K6gcu47sQuc/FeB6RzFWmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4b35fn0Rd6zYm66r;
	Thu, 22 May 2025 19:29:37 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 May
 2025 19:31:31 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 May
 2025 19:31:31 +0800
From: wangzijie <wangzijie1@honor.com>
To: <wangzijie1@honor.com>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<tao.wangtao@honor.com>, <wangqi13@honor.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs : add a ioctl to estimate compression gain
Date: Thu, 22 May 2025 19:31:30 +0800
Message-ID: <20250522113130.174200-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250522015244.4132723-1-wangzijie1@honor.com>
References: <20250522015244.4132723-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

>On 5/22/25 09:52, wangzijie wrote:
>> This patch add a ioctl to estimate compression gain. In user mode compression, users can define 
>> the interval between clusters for estimation sampling before compress and release ioctl to a file.
>> This can help users to decide whether to do compress in a fast way, especially for some large files.
>
>Zijie,
>
>Thanks for your contribution.
>
>But, have you considered estimating compression ratio in userspace,
>which may face less risk when there is bug in its implementation.
>Or you have a strong reason to do this in kernel?
>
>Thanks,

Hi Chao,
I think that we can use some existing kernel code(which will be used to
compress file later) to estimate compression gain directly, but I admit it's 
safer to do this in userspace, thank you for your suggestion.


>> 
>> Signed-off-by: wangqi <wangqi13@honor.com>
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> ---
>>  fs/f2fs/compress.c        | 107 ++++++++++++++++++++++++++++++++++++++
>>  fs/f2fs/f2fs.h            |   5 ++
>>  fs/f2fs/file.c            |  38 +++++++++++++-
>>  include/uapi/linux/f2fs.h |   8 +++
>>  4 files changed, 157 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 9b9481067..3fe160245 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1621,6 +1621,113 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>>  	return err;
>>  }
>>  
>> +int f2fs_estimate_compress(struct inode *inode,
>> +					struct f2fs_comp_estimate *estimate)
>> +{
>> +	unsigned long step, cluster_idx, nr_cluster;
>> +	block_t i, k;
>> +	pgoff_t page_idx;
>> +	int ret = 0;
>> +	__u64 saved_blocks = 0, compressible_clusters = 0;
>> +	struct page *page;
>> +	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, 0);
>> +	struct compress_ctx cc = {
>> +		.inode = inode,
>> +		.log_cluster_size = 0,
>> +		.cluster_size = 0,
>> +		.cluster_idx = NULL_CLUSTER,
>> +		.rpages = NULL,
>> +		.nr_rpages = 0,
>> +		.cpages = NULL,
>> +		.rbuf = NULL,
>> +		.cbuf = NULL,
>> +		.rlen = 0,
>> +		.private = NULL,
>> +	};
>> +
>> +	inode_lock_shared(inode);
>> +
>> +	cc.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
>> +	cc.cluster_size = F2FS_I(inode)->i_cluster_size;
>> +	cc.rlen = PAGE_SIZE * F2FS_I(inode)->i_cluster_size;
>> +
>> +	nr_cluster = (i_size_read(inode) + F2FS_BLKSIZE - 1) >>
>> +			(F2FS_BLKSIZE_BITS + cc.log_cluster_size);
>> +
>> +	if (!(nr_cluster >> (1 + estimate->log_sample_density))) {
>> +		ret = -EINVAL;
>> +		goto unlock_out;
>> +	}
>> +
>> +	if (f2fs_init_compress_ctx(&cc)) {
>> +		ret = -ENOMEM;
>> +		goto unlock_out;
>> +	}
>> +
>> +	step = nr_cluster >> estimate->log_sample_density;
>> +
>> +	for (cluster_idx = 0; cluster_idx < nr_cluster;
>> +		cluster_idx += step) {
>> +		page_idx = cluster_idx << F2FS_I(inode)->i_log_cluster_size;
>> +
>> +		if (f2fs_is_compressed_cluster(inode, page_idx))
>> +			continue;
>> +
>> +		ractl._index = page_idx;
>> +		page_cache_ra_unbounded(&ractl, cc.cluster_size, 0);
>> +
>> +		for (i = 0; i < cc.cluster_size; ++i) {
>> +			page = read_cache_page(inode->i_mapping, page_idx + i, NULL, NULL);
>> +			if (IS_ERR(page)) {
>> +				ret = PTR_ERR(page);
>> +				goto err_out;
>> +			}
>> +			f2fs_compress_ctx_add_page(&cc, page_folio(page));
>> +		}
>> +
>> +		ret = f2fs_compress_pages(&cc);
>> +		if (ret) {
>> +			if (ret == -EAGAIN)
>> +				goto free_rpages;
>> +			else
>> +				goto err_out;
>> +		}
>> +
>> +		saved_blocks += cc.cluster_size - cc.valid_nr_cpages;
>> +		compressible_clusters++;
>> +
>> +		for (k = 0; k < cc.nr_cpages; ++k) {
>> +			f2fs_compress_free_page(cc.cpages[k]);
>> +			cc.cpages[k] = NULL;
>> +		}
>> +
>> +		page_array_free(cc.inode, cc.cpages, cc.nr_cpages);
>> +free_rpages:
>> +		f2fs_put_rpages(&cc);
>> +		cc.nr_rpages = 0;
>> +		cc.cluster_idx = NULL_CLUSTER;
>> +	}
>> +
>> +	f2fs_destroy_compress_ctx(&cc, false);
>> +	inode_unlock_shared(inode);
>> +
>> +	estimate->saved_blocks = saved_blocks;
>> +	estimate->compressible_clusters = compressible_clusters;
>> +
>> +	if (ret == -EAGAIN)
>> +		ret = 0;
>> +
>> +	return ret;
>> +
>> +err_out:
>> +	f2fs_drop_rpages(&cc, i, 0);
>> +	f2fs_destroy_compress_ctx(&cc, false);
>> +
>> +unlock_out:
>> +	inode_unlock_shared(inode);
>> +	return ret;
>> +}
>> +
>>  static inline bool allow_memalloc_for_decomp(struct f2fs_sb_info *sbi,
>>  		bool pre_alloc)
>>  {
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index f1576dc6e..c0d3bd051 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -24,6 +24,7 @@
>>  #include <linux/quotaops.h>
>>  #include <linux/part_stat.h>
>>  #include <linux/rw_hint.h>
>> +#include <uapi/linux/f2fs.h>
>>  
>>  #include <linux/fscrypt.h>
>>  #include <linux/fsverity.h>
>> @@ -4448,6 +4449,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>>  						struct writeback_control *wbc,
>>  						enum iostat_type io_type);
>>  int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
>> +int f2fs_estimate_compress(struct inode *inode, struct f2fs_comp_estimate *estimate);
>>  bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index);
>>  void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>>  				pgoff_t fofs, block_t blkaddr,
>> @@ -4539,6 +4541,9 @@ static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
>>  static inline int f2fs_is_compressed_cluster(
>>  				struct inode *inode,
>>  				pgoff_t index) { return 0; }
>> +static inline int f2fs_estimate_compress(
>> +				struct inode *inode,
>> +				struct f2fs_comp_estimate *estimate) { return 0; }
>>  static inline bool f2fs_is_sparse_cluster(
>>  				struct inode *inode,
>>  				pgoff_t index) { return true; }
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index abbcbb586..befd58c70 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -33,7 +33,6 @@
>>  #include "gc.h"
>>  #include "iostat.h"
>>  #include <trace/events/f2fs.h>
>> -#include <uapi/linux/f2fs.h>
>>  
>>  static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>>  {
>> @@ -3525,6 +3524,40 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>>  	return 0;
>>  }
>>  
>> +static int f2fs_ioc_estimate_compress(struct file *filp, unsigned long arg)
>> +{
>> +	struct inode *inode = file_inode(filp);
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +	struct f2fs_comp_estimate estimate;
>> +	int ret = 0;
>> +
>> +	if (!f2fs_sb_has_compression(sbi) ||
>> +			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!f2fs_is_compress_backend_ready(inode))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!f2fs_compressed_file(inode) ||
>> +		is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(&estimate, (struct f2fs_comp_estimate __user *)arg,
>> +		sizeof(struct f2fs_comp_estimate)))
>> +		return -EFAULT;
>> +
>> +	ret = f2fs_estimate_compress(inode, &estimate);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (copy_to_user((struct f2fs_comp_estimate __user *)arg, &estimate,
>> +		sizeof(struct f2fs_comp_estimate)))
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>>  int f2fs_precache_extents(struct inode *inode)
>>  {
>>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>> @@ -4628,6 +4661,8 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  		return f2fs_ioc_get_dev_alias_file(filp, arg);
>>  	case F2FS_IOC_IO_PRIO:
>>  		return f2fs_ioc_io_prio(filp, arg);
>> +	case F2FS_IOC_ESTIMATE_COMPRESS:
>> +		return f2fs_ioc_estimate_compress(filp, arg);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> @@ -5347,6 +5382,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  	case F2FS_IOC_COMPRESS_FILE:
>>  	case F2FS_IOC_GET_DEV_ALIAS_FILE:
>>  	case F2FS_IOC_IO_PRIO:
>> +	case F2FS_IOC_ESTIMATE_COMPRESS:
>>  		break;
>>  	default:
>>  		return -ENOIOCTLCMD;
>> diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
>> index 795e26258..07c98985d 100644
>> --- a/include/uapi/linux/f2fs.h
>> +++ b/include/uapi/linux/f2fs.h
>> @@ -45,6 +45,8 @@
>>  #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
>>  #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
>>  #define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
>> +#define F2FS_IOC_ESTIMATE_COMPRESS	_IOR(F2FS_IOCTL_MAGIC, 28,	\
>> +						struct f2fs_comp_estimate)
>>  
>>  /*
>>   * should be same as XFS_IOC_GOINGDOWN.
>> @@ -104,4 +106,10 @@ struct f2fs_comp_option {
>>  	__u8 log_cluster_size;
>>  };
>>  
>> +struct f2fs_comp_estimate {
>> +	__u16 log_sample_density;
>> +	__u64 compressible_clusters;
>> +	__u64 saved_blocks;
>> +};
>> +
>>  #endif /* _UAPI_LINUX_F2FS_H */
>
>
>
>_______________________________________________
>Linux-f2fs-devel mailing list
>Linux-f2fs-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


