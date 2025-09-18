Return-Path: <linux-kernel+bounces-822038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FFAB82EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A91BC6FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52AE274641;
	Thu, 18 Sep 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CSIr6b7F"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D217A310
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171354; cv=none; b=Xn91WOibSBveeSYZYPHpEJ/aMrenemqku/VvfOa3ospPbaSeEudCdGHyr7aLv+b/ArC50HJlVcprOyry6oTkMh1nPG8UjFtSdG73VnWeyqxZ64H7CWzMzWLkw182fFvq2URxJlrxk0nrCPQnfq/+R745qDZ6bkj1aKNZ91+iy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171354; c=relaxed/simple;
	bh=6glWsPn+/Z8BQ0j7MY6JIDYXrf9ocQQxhqphGuoxQbg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=BJVWOA8EM3kWXHQNNT88zqtyhGZqL71wHRY5RHVe0mR9hZqwnAsYQlhZGS1xGtqavtiqct1gppLOx79+7+Flfsor5f1ZqNB0L/LQm3Gy/ynv4N8pYLJnC5iqG8mJjqi9Zp9t9ZaqGBV+sXFX2UHWWHWFM2Fr0Ms9Ch2kkZdL0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CSIr6b7F; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250918045546epoutp02455343bd23e23c96c26437959a09db54~mR4ZI9VTT0060200602epoutp02o
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250918045546epoutp02455343bd23e23c96c26437959a09db54~mR4ZI9VTT0060200602epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758171346;
	bh=Zefas1JuGiUdEFTbKhZnv+ZVIOySC9g42o1FgVXKi8U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=CSIr6b7Fi9L/y3bWgOaOXCyXlH0zCSLmyBuhcWL6TA2EJmmwuLHl/slfF80k5VFlv
	 UfLNJ4DCYyuooTJGtTpte4C6JcWFU73xqvO3XDiuAx/MBPTfVjtg0QKSxwHz1lagwE
	 lWe+T1ZAyoNx5CoxCjKLlRpAI8Lxv4TKqJs7+CPk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20250918045546epcas1p378af9aae47cab22e9f998f4efd2254b6~mR4Y2dbiW2531025310epcas1p3s;
	Thu, 18 Sep 2025 04:55:46 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.247]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cS3HQ1WX0z2SSKX; Thu, 18 Sep
	2025 04:55:46 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250918045545epcas1p4c45f2104438d05dbb02f9cfb92cae8c6~mR4YMpbGq0638406384epcas1p4a;
	Thu, 18 Sep 2025 04:55:45 +0000 (GMT)
Received: from yunji0kang01 (unknown [10.253.100.171]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250918045545epsmtip13d05c5d1c33b18a3a7bef7a56b69ab42~mR4YJVSxw0616806168epsmtip1P;
	Thu, 18 Sep 2025 04:55:45 +0000 (GMT)
From: "Yunji Kang" <yunji0.kang@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, "'Sungjong Seo'" <sj1557.seo@samsung.com>,
	"'Sunmin	Jeong'" <s_min.jeong@samsung.com>
In-Reply-To: <de32bc26-6424-4750-83f7-17956e6727cd@kernel.org>
Subject: RE: [PATCH] f2fs: readahead node block in F2FS_GET_BLOCK_PRECACHE
 mode
Date: Thu, 18 Sep 2025 13:55:45 +0900
Message-ID: <000a01dc2858$7e50f460$7af2dd20$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHGlTO1sK2WH87Ru+8OHbgyt7E/JwJw0GzGAYBuEl+0o/nd0A==
Content-Language: ko
X-CMS-MailID: 20250918045545epcas1p4c45f2104438d05dbb02f9cfb92cae8c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448
References: <CGME20250917055237epcas1p2faa1b3d6555ffc5179c700e7a2afd448@epcas1p2.samsung.com>
	<20250917055217.39960-1-yunji0.kang@samsung.com>
	<de32bc26-6424-4750-83f7-17956e6727cd@kernel.org>

> > In f2fs_precache_extents(), For large files, It requires reading many
> > node blocks. Instead of reading each node block with synchronous I/O,
> > this patch applies readahead so that node blocks can be fetched in
> > advance.
> >
> > It reduces the overhead of repeated sync reads and improves efficiency
> > when precaching extents of large files.
> >
> > I created a file with the same largest extent and executed the test.
> > For this experiment, I set the file's largest extent with an offset of
> > 0 and a size of 1GB. I configured the remaining area with 100MB extents=
.
> >
> > 5GB test file:
> > dd if=3D/dev/urandom of=3Dtest1 bs=3D1m count=3D5120 cp test1 test2 fsy=
nc
> > test1 dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D1024 seek=3D1024 count=3D=
100
> > conv=3Dnotrunc dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D1224 seek=3D1224=
 count=3D100
> > conv=3Dnotrunc ...
> > dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D5024 seek=3D5024 count=3D100 co=
nv=3Dnotrunc
> > reboot
> >
> > I also created 10GB and 20GB files with large extents using the same
> > method.
> >
> > ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
> >   +-----------+---------+---------+-----------+
> >   =7C File size =7C Before  =7C After   =7C Reduction =7C
> >   +-----------+---------+---------+-----------+
> >   =7C 5GB       =7C 101.8ms =7C 72.1ms  =7C 29.2%     =7C
> >   =7C 10GB      =7C 222.9ms =7C 149.5ms =7C 32.9%     =7C
> >   =7C 20GB      =7C 446.2ms =7C 276.3ms =7C 38.1%     =7C
> >   +-----------+---------+---------+-----------+
> > Tested on a 256GB mobile device with an SM8750 chipset.
> >
> > Reviewed-by: Sungjong Seo <sj1557.seo=40samsung.com>
> > Reviewed-by: Sunmin Jeong <s_min.jeong=40samsung.com>
> > Signed-off-by: Yunji Kang <yunji0.kang=40samsung.com>
> > ---
> >  fs/f2fs/data.c =7C 3 +++
> >  fs/f2fs/f2fs.h =7C 1 +
> >  fs/f2fs/node.c =7C 4 +++-
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index
> > 7961e0ddfca3..ab3117e3b24a 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > =40=40 -1572,6 +1572,9 =40=40 int f2fs_map_blocks(struct inode *inode, =
struct
> f2fs_map_blocks *map, int flag)
> >  	pgofs =3D	(pgoff_t)map->m_lblk;
> >  	end =3D pgofs + maxblocks;
> >
> > +	if (flag =3D=3D F2FS_GET_BLOCK_PRECACHE)
> > +		mode =3D LOOKUP_NODE_PRECACHE;
> > +
> >  next_dnode:
> >  	if (map->m_may_create) =7B
> >  		if (f2fs_lfs_mode(sbi))
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
> > 9d3bc9633c1d..3ce41528d48e 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > =40=40 -651,6 +651,7 =40=40 enum =7B
> >  					 * look up a node with readahead called
> >  					 * by get_data_block.
> >  					 */
> > +	LOOKUP_NODE_PRECACHE,		/* look up a node for
> F2FS_GET_BLOCK_PRECACHE */
> >  =7D;
> >
> >  =23define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush
> count */
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index
> > 4254db453b2d..50be167e5c59 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > =40=40 -860,7 +860,9 =40=40 int f2fs_get_dnode_of_data(struct dnode_of_=
data *dn,
> pgoff_t index, int mode)
> >  			set_nid(parent, offset=5Bi - 1=5D, nids=5Bi=5D, i =3D=3D 1);
> >  			f2fs_alloc_nid_done(sbi, nids=5Bi=5D);
> >  			done =3D true;
> > -		=7D else if (mode =3D=3D LOOKUP_NODE_RA && i =3D=3D level && level >=
 1)
> =7B
> > +		=7D else if ((mode =3D=3D LOOKUP_NODE_RA =7C=7C
>=20
> Does this change the logic for mode =3D LOOKUP_NODE_RA?
>=20
> Not sure, do you mean this?
>=20
> 	if ((i =3D=3D level && level > 1) &&
> 		(mode =3D=3D LOOKUP_NODE_RA =7C=7C
> 		(mode =3D=3D LOOKUP_NODE_PRECACHE &&
> 		offset=5Bi - 1=5D % MAX_RA_NODE =3D=3D 0)))
>=20
> Thanks,
>=20
> > +				(mode =3D=3D LOOKUP_NODE_PRECACHE && offset=5Bi - 1=5D %
> MAX_RA_NODE =3D=3D 0))
> > +				&& i =3D=3D level && level > 1) =7B
> >  			nfolio=5Bi=5D =3D f2fs_get_node_folio_ra(parent, offset=5Bi -
> 1=5D);
> >  			if (IS_ERR(nfolio=5Bi=5D)) =7B
> >  				err =3D PTR_ERR(nfolio=5Bi=5D);

I think the code has the same meaning.
The version you wrote looks more readable, so would it be okay if I change =
the patch with your code?

Also, I did not change the logic for mode =3D LOOKUP_NODE_RA; I only added =
a condition for when readahead is performed.

Thanks.


