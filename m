Return-Path: <linux-kernel+bounces-894918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782F4C4C711
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5819189A995
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B32EA470;
	Tue, 11 Nov 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JdTja2uW"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E832ABD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850668; cv=none; b=rEf8fWgGD8y58c80OIWIx2V6M+MSna+4LaJikjUFq3SemLKTIqpTdThB3JnZoPPDcBjn1S/U4Ts3l+uTWq3IXjc/dqIAHPeCvcwlrx7MTJJStD5cUq+s633s+lYzv300xGxYUAIRrwovfAn34t12DISsW5S0Gh7sjpNX0VoT/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850668; c=relaxed/simple;
	bh=djS6r7wvJCuCRtyWyGjDglCHV7B+bjB3EVQ0JfgIzug=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=d2XsfzeOAoXGKjEWiepP//vUwzwyz45NmT5S6gBWyMUQ3BKy94bCx7/naJY8HjRvQQ+GBxAnS0/pOGYm2DUInwrWgc/MIVc31lC9G0HyXhiHUX11e/gB7hJ6JMh8zwf3bYFvoFvzKK2FktTgOXiuGaCukHqRxSGdximAuWmYkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JdTja2uW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251111084417epoutp03762119ad4507d336762298917e76e0da~251VbmpWS0631106311epoutp03v
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251111084417epoutp03762119ad4507d336762298917e76e0da~251VbmpWS0631106311epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762850657;
	bh=djS6r7wvJCuCRtyWyGjDglCHV7B+bjB3EVQ0JfgIzug=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=JdTja2uWASEIN7FdnmR6Sh50xBqEFc6zyyIOxHVcnOR+I0QRSudiz5Il+2hdY51W/
	 ZBtNifBwL7V2WYzUCoWR0Ef8YB6frZEY49BqzfmBRnv3Pmh9PcQIIC9P+0WSI9ppY4
	 dVaFij5n0pX6LzyRqVc2a2xE4eLy7Qzlz/MbvJoo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20251111084417epcas1p4df5555d6f4a0ac36c88180c40bfbe493~251U86qvm2711527115epcas1p4s;
	Tue, 11 Nov 2025 08:44:17 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.114]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4d5Kp91PRZz3hhTL; Tue, 11 Nov
	2025 08:44:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251111084416epcas1p3f4c9f147866893bb32b16141f4f8adba~251ULZAtY0446904469epcas1p34;
	Tue, 11 Nov 2025 08:44:16 +0000 (GMT)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251111084416epsmtip2061329fc1c15ab2180a3bbfc0d31b4b3~251UGzuSR2786927869epsmtip2P;
	Tue, 11 Nov 2025 08:44:16 +0000 (GMT)
From: "Seunghui Lee" <sh043.lee@samsung.com>
To: =?UTF-8?Q?'Peter_Wang_=28=E7=8E=8B=E4=BF=A1=E5=8F=8B=29'?=
	<peter.wang@mediatek.com>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
	<storage.sec@samsung.com>, <linux-scsi@vger.kernel.org>,
	<bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
	<alim.akhtar@samsung.com>, <adrian.hunter@intel.com>,
	<martin.petersen@oracle.com>
In-Reply-To: <e98df6a1b10d185358bdadf98cb3a940e5322dcb.camel@mediatek.com>
Subject: RE: [PATCH] UFS: Make TM command timeout configurable from host
 side
Date: Tue, 11 Nov 2025 17:44:16 +0900
Message-ID: <009401dc52e7$5d042cf0$170c86d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQKPfZmbwG70PGLKm/pFTS39UPXmNQJO/jelAdbalYWzZYLXUA==
X-CMS-MailID: 20251111084416epcas1p3f4c9f147866893bb32b16141f4f8adba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2
References: <CGME20251106012702epcas1p28fdeed020ea44f18dcc751c283fbbcc2@epcas1p2.samsung.com>
	<20251106012654.4094-1-sh043.lee@samsung.com>
	<e98df6a1b10d185358bdadf98cb3a940e5322dcb.camel@mediatek.com>

> -----Original Message-----
> From: Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B)=20<peter.wang=40mediatek.c=
om>=0D=0A>=20Sent:=20Tuesday,=20November=2011,=202025=2011:46=20AM=0D=0A>=
=20To:=20beanhuo=40micron.com;=20sh043.lee=40samsung.com;=20avri.altman=40w=
dc.com;=0D=0A>=20storage.sec=40samsung.com;=20linux-scsi=40vger.kernel.org;=
=20bvanassche=40acm.org;=0D=0A>=20linux-kernel=40vger.kernel.org;=20alim.ak=
htar=40samsung.com;=0D=0A>=20adrian.hunter=40intel.com;=20martin.petersen=
=40oracle.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=20UFS:=20Make=20TM=20co=
mmand=20timeout=20configurable=20from=20host=0D=0A>=20side=0D=0A>=20=0D=0A>=
=20On=20Thu,=202025-11-06=20at=2010:26=20+0900,=20Seunghui=20Lee=20wrote:=
=0D=0A>=20>=20Currently,=20UFS=20driver=20uses=20hardcoded=20TM_CMD_TIMEOUT=
=20(100ms)=20for=20all=0D=0A>=20>=20Task=20Management=20commands,=20which=
=20may=20not=20be=20optimal=20for=20different=20UFS=0D=0A>=20>=20devices=20=
and=20use=20cases.=0D=0A>=20>=0D=0A>=20>=20This=20patch=20adds=20a=20config=
urable=20tm_cmd_timeout=20field=20to=20ufs_hba=0D=0A>=20>=20structure=20and=
=20uses=20it=20instead=20of=20the=20hardcoded=20constant.=20The=20default=
=0D=0A>=20>=20value=20remains=20TM_CMD_TIMEOUT=20to=20maintain=20backward=
=20compatibility.=0D=0A>=20=0D=0A>=20Hi=20Seunghui,=0D=0A>=20=0D=0A>=20Ther=
e=20should=20be=20another=20patch=20to=20add=20a=20device=20quirk=20that=20=
modifies=20the=0D=0A>=20value=20of=20tm_cmd_timeout?=0D=0A>=20Otherwise,=20=
this=20patch=20doesn=E2=80=99t=20actually=20change=20anything.=0D=0A>=20=0D=
=0A>=20Thanks.=0D=0A>=20Peter=0D=0A>=20=0D=0A=0D=0AThank=20you=20for=20your=
=20kind=20opinion.=0D=0AAs=20you=20know,=20it's=20not=20easy=20to=20modify=
=20default=20value.=0D=0ABecause=20it=20effects=20all=20devices.=0D=0A=0D=
=0AShould=20I=20read=20the=20tm_cmd_timeout=20from=20dt=20property?=0D=0AWh=
at=20do=20you=20think?=0D=0A=0D=0A*=20drivers/ufs/host/ufhcd-pltfrm.c=0D=0A=
=0D=0Astatic=20void=20ufshcd_init_tm_cmd_timeout(struct=20ufs_hba=20*hba)=
=0D=0A=7B=0D=0A=20=20=20=20=20=20=20=20struct=20device=20*dev=20=3D=20hba->=
dev;=0D=0A=20=20=20=20=20=20=20=20int=20ret;=0D=0A=0D=0A=20=20=20=20=20=20=
=20=20ret=20=3D=20of_property_read_u32(dev->of_node,=20=22tm_cmd_timeout=22=
,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20&hba->tm_cmd_timeout);=0D=0A=20=20=20=20=20=20=20=20if=20(ret)=20=7B=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20dev_dbg(hba->dev,=0D=
=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=22%s:=20failed=20to=20read=20tm_cmd_timeout,=20ret=
=3D%d=5Cn=22,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20__func__,=20ret);=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20hba->tm_cmd_timeout=20=3D=20TM_CMD_T=
IMEOUT;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=0D=0A=20=20=20=20=20=20=20=20=7D=0D=0A=7D=0D=
=0A=0D=0AThanks,=0D=0ASeunghui=20Lee.=0D=0A=0D=0A=0D=0A

