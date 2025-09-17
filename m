Return-Path: <linux-kernel+bounces-821228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50506B80D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227B2167D02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2142EC0B8;
	Wed, 17 Sep 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5M0aTe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F434136B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124765; cv=none; b=paADew6EmgK0wpebo5xbfAJ2DNkcwQYJ27a3EKcMDzglPHnzf/d1cQJ189xwn5q5os1lv9NgCf6QvLnFGN5v8gY85ULq4aUNJ6T3xwp+wLk7vhsQ/aJLilQO7tC+mpUHFreIljEX3VJpDojT4anafjVlr1AZkM8uMtnCBOoAda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124765; c=relaxed/simple;
	bh=NnGX677nwdyHGZdxlN31q3yooL9zbXMipdVwiJ+dzBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWcTwQRM9tMfNMWjihGb+Absu99VpKs/UinDTUHBvH4cJtBUWZb/KThpgGeSEJuUJyZqAL3KO8Pa7MeESbw/R9R+vAqiQrExdSBcKJ9uwFi9ek7Ag5c08Z5F5Pelh5push2s2BXuS0kHzFri3GfIfmu4EnJFnlvSoZm/mclWI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5M0aTe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC55C4CEE7;
	Wed, 17 Sep 2025 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124765;
	bh=NnGX677nwdyHGZdxlN31q3yooL9zbXMipdVwiJ+dzBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5M0aTe4F3gwnP33KkGj3X8l9LNtVvODxOO439YyMDX8reXD3J2xZQKP2LPN80SUN
	 QTeoMVUo+TBPRblP8kq9PZv3voN3GLMYqEPMapXyBniyJFmT5OEBu/TS8j7Ndvy779
	 crFuKVgbx8LSbXpNeHsnZ+hHEzY+cfYIhCoNkYLJdNByCAhgmI6C0CMXPglVjy3ZGW
	 f4z+3adIG8moNfUJ/zvM+4gpd5Kc5bNF2EBoD8lGnD7lfCF0ntXGKUxgnpOM3tY665
	 LeBhLS2TIZGSIfBGTiHv8Yo3B8lSbyg4/x8nVjs0ssRxrHfM2sSCujVc5JXA9yVmHX
	 vv8NLMVkpcDlA==
Date: Wed, 17 Sep 2025 15:59:23 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: wangzijie <wangzijie1@honor.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, bintian.wang@honor.com,
	feng.han@honor.com
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for
 precache extents
Message-ID: <aMra2_bW9cPCRcTs@google.com>
References: <20250917023622.516052-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917023622.516052-1-wangzijie1@honor.com>

On 09/17, wangzijie wrote:
> Script to reproduce:
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> fsync testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
> When the data layout is something like this:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> During precache_extents, we map the last block(valid blkaddr) in dnode1:
> map->m_flags |= F2FS_MAP_MAPPED;
> map->m_pblk = blkaddr(valid blkaddr);
> map->m_len = 1;
> then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
> map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent:
> 
> map->m_len = 1
> ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
> ei.fofs = start_pgofs = 1882
> ei.len = map->m_len - ofs = 1 - 1 = 0
> 
> 
> Rebased on patch[1], this patch can cover these cases to avoid zero-sized extent:
> A,B,C is valid blkaddr
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
> [1] https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
> 
> Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
> Rebased on:
> https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
> v2:
> https://lore.kernel.org/linux-f2fs-devel/20250915035246.98055-1-wangzijie1@honor.com/
> ---
>  fs/f2fs/data.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 838eae39d..7a5170b32 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1778,9 +1778,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  		if (map->m_flags & F2FS_MAP_MAPPED) {
>  			unsigned int ofs = start_pgofs - map->m_lblk;
>  
> -			f2fs_update_read_extent_cache_range(&dn,
> -				start_pgofs, map->m_pblk + ofs,
> -				map->m_len - ofs);
> +			if (map->m_len - ofs > 0)

Applied with
			if (map->m_len > ofs)

> +				f2fs_update_read_extent_cache_range(&dn,
> +					start_pgofs, map->m_pblk + ofs,
> +					map->m_len - ofs);
>  		}
>  		if (map->m_next_extent)
>  			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
> -- 
> 2.25.1

