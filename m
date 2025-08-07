Return-Path: <linux-kernel+bounces-758606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB2B1D150
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290183BB29D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5D1DB127;
	Thu,  7 Aug 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOE4AETb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130E1B3925
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538598; cv=none; b=M5ruvQISbuo4jbAtj647d80cCQ1xgQf6b2Gcw5f2QDjSwU7Ymiovc+u+6HdwS339Ywz4d2N7Fg7XAGDln7L4TfrKzVmCYKTMEVUMGrjLvys5yG3GcQITN4CPmI0AbCmePON0cDpZvHKFXC4gyCTdTRN2haEOBKv0p8X3UfmIvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538598; c=relaxed/simple;
	bh=XgSHM3SUZ/g5o7AuDV27r0l5zUVXrs7FyX7nJLuRAj0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tS2waTqzdyANsY/BqcBmGf2sT4HNnMAUmHaAjEUQcIFA1WuqpZ47NCLGlwHcRPF1VgZPx5LykyZkIZsSJquU5csefBSUFxOYJIw6abtxdmJac2lMbDYn5MfPiwxgAkP1rBySrLMV73IhQK+xe+CVbKxnHSQ0PZ1Twd30wyRlCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOE4AETb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CFEC4CEEB;
	Thu,  7 Aug 2025 03:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754538597;
	bh=XgSHM3SUZ/g5o7AuDV27r0l5zUVXrs7FyX7nJLuRAj0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FOE4AETbytAUEi8B5qN1PWTZnOqA6IjV6HS3ohSjnuyBS1bpyIFIqh3Z36uwm5u8q
	 8pp3MlLDZtkX/ovQ8rxLJRJxn+QsG6IULMMzla35z+f2mB/aiQLzmZOQL6HZBHIcof
	 QwolHhTdsdCBanaBQIbE3BuONFozx2NjpKwl1wTc0zQ92r1E/z6rXh/rwanwODB3KF
	 lqArPVmf9bIjRL+GOdzay8SCDLqzIkopqUg0RnQJSbGfqR2Nh3Mjh6ea5z2aeSrHbu
	 YgCdMXi1Mte7gRgQbt6xBkl1RxqOZVkwfk3ArlmRQh6uiDdxSIoFE/QClz8ZqUjxkh
	 PT10mAaqQvi6A==
Message-ID: <77309097-2b76-4dd8-9766-f22fb385aa83@kernel.org>
Date: Thu, 7 Aug 2025 11:49:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce flush_policy sysfs entry
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250807032406.3817056-1-chao@kernel.org>
 <CAHJ8P3L9VRghpbpn=ndQQfDXKjit=5PY28yR_19mnbgvda1LxQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3L9VRghpbpn=ndQQfDXKjit=5PY28yR_19mnbgvda1LxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/25 11:47, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年8月7日周四 11:27写道：
>>
>> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
>> in order to tune performance of f2fs data flush flow.
>>
>> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
>> some kind device has bad performance on REQ_FUA command, result in that
>> checkpoint being blocked for long time, w/ this sysfs entry, we can give
>> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
>> it can help to mitigate long latency of checkpoint.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Sorry, missed to export f2fs_submit_flush_wait(), please check v3, thanks!

Thanks,

>> ---
>> v2:
>> - use __submit_flush_wait() instead of f2fs_flush_device_cache() to
>> just flush primary device cache
>>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>>  fs/f2fs/checkpoint.c                    | 11 ++++++++++-
>>  fs/f2fs/f2fs.h                          |  7 +++++++
>>  fs/f2fs/sysfs.c                         |  9 +++++++++
>>  4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index bc0e7fefc39d..2fedb44b713b 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -883,3 +883,12 @@ Date:              June 2025
>>  Contact:       "Daeho Jeong" <daehojeong@google.com>
>>  Description:   Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
>>                 Default: 1
>> +
>> +What:          /sys/fs/f2fs/<disk>/flush_policy
>> +Date:          July 2025
>> +Contact:       "Chao Yu" <chao@kernel.org>
>> +Description:   Device has different performance for the same flush methods, this node
>> +               can be used to tune performance by setting different flush methods.
>> +
>> +               policy value            description
>> +               0x00000001              Use preflush instead of fua during checkpoint
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index db3831f7f2f5..fafa2156732d 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1419,7 +1419,9 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
>>         f2fs_folio_put(folio, false);
>>
>>         /* submit checkpoint (with barrier if NOBARRIER is not set) */
>> -       f2fs_submit_merged_write(sbi, META_FLUSH);
>> +       f2fs_submit_merged_write(sbi,
>> +               sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA) ?
>> +               META : META_FLUSH);
>>  }
>>
>>  static inline u64 get_sectors_written(struct block_device *bdev)
>> @@ -1594,6 +1596,13 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>
>>         __set_cp_next_pack(sbi);
>>
>> +       /* flush device cache to make sure last cp pack can be persisted */
>> +       if (sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA)) {
>> +               err = __submit_flush_wait(sbi, sbi->sb->s_bdev);
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>>         /*
>>          * redirty superblock if metadata like node page or inode cache is
>>          * updated during writing checkpoint.
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 46be7560548c..5db5eba4cbd7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1594,6 +1594,11 @@ struct decompress_io_ctx {
>>  #define MAX_COMPRESS_LOG_SIZE          8
>>  #define MAX_COMPRESS_WINDOW_SIZE(log_size)     ((PAGE_SIZE) << (log_size))
>>
>> +enum flush_policy {
>> +       FLUSH_POLICY_CP_NO_FUA,
>> +       FLUSH_POLICY_MAX,
>> +};
>> +
>>  struct f2fs_sb_info {
>>         struct super_block *sb;                 /* pointer to VFS super block */
>>         struct proc_dir_entry *s_proc;          /* proc entry */
>> @@ -1845,6 +1850,8 @@ struct f2fs_sb_info {
>>         /* carve out reserved_blocks from total blocks */
>>         bool carve_out;
>>
>> +       unsigned int flush_policy;              /* flush policy */
>> +
>>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>>         struct kmem_cache *page_array_slab;     /* page array entry */
>>         unsigned int page_array_slab_size;      /* default page array slab size */
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index f736052dea50..b69015f1dc67 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -852,6 +852,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>                 return count;
>>         }
>>
>> +       if (!strcmp(a->attr.name, "flush_policy")) {
>> +               if (t >= BIT(FLUSH_POLICY_MAX))
>> +                       return -EINVAL;
>> +               *ui = (unsigned int)t;
>> +               return count;
>> +       }
>> +
>>         if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
>>                 if (t < 1 || t > SEGS_PER_SEC(sbi))
>>                         return -EINVAL;
>> @@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>>  #endif
>>  F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>>  F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
>> +F2FS_SBI_GENERAL_RW_ATTR(flush_policy);
>>
>>  /* STAT_INFO ATTR */
>>  #ifdef CONFIG_F2FS_STAT_FS
>> @@ -1371,6 +1379,7 @@ static struct attribute *f2fs_attrs[] = {
>>         ATTR_LIST(max_read_extent_count),
>>         ATTR_LIST(carve_out),
>>         ATTR_LIST(reserved_pin_section),
>> +       ATTR_LIST(flush_policy),
>>         NULL,
>>  };
>>  ATTRIBUTE_GROUPS(f2fs);
>> --
>> 2.49.0
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


