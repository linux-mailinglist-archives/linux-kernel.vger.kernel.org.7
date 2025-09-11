Return-Path: <linux-kernel+bounces-811526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CACFB52A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262CA169580
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582A27F01E;
	Thu, 11 Sep 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="LhkM5LUH"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B727E1B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576581; cv=none; b=WqJ/46ks4oQSQltUcHpuoA7tOBLv0Zg4Y30agnMalD6JDNN/UTDOz48BDmhBhjtqvMzyYJe9koNB+u8mdHm0pFwgElTlrmhfwOrWFgxT5S7gindyyvJ3B9PDifhecYCuOFgBQL0WErRSvx4xrX0pDOcjPEhJipqN9JihGfPj50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576581; c=relaxed/simple;
	bh=MkvcQ50YWIEzEBz0+ep1N4cuIISAK/90vleTXfLxas4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qcnf4fRcthbHsrP28WmQMnqvobNy9fkWOB8PEgaT5DrEh92udi+wS9v+VqI84WKKz3xxGMhp6cUWtg70yBuHA5JWT7nIi4YWsGtcFC3iCIR1Y4pDvAle5cBZsGFOdLZf915S2/2mkbp5TdX+N3rHPb39OSI6+PGCwQeMabqrepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=LhkM5LUH; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=/nIAUlfMJKzaQDwsPUuGN9VRDGJYAdNEzEXEqdePAQ8=;
	b=LhkM5LUHiIHF8FvVTi1e5YaHlF2Jt3kBoPMPvdsNK9IFb2PsOvNaUpLYMQ/uDUL4GuOP/S+5t
	TSNMFe7p0pHkQA88K7mCGGju1J0FeZXk9RXykMOj48W6ubTCqZEDhEpzSUn1z7LhDK7yjZReU9D
	wRU3Dg6DDOZmDldLHSfh+og=
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cMqJt0Yl1zYl4ZW;
	Thu, 11 Sep 2025 15:42:22 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 15:42:39 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 15:42:39 +0800
From: wangzijie <wangzijie1@honor.com>
To: <linux-f2fs-devel@lists.sourceforge.net>
CC: <chao@kernel.org>, <feng.han@honor.com>, <jaegeuk@kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangzijie1@honor.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong extent_info data for precache extents
Date: Thu, 11 Sep 2025 15:42:39 +0800
Message-ID: <20250911074239.2933899-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ad627632-298e-428b-9cfa-a5b5b50c147e@kernel.org>
References: <ad627632-298e-428b-9cfa-a5b5b50c147e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
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
> 
> Hi Zijie,
> 
> I tried to reproduce w/ below steps:
> 
> f2fs_io write 1 0 1881 rand dsync testfile
> f2fs_io write 1 1881 1 rand buffered testfile
> f2fs_io fallocate 0 7708672 4096 testfile
> umount
> mount
> f2fs_io precache_extents testfile
> 
>          f2fs_io-921     [013] .....  1049.855817: f2fs_lookup_start: dev = (253,16), pino = 3, name:testfile, flags:65537
>          f2fs_io-921     [013] .....  1049.855870: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), DATA, sector = 139280, size = 4096
>          f2fs_io-921     [013] .....  1049.856116: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x5, oldaddr = 0x5553, newaddr = 0x5553, rw = READ(), type = HOT_NODE
>          f2fs_io-921     [013] .....  1049.856147: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174744, size = 4096
>          f2fs_io-921     [013] .....  1049.856273: f2fs_iget: dev = (253,16), ino = 5, pino = 3, i_mode = 0x81ed, i_size = 7712768, i_nlink = 1, i_blocks = 15080, i_advise = 0x0
>          f2fs_io-921     [013] .....  1049.856305: f2fs_lookup_end: dev = (253,16), pino = 3, name:testfile, ino:5, err:0
>          f2fs_io-921     [013] .....  1049.856316: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 0, type = Read
>          f2fs_io-921     [013] .....  1049.856317: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 0, read_ext_info(fofs: 0, len: 512, blk: 1055744)
>          f2fs_io-921     [013] .....  1049.856317: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 0, start blkaddr = 0x101c00, len = 0x200, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>          f2fs_io-921     [013] .....  1049.856318: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 512, type = Read
>          f2fs_io-921     [013] .....  1049.856318: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 512, read_ext_info(fofs: 0, len: 0, blk: 0)
>          f2fs_io-921     [013] .....  1049.856323: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 512, len = 352, blkaddr = 18432, c_len = 0
>          f2fs_io-921     [013] .....  1049.856328: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x6, oldaddr = 0x5556, newaddr = 0x5556, rw = READ(), type = HOT_NODE
>          f2fs_io-921     [013] .....  1049.856329: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174768, size = 4096
>          f2fs_io-921     [021] .....  1049.856968: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 864, len = 160, blkaddr = 18784, c_len = 0
>          f2fs_io-921     [021] .....  1049.857002: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 512, start blkaddr = 0x4800, len = 0x200, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>          f2fs_io-921     [021] .....  1049.857003: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1025, type = Read
>          f2fs_io-921     [021] .....  1049.857004: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1025, read_ext_info(fofs: 0, len: 0, blk: 0)
>          f2fs_io-921     [021] .....  1049.857010: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 1025, len = 511, blkaddr = 19457, c_len = 0
>          f2fs_io-921     [021] .....  1049.857011: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1025, start blkaddr = 0x4c01, len = 0x1ff, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>          f2fs_io-921     [021] .....  1049.857012: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1537, type = Read
>          f2fs_io-921     [021] .....  1049.857012: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1537, read_ext_info(fofs: 0, len: 0, blk: 0)
>          f2fs_io-921     [021] .....  1049.857016: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 5, pgofs = 1537, len = 344, blkaddr = 20993, c_len = 0
>          f2fs_io-921     [021] .....  1049.857016: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1537, start blkaddr = 0x5201, len = 0x158, flags = 2, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
>          f2fs_io-921     [021] .....  1049.857017: f2fs_lookup_extent_tree_start: dev = (253,16), ino = 5, pgofs = 1882, type = Read
>          f2fs_io-921     [021] .....  1049.857017: f2fs_lookup_read_extent_tree_end: dev = (253,16), ino = 5, pgofs = 1882, read_ext_info(fofs: 0, len: 0, blk: 0)
>          f2fs_io-921     [021] .....  1049.857024: f2fs_submit_folio_bio: dev = (253,16), ino = 1, folio_index = 0x7, oldaddr = 0x5555, newaddr = 0x5555, rw = READ(), type = HOT_NODE
>          f2fs_io-921     [021] .....  1049.857026: f2fs_submit_read_bio: dev = (253,16)/(253,16), rw = READ(), NODE, sector = 174760, size = 4096
>          f2fs_io-921     [021] .....  1049.857156: f2fs_map_blocks: dev = (253,16), ino = 5, file offset = 1882, start blkaddr = 0x5201, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 6, err = 0
> 
> It seems f2fs_update_read_extent_tree_range() won't insert a zero-sized extent?
> Or am I missing something?
> 
> Thanks,

From the trace, it seems that the data layout is not like what I described?

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
> >  			goto sync_out;
> >  		case F2FS_GET_BLOCK_BMAP:
> >  			map->m_pblk = 0;



