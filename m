Return-Path: <linux-kernel+bounces-758580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F50B1D101
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C065816EF4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584E1940A1;
	Thu,  7 Aug 2025 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwBV7J5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AE79EA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534868; cv=none; b=XvaICAeQ0h37FBHd3rnya2D28h7ifGNTC+qMA0jLntoDudixidqewWJ3+IPm1U11oiiQK8V5b8WveJ54ilaKAZkkpRV/J6bolK7/BndQhWGhIZEtpjBji63Gu3Gp9ohJjfsPiJkBOK1VFlh7rhcHmW7+p5H4m0WZ7vCuApTQIB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534868; c=relaxed/simple;
	bh=uTtkPEq2yFmxCcFM/cPem5ZdCduiGqyu/C6uW0UOaZc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H19RXMPZI+6AT/50YG/BbsXpM/AZghfl/qiAQ+9DnNQEgOB7fzpoqe5D4gt9lGbbBJdBHB3dsWK205GRnHPJOsObxXM2xECU8uG0lB6ZPcJ3t5vz4L7cOkarCoYv3ywgJBNzGyobVfXKayXeBtnZKQ2tfBPIyDe+qhQkuaMFkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwBV7J5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD8DC4CEE7;
	Thu,  7 Aug 2025 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754534866;
	bh=uTtkPEq2yFmxCcFM/cPem5ZdCduiGqyu/C6uW0UOaZc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pwBV7J5E4b9ZdLq6jrLdWGFr/R9CR1SwZMqjXpOnX6WPH9o3VcvOZqPJv/t+hinSR
	 DZMoLDfT6q4XB3etQ2EoCZrkBF7hKxPrZ+gVPrc7mMfYKEcK4+Fq1c3gtsKBO8Opap
	 AKhZ9ms5Rbi+zPnH00ykgztByByAFwU6syZVZsumcorFLzyApW6DVD/OISMPLQpoNz
	 YPVGJ6C20b5pS/J7MkIKmHctNuWmpL1ypbD2mz9lpK0A39bPJADWPCeFYKrzzMV4p3
	 VZwwGJi5qtJo9dCz4wqOU5r9Tym27pItJ7Idr07eE8/IGzf7ghYjQcEWSCZqwk7ury
	 8RzCcYstVEEMA==
Message-ID: <da1b15f0-95bd-43ab-9900-c3afd87e9ac7@kernel.org>
Date: Thu, 7 Aug 2025 10:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce flush_policy sysfs entry
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20250731084700.1230841-1-chao@kernel.org>
 <CAHJ8P3+GJu8ztM85pMUih93RUsDF65n2OUc-F7QPwvGwv2x48w@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+GJu8ztM85pMUih93RUsDF65n2OUc-F7QPwvGwv2x48w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/7/25 10:16, Zhiguo Niu wrote:
> Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 于2025年7月31日周四 16:49写道：
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
>> ---
>>  Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
>>  fs/f2fs/checkpoint.c                    | 10 +++++++++-
>>  fs/f2fs/f2fs.h                          |  7 +++++++
>>  fs/f2fs/sysfs.c                         |  9 +++++++++
>>  4 files changed, 34 insertions(+), 1 deletion(-)
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
>> index bbe07e3a6c75..10cc27158770 100644
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
>> @@ -1606,6 +1608,12 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>         f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>>         stat_cp_time(cpc, CP_TIME_WAIT_LAST_CP);
>>
>> +       if (sbi->flush_policy & BIT(FLUSH_POLICY_CP_NO_FUA)) {
>> +               err = f2fs_flush_device_cache(sbi);
>> +               if (err)
>> +                       return err;
>> +       }
> Hi Chao,
> sorry for late interruption.
> f2fs_flush_device_cache is just used for multi device cases, so this patch will
> not be suitable for a single device if the user changes flush_policy
> by sysfs, otherwise it
> will not use FUA write when committing checkpoint? Is this expected?

Zhiguo, I expected to flush primary device as well, so I need to fix this, thanks
for catching this.

Thanks,

> Thanks!
>> +
>>         /*
>>          * invalidate intermediate page cache borrowed from meta inode which are
>>          * used for migration of encrypted, verity or compressed inode's blocks.
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 5c0ea60e502e..5bba24ca15c8 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1621,6 +1621,11 @@ struct decompress_io_ctx {
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
>> @@ -1873,6 +1878,8 @@ struct f2fs_sb_info {
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


