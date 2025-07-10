Return-Path: <linux-kernel+bounces-725741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB1B0031F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0297BFE56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054325760;
	Thu, 10 Jul 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeKZX4sK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10E17993
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153320; cv=none; b=dF9+2nmJTdUbAg9NOvXLIs/w98fagdomYk1DiYdBX06pP7QMIB0f3dVpfsCv7tdndDFqH17MqbfzeFfGLs0MS2KQ2/3aBkX3obR+/8JPDcTs1zQ4/MpjVtb6EIm8uPgIXFjUwuWnegRssPyDsGIABabp7vfS/c4fMnc2ro6SRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153320; c=relaxed/simple;
	bh=pvunt5eG5jjQjrQBbk3om39+1F4Hjs2yoeH3t0iPqo4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nZNioNL2Tf2E/w6NUveW2VAz75EYAcGyJL1F44ZI+NgVnjg8yPgGERLuxDcaK+79dy4Tuvo60YrCpMrSgJk4dIBF/V0yYT5pAftuaUnq0yoOfC0XyIfeIB8ud429xPZa7/lyh8p63N/Bfj4zY8b+51DU9aGKmRIs9GUGSrkJmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeKZX4sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256FAC4CEE3;
	Thu, 10 Jul 2025 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153317;
	bh=pvunt5eG5jjQjrQBbk3om39+1F4Hjs2yoeH3t0iPqo4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HeKZX4sK3OuQnuSdf3xL0o30Oa3B5fsldNuYpBE/8IbNGfgcfBDtLVPNItPY8Lzj+
	 bPMv4O+GGDFLHrLdQbzi59IHRT30uXh0T2499MEljGPtYMnEdfsDtsojRTSNVWv5tl
	 DUIRkL3K2dfb/wU+nYcq5wbbkYQ5p8YlWYxrvO5BBjf17yM9onBlSNAmuu734fZDfS
	 f3ftR2pHzEd8oN1/mcuV7D1ySQGCxT8sDIQbvDEfb0WqpJo0QrITKpTQAg/fQM962i
	 upemzxKkx/sKYNPJ01/QO39piSxYOJCCGQ1tGwX5umlkYnuChVVTkvKU+/PJTpG8og
	 h+wMe9tXVePvg==
Message-ID: <2d772d8b-1314-4af6-b17a-b5f09acbf25b@kernel.org>
Date: Thu, 10 Jul 2025 21:15:10 +0800
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
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
 <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
 <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
 <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/25 16:04, Gao Xiang wrote:
> 
> 
> On 2025/7/10 15:59, Chao Yu wrote:
>> On 7/10/25 15:46, Gao Xiang wrote:
>>> Hi Chao,
>>>
>>> On 2025/7/10 15:36, Chao Yu wrote:
>>>> This patch supports to readahead more blocks in erofs_readdir(),
>>>> it can enhance performance in large direcotry.
>>>>
>>>> readdir test in a large directory which contains 12000 sub-files.
>>>>
>>>>          files_per_second
>>>> Before:        926385.54
>>>> After:        2380435.562
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/erofs/dir.c      | 8 ++++++++
>>>>    fs/erofs/internal.h | 3 +++
>>>>    2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>>> index cff61c5a172b..04113851fc0f 100644
>>>> --- a/fs/erofs/dir.c
>>>> +++ b/fs/erofs/dir.c
>>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>>        struct inode *dir = file_inode(f);
>>>>        struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>>        struct super_block *sb = dir->i_sb;
>>>> +    struct file_ra_state *ra = &f->f_ra;
>>>>        unsigned long bsz = sb->s_blocksize;
>>>>        unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>>>        int err = 0;
>>>>        bool initial = true;
>>>>    @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>>            }
>>>>            cond_resched();
>>>>    +        /* readahead blocks to enhance performance in large directory */
>>>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>>>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>>>> +                dbstart, min(nr_pages - dbstart,
>>>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>>>> +
>>>>            de = erofs_bread(&buf, dbstart, true);
>>>>            if (IS_ERR(de)) {
>>>>                erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>>> index a32c03a80c70..ef9d1ee8c688 100644
>>>> --- a/fs/erofs/internal.h
>>>> +++ b/fs/erofs/internal.h
>>>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>>    #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>>>    #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>>>    +/* maximum readahead pages of directory */
>>>> +#define MAX_DIR_RA_PAGES    4
>>>
>>> Could we set it as a per-sb sysfs configuration for users to config?
>>
>> Xiang,
>>
>> Oh, that will be better, how about introducing new sysfs in separated patch?
> 
> Hi Chao,
> 
> Thanks for your interest but in that case it could cause some bisect
> issue anyway, could we just use one patch to add this optimization
> for slow devices?

Xiang,

Yeah, one patch includes all these looks fine to me, anyway, let me update v2.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>
> 


