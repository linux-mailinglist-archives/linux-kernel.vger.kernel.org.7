Return-Path: <linux-kernel+bounces-818362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B52B59098
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227ED322C74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78112EAB85;
	Tue, 16 Sep 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="LoY39Hbh"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20441FBC92
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011208; cv=none; b=ZwAGg2Ao2p5qv5m4oJ/chymavJ268mo2SZl8+U6dWVr6OpfFfY5cY6oJ50dxbsMOeFblz8/ufTapOHJ73DniiVE5bOacWanEZJT30doM/6yUkgvFR5B0tzmDgIPyJpDY9tABlZTy9HMbLQ3SBWqZvhAjeTRqnoz+t1eIhmpeyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011208; c=relaxed/simple;
	bh=IgPF4Nuwe0xYIk3jktrMRmXoet6gjSUxaBDW7cqXw+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNqG1q1un/M3BqRuHxp14XywIxolvonLNQvY8TVQxvv+ibEr6SKklSZxazPmFMEoiriFqsiJElrLp6S8S/rgcu3+qvumnFt1qaGwQqYIgQk8PWPJ4pKyXtK+o7O1UrvO2hTD/e4S0KDCFR7csu7bmCIz8x4MPTqGIMsXN3EjBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=LoY39Hbh; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=CXV1ap17rYGQE0rfqZtUMLXQoKATnSSIIdYcmnSwgaU=;
	b=LoY39HbhIKF7BvVVgbHlkDwVJA4JuuqjXWIt5nI1gQTOjyA3UVRPrt3bKvCXe735GsKy58XAy
	uVH1qPSrbm1qisBi+nnFIkwOl5YHUDGmvireyBEGlZkT6LYutips4DJpCjhERHEpllAINfUItd1
	H8bnFz/0NcDvj2awScH7Jq4=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cQw3F54SVzYl1nk;
	Tue, 16 Sep 2025 16:26:17 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 16:26:37 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 16:26:37 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Tue, 16 Sep 2025 16:26:36 +0800
Message-ID: <20250916082636.237935-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <62d7f4d3-cc9c-429f-8b7e-0e80e2aa24e4@kernel.org>
References: <62d7f4d3-cc9c-429f-8b7e-0e80e2aa24e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

>On 9/16/25 15:09, wangzijie wrote:
>>> On 9/16/25 13:22, wangzijie wrote:
>>>>> On 09/15, wangzijie wrote:
>>>>>> When we get wrong extent info data, and look up extent_node in rb tree,
>>>>>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>>>>>> return NULL.
>>>>>
>>>>> This is the exact buggy case which we should fix the original one. Have
>>>>> you seen this error? In that case, can we consider writing some kernel
>>>>> message and handle the error properly?
>>>>
>>>> Hi Jaegeuk,
>>>> The original one is the bug I mentioned in the first patch of this patch set
>>>> ("f2fs: fix zero-sized extent for precache extents"). 
>>>
>>> Zijie,
>>>
>>> Did you suffer this problem in product? right?
>> 
>> Hi Chao,
>> Yes, and I can confirm that infinite loop cases I suffered are caused by the bug I
>> mentioned in the first patch of this patch set. But I'm not sure if there are
>> other cases that can cause this infinite loop.
>> 
>>>>
>>>> When we use a wrong extent_info(zero-sized) to do update, and there exists a
>>>> extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
>>>> nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
>>>> which cause the infinite loop in __insert_extent_tree().
>>>>
>>>> So we can add f2fs_bug_on() when there occurs zero-sized extent
>>>> in f2fs_update_read_extent_cache_range(), and give up this zero-sized
>>>> extent update to handle other unknown buggy cases. Do you think this will be better?
>>>>
>>>> And do we need to solve this infinite loop?
>>>
>>> IMO, it's worth to end such loop if there is any corrupted extent in rbtree to
>>> avoid kernel hang, no matter it is caused by software bug or hardware flaw
>>> potentially.
>>>
>>> Thanks,
>> 
>> And do you think we need this?
>> "add f2fs_bug_on() when there occurs zero-sized extent in f2fs_update_read_extent_cache_range(),
>> and give up this zero-sized extent update to handle other unknown buggy cases".
>
>Oh, I was testing below patch..., does this what you want to do?
>
>I think we can keep all your patches, and appending below patch to detect any
>potential cases who will update a zero-sized extent.
>
>>From 439d61ef3715fafa5c9f2d1b7f8026cdd2564ca7 Mon Sep 17 00:00:00 2001
>From: Chao Yu <chao@kernel.org>
>Date: Tue, 16 Sep 2025 11:52:30 +0800
>Subject: [PATCH] f2fs: add sanity check on ei.len in
> __update_extent_tree_range()
>
>Add a sanity check in __update_extent_tree_range() to detect any
>zero-sized extent update.
>
>Signed-off-by: Chao Yu <chao@kernel.org>
>---
> fs/f2fs/extent_cache.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>index 199c1e7a83ef..9544323767be 100644
>--- a/fs/f2fs/extent_cache.c
>+++ b/fs/f2fs/extent_cache.c
>@@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
> 	if (!et)
> 		return;
>
>+	if (unlikely(len == 0)) {
>+		f2fs_bug_on(sbi, 1);
>+		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
>+			"extent [%u, %u, %u], age [%llu, %llu]",
>+			__func__, type, tei->fofs, tei->blk, tei->len,
>+			tei->age, tei->last_blocks);
>+		return;
>+	}
>+
> 	if (type == EX_READ)
> 		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
> 						tei->blk, 0);
>-- 
>2.49.0

Yes, that's exactly what I want to do.
Maybe we should relocate f2fs_bug_on()?

	if (unlikely(len == 0)) {
		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
			"extent [%u, %u, %u], age [%llu, %llu]",
			__func__, type, tei->fofs, tei->blk, tei->len,
			tei->age, tei->last_blocks);
		f2fs_bug_on(sbi, 1);
		return;
	}

>> 
>> 
>> 
>>>>
>>>>
>>>>>>
>>>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>>>> ---
>>>>>>  fs/f2fs/extent_cache.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>>> index 199c1e7a8..6ed6f3d1d 100644
>>>>>> --- a/fs/f2fs/extent_cache.c
>>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>>>>  			leftmost = false;
>>>>>>  		} else {
>>>>>>  			f2fs_bug_on(sbi, 1);
>>>>>> +			return NULL;
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>> -- 
>>>>>> 2.25.1
>> 


