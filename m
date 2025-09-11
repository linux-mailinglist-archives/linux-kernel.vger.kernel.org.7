Return-Path: <linux-kernel+bounces-811610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0765B52B73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFF51C805D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185572D9786;
	Thu, 11 Sep 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwrP0B0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4721FF39
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578751; cv=none; b=BoT1k71v6ftqkLP6HeVHNDlv5FAPEEPXtioPana7plxvlMY1uo+/ubFvTmr7/9ERhLSY8KIxYaaPEY0x8UHHzgUFOaTuBn7MpJhvlskruegS4oWseNbEhCCLyKJ9BrqI641/Q/KvwKQJId/y71GXGMrv3KTijiPxzb9HQCo79hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578751; c=relaxed/simple;
	bh=cZKbUYp1WeU6O2Sr+ZScff3E+oh6kWfDkkGDRRWbqps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CppwsxctfwnRl9Vu0NntNYVYLCRL6SjeayDjSUai8lCt5fk3EANlAx4/KGwrjWlSlD1erk2Jd4Y0hnSTQJ3Rg/OX+QR7MVNalT7wHtbRvHYlTu30V+6EABdOBio7aica6ckbu3nZvmXcE4lP2aSUNImgt/ErtbeEjc2p+I3Jy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwrP0B0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5A5C4CEF1;
	Thu, 11 Sep 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757578751;
	bh=cZKbUYp1WeU6O2Sr+ZScff3E+oh6kWfDkkGDRRWbqps=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bwrP0B0KI52C49vphmiXlCAUfUPhjA/eLP3sbHbmhHQ8xhc0meD44MvqS3Hbq6ji+
	 OsYV6IMOG8bOefByzk5fJurE7mmS/8/ixiltRvyCM6xNgiTHFTcAlOGSm8bWfi8vDN
	 /uWH0aVqypOHrcNKZyT379GdjrUMiLKgHVafRrGUPZPLffipGAZbEGPkKi25FvPn/u
	 gOf6DBO8JOzXkpyJ9u2TwGRQrmLiS0WRVCL1D76hSUx0cO6RNiUDOaVAFH4/eRBzlB
	 Stwij7Hngz2t7Or0PziyrW2dmmzrCOS/LbwVG4llYqQ19o+IMI/vz2kbnxNpdk/X7r
	 TmtJzds5G66MA==
Message-ID: <228203f5-d3bf-46fb-b990-3de2eb2ff3e8@kernel.org>
Date: Thu, 11 Sep 2025 16:19:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, bintian.wang@honor.com, feng.han@honor.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for
 precache extents
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250910135835.2751574-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250910135835.2751574-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 21:58, wangzijie wrote:
> When the data layout is like this:
> dnode1:                     dnode2:
> [0]      A                  [0]    NEW_ADDR
> [1]      A+1                [1]    0x0
> ...                         ....
> [1016]   A+1016
> [1017]   B (B!=A+1017)      [1017] 0x0
> 
> We can build this kind of layout by following steps(with i_extra_isize:36):
> ./f2fs_io write 1 0 1881 rand dsync testfile
> ./f2fs_io write 1 1881 1 rand buffered testfile
> ./f2fs_io fallocate 0 7708672 4096 testfile
> 
> And when we map first data block in dnode2, we will get wrong extent_info data:
> map->m_len = 1
> ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
> 
> ei.fofs = start_pgofs = 1882
> ei.len = map->m_len - ofs = 1 - 1 = 0
> 
> Fix it by skipping updating this kind of extent info.
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>
> ---
>  fs/f2fs/data.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7961e0ddf..b8bb71852 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  
>  		switch (flag) {
>  		case F2FS_GET_BLOCK_PRECACHE:
> +			if (__is_valid_data_blkaddr(map->m_pblk) &&
> +				start_pgofs - map->m_lblk == map->m_len)
> +				map->m_flags &= ~F2FS_MAP_MAPPED;

It looks we missed to reset value for map variable in f2fs_precache_extents(),
what do you think of this?

---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1aae4361d0a8..2b14151d4130 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3599,7 +3599,7 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
 int f2fs_precache_extents(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_map_blocks map;
+	struct f2fs_map_blocks map = { 0 };
 	pgoff_t m_next_extent;
 	loff_t end;
 	int err;
@@ -3617,6 +3617,8 @@ int f2fs_precache_extents(struct inode *inode)

 	while (map.m_lblk < end) {
 		map.m_len = end - map.m_lblk;
+		map.m_pblk = 0;
+		map.m_flags = 0;

 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
-- 
2.49.0

Thanks,

>  			goto sync_out;
>  		case F2FS_GET_BLOCK_BMAP:
>  			map->m_pblk = 0;


