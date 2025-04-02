Return-Path: <linux-kernel+bounces-584621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4DA78961
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E2B188465B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4920D4E4;
	Wed,  2 Apr 2025 08:00:30 +0000 (UTC)
Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8899C2F5A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580830; cv=none; b=d5Z+EopgDa5ONjppSl1aNpriNiybxfiR93oG9ouLgjjhPyQaYtzYvkm7ixh04jotxgFlXOpwZFgVnDPACpWBcdf/R6scQLW4ukpwp5NBGbE9+lQ5846BpEUFtavrlkeNC3TDgnsKNbTEkezy9GZgkEs3vbtoR9F4mLncQ7VAmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580830; c=relaxed/simple;
	bh=AKGE9aNPGK4LwH5V7m/8gGinPFqVG7I+LuXuQjfxaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwnfjqDUHThMqcxET1FnkvLNlvy/FOhnlAs1okU0wJm445kpHo8BRYBqsBK2mwvyTUwPHbRRn9q6mQjJnlVniQm1BhvoYQw9Vs8DkVfAfWvZlUQUQv5ScLXBBksSlxZO7+qhhIDeRoCPRImryT+JcEtoBu0q9aQTXKRkO4sxroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-03fff7000000aab6-f3-67ecee91e7d3
From: "yohan.joung" <yohan.joung@sk.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	pilhyun.kim@sk.com,
	yohan.joung@sk.com
Subject: f2fs: prevent the current section from being selected as a victim during GC
Date: Wed,  2 Apr 2025 17:00:14 +0900
Message-ID: <20250402080015.2794-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <7440d324-03f4-44a6-b6bf-4f569c829214@kernel.org>
References: <7440d324-03f4-44a6-b6bf-4f569c829214@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXC9ZZnke7Ed2/SDfo/81icnnqWyeLJ+lnM
	FpcWuVtc3jWHzYHFY9OqTjaP3Qs+M3l83iQXwBzFZZOSmpNZllqkb5fAldFw8jZ7wQWxivbH
	F5gbGM8IdTFyckgImEhMmzKPBcZesnonI4jNJqAh8ae3lxnEFhHQkpjY8BcszixQKtH7fBmY
	LSwQIrFsw3G2LkYODhYBVYlv05JBTF4BM4kfPU4QEzUldnw5zwRicwrYSXz9twXMFhKwlVh3
	oAFsK6+AoMTJmU9YIKbLSzRvnQ20lQuo9yurxPVdc5ghBklKHFxxg2UCI/8sJD2zkPQsYGRa
	xSiSmVeWm5iZY6xXnJ1RmZdZoZecn7uJERh6y2r/RO5g/HYh+BCjAAejEg9vA++bdCHWxLLi
	ytxDjBIczEoivEVngUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFk
	mTg4pRoYE2fMTXjyJPzrf1O7B9flb8z/q7tNQ0HhyIJjxftvTN58M2JfmvqmFPsaS4V7uf9Y
	19idUSg/rmV5pIop67LppjR75mq351xzXxx1bu0oZvuy0+PefAtTpvxaX4mM6xPvOAh73sq+
	fDnLJ/x8t93ZANXvF9JjWSbFtDnxyLy32vXcVyBoffsrJZbijERDLeai4kQAnvz5WDkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhmqEyR3fiuzfpBt17GS1OTz3LZPFk/Sxm
	i0uL3C0u75rDZjFh7lUmi/db7zE6sHlsWtXJ5rF7wWcmj2+3PTw+b5ILYInisklJzcksSy3S
	t0vgymg4eZu94IJYRfvjC8wNjGeEuhg5OSQETCSWrN7JCGKzCWhI/OntZQaxRQS0JCY2/AWL
	MwuUSvQ+XwZmCwuESCzbcJyti5GDg0VAVeLbtGQQk1fATOJHjxPERE2JHV/OM4HYnAJ2El//
	bQGzhQRsJdYdaGABsXkFBCVOznzCAjFdXqJ562zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOm
	V5ydUZmXWaGXnJ+7iREYTMtq/0zawfjtsvshRgEORiUe3gbeN+lCrIllxZW5hxglOJiVRHiL
	zgKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGJddeSnN
	ryPEcWmiUfqLu+a7lu96cCrmoKfqAi819ie3JM9tzGgUtu1ewTWLL0YjhHX3EV2mnv1v2UJW
	tH689qioTIqxPNQh0s3xwbRK49bpT/iObm9rm7a5tPrfvmMlVXzfyn87tQs+l7Dhr+E9wxAy
	Q3j537e7Pj6dWHWm671N8vQGvVNrriixFGckGmoxFxUnAgCqi8jCIgIAAA==
X-CFilter-Loop: Reflected

>On 4/2/25 08:52, yohan.joung wrote:
>> When selecting a victim using next_victim_seg in a large section, the
>> selected section might already have been cleared and designated as the
>> new current section, making it actively in use.
>> This behavior causes inconsistency between the SIT and SSA.
>>
>> F2FS-fs (dm-54): Inconsistent segment (70961) type [0, 1] in SSA and
>> SIT Call trace:
>> dump_backtrace+0xe8/0x10c
>> show_stack+0x18/0x28
>> dump_stack_lvl+0x50/0x6c
>> dump_stack+0x18/0x28
>> f2fs_stop_checkpoint+0x1c/0x3c
>> do_garbage_collect+0x41c/0x271c
>> f2fs_gc+0x27c/0x828
>> gc_thread_func+0x290/0x88c
>> kthread+0x11c/0x164
>> ret_from_fork+0x10/0x20
>>
>> issue scenario
>> segs_per_sec=2
>> - seg#0 and seg#1 are all dirty
>> - all valid blocks are removed in seg#1
>> - gc select this sec and next_victim_seg=seg#0
>> - migrate seg#0, next_victim_seg=seg#1
>> - checkpoint -> sec(seg#0, seg#1)  becomes free
>> - allocator assigns sec(seg#0, seg#1) to curseg
>> - gc tries to migrate seg#1
>>
>> Signed-off-by: yohan.joung <yohan.joung@sk.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/segment.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index
>> 0465dc00b349..14d18bcf3559 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -460,6 +460,7 @@ static inline void __set_test_and_free(struct
>f2fs_sb_info *sbi,
>>  		unsigned int segno, bool inmem)
>>  {
>>  	struct free_segmap_info *free_i = FREE_I(sbi);
>> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>  	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>>  	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
>>  	unsigned int next;
>> @@ -476,6 +477,11 @@ static inline void __set_test_and_free(struct
>f2fs_sb_info *sbi,
>>  		if (next >= start_segno + usable_segs) {
>>  			if (test_and_clear_bit(secno, free_i->free_secmap))
>>  				free_i->free_sections++;
>> +
>> +			if (test_and_clear_bit(secno, dirty_i->victim_secmap))
>{
>> +				sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
>> +				sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
>
>sbi->next_victim_seg[FG_GC] relies on sbi->cur_victim_sec?
right  
>
>If sbi->next_victim_seg[BG_GC] is not equal to secno, will we still need to
>nullify sbi->next_victim_seg[BG_GC]?
Changed to remove only when equal
>
>We have cleared bit in victim_secmap after we tag a section as prefree,
>right?
You are right 
change victim_secmap to not be used
In the end, I think I'll have to do this to directly compare segno, 
as you suggested.
I tested this and it worked fine.

Thanks
>
>- locate_dirty_segment
> - __locate_dirty_segment
> - __remove_dirty_segment
>  - clear_bit(GET_SEC_FROM_SEG(sbi, segno), dirty_i->victim_secmap);
>
>Thanks,
>
>> +			}
>>  		}
>>  	}
>>  skip_free:


