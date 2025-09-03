Return-Path: <linux-kernel+bounces-797695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C1B413B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF94548207
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56A2D481F;
	Wed,  3 Sep 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="seAx/fyD"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82228726D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875213; cv=none; b=c27cvegkgSX3gro34mugN11AOI/4o2tu/pKFFDLy7u5d3v7dadWEjTcY0qU+zxvfH4CyM9c0l0PeJLDQDhbFXordcWfAhTDbl+Rn+kJkjzSBisIjbyrKFg69GvV4HtxBMpHEgUVSE1xOtXrw76t+64LRTeOim450t6hO/7sTZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875213; c=relaxed/simple;
	bh=R3DhZ6mfg1h+sJtmD78zCTphaI6OPacxMmjj6u3H1Es=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=g8ihkHsT53yxwTsjHDAXiRTbfjlGIbIOB29OxgSqNZaegX0pGCWio7LfBkEHlqsCP87tyx+UeY39QRW5hcBJGxmx92UIeMAeSEPvlpDO260fy2jnQlc8BUNfaN/3iOiirGCsEXXoYNRIPm2kh3QSLNf0y6i//tNq2cOCuUzVmig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=seAx/fyD; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250903045329epoutp01f924a0685a481c09506e23b00a74b342~hrLHgG9dY1282812828epoutp01z
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:53:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250903045329epoutp01f924a0685a481c09506e23b00a74b342~hrLHgG9dY1282812828epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756875209;
	bh=21B5w+1lssADMm+k2ZLitCCdTF49rGjLr51Zj+pcqQk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=seAx/fyDbNrkUWlz3g3+ruYtmPX95TLZkHbTtU6AlDU8zT4ftLtFP1g4kQFeM51St
	 8t3s4tXz80u0mz6v/8qHzPJe6y8mhni0Tfg3JN69oQWnh9FXxVKR91a129QsmewQ42
	 etTGIkI9e0vQBMXARDTvQkdy27DMf9wumAZpW4tU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250903045329epcas5p4d0f89b732ea8235d08c55b5a2b041fe0~hrLHJawFo2982929829epcas5p4v;
	Wed,  3 Sep 2025 04:53:29 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cGqxh3glKz6B9mH; Wed,  3 Sep
	2025 04:53:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250903045327epcas5p2a97e15cae1c6a759a59a6756e4891e92~hrLF9ypcc2711927119epcas5p2y;
	Wed,  3 Sep 2025 04:53:27 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250903045326epsmtip122cca7fe6eb21dabe242b0fd7239af86~hrLEWBRlQ1713217132epsmtip1K;
	Wed,  3 Sep 2025 04:53:26 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Ram Kumar Dwivedi'" <quic_rdwivedi@quicinc.com>,
	<avri.altman@wdc.com>, <bvanassche@acm.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mani@kernel.org>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
In-Reply-To: <20250902164900.21685-3-quic_rdwivedi@quicinc.com>
Subject: RE: [PATCH V5 2/4] ufs: ufs-qcom: Remove redundant re-assignment to
 hs_rate
Date: Wed, 3 Sep 2025 10:23:25 +0530
Message-ID: <3a9201dc1c8e$affa1c10$0fee5430$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDbtq+ZX022GZqTIcIYj1g81c9NHgHu7PnKAbEBfqC2ZK+0sA==
Content-Language: en-us
X-CMS-MailID: 20250903045327epcas5p2a97e15cae1c6a759a59a6756e4891e92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250902164935epcas5p14139d20b5d385b99edfc0da60865dd98
References: <20250902164900.21685-1-quic_rdwivedi@quicinc.com>
	<CGME20250902164935epcas5p14139d20b5d385b99edfc0da60865dd98@epcas5p1.samsung.com>
	<20250902164900.21685-3-quic_rdwivedi@quicinc.com>



> -----Original Message-----
> From: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> Sent: Tuesday, September 2, 2025 10:19 PM
> To: alim.akhtar@samsung.com; avri.altman@wdc.com;
> bvanassche@acm.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; mani@kernel.org;
> James.Bottomley@HansenPartnership.com; martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org
> Subject: [PATCH V5 2/4] ufs: ufs-qcom: Remove redundant re-assignment to
> hs_rate
> 
> Remove the redundant else block that assigns PA_HS_MODE_B to hs_rate,
> as it is already assigned in ufshcd_init_host_params(). This avoids
> unnecessary reassignment and prevents overwriting hs_rate when it is
> explicitly set to a different value.
> 
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> ---
Better to send non-dependent patches separately.

Feel free to add:
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>  

>  drivers/ufs/host/ufs-qcom.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index
> 9574fdc2bb0f..1a93351fb70e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -494,12 +494,8 @@ static int ufs_qcom_power_up_sequence(struct
> ufs_hba *hba)
>  	 * If the HS-G5 PHY gear is used, update host_params->hs_rate to
> Rate-A,
>  	 * so that the subsequent power mode change shall stick to Rate-A.
>  	 */
> -	if (host->hw_ver.major == 0x5) {
> -		if (host->phy_gear == UFS_HS_G5)
> -			host_params->hs_rate = PA_HS_MODE_A;
> -		else
> -			host_params->hs_rate = PA_HS_MODE_B;
> -	}
> +	if (host->hw_ver.major == 0x5 && host->phy_gear == UFS_HS_G5)
> +		host_params->hs_rate = PA_HS_MODE_A;
> 
>  	mode = host_params->hs_rate == PA_HS_MODE_B ?
> PHY_MODE_UFS_HS_B : PHY_MODE_UFS_HS_A;
> 
> --
> 2.50.1



