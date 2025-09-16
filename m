Return-Path: <linux-kernel+bounces-818173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C41BB58DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DED2A3136
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47827C869;
	Tue, 16 Sep 2025 05:22:36 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1C823DD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000155; cv=none; b=ivw5pYhh+/rk1B7ntkAAFkPwkBe1wV93P4EEKhREYpUZ9zoYjdLP1MwkS+wbQItzAyoaSKYag18URlYA/eXgx5g4S8CPU0YIrehqs9WrpXO9KTr67hWEFgR+QZ3FJOLF7DDeF/9CG8xL1NESXKhzFRUpZh3epqCtNV0CyQN4qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000155; c=relaxed/simple;
	bh=vKjlbUqm5ITD2/iG0cIALeEjQ/FVazibK53TpXylZTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYYdY3l1vahMlBmUlPimNgV+YlQTPV3IYEfgz+zzGYHtxLRx+wQl5X3DDRGGeLPUfn1+BpP/NUj6vtx7Q3fb5VXVO149NCcLpAOrMxz5Scrg15o49PbRvw7AwEOaQLK4CEznOxqa6kxtxcyuBDQSS2jVyWNjld2F8XRuf27iYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cQqyV4KhrzYlYmg;
	Tue, 16 Sep 2025 13:21:54 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 13:22:24 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 13:22:24 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>
CC: <bintian.wang@honor.com>, <chao@kernel.org>, <feng.han@honor.com>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: fix infinite loop in __insert_extent_tree()
Date: Tue, 16 Sep 2025 13:22:24 +0800
Message-ID: <20250916052224.223500-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aMjJwkQ3wQ0uNJXX@google.com>
References: <aMjJwkQ3wQ0uNJXX@google.com>
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

>On 09/15, wangzijie wrote:
>> When we get wrong extent info data, and look up extent_node in rb tree,
>> it will cause infinite loop (CONFIG_F2FS_CHECK_FS=n). Avoiding this by
>> return NULL.
>
>This is the exact buggy case which we should fix the original one. Have
>you seen this error? In that case, can we consider writing some kernel
>message and handle the error properly?

Hi Jaegeuk,
The original one is the bug I mentioned in the first patch of this patch set
("f2fs: fix zero-sized extent for precache extents"). 

When we use a wrong extent_info(zero-sized) to do update, and there exists a
extent_node which has same fofs as the wrong one, we will skip "invalidate all extent
nodes in range [fofs, fofs + len - 1]"(en->ei.fofs = end = tei->fofs + tei->len = tei->fofs),
which cause the infinite loop in __insert_extent_tree().

So we can add f2fs_bug_on() when there occurs zero-sized extent
in f2fs_update_read_extent_cache_range(), and give up this zero-sized
extent update to handle other unknown buggy cases. Do you think this will be better?

And do we need to solve this infinite loop?


>> 
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> ---
>>  fs/f2fs/extent_cache.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 199c1e7a8..6ed6f3d1d 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -605,6 +605,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>  			leftmost = false;
>>  		} else {
>>  			f2fs_bug_on(sbi, 1);
>> +			return NULL;
>>  		}
>>  	}
>>  
>> -- 
>> 2.25.1

