Return-Path: <linux-kernel+bounces-734602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF8B083C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57503A7DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66E1D5CC7;
	Thu, 17 Jul 2025 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ejlRwCN+"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2A10E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726409; cv=none; b=Ll0JrQOjqCUf/aEsxtNyWFGKx9rH2QW/uJlU6BcrzQdis/+3jY9gwg6i+g1epWKLh0aUBnYTMN7dbktqrDfoh5k3x1Rer7tFmMzQ3PMKl+v0ViGFH4LbTFYEyEhU44xl9J7Z6J1fiYc84aR0hEDGanydxI3IIsAvpv0kprLHBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726409; c=relaxed/simple;
	bh=HsL5KKcSoHYhyat4Gh7V8v2v1V4IqllIisrYKQgZdGg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=dlbw7w5E03rkY+T1jDfZHbDupGCZre+EKAraRYtEoCk99AFsdiYWGpYFyxFRPeFhdRwUwVgCBgt2m83iL4QehgYZmWWeQCTU60qgaMI3gEb9dExz5UIZdGpu0NzWeG9jHaws46ROeTY2BRsXWzjdiiV5QxzE+6+1bMOjaIFwHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ejlRwCN+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250717042644epoutp03eaa0dddf359ca169c91376738a5bb320~S72DLAequ1554215542epoutp03e
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:26:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250717042644epoutp03eaa0dddf359ca169c91376738a5bb320~S72DLAequ1554215542epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752726404;
	bh=HrNx6/9WXfuC76MDuRRCJbK6joLk959v0hLRLqfhbVY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ejlRwCN+YEGihDMMGFCWgEe4OUDw9Ry2TCI0XNtzMe8uIluB08LMiTFTuICHNguen
	 i+Pkk2KBCcoIZdxW99PyF4Jc52Ily7iIQuXdJufIXG0MeWGUUmaRHeQASnQIldh4KE
	 5Ko/KMPEBMn4DzWFsXR4hcSG/CZYP7Q6tb0pEz2o=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250717042643epcas5p2d7d5dd8d9863e8b16d2dae1a957828f4~S72CuOEV72283622836epcas5p2e;
	Thu, 17 Jul 2025 04:26:43 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bjKcy5nJYz2SSKf; Thu, 17 Jul
	2025 04:26:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250717042642epcas5p1b1ceebd9abbc906966b63b710d6a2118~S72BW5d0p1535115351epcas5p1Z;
	Thu, 17 Jul 2025 04:26:42 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250717042640epsmtip144675d33c5f41cc6e20b18e6fb4f1591~S72AB93xo2735127351epsmtip1M;
	Thu, 17 Jul 2025 04:26:40 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Sowon Na'" <sowon.na@samsung.com>, <robh@kernel.org>,
	<krzk@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>
Cc: <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20250702013316.2837427-5-sowon.na@samsung.com>
Subject: RE: [PATCH 4/5] scsi: ufs: exynos: add support for ExynosAutov920
 SoC
Date: Thu, 17 Jul 2025 09:56:39 +0530
Message-ID: <1eab01dbf6d2$feed4810$fcc7d830$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKcRDJWwAug8EBOlN5S0ESXxoAVsAF9G/OQAkREfl2ylxGNoA==
X-CMS-MailID: 20250717042642epcas5p1b1ceebd9abbc906966b63b710d6a2118
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250702013332epcas2p3fc1442b0c8f8b92c9cdc8dd0398ebcb6
References: <20250702013316.2837427-1-sowon.na@samsung.com>
	<CGME20250702013332epcas2p3fc1442b0c8f8b92c9cdc8dd0398ebcb6@epcas2p3.samsung.com>
	<20250702013316.2837427-5-sowon.na@samsung.com>



> -----Original Message-----
> From: Sowon Na <sowon.na=40samsung.com>
> Sent: Wednesday, July 2, 2025 7:03 AM
> To: robh=40kernel.org; krzk=40kernel.org; conor+dt=40kernel.org;
> vkoul=40kernel.org; alim.akhtar=40samsung.com; kishon=40kernel.org
> Cc: krzk+dt=40kernel.org; linux-kernel=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org;
> sowon.na=40samsung.com
> Subject: =5BPATCH 4/5=5D scsi: ufs: exynos: add support for ExynosAutov92=
0 SoC
>=20
> Add a dedicated compatible and drv_data with associated hooks for
> ExynosAutov920 SoC, Samsung Autotomotive SoC series.
>=20
> ExynosAutov920 has the UFSHCI 3.1 compliant UFS controller.
>=20
> Signed-off-by: Sowon Na <sowon.na=40samsung.com>
> ---
>  drivers/ufs/host/ufs-exynos.c =7C 130
> +++++++++++++++++++++++++++++++---
>  1 file changed, 120 insertions(+), 10 deletions(-)
>=20
=5Bsnip=5D

>  	struct phy *generic_phy =3D ufs->phy;
>  	int ret =3D 0;
>=20
> -	if (ufs->avail_ln_rx =3D=3D 0 =7C=7C ufs->avail_ln_tx =3D=3D 0) =7B
> -		ufshcd_dme_get(hba,
> UIC_ARG_MIB(PA_AVAILRXDATALANES),
> -			&ufs->avail_ln_rx);
> -		ufshcd_dme_get(hba,
> UIC_ARG_MIB(PA_AVAILTXDATALANES),
> -			&ufs->avail_ln_tx);
> -		WARN(ufs->avail_ln_rx =21=3D ufs->avail_ln_tx,
> -			=22available data lane is not equal(rx:%d, tx:%d)=5Cn=22,
> -			ufs->avail_ln_rx, ufs->avail_ln_tx);
> -	=7D
> -

Why you are moving these changes from exynos_ufs_phy_init() to exynos_ufs_p=
re_link()?=20
If at all this is needed, this need to be a separate patch, not related to =
adding exynosautov920 support.=20

>  	phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
>=20
>  	if (generic_phy->power_count) =7B
> =40=40 -1065,6 +1148,16 =40=40 static int exynos_ufs_pre_link(struct ufs_=
hba
> *hba)
>  	/* unipro */
>  	exynos_ufs_config_unipro(ufs);
>=20
> +	if (ufs->avail_ln_rx =3D=3D 0 =7C=7C ufs->avail_ln_tx =3D=3D 0) =7B
> +		ufshcd_dme_get(hba,
> UIC_ARG_MIB(PA_AVAILRXDATALANES),
> +			       &ufs->avail_ln_rx);
> +		ufshcd_dme_get(hba,
> UIC_ARG_MIB(PA_AVAILTXDATALANES),
> +			       &ufs->avail_ln_tx);
> +		WARN(ufs->avail_ln_rx =21=3D ufs->avail_ln_tx,
> +		     =22available data lane is not equal(rx:%d, tx:%d)=5Cn=22,
> +		     ufs->avail_ln_rx, ufs->avail_ln_tx);
> +	=7D
> +



