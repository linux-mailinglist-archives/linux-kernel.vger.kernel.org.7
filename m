Return-Path: <linux-kernel+bounces-725163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28004AFFB81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C51887061
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F528B507;
	Thu, 10 Jul 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNSlVgfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2E1E515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134347; cv=none; b=hz3eOvoZ6cJx9BN+LI60zwBkQC+Hu2XCucvJd44Xfgr8q4u7F6+j1SClIQS1gMICXH+k+NqAKUJe8vTUf2tNGDYH0tU5KR5CtVgB76m8j5a47ZJWH6TTE/rlywb1Q1JObUFPsE1TZgtmnvXtHJdP7iGq13e4DwGYbBsgbVAGzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134347; c=relaxed/simple;
	bh=8b54bDcLpykq7/jN9RXeM/Bx9RPEsuWayXBfpLBFqFM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W+ysKV/auFxtH0raHr8qtTvMWpUX8gTA50lbaeX2lcxCCNg4yhfvUg827f9LfloNkfYxkvVM5cs2lQBw/pSq3fuXN3oXKV/iXQ8Q9uzGmMO5KSfPy4um2v2CEyjYocZBxwCDvKnkpBqpKeHmjeB7vb/3+J2OoZtNbhKHr6He+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNSlVgfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F52C4CEF4;
	Thu, 10 Jul 2025 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134347;
	bh=8b54bDcLpykq7/jN9RXeM/Bx9RPEsuWayXBfpLBFqFM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fNSlVgfYPGH9Vy7/3YkzhYttzbfnbjAeeF+MUEiiS8pvd2kug5GBOeha04IBQajng
	 zgvXT3Ut8QGvsZCnnmLg2sOVX2PBGtuCRRF1Z3ZZZ+jNnhUCENk7G7ub2ll03zRL0L
	 EN8n6KYiCaNZlqyiGcCPImL0dV3HC4J/uh4noBiIZCA+vKhcanzUmony/Nxw8oMruh
	 FIw9hQhUXHwxBBEodh/deU7i8Jn8RkrHDM6dY3QNUnIY+1eOiA4Bsn6MWiWTVKujsM
	 n1cavEUa6e8tVXiaenvuB+fDjmh0re2/2OvBd1CZbrQsO2X6gbrFzj11yQr7GAtEK6
	 4wcAlBJ4lVPBw==
Message-ID: <2a2e0147-355b-4863-bcd7-6a227766f7b2@kernel.org>
Date: Thu, 10 Jul 2025 15:59:02 +0800
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
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <8cbaa76b-f6de-4242-bd6c-629980311f4a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/25 15:46, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/7/10 15:36, Chao Yu wrote:
>> This patch supports to readahead more blocks in erofs_readdir(),
>> it can enhance performance in large direcotry.
>>
>> readdir test in a large directory which contains 12000 sub-files.
>>
>>         files_per_second
>> Before:        926385.54
>> After:        2380435.562
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/erofs/dir.c      | 8 ++++++++
>>   fs/erofs/internal.h | 3 +++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index cff61c5a172b..04113851fc0f 100644
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
>>       int err = 0;
>>       bool initial = true;
>>   @@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           }
>>           cond_resched();
>>   +        /* readahead blocks to enhance performance in large directory */
>> +        if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
>> +            page_cache_sync_readahead(dir->i_mapping, ra, f,
>> +                dbstart, min(nr_pages - dbstart,
>> +                (pgoff_t)MAX_DIR_RA_PAGES));
>> +
>>           de = erofs_bread(&buf, dbstart, true);
>>           if (IS_ERR(de)) {
>>               erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index a32c03a80c70..ef9d1ee8c688 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>>   #define EROFS_I_BL_XATTR_BIT    (BITS_PER_LONG - 1)
>>   #define EROFS_I_BL_Z_BIT    (BITS_PER_LONG - 2)
>>   +/* maximum readahead pages of directory */
>> +#define MAX_DIR_RA_PAGES    4
> 
> Could we set it as a per-sb sysfs configuration for users to config?

Xiang,

Oh, that will be better, how about introducing new sysfs in separated patch?

Thanks,

> 
> Thanks,
> Gao Xiang


