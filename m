Return-Path: <linux-kernel+bounces-818431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE32B5919E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DCE1BC557B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8529B214;
	Tue, 16 Sep 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Q+E7CeTt"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F928CF42
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013343; cv=none; b=Ry1EIgszOpdzW87TT631FZN3YEWnS6Qy4HqhWkTBvO8Z3sV6/p3girV1JAzq6bKbQ9Ya96ilXpVTgUpcH9LevKH547M4/N6uLni3QjTVwXI9fkx9B4iM5uPnyme4RgcNt6vZ13vaevuUK7TiVolryVBTijtdNlj8dAdpX2+gwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013343; c=relaxed/simple;
	bh=0Vpn586g2Rf3xwgZqTtECSZVCszHpKgDLJcRU12/5Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xzi2/0n+W7t+44Fv2xAAgk8lGWQdJAA7ttlFfCC2kWstYIdWCM9cmbIgbVZcS1u8iCOuia/UtUbmpvM/gZ68V+vqpTL0CzyWR/qzc27h9WAaEpSzl1YbRSQ3YW8ERsybqqqLocd04xCDmbeLUfmzfYWYtk/NOwT7k8U1147QBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Q+E7CeTt; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=iH1qUO4aNBEKYkB0AJOgosv4x+Ue22Qn3EpBolYH968=;
	b=Q+E7CeTtkGNAvGVlgMcuKS3tjcgH6xoKhOBp3y4LlcFeZNyDJX+ZbrmkYRcjxhw2rosgWGy6u
	Sgn7r0OVEcD0AFTsNcsTPmvCV2xHpsrIfvr/sk2++lvLvKkHs30wJB89zvs92Amho2W26At0DXF
	hNaOMvf0hBOLRByzDF2Q7rQ=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cQwrF6ZhxzYl7XN;
	Tue, 16 Sep 2025 17:01:49 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 17:02:09 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 17:02:09 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Tue, 16 Sep 2025 17:02:09 +0800
Message-ID: <20250916090209.240852-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <71872583-0d81-48a4-a148-184963a24fd4@kernel.org>
References: <71872583-0d81-48a4-a148-184963a24fd4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a011.hihonor.com
 (10.68.31.243)

>On 9/16/25 16:26, wangzijie wrote:
>>> On 9/16/25 15:09, wangzijie wrote:
>>>>> On 9/16/25 13:22, wangzijie wrote:
>>>>>>> On 09/15, wangzijie wrote:
>>>>>>>> When we get wrong extent info data, and look up extent_node in rb tree,
>>>>>>>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>>>>>>>> return NULL.
>>>>>>>
>>>>>>> This is the exact buggy case which we should fix the original one. Have
>>>>>>> you seen this error? In that case, can we consider writing some kernel
>>>>>>> message and handle the error properly?
>>>>>>
>>>>>> Hi Jaegeuk,
>>>>>> The original one is the bug I mentioned in the first patch of this patch set
>>>>>> ("f2fs: fix zero-sized extent for precache extents"). 
>>>>>
>>>>> Zijie,
>>>>>
>>>>> Did you suffer this problem in product? right?
>>>>
>>>> Hi Chao,
>>>> Yes, and I can confirm that infinite loop cases I suffered are caused by the bug I
>>>> mentioned in the first patch of this patch set. But I'm not sure if there are
>>>> other cases that can cause this infinite loop.
>>>>
>>>>>>
>>>>>> When we use a wrong extent_info(zero-sized) to do update, and there exists a
>>>>>> extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
>>>>>> nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
>>>>>> which cause the infinite loop in __insert_extent_tree().
>>>>>>
>>>>>> So we can add f2fs_bug_on() when there occurs zero-sized extent
>>>>>> in f2fs_update_read_extent_cache_range(), and give up this zero-sized
>>>>>> extent update to handle other unknown buggy cases. Do you think this will be better?
>>>>>>
>>>>>> And do we need to solve this infinite loop?
>>>>>
>>>>> IMO, it's worth to end such loop if there is any corrupted extent in rbtree to
>>>>> avoid kernel hang, no matter it is caused by software bug or hardware flaw
>>>>> potentially.
>>>>>
>>>>> Thanks,
>>>>
>>>> And do you think we need this?
>>>> "add f2fs_bug_on() when there occurs zero-sized extent in f2fs_update_read_extent_cache_range(),
>>>> and give up this zero-sized extent update to handle other unknown buggy cases".
>>>
>>> Oh, I was testing below patch..., does this what you want to do?
>>>
>>> I think we can keep all your patches, and appending below patch to detect any
>>> potential cases who will update a zero-sized extent.
>>>
>>> >From 439d61ef3715fafa5c9f2d1b7f8026cdd2564ca7 Mon Sep 17 00:00:00 2001
>>> From: Chao Yu <chao@kernel.org>
>>> Date: Tue, 16 Sep 2025 11:52:30 +0800
>>> Subject: [PATCH] f2fs: add sanity check on ei.len in
>>> __update_extent_tree_range()
>>>
>>> Add a sanity check in __update_extent_tree_range() to detect any
>>> zero-sized extent update.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>> fs/f2fs/extent_cache.c | 9 +++++++++
>>> 1 file changed, 9 insertions(+)
>>>
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 199c1e7a83ef..9544323767be 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
>>> 	if (!et)
>>> 		return;
>>>
>>> +	if (unlikely(len == 0)) {
>>> +		f2fs_bug_on(sbi, 1);
>>> +		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
>>> +			"extent [%u, %u, %u], age [%llu, %llu]",
>>> +			__func__, type, tei->fofs, tei->blk, tei->len,
>>> +			tei->age, tei->last_blocks);
>>> +		return;
>>> +	}
>>> +
>>> 	if (type == EX_READ)
>>> 		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
>>> 						tei->blk, 0);
>>> -- 
>>> 2.49.0
>> 
>> Yes, that's exactly what I want to do.
>> Maybe we should relocate f2fs_bug_on()?
>> 
>> 	if (unlikely(len == 0)) {
>> 		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
>> 			"extent [%u, %u, %u], age [%llu, %llu]",
>> 			__func__, type, tei->fofs, tei->blk, tei->len,
>> 			tei->age, tei->last_blocks);
>> 		f2fs_bug_on(sbi, 1);
>> 		return;
>> 	}
>
>Yeah, looks better.
>
>I don't see any problem in my test, will send a formal patch, let me add
>Signed-off-by of you if you don't mind. :)
>
>Thanks,

OK, thanks for your help.

>> 
>>>>
>>>>
>>>>
>>>>>>
>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>>>>>> ---
>>>>>>>>  fs/f2fs/extent_cache.c | 1 +
>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>>>>> index 199c1e7a8..6ed6f3d1d 100644
>>>>>>>> --- a/fs/f2fs/extent_cache.c
>>>>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>>>>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>>>>>>  			leftmost = false;
>>>>>>>>  		} else {
>>>>>>>>  			f2fs_bug_on(sbi, 1);
>>>>>>>> +			return NULL;
>>>>>>>>  		}
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>> -- 
>>>>>>>> 2.25.1
>>>>
>> 

