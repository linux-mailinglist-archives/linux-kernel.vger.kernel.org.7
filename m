Return-Path: <linux-kernel+bounces-797567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D913B411F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076E11B61D01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A7B1B983F;
	Wed,  3 Sep 2025 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6Erysx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC313C8FF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863202; cv=none; b=bh9GyTCuhcDpGzqb6E8VBFMdMYap9zPwy/pFUlQWdMsyHiYSjN7cK6kNVRni2jY1M/rj+HdrRH/QVvfKELj/AuoMECyDUpK15U3oH29oZy2O0kFOeoE4wHusdXdrBUQnI4m3RdRelgMeKwK0dueKbo+0lOb76NP1Zsufoe/pEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863202; c=relaxed/simple;
	bh=b37So3j2iYeAd1OR2qYhYUiZfHzafcrukdWRQBjhpms=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dtXvF9WbzEsYV8brzMW6kiq55XOl9wweVWt3LTt7s3dcwsjnN6Eu3eR/fJHPcumF7RASmWAsxms0Qci+hsy6R95Kw4qhp8MpAnsOrgvAgCvTKvrc1jPzgf28OjHHJSvRLI8VtFuKmb244aIZ54II3kr/I7voQCgNCRJijTq9IoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6Erysx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BE8C4CEED;
	Wed,  3 Sep 2025 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863202;
	bh=b37So3j2iYeAd1OR2qYhYUiZfHzafcrukdWRQBjhpms=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=T6Erysx2EfgdNWpSAjSuRn+ri//0/IeUcbCaBHwDDedaSLOZImkBPn7I5yLWs5hiK
	 +gf4Y/XTXUq2rP52Jz9F4kcFp3v3m5DueB00JlOs4vz535r0j8+ww3tFxrP4dxR2hh
	 uuKdxg8wIziTBeIccsWHV5RP5kPAwfXQeuzHBWyK04zjvcHXIz8x6QftaQKZplYxDA
	 jz0s29WIuYg85XwC5l6rdBqW6s+3sJkb/FEhJWzotjhDh1PZbT0cnDvilMcOgX+YUT
	 6i98BhqTsfC0NOIrwN4F22keIoU0NC0oif4pFp2Pni20Av1RyRHKeBFgaclO03NEfh
	 RaokkT3WceZKg==
Message-ID: <e44dc335-dfe1-45ba-8bac-9c5f7a5f24d7@kernel.org>
Date: Wed, 3 Sep 2025 09:33:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid migrating empty section
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250901020416.2172182-1-chao@kernel.org>
 <CAHJ8P3+NJfE+F-Tsbw4Rz6PyT9o2F74kyrJncLqyQv+YeOSvgA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+NJfE+F-Tsbw4Rz6PyT9o2F74kyrJncLqyQv+YeOSvgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/25 08:04, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年9月1日周一 10:08写道：
>>
>> It reports a bug from device w/ zufs:
>>
>> F2FS-fs (dm-64): Inconsistent segment (173822) type [1, 0] in SSA and SIT
>> F2FS-fs (dm-64): Stopped filesystem due to reason: 4
>>
>> Thread A                                Thread B
>> - f2fs_expand_inode_data
>>  - f2fs_allocate_pinning_section
>>   - f2fs_gc_range
>>    - do_garbage_collect w/ segno #x
>>                                         - writepage
>>                                          - f2fs_allocate_data_block
>>                                           - new_curseg
>>                                            - allocate segno #x
>>
>> The root cause is: fallocate on pinning file may race w/ block allocation
>> as above, result in do_garbage_collect() from fallocate() may migrate
>> segment which is just allocated by a log, the log will update segment type
>> in its in-memory structure, however GC will get segment type from on-disk
>> SSA block, once segment type changes by log, we can detect such
>> inconsistency, then shutdown filesystem.
>>
>> In this case, on-disk SSA shows type of segno #173822 is 1 (SUM_TYPE_NODE),
>> however segno #173822 was just allocated as data type segment, so in-memory
>> SIT shows type of segno #173822 is 0 (SUM_TYPE_DATA).
>>
>> Change as below to fix this issue:
>> - check whether current section is empty before gc
>> - add sanity checks on do_garbage_collect() to avoid any race case, result
>> in migrating segment used by log.
>> - btw, it fixes misc issue in printed logs: "SSA and SIT" -> "SIT and SSA".
>>
>> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
>> Cc: Daeho Jeong <daehojeong@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/gc.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index ed3acbfc83ca..a7708cf80c04 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -1794,6 +1794,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>                 struct folio *sum_folio = filemap_get_folio(META_MAPPING(sbi),
>>                                         GET_SUM_BLOCK(sbi, segno));
>>
>> +               if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
>> +                       f2fs_err(sbi, "%s: segment %u is used by log",
>> +                                                       __func__, segno);
>> +                       f2fs_bug_on(sbi, 1);
> Hi Chao,
> Do we need f2fs_bug_on here?  or it is enough to skip current segno
> and let gc continue?

Zhiguo,

I think we should never select in-use segment as GC victim, so I add a
f2fs_bug_on() here to detect any potential bugs. Let's see what will we
find w/ this.

Thanks,

> Thanks!
>> +                       goto skip;
>> +               }
>> +
>>                 if (get_valid_blocks(sbi, segno, false) == 0)
>>                         goto freed;
>>                 if (gc_type == BG_GC && __is_large_section(sbi) &&
>> @@ -1805,7 +1812,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>
>>                 sum = folio_address(sum_folio);
>>                 if (type != GET_SUM_TYPE((&sum->footer))) {
>> -                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
>> +                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SIT and SSA",
>>                                  segno, type, GET_SUM_TYPE((&sum->footer)));
>>                         f2fs_stop_checkpoint(sbi, false,
>>                                 STOP_CP_REASON_CORRUPTED_SUMMARY);
>> @@ -2068,6 +2075,13 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>>                         .iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
>>                 };
>>
>> +               /*
>> +                * avoid migrating empty section, as it can be allocated by
>> +                * log in parallel.
>> +                */
>> +               if (!get_valid_blocks(sbi, segno, true))
>> +                       continue;
>> +
>>                 if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno)))
>>                         continue;
>>
>> --
>> 2.49.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


