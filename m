Return-Path: <linux-kernel+bounces-818265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7638B58F20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E92B1B220FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA82E36FB;
	Tue, 16 Sep 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCwihVVo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8889265CAB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007714; cv=none; b=Lmp+mQxNnn4HJWYItX95bLl/dUAT70oyFc8GFtJXcKX58ViydtvDvinh6gJ3jceAjSVa7Xot98psVikNdaJ5cXdThoTwraEsFu6qQ1RJnPK/gmvU1UgC2Gb5SYAcJKCLudi73npI3/uuIdHPlN5sm0roy6P+4pN3mWOV5IxyYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007714; c=relaxed/simple;
	bh=DYAXQCcr75Fy8fYpNafpW9dWhyLeE+JscgT1dXk3NdM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fr2pjoLOGoFvlqwVL5qZ3egnfIm1JyIAg4Ae7tbke28Qxlc8pnHTPl5ZZ+U861nG4njW+UvUZZPnvxA53mQ2j7BShy1bCY0DFFLB57Ijut2aiSYwDLALU4J2QsWvm1XqnJxbsWw2HncPx4ggujSt7HPx/jQlhDlDBKgySnOMhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCwihVVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D972FC4CEEB;
	Tue, 16 Sep 2025 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758007714;
	bh=DYAXQCcr75Fy8fYpNafpW9dWhyLeE+JscgT1dXk3NdM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RCwihVVoCEMEZy0QGLPEtqnRHMl82oj9JD8ScaARQCN0K9DldLxgZA8aBies5hi+d
	 UxPaq7mnGqY7VeTOhp/vVLvY6x4nr79Ci3X/WXjDS1W/FotCWusHE27z/hIa0nv/LP
	 2n2Kxh8Le6D8wYrJPKf5QpjhZn3AYjJgvDuVaF3Fj0WR+h7wIlPK1GqP19pygXIqI2
	 gbIlELwW4kNxAW0Bhl28z8XWiJTpFOtcotgUpKGz9grO8M6aq1zc7EwOITUm1DZPqB
	 +MS9+/GjR3dtUfWjXRA6qyIXipHdDUZ0DHOM67CgliII5V8HIioPkJHWC3SsYAVaOz
	 qYuxMoRn+EdqA==
Message-ID: <62d7f4d3-cc9c-429f-8b7e-0e80e2aa24e4@kernel.org>
Date: Tue, 16 Sep 2025 15:28:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, bintian.wang@honor.com, feng.han@honor.com,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in
 __insert_extent_tree()
To: wangzijie <wangzijie1@honor.com>
References: <f6b74555-f10c-4a8e-8caa-1797a3d7a7cf@kernel.org>
 <20250916070946.231825-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250916070946.231825-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 15:09, wangzijie wrote:
>> On 9/16/25 13:22, wangzijie wrote:
>>>> On 09/15, wangzijie wrote:
>>>>> When we get wrong extent info data, and look up extent_node in rb tree,
>>>>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>>>>> return NULL.
>>>>
>>>> This is the exact buggy case which we should fix the original one. Have
>>>> you seen this error? In that case, can we consider writing some kernel
>>>> message and handle the error properly?
>>>
>>> Hi Jaegeuk,
>>> The original one is the bug I mentioned in the first patch of this patch set
>>> ("f2fs: fix zero-sized extent for precache extents"). 
>>
>> Zijie,
>>
>> Did you suffer this problem in product? right?
> 
> Hi Chao,
> Yes, and I can confirm that infinite loop cases I suffered are caused by the bug I
> mentioned in the first patch of this patch set. But I'm not sure if there are
> other cases that can cause this infinite loop.
> 
>>>
>>> When we use a wrong extent_info(zero-sized) to do update, and there exists a
>>> extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
>>> nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
>>> which cause the infinite loop in __insert_extent_tree().
>>>
>>> So we can add f2fs_bug_on() when there occurs zero-sized extent
>>> in f2fs_update_read_extent_cache_range(), and give up this zero-sized
>>> extent update to handle other unknown buggy cases. Do you think this will be better?
>>>
>>> And do we need to solve this infinite loop?
>>
>> IMO, it's worth to end such loop if there is any corrupted extent in rbtree to
>> avoid kernel hang, no matter it is caused by software bug or hardware flaw
>> potentially.
>>
>> Thanks,
> 
> And do you think we need this?
> "add f2fs_bug_on() when there occurs zero-sized extent in f2fs_update_read_extent_cache_range(),
> and give up this zero-sized extent update to handle other unknown buggy cases".

Oh, I was testing below patch..., does this what you want to do?

I think we can keep all your patches, and appending below patch to detect any
potential cases who will update a zero-sized extent.

From 439d61ef3715fafa5c9f2d1b7f8026cdd2564ca7 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Tue, 16 Sep 2025 11:52:30 +0800
Subject: [PATCH] f2fs: add sanity check on ei.len in
 __update_extent_tree_range()

Add a sanity check in __update_extent_tree_range() to detect any
zero-sized extent update.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/extent_cache.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 199c1e7a83ef..9544323767be 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (!et)
 		return;

+	if (unlikely(len == 0)) {
+		f2fs_bug_on(sbi, 1);
+		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
+			"extent [%u, %u, %u], age [%llu, %llu]",
+			__func__, type, tei->fofs, tei->blk, tei->len,
+			tei->age, tei->last_blocks);
+		return;
+	}
+
 	if (type == EX_READ)
 		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
 						tei->blk, 0);
-- 
2.49.0


> 
> 
> 
>>>
>>>
>>>>>
>>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>>> ---
>>>>>  fs/f2fs/extent_cache.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>> index 199c1e7a8..6ed6f3d1d 100644
>>>>> --- a/fs/f2fs/extent_cache.c
>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>>>  			leftmost = false;
>>>>>  		} else {
>>>>>  			f2fs_bug_on(sbi, 1);
>>>>> +			return NULL;
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> -- 
>>>>> 2.25.1
> 


