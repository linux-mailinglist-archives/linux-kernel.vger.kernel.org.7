Return-Path: <linux-kernel+bounces-818251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF35B58ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94997188E91C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE12E5405;
	Tue, 16 Sep 2025 07:09:52 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCB2E424F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006592; cv=none; b=pjZFteFIRAJQHKQizLxd63vuUHl1H01J/a9Hsad59EGNBJgBv8qWY0zcJ2VGNYGqK5ifFdY37vVI0QOwdO6mewRgKZL1FkG/76C3qXC2O38al9gn+0O45+1MTj5Vu3OIHl1kjx9FuCVIle63aHEIXEf+iR1eJiTGmZEHYWmJfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006592; c=relaxed/simple;
	bh=Zon/91plCCvXXk/Fy6FS3vH6KSbhp4Y0Zf5toJPv1Y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQq8P6pR7ZWt6SQve4ekNZQvI7NYje1vhMmAQ1PLlh4kZEmohN2NOXWTBBkI8jXC/4yk1en17LKCx5saPZHM5v9yys1OcWl0TCd+jjZQxo0v/KaTPWQq7GJw1X7WtPu7WdaumtPxGiYKVPFltdj09dVNgGJuq2uKAA+BT/CaaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cQtLN5P1BzYlv4M;
	Tue, 16 Sep 2025 15:09:16 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 15:09:46 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 15:09:46 +0800
From: wangzijie <wangzijie1@honor.com>
To: <chao@kernel.org>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Tue, 16 Sep 2025 15:09:46 +0800
Message-ID: <20250916070946.231825-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f6b74555-f10c-4a8e-8caa-1797a3d7a7cf@kernel.org>
References: <f6b74555-f10c-4a8e-8caa-1797a3d7a7cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

>On 9/16/25 13:22, wangzijie wrote:
>>> On 09/15, wangzijie wrote:
>>>> When we get wrong extent info data, and look up extent_node in rb tree,
>>>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>>>> return NULL.
>>>
>>> This is the exact buggy case which we should fix the original one. Have
>>> you seen this error? In that case, can we consider writing some kernel
>>> message and handle the error properly?
>> 
>> Hi Jaegeuk,
>> The original one is the bug I mentioned in the first patch of this patch set
>> ("f2fs: fix zero-sized extent for precache extents"). 
>
>Zijie,
>
>Did you suffer this problem in product? right?

Hi Chao,
Yes, and I can confirm that infinite loop cases I suffered are caused by the bug I
mentioned in the first patch of this patch set. But I'm not sure if there are
other cases that can cause this infinite loop.

>> 
>> When we use a wrong extent_info(zero-sized) to do update, and there exists a
>> extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
>> nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
>> which cause the infinite loop in __insert_extent_tree().
>> 
>> So we can add f2fs_bug_on() when there occurs zero-sized extent
>> in f2fs_update_read_extent_cache_range(), and give up this zero-sized
>> extent update to handle other unknown buggy cases. Do you think this will be better?
>> 
>> And do we need to solve this infinite loop?
>
>IMO, it's worth to end such loop if there is any corrupted extent in rbtree to
>avoid kernel hang, no matter it is caused by software bug or hardware flaw
>potentially.
>
>Thanks,

And do you think we need this?
"add f2fs_bug_on() when there occurs zero-sized extent in f2fs_update_read_extent_cache_range(),
and give up this zero-sized extent update to handle other unknown buggy cases".



>> 
>> 
>>>>
>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>> ---
>>>>  fs/f2fs/extent_cache.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>> index 199c1e7a8..6ed6f3d1d 100644
>>>> --- a/fs/f2fs/extent_cache.c
>>>> +++ b/fs/f2fs/extent_cache.c
>>>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>>  			leftmost = false;
>>>>  		} else {
>>>>  			f2fs_bug_on(sbi, 1);
>>>> +			return NULL;
>>>>  		}
>>>>  	}
>>>>  
>>>> -- 
>>>> 2.25.1


