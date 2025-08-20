Return-Path: <linux-kernel+bounces-776721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC109B2D0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A85A01F71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F8194A45;
	Wed, 20 Aug 2025 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEO8gOtj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34167FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755650980; cv=none; b=nE4DZhtLNLbtuPClGucC4Qvk1Fq2leYq0fHY3mg7pA9EX0JulGV3ABsCtngNgPlxtgljcXXVpDDpg/SzceHH1FabBhM1rUUdncjVjRE9uOnnW/Fs37+m7IoftA1o7ptsuFxZtgQaiCYeRHEdqVKwHNKhkLFwtgLI3lWkFmsTK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755650980; c=relaxed/simple;
	bh=Rjq+3fz/bHLH5SdPEX0my0AZO/wLNhETTXOqjlGZUFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk0fJxa/boL7X1SYHFwMo0+dDuH7G6nAomWEwKZ45b42Gd8TwM6AQdCfpnx2wfjL+BcNmzIWYKF8Je82mfvm5hPeL/38rRZwqGVTrykzK4mw4WPHKLUBg1gbtD+GjQzAx5v/rdlQomaR402YnmocGu+/C33grRpvfeg13jEVOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEO8gOtj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL119E027075
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7zu7l2y9FBY48F1LOrgt552y
	dSy/rBgg7xXX+MIdGBY=; b=cEO8gOtjKCDyVBmgTI2FC0zHb7EUqrTyGCT5cnI7
	IXMGLE0Tq8TVen2mFXh0N2Sl1nJIxWH8zOIqKsua4DuMjtAbWUQOjNqeNSxddk/S
	ooyQ7z6rCBeRlE7/WqZAvy0YZSa6Ytq88MvTy6th308rt6Fc4A8jvihpD/Rzsbfk
	lNVs2OVHSgBs/lyMI1YbOSf+Gx2VHUezMKEqKNoQW4DT0kukD6bbgc6NTcpZmbrO
	IfymP1rYxZOsVyP5qVBjDgJdLDqBepiVqRHy7uK6uvcphSR6tC9k7bhgjL0ir54+
	aZilODCBAqcqFZ25i1ea4Fjyh45X8IKhzg2zq4hgVf6SEA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0tfgdxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:49:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9289baafso9433376d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755650976; x=1756255776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zu7l2y9FBY48F1LOrgt552ydSy/rBgg7xXX+MIdGBY=;
        b=Ga31/aLDj5uGwnzU+RUhNy7uZfDTdW5zs58ue2b6FV8n6xlyXlBay0oc/FEqdSsMhh
         BfuROl5ZzWPWj8lcc1sXVxeL7oiltJqg9Psz1ioMzrI5NDRwCFvmmh5Fc6iFG28+yV/a
         EI93SAWQaafhkjkdXTV4l7hqIRJx0uImSU7NdQH7W5KWe+fhIIDI6vEVqQaR9lI7S9mF
         7A5c5CBNZbUE4kq6IvvOxv+DTqtt0m9PNVTu9o4UByVl+H1tdOCSi6DY9BKk/0Pp1Xcv
         l+iaTicDMm6TsrPJa2E4Z1xl5gFqPsfwGalMTMtzI1DJfzj7nRDrqMj9KVhKNDqmBDCF
         bDag==
X-Forwarded-Encrypted: i=1; AJvYcCVxYwV8IoBK3Sj4ce5qf9/a322IawYMQlhkdznmQXUPF2o8P9CBtQhN8llw4+t0u2eZeRWMlAKAVxH2Zxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//KZNkpevJpxSaw4m9ePURnXKbphHjYKvULgSA5Rgimx3ul0K
	SDRbI/gBe5AHf53tJQpX7f2Pt/9e8dDVySPq6xQzHTBSn+IZ4sEvX/PS+O4kIOIy9GVUH8sRALk
	nZPh6vm9CrP77vxL9YgWikBaF2bBwIZwb8E+7oUMo9BSnnJcdgbwdMnotGyKbFm3sOi3qnSRavK
	o=
X-Gm-Gg: ASbGncsW8wuBc4baOsHmYR7drdBMTaQJT7hzTEmmQDUTXZHZ+/vR7pttGEJj4W/kpWt
	YLRZqLMpTt/E+dOlHtCx3JYH3kz9ci8fK47SIpYxR7qfPUzZ04AhScjBCuYk/vCYEAChX8Y5ca+
	cX7rqttnPkNuVijm1hBfaN3g7ZTgDMlgIC6/xfnwKqG7TMJ6+9CyGmTOykKJXJ9odz7Tp4GkRBY
	Q43UAe/2kverP/byRgfdae1J+tWC4F/bxxD33PDW75B9RcK1h7NOcmqv67nWNRmqfENLikiBz4t
	uKPDgfYRLQJeMPsYK8mdN1TuBjlHeddgHCpLZX0T1LjU/9qNb7AqZCTcFqEnQO019b3D5uUpGf9
	jCKgqWR9p9nKlPbu1tew3qEiJi2jwrOfc6kn7/awZkyK7fU4t0MdE
X-Received: by 2002:a05:6214:1c0c:b0:70b:be30:62c7 with SMTP id 6a1803df08f44-70c689212cdmr48106526d6.24.1755650976079;
        Tue, 19 Aug 2025 17:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJlvHfhO/H8jyDOpduulQj1SpN2n0STcA5OEQOkKAQCJmffL6GHOubWWLrzJfepchpusERIg==
X-Received: by 2002:a05:6214:1c0c:b0:70b:be30:62c7 with SMTP id 6a1803df08f44-70c689212cdmr48106356d6.24.1755650975640;
        Tue, 19 Aug 2025 17:49:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35f11csm2323366e87.51.2025.08.19.17.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 17:49:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 03:49:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, mani@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add regulator loads for SM8650
 and SM8750
Message-ID: <ger4kizeltjwalfuwu4dpfjiskrv2okgo5c7d6n3pb24yaxgfo@nkcndblyx3il>
References: <20250819222832.8471-1-quic_nitirawa@quicinc.com>
 <20250819222832.8471-3-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819222832.8471-3-quic_nitirawa@quicinc.com>
X-Authority-Analysis: v=2.4 cv=M84U6yws c=1 sm=1 tr=0 ts=68a51ba1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=ehUKESkC_4NtqqJ1MVkA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXyXCnTKy1REhu
 IViaeB9dp8ChWECbB2T+EJaPk9Ocs0YVdjbv5UbrqgI7Z/+dAdIfRbklWxBnm++qG0BK4DQc/m6
 quAmoQNMDT0EyAjUhYRfn6FhvtjKFlsp5VgPb5alHos33k+iOq3+kQ5Rd7QknSnc/BcxLE5LhtB
 PO4AV8sRTssIiMY46024xnN4wYFdsM+RhMZ4aLbvhvLTka2TUfdHbbPPtID5huBXk710nArlr9s
 KXPfgMasmpy+DkCxcc2xFKdp7LcnBL+JzZsI5yJnV47Ubi8+XMtZctlpxRpoA9+Kf9dnlOwEVr5
 /htCcV+7ZOCNFZQsau9QDz+bAJwznbUqWaOLx+amGB2HWawwT39aYZBAK9oEqo4t7mWI9TvyLG8
 2sCA+0SyXjMIFK5EVmaRPHnfWiDySA==
X-Proofpoint-ORIG-GUID: 78wxFgoSOxLcVgWZJSv9C8_Xj2aBo2iw
X-Proofpoint-GUID: 78wxFgoSOxLcVgWZJSv9C8_Xj2aBo2iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190196

On Wed, Aug 20, 2025 at 03:58:26AM +0530, Nitin Rawat wrote:
> Add regulator load voting support for SM8650 and SM8750 platforms by
> introducing dedicated regulator bulk data arrays with their load
> values.
> 
> The load requirements are:
> - SM8650: vdda-phy (205mA), vdda-pll (17.5mA)
> - SM8750: vdda-phy (213mA), vdda-pll (18.3mA)
> 
> This ensures stable operation and proper power management for these
> platforms where regulators are shared between the QMP USB PHY and
> other IP blocks by setting appropriate regulator load currents during PHY
> operations.
> 
> Configurations without specific load requirements will continue to work
> unchanged, as init_load_uA remains zero-initialized when .init_load_uA
> is not provided.

Can we please get configuration for the rest of the platforms?

> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index aaa88ca0ef07..1c3ce0fa6adf 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -1170,6 +1170,17 @@ static const struct regulator_bulk_data qmp_phy_vreg_l[] = {
>  	{ .supply = "vdda-pll" },
>  };
> 
> +/* Regulator bulk data with load values for specific configurations */
> +static const struct regulator_bulk_data sm8650_ufsphy_vreg_l[] = {
> +	{ .supply = "vdda-phy", .init_load_uA = 205000 },
> +	{ .supply = "vdda-pll", .init_load_uA = 17500 },
> +};
> +
> +static const struct regulator_bulk_data sm8750_ufsphy_vreg_l[] = {
> +	{ .supply = "vdda-phy", .init_load_uA = 213000 },
> +	{ .supply = "vdda-pll", .init_load_uA = 18300 },
> +};
> +
>  static const struct qmp_ufs_offsets qmp_ufs_offsets = {
>  	.serdes		= 0,
>  	.pcs		= 0xc00,
> @@ -1638,8 +1649,8 @@ static const struct qmp_phy_cfg sm8650_ufsphy_cfg = {
>  		.max_gear	= UFS_HS_G5,
>  	},
> 
> -	.vreg_list		= qmp_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.vreg_list		= sm8650_ufsphy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(sm8650_ufsphy_vreg_l),
>  	.regs			= ufsphy_v6_regs_layout,
>  };
> 
> @@ -1676,8 +1687,8 @@ static const struct qmp_phy_cfg sm8750_ufsphy_cfg = {
>  		.max_gear	= UFS_HS_G5,
>  	},
> 
> -	.vreg_list		= qmp_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.vreg_list		= sm8750_ufsphy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(sm8750_ufsphy_vreg_l),
>  	.regs			= ufsphy_v6_regs_layout,
> 
>  };
> --
> 2.48.1
> 

-- 
With best wishes
Dmitry

