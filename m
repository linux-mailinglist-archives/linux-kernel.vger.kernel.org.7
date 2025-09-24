Return-Path: <linux-kernel+bounces-830045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A5B988EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6EA2E3E16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231527BF7E;
	Wed, 24 Sep 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O+hNl3GX"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147227B33B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699203; cv=none; b=oBioNWS4A17YJ2YFx9pcxKnqbauSVsdcSpTDfyJEc9Nj/TIdugHXLcqYhmzvqy8JNwnus0KLVOdnUo8566En4Qe61HVLk0sZdTxRRXmIcdEp2kpn7sOMS9oWuY479pUImhgj9BX1T1kDLeREaACozKfbzQee+QX4KCv45FCM8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699203; c=relaxed/simple;
	bh=oVWPhZMUOG/vSjp9gEV8cZEnbWTdab9AybPC3XGfFC4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=s7xAUV1/6ZLkTppTrLyVEh9zrpjO5ZR8XQRD8S+ISJWTt5sLQ72NtnS1CK9EpeX5ZEpCZkiRpalXO1TEwWA8qOtR2jnRt+zpyjOcEVWzkwJuhiv1b7uqOojPMQfe4W9gtu7ojw3dvxmHZWLAa+Ps8eVLQ5jIzTGjvDe3am3DGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O+hNl3GX; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250924073318epoutp01fcb5901d1d26be1e230e5d1916c7a284~oJ5pcATPS0332103321epoutp01D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:33:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250924073318epoutp01fcb5901d1d26be1e230e5d1916c7a284~oJ5pcATPS0332103321epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758699198;
	bh=WlJ7wJPElM3wc18LxgXDPA1uOvBE4Y5qrSSvIuBgqPU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=O+hNl3GXGik+2GkOhMQS9huZXifhJb/TA8ASBDKuuvWUP1fNi/oSWLFtGt/M8vcQV
	 3VvUObN27DlhhZbbuZvrkXkN3wH5b6Qqji+CdK0orIXa+58SJUQ6oNlb4V/MTkg669
	 K42uoCx0S45f095KSum7/1HCa6YOqL0CQ3zYdzSE=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250924073318epcas1p443b94281544243d7563664de3dc1ebe8~oJ5pHHPiN2870828708epcas1p49;
	Wed, 24 Sep 2025 07:33:18 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.240]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cWpVP4p1Lz6B9mc; Wed, 24 Sep
	2025 07:33:17 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250924073316epcas1p49fe9274ac2e9a2b576a57e2a373e491e~oJ5ntW95j2870828708epcas1p46;
	Wed, 24 Sep 2025 07:33:16 +0000 (GMT)
Received: from yunji0kang01 (unknown [10.253.100.171]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250924073316epsmtip1681e0b7812bd94b1fda707cfb0067197~oJ5nqK5D12247522475epsmtip1o;
	Wed, 24 Sep 2025 07:33:16 +0000 (GMT)
From: "Yunji Kang" <yunji0.kang@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, "'Sungjong Seo'" <sj1557.seo@samsung.com>,
	"'Sunmin Jeong'" <s_min.jeong@samsung.com>
In-Reply-To: <84d65c75-7ab7-4c0c-9085-9423effb8632@kernel.org>
Subject: RE: [PATCH v2] f2fs: readahead node blocks in
 F2FS_GET_BLOCK_PRECACHE mode
Date: Wed, 24 Sep 2025 16:33:16 +0900
Message-ID: <055101dc2d25$7e068a70$7a139f50$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLJ+3fmt+QCibYu+QNx3C6/vuLkWQHN7bNGAg+MCJQBrmMzkgIJQwVOsommwKA=
Content-Language: ko
X-CMS-MailID: 20250924073316epcas1p49fe9274ac2e9a2b576a57e2a373e491e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf
References: <CGME20250918082037epcas1p1eb201d3b6d5780c0bff3ba32740ccdcf@epcas1p1.samsung.com>
	<20250918082023.57381-1-yunji0.kang@samsung.com>
	<89f237cd-3f86-405a-8f8f-d9cad250ef00@kernel.org>
	<00d401dc2d0a$18100c20$48302460$@samsung.com>
	<84d65c75-7ab7-4c0c-9085-9423effb8632@kernel.org>

> On 9/24/25 12:17, Yunji Kang wrote:
> >>> In f2fs_precache_extents(), For large files, It requires reading
> >>> many node blocks. Instead of reading each node block with
> >>> synchronous I/O, this patch applies readahead so that node blocks
> >>> can be fetched in advance.
> >>>
> >>> It reduces the overhead of repeated sync reads and improves
> >>> efficiency when precaching extents of large files.
> >>>
> >>> I created a file with the same largest extent and executed the test.
> >>> For this experiment, I set the file's largest extent with an offset
> >>> of
> >>> 0 and a size of 1GB. I configured the remaining area with 100MB
> extents.
> >>>
> >>> 5GB test file:
> >>> dd if=3D/dev/urandom of=3Dtest1 bs=3D1m count=3D5120 cp test1 test2 f=
sync
> >>> test1 dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D1024 seek=3D1024 count=
=3D100
> >>> conv=3Dnotrunc dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D1224 seek=3D12=
24
> >>> count=3D100 conv=3Dnotrunc ...
> >>> dd if=3Dtest1 of=3Dtest2 bs=3D1m skip=3D5024 seek=3D5024 count=3D100
> >>> conv=3Dnotrunc reboot
> >>>
> >>> I also created 10GB and 20GB files with large extents using the same
> >>> method.
> >>>
> >>> ioctl(F2FS_IOC_PRECACHE_EXTENTS) test results are as follows:
> >>>   +-----------+---------+---------+-----------+
> >>>   =7C File size =7C Before  =7C After   =7C Reduction =7C
> >>>   +-----------+---------+---------+-----------+
> >>>   =7C 5GB       =7C 101.8ms =7C 72.1ms  =7C 29.2%     =7C
> >>>   =7C 10GB      =7C 222.9ms =7C 149.5ms =7C 32.9%     =7C
> >>>   =7C 20GB      =7C 446.2ms =7C 276.3ms =7C 38.1%     =7C
> >>>   +-----------+---------+---------+-----------+
> >>
> >> Yunji,
> >>
> >> Will we gain better performance if we readahead more node pages w/
> >> sychronous request for precache extent case? Have you tried that?
> >>
> >> Thanks,
> >>
> >
> > Does =E2=80=9Creadahead=20more=20node=20pages=E2=80=9D=20mean=20removin=
g=20this=20condition?=0D=0A>=20>=20=22=20offset=5Bi=20-=201=5D=20%=20MAX_RA=
_NODE=20=3D=3D=200=20=22=0D=0A>=20=0D=0A>=20Actually,=20I=20meant=20a)=20re=
move=20=22offset=5Bi=20-=201=5D=20%=20MAX_RA_NODE=20=3D=3D=200=22=20or=20b)=
=0D=0A>=20increase=20MAX_RA_NODE.=0D=0A>=20=0D=0A>=20Also,=20maybe=20we=20c=
an=20try=20as=20below=20to=20trigger=20synchronous=20IO=20for=20such=20high=
=0D=0A>=20determinacy=20read.=0D=0A>=20=0D=0A>=20void=20df2fs_ra_node_page(=
)=0D=0A>=20=7B=0D=0A>=20...=0D=0A>=20=09err=20=3D=20read_node_folio(afolio,=
=200);=0D=0A>=20...=0D=0A>=20=7D=0D=0A>=20=0D=0A=0D=0AI=E2=80=99m=20not=20s=
ure=20if=20I=20fully=20understood,=20but=20does=20this=20mean=20that=20in=
=20the=20case=20of=20precache,=20the=20readahead=20nodes=20are=20handled=20=
with=20sync=20reads?=0D=0AWith=20the=20current=20code,=20it=20seems=20diffi=
cult=20to=20implement=20this.=0D=0A=0D=0A>=20>=0D=0A>=20>=20I=20originally=
=20added=20the=20condition=20to=20prevent=20unnecessary=20readahead=0D=0A>=
=20>=20requests,=20but=20it=20seems=20this=20condition=20was=20actually=20b=
locking=20valid=0D=0A>=20readahead=20as=20well.=0D=0A>=20>=0D=0A>=20>=20Aft=
er=20removing=20the=20condition=20and=20running=20tests,=20I=20confirmed=20=
that=20more=0D=0A>=20>=20readahead=20node=20pages=20are=20being=20issued.=
=0D=0A>=20>=0D=0A>=20>=20I=E2=80=99ll=20share=20the=20test=20results=20alon=
g=20with=20the=20improved=20patch.=0D=0A>=20=0D=0A>=20It=20makes=20sense,=
=20thanks=20for=20checking=20this=20and=20sharing=20the=20result.=0D=0A>=20=
=0D=0A>=20Thanks,=0D=0A>=20=0D=0A=0D=0AI=20tested=20with=20the=20revised=20=
v3=20code=20and=20confirmed=20that=20most=20node=20pages=20are=20now=20hand=
led=20by=20readahead.=20=0D=0A(In=20the=20v2=20version,=20only=20about=20ha=
lf=20of=20nodes=20were=20processed=20with=20readahead.)=0D=0A=0D=0AThank=20=
you=20for=20your=20review.=0D=0A=0D=0A>=20>=0D=0A>=20>=20Thanks,=0D=0A>=20>=
=0D=0A>=20>>>=20Tested=20on=20a=20256GB=20mobile=20device=20with=20an=20SM8=
750=20chipset.=0D=0A>=20>>>=0D=0A>=20>>>=20Reviewed-by:=20Sungjong=20Seo=20=
<sj1557.seo=40samsung.com>=0D=0A>=20>>>=20Reviewed-by:=20Sunmin=20Jeong=20<=
s_min.jeong=40samsung.com>=0D=0A>=20>>>=20Signed-off-by:=20Yunji=20Kang=20<=
yunji0.kang=40samsung.com>=0D=0A>=20>>>=20---=0D=0A>=20>>>=20v2:=0D=0A>=20>=
>>=20=20-=20Modify=20the=20readahead=20condition=20check=20routine=20for=20=
better=20code=0D=0A>=20>>>=20readability.=0D=0A>=20>>>=20=20-=20Update=20th=
e=20title=20from=20'node=20block'=20to=20'node=20blocks'.=0D=0A>=20>>>=0D=
=0A>=20>>>=20=20fs/f2fs/data.c=20=7C=203=20+++=0D=0A>=20>>>=20=20fs/f2fs/f2=
fs.h=20=7C=201=20+=0D=0A>=20>>>=20=20fs/f2fs/node.c=20=7C=205=20++++-=0D=0A=
>=20>>>=20=203=20files=20changed,=208=20insertions(+),=201=20deletion(-)=0D=
=0A>=20>>>=0D=0A>=20>>>=20diff=20--git=20a/fs/f2fs/data.c=20b/fs/f2fs/data.=
c=20index=0D=0A>=20>>>=207961e0ddfca3..ab3117e3b24a=20100644=0D=0A>=20>>>=
=20---=20a/fs/f2fs/data.c=0D=0A>=20>>>=20+++=20b/fs/f2fs/data.c=0D=0A>=20>>=
>=20=40=40=20-1572,6=20+1572,9=20=40=40=20int=20f2fs_map_blocks(struct=20in=
ode=20*inode,=0D=0A>=20>>>=20struct=0D=0A>=20>>=20f2fs_map_blocks=20*map,=
=20int=20flag)=0D=0A>=20>>>=20=20=09pgofs=20=3D=09(pgoff_t)map->m_lblk;=0D=
=0A>=20>>>=20=20=09end=20=3D=20pgofs=20+=20maxblocks;=0D=0A>=20>>>=0D=0A>=
=20>>>=20+=09if=20(flag=20=3D=3D=20F2FS_GET_BLOCK_PRECACHE)=0D=0A>=20>>>=20=
+=09=09mode=20=3D=20LOOKUP_NODE_PRECACHE;=0D=0A>=20>>>=20+=0D=0A>=20>>>=20=
=20next_dnode:=0D=0A>=20>>>=20=20=09if=20(map->m_may_create)=20=7B=0D=0A>=
=20>>>=20=20=09=09if=20(f2fs_lfs_mode(sbi))=0D=0A>=20>>>=20diff=20--git=20a=
/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.h=20index=0D=0A>=20>>>=209d3bc9633c1d..3ce=
41528d48e=20100644=0D=0A>=20>>>=20---=20a/fs/f2fs/f2fs.h=0D=0A>=20>>>=20+++=
=20b/fs/f2fs/f2fs.h=0D=0A>=20>>>=20=40=40=20-651,6=20+651,7=20=40=40=20enum=
=20=7B=0D=0A>=20>>>=20=20=09=09=09=09=09=20*=20look=20up=20a=20node=20with=
=20readahead=20called=0D=0A>=20>>>=20=20=09=09=09=09=09=20*=20by=20get_data=
_block.=0D=0A>=20>>>=20=20=09=09=09=09=09=20*/=0D=0A>=20>>>=20+=09LOOKUP_NO=
DE_PRECACHE,=09=09/*=20look=20up=20a=20node=20for=0D=0A>=20>>=20F2FS_GET_BL=
OCK_PRECACHE=20*/=0D=0A>=20>>>=20=20=7D;=0D=0A>=20>>>=0D=0A>=20>>>=20=20=23=
define=20DEFAULT_RETRY_IO_COUNT=098=09/*=20maximum=20retry=20read=20IO=20or=
=0D=0A>=20flush=0D=0A>=20>>=20count=20*/=0D=0A>=20>>>=20diff=20--git=20a/fs=
/f2fs/node.c=20b/fs/f2fs/node.c=20index=0D=0A>=20>>>=204254db453b2d..d4bf3c=
e715c5=20100644=0D=0A>=20>>>=20---=20a/fs/f2fs/node.c=0D=0A>=20>>>=20+++=20=
b/fs/f2fs/node.c=0D=0A>=20>>>=20=40=40=20-860,7=20+860,10=20=40=40=20int=20=
f2fs_get_dnode_of_data(struct=20dnode_of_data=0D=0A>=20>>>=20*dn,=0D=0A>=20=
>>=20pgoff_t=20index,=20int=20mode)=0D=0A>=20>>>=20=20=09=09=09set_nid(pare=
nt,=20offset=5Bi=20-=201=5D,=20nids=5Bi=5D,=20i=20=3D=3D=201);=0D=0A>=20>>>=
=20=20=09=09=09f2fs_alloc_nid_done(sbi,=20nids=5Bi=5D);=0D=0A>=20>>>=20=20=
=09=09=09done=20=3D=20true;=0D=0A>=20>>>=20-=09=09=7D=20else=20if=20(mode=
=20=3D=3D=20LOOKUP_NODE_RA=20&&=20i=20=3D=3D=20level=20&&=20level=20>=201)=
=0D=0A>=20>>=20=7B=0D=0A>=20>>>=20+=09=09=7D=20else=20if=20((i=20=3D=3D=20l=
evel=20&&=20level=20>=201)=20&&=0D=0A>=20>>>=20+=09=09=09=09(mode=20=3D=3D=
=20LOOKUP_NODE_RA=20=7C=7C=0D=0A>=20>>>=20+=09=09=09=09(mode=20=3D=3D=20LOO=
KUP_NODE_PRECACHE=20&&=0D=0A>=20>>>=20+=09=09=09=09offset=5Bi=20-=201=5D=20=
%=20MAX_RA_NODE=20=3D=3D=200)))=20=7B=0D=0A>=20>>>=20=20=09=09=09nfolio=5Bi=
=5D=20=3D=20f2fs_get_node_folio_ra(parent,=20offset=5Bi=20-=0D=0A>=20>>=201=
=5D);=0D=0A>=20>>>=20=20=09=09=09if=20(IS_ERR(nfolio=5Bi=5D))=20=7B=0D=0A>=
=20>>>=20=20=09=09=09=09err=20=3D=20PTR_ERR(nfolio=5Bi=5D);=0D=0A>=20>=0D=
=0A>=20>=0D=0A>=20>=0D=0A=0D=0A=0D=0A

