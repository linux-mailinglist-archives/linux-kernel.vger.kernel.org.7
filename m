Return-Path: <linux-kernel+bounces-821920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E63B829EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA4723665
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B822A1D5;
	Thu, 18 Sep 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2NuQrgG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5C1D5CC7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161396; cv=none; b=ZnMRqXLEZ19Opq802tVJ00fyQ0PXgr3VaRqWIeRTPomm1pGMwMhqg21dEJw7rLdSA5ShEOMfB42ZgpE0NhTYLNlFA425R/NAo9WcR/4fCqPlK+w/AqOPI94sIOh0HGdbe20KWGHiQQq99bscCrF6ScbkdNAOeUdabx5sH2vCfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161396; c=relaxed/simple;
	bh=2Gl5VQpe3Kr+g9GDcpIm9On2t4jBVt6mmEX/BU/mrAQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XNLZNysgv4x41ZSnNhwYY0/kDuLuRs7Y70QILS1xYoR2g61gRlI6AbPhy1OByJW4ATbZbJkJ3k8KTWvDS3o2IvhKwtAvp2J00uuLneFl9Dtk3SodfeQZ+UY/iNvwHDVBFxYKy17vXPgZaclXCavVsnbViWuI/SwYGsu+tEtEQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2NuQrgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7ECC4CEE7;
	Thu, 18 Sep 2025 02:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758161395;
	bh=2Gl5VQpe3Kr+g9GDcpIm9On2t4jBVt6mmEX/BU/mrAQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=R2NuQrgG+QMzce/tITsqLa0Na5y4kjZ33KcJWmNYXIVY2FUAGfWMv9leQVENng3w/
	 odID7xGRQNs63cwejiO4nbEczpaNN7KMh0b/oz8fZwOKntzpRPuMEbga16J9gwHngj
	 4KKKLj+9YJaS1FTcORm91f+cfHW2DGGNsRr5MzmR8JR+GGVQKQubJwXuTkkkiYOmzK
	 oRVakjICOEwmmVUpMEFGxroAk23EHoMMf+Nn6EE5wkoSfM3XyQnzVAUH2yU1M/7M9i
	 k/cWfoyh22+k1RGC9VuGIYhwfihItEfPN6eZnxHoePXyPC28g7dXSV5qBbmTqYbZcY
	 fakeP8kGfxlOQ==
Message-ID: <de32bc26-6424-4750-83f7-17956e6727cd@kernel.org>
Date: Thu, 18 Sep 2025 10:09:48 +0800
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
Subject: Re: [PATCH] f2fs: readahead node block in F2FS_GET_BLOCK_PRECACHE
 mode
To: Yunji Kang <yunji0.kang@samsung.com>, jaegeuk@kernel.org
References: <CGME20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448@epcas1p2.samsung.com>
 <20250917055217.39960-1-yunji0.kang@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250917055217.39960-1-yunji0.kang@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 13:52, Yunji Kang wrote:
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
>   | 5GB       | 101.8ms | 72.1ms  | 29.2%     |
>   | 10GB      | 222.9ms | 149.5ms | 32.9%     |
>   | 20GB      | 446.2ms | 276.3ms | 38.1%     |
>   +-----------+---------+---------+-----------+
> Tested on a 256GB mobile device with an SM8750 chipset.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yunji Kang <yunji0.kang@samsung.com>
> ---
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
> index 4254db453b2d..50be167e5c59 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -860,7 +860,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
>  			set_nid(parent, offset[i - 1], nids[i], i == 1);
>  			f2fs_alloc_nid_done(sbi, nids[i]);
>  			done = true;
> -		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
> +		} else if ((mode == LOOKUP_NODE_RA ||

Does this change the logic for mode = LOOKUP_NODE_RA?

Not sure, do you mean this?

	if ((i == level && level > 1) &&
		(mode == LOOKUP_NODE_RA ||
		(mode == LOOKUP_NODE_PRECACHE &&
		offset[i - 1] % MAX_RA_NODE == 0)))

Thanks,

> +				(mode == LOOKUP_NODE_PRECACHE && offset[i - 1] % MAX_RA_NODE == 0))
> +				&& i == level && level > 1) {
>  			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
>  			if (IS_ERR(nfolio[i])) {
>  				err = PTR_ERR(nfolio[i]);


