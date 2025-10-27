Return-Path: <linux-kernel+bounces-871007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40EC0C387
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E59189D7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F32E425F;
	Mon, 27 Oct 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkHf8N6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978E19D065
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552275; cv=none; b=U/E6DctlSlEPHgvSZkkmSn2ihZnjFDZ227KS36TeLI6NspJEUyOjdbc1kXrH8fe6nksp2AcIwdeVs2nsVjuCsraWxLPxFNBPvBn8PDy2wuOXEtnAHbW0aAmVDyKvJu9zhe70YHpPizhl2HisIvW410hqy85pwtqn73MP/m0AmHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552275; c=relaxed/simple;
	bh=sgCne/ELFZaA17TmEA7gqxd4vbE9iXyIeLCoG+vVFZs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LOH80y6o28uH5z/8e7SmxWIlIP8GJ9gFDV7yU8oFwGsfeE5+mCvRw9t9qsMP07UMHQGNPfzKkskF77JIac/pNfKTNL0VBsF1iS5S+7LOH+BI59+2LNpqAqF2VSWpME6R93VFJDZR6docWE6wbCiCWv8KR8clCOU/R9GWumU3+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkHf8N6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0EDC4CEF1;
	Mon, 27 Oct 2025 08:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761552274;
	bh=sgCne/ELFZaA17TmEA7gqxd4vbE9iXyIeLCoG+vVFZs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hkHf8N6BVg6dYETC1WA1bEveoZtCvBl2zq1xyFdk1nRHk6jwUhs8COhi7NDshHa4B
	 tDf3KWacA6UyG3zU+dIHjhusWdHCZbE0bsfEXEFTVJkX387CxPzwvjZiUuA++Fo/+7
	 YDWBB69TiN+qq0mHmLaTzpD75doZKL+4i1dh3WwtV86Zm5oXU2VNbZPGMqzNtU02O4
	 l79jooWTgJ43CXl9hQKYZytrHy7yR5/ue9BSOIUQmcBndPEQc22NdLoGP5fcP3fd8k
	 EbZs1Ektv2hhPSua125rdXESfz6XKGdtwr6JQcmqDBLiINb7EOqXTWOc4tsNtoAbIQ
	 O9xtei//0F1Sg==
Message-ID: <7e7b7b9f-5909-4bb9-88ea-d3653f26c95d@kernel.org>
Date: Mon, 27 Oct 2025 16:04:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] f2fs: fix age extent cache insertion skip on counter
 overflow
To: Xiaole He <hexiaole1994@126.com>, jaegeuk@kernel.org
References: <20251023035416.7943-1-hexiaole1994@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251023035416.7943-1-hexiaole1994@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 11:54, Xiaole He wrote:
> The age extent cache uses last_blocks (derived from
> allocated_data_blocks) to determine data age. However, there's a
> conflict between the deletion
> marker (last_blocks=0) and legitimate last_blocks=0 cases when
> allocated_data_blocks overflows to 0 after reaching ULLONG_MAX.
> 
> In this case, valid extents are incorrectly skipped due to the
> "if (!tei->last_blocks)" check in __update_extent_tree_range().
> 
> This patch fixes the issue by:
> 1. Reserving ULLONG_MAX as an invalid/deletion marker
> 2. Limiting allocated_data_blocks to range [0, ULLONG_MAX-1]
> 3. Using F2FS_EXTENT_AGE_INVALID for deletion scenarios
> 4. Adjusting overflow age calculation from ULLONG_MAX to (ULLONG_MAX-1)
> 
> Reproducer (using a patched kernel with allocated_data_blocks
> initialized to ULLONG_MAX - 3 for quick testing):
> 
> Step 1: Mount and check initial state
>   # dd if=/dev/zero of=/tmp/test.img bs=1M count=100
>   # mkfs.f2fs -f /tmp/test.img
>   # mkdir -p /mnt/f2fs_test
>   # mount -t f2fs -o loop,age_extent_cache /tmp/test.img /mnt/f2fs_test
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 18446744073709551612 # ULLONG_MAX - 3
>   Inner Struct Count: tree: 1(0), node: 0
> 
> Step 2: Create files and write data to trigger overflow
>   # touch /mnt/f2fs_test/{1,2,3,4}.txt; sync
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 18446744073709551613 # ULLONG_MAX - 2
>   Inner Struct Count: tree: 5(0), node: 1
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/1.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 18446744073709551614 # ULLONG_MAX - 1
>   Inner Struct Count: tree: 5(0), node: 2
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/2.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 18446744073709551615 # ULLONG_MAX
>   Inner Struct Count: tree: 5(0), node: 3
> 
>   # dd if=/dev/urandom of=/mnt/f2fs_test/3.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 0 # Counter overflowed!
>   Inner Struct Count: tree: 5(0), node: 4
> 
> Step 3: Trigger the bug - next write should create node but gets skipped
>   # dd if=/dev/urandom of=/mnt/f2fs_test/4.txt bs=4K count=1; sync
>   # cat /sys/kernel/debug/f2fs/status | grep "Block Age"
>   Allocated Data Blocks: 1
>   Inner Struct Count: tree: 5(0), node: 4
> 
>   Expected: node: 5 (new extent node for 4.txt)
>   Actual: node: 4 (extent insertion was incorrectly skipped due to
>   last_blocks = allocated_data_blocks = 0 in __get_new_block_age)
> 
> After this fix, the extent node is correctly inserted and node count
> becomes 5 as expected.
> 

Hi Xiaole,

Can we add a Fixes line and Cc stable@kernel.org?

Thanks,

> Signed-off-by: Xiaole He <hexiaole1994@126.com>
> ---
>  fs/f2fs/extent_cache.c | 5 +++--
>  fs/f2fs/f2fs.h         | 6 ++++++
>  fs/f2fs/segment.c      | 9 +++++++--
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 33e09c453c70..0ed84cc065a7 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -808,7 +808,7 @@ static void __update_extent_tree_range(struct inode *inode,
>  	}
>  	goto out_read_extent_cache;
>  update_age_extent_cache:
> -	if (!tei->last_blocks)
> +	if (tei->last_blocks == F2FS_EXTENT_AGE_INVALID)
>  		goto out_read_extent_cache;
>  
>  	__set_extent_info(&ei, fofs, len, 0, false,
> @@ -912,7 +912,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>  			cur_age = cur_blocks - tei.last_blocks;
>  		else
>  			/* allocated_data_blocks overflow */
> -			cur_age = ULLONG_MAX - tei.last_blocks + cur_blocks;
> +			cur_age = (ULLONG_MAX - 1) - tei.last_blocks + cur_blocks;
>  
>  		if (tei.age)
>  			ei->age = __calculate_block_age(sbi, cur_age, tei.age);
> @@ -1114,6 +1114,7 @@ void f2fs_update_age_extent_cache_range(struct dnode_of_data *dn,
>  	struct extent_info ei = {
>  		.fofs = fofs,
>  		.len = len,
> +		.last_blocks = F2FS_EXTENT_AGE_INVALID,
>  	};
>  
>  	if (!__may_extent_tree(dn->inode, EX_BLOCK_AGE))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5b4e9548a231..fa3c676adc30 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -707,6 +707,12 @@ enum extent_type {
>  	NR_EXTENT_CACHES,
>  };
>  
> +/*
> + * Reserved value to mark invalid age extents, hence valid block range
> + * from 0 to ULLONG_MAX-1
> + */
> +#define F2FS_EXTENT_AGE_INVALID	ULLONG_MAX
> +
>  struct extent_info {
>  	unsigned int fofs;		/* start offset in a file */
>  	unsigned int len;		/* length of the extent */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45eace879d7..a473cd1fb37d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3863,8 +3863,13 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
>  	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
>  	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
>  
> -	if (IS_DATASEG(curseg->seg_type))
> -		atomic64_inc(&sbi->allocated_data_blocks);
> +	if (IS_DATASEG(curseg->seg_type)) {
> +		unsigned long long new_val;
> +
> +		new_val = atomic64_inc_return(&sbi->allocated_data_blocks);
> +		if (unlikely(new_val == ULLONG_MAX))
> +			atomic64_set(&sbi->allocated_data_blocks, 0);
> +	}
>  
>  	up_write(&sit_i->sentry_lock);
>  


