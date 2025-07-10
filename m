Return-Path: <linux-kernel+bounces-725178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A004AFFBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E7564408A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB128B4E0;
	Thu, 10 Jul 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vBWPQgaF"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16335242D71
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134648; cv=none; b=Y8UBQnA+Ee6yeJTIZO4wO7rI/Uzukq6+AFviCG0fHZRt0KTSWLnfLZAKgGraMWMDvspBp1d7FaB3J6rvBY0F7Knseza8vOPgoNSLxK2pSdjlDCAG7N+1N6x7/hoUMUDUmzoYenFuJw1uI2TY95cvsnaOyLne3BdtXN6UGNc+GWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134648; c=relaxed/simple;
	bh=gTUMRqPqJQw01B697+1SHEycrA0BHNZFuiCeAPdvebA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBYCT+5F0Os2vp8GGkxV4u2FnS2X0yp8EPp1QXZRzjV+jryju4KffgBYeWJUFBQvzL3gPA5sE+jkUcHVWE/DeUl+DYND0svRDfdONuqmoeZn1sEgW/fSiOQ0R2hJEQhTtyUVrjK8FFRSCvdCitBa0R5bpxdGxZsV3grAPFgDa4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vBWPQgaF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752134642; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w4lLUVSdrHauf9evUjus6KQO1VLwt7Ma9ZazUSCtCmA=;
	b=vBWPQgaF2men60J0Lt9OH18FniO6f8C5Hk30lFeVBJ1Y+mVgZFRDtQsuqCV1xwVoXHAmqb6xQTMbrwkihcsmidwWYunGveTlgL5DIQXMgN0zgVHBS41wAuMJHVYcB8f7CwHk/S/AECwxbQjjntTeKLGv9H5xi/v4p4GGEdalaVI=
Received: from 30.221.128.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wic9qR9_1752134641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 16:04:01 +0800
Message-ID: <c0e0b8ed-13b6-41a4-b978-ff4b8f5b2634@linux.alibaba.com>
Date: Thu, 10 Jul 2025 16:04:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: support to readahead dirent blocks in
 erofs_readdir()
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20250710073619.4083422-1-chao@kernel.org>
 <20250710073619.4083422-2-chao@kernel.org>
 <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
 <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/10 15:59, Chao Yu wrote:
> On 7/10/25 15:46, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/7/10 15:36, Chao Yu wrote:
>>> This patch supports to readahead more blocks in erofs_readdir(),
>>> it can enhance performance in large direcotry.
>>>
>>> readdir test in a large directory which contains 12000 sub-files.
>>>
>>>          files_per_second
>>> Before:        926385.54
>>> After:        2380435.562
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/erofs/dir.c      | 8 ++++++++
>>>    fs/erofs/internal.h | 3 +++
>>>    2 files changed, 11 insertions(+)
>>>
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index cff61c5a172b..04113851fc0f 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>        struct inode *dir = file_inode(f);
>>>        struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>        struct super_block *sb = dir->i_sb;
>>> +    struct file_ra_state *ra = &f->f_ra;
>>>        unsigned long bsz = sb->s_blocksize;
>>>        unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>>        int err = 0;
>>>        bool initial = true;
>>>    @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>            }
>>>            cond_resched();
>>>    +        /* readahead blocks to enhance performance in large directory */
>>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>>> +                dbstart, min(nr_pages - dbstart,
>>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>>> +
>>>            de = erofs_bread(&buf, dbstart, true);
>>>            if (IS_ERR(de)) {
>>>                erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index a32c03a80c70..ef9d1ee8c688 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>>    #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>>    #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>>    +/* maximum readahead pages of directory */
>>> +#define MAX_DIR_RA_PAGES    4
>>
>> Could we set it as a per-sb sysfs configuration for users to config?
> 
> Xiang,
> 
> Oh, that will be better, how about introducing new sysfs in separated patch?

Hi Chao,

Thanks for your interest but in that case it could cause some bisect
issue anyway, could we just use one patch to add this optimization
for slow devices?

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
> 


