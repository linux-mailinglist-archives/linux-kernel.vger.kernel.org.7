Return-Path: <linux-kernel+bounces-813039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319DAB53FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B4E48716B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98515747D;
	Fri, 12 Sep 2025 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoCnrmp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE221348
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641981; cv=none; b=uaU471rpCoXgaqOjy35b9HENnFwbPu95Oh5TYT2HEw1NyqGztadKrryaVTWXWROY7G5I5CG89qfa8XOcVhip5IK8qn/9l4U+geb/XTC+W/oDOIkqUrvoe+bFEcv5Q8+jrJVrfzvk55rRhcxBYbB+gK2oAl+xmtX7ytVbV+Roz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641981; c=relaxed/simple;
	bh=99G4qv/3CdgX9Nxeg7q0yDGVl4TQ9oN85oPNSBy8taM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=soCMHAFuPPk8piQfQnVKX2rI3YGV05fv4/sdt0eoyrJ7XXx1OqmEY1EQSXFty9RmOImQcdVo3m4aVfWUowzuKQyfhi+KzTAbKl5/RNsxUzdMaobqRNSQpLrCP8+Mv9Fz/aQL5q4MHrRldNMz/PwjaOPi7NtQy0MrLjyTI1UKDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoCnrmp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0286C4CEF0;
	Fri, 12 Sep 2025 01:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757641981;
	bh=99G4qv/3CdgX9Nxeg7q0yDGVl4TQ9oN85oPNSBy8taM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=MoCnrmp5C9fofctJy9vANtmUS5nWhjRqVihHfHZmxd9SunHBQtUkEYqfVdi7i2U0W
	 v1oFDKpn2wuxMJxuRdkhFvXE6iI5oolCRpCMnJacjUJBGfmONOvJ6rHtlFjy2HpDez
	 JezhZoQHCNSuoF8+uIUwUbMgxUexhxPS62Yxoih4cv0XMubC1EH8OBS704fGeFApTX
	 U3WqxjMeyjZ2moIBFerGBefsrUMZewhehuxzinKfvty8YgHlgqHg/6P3u7gD7/g6fK
	 k74qTOKV1sm2GIUOZmGWayEh/eokQ8V1xHN5okV9Ztd8YbqX762B0t0vbt5xmYdbYR
	 AisuqobkzpCEw==
Message-ID: <c83ac24b-9997-4f2e-9e51-00c29909ad85@kernel.org>
Date: Fri, 12 Sep 2025 09:52:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for
 precache extents
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org, feng.han@honor.com, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org
References: <228203f5-d3bf-46fb-b990-3de2eb2ff3e8@kernel.org>
 <20250911090745.2940557-1-wangzijie1@honor.com>
Content-Language: en-US
In-Reply-To: <20250911090745.2940557-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/2025 5:07 PM, wangzijie wrote:
>> On 9/10/25 21:58, wangzijie wrote:
>>> When the data layout is like this:
>>> dnode1:                     dnode2:
>>> [0]      A                  [0]    NEW_ADDR
>>> [1]      A+1                [1]    0x0
>>> ...                         ....
>>> [1016]   A+1016
>>> [1017]   B (B!=A+1017)      [1017] 0x0
>>>
>>> We can build this kind of layout by following steps(with i_extra_isize:36):
>>> ./f2fs_io write 1 0 1881 rand dsync testfile
>>> ./f2fs_io write 1 1881 1 rand buffered testfile
>>> ./f2fs_io fallocate 0 7708672 4096 testfile
>>>
>>> And when we map first data block in dnode2, we will get wrong extent_info data:
>>> map->m_len = 1
>>> ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
>>>
>>> ei.fofs = start_pgofs = 1882
>>> ei.len = map->m_len - ofs = 1 - 1 = 0
>>>
>>> Fix it by skipping updating this kind of extent info.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>> ---
>>>   fs/f2fs/data.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7961e0ddf..b8bb71852 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>   
>>>   		switch (flag) {
>>>   		case F2FS_GET_BLOCK_PRECACHE:
>>> +			if (__is_valid_data_blkaddr(map->m_pblk) &&
>>> +				start_pgofs - map->m_lblk == map->m_len)
>>> +				map->m_flags &= ~F2FS_MAP_MAPPED;
>>
>> It looks we missed to reset value for map variable in f2fs_precache_extents(),
>> what do you think of this?
>>
>> ---
>>   fs/f2fs/file.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 1aae4361d0a8..2b14151d4130 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3599,7 +3599,7 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>>   int f2fs_precache_extents(struct inode *inode)
>>   {
>>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>> -	struct f2fs_map_blocks map;
>> +	struct f2fs_map_blocks map = { 0 };
>>   	pgoff_t m_next_extent;
>>   	loff_t end;
>>   	int err;
>> @@ -3617,6 +3617,8 @@ int f2fs_precache_extents(struct inode *inode)
>>
>>   	while (map.m_lblk < end) {
>>   		map.m_len = end - map.m_lblk;
>> +		map.m_pblk = 0;
>> +		map.m_flags = 0;
>>
>>   		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>>   		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
>> -- 
>> 2.49.0
>>
>> Thanks,
>>
>>>   			goto sync_out;
>>>   		case F2FS_GET_BLOCK_BMAP:
>>>   			map->m_pblk = 0;
> 
> 
> We have already reset m_flags (map->m_flags = 0) in f2fs_map_blocks().

Zijie:

Oops, that's right, thanks for correcting me.

> 
> I think that this bug is caused by we missed to reset m_flags when we
> goto next_dnode in below case：
> 
> Data layout is something like this:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> we map the last block(valid blkaddr) in dnode1:
> map->m_flags |= F2FS_MAP_MAPPED;
> map->m_pblk = blkaddr(valid blkaddr);
> map->m_len = 1;
> then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
> map->m_flags & F2FS_MAP_MAPPED == true, and we make wrong blkaddr/len for extent_info.

So, can you please add above explanation into commit message? that
should be helpful for understanding the problem more clearly.

Please take a look at this case w/ your patch:

mkfs.f2fs -O extra_attr,compression /dev/vdb -f
mount /dev/vdb /mnt/f2fs -o mode=lfs
cd /mnt/f2fs
f2fs_io write 1 0 1883 rand dsync testfile
f2fs_io fallocate 0 7712768 4096 testfile
f2fs_io write 1 1881 1 rand buffered testfile
xfs_io testfile -c "fsync"
cd /
umount /mnt/f2fs
mount /dev/vdb /mnt/f2fs
f2fs_io precache_extents /mnt/f2fs/testfile
umount /mnt/f2fs

          f2fs_io-733     [010] .....    78.134136: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 1882, len = 0, blkaddr = 17410, c_len = 0

I suspect we need this?

@@ -1784,7 +1781,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
         }

         if (flag == F2FS_GET_BLOCK_PRECACHE) {
-               if (map->m_flags & F2FS_MAP_MAPPED) {
+               if ((map->m_flags & F2FS_MAP_MAPPED) &&
+                       (map->m_len - ofs)) {
                         unsigned int ofs = start_pgofs - map->m_lblk;

                         f2fs_update_read_extent_cache_range(&dn,

BTW, I find another bug, if one blkaddr is adjcent to previous extent,
but and it is valid, we need to set m_next_extent to pgofs rather than
pgofs + 1.

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cbf8841642c7..ac88ed68059c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1789,8 +1789,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
                                 start_pgofs, map->m_pblk + ofs,
                                 map->m_len - ofs);
                 }
-               if (map->m_next_extent)
-                       *map->m_next_extent = pgofs + 1;
+               if (map->m_next_extent) {
+                       *map->m_next_extent = pgofs;
+                       if (!__is_valid_data_blkaddr(blkaddr))
+                               *map->m_next_extent += 1;
+               }
         }
         f2fs_put_dnode(&dn);

