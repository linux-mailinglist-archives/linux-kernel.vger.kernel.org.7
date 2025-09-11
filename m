Return-Path: <linux-kernel+bounces-811537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E1B52A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1A1BC55D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442A29ACC3;
	Thu, 11 Sep 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ9CiPx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D558296BC1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576842; cv=none; b=SwD4L2LXNaMaV8oSM3suhB1KI/Uh9H2ujVkeJCWP3gqGhfno3InZB/cZ803qJKIzst5wy/TRMKZpJ0A5nRVhEJyc4Yw5WabZicayqExWRO8fiOkrhN8RHfuGPds1k/70LNEJzlw9KSMgJrsbVUj/esnYRNxS7CXnVO4/x8IUBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576842; c=relaxed/simple;
	bh=xG0wqREPO4jvc2whMHvR/DEgATLKUBA6P+zcRmExoUo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XEDbVMHt08fsxr9rPOgek9YSk9PY19DdTZMMmEre4xqm2NZl2U49wlMxRKh4yXc2bdTpzFyVAd2kWJNVH4C64jN/en2Akh5A0TqlAEWXs4Drua8FTJJicED48wwMQBJk2Xd8W6nAZgSPDq1rFM+NnlTtVf0XzaVlEVludo2QzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ9CiPx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA1C4CEF1;
	Thu, 11 Sep 2025 07:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757576841;
	bh=xG0wqREPO4jvc2whMHvR/DEgATLKUBA6P+zcRmExoUo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eZ9CiPx8KWTZJDC6odQjuXXVQD7rkpTyZnWMi8AEs0/HPTp54WAYN5kkmTwAmAVSC
	 GgO/LHB6PFRvqHDnNQ+iQdE5iWe6wtUWjbXWH2TkruniCfTk88OwI3hXRd7DdHtn6O
	 edOSW8CN4qkfVtvRUJpyjjCnfQCNWS3j9vQayLmkZnIeXZLhRHUBs5Ewc26+Ti/A9Z
	 6BisRrtu7yUDkbuJoxFIs0rt4cFCSTv/BLu8rchkUY5NUJLeK5sH0IrfP4c94nCdea
	 gUWrNlTVKfXB8olh5bP4K9cUfLhxEaOJJmf20o3eyCzo43i0H6w0TVjfYzw5Z9yJXp
	 frvSZOwyrHZpQ==
Message-ID: <122b93a0-515d-49b0-9c0a-30313e040287@kernel.org>
Date: Thu, 11 Sep 2025 15:47:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, feng.han@honor.com, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for
 precache extents
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
References: <ad627632-298e-428b-9cfa-a5b5b50c147e@kernel.org>
 <20250911065549.2929967-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250911065549.2929967-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 14:55, wangzijie wrote:
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
>>
>> Hi Zijie,
>>
>> I tried to reproduce w/ below steps:
>>
>> f2fs_io write 1 0 1881 rand dsync testfile
>> f2fs_io write 1 1881 1 rand buffered testfile
>> f2fs_io fallocate 0 7708672 4096 testfile
>> umount
>> mount
>> f2fs_io precache_extents testfile
>>
>>          f2fs_io-921     [013] .....  1049.855817: f2fs_lookup_start: dev = (253,16), pino = 3, name:testfile, flags:65537
>>          f2fs_io-921     [013] .....  1049.855870: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), DATA, sector = 139280, size = 4096
>>          f2fs_io-921     [013] .....  1049.856116: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x5, oldaddr = 0x5553, newaddr = 0x5553, rw = READ(), type = HOT_NODE
>>          f2fs_io-921     [013] .....  1049.856147: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174744, size = 4096
>>          f2fs_io-921     [013] .....  1049.856273: f2fs_iget: dev = (253,16), ino = 5, pino = 3, i_mode = 0x81ed, i_size = 7712768, i_nlink = 1, i_blocks = 15080, i_advise = 0x0
>>          f2fs_io-921     [013] .....  1049.856305: f2fs_lookup_end: dev = (253,16), pino = 3, name:testfile, ino:5, err:0
>>          f2fs_io-921     [013] .....  1049.856316: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 0, type = Read
>>          f2fs_io-921     [013] .....  1049.856317: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 0, read_ext_info(fofs: 0, len: 512, blk: 1055744)
>>          f2fs_io-921     [013] .....  1049.856317: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 0, start blkaddr = 0x101c00, len = 0x200, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>>          f2fs_io-921     [013] .....  1049.856318: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 512, type = Read
>>          f2fs_io-921     [013] .....  1049.856318: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 512, read_ext_info(fofs: 0, len: 0, blk: 0)
>>          f2fs_io-921     [013] .....  1049.856323: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 512, len = 352, blkaddr = 18432, c_len = 0
>>          f2fs_io-921     [013] .....  1049.856328: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x6, oldaddr = 0x5556, newaddr = 0x5556, rw = READ(), type = HOT_NODE
>>          f2fs_io-921     [013] .....  1049.856329: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174768, size = 4096
>>          f2fs_io-921     [021] .....  1049.856968: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 864, len = 160, blkaddr = 18784, c_len = 0
>>          f2fs_io-921     [021] .....  1049.857002: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 512, start blkaddr = 0x4800, len = 0x200, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>>          f2fs_io-921     [021] .....  1049.857003: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1025, type = Read
>>          f2fs_io-921     [021] .....  1049.857004: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1025, read_ext_info(fofs: 0, len: 0, blk: 0)
>>          f2fs_io-921     [021] .....  1049.857010: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 1025, len = 511, blkaddr = 19457, c_len = 0
>>          f2fs_io-921     [021] .....  1049.857011: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1025, start blkaddr = 0x4c01, len = 0x1ff, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>>          f2fs_io-921     [021] .....  1049.857012: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1537, type = Read
>>          f2fs_io-921     [021] .....  1049.857012: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1537, read_ext_info(fofs: 0, len: 0, blk: 0)
>>          f2fs_io-921     [021] .....  1049.857016: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 1537, len = 344, blkaddr = 20993, c_len = 0
>>          f2fs_io-921     [021] .....  1049.857016: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1537, start blkaddr = 0x5201, len = 0x158, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>>          f2fs_io-921     [021] .....  1049.857017: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1882, type = Read
>>          f2fs_io-921     [021] .....  1049.857017: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1882, read_ext_info(fofs: 0, len: 0, blk: 0)
>>          f2fs_io-921     [021] .....  1049.857024: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x7, oldaddr = 0x5555, newaddr = 0x5555, rw = READ(), type = HOT_NODE
>>          f2fs_io-921     [021] .....  1049.857026: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174760, size = 4096
>>          f2fs_io-921     [021] .....  1049.857156: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1882, start blkaddr = 0x5201, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>>
>> It seems f2fs_update_read_extent_tree_range() won't insert a zero-sized extent?
>> Or am I missing something?
>>
>> Thanks,
> 
> Hi, Chao
> I test it again with below steps:
> 
> ./f2fs_io write 1 0 1881 rand dsync testfile
> ./f2fs_io fallocate 0 7708672 4096 testfile
> ./f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> ./f2fs_io precache_extents testfile

Oh, I can reproduce the bug w/ above scripts, thanks.

Thanks,

> 
>          f2fs_io-8749    [003] .....    86.759281: f2fs_lookup_start: dev = (254,57), pino = 45485, name:testfile, flags:257
>          f2fs_io-8749    [003] .....    86.759954: f2fs_iget: dev = (254,57), ino = 501391, pino = 45485, i_mode = 0x81ed, i_size = 7712768, i_nlink = 1, i_blocks = 15080, i_advise = 0x0
>          f2fs_io-8749    [003] .....    86.759968: f2fs_lookup_end: dev = (254,57), pino = 45485, name:testfile, ino:501391, err:0
>          f2fs_io-8749    [003] .....    86.760000: f2fs_lookup_extent_tree_start: dev = (254,57), ino = 501391, pgofs = 0, type = Read
>          f2fs_io-8749    [003] .....    86.760020: f2fs_lookup_read_extent_tree_end: dev = (254,57), ino = 501391, pgofs = 0, read_ext_info(fofs: 0, len: 1881, blk: 3164707)
>          f2fs_io-8749    [003] .....    86.760020: f2fs_map_blocks: dev = (254,57), ino = 501391, file offset = 0, start blkaddr = 0x304a23, len = 0x759, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>          f2fs_io-8749    [003] .....    86.760021: f2fs_lookup_extent_tree_start: dev = (254,57), ino = 501391, pgofs = 1881, type = Read
>          f2fs_io-8749    [003] .....    86.760022: f2fs_lookup_read_extent_tree_end: dev = (254,57), ino = 501391, pgofs = 1881, read_ext_info(fofs: 0, len: 0, blk: 0)
>          f2fs_io-8749    [005] .....    86.760162: f2fs_update_read_extent_tree_range: dev = (254,57), ino = 501391, pgofs = 1881, len = 1, blkaddr = 2688335, c_len = 0
>     *****f2fs_io-8749    [005] .....    86.760324: f2fs_update_read_extent_tree_range: dev = (254,57), ino = 501391, pgofs = 1882, len = 0, blkaddr = 2688336, c_len = 0  ******
>          f2fs_io-8749    [005] .....    86.760326: f2fs_map_blocks: dev = (254,57), ino = 501391, file offset = 1881, start blkaddr = 0x29054f, len = 0x1, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
> 
> 
> inode:
> i_ext: fofs:0 blkaddr:304a23 len:759
> i_addr[0x9]     [0x  304a23 : 3164707]
> ....
> i_addr[0x368]   [0x  304d82 : 3165570]
> 
> dnode1:
> [0]    [0x  304d83 : 3165571]
> [1016] [0x  30517b : 3166587]
> ...
> [1017] [0x  29054f : 2688335]
> 
> dnode2:
> [0]  	NEW_ADDR
> [1]     [0x       0 : 0]
> ...
> 
> 
> 
> 
>>>
>>> Fix it by skipping updating this kind of extent info.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>> ---
>>>  fs/f2fs/data.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7961e0ddf..b8bb71852 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>  
>>>  		switch (flag) {
>>>  		case F2FS_GET_BLOCK_PRECACHE:
>>> +			if (__is_valid_data_blkaddr(map->m_pblk) &&
>>> +				start_pgofs - map->m_lblk == map->m_len)
>>> +				map->m_flags &= ~F2FS_MAP_MAPPED;
>>>  			goto sync_out;
>>>  		case F2FS_GET_BLOCK_BMAP:
>>>  			map->m_pblk = 0;
> 


