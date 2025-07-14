Return-Path: <linux-kernel+bounces-729444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278EB036BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E7C1898317
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624F1F9F70;
	Mon, 14 Jul 2025 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc00x9l0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352042E3706
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473810; cv=none; b=AgsSQsM/oYmBvLD7Zv2Zd+xdpMnVf+VxpGenzHGvh9Myvj+/WZxrwvMFPPoCOoFSGAtfng45TnceAUtLBaOwUg+IUtbPD+QijgB3hLU9lcw3OYMmqZB6o1m0hyRC+dzq9c4IQFaSYXu6yqC0Ka5uwo+oWgYh3HgvQyUSffE9QDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473810; c=relaxed/simple;
	bh=O1ETop01ZN4d5gek3Oou4+1OB0vTZhVUxDynTVNMEKc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YYpXWM/PJkmAba7aYBQ5PWxy+KDmWQhHt+hCdKBeTrH/sGo75Bq7wurz5K10b3yaOYqyCmhoe9uHEeL27DQe83xvXvdGmKKkEVsRcr7nlc+gCE4zcwS01h0J3q2cTanwRkk3gjlUwg/QngmbOP+AX4XvJSpLOYn6jUmqAFVVPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc00x9l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB17C4CEED;
	Mon, 14 Jul 2025 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752473809;
	bh=O1ETop01ZN4d5gek3Oou4+1OB0vTZhVUxDynTVNMEKc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uc00x9l0EljpdB8lJRkz50kRPsfI6l3awnDj16Ws14K8mHJUP+CXInlCLXS84KFLm
	 LnzLTv18Z+VxbTU0CWE5mr7fYJKEiPAbNWrdM82rKuXz4VgkuiY79Q1JJ68jlzAYXf
	 I5sBzZbHCQjK6godwwG41FYg9e2yZWhzhyql14OCAGuUq2iQRW62dbcSCpmvWtk9EI
	 4a+GG/Qq09baxDLaBgua4gDW5IYlYSO5NbHv/en3lehokiew/1EMW5rKh6etKS9f3x
	 3MQgTS/KgxV3YfXYmTNrMEmuxDkLbD9/wW/EuvO5l5zWYIFuA3JXrmRztPA7XxUNlE
	 sHNLUlkAsxu4A==
Message-ID: <6a501e5f-880e-4dc6-a984-b2406b54daa9@kernel.org>
Date: Mon, 14 Jul 2025 14:16:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v2 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250714033450.58298-1-chao@kernel.org>
 <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <dcb197e7-8dea-4bd2-9344-b753c10c534d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/25 11:49, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/14 11:34, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(), it can
>> enhance readdir performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Meanwhile, let's introduces a new sysfs entry to control page count
>> of readahead to provide more flexible policy for readahead of readdir().
>> - location: /sys/fs/erofs/<disk>/dir_ra_pages
>> - default value: 4
>> - range: [0, 128]
>> - disable readahead: set the value to 0
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - introduce sysfs node to control page count of readahead during
>> readdir().
>>   Documentation/ABI/testing/sysfs-fs-erofs | 7 +++++++
>>   fs/erofs/dir.c                           | 9 +++++++++
>>   fs/erofs/internal.h                      | 5 +++++
>>   fs/erofs/super.c                         | 2 ++
>>   fs/erofs/sysfs.c                         | 5 +++++
>>   5 files changed, 28 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..500c93484e4c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,10 @@ Description:    Used to set or show hardware accelerators in effect
>>           and multiple accelerators are separated by '\n'.
>>           Supported accelerator(s): qat_deflate.
>>           Disable all accelerators with an empty string (echo > accel).
>> +
>> +What:        /sys/fs/erofs/<disk>/dir_ra_pages
>> +Date:        July 2025
>> +Contact:    "Chao Yu" <chao@kernel.org>
>> +Description:    Used to set or show page count of readahead during readdir(),
>> +        the range of value is [0, 128], by default it is 4, set it to
>> +        0 to disable readahead.
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 3e4b38bec0aa..40f828d5b670 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
> 
> why using DIV_ROUND_UP_POW2 rather than DIV_ROUND_UP here?

Seems DIV_ROUND_UP_POW2() doesn't use bit shift as expected, let
me use DIV_ROUND_UP() instead.

> 
>>       int err = 0;
>>       bool initial = true;
>>   @@ -63,6 +65,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>               break;
>>           }
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (EROFS_I_SB(dir)->dir_ra_pages && nr_pages - dbstart > 1 &&
> 
> dbstart is a byte-oriented value, so I'm not sure if it
> works as you expect..

Oh, I checked patch in 6.6, found that I missed to handle it correctly
when porting code to upstream, let me fix this.

> 
>> +            !ra_has_index(ra, dbstart))
>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>> +                dbstart, min(nr_pages - dbstart,
> 
> same here.
> 
>> +                (pgoff_t)EROFS_I_SB(dir)->dir_ra_pages));
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 0d19bde8c094..f0e5b4273aa8 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>>       /* sysfs support */
>>       struct kobject s_kobj;        /* /sys/fs/erofs/<devname> */
>>       struct completion s_kobj_unregister;
>> +    unsigned int dir_ra_pages;
>>         /* fscache support */
>>       struct fscache_volume *volume;
>> @@ -238,6 +239,10 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>   +/* default/maximum readahead pages of directory */
>> +#define DEFAULT_DIR_RA_PAGES    4
>> +#define MAX_DIR_RA_PAGES    128
> 
> better to add EROFS_ prefix for them.
> 
> Also could we setup those blocks or bytes instead
> of pages?
> 
> If users would like to setup values, they may don't
> care more the page size since they only care about
> images.

Let's use bytes, and then roundup to blksize?

> 
> Also why do we limit maximum number even if users
> would like to readahead more? (such as fadvise
> allows -1 too)

No test, but I suspect there is border effect even we set it to
i_size.

Anyway, let me remove the upper boundary limitation, unless there
is further requirement of limitation.

Thanks,

> 
> Thanks,
> Gao Xiang
> 


