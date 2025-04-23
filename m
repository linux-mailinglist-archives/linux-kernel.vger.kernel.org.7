Return-Path: <linux-kernel+bounces-615575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9AA97F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EA8189B626
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA011E47C5;
	Wed, 23 Apr 2025 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YlwEzTgp"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9E266F0A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390709; cv=none; b=bKhP4Ib+tKPIQMbO7c16hCQBkQMJH/7hEM5SVn+1BqzaO8YjfIlIOA8R1HTnCtgrf9rTN7xnahdVfuEark1aNU5W4yPGnqHYJjN/mND6hAuRsnyYA/y0v5pgQLlBnS/ipQwR5Zu0PoCxaSrBSnmDZUVZk2TzimuKThPa85SXXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390709; c=relaxed/simple;
	bh=3SqWo4ulTzFqzs780nKr+GWWXoyKc3CsqRlgn0TlszU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ElvJSbs6divhu8p5sV3vZI12EWXaZ64+eniM3X8FTpXziMesy1SQHoka5TzKWuwkVAvubxVAODBTcxt6Q+bMKWNqd6C1XLTozc5DMYrP2oQpyEMn+NEutV40vf0oMs2j5Zf0MmQWrI7ZlXgxSZc/b1PFVFQnFWgWOJyIP6R9MO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YlwEzTgp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250423064504epoutp04b4f2f7438ca976ba61336fb7e350d078~435kKVN741455514555epoutp04-
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 06:45:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250423064504epoutp04b4f2f7438ca976ba61336fb7e350d078~435kKVN741455514555epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745390704;
	bh=72Psgkn+jG8bccz9lqfdGIztHlVpKbwkw3e+s4Gh1hs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=YlwEzTgpMpZjs///FsdX8fYN8BP5T9Fi97BMxTh7KCgQcIVVF6PB/F8hLv7g2tJyK
	 dRLBcJwhcoVFqkwHibghV7aj8uIzTtCaTjeTBkSPvvy7UNZCKXDhP3V72FRVpejbh7
	 qvx2v5q5/f8rb2wFxNNA+Ni9Extv2Cev1CXNjXlM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20250423064503epcas1p3d6b28a5118bc49104a8d5e997b579474~435jXdHAK1657316573epcas1p3M;
	Wed, 23 Apr 2025 06:45:03 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.248]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4Zj8jp2dwdz6B9m6; Wed, 23 Apr
	2025 06:45:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250423064501epcas1p2f5ee0585feea01613ca82118a3241d40~435hnRXYg2862928629epcas1p2V;
	Wed, 23 Apr 2025 06:45:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250423064501epsmtrp1fe7e0b792b4fc098e8dc39303e55cadd~435hl4yo53246032460epsmtrp1i;
	Wed, 23 Apr 2025 06:45:01 +0000 (GMT)
X-AuditID: b6c32a29-fda1d2400000223e-77-68088c6db7d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.2A.08766.D6C88086; Wed, 23 Apr 2025 15:45:01 +0900 (KST)
Received: from dh0421hwang02 (unknown [10.253.101.58]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250423064501epsmtip1dd824c9339839168ea88ffae03456c03~435hXsEvJ2704327043epsmtip1X;
	Wed, 23 Apr 2025 06:45:00 +0000 (GMT)
From: "DooHyun Hwang" <dh0421.hwang@samsung.com>
To: =?UTF-8?Q?'Peter_Wang_=28=E7=8E=8B=E4=BF=A1=E5=8F=8B=29'?=
	<peter.wang@mediatek.com>, <avri.altman@wdc.com>,
	<quic_mnaresh@quicinc.com>, <linux-scsi@vger.kernel.org>,
	<bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
	<alim.akhtar@samsung.com>, <manivannan.sadhasivam@linaro.org>,
	<martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
Cc: <sh043.lee@samsung.com>, <wkon.kim@samsung.com>,
	<cw9316.lee@samsung.com>, <grant.jung@samsung.com>,
	<sh8267.baek@samsung.com>, <jt77.jang@samsung.com>,
	<jangsub.yi@samsung.com>, <junwoo80.lee@samsung.com>
In-Reply-To: <039d433e9931e4999e4011cebc2844ffacd2ec0c.camel@mediatek.com>
Subject: RE: [PATCH 2/2] scsi: ufs: core: Add a trace function calling when
 uic command error occurs
Date: Wed, 23 Apr 2025 15:45:00 +0900
Message-ID: <001001dbb41b$3c947300$b5bd5900$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQEmYeTjtFjYRI1QNWxgWL0Y7ybfIwLekswsAdKaXvgCNaz4WLTkHcVg
X-Brightmail-Tracker: H4sIAAAAAAAAA02ReUiTYRzHed5r75bDt23gk0XEQExLUzJ4OjAjlLcZlIQa0TXz1Vnbmls3
	FWWeM/OqqbPMDiz3R6I1HWpZW3lVmGVqZmlS2Do1y1jNrG0E/vfhe/GDH42LHhO+dIp6H6dV
	y5VSSkDU26Tzg1SnaUXIhZ8CNFxRTyG74zmFDGMOHJV2ZpLo11QND9Xm0yjbXIwhy+gjHmqc
	OoWhZ43nKZTbZ6HQq/QcEl1r+4Mh87ffJJo885aH0px3CNT7qJ1EN59OEhEi9llPNGso6qTY
	wd5mik3vaCHY8XcDBFvYfJw9c8sE2Im6+WzW3VxsI3+LYFUip0w5wGmXhO8UKCb60wmNzfeQ
	/UYGdgI0SvSAT0MmDBZlZmN6IKBFTBOAlc1NwGPMg7lDt3l6QP9jMbTZdJ6MHcAyezHpylBM
	CCxu/US5DAnzE4N6vcW9hDNDAJb0pJOeyhSA9oES3FXhMzI4fe4q5WIxkwjLz47xXEwwfrCg
	w+TOCJnl8GXOF8LDs2FH2Vs348wimPcmA/znqksfcc+pC6DjXRXp0SWwPCfTrUuYKDj44iRW
	AMTGGVPGGVPGGVPGGfVKQJjAHE6jUyWrdKGaUDV3MFgnV+n2q5ODd+1V1QH3xwMDLKDBNBZs
	BRgNrADSuFQi/BXFU4iEifLDRzjt3h3a/UpOZwVzaULqI/R5n5coYpLl+7g9HKfhtP9djOb7
	nsD4xyJLlNbqvAnnwaqItZ9jzAFOfzM5u2t3FEs72q/tzPDa1lxQkDQ0OnGFXFEVPr3luH4g
	tf6wE24dS355ISHg+wPlnZpon68PT6+eXq3Ir2gwTGevg8KemCDB0dq4x7xjC+55K28yH9bH
	lW7wkRnCVc7A/rPx2MXubP+a808/p1wtvC5dSuGbJxu9B7q+XmrzX2WJMITUDW4Yvu/VZx8n
	K8WxXpGX/VJHhjuDFmdtylKvTCv0xh3j8phu63bHdVlhySuZrCL2SWySeDDYb2QhuebusqWL
	w0x+r9e2jJbGR2bMe841va84km9beQDMItN+dC6phq0JviNqDaDNQ5ulhE4hDw3EtTr5Xwkg
	fxNgAwAA
X-CMS-MailID: 20250423064501epcas1p2f5ee0585feea01613ca82118a3241d40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250417023419epcas1p343060855c4470f8056116a207a584956
References: <20250417023405.6954-1-dh0421.hwang@samsung.com>
	<CGME20250417023419epcas1p343060855c4470f8056116a207a584956@epcas1p3.samsung.com>
	<20250417023405.6954-3-dh0421.hwang@samsung.com>
	<039d433e9931e4999e4011cebc2844ffacd2ec0c.camel@mediatek.com>

> On Thu, 2025-04-17 at 11:34 +0900, DooHyun Hwang wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > When a uic command error occurs, there is no trace function calling.
> > Therefore, trace function calls are added when a uic command error
> > happens.
> >
> > Signed-off-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
> > ---
> >  drivers/ufs/core/ufshcd.c =7C 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index ab98acd982b5..baac1ae94efc 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > =40=40 -2534,6 +2534,9 =40=40 ufshcd_wait_for_uic_cmd(struct ufs_hba *h=
ba,
> > struct uic_command *uic_cmd)
> >         hba->active_uic_cmd =3D NULL;
> >         spin_unlock_irqrestore(hba->host->host_lock, flags);
> >
> > +       if (ret)
> > +               ufshcd_add_uic_command_trace(hba, uic_cmd,
> > UFS_CMD_ERR);
> > +
> >         return ret;
> >  =7D
> >
> > =40=40 -4306,6 +4309,8 =40=40 static int ufshcd_uic_pwr_ctrl(struct ufs=
_hba
> > *hba, struct uic_command *cmd)
> >         =7D
> >  out:
> >         if (ret) =7B
> > +               ufshcd_add_uic_command_trace(hba, hba-
> > >active_uic_cmd,
> > +                                            UFS_CMD_ERR);
> >                 ufshcd_print_host_state(hba);
> >                 ufshcd_print_pwr_info(hba);
> >                 ufshcd_print_evt_hist(hba);
> > --
> > 2.48.1
> >
>=20
>=20
> Hi DooHyun,
>=20
> Is it possible to receive UFS_CMD_COMP and UFS_CMD_ERR at the same time?
> Wouldn't it be a bit strange for a command to receive two completions?
> Additionally, should we also add tracing for general SCSI commands that
> receive errors?
>=20
> Thanks
> Peter
>=20
Thank you for your review.

Yes, that=E2=80=99s=20correct.=20There=20is=20a=20case=20where=20both=20UFS=
_CMD_COMP=20and=20UFS_CMD_ERR=20are=20logged=20simultaneously.=0D=0A=0D=0AI=
n=20the=20typical=20case=20of=20a=20UIC=20command=20timeout,=20only=20UFS_C=
MD_ERR=20would=20be=20recorded.=0D=0A=0D=0AHowever,=20the=20scenario=20you=
=20described=20earlier,=20where=20both=20UFS_CMD_COMP=20and=20UFS_CMD_ERR=
=20are=20received=20in=20the=20same=20UIC=20command,=20is=20distinct=20from=
=20a=20timeout=20situation.=0D=0AIn=20this=20case,=20the=20command=20comple=
tes=20in=20time,=20and=20UFS_CMD_COMP=20is=20received=20when=20handling=20t=
he=20UIC=20command=20completion=20interrupt=20in=20ufshcd_uic_cmd_compl().=
=0D=0AHowever,=20the=20UPMCRS=20status=20indicates=20an=20error=20because=
=20PWR_LOCAL=20is=20not=20in=20its=20expected=20state=20(when=20checking=20=
upmcrs=20in=20the=20=22check_upmcrs:=22=20section=20of=20the=20ufshcd_uic_p=
wr_ctrl()=20function).=0D=0A=0D=0AUFS_CMD_COMP=20is=20generated=20when=20th=
e=20system=20recognizes=20through=20interrupt=20status=20that=20the=20comma=
nd=20has=20completed=20its=20execution,=20while=20UFS_CMD_ERR=20is=20record=
ed=20when=20an=20error=20associated=20with=20the=20command=20is=20detected.=
=0D=0A=0D=0AWhile=20it=20may=20be=20cumbersome,=20it=20is=20possible=20to=
=20trace=20the=20timeout=20case=20and=20this=20case=20separately.=0D=0A=0D=
=0ARegarding=20tracing=20general=20SCSI=20command=20errors=20directly=20thr=
ough=20UFS_CMD_ERR,=20it=20might=20be=20challenging=20because=20SCSI=20comm=
and=20errors=20are=20typically=20handled=20through=20various=20mechanisms=
=20such=20as=20timeout=20detection,=20scsi_status=20value=20checks,=20sense=
=20error=20checks,=20and=20OCS=20(Overall=20Command=20Status)=20value=20ver=
ification.=0D=0AAdditionally,=20tracing=20SCSI=20command=20errors=20does=20=
not=20align=20with=20the=20purpose=20of=20this=20commit.=0D=0A=0D=0ABR,=0D=
=0AThank=20you.=0D=0ADooHyun=20Hwang=0D=0A=0D=0A

