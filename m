Return-Path: <linux-kernel+bounces-830008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF30B9870A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B1019C7453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16815246787;
	Wed, 24 Sep 2025 06:54:06 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0754F81
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696845; cv=none; b=geSa1wEm4P3GcBzz5IJUCXbovEfeRjx/VU2PFW7pg5D9twjP+iCINopqhDGyyQMFhm+ZJcrAsU7pjfo58s1yLB8SiJzq5BkyIrkO8MNLtp1Ho5CwF+HK4suWEzcuxr2KjhaQ3QVNbAqjXOZ2M7c0UXPgww9/PNgmvXPXeKvnR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696845; c=relaxed/simple;
	bh=zfyNs5Bm4Ihj/zByP961pvW3U1HLC/BZzMUO/TJKbXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE+JOedWhP/AeiiCVUS/ceqAFrLGEyKTMklw+hNEjqL1ipyrGzkAkcQ9bAS7hL8pTVvzU4OvtmqwloEtoTqENJ8oi8JomvsP3taDxNCkJ28pBNpIi+14kP01w0DirxWC91vEC9jUXYF8nou9l+tuXrMZ9hj9jR/pcDNZvi87XWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cWnby6QJxzYlX32;
	Wed, 24 Sep 2025 14:53:02 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Sep
 2025 14:53:39 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Sep
 2025 14:53:39 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
	<sj1557.seo@samsung.com>, <yunji0.kang@samsung.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE mode
Date: Wed, 24 Sep 2025 14:53:38 +0800
Message-ID: <20250924065338.1359558-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dfc68656-1794-4e69-a222-9ba9c8bf3a20@kernel.org>
References: <dfc68656-1794-4e69-a222-9ba9c8bf3a20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

>On 9/24/25 13:58, Yunji Kang wrote:
>> In f2fs_precache_extents(), For large files, It requires reading many
>> node blocks. Instead of reading each node block with synchronous I/O,
>> this patch applies readahead so that node blocks can be fetched in
>> advance.
>> 
>> It reduces the overhead of repeated sync reads and improves efficiency
>> when precaching extents of large files.
>> 
>> I created a file with the same largest extent and executed the test.
>> For this experiment, I set the file's largest extent with an offset of 0
>> and a size of 1GB. I configured the remaining area with 100MB extents.
>> 
>> 5GB test file:
>> dd if=/dev/urandom of=test1 bs=1m count=5120
>> cp test1 test2
>> fsync test1
>> dd if=test1 of=test2 bs=1m skip=1024 seek=1024 count=100 conv=notrunc
>> dd if=test1 of=test2 bs=1m skip=1224 seek=1224 count=100 conv=notrunc
>> ...
>> dd if=test1 of=test2 bs=1m skip=5024 seek=5024 count=100 conv=notrunc
>> reboot
>> 
>> I also created 10GB and 20GB files with large extents using the same
>> method.
>> 
>> ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
>>   +-----------+---------+---------+-----------+
>>   | File size | Before  | After   | Reduction |
>>   +-----------+---------+---------+-----------+
>>   | 5GB       | 101.8ms | 37.0ms  | 72.1%     |
>>   | 10GB      | 222.9ms | 56.0ms  | 74.9%     |
>>   | 20GB      | 446.2ms | 116.4ms | 73.9%     |
>>   +-----------+---------+---------+-----------+
>> Tested on a 256GB mobile device with an SM8750 chipset.
>> 
>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
>> Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>
>> ---
>> v2:
>>  - Modify the readahead condition check routine for better code
>> readability.
>>  - Update the title from 'node block' to 'node blocks'.
>> 
>> v3:
>>  - Bug fix to allow more node pages to be readahead.
>>  - Updated with test results.
>> 
>>  fs/f2fs/data.c | 3 +++
>>  fs/f2fs/f2fs.h | 1 +
>>  fs/f2fs/node.c | 4 +++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 7961e0ddfca3..ab3117e3b24a 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1572,6 +1572,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>  	pgofs =	(pgoff_t)map->m_lblk;
>>  	end = pgofs + maxblocks;
>>  
>> +	if (flag == F2FS_GET_BLOCK_PRECACHE)
>> +		mode = LOOKUP_NODE_PRECACHE;
>
>If trigger condition of LOOKUP_NODE_RA and LOOKUP_NODE_PRECACHE is the same,
>What about?
>
>	if (flag == F2FS_GET_BLOCK_PRECACHE)
>		mode = LOOKUP_NODE_RA;
>
>Thanks,

Hi Yunji and Chao,
I think so, we can directly use LOOKUP_NODE_RA for precache extents.
BTW, maybe there are more cases that LOOKUP_NODE_RA will be better? Like
defragment/compress(need to call __f2fs_cluster_blocks() ) ioctl..


>> +
>>  next_dnode:
>>  	if (map->m_may_create) {
>>  		if (f2fs_lfs_mode(sbi))
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 9d3bc9633c1d..3ce41528d48e 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -651,6 +651,7 @@ enum {
>>  					 * look up a node with readahead called
>>  					 * by get_data_block.
>>  					 */
>> +	LOOKUP_NODE_PRECACHE,		/* look up a node for F2FS_GET_BLOCK_PRECACHE */
>>  };
>>  
>>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 4254db453b2d..63e9ee7ab911 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
>>  			set_nid(parent, offset[i - 1], nids[i], i == 1);
>>  			f2fs_alloc_nid_done(sbi, nids[i]);
>>  			done = true;
>> -		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
>> +		} else if ((mode == LOOKUP_NODE_RA ||
>> +                (mode == LOOKUP_NODE_PRECACHE))
>> +                && i == level && level > 1) {
>>  			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
>>  			if (IS_ERR(nfolio[i])) {
>>  				err = PTR_ERR(nfolio[i]);

