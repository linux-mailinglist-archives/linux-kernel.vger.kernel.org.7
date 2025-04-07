Return-Path: <linux-kernel+bounces-590352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5432A7D208
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA9F188BA26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 02:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F0212F94;
	Mon,  7 Apr 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMr+NpO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A1A8F60
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991874; cv=none; b=KW5N5Pm6z6eCZpOXkwNbT/IJiMjqu3U7e3ZaB2sIVbGEf2hqNf150KNZ2MCOOlhwrBWX5CBF8nWPEk92vaSZIJD9WhdVqibyWet/POLHy+snxpHh7j+pmZcV/Y4IRPPsq+pwIgTOJgkWEz1Zg5MzE+Qbdw4bvICAmWq4yk3XGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991874; c=relaxed/simple;
	bh=DU2v1Weg3kqbG34VlRjX5pwsMXKz6VDkV0AjhbIo3fY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TZPZ8MqXr7LjnsJwLahZFU6BH6gkL+V5PZLcm8VJ7mmezs6rnWQjNCiaaEpBv4wLBOBs+AiOjV+sOToHPiFuZZNo7dJRz4iCHPDW+f/WJHLeX2Jh4CaTu9OxIClLOfI7qA402/p99NxrXxE3TBSLJlihrWaFbNgfrH6aEjqRzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMr+NpO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F73C4CEE3;
	Mon,  7 Apr 2025 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743991873;
	bh=DU2v1Weg3kqbG34VlRjX5pwsMXKz6VDkV0AjhbIo3fY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sMr+NpO7Kv1pPnomvFzVvSJ7uuWF6cslbsJW/pPoaR7xQH5Ms5/bc16oFY1TPDDZ9
	 6Qc8ZTX+rVi2o6W862HD6PXV1QruDs69HAsm6PqU43nIIX2ONTEIm5UQtBcxjGbT0M
	 CpGBQBAKqeqy86+xk6wWdV5Bp+MMGqe2NcpJ3jXBFCuoTyUJHH8oImwc8Xz7N3dBCz
	 nVqKF/85R/FIHKgr+DZbAku0DgyDLkA97hpmYbhVEiFryLBXvKvCAAM5d4S2RGCgaV
	 bIUtVFj1FvdYAnAT2xQnD3qROpf73zIl1A5IOfI9q93ME7ej0RUFXROaJu1/nTq5kn
	 0BL9asl2YrFIg==
Message-ID: <87056483-6cf8-4b2e-82f1-dcda31a28afd@kernel.org>
Date: Mon, 7 Apr 2025 10:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, pilhyun.kim@sk.com
Subject: Re: [PATCH v5] f2fs: prevent the current section from being selected
 as a victim during GC
To: "yohan.joung" <yohan.joung@sk.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250403232107.2960-1-yohan.joung@sk.com>
 <Z_A5SWl1ueMTZxV0@google.com>
 <7059eada-a51d-4f68-b62a-0f2c89c9b01c@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <7059eada-a51d-4f68-b62a-0f2c89c9b01c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 10:08, Chao Yu wrote:
> On 4/5/25 03:55, Jaegeuk Kim wrote:
>> Hi Yohan,
>>
>> I modified this patch after applying the clean up by
>>
>> https://lore.kernel.org/linux-f2fs-devel/20250404195442.413945-1-jaegeuk@kernel.org/T/#u
>>
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -486,6 +486,11 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
>>
>>         free_i->free_sections++;
>>
>> +       if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[BG_GC]) == secno)
>> +               sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
>> +       if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[FG_GC]) == secno)
>> +               sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Oh, can we add Fixes line to make it to be merged into stable kernel?

Thanks,

> 
> Thanks,
> 
>> +
>>  unlock_out:
>>         spin_unlock(&free_i->segmap_lock);
>>  }
>>
>> On 04/04, yohan.joung wrote:
>>> When selecting a victim using next_victim_seg in a large section, the
>>> selected section might already have been cleared and designated as the
>>> new current section, making it actively in use.
>>> This behavior causes inconsistency between the SIT and SSA.
>>>
>>> F2FS-fs (dm-54): Inconsistent segment (70961) type [0, 1] in SSA and SIT
>>> Call trace:
>>> dump_backtrace+0xe8/0x10c
>>> show_stack+0x18/0x28
>>> dump_stack_lvl+0x50/0x6c
>>> dump_stack+0x18/0x28
>>> f2fs_stop_checkpoint+0x1c/0x3c
>>> do_garbage_collect+0x41c/0x271c
>>> f2fs_gc+0x27c/0x828
>>> gc_thread_func+0x290/0x88c
>>> kthread+0x11c/0x164
>>> ret_from_fork+0x10/0x20
>>>
>>> issue scenario
>>> segs_per_sec=2
>>> - seg#0 and seg#1 are all dirty
>>> - all valid blocks are removed in seg#1
>>> - gc select this sec and next_victim_seg=seg#0
>>> - migrate seg#0, next_victim_seg=seg#1
>>> - checkpoint -> sec(seg#0, seg#1)  becomes free
>>> - allocator assigns sec(seg#0, seg#1) to curseg
>>> - gc tries to migrate seg#1
>>>
>>> Signed-off-by: yohan.joung <yohan.joung@sk.com>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>  fs/f2fs/segment.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 0465dc00b349..0773283babfa 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -474,8 +474,15 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
>>>  		next = find_next_bit(free_i->free_segmap,
>>>  				start_segno + SEGS_PER_SEC(sbi), start_segno);
>>>  		if (next >= start_segno + usable_segs) {
>>> -			if (test_and_clear_bit(secno, free_i->free_secmap))
>>> +			if (test_and_clear_bit(secno, free_i->free_secmap)) {
>>>  				free_i->free_sections++;
>>> +
>>> +				if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[BG_GC]) == secno)
>>> +					sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
>>> +
>>> +				if (GET_SEC_FROM_SEG(sbi, sbi->next_victim_seg[FG_GC]) == secno)
>>> +					sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
>>> +			}
>>>  		}
>>>  	}
>>>  skip_free:
>>> -- 
>>> 2.33.0
> 


