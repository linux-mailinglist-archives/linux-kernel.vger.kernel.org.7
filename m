Return-Path: <linux-kernel+bounces-736192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04FB099EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621FE7B152F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBE1A3A80;
	Fri, 18 Jul 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RGZTGP1b"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337EB1624E9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752806770; cv=none; b=nAQ8ZpioTDArd2FSFGxbrVdYdqusowoFBbdyAV8Il/65n24hbM6OwWD6IizeajmvJPwxqotJrXZn4xHpHQXwYGfJCakjjlILp3le9rSP/qX/25JcdwH1fLS2nwd40dnsMgbNYnFj5nM4wqWKzF5sm3RwkJckSua+PqwGdacvUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752806770; c=relaxed/simple;
	bh=pZewbdrz4fw5Y4OOFSm39/eEOox6QQYpvYzjJL+sSvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InVHzH3Qayp+7NWx1ucyImd8z3c8ZQ9PBKohxnVzK7jTeCfpOinM+qWW2Aayfmdn0u0Q3fvqaTC5SL79JhSimoDZxfxjNwa95mIM9EBoi8+aeX+eIqUfnyYXCfNdRPT0cb747DFM4YMAOkcgjbF9ahGzbpv7bCjKDhzs7nDf0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RGZTGP1b; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752806755; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EVZgpGdH2j4OBof47AaTdebWfnsCMe/x2e5JdhT5ZMU=;
	b=RGZTGP1b2foG5mSuoxAfS58Wl4wUZhbwkErnW2HSNWiap6jO9BWBLyX8X2vtL+mCd9yXAcJXPWWAzMhsovh8SjnPU8QYdRcu1RcWmXL2FgrKJ0kidJt1FyGRYHS7rTwBSCvMNcVBbSFjqJiOxTnp7voEvoHTOFhoOR3M5qaR7oY=
Received: from 30.221.129.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjAiLZk_1752806753 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 10:45:54 +0800
Message-ID: <10bce97b-1a17-462f-aac3-af5b7847f670@linux.alibaba.com>
Date: Fri, 18 Jul 2025 10:45:53 +0800
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
 <631728e2-2808-47af-8db7-28cd8ae17622@linux.alibaba.com>
 <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <19ee5db7-814f-402b-9b06-586f7203977d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/18 09:52, Chao Yu wrote:
> Hi Xiang,
> 
> On 2025/7/17 16:26, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/7/14 17:39, Chao Yu wrote:
>>> This patch supports to readahead more blocks in erofs_readdir(), it can
>>> enhance readdir performance in large direcotry.
>>>
>>> readdir test in a large directory which contains 12000 sub-files.
>>>
>>>         files_per_second
>>> Before:        926385.54
>>> After:        2380435.562
>>>
>>> Meanwhile, let's introduces a new sysfs entry to control readahead
>>> bytes to provide more flexible policy for readahead of readdir().
>>> - location: /sys/fs/erofs/<disk>/dir_ra_bytes
>>> - default value: 16384
>>> - disable readahead: set the value to 0
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> v3:
>>> - add EROFS prefix for macro
>>> - update new sysfs interface to 1) use bytes instead of pages
>>> 2) remove upper boundary limitation
>>> - fix bug of pageidx calculation
>>>   Documentation/ABI/testing/sysfs-fs-erofs |  8 ++++++++
>>>   fs/erofs/dir.c                           | 13 +++++++++++++
>>>   fs/erofs/internal.h                      |  4 ++++
>>>   fs/erofs/super.c                         |  2 ++
>>>   fs/erofs/sysfs.c                         |  2 ++
>>>   5 files changed, 29 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ ABI/testing/sysfs-fs-erofs
>>> index bf3b6299c15e..85fa56ca092c 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-erofs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
>>> @@ -35,3 +35,11 @@ Description:    Used to set or show hardware accelerators in effect
>>>           and multiple accelerators are separated by '\n'.
>>>           Supported accelerator(s): qat_deflate.
>>>           Disable all accelerators with an empty string (echo > accel).
>>> +
>>> +What:        /sys/fs/erofs/<disk>/dir_ra_bytes
>>> +Date:        July 2025
>>> +Contact:    "Chao Yu" <chao@kernel.org>
>>> +Description:    Used to set or show readahead bytes during readdir(), by
>>> +        default the value is 16384.
>>> +
>>> +        - 0: disable readahead.
>>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>>> index 3e4b38bec0aa..950d6b0046f4 100644
>>> --- a/fs/erofs/dir.c
>>> +++ b/fs/erofs/dir.c
>>> @@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>       struct inode *dir = file_inode(f);
>>>       struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
>>>       struct super_block *sb = dir->i_sb;
>>> +    struct file_ra_state *ra = &f->f_ra;
>>>       unsigned long bsz = sb->s_blocksize;
>>>       unsigned int ofs = erofs_blkoff(sb, ctx->pos);
>>> +    unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
>>
>>      pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes);
> 
> Do you mean?
> 
> pgoff_t ra_pages = PAGE_ALIGN(EROFS_SB(dir)->dir_ra_bytes) >> PAGE_SHIFT?

That seems more complicated, sigh, I think the original
DIV_ROUND_UP_POW2() is better.

> 
>>
>>>       int err = 0;
>>>       bool initial = true;
>>> @@ -63,6 +65,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>>               break;
>>>           }
>>> +        /* readahead blocks to enhance performance in large directory */
>>> +        if (EROFS_I_SB(dir)->dir_ra_bytes) {
>  > >          if (ra_pages) {
>>
>>> +            unsigned long idx = DIV_ROUND_UP(ctx->pos, PAGE_SIZE);
>>> +            pgoff_t ra_pages = DIV_ROUND_UP(
>>> +                EROFS_I_SB(dir)->dir_ra_bytes, PAGE_SIZE);
> 
> I put calculation here because if the value is zero, we don't need unnecessary calculation above, anyway, will update as you suggested, but let me know if you have any other concerns. :)

If only shift calculatiion is needed, I guess it
should not have much overhead, like:

		if (ra_pages) {
			pgoff_t idx = DIV_ROUND_UP_POW2(ctx->pos, PAGE_SIZE);
			pgoff_t pages = min(nr_pages - idx, ra_pages);

			...

Thanks,
Gao Xiang

