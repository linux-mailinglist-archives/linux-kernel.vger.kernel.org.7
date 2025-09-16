Return-Path: <linux-kernel+bounces-818235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B1B58E94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24441BC207A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21182777F3;
	Tue, 16 Sep 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnjHAgWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B52248B9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005199; cv=none; b=SsVi7NyzRgkGHqcq9yHSXzrr+kKrH4hbMOL1eMBkN/+RoHIM7/s2/njFDWR+9iKxcD5ZWJFO5LdN0+jtxuqMl5u9GzejDHkJ0ni0iOmgIvUk8v7Aw9o1rFjMnx4KrqJNogHCKJ2xAyi+TsTDK6X422uI54iYcd7kFxzFVKLFb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005199; c=relaxed/simple;
	bh=UyM89QNHpSkF9EPdMvI0ufnD9cqqHBkKnIr4Bp93Jls=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P2OyNE80x/MfEvaW1KKntx/a/O3hfXhHg587nuvlGYjJtAgFG3H4uu7ZNBoPcGnSxDdHhkUpxan34LBvDN+X5t7bSq+6Mrs8HJNBmSymyVMfKvHhvz4OyQEXr8/sk+SdmgUELoR2Jq4w/0v2uDnNEHzvqwAqnaRuVoZW820tomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnjHAgWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16336C4CEEB;
	Tue, 16 Sep 2025 06:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758005197;
	bh=UyM89QNHpSkF9EPdMvI0ufnD9cqqHBkKnIr4Bp93Jls=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MnjHAgWHPS7HptB1RfjVSZIclIB093kS0ElAzTzDMc/EYx4FMTRlwipSOo+BDwFDQ
	 9JaGDVv5hD3Xyrd17dsEhFpASZYAtK0K0VvpvF08RZSyqlyAZzHGjTp2+Ora+3eeet
	 DR02tnIhboy18qriLoMpcwhrEftELgG/jgoArTBlLvU1TuqWfSi+JvqZowNf018mCI
	 zjaQGcpSRn/F3d7uFyY4i70NHPVrhiEDs8N45FXWVLepXEWs6fdSalNjng8GClmAtC
	 AU8SPUTO4Otx3SR69mbOKJCsS17w9tsQCy4YQQw3YqjGAj3pIk/c8CfNOTrgcCKqO+
	 l4cMG1RJk9onA==
Message-ID: <f6b74555-f10c-4a8e-8caa-1797a3d7a7cf@kernel.org>
Date: Tue, 16 Sep 2025 14:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, bintian.wang@honor.com, feng.han@honor.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <aMjJwkQ3wQ0uNJXX@google.com>
 <20250916052224.223500-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250916052224.223500-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 13:22, wangzijie wrote:
>> On 09/15, wangzijie wrote:
>>> When we get wrong extent info data, and look up extent_node in rb tree,
>>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>>> return NULL.
>>
>> This is the exact buggy case which we should fix the original one. Have
>> you seen this error? In that case, can we consider writing some kernel
>> message and handle the error properly?
> 
> Hi Jaegeuk,
> The original one is the bug I mentioned in the first patch of this patch set
> ("f2fs: fix zero-sized extent for precache extents"). 

Zijie,

Did you suffer this problem in product? right?

> 
> When we use a wrong extent_info(zero-sized) to do update, and there exists a
> extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
> nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
> which cause the infinite loop in __insert_extent_tree().
> 
> So we can add f2fs_bug_on() when there occurs zero-sized extent
> in f2fs_update_read_extent_cache_range(), and give up this zero-sized
> extent update to handle other unknown buggy cases. Do you think this will be better?
> 
> And do we need to solve this infinite loop?

IMO, it's worth to end such loop if there is any corrupted extent in rbtree to
avoid kernel hang, no matter it is caused by software bug or hardware flaw
potentially.

Thanks,

> 
> 
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>> ---
>>>  fs/f2fs/extent_cache.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 199c1e7a8..6ed6f3d1d 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>  			leftmost = false;
>>>  		} else {
>>>  			f2fs_bug_on(sbi, 1);
>>> +			return NULL;
>>>  		}
>>>  	}
>>>  
>>> -- 
>>> 2.25.1


