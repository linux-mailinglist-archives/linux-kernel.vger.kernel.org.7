Return-Path: <linux-kernel+bounces-830090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA2B98B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5F4172EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3127FD64;
	Wed, 24 Sep 2025 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbbXII8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CD16132A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700723; cv=none; b=uQuMQB3thlHomQ/29PMB90TBh6QOzv6b3GHEc3laIcm4wnq6uIc1cXQfsOba8+81oYuXkeyxTvF6YMhb6dzYOJUwwDHQQSE0cKiJftk1M2GpXvKQyWIIe2h2hxOmmzsnglQg2MB+PTkBzw8tmYpGlLe4rDGBz9NMuzagdEG4fWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700723; c=relaxed/simple;
	bh=rHSxg4+4TSenEjSeMMvVprpOjHqvnCoRegMdDVjjUgQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gnP35ZJ00yXZL/KObGuVJpCu4DsL4WbGlLzlzhn7j1knUvtzM71R57pCXwNfcJdYrXnkeLrNyX+lBRHtJG781utsT3MJ6ntLBiyRtWg2iFj+7Io+s6OK/XYge/m5+wnU7kHwkOIf3hKrjyYWT6E9T5FyU1zkGveB/E1k2ZfMNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbbXII8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CDEC4CEE7;
	Wed, 24 Sep 2025 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758700722;
	bh=rHSxg4+4TSenEjSeMMvVprpOjHqvnCoRegMdDVjjUgQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BbbXII8LVVU1HEoc9RKzioSZaFq4mz5nRg5r1Ct/hCFWZALsg00YE0Q0KMXbI48DH
	 RRsggo3mlKcuaBTpQ0yVUMBfNnrgpMZ6YD52RsPPpIb1SiskyMZuqnx+OuWB0cA0bj
	 AAYpbY/5/pcO3ES3Aweozs5/bX9CBlyI5AD+VndfeeqJlWLfscBgvMXy53W9C2/Fg4
	 0tnh9YDBuUrrfHQkNFK6CfXBYKaNznP09/E1W8sECG/PnLXSSFz8wItSd7WoDMlgVN
	 jzp/aG61AYBfFlyDoh0YYC4zTn5t+Dccelp3HYNFnDLak7BKoJ6At8QbRZVA9KSdbD
	 2gQr99zxC4wCg==
Message-ID: <7d4dd633-8828-4d88-9160-2827c7a0bc83@kernel.org>
Date: Wed, 24 Sep 2025 15:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 sj1557.seo@samsung.com, yunji0.kang@samsung.com
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: readahead node blocks in
 F2FS_GET_BLOCK_PRECACHE mode
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
References: <dfc68656-1794-4e69-a222-9ba9c8bf3a20@kernel.org>
 <20250924065338.1359558-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250924065338.1359558-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 14:53, wangzijie wrote:
>> On 9/24/25 13:58, Yunji Kang wrote:
>>> In f2fs_precache_extents(), For large files, It requires reading many
>>> node blocks. Instead of reading each node block with synchronous I/O,
>>> this patch applies readahead so that node blocks can be fetched in
>>> advance.
>>>
>>> It reduces the overhead of repeated sync reads and improves efficiency
>>> when precaching extents of large files.
>>>
>>> I created a file with the same largest extent and executed the test.
>>> For this experiment, I set the file's largest extent with an offset of 0
>>> and a size of 1GB. I configured the remaining area with 100MB extents.
>>>
>>> 5GB test file:
>>> dd if=/dev/urandom of=test1 bs=1m count=5120
>>> cp test1 test2
>>> fsync test1
>>> dd if=test1 of=test2 bs=1m skip=1024 seek=1024 count=100 conv=notrunc
>>> dd if=test1 of=test2 bs=1m skip=1224 seek=1224 count=100 conv=notrunc
>>> ...
>>> dd if=test1 of=test2 bs=1m skip=5024 seek=5024 count=100 conv=notrunc
>>> reboot
>>>
>>> I also created 10GB and 20GB files with large extents using the same
>>> method.
>>>
>>> ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
>>>   +-----------+---------+---------+-----------+
>>>   | File size | Before  | After   | Reduction |
>>>   +-----------+---------+---------+-----------+
>>>   | 5GB       | 101.8ms | 37.0ms  | 72.1%     |
>>>   | 10GB      | 222.9ms | 56.0ms  | 74.9%     |
>>>   | 20GB      | 446.2ms | 116.4ms | 73.9%     |
>>>   +-----------+---------+---------+-----------+
>>> Tested on a 256GB mobile device with an SM8750 chipset.
>>>
>>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>>> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
>>> Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>
>>> ---
>>> v2:
>>>  - Modify the readahead condition check routine for better code
>>> readability.
>>>  - Update the title from 'node block' to 'node blocks'.
>>>
>>> v3:
>>>  - Bug fix to allow more node pages to be readahead.
>>>  - Updated with test results.
>>>
>>>  fs/f2fs/data.c | 3 +++
>>>  fs/f2fs/f2fs.h | 1 +
>>>  fs/f2fs/node.c | 4 +++-
>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 7961e0ddfca3..ab3117e3b24a 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1572,6 +1572,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>  	pgofs =	(pgoff_t)map->m_lblk;
>>>  	end = pgofs + maxblocks;
>>>  
>>> +	if (flag == F2FS_GET_BLOCK_PRECACHE)
>>> +		mode = LOOKUP_NODE_PRECACHE;
>>
>> If trigger condition of LOOKUP_NODE_RA and LOOKUP_NODE_PRECACHE is the same,
>> What about?
>>
>> 	if (flag == F2FS_GET_BLOCK_PRECACHE)
>> 		mode = LOOKUP_NODE_RA;
>>
>> Thanks,
> 
> Hi Yunji and Chao,
> I think so, we can directly use LOOKUP_NODE_RA for precache extents.
> BTW, maybe there are more cases that LOOKUP_NODE_RA will be better? Like
> defragment/compress(need to call __f2fs_cluster_blocks() ) ioctl..

Yeah, we can have a try to check the benefits. :)

Thaks,

> 
> 
>>> +
>>>  next_dnode:
>>>  	if (map->m_may_create) {
>>>  		if (f2fs_lfs_mode(sbi))
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 9d3bc9633c1d..3ce41528d48e 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -651,6 +651,7 @@ enum {
>>>  					 * look up a node with readahead called
>>>  					 * by get_data_block.
>>>  					 */
>>> +	LOOKUP_NODE_PRECACHE,		/* look up a node for F2FS_GET_BLOCK_PRECACHE */
>>>  };
>>>  
>>>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 4254db453b2d..63e9ee7ab911 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
>>>  			set_nid(parent, offset[i - 1], nids[i], i == 1);
>>>  			f2fs_alloc_nid_done(sbi, nids[i]);
>>>  			done = true;
>>> -		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
>>> +		} else if ((mode == LOOKUP_NODE_RA ||
>>> +                (mode == LOOKUP_NODE_PRECACHE))
>>> +                && i == level && level > 1) {
>>>  			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
>>>  			if (IS_ERR(nfolio[i])) {
>>>  				err = PTR_ERR(nfolio[i]);


