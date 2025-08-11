Return-Path: <linux-kernel+bounces-762355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FCB2055E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7EF18A2121
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E71F3FE9;
	Mon, 11 Aug 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxd7ThhG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913D3C465
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908274; cv=none; b=Tg85lPqbhmexDER/bvQjCcRTljSojBwl4rc3ErJ3LechjVJ/0B4+39qtvA9WICi8Y9S8yI9K6REOjUTIj5xhuYzJ5zfy1LOzUjw4HgHUPxYE/p0jnHIGan5MZao0UXmmbs19BGlkVnpVCeBQ69Yr7uR3zbN9nTeLE8QZ4UZ4ehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908274; c=relaxed/simple;
	bh=TmbORZlcCKPc40wFUS1pF0fgoG26pzs8CG8rViTLwDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwv3oCyciYXYiOtoqqzjxphrbIw/6N0EBib3K9wiI8s0iHrzJGP3YHuUIczXAZMWOallDkV3weumezQ2KAKb5yXs0CsTLdcEJGJCVcAZ33VJWqMjpXL6h6Q0GrBKRDILL/4UnfOjLCuFBatT+h7Qn7OUz7IePwoGzvy2xKyavE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxd7ThhG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d88b000577
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/ucSKnN0VabkHBeCyUPOOAp0
	1IU9Td+bmPEMlaDwwOU=; b=nxd7ThhG8UiO8u4+aSNd9NxDhUvou3BAn+kuDkqC
	0g12KNcGvPLBzZnLa922+aQAbCjy1re5GA0N2LweBkFOLRA+D8uL/VfU3tYcp05c
	MVYswdGvFgzsWqtoWc90iiEXIOHc2EOv7V2sEd0ekyqZQiohlxdbKUAdzWgib9SS
	dT96BvYp3AopY15+Xc64JZgnvcudlWTfSJzFvPSDrLbMD06Zp6y9IqlbdiBaRdxB
	xvpbFvtoFJuFPhFmy22IsFXejAVmNxgtkLd5hw6Ilu4ccGPcecZAlprtTxcdwVPS
	Yvs61NKR1WVjdbsB8Wm0jz+TrDKP9OGP1NN7OyfQjOeJHw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6uyea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:31:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af18aa7af8so116016221cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908271; x=1755513071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ucSKnN0VabkHBeCyUPOOAp01IU9Td+bmPEMlaDwwOU=;
        b=PDTZwx2Ar7l+wxcHoN+0UDP27VQmfMI6/8j+BN9O3XZJD4kcfQ3IZpzKz1DP+VV5J3
         KIhsABvFuHvXw2bYF4H2CYTJZtEH9pbAc2C5VIqw1i638JWMlKIRwB1WxF88svHXKH2n
         t2L8w7rOvzEMjGh/aho6Kf4hkIgJR4EX1POeRg8FGXO8NnKZcMsaoXkrf89rw/vZC2OB
         Q4HknsceuJaKfsmvkFnsWD77T/p0kVkJOsmwFNAbzSVTqNF0V+zxSPBugir3w5ueXSa3
         d9iM37SOt2ti9j27dREWOTr47MBaS0hvwGcWfziiNof3Q9rOEoVAETOs8KpfPrup1lt9
         fPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTvbvbEo0yk/SypHvtE/cJ2aAjYklp0urAobEaBx81bFz2XbI6h+HGpWP9jrQzUCGIifKWEynPKZXfW64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDZAeG3hjUtv65fViHdskg92UUpoXiUTtwOYPaE6/8Gwvz6kxT
	bMYPMh6EEP2WqHitX4fwdC7JnTBKKknhIJVlkMnoeDGt50B49xFFTsikIOWE6JtG8aDDsutVDyF
	QYsplRso+0da6IP8bmfSFNlkGlRWa+Bo6u/CHdcgP0UCN7zivR5G9KZV42AdhQTeKsEc=
X-Gm-Gg: ASbGncvBQfMGgOMjHz6tEABfCiq5ZmW6AHd6fkib+u2bOaCCIq8O+Yxdza4ivKjDNQ8
	FU4mVmNsAZMP122JH6ej+eRQOlpE7lL3vAQosBmatr2EoatED6fxBN02NR1/KMBNIsg6MgGJZie
	Du/eWxS7egUyBAPQTbvXFNNEaAVyj6Fff7opKXprUZTjBPGwhvS4UylH4huZNewwiUdPGdQXV1f
	IcjllPgMeEBmBe+4o75hTbZ191to7RIXJGzkAgSvRZjN2vQDjly8bqUX1hBuFBIn9LsoRc+Liac
	dUM+W+JpjcqAMttNc++lSrsMKM059+tJbtb3De9TjRgHCmWCa6WWs183QaUxAnEu9zaCtHzIXV3
	aYSwtfNiApZoQYAEC/yDJmzIvWFegYKf4mxlSOp8/NiEDChhZNDpw
X-Received: by 2002:ac8:5956:0:b0:4b0:7581:4dbf with SMTP id d75a77b69052e-4b0aec7e670mr172487701cf.18.1754908271520;
        Mon, 11 Aug 2025 03:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcBbTdZISUt9SKxmEFAT76YcvHLLyKJL2uxyoSRdkuIyPT1U4jZXtxIgMb19xtPh+M9uOHug==
X-Received: by 2002:ac8:5956:0:b0:4b0:7581:4dbf with SMTP id d75a77b69052e-4b0aec7e670mr172487341cf.18.1754908271099;
        Mon, 11 Aug 2025 03:31:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88caf0ebsm4214962e87.154.2025.08.11.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:31:10 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:31:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] drm/msm/dsi_phy_14nm: convert from round_rate()
 to determine_rate()
Message-ID: <23yejfrhz3qmi67r63ni7zawmpsawrb3jzn37r4h75s2ax5gki@6ngyqpqlqdez>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-2-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-2-0fd1f7979c83@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX2TH2dGj4GoOj
 n7L2IcnC1Mf88dayDJMW0DrENofZzpFnM2J1PQ8mS4VFk3fC4wQg5jbOSRRgN8piFXmPWpMREU6
 Shz9esQMbIMaIV0Jv8DaHJ1hxyOArcBrsu8Q7kCgSK7YX4nGdne62DYUuxoFUNgCdmOMh24M3jC
 2kJ9StwmZ4XPajiahjsvo9JfzbWCMjIXNeup5yOqj2xnrJHMTP19OiPa0VSymyz3F0O8ll2kUL8
 DOoNcCA++QUEua0X8kMcmK6ErA+4+MmSthETu6zr60PIK+F0YGwobnUrj4uyLYSUFduUVIhOdIv
 YvIWYXAQZ6MrsK1R8SLDhnX25+yebZQJXP1QbKDsBAb/pNd6braURwg34kJLymn1ztmfK1P1GeJ
 wgpW1Ywv
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6899c670 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GLNcJmYBFrBTrGmVxUZOWQdAq_KBAeEU
X-Proofpoint-ORIG-GUID: GLNcJmYBFrBTrGmVxUZOWQdAq_KBAeEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

On Sun, Aug 10, 2025 at 06:57:26PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 34 +++++++++++++++---------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

