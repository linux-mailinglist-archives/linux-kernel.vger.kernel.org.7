Return-Path: <linux-kernel+bounces-851788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB0BD7436
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D30184E7F91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E813074AA;
	Tue, 14 Oct 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CyunqR9C"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5B757EA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416525; cv=none; b=k9e2JwSavAqc29V152prBgRiCJGDcr+AYOzuOUuUi+s9x4qcIQaSS7p0+rKXcQ0BYQGgIn6wi8gn7sLy7A+tZhJdwimPSVJ008UQBBfTS3QGVid6424CplxiR/es/m2cC+VIl9yMYU2qYfl928AAj+7ms9oN7TjOFZN/1ZeZ3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416525; c=relaxed/simple;
	bh=uAwl1GNK6MVfiRj2npv6hyUGtVFuuhpcPe1Xltm/3To=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=L+Rg0RePW88WV1qenEeAHCwJIDvAM5iJBFiQVE1YJn2IMfY+agEBnwLJgAL2Vnruv643oo3ihWTeL4ZpayRG5LOAqUvFToDU8X1xh0YD8DO9Bk9N/MFoo1unBEAVtXZ7g7JVYpDRhReZ8QqsFQZTYzsjGOSp7QpHWHKFOPwXvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CyunqR9C; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251014043513epoutp026dc6d1f5ec57d8fb1de38b6a9fe9252d~uQX3Zj05W2232922329epoutp02y
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251014043513epoutp026dc6d1f5ec57d8fb1de38b6a9fe9252d~uQX3Zj05W2232922329epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760416513;
	bh=KIHDVhuZ6TYpVfog+kFYWQMy8WRowbJlE3bnFZPEiMM=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=CyunqR9CuItd6hS9QXgYIvGu1+1Jc6sxnmog4KbWtHVaS92TUyUv9c9WdvFb83Hk/
	 J8LumzsBTqdM0Nmmcy1sg7Z0myLgWkLZ3N08CNCW++JXjj+Tg93bmdoaA7qTN/pWDv
	 gzMbC39XlhCWZlaPiV4YSaIzgmlwm6isDgsLKykg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20251014043512epcas1p1fda50efe0632504b562c17695cded6cc~uQX29KIV42282522825epcas1p1D;
	Tue, 14 Oct 2025 04:35:12 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.119]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cm1bh2t5Lz6B9m6; Tue, 14 Oct
	2025 04:35:12 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014043511epcas1p37bffc5c998bff21f27aba426deb77e95~uQX2K9LcL2696626966epcas1p3X;
	Tue, 14 Oct 2025 04:35:11 +0000 (GMT)
Received: from wkonkim01 (unknown [10.253.100.198]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251014043511epsmtip1954ec39f6a83fdc63043a6899695cd0e~uQX2IOiWL2405624056epsmtip1s;
	Tue, 14 Oct 2025 04:35:11 +0000 (GMT)
From: "Wonkon Kim" <wkon.kim@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<peter.wang@mediatek.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <f90010b2-7db1-412c-8526-47339bf4aa6b@acm.org>
Subject: RE: [PATCH] ufs: core: Initialize a variable mode for PA_PWRMODE
Date: Tue, 14 Oct 2025 13:35:11 +0900
Message-ID: <065101dc3cc3$eda735c0$c8f5a140$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFhT2clGfJ4dWcII9qWXyagEihcgwJWi3eIAdcMmwEC1X995AKKjmFatWp7pXA=
Content-Language: ko
X-CMS-MailID: 20251014043511epcas1p37bffc5c998bff21f27aba426deb77e95
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924
References: <CGME20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924@epcas1p4.samsung.com>
	<20251002070027.228638-1-wkon.kim@samsung.com>
	<4c894d68-7d0e-49a0-b582-477bcc7f351d@acm.org>
	<000001dc3c1a$33e23030$9ba69090$@samsung.com>
	<f90010b2-7db1-412c-8526-47339bf4aa6b@acm.org>

> On 10/13/25 1:20 AM, Wonkon Kim wrote:
> >> On 10/2/25 12:00 AM, Wonkon Kim wrote:
> >>>    static bool ufshcd_is_pwr_mode_restore_needed(struct ufs_hba *hba)
> >>>    {
> >>>    	struct ufs_pa_layer_attr *pwr_info = &hba->pwr_info;
> >>> -	u32 mode;
> >>> +	u32 mode = 0;
> >>>
> >>>    	ufshcd_dme_get(hba, UIC_ARG_MIB(PA_PWRMODE), &mode);
> >>
> >> Since there is more code that passes a pointer to an uninitialized
> >> variable to ufshcd_dme_get(), the untested patch below may be a
> >> better
> >> solution:
> >>
> >> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> >> index 127b691402f9..5226fbca29ec 100644
> >> --- a/drivers/ufs/core/ufshcd.c
> >> +++ b/drivers/ufs/core/ufshcd.c
> >> @@ -4277,8 +4277,8 @@ int ufshcd_dme_get_attr(struct ufs_hba *hba,
> >> u32 attr_sel,
> >>    			get, UIC_GET_ATTR_ID(attr_sel),
> >>    			UFS_UIC_COMMAND_RETRIES - retries);
> >>
> >> -	if (mib_val && !ret)
> >> -		*mib_val = uic_cmd.argument3;
> >> +	if (mib_val)
> >> +		*mib_val = ret == 0 ? uic_cmd.argument3 : 0;
> >>
> >>    	if (peer && (hba->quirks & UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE)
> >>    	    && pwr_mode_change)
> >>
> >>
> >
> > There are some attributes to use 0 as valid value.
> > e.g. PA_MAXRXHSGEAR is set to 0 for NO_HS=0 If it has 0 for valid
> > value, most of value 0 are regarded as FALSE, unsupported or minimum.
> > And these cases seems to check ret for command success/fail in code.
> > However, is it ok to set 0 for ufshcd_send_uic_cmd() fail?
> >
> > If it can't, it needs to initialize mode.
> > Value 0 for PA_PWRMODE is invalid.
> 
> Hi Wonkon,
> 
> Modifying ufshcd_dme_get_attr() doesn't exclude checking the return value
> of ufshcd_dme_get_attr(). I propose to modify
> ufshcd_dme_get_attr() such that it always initializes *mib_val and also to
> check the ufshcd_dme_get_attr() return value wherever appropriate.
> 
> Thanks,
> 
> Bart.

Hi Bart,
I got it. I'll update it.


Thanks,
Wonkon Kim.


