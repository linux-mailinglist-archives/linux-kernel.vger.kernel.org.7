Return-Path: <linux-kernel+bounces-813730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FFB54A05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60651CC5477
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5512EB840;
	Fri, 12 Sep 2025 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLGckd0Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900732EBDDC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673536; cv=none; b=kngHm1npgwBIgKWlVtjOiKCGQ1Aww9Wu7chD7Ug/4MtqYkeKA5pIDygk5tEurC7qfoJHKBTz0rqFr5GGlRClU3PK2R1pn+Alfw2ZubUbjUWmBDQyQ5puIvt/QGsOMnTjd6CuiUAflK1VbssOXv/cPjKrYWFubP16cpKhAV+U5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673536; c=relaxed/simple;
	bh=iPCFZZNGeEXP4VXVwEOl0dkNG1owk4NNFMYpbjH9kgI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nIG0Jbjf23rxnS4LHGgEh47d2EIaGQCWgB2F4f/C5jylTy0I77JnhrM3IU9+jqiLuiw5bU+KnQH5mlL7rQahKOApGAdyb7IOM/qimHjCpmZGiL3KBDcTrsCfkgojCYbNGd+PWtWeAU9/0hrf69iaCqWqlgOxLFg5DED+SusZOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLGckd0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7CBC4CEFA;
	Fri, 12 Sep 2025 10:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757673536;
	bh=iPCFZZNGeEXP4VXVwEOl0dkNG1owk4NNFMYpbjH9kgI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PLGckd0ZoLa+xWUPJPCbrNyz6t6ZLFWHFVE8ilK4gAJPx0557r6mT373s+3OsWxVT
	 7r33UTrmNbBLYCNfbEcWM48Lbx1GrI/K0V4mweZRSdpYZBZulS9mkSdUsMIQ5MjFDb
	 v9JKc2KgBTW+RSPyR+bXpaGcAp10Ml0lUv7jENmPx4IObMVkrUIbq/c0JocNJN4n+W
	 MsMT/nkYH4UE+9G2qI/cqf68M2V7oB01u4rnoPPU0FZBHIn8xQUno3ln+VY5Eb21ga
	 1JmcOlJoFRNuCD/p70lNwKs5zOurQXVuFhtKhsGdK6cH5ALNEKaKMbQkDWQK+ZaECj
	 O3pEtE/EVA56Q==
Message-ID: <6464ded0-b25e-4ce8-a05b-6caa394fbe63@kernel.org>
Date: Fri, 12 Sep 2025 18:38:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, feng.han@honor.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for
 precache extents
To: wangzijie <wangzijie1@honor.com>
References: <2ecb4f74-cc60-4dd4-8dc3-d4f3ff848e87@kernel.org>
 <20250912100650.3594565-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250912100650.3594565-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/2025 6:06 PM, wangzijie wrote:
>> On 9/12/2025 11:36 AM, wangzijie wrote:
>>>> On 9/11/2025 5:07 PM, wangzijie wrote:
>>>>>> On 9/10/25 21:58, wangzijie wrote:
>>>>>>> When the data layout is like this:
>>>>>>> dnode1:                     dnode2:
>>>>>>> [0]      A                  [0]    NEW_ADDR
>>>>>>> [1]      A+1                [1]    0x0
>>>>>>> ...                         ....
>>>>>>> [1016]   A+1016
>>>>>>> [1017]   B (B!=A+1017)      [1017] 0x0
>>>>>>>
>>>>>>> We can build this kind of layout by following steps(with i_extra_isize:36):
>>>>>>> ./f2fs_io write 1 0 1881 rand dsync testfile
>>>>>>> ./f2fs_io write 1 1881 1 rand buffered testfile
>>>>>>> ./f2fs_io fallocate 0 7708672 4096 testfile
>>>>>>>
>>>>>>> And when we map first data block in dnode2, we will get wrong extent_info data:
>>>>>>> map->m_len = 1
>>>>>>> ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
>>>>>>>
>>>>>>> ei.fofs = start_pgofs = 1882
>>>>>>> ei.len = map->m_len - ofs = 1 - 1 = 0
>>>>>>>
>>>>>>> Fix it by skipping updating this kind of extent info.
>>>>>>>
>>>>>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>>>>>> ---
>>>>>>>     fs/f2fs/data.c | 3 +++
>>>>>>>     1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>> index 7961e0ddf..b8bb71852 100644
>>>>>>> --- a/fs/f2fs/data.c
>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>> @@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>>>>>     
>>>>>>>     		switch (flag) {
>>>>>>>     		case F2FS_GET_BLOCK_PRECACHE:
>>>>>>> +			if (__is_valid_data_blkaddr(map->m_pblk) &&
>>>>>>> +				start_pgofs - map->m_lblk == map->m_len)
>>>>>>> +				map->m_flags &= ~F2FS_MAP_MAPPED;
>>>>>>
>>>>>> It looks we missed to reset value for map variable in f2fs_precache_extents(),
>>>>>> what do you think of this?
>>>>>>
>>>>>> ---
>>>>>>     fs/f2fs/file.c | 4 +++-
>>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>> index 1aae4361d0a8..2b14151d4130 100644
>>>>>> --- a/fs/f2fs/file.c
>>>>>> +++ b/fs/f2fs/file.c
>>>>>> @@ -3599,7 +3599,7 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>>>>>>     int f2fs_precache_extents(struct inode *inode)
>>>>>>     {
>>>>>>     	struct f2fs_inode_info *fi = F2FS_I(inode);
>>>>>> -	struct f2fs_map_blocks map;
>>>>>> +	struct f2fs_map_blocks map = { 0 };
>>>>>>     	pgoff_t m_next_extent;
>>>>>>     	loff_t end;
>>>>>>     	int err;
>>>>>> @@ -3617,6 +3617,8 @@ int f2fs_precache_extents(struct inode *inode)
>>>>>>
>>>>>>     	while (map.m_lblk < end) {
>>>>>>     		map.m_len = end - map.m_lblk;
>>>>>> +		map.m_pblk = 0;
>>>>>> +		map.m_flags = 0;
>>>>>>
>>>>>>     		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>>>>>>     		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
>>>>>> -- 
>>>>>> 2.49.0
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>     			goto sync_out;
>>>>>>>     		case F2FS_GET_BLOCK_BMAP:
>>>>>>>     			map->m_pblk = 0;
>>>>>
>>>>>
>>>>> We have already reset m_flags (map->m_flags = 0) in f2fs_map_blocks().
>>>>
>>>> Zijie:
>>>>
>>>> Oops, that's right, thanks for correcting me.
>>>>
>>>>>
>>>>> I think that this bug is caused by we missed to reset m_flags when we
>>>>> goto next_dnode in below case：
>>>>>
>>>>> Data layout is something like this:
>>>>> dnode1:                     dnode2:
>>>>> [0]      A                  [0]    NEW_ADDR
>>>>> [1]      A+1                [1]    0x0
>>>>> ...
>>>>> [1016]   A+1016
>>>>> [1017]   B (B!=A+1017)      [1017] 0x0
>>>>>
>>>>> we map the last block(valid blkaddr) in dnode1:
>>>>> map->m_flags |= F2FS_MAP_MAPPED;
>>>>> map->m_pblk = blkaddr(valid blkaddr);
>>>>> map->m_len = 1;
>>>>> then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
>>>>> map->m_flags & F2FS_MAP_MAPPED == true, and we make wrong blkaddr/len for extent_info.
>>>>
>>>> So, can you please add above explanation into commit message? that
>>>> should be helpful for understanding the problem more clearly.
>>>>
>>>> Please take a look at this case w/ your patch:
>>>>
>>>> mkfs.f2fs -O extra_attr,compression /dev/vdb -f
>>>> mount /dev/vdb /mnt/f2fs -o mode=lfs
>>>> cd /mnt/f2fs
>>>> f2fs_io write 1 0 1883 rand dsync testfile
>>>> f2fs_io fallocate 0 7712768 4096 testfile
>>>> f2fs_io write 1 1881 1 rand buffered testfile
>>>> xfs_io testfile -c "fsync"
>>>> cd /
>>>> umount /mnt/f2fs
>>>> mount /dev/vdb /mnt/f2fs
>>>> f2fs_io precache_extents /mnt/f2fs/testfile
>>>> umount /mnt/f2fs
>>>>
>>>>            f2fs_io-733     [010] .....    78.134136: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 1882, len = 0, blkaddr = 17410, c_len = 0
>>>>
>>>> I suspect we need this?
>>>>
>>>> @@ -1784,7 +1781,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>>           }
>>>>
>>>>           if (flag == F2FS_GET_BLOCK_PRECACHE) {
>>>> -               if (map->m_flags & F2FS_MAP_MAPPED) {
>>>> +               if ((map->m_flags & F2FS_MAP_MAPPED) &&
>>>> +                       (map->m_len - ofs)) {
>>>>                           unsigned int ofs = start_pgofs - map->m_lblk;
>>>>
>>>>                           f2fs_update_read_extent_cache_range(&dn,
>>>
>>> Thanks for pointing out this. Let me find a way to cover these cases and do more test.
>>>
>>>> BTW, I find another bug, if one blkaddr is adjcent to previous extent,
>>>> but and it is valid, we need to set m_next_extent to pgofs rather than
>>>> pgofs + 1.
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index cbf8841642c7..ac88ed68059c 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -1789,8 +1789,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>>                                   start_pgofs, map->m_pblk + ofs,
>>>>                                   map->m_len - ofs);
>>>>                   }
>>>> -               if (map->m_next_extent)
>>>> -                       *map->m_next_extent = pgofs + 1;
>>>> +               if (map->m_next_extent) {
>>>> +                       *map->m_next_extent = pgofs;
>>>> +                       if (!__is_valid_data_blkaddr(blkaddr))
>>>> +                               *map->m_next_extent += 1;
>>>> +               }
>>>>           }
>>>>           f2fs_put_dnode(&dn);
>>>
>>> Maybe it can be this?
>>> if (map->m_next_extent)
>>> 	*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
>>
>> It's better, will update, thank you. :)
>>
>> Thanks,
> 
> Hi Chao,
> I test some cases with this change:
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddf..7093fdc95 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1777,13 +1777,13 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>          if (flag == F2FS_GET_BLOCK_PRECACHE) {
>                  if (map->m_flags & F2FS_MAP_MAPPED) {
>                          unsigned int ofs = start_pgofs - map->m_lblk;
> -
> -                       f2fs_update_read_extent_cache_range(&dn,
> -                               start_pgofs, map->m_pblk + ofs,
> -                               map->m_len - ofs);
> +                       if (map->m_len - ofs > 0)
> +                               f2fs_update_read_extent_cache_range(&dn,
> +                                       start_pgofs, map->m_pblk + ofs,
> +                                       map->m_len - ofs);
>                  }
>                  if (map->m_next_extent)
> -                       *map->m_next_extent = pgofs + 1;
> +                       *map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
>          }
>          f2fs_put_dnode(&dn);
>   unlock_out:
> 
> 
> test cases:
> 
> case1:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case2:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+1)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> case3:
> dnode1:                     dnode2:
> [0]      A                  [0]    C (C!=B+2)
> [1]      A+1                [1]    C+1
> ...                         ....
> [1015]   A+1015
> [1016]   B (B!=A+1016)
> [1017]   B+1                [1017] 0x0
> 
> case4:
> one blkaddr is adjcent to previous extent, and it is valid.
 > > And from the result, it seems this change can cover these
> situations correctly.
> Do we need a patch with this change?

Zijie, thanks for the test.

IMO, we'd better use these changes:

-
-                       f2fs_update_read_extent_cache_range(&dn,
-                               start_pgofs, map->m_pblk + ofs,
-                               map->m_len - ofs);
+                       if (map->m_len - ofs > 0)
+                               f2fs_update_read_extent_cache_range(&dn,
+                                       start_pgofs, map->m_pblk + ofs,
+                                       map->m_len - ofs);

instead of

    		switch (flag) {
    		case F2FS_GET_BLOCK_PRECACHE:
+			if (__is_valid_data_blkaddr(map->m_pblk) &&
+				start_pgofs - map->m_lblk == map->m_len)
+				map->m_flags &= ~F2FS_MAP_MAPPED;

Can you please rebase your patchset on mine and send v2?

https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org

BTW, please add fixes line in your patch.

Thanks,


