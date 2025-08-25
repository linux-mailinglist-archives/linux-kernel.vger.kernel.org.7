Return-Path: <linux-kernel+bounces-783971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F9B334D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EE91B2193C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23F2405FD;
	Mon, 25 Aug 2025 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkL8rlWw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04E1FE45D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094179; cv=none; b=r4TFceC8BmvFspTcUdccftIU5jYvJYuawGoc0UoBq5wUPvInvHvxV+0mFHgSOVKkxfqeGLWQew73vukupeAvz8ZiOhgCgKV9GrvE4DJUdMEn+lom7KfPRfHUHFxe0/bzQUe/t9/ttV9kNT0Tq0fRLfnqyO9C137EJhqiW0898hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094179; c=relaxed/simple;
	bh=dlP9gLi1p2qkfUlTX7cxU3rEmiLAQ6WMx4vIvUaWAeI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IXY1rX7Zp/Whq2TfhzuzxHkhDorlqNGm+Xh609kRiMPcV95Zfe51zQzeCdb4NPpWj8g4UG2GCDsU9/K/9G7Y9NerhqV+NTlWGOc6sh6eWkhJBYYBGFQW3cWjFA8ZtfKZKq3pD4NuVeSHE3om9LrH6fdmdcmvS0UZOEiA2xgKkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkL8rlWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B34C4CEF4;
	Mon, 25 Aug 2025 03:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756094178;
	bh=dlP9gLi1p2qkfUlTX7cxU3rEmiLAQ6WMx4vIvUaWAeI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gkL8rlWwqqUvtCb00ebB0F1SzJpgerZpkIyNAoYB1j+PHbEW7x/ltxzJbS2ZgHo5q
	 CyWdPecgOUFbv2f3oLF5OSBeBAkSVAc45CD/gHl9LBsnmD4wQicerge/W+F6vI2bt5
	 3UKEppL0lxNQvCgIizFnnQ95N7jmVRbbxt6IHtH12juHNQZ66BkqEBS1/N+OUcAaBn
	 qUo390NwSZhLTPSfcn2c3kly1RAA6FlwGOcNcb60425zI0SpKGZm/JNkB+vKeU4BMd
	 rMtvByDle9uWpD77/FB49MBQ3JNcQfYWZ5nM+EBAgB95V5vDIbazKU9kOYfyE3CN4/
	 UmqiOGXTNdWQQ==
Message-ID: <f1a893f7-9784-43c1-a696-b09c31d922fb@kernel.org>
Date: Mon, 25 Aug 2025 11:56:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH v2] f2fs: Use allocate_section_policy to control write
 priority in multi-devices setups
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250820082142.388237-1-liaoyuanhong@vivo.com>
 <8bda5b71-e7b9-47af-956b-22b95c957d56@kernel.org>
 <f037ec6c-1290-4caa-a790-1d65d9f7c985@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f037ec6c-1290-4caa-a790-1d65d9f7c985@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/25/25 11:42, Liao Yuanhong wrote:
> 
> On 8/25/2025 11:10 AM, Chao Yu wrote:
>> Yuanhong,
>>
>> On 8/20/25 16:21, Liao Yuanhong wrote:
>>> Introduces two new sys nodes: allocate_section_hint and
>>> allocate_section_policy. The allocate_section_hint identifies the boundary
>>> between devices, measured in sections; it defaults to the end of the device
>>> for single storage setups, and the end of the first device for multiple
>>> storage setups. The allocate_section_policy determines the write strategy,
>>> with a default value of 0 for normal sequential write strategy. A value of
>>> 1 prioritizes writes before the allocate_section_hint, while a value of 2
>>> prioritizes writes after it.
>>>
>>> This strategy addresses the issue where, despite F2FS supporting multiple
>>> devices, SOC vendors lack multi-devices support (currently only supporting
>>> zoned devices). As a workaround, multiple storage devices are mapped to a
>>> single dm device. Both this workaround and the F2FS multi-devices solution
>>> may require prioritizing writing to certain devices, such as a device with
>>> better performance or when switching is needed due to performance
>>> degradation near a device's end. For scenarios with more than two devices,
>>> sort them at mount time to utilize this feature.
>>>
>>> When using this feature with a single storage device, it has almost no
>>> impact. However, for configurations where multiple storage devices are
>>> mapped to the same dm device using F2FS, utilizing this feature can provide
>>> some optimization benefits. Therefore, I believe it should not be limited
>>> to just multi-devices usage.
>>>
>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>> ---
>>> Changes in v2:
>>>     - Updated the feature naming to better reflect its actual functionality.
>>>     - Appended patch description to clarify whether the usage should be
>>>     limited to multi-devices.
>>>     - Improved the code style.
>>>     - Fixed typo.
>>> ---
>>>   Documentation/ABI/testing/sysfs-fs-f2fs | 22 ++++++++++++++++++++++
>>>   fs/f2fs/f2fs.h                          |  8 ++++++++
>>>   fs/f2fs/gc.c                            |  5 +++++
>>>   fs/f2fs/segment.c                       | 18 +++++++++++++++++-
>>>   fs/f2fs/super.c                         |  4 ++++
>>>   fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>>>   6 files changed, 74 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> index ee3acc8c2cb8..b590809869ca 100644
>>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>>> @@ -911,3 +911,25 @@ Description:    Used to adjust the BG_GC priority when pending IO, with a default v
>>>           bggc_io_aware = 1   skip background GC if there is pending read IO
>>>           bggc_io_aware = 2   don't aware IO for background GC
>>>           ==================  ======================================================
>>> +
>>> +What:        /sys/fs/f2fs/<disk>/allocate_section_hint
>>> +Date:        August 2025
>>> +Contact:    "Liao Yuanhong" <liaoyuanhong@vivo.com>
>>> +Description:    Indicates the hint section between the first device and others in multi-devices
>>> +        setup. It defaults to the end of the first device in sections. For a single storage
>>> +        device, it defaults to the total number of sections. It can be manually set to match
>>> +        scenarios where multi-devices are mapped to the same dm device.
>>> +
>>> +What:        /sys/fs/f2fs/<disk>/allocate_section_policy
>>> +Date:        August 2025
>>> +Contact:    "Liao Yuanhong" <liaoyuanhong@vivo.com>
>>> +Description:    Controls write priority in multi-devices setups. A value of 0 means normal writing.
>>> +        A value of 1 prioritizes writing to devices before the allocate_section_hint. A value of 2
>>> +        prioritizes writing to devices after the allocate_section_hint. The default is 0.
>>> +
>>> +        ===========================  ==========================================================
>>> +        value                         description
>>> +        allocate_section_policy = 0  Normal writing
>>> +        allocate_section_policy = 1  Prioritize writing to section before allocate_section_hint
>>> +        allocate_section_policy = 2  Prioritize writing to section after allocate_section_hint
>>> +        ===========================  ==========================================================
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index d6a49de1b7e9..5ce9bf6be462 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -162,6 +162,12 @@ enum bggc_io_aware_policy {
>>>       AWARE_NONE,            /* don't aware IO for background GC */
>>>   };
>>>   +enum device_allocation_policy {
>>> +    ALLOCATE_FORWARD_NOHINT,
>>> +    ALLOCATE_FORWARD_WITHIN_HINT,
>>> +    ALLOCATE_FORWARD_FROM_HINT,
>>> +};
>>> +
>>>   /*
>>>    * An implementation of an rwsem that is explicitly unfair to readers. This
>>>    * prevents priority inversion when a low-priority reader acquires the read lock
>>> @@ -1850,6 +1856,8 @@ struct f2fs_sb_info {
>>>       bool aligned_blksize;            /* all devices has the same logical blksize */
>>>       unsigned int first_seq_zone_segno;    /* first segno in sequential zone */
>>>       unsigned int bggc_io_aware;        /* For adjust the BG_GC priority when pending IO */
>>> +    unsigned int allocate_section_hint;    /* the boundary position between devices */
>>> +    unsigned int allocate_section_policy;    /* determine the section writing priority */
>>>         /* For write statistics */
>>>       u64 sectors_written_start;
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 098e9f71421e..b57b8fd64747 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -2182,6 +2182,8 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>>>       SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>>>       MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
>>>       MAIN_SECS(sbi) += secs;
>>> +    if (sbi->allocate_section_hint > MAIN_SECS(sbi))
>>> +        sbi->allocate_section_hint = MAIN_SECS(sbi);
>>>       FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
>>>       FREE_I(sbi)->free_segments = (int)FREE_I(sbi)->free_segments + segs;
>>>       F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count + blks);
>>> @@ -2189,6 +2191,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>>>       if (f2fs_is_multi_device(sbi)) {
>>>           int last_dev = sbi->s_ndevs - 1;
>>>   +        sbi->allocate_section_hint = FDEV(0).total_segments /
>>> +                    SEGS_PER_SEC(sbi);
>>> +
>>>           FDEV(last_dev).total_segments =
>>>                   (int)FDEV(last_dev).total_segments + segs;
>>>           FDEV(last_dev).end_blk =
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 04b0a3c1804d..e0f6589c6a1c 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2807,6 +2807,10 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>>>       }
>>>   #endif
>>>   +    if (sbi->allocate_section_policy == ALLOCATE_FORWARD_FROM_HINT &&
>>> +        hint < sbi->allocate_section_hint)
>>> +        hint = sbi->allocate_section_hint;
>>> +
>>>   find_other_zone:
>>>       secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>>>   @@ -2828,13 +2832,25 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>>>   #endif
>>>         if (secno >= MAIN_SECS(sbi)) {
>>> -        secno = find_first_zero_bit(free_i->free_secmap,
>>> +        if (sbi->allocate_section_policy == ALLOCATE_FORWARD_FROM_HINT) {
>>> +            secno = find_next_zero_bit(free_i->free_secmap,
>>> +                            MAIN_SECS(sbi), sbi->allocate_section_hint);
>>> +            if (secno >= MAIN_SECS(sbi))
>>> +                secno = find_first_zero_bit(free_i->free_secmap,
>>> +                                MAIN_SECS(sbi));
>>> +        } else {
>>> +            secno = find_first_zero_bit(free_i->free_secmap,
>>>                               MAIN_SECS(sbi));
>>> +        }
>>>           if (secno >= MAIN_SECS(sbi)) {
>>>               ret = -ENOSPC;
>>>               f2fs_bug_on(sbi, !pinning);
>>>               goto out_unlock;
>>>           }
>>> +    } else if (sbi->allocate_section_policy == ALLOCATE_FORWARD_WITHIN_HINT &&
>>> +                secno >= sbi->allocate_section_hint) {
>>> +        secno = find_first_zero_bit(free_i->free_secmap,
>>> +                            MAIN_SECS(sbi));
>> Will we hit "secno >= MAIN_SECS(sbi)" case here?
> 
> 
> Yes, there may be hit 'secno>=MAIN_SECS (sbi)' case, and I will fix this issue in
> 
> the new version patch.
> 
>>>       }
>>>       segno = GET_SEG_FROM_SEC(sbi, secno);
>>>       zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 5aa9d650512d..fa38a3e6b9cd 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -3942,6 +3942,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>       segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>>>       secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>>>       total_sections = le32_to_cpu(raw_super->section_count);
>>> +    sbi->allocate_section_hint = total_sections;
>> What about assigning sbi->allocate_section_hint in anywhere else rather than
>> in sanity_check_raw_super()?
> 
> 
> 
> You're right, it's not suitable to initialize sbi->allocate_section_hint here. I'll put it in
> 
> init_sb_info() or f2fs_scan_devices().
> 
>>>         /* blocks_per_seg should be 512, given the above check */
>>>       blocks_per_seg = BIT(le32_to_cpu(raw_super->log_blocks_per_seg));
>>> @@ -4713,6 +4714,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>>       logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>>>       sbi->aligned_blksize = true;
>>>       sbi->bggc_io_aware = AWARE_ALL_IO;
>>> +    sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
>>>   #ifdef CONFIG_BLK_DEV_ZONED
>>>       sbi->max_open_zones = UINT_MAX;
>>>       sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
>>> @@ -4744,6 +4746,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>>                       SEGS_TO_BLKS(sbi,
>>>                       FDEV(i).total_segments) - 1 +
>>>                       le32_to_cpu(raw_super->segment0_blkaddr);
>>> +                sbi->allocate_section_hint = FDEV(i).total_segments /
>>> +                            SEGS_PER_SEC(sbi);
>>>               } else {
>>>                   FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
>>>                   FDEV(i).end_blk = FDEV(i).start_blk +
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 1ffaf9e74ce9..81b99c2a02a9 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -889,6 +889,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>>           return count;
>>>       }
>>>   +    if (!strcmp(a->attr.name, "allocate_section_hint")) {
>>> +        if (t < 0 || t > MAIN_SECS(sbi))
>>> +            return -EINVAL;
>>> +        sbi->allocate_section_hint = t;
>> Will it race w/ resize_fs ioctl?
>>
>> Thanks,
> 
> 
> Does this mean that after executing resize_fs, the current allocate_section_hint value will
> 
> not match the resized size? If so, I've handled the data update in update_fs_metadata().
> 
> If not, what other areas might cause a conflict? Please let me know so I can address the
> 
> issue immediately.

I meant something like this:

resize (cpu 0)					sysfs (cpu 1)
- MAIN_SECS(sbi) += secs;
- if (sbi->allocate_section_hint > MAIN_SECS(sbi))
   sbi->allocate_section_hint = MAIN_SECS(sbi);
						- if (t < 0 || t > MAIN_SECS(sbi))
						 : what if MAIN_SECS() has the old value before
						   statement "MAIN_SECS(sbi) += secs;" since cache
						   between cpu 0 & 1 may not the same unless you
						   call barrier to flush cache? Not sure, we'd better
						   to avoid such race case w/ a lock?

> 
> 
> Thanks,
> 
> Liao
> 
>>> +        return count;
>>> +    }
>>> +
>>> +    if (!strcmp(a->attr.name, "allocate_section_policy")) {
>>> +        if (t < ALLOCATE_FORWARD_NOHINT || t > ALLOCATE_FORWARD_FROM_HINT)
>>> +            return -EINVAL;
>>> +        sbi->allocate_section_policy = t;
>>> +        return count;
>>> +    }
>>> +
>>>       *ui = (unsigned int)t;
>>>         return count;
>>> @@ -1161,6 +1175,8 @@ F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>>>   F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>>>   F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
>>>   F2FS_SBI_GENERAL_RW_ATTR(dir_level);
>>> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_hint);
>>> +F2FS_SBI_GENERAL_RW_ATTR(allocate_section_policy);
>>>   #ifdef CONFIG_F2FS_IOSTAT
>>>   F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
>>>   F2FS_SBI_GENERAL_RW_ATTR(iostat_period_ms);
>>> @@ -1398,6 +1414,8 @@ static struct attribute *f2fs_attrs[] = {
>>>       ATTR_LIST(max_read_extent_count),
>>>       ATTR_LIST(carve_out),
>>>       ATTR_LIST(reserved_pin_section),
>>> +    ATTR_LIST(allocate_section_hint),
>>> +    ATTR_LIST(allocate_section_policy),
>>>       NULL,
>>>   };
>>>   ATTRIBUTE_GROUPS(f2fs);


