Return-Path: <linux-kernel+bounces-738635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACDB0BB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9761897477
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B412F41;
	Mon, 21 Jul 2025 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCgoyB/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE52C181
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067781; cv=none; b=t3IV0Tb+SC+vZMnG6Rvh13qnQfDcaj8S7MumCWqaR8hRrG0JeLNMZCBq+1Me0nxO7KM5T45mF+135eSO5TGnteGgSVRivFMlXHsL8ZYBHoZyRiIQuh18wZNH2rDTckA3Bcsx+CDqq7zoSYB17xT/7bLzSkx9WwM0B4NNL7ynBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067781; c=relaxed/simple;
	bh=Nw5seF9MEuTiXjenbHZetewAcRt6dVK+T1m7D8mi55o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rWhTv7NbzD3Cfuj6EBYNtigidbFUjQzpy9zxfbVkqUPf3l8sFZH59IpJitAKcgPkS8mXJv0X9+1IHkeBriUqouMZxEDvKPIKIy4yEzM9buFQTd1qvHCsF59LLHi6m12ZkvtutIisb4PDV9YK9SnGwb1BZDCPGQoSoQ+IIzkeDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCgoyB/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F4C4CEE7;
	Mon, 21 Jul 2025 03:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753067780;
	bh=Nw5seF9MEuTiXjenbHZetewAcRt6dVK+T1m7D8mi55o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=oCgoyB/aaQ8DLJ+mYs4v/2103iPAE62a9RHCFTaZNsGmEYABYmPkhyorCrp0XnIfz
	 v2vl9VU+vljvsmIHtblflE1CdZuqOIaxTij2NZbFjzxXfM2Ycqszuma7HyOuqlsrDz
	 0SjUAWhAgQBL1osZ59uRBSEbeo4HzLm4IjUHwIN8LyomgAabgN6Jk0H+RMeJB2Nihm
	 r9k10CVM05fBFn4XQOnNtNGXscg7BfW/iOrA36h/ll9hmSkqqIBSDLqILTv3Zc+mLZ
	 msp58fUzfO9SEGFC+L/hLxfqQb6uK6kZWcFLaoUqxBMipLijA9Qt64OS75n7wAWZ1+
	 5rUhLWuniej/g==
Message-ID: <e2aeb886-cb45-4f75-aaf9-7f0855b3a87a@kernel.org>
Date: Mon, 21 Jul 2025 11:16:16 +0800
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
Subject: Re: [PATCH v4] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250721021352.2495371-1-chao@kernel.org>
 <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <085b2e3f-223f-4867-9fac-99cf7cb2fa21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 10:24, Gao Xiang wrote:
> 
> 
> On 2025/7/21 10:13, Chao Yu wrote:
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
>> v4:
>> - clean up codes and comments
>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>   fs/erofs/dir.c                           | 14 ++++++++++++++
>>   fs/erofs/internal.h                      |  4 ++++
>>   fs/erofs/super.c                         |  2 ++
>>   fs/erofs/sysfs.c                         |  2 ++
>>   5 files changed, 30 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
>> index bf3b6299c15e..85fa56ca092c 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware accelerators in effect
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
>> index 3e4b38bec0aa..99745c272b60 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -47,8 +47,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>       struct inode *dir = file_inode(f);
>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>       struct super_block *sb = dir->i_sb;
>> +    struct file_ra_state *ra = &f->f_ra;
>>       unsigned long bsz = sb->s_blocksize;
>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>> +    pgoff_t ra_pages = DIV_ROUND_UP_POW2(
>> +            EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
>> +    pgoff_t nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>       int err = 0;
>>       bool initial = true;
>>   @@ -63,6 +67,16 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>               break;
>>           }
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (ra_pages) {
>> +            pgoff_t idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
> 
> Can we use DIV_ROUND_UP_POW2 here too? If it's okay,
> I will update the patch manually when applied.

Xiang,

Yeah, looks fine to me.

Please go ahead to update it while applying, thanks for your help. :)

Thanks,

> 
> Otherwise it looks good to me,
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang


