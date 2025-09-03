Return-Path: <linux-kernel+bounces-797782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C35B4154E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03D01A81745
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D882D8376;
	Wed,  3 Sep 2025 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mPNY2G1l"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE032D6619
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881568; cv=none; b=jr47s5mNeU2jGxNUxle2HX4jblDn9IUaxcjv+PQoSe3/U1PEwlpz6GnhMqXnFCwtbUumvkHUv6WK2688pQvpb6G8cKvcongxGpZtKzQVUKwgxZxpmdL2Ngcl8N8ZyHCtbMqln9Khoye0xNbDnxUz2ojOu7l68Ha+gnHhxiI0VfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881568; c=relaxed/simple;
	bh=Bd/B1elhO6Fp4x1SMGEuPwSPiPNHgZ3GUb1dqFAV3bo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Xx+TW7B6QFBuuq43Z1340V+vkyaWLAqChBd65WEKhdFk9cpTXIlcn/WEpH5QUZ1JD17F71WdS0Jy/557R31aBrz8wfLYMXduwz4XmJtL79MaJIQByrMas4ginOSqCOkNk36Rdo7N1w7bIfYkA70z5p2KON2dEUzD+/sscIcSClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mPNY2G1l; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250903063924epoutp04c29fb22098cc0f48feca3c424a915aca~hsnlwl0eK1306813068epoutp049
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250903063924epoutp04c29fb22098cc0f48feca3c424a915aca~hsnlwl0eK1306813068epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756881564;
	bh=Bd/B1elhO6Fp4x1SMGEuPwSPiPNHgZ3GUb1dqFAV3bo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mPNY2G1lkGii26iMBZhskoOSiI5dfRIr5VRSzPjRbCtqIXMxrQQaQvZPywGoz9R+O
	 YJ/VTo225T5/bQ56Xu7Of7xPbVzP6uEjjmaKrEoDQHHLKP+8aduUjPHY+/boRM34kG
	 k6XSa1b0M/9dR2Now0Kt0btGiEiO/s+c1MtN2ibY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250903063923epcas1p1d1b1e70ed3cb7680f269c949ab4b7215~hsnlG9Nqa1823018230epcas1p1H;
	Wed,  3 Sep 2025 06:39:23 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.247]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cGtHv1MFhz6B9mF; Wed,  3 Sep
	2025 06:39:23 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250903063922epcas1p35e96f325bc193191cc9ec37d8e4935f3~hsnjp4Ppt2315123151epcas1p3k;
	Wed,  3 Sep 2025 06:39:22 +0000 (GMT)
Received: from dh0421hwang02 (unknown [10.253.101.58]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250903063921epsmtip2e4c97d6aa76f0c28b44ce6e860768d5a~hsnjjlJwV2752127521epsmtip2I;
	Wed,  3 Sep 2025 06:39:21 +0000 (GMT)
From: "DooHyun Hwang" <dh0421.hwang@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<avri.altman@wdc.com>, <James.Bottomley@HansenPartnership.com>,
	<martin.petersen@oracle.com>, <peter.wang@mediatek.com>,
	<manivannan.sadhasivam@linaro.org>, <quic_mnaresh@quicinc.com>
Cc: <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<junwoo80.lee@samsung.com>, <jangsub.yi@samsung.com>,
	<sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <6e854090-a071-416a-b7a5-cc8ee0122a90@acm.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add an enum for ufs_trace to check ufs
 cmd error
Date: Wed, 3 Sep 2025 15:39:21 +0900
Message-ID: <2add01dc1c9d$7b5cba30$72162e90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEmYeTjtFjYRI1QNWxgWL0Y7ybfIwITLn2gAaoUPAICiJScSgGs7ud4AZvu8PIB4FCAbgHlrZjytYHPHfA=
Content-Language: ko
X-CMS-MailID: 20250903063922epcas1p35e96f325bc193191cc9ec37d8e4935f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250417023417epcas1p31338c05e70e61b0a5e96d0ac0910713d
References: <20250417023405.6954-1-dh0421.hwang@samsung.com>
	<CGME20250417023417epcas1p31338c05e70e61b0a5e96d0ac0910713d@epcas1p3.samsung.com>
	<20250417023405.6954-2-dh0421.hwang@samsung.com>
	<239ea120-841f-478d-b6b4-9627aa453795@acm.org>
	<093601dc1ae0$2389c460$6a9d4d20$@samsung.com>
	<27882582-58b8-4ac2-9596-3602098e7c1d@acm.org>
	<17db01dc1ba6$41d37350$c57a59f0$@samsung.com>
	<6e854090-a071-416a-b7a5-cc8ee0122a90@acm.org>

On 9/2/25 9:35 AM, Bart Van Assche wrote:
> On 9/1/25 6:09 PM, DooHyun Hwang wrote:
> > The UFS_CMD_ERR stands for =22command completion error.=22
>=20
> I've never before seen anyone abbreviating =22completion=22 as =22CMD=22.
> Please choose a better enumeration label name.
>=20
> Bart.

When I reviewed the UFS_CMD_TRACE_STRINGS definition,
I noticed that =22query_complete_err=22 is referred to as UFS_QUERY_ERR,
and =22tm_complete_err=22 is referred to as UFS_TM_ERR.

I followed the naming convention specified in this STRINGS definition,
but I=E2=80=99m=20not=20entirely=20clear=20on=20what=20changes=20are=20bein=
g=20requested.=0D=0A=0D=0ACould=20you=20please=20provide=20some=20guidance=
=20or=20suggestions?=0D=0A=0D=0AThank=20you.=0D=0ADooHyun=20Hwang.=0D=0A=0D=
=0A

