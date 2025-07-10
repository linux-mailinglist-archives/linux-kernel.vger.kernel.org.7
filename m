Return-Path: <linux-kernel+bounces-725160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75276AFFB78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602741C84072
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E728B7DA;
	Thu, 10 Jul 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgbShvcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1A1E515
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134254; cv=none; b=UN8P8yUmE82e+P1j2RTZnhXeWKyOVEP1CDRd7XWnX6VwBJpM0jhoMz34m3Wx/NfVh8/pcDIEA0t1po8KB7m5VFvckCMvSVB4zsBl3Ud5g82xGj+mU+kxWM960o2g1gmKr5f/jxWQD1G6hmqrpllQm3CC/ZrL7iD3NB6T9JZrkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134254; c=relaxed/simple;
	bh=cAeUtFb3ky7Chu1n9ZZZex7UIBdgbdVUpkxMm4VhNqM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jH6Xl3BP66sRuZ/WEOR/l5OIWaZJl0k66/uXPcyvGH36yB4AsQJrVEV0nHyvH1BeybE1EWYe96QGksRa2bUcXweziHUGSAmErVsv2Un4Qq3rzl7S3VKAYZGctio/LEkkuJOY66kzXOh9phxll7z0wj2I62lRnhfyyQND+fJrSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgbShvcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BE3C4CEE3;
	Thu, 10 Jul 2025 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134253;
	bh=cAeUtFb3ky7Chu1n9ZZZex7UIBdgbdVUpkxMm4VhNqM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kgbShvcsa8ZNyWyTxSzRh/P1oUVvjSbgcBlyHA2lGTkkKqidSoC/SLIX7b0TAWnBd
	 CJ3KTs3F7IQKiC5j9ssWPw98NS/hGwEqP3j6ctAGVAHCzMNv04Qrv7Bs4W5TyuD7fj
	 kDyj91eP0ua12mCe8pg3W4u7aUP8X0qtPr3x3wjQj75gk4Lv1U7K62aMSdbSABKYIW
	 WTyqW8nOWNZOxIwqot5pqSdvBLObhD1ILd+YLvyUKU+9HingUUS9emle9+lozpAb1x
	 YtQ7zdU09gOsj4QISIy/URfgoJQ7UYSxBj+vVMAmkbFPSnU0GrC97lkSBTIbZ7204Z
	 GMdevoMvMeEEg==
Message-ID: <156d89fd-7880-4d78-a7b1-d928fbe1a5cf@kernel.org>
Date: Thu, 10 Jul 2025 15:57:29 +0800
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
Subject: Re: [PATCH 1/2] erofs: allow readdir() to be interrupted
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250710073619.4083422-1-chao@kernel.org>
 <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a4ab45c9-b3d2-4807-954d-1bd7d38b7242@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/25 15:41, Gao Xiang wrote:
> 
> 
> On 2025/7/10 15:36, Chao Yu wrote:
>> In a quick slow device, readdir() may loop for long time in large
>> directory, let's give a chance to allow it to be interrupted by
>> userspace.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
>> ---
>>   fs/erofs/dir.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index 2fae209d0274..cff61c5a172b 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -58,6 +58,13 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           struct erofs_dirent *de;
>>           unsigned int nameoff, maxsize;
>>   +        /* allow readdir() to be interrupted */
> 
> Hi Chao,
> 
> It seems that comment is unnecessary since the following code
> is obvious, if you have no objection I will remove this
> comment when applying.

Xiang, sure, no problem. :)

Thanks,

> 
> Thanks,
> Gao Xiang


