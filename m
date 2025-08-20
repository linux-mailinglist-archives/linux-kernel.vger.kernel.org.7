Return-Path: <linux-kernel+bounces-776722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666FB2D0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C683C1C23383
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3718C91F;
	Wed, 20 Aug 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0G0lzwB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02357FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651032; cv=none; b=oWfqM4w8Fvfs1UTyNxea51/yb14RkJYz4GAclIBtwjxr+AoXBTjsx6OCtCOf5xrZIjCyMCwvQBJ3T+thbNTJNpu73t+PLYNicEmAtuGtZyL9KaliCH4oW5HU94+DjZZ2fZ2dn6N9jGrkLRTV+fgCox0x7zEXNAuRLisoGyNtTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651032; c=relaxed/simple;
	bh=YIRpeSbZbQx4vA5wFVD+gkqsQApN85GMOE0/qPdsAM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrUwGXAKTb+80GXjw7Pt2j1IyOkaXstBnQyavEBvHwjIv4v5MRMaxYGcGmsYQRE9QwkNwH5iEyvYigckU4SPkVw4wOHYQKzfPfpcoDGaA9DvuzEVX14FmGI+j6b29y51poeaD2wLJhXC+c04fTDhzR9q/eYXuPkmDXFptWx17n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M0G0lzwB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JL16Vo027687
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fFHU5Uj+jXoPoAM1BiBDUT8I
	hXi09SdGNJ1NomSthLE=; b=M0G0lzwBza41VuZ6YB1X0z5czf2rGCswbu0hfe1R
	nnq1jEIb87cSyTsnH4s8YEg6Td7mYwIGrN+KkXxAMTcmpceRz+IIfX65QJxluT4Z
	HnsR0h5Ebpoi3zg1yiLhdNXfMwOWQIqwuZ2rm8y96Cl1GlXh4zFyvgrxvD0VbXlD
	YMl39iKdWHMpBAHB+lO3dNnLHnoriq8seVJp03cVsT6/2WEcJ/9tsm3sETjzOid+
	F+zAOJr3yzJfB5aV2asOtw6XMANoIs1VbcUlszRDU1kooZOe8YvXnmuYFkZ72naN
	4a/kjdsfYe3eWKd5/zWByF8GT+qEhoPUt7XeVIyEQsWKaQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n0th0d7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:50:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9289baafso9443406d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755651028; x=1756255828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFHU5Uj+jXoPoAM1BiBDUT8IhXi09SdGNJ1NomSthLE=;
        b=wxhdUknpukDvvLONwBl5TWTE+sN8ixofCB9rMutLChiUayYVgwwiFFLuLhWXwqkg9/
         g2wPcgp8PdyPEfpq4s1ik8o/1QF+euRp8Kj71uhOjebcbs7wWKCpvmonliyfYJGjU6vK
         7DX9iyyE5hZ0sFm42dP8lCeKUiBCmRRCNjBslYvLAjeglHM3Nghh1PxCXa89y4isnF/W
         hrJy/E4w6zUHnwx0mFmwHiCWGi11o2qXypnr24qRM0E+FB6AqFT0B/LbIf9Ed40Y56Iy
         uah/bvMcyL6VhfnJP+FW/588FcxwaTfAX4rwwwRETYf4puPpFsMX7sAHiBHNieIK31T8
         6vBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4snE8efSMEJ6jvs2aZIP6tI6q9DyogfdZ6hAYvMN89HXfmeLvVxdopN/HAiQqH3DAWud7srqfJ4froPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4zde4u3+lagFZ1lNF8S3WwD0BKmQGNBqYyRbXzAmfxqyb8YE
	WHikmENGxeqQsSJ0vBW5/0Pp9BWL8TRliPiugmrFF4FyvyiVf6M6IRAhF9XuGqrdXJIDzrqe3yW
	PwR4hKnSevpd/WbaUuVCvfuggtOoZ0S3UG88tdnHQfcpuKWbkYuylP0kD+PukV9qKr+4=
X-Gm-Gg: ASbGncs0+Vkpa2hPGumpR4k7feUrwykAs7Qvzpl0KozoOMNdW4K/XNGb8mxpscugWsO
	OzCo95hOtXn9+T+ERR3nzNdX8MhKnx+b5E+ro5Rb39yM4HBNRf1338djlOBFR+UdBk76bhC0DSg
	cVuV4NrnKZsfN7osxQgzztsAD0EHtB4zJlW+5DiZNaC5zC1+zXZTsJXxSBZT79MYQY1Ix3skYGd
	zPjxNL5iWmPCNRapAaPzRbJGoGxnwcf74lnklsGLeAceiRmGvYV0eKniGhc4hvrEFwZRRFxbk+T
	EEolj2vwrKCa6suJ0whfmcT2MQvkF66MBYCNDQh/+2Y/qBcEx3AFKjHwFW2JuWncMrVPPVrwp/a
	TPW3y56B5Pt98f5nygyOPvfcMJuPnCnYKo7PVxlIdRL8RN8qWJqYa
X-Received: by 2002:a05:6214:2347:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-70c6769d407mr51600356d6.9.1755651027808;
        Tue, 19 Aug 2025 17:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESN0BIvM6CuJAs/DUGKSJfPhZ/a+kgpIoYK/BoCUIvKjOBaanSEDI8cOaQ20OdYtUduS4y3A==
X-Received: by 2002:a05:6214:2347:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-70c6769d407mr51600096d6.9.1755651027357;
        Tue, 19 Aug 2025 17:50:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35a187sm2325712e87.46.2025.08.19.17.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 17:50:26 -0700 (PDT)
Date: Wed, 20 Aug 2025 03:50:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Peng Fan <peng.fan@nxp.com>, linux-remoteproc@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5] remoteproc: Use of_reserved_mem_region_* functions
 for "memory-region"
Message-ID: <6lbathmvpjxdvcnhtncxclcdro7nv6gjwkvznnpv5zrbh2lcde@qw3gjj5lp7ev>
References: <20250819213831.1368296-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819213831.1368296-1-robh@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NiBTYWx0ZWRfXzZVzOk+6BA9j
 9ftaaKkQ2+ujmtznrFaAJ/hxcv5uQkbJsoJwNyM6dnZsdRJqXweMtaUG7Kz/XqPWdNR6IJz6fSx
 5KJNpetGboz1GdkbfhZLaLz29rY+ngrqyR/BM1MLLX1cbX+uuj89ebU2Dmyd5+tJCSINKkVnExZ
 B6ufa+52ba4UldpJwX5txoGjEru6atvWjczfVteh2VaO0lh7PgzeAVbBmOQ9CAfKNqrYl7UBBJo
 or1ndKDbhAI2RQ36IdlxfzFtWLtwo7DiOr+UMjTRoZQR7Z1UE96Yq+w7Oqzh8q72D4hAP8bVoD6
 bY86Ye993mgFT4epdxG71qJPuccFswOx9F5XeVCbJURoPmW2OdGsMjiXf8OpKT+Ct2XYfLjS1Yr
 PSqBPaSC0n55QRDCDbO26yy+GipAGw==
X-Authority-Analysis: v=2.4 cv=dI7/WOZb c=1 sm=1 tr=0 ts=68a51bd4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=8b9GpE9nAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_lrZVZmJbgvpAXfrVDQA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: rwRRlIrrRgVuon8bGqKioGXPQf_5byWG
X-Proofpoint-GUID: rwRRlIrrRgVuon8bGqKioGXPQf_5byWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190196

On Tue, Aug 19, 2025 at 04:38:27PM -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() and
> of_reserved_mem_region_count() functions to handle "memory-region"
> properties.
> 
> The error handling is a bit different in some cases. Often
> "memory-region" is optional, so failed lookup is not an error. But then
> an error in of_reserved_mem_lookup() is treated as an error. However,
> that distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Tested-by: Peng Fan <peng.fan@nxp.com> # i.MX93-11x11-EVK for imx_rproc.c
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v5:
>  - Drop some inadvertent whitespace changes in qcom_q6v5_pas.c and ti_k3.
>  - Fix error handling in adsp_alloc_memory_region()
>  - Drop unreachable returns after 'while (1)' loops
> 
> v4:
>  - Rebase on v6.17-rc1. qcom_q6v5_pas.c conflicted needing s/adsp/pas/
> 
> v3:
>  - Rebase on v6.16-rc1. Move TI K3 changes to new common file.
>  - Fix double increment of "i" in xlnx_r5
> 
> v2:
>  - Use strstarts instead of strcmp for resource names as they include
>    the unit-address.
>  - Drop the unit-address from resource name for imx and st drivers
> ---
>  drivers/remoteproc/imx_dsp_rproc.c      | 47 +++++++----------
>  drivers/remoteproc/imx_rproc.c          | 70 ++++++++++---------------
>  drivers/remoteproc/qcom_q6v5_adsp.c     | 24 ++++-----
>  drivers/remoteproc/qcom_q6v5_mss.c      | 60 +++++++--------------
>  drivers/remoteproc/qcom_q6v5_pas.c      | 69 +++++++++---------------
>  drivers/remoteproc/qcom_q6v5_wcss.c     | 25 ++++-----
>  drivers/remoteproc/qcom_wcnss.c         | 23 ++++----
>  drivers/remoteproc/rcar_rproc.c         | 38 +++++---------
>  drivers/remoteproc/st_remoteproc.c      | 41 +++++++--------
>  drivers/remoteproc/stm32_rproc.c        | 46 +++++++---------
>  drivers/remoteproc/ti_k3_common.c       | 28 ++++------
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 53 +++++++------------
>  12 files changed, 199 insertions(+), 325 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # msm


-- 
With best wishes
Dmitry

