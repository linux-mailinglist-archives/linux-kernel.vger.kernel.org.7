Return-Path: <linux-kernel+bounces-811695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF160B52CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CD3166C14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D42E7BC3;
	Thu, 11 Sep 2025 09:07:52 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE22E7646
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581672; cv=none; b=oR8RwBFA4OY9AsNM2BA1EEqhxfmXw3mGPwjCay7679EvqQQ1Uk2mXAIed2RpHx3Uh1+zobNTRaB2IAqkpmMZifOn2IXCCH5PQDgFb5yX1TkQnA6gP7VimsqEUV78NGUNspJi8L6mM5NUU8vGY0mCDsaVyHsaYtV8dSwMCkR74fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581672; c=relaxed/simple;
	bh=g93+47jtM8NMRlfT9ZE2/XFtWHMhiAC4W2jZnhxabz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGCG/skV6QkuPEgKIOv9stopD3iqf2/omzl61WapO7Jy+33PoEOIkCRbq2jXLXQsuL6QiOqCm/+TFibb2OqgB7Ope9i6x2JkkT6sS6GpFWMlXX2K0F1bv5YjQTJFz68QTbFTehCVID9RBKSfn/lDM1O4W9lWK5Z2xM7c0JVSJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cMsBv2bWFzYlNNL;
	Thu, 11 Sep 2025 17:07:19 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 17:07:46 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 17:07:45 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for precache extents
Date: Thu, 11 Sep 2025 17:07:45 +0800
Message-ID: <20250911090745.2940557-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <228203f5-d3bf-46fb-b990-3de2eb2ff3e8@kernel.org>
References: <228203f5-d3bf-46fb-b990-3de2eb2ff3e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a011.hihonor.com
 (10.68.31.243)

> On 9/10/25 21:58, wangzijie wrote:
> > When the data layout is like this:
> > dnode1:                     dnode2:
> > [0]      A                  [0]    NEW_ADDR
> > [1]      A+1                [1]    0x0
> > ...                         ....
> > [1016]   A+1016
> > [1017]   B (B!=A+1017)      [1017] 0x0
> > 
> > We can build this kind of layout by following steps(with i_extra_isize:36):
> > ./f2fs_io write 1 0 1881 rand dsync testfile
> > ./f2fs_io write 1 1881 1 rand buffered testfile
> > ./f2fs_io fallocate 0 7708672 4096 testfile
> > 
> > And when we map first data block in dnode2, we will get wrong extent_info data:
> > map->m_len = 1
> > ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
> > 
> > ei.fofs = start_pgofs = 1882
> > ei.len = map->m_len - ofs = 1 - 1 = 0
> > 
> > Fix it by skipping updating this kind of extent info.
> > 
> > Signed-off-by: wangzijie <wangzijie1@honor.com>
> > ---
> >  fs/f2fs/data.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 7961e0ddf..b8bb71852 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1649,6 +1649,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
> >  
> >  		switch (flag) {
> >  		case F2FS_GET_BLOCK_PRECACHE:
> > +			if (__is_valid_data_blkaddr(map->m_pblk) &&
> > +				start_pgofs - map->m_lblk == map->m_len)
> > +				map->m_flags &= ~F2FS_MAP_MAPPED;
> 
> It looks we missed to reset value for map variable in f2fs_precache_extents(),
> what do you think of this?
> 
> ---
>  fs/f2fs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1aae4361d0a8..2b14151d4130 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3599,7 +3599,7 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>  int f2fs_precache_extents(struct inode *inode)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	struct f2fs_map_blocks map;
> +	struct f2fs_map_blocks map = { 0 };
>  	pgoff_t m_next_extent;
>  	loff_t end;
>  	int err;
> @@ -3617,6 +3617,8 @@ int f2fs_precache_extents(struct inode *inode)
> 
>  	while (map.m_lblk < end) {
>  		map.m_len = end - map.m_lblk;
> +		map.m_pblk = 0;
> +		map.m_flags = 0;
> 
>  		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>  		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
> -- 
> 2.49.0
> 
> Thanks,
> 
> >  			goto sync_out;
> >  		case F2FS_GET_BLOCK_BMAP:
> >  			map->m_pblk = 0;


We have already reset m_flags (map->m_flags = 0) in f2fs_map_blocks().

I think that this bug is caused by we missed to reset m_flags when we
goto next_dnode in below case：

Data layout is something like this:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

we map the last block(valid blkaddr) in dnode1:
map->m_flags |= F2FS_MAP_MAPPED;
map->m_pblk = blkaddr(valid blkaddr);
map->m_len = 1;
then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
map->m_flags & F2FS_MAP_MAPPED == true, and we make wrong blkaddr/len for extent_info.

