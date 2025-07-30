Return-Path: <linux-kernel+bounces-750103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D7B15756
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCEC3A1B66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB722318;
	Wed, 30 Jul 2025 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LiSxqmh+"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63C1A3154
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840504; cv=none; b=LRGeSfc1YpRLotnsARCWMF3RHQrQ8o1D9IxFKf+fR0TiqdT3a0hXGCdGqjkWc/WMktyRbvev7fTto6XTz5LetWNaCRK7sQh3MFYbD/YmmibtqGdhMMvtZtmTM5N++ukjH9t0rLUrBbxq8E91Iq3+hfHNE9P9L7j48nc7HBdPXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840504; c=relaxed/simple;
	bh=mkmA8L5rsx2MksgjFal39snv5i1UbsJ3M4tQZEhMjxs=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=Qio7gfFb25EVTkFFDwN0whx4qCFPWJQ5pMq4EDhZqIthdc8s5m5+5yIF0AV2Z3FKueRgSHymAv4DjYzj5fj0kq2m54NNJC6xWT7bZXVm04eyV6EOEVOOVv5E3e2o84noBuLw4N5tq4Unrti/sJ/LkYrmwiLuSHeupgRDa8y9c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LiSxqmh+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250730015458epoutp010fc47a8e581bf1fc28e2db567769cba9~W5KQwp-nW0481004810epoutp01Z
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:54:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250730015458epoutp010fc47a8e581bf1fc28e2db567769cba9~W5KQwp-nW0481004810epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753840498;
	bh=mkmA8L5rsx2MksgjFal39snv5i1UbsJ3M4tQZEhMjxs=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=LiSxqmh+ZPIM3WXBGd2858RoeKQitcx9ZWHJ7kRsBhbrMYzw0cjqZ39O8xt4DMnFc
	 YWKYq+dnKhT/569s6gDzyWEk+e/n6F8/doD8aBovp+IGBxZrXrIVjra4OQcmgY0c2V
	 LMmVVtKCpeFShZPVINAfHgwdCjI8QBBpDthvAwiA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250730015458epcas2p1331d15b6c940b2d88cfed36dcc7d56f6~W5KQfPUgJ0505705057epcas2p16;
	Wed, 30 Jul 2025 01:54:58 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bsFdt0qHSz6B9mK; Wed, 30 Jul
	2025 01:54:58 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] f2fs: don't break allocation when crossing contiguous
 sections
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250721020231.2482090-1-chao@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b@epcms2p6>
Date: Wed, 30 Jul 2025 10:53:57 +0900
X-CMS-MailID: 20250730015357epcms2p63d8a9d98265a526f959e33fa2d7c610b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721020241epcas2p1481962181d9f81f127e122736923fe20
References: <20250721020231.2482090-1-chao@kernel.org>
	<CGME20250721020241epcas2p1481962181d9f81f127e122736923fe20@epcms2p6>

Hi Chao Yu,

> + =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0lfs_dio_write=20=3D=20(flag=20=3D=3D=
=20F2FS_GET_BLOCK_DIO=20&&=20f2fs_lfs_mode(sbi)=20&&=0D=0A>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0map->m_may_create)=
;=0D=0A>=20+=0D=0A=0D=0AConsider=20moving=20the=20lfs_dio_write=20assignmen=
t=20to=20just=20after=20the=20if=20(=21map->m_may_create=20=E2=80=A6)=20che=
ck=0D=0Aso=20it=20isn=E2=80=99t=20evaluated=20when=20creation=20isn=E2=80=
=99t=20allowed.=0D=0A=0D=0A>=20=40=40=20-4171,6=20+4172,10=20=40=40=20stati=
c=20int=20f2fs_iomap_begin(struct=20inode=20*inode,=20loff_t=20offset,=20lo=
ff_t=20length,=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0map.m_nex=
t_pgofs=20=3D=20&next_pgofs;=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0map.m_seg_type=20=3D=20f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),=0D=
=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0inode->i_write_hint);=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0i=
f=20(flags=20&=20IOMAP_WRITE=20&&=20iomap->private)=20=7B=0D=0A=0D=0ASince=
=20iomap->private=20is=20only=20set=20on=20the=20LFS=20DIO=20path,=20you=20=
can=20drop=20the=20flags=20&=20IOMAP_WRITE=20and=0D=0Atest=20the=20pointer=
=20directly.=0D=0A=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0map.m_last_pblk=20=3D=20(unsigned=20long)iomap->=
private;=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0iomap->private=20=3D=20NULL;=0D=0A>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=7D=0D=0A>=20=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0/*=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20If=20=
the=20blocks=20being=20overwritten=20are=20already=20allocated,=0D=0A>=20=
=40=40=20-4209,6=20+4214,9=20=40=40=20static=20int=20f2fs_iomap_begin(struc=
t=20inode=20*inode,=20loff_t=20offset,=20loff_t=20length,=0D=0A>=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0iom=
ap->flags=20=3D=20IOMAP_F_MERGED;=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0iomap->bdev=20=3D=20map.m_b=
dev;=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0iomap->addr=20=3D=20F2FS_BLK_TO_BYTES(map.m_pblk);=0D=0A>=
=20+=0D=0A>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(flags=20&=20IOMAP_WRITE=20&&=20map.m_last_pblk)=0D=0A>=20=
+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0iomap->private=20=3D=20(void=20*)map.m_=
last_pblk;=0D=0A=0D=0ALikewise,=20checking=20only=20map.m_last_pblk=20is=20=
sufficient=20for=20restoring.=0D=0A=0D=0AReviewed-by:=20Daejun=20Park=20<da=
ejun7.park=40samsung.com>=0D=0A

