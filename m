Return-Path: <linux-kernel+bounces-829992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9422B9865E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526B57A4FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316D242D90;
	Wed, 24 Sep 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh3ptc5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C61552FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695660; cv=none; b=IcI2LxMHUtHFHOSs75bwf72p3aRU8AcO+zMCEHDWj6MnoXSJOiaemjfq68N6yRSw/MMTMr6DxvyaHb+jE1ni/VY/Vm+dYsEbl/OKFPzUe4AQjEo9at88rU37t8VA/JIl24p6t0jusVYHhTtfsbWifclnP3/0wv/5WV7pZYu7NcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695660; c=relaxed/simple;
	bh=n+fob0a/KleEhL3/yk1pmNFL67AabGNBDwLx7nDdKXg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ldDVgsqZYPpaL9wSMqxi8/pKNW8ni7gCjSLoHWx4amuVlujJLTNgjy+K2p8JXBZUDp5C9jh9IdEO0J4ccaXkD1dkpvfFNdGvIKTfLEaH+nHE02IB3TIkMKJcGVQcoWUagfcS1X5Ny0Z6x7L5STZrnvS6+rB9MoplmujOlp4msfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh3ptc5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE91C4CEE7;
	Wed, 24 Sep 2025 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758695659;
	bh=n+fob0a/KleEhL3/yk1pmNFL67AabGNBDwLx7nDdKXg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Jh3ptc5MDKfNd29lg4+XyQtcDxf3MKkosBFwUtADKV4ALckS1TQ1GtMXLS53JX+2d
	 sRv4KWLGQEIRuGzZueURU6rSw+w7aJDAM1eKgFKdrQLcpKI5zcah+6jeYYvSzWFakH
	 kMwfBAIeInZeVAVaZHU+4IvnZP8i1SlJaQCKwjWR61cRxDrcF18Ciz+Zs7I2LmAGN2
	 PF6T3A9WYsLm4T6BuTMdHu5dbcFRlCtlPH+mD85mKSaYWOROkKDrc5YL40nTGAxlcc
	 nqyrIga+WoLJq1Ul7np72mydkFTDRT5KOGegMu3ggxyOYLQp6Z8RhiFPjHnNCEJ6Wq
	 k4UXmPXt60ipA==
Message-ID: <dfc68656-1794-4e69-a222-9ba9c8bf3a20@kernel.org>
Date: Wed, 24 Sep 2025 14:34:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Sunmin Jeong <s_min.jeong@samsung.com>
Subject: Re: [PATCH v3] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE
 mode
To: Yunji Kang <yunji0.kang@samsung.com>, jaegeuk@kernel.org
References: <CGME20250924055837epcas1p460d67d7f1c900f5cc25c865cb636e950@epcas1p4.samsung.com>
 <20250924055831.250805-1-yunji0.kang@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250924055831.250805-1-yunji0.kang@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 13:58, Yunji Kang wrote:
> In f2fs_precache_extents(), For large files, It requires reading many
> node blocks. Instead of reading each node block with synchronous I/O,
> this patch applies readahead so that node blocks can be fetched in
> advance.
> 
> It reduces the overhead of repeated sync reads and improves efficiency
> when precaching extents of large files.
> 
> I created a file with the same largest extent and executed the test.
> For this experiment, I set the file's largest extent with an offset of 0
> and a size of 1GB. I configured the remaining area with 100MB extents.
> 
> 5GB test file:
> dd if=/dev/urandom of=test1 bs=1m count=5120
> cp test1 test2
> fsync test1
> dd if=test1 of=test2 bs=1m skip=1024 seek=1024 count=100 conv=notrunc
> dd if=test1 of=test2 bs=1m skip=1224 seek=1224 count=100 conv=notrunc
> ...
> dd if=test1 of=test2 bs=1m skip=5024 seek=5024 count=100 conv=notrunc
> reboot
> 
> I also created 10GB and 20GB files with large extents using the same
> method.
> 
> ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
>   +-----------+---------+---------+-----------+
>   | File size | Before  | After   | Reduction |
>   +-----------+---------+---------+-----------+
>   | 5GB       | 101.8ms | 37.0ms  | 72.1%     |
>   | 10GB      | 222.9ms | 56.0ms  | 74.9%     |
>   | 20GB      | 446.2ms | 116.4ms | 73.9%     |
>   +-----------+---------+---------+-----------+
> Tested on a 256GB mobile device with an SM8750 chipset.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>
> ---
> v2:
>  - Modify the readahead condition check routine for better code
> readability.
>  - Update the title from 'node block' to 'node blocks'.
> 
> v3:
>  - Bug fix to allow more node pages to be readahead.
>  - Updated with test results.
> 
>  fs/f2fs/data.c | 3 +++
>  fs/f2fs/f2fs.h | 1 +
>  fs/f2fs/node.c | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddfca3..ab3117e3b24a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1572,6 +1572,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  	pgofs =	(pgoff_t)map->m_lblk;
>  	end = pgofs + maxblocks;
>  
> +	if (flag == F2FS_GET_BLOCK_PRECACHE)
> +		mode = LOOKUP_NODE_PRECACHE;

If trigger condition of LOOKUP_NODE_RA and LOOKUP_NODE_PRECACHE is the same,
What about?

	if (flag == F2FS_GET_BLOCK_PRECACHE)
		mode = LOOKUP_NODE_RA;

Thanks,

> +
>  next_dnode:
>  	if (map->m_may_create) {
>  		if (f2fs_lfs_mode(sbi))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9d3bc9633c1d..3ce41528d48e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -651,6 +651,7 @@ enum {
>  					 * look up a node with readahead called
>  					 * by get_data_block.
>  					 */
> +	LOOKUP_NODE_PRECACHE,		/* look up a node for F2FS_GET_BLOCK_PRECACHE */
>  };
>  
>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4254db453b2d..63e9ee7ab911 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
>  			set_nid(parent, offset[i - 1], nids[i], i == 1);
>  			f2fs_alloc_nid_done(sbi, nids[i]);
>  			done = true;
> -		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
> +		} else if ((mode == LOOKUP_NODE_RA ||
> +                (mode == LOOKUP_NODE_PRECACHE))
> +                && i == level && level > 1) {
>  			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
>  			if (IS_ERR(nfolio[i])) {
>  				err = PTR_ERR(nfolio[i]);


