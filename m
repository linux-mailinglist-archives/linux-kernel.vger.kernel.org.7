Return-Path: <linux-kernel+bounces-829914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48220B982E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007C22E5DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CB1D5CF2;
	Wed, 24 Sep 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SxJvvQ4O"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82724167A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687442; cv=none; b=a/wvP1JGbSH8BlEWl2eCoVC2c0YbiZ1cBgxp3VSrLfgT/lkzREZZtNVqUkSZDVjdi6+PsMsBu9Ec7iX3WO4OR9GItU2uhp/xmmdilZaI77ITkWZbBU3aSoWo+AlmIEhuEiRuUCaM35UbXVSyydCQfJ4PTqsBChImoK9UkeIwdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687442; c=relaxed/simple;
	bh=NKHHQWLLO7iEsaIsR916DMhOaKE+fx0kwZEQxs9hNhg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=nB4EGk8s9TcTAneyL7agoiPJynY1fYIZeJwZiACbuKTBAWHG0FBwr8kHQHVFK4zj0cWKQDE0QWIPF34vnP+uqVpZkmYYpPpdicuaa+TcevBgvfgvBcYhrEh+7zy0VBKw2LH8mjBqdSGOwkVikoXD7a6KG/JbCm+vmTri7kAFIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SxJvvQ4O; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250924041710epoutp04d3621f6770ef9218b3be3aed6bf2d392~oHOZuUTas1890718907epoutp049
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250924041710epoutp04d3621f6770ef9218b3be3aed6bf2d392~oHOZuUTas1890718907epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758687430;
	bh=jYbjNYvDcvxUJIbV4CcVlf3jrFpR4g5YEjPmTZVG/mg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=SxJvvQ4OaCXCEpurWuC5N9CZrzFk2kwvdzhn/abhjeutuKKnay9ibwsZpN97I1aCj
	 N5mXZvuVgrspY0UDW3xtg7Zz5Y2G5IJYK5xmMqWMEwTWTF5SUxWxLIjVqQq3C6Knhf
	 B0oTQ9lGEydGGZhfuVkofNJwwwqqAXkLl6nIkUw0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20250924041710epcas1p31839db2ffc0bb57e6874cc1f490e85ae~oHOZcEOi70590605906epcas1p3c;
	Wed, 24 Sep 2025 04:17:10 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.36.227]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cWk855sfbz3hhTC; Wed, 24 Sep
	2025 04:17:09 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250924041709epcas1p487d175805cbfb988b556ae4034995747~oHOYbA3Ls1797517975epcas1p4I;
	Wed, 24 Sep 2025 04:17:09 +0000 (GMT)
Received: from yunji0kang01 (unknown [10.253.100.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250924041709epsmtip21da12bfd155b24fefb4dd00ea7cbbe94~oHOYYAMdS2684526845epsmtip2P;
	Wed, 24 Sep 2025 04:17:09 +0000 (GMT)
From: "Yunji Kang" <yunji0.kang@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, "'Sungjong Seo'" <sj1557.seo@samsung.com>,
	"'Sunmin	Jeong'" <s_min.jeong@samsung.com>
In-Reply-To: <89f237cd-3f86-405a-8f8f-d9cad250ef00@kernel.org>
Subject: RE: [PATCH v2] f2fs: readahead node blocks in
 F2FS_GET_BLOCK_PRECACHE mode
Date: Wed, 24 Sep 2025 13:17:08 +0900
Message-ID: <00d401dc2d0a$18100c20$48302460$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLJ+3fmt+QCibYu+QNx3C6/vuLkWQHN7bNGAg+MCJSypyzxwA==
Content-Language: ko
X-CMS-MailID: 20250924041709epcas1p487d175805cbfb988b556ae4034995747
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf
References: <CGME20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf@epcas1p1.samsung.com>
	<20250918082023.57381-1-yunji0.kang@samsung.com>
	<89f237cd-3f86-405a-8f8f-d9cad250ef00@kernel.org>

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
>=20
> Yunji,
>=20
> Will we gain better performance if we readahead more node pages w/
> sychronous request for precache extent case? Have you tried that?
>=20
> Thanks,
>=20

Does =E2=80=9Creadahead=20more=20node=20pages=E2=80=9D=20mean=20removing=20=
this=20condition?=0D=0A=22=20offset=5Bi=20-=201=5D=20%=20MAX_RA_NODE=20=3D=
=3D=200=20=22=0D=0A=0D=0AI=20originally=20added=20the=20condition=20to=20pr=
event=20unnecessary=20readahead=20requests,=20=0D=0Abut=20it=20seems=20this=
=20condition=20was=20actually=20blocking=20valid=20readahead=20as=20well.=
=0D=0A=0D=0AAfter=20removing=20the=20condition=20and=20running=20tests,=20=
=0D=0AI=20confirmed=20that=20more=20readahead=20node=20pages=20are=20being=
=20issued.=0D=0A=0D=0AI=E2=80=99ll=20share=20the=20test=20results=20along=
=20with=20the=20improved=20patch.=0D=0A=0D=0AThanks,=0D=0A=0D=0A>=20>=20Tes=
ted=20on=20a=20256GB=20mobile=20device=20with=20an=20SM8750=20chipset.=0D=
=0A>=20>=0D=0A>=20>=20Reviewed-by:=20Sungjong=20Seo=20<sj1557.seo=40samsung=
.com>=0D=0A>=20>=20Reviewed-by:=20Sunmin=20Jeong=20<s_min.jeong=40samsung.c=
om>=0D=0A>=20>=20Signed-off-by:=20Yunji=20Kang=20<yunji0.kang=40samsung.com=
>=0D=0A>=20>=20---=0D=0A>=20>=20v2:=0D=0A>=20>=20=20-=20Modify=20the=20read=
ahead=20condition=20check=20routine=20for=20better=20code=0D=0A>=20>=20read=
ability.=0D=0A>=20>=20=20-=20Update=20the=20title=20from=20'node=20block'=
=20to=20'node=20blocks'.=0D=0A>=20>=0D=0A>=20>=20=20fs/f2fs/data.c=20=7C=20=
3=20+++=0D=0A>=20>=20=20fs/f2fs/f2fs.h=20=7C=201=20+=0D=0A>=20>=20=20fs/f2f=
s/node.c=20=7C=205=20++++-=0D=0A>=20>=20=203=20files=20changed,=208=20inser=
tions(+),=201=20deletion(-)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/fs/f2f=
s/data.c=20b/fs/f2fs/data.c=20index=0D=0A>=20>=207961e0ddfca3..ab3117e3b24a=
=20100644=0D=0A>=20>=20---=20a/fs/f2fs/data.c=0D=0A>=20>=20+++=20b/fs/f2fs/=
data.c=0D=0A>=20>=20=40=40=20-1572,6=20+1572,9=20=40=40=20int=20f2fs_map_bl=
ocks(struct=20inode=20*inode,=20struct=0D=0A>=20f2fs_map_blocks=20*map,=20i=
nt=20flag)=0D=0A>=20>=20=20=09pgofs=20=3D=09(pgoff_t)map->m_lblk;=0D=0A>=20=
>=20=20=09end=20=3D=20pgofs=20+=20maxblocks;=0D=0A>=20>=0D=0A>=20>=20+=09if=
=20(flag=20=3D=3D=20F2FS_GET_BLOCK_PRECACHE)=0D=0A>=20>=20+=09=09mode=20=3D=
=20LOOKUP_NODE_PRECACHE;=0D=0A>=20>=20+=0D=0A>=20>=20=20next_dnode:=0D=0A>=
=20>=20=20=09if=20(map->m_may_create)=20=7B=0D=0A>=20>=20=20=09=09if=20(f2f=
s_lfs_mode(sbi))=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/f2fs.h=20b/fs/f2fs/f=
2fs.h=20index=0D=0A>=20>=209d3bc9633c1d..3ce41528d48e=20100644=0D=0A>=20>=
=20---=20a/fs/f2fs/f2fs.h=0D=0A>=20>=20+++=20b/fs/f2fs/f2fs.h=0D=0A>=20>=20=
=40=40=20-651,6=20+651,7=20=40=40=20enum=20=7B=0D=0A>=20>=20=20=09=09=09=09=
=09=20*=20look=20up=20a=20node=20with=20readahead=20called=0D=0A>=20>=20=20=
=09=09=09=09=09=20*=20by=20get_data_block.=0D=0A>=20>=20=20=09=09=09=09=09=
=20*/=0D=0A>=20>=20+=09LOOKUP_NODE_PRECACHE,=09=09/*=20look=20up=20a=20node=
=20for=0D=0A>=20F2FS_GET_BLOCK_PRECACHE=20*/=0D=0A>=20>=20=20=7D;=0D=0A>=20=
>=0D=0A>=20>=20=20=23define=20DEFAULT_RETRY_IO_COUNT=098=09/*=20maximum=20r=
etry=20read=20IO=20or=20flush=0D=0A>=20count=20*/=0D=0A>=20>=20diff=20--git=
=20a/fs/f2fs/node.c=20b/fs/f2fs/node.c=20index=0D=0A>=20>=204254db453b2d..d=
4bf3ce715c5=20100644=0D=0A>=20>=20---=20a/fs/f2fs/node.c=0D=0A>=20>=20+++=
=20b/fs/f2fs/node.c=0D=0A>=20>=20=40=40=20-860,7=20+860,10=20=40=40=20int=
=20f2fs_get_dnode_of_data(struct=20dnode_of_data=20*dn,=0D=0A>=20pgoff_t=20=
index,=20int=20mode)=0D=0A>=20>=20=20=09=09=09set_nid(parent,=20offset=5Bi=
=20-=201=5D,=20nids=5Bi=5D,=20i=20=3D=3D=201);=0D=0A>=20>=20=20=09=09=09f2f=
s_alloc_nid_done(sbi,=20nids=5Bi=5D);=0D=0A>=20>=20=20=09=09=09done=20=3D=
=20true;=0D=0A>=20>=20-=09=09=7D=20else=20if=20(mode=20=3D=3D=20LOOKUP_NODE=
_RA=20&&=20i=20=3D=3D=20level=20&&=20level=20>=201)=0D=0A>=20=7B=0D=0A>=20>=
=20+=09=09=7D=20else=20if=20((i=20=3D=3D=20level=20&&=20level=20>=201)=20&&=
=0D=0A>=20>=20+=09=09=09=09(mode=20=3D=3D=20LOOKUP_NODE_RA=20=7C=7C=0D=0A>=
=20>=20+=09=09=09=09(mode=20=3D=3D=20LOOKUP_NODE_PRECACHE=20&&=0D=0A>=20>=
=20+=09=09=09=09offset=5Bi=20-=201=5D=20%=20MAX_RA_NODE=20=3D=3D=200)))=20=
=7B=0D=0A>=20>=20=20=09=09=09nfolio=5Bi=5D=20=3D=20f2fs_get_node_folio_ra(p=
arent,=20offset=5Bi=20-=0D=0A>=201=5D);=0D=0A>=20>=20=20=09=09=09if=20(IS_E=
RR(nfolio=5Bi=5D))=20=7B=0D=0A>=20>=20=20=09=09=09=09err=20=3D=20PTR_ERR(nf=
olio=5Bi=5D);=0D=0A=0D=0A=0D=0A

