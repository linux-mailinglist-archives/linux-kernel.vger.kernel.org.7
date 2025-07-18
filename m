Return-Path: <linux-kernel+bounces-736150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BEB0996E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336F3A422BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C219E98C;
	Fri, 18 Jul 2025 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2/DsdGy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C818CC1D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803548; cv=none; b=le1g8BlqhZTbYfDUmP4Bhh1YbClT+bXlRXdcd1wUfjvxEJNwgOt2N5tItJW3CkGTlOyMTbxNZt5HqHQvVvTk3JY64HbeVRAOWUHz0SSjrXUoefVPxcROPQForqCEESzLhK7Lb5v6bZMnKVNdZyCGG7ak/qb0LTR39L9WZhMIPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803548; c=relaxed/simple;
	bh=DZenHan6HEdNoDKIaO8bmG2IU9oiW+D1QihQoYGhJXg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DpuIFaUiXoO/D5e3VZ4aTnPBtax1JdTz5fVyxN9q1Tdw3z4FJYkFsgdTiHkTj5Ji9KKH60mAP2xZPFbrz9a58u7/qD9UxR/JSY+6jLA/OKBLW3gxjoqCSu2k+TWj8OFs/gtvvw1IsFak3HxLRDQF08uxBpqdPJ56z+U3xxHg09o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2/DsdGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC7C4CEF0;
	Fri, 18 Jul 2025 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752803548;
	bh=DZenHan6HEdNoDKIaO8bmG2IU9oiW+D1QihQoYGhJXg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A2/DsdGy+8I0YzRpiNgnIjuPrIBym2QcTh+RuEGoEgLHHPcPOkS24qqFV38HuikYx
	 EjSWY2er6PPZF/4uxznCqxgIe0QvKoaXtt6mMBGHlUZOluUe3p4PX7gI3hoKAWASfc
	 IAwhcijBQXe0siBt7s+OmhUqNNgjo2cbK5rCAGwaR0bOJzI68PdTjuFdTgxC3rsIp+
	 BZK/OSrFMKH2Y+pzsGN9w1V347fN1YMyYyR/PAF2x63JCvroyUEnf3mzjMQf2NLDoe
	 CV0aeIhBlopPAiBIAbHNLT6QuKJdY1Fu1LDzKzYo3szS9WrvdGQ1wS+AdKknkvjgf/
	 buEk//nXvkFdQ==
Message-ID: <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
Date: Fri, 18 Jul 2025 09:52:21 +0800
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
Subject: Re: [PATCH v3] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250714093935.200749-1-chao@kernel.org>
 <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xiang,

On 2025/7/17 16:26, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/14 17:39, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(), it can
>> enhance readdir performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Meanwhile, let's introduces a new sysfs entry to control readahead
>> bytes to provide more flexible policy for readahead of readdir().
>> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
>> - default value: 16384
>> - disable readahead: set the value to 0
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - add EROFS prefix for macro
>> - update new sysfs interface to 1) use bytes instead of pages
>> 2) remove upper boundary limitation
>> - fix bug of pageidx calculation
>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>   fs/erofs/dir.c                           | 13 +++++++++++++
>>   fs/erofs/internal.h                      |  4 ++++
>>   fs/erofs/super.c                         |  2 ++
>>   fs/erofs/sysfs.c                         |  2 ++
>>   5 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ 
>> ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..85fa56ca092c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware 
>> accelerators in effect
>>           and multiple accelerators are separated by '\n'.
>>           Supported accelerator(s): qat_deflate.
>>           Disable all accelerators with an empty string (echo > accel).
>> +
>> +What:        /sys/fs/erofs/<disk>/dir_ra_bytes
>> +Date:        July 2025
>> +Contact:    "Chao Yu" <chao@kernel.org>
>> +Description:    Used to set or show readahead bytes during readdir(), by
>> +        default the value is 16384.
>> +
>> +        - 0: disable readahead.
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 3e4b38bec0aa..950d6b0046f4 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
> 
>      pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);

Do you mean?

pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes) >> PAGE_SHIFT?

> 
>>       int err = 0;
>>       bool initial = true;
>> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct 
>> dir_context *ctx)
>>               break;
>>           }
>> +        /* readahead blocks to enhance performance in large directory */
>> +        if (EROFS_I_SB(dir)->dir_ra_bytes) {
 > >          if (ra_pages) {
> 
>> +            unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
>> +            pgoff_t ra_pages = DIV_ROUND_UP(
>> +                EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);

I put calculation here because if the value is zero, we don't need 
unnecessary calculation above, anyway, will update as you suggested, but 
let me know if you have any other concerns. :)

> 
>              pgoff_t idx = PAGE_ALIGN(ctx->pos);

Ditto,

Thanks,

>              pgoff_t pages = min(nr_pages - idx, ra_pages);
> 
>> +
>> +            if (nr_pages - idx > 1 && !ra_has_index(ra, idx))
> 
>              if (pages > 1 && !ra_has_index(ra, idx))
>                  page_cache_sync_readahead(dir->i_mapping, ra,
>                                f, idx, pages)?
> 
> 
>> +                page_cache_sync_readahead(dir->i_mapping, ra,
>> +                    f, idx, min(nr_pages - idx, ra_pages));
>> +        }
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu 
>> of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 0d19bde8c094..4399b9332307 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -157,6 +157,7 @@ struct erofs_sb_info {
>>       /* sysfs support */
>>       struct kobject s_kobj;        /* /sys/fs/erofs/<devname> */
>>       struct completion s_kobj_unregister;
>> +    erofs_off_t dir_ra_bytes;
>>       /* fscache support */
>>       struct fscache_volume *volume;
>> @@ -238,6 +239,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, 
>> COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>> +/* default readahead size of directory */
> 
> /* default readahead size of directories */
> 
> Otherwise it looks good to me.
> 
> Thanks,
> Gao Xiang
> 
>> +#define EROFS_DIR_RA_BYTES    16384


