Return-Path: <linux-kernel+bounces-839705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2ABB2340
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E034F7A2398
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8621348;
	Thu,  2 Oct 2025 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZphk4Nh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B527DF59
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367032; cv=none; b=YjYeYHGJdj4hkLU2SRoyiPUzwkWEmSse/wDmkdISjmgzoo63acFQLsEDcbtbC+Qf+PLQZn5R7rHi+sGBM7C4lF29VcdHV45OfFYPgEPjWmvPayAf2wv5y0PIMdS1r56OLGdDiZNRP5x2lZVBSCO6di5pGS1+2uUFzEjqmuW5Ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367032; c=relaxed/simple;
	bh=5Ie8hS7ySudMhvrFQ120F+fE0XrbFcZOgEC5UeBk4IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIZwK2zTmnOiCrUAfezE+1mLbVXolnYYD+4b41PC1ZcQ4mqt8d1bqCVB4LmNPPBHMuvYSQx6cebYSQkHV8cQCWRxA6hCaVUtHBSgcSS5THAjFpCkm9sQ56Ia/U2KTs6XXK/viZw38oBQQENNCBSxIb6gpnzYakoM41EiQFeSFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZphk4Nh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591MuqAh027601
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 01:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fHrr65lNXuCbU7GLecWRSzb5
	A4LI0xtyUM7m4ktwrdY=; b=IZphk4Nhg0W0DaJgkAk/2l6BgMbcMbaUAmi4e2Ht
	zf19C5MX1zPKhZOFpiLyarnSwJE4FCZ2/9iUjXgoTfvUPKGQpWBO0HPZFzEhpVFm
	qd+sPnWUvm0ei5lCm/U9NXCQUiCqgiYadMkQla56TJFVuNOYiuWrHHTVk8FvpyxB
	qqaJSTm6N02CJLa6o+DbETd0IHyz/bxBFo2F65K+1bJw2ccYTc0kpMh7Yq2pFNm+
	qUbPTcbjlatp84jBLUT++FCoZDsO62ewDaBV4l1KmU4JbXrVO68H03uww+Xa+vuF
	fALG5LzZCoGY2nYVuFutQWPJ/3if8tMPbU+tmxBtHMD4iA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851pat7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:03:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4deb67c61caso14482471cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 18:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367028; x=1759971828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHrr65lNXuCbU7GLecWRSzb5A4LI0xtyUM7m4ktwrdY=;
        b=YZVuvl6tJ/s/+DB0SPAzn7AQVFn/l0EoC+36bKnew9chqSDrTsFbl/pBKevKWhUGsn
         4EDL1iwK1zAxbcdmPreGb5c9wkOIcCSELl5hwse4krUdCsOfIAqvskgZNVUWHfdRe3cv
         dC/fw7OPCgt+XGB2OjkvvLrgeEmrQLL/qpd7PM7DArQ3f48Uql7aaJ2AlKPEtiNEA+nw
         SIMRMOMx7rjpTDwimoJSpQJhD6MSeVWQxMnygO+T9NNzby0BDAooTkvPwawYUTsEKEWu
         9SkBY89MZq0joVcCCPT/1z/AapyqWqMEMYmSg7duAU6zr+QvRmUOAQ47Z/sMONlTycCo
         dUiw==
X-Forwarded-Encrypted: i=1; AJvYcCWxQmYsQNHE0ZDpTD1RwhIMcmo787uwJoDPAr0zGBw8hL/x9mTxzssybO/1O/HYiaxPiwdJ9092LXbyE6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFM9CYw6AEWMGNPXfxGnwQ775tzeoe5JZZfYVoXoD71858a5G
	rHOWRtyMGLI55FNjhK+QIpyXtA9lQAnzv11qU155PHhceyJQjcI25pwVZPAm0zjG7imHLpWxDQc
	Dp4VJccoqqL6xGP/LRURbLnYHLGstSzB295v/jR660xi54NucSCHQIZBCLGMfCxjQIjE=
X-Gm-Gg: ASbGncuOFTLAcRwyvZGP15d9wPr1rA3nJksCsaeyOfef5Baza0pcMKl+pPGvI45FI8r
	8aqzGQoWHj8YM4gMIxYYrialhnlc/cRpOzP9LEpMxwVsNmIhgfB4iz1gjtLWv6CNnpi0wOjRspG
	6HMNUx8bFcnJQBwrGE6xLlowWJnJIc/JLHchyZI6y6mJkt6OgjCNFPg6YPi+1wkYlMvOcOs+s4z
	O5qrw8BmwZfrbkKVdItlaKA4aQANiUDhd4U4DpTwnks9Fl6pGZQYzIM4w3k+0pkWxdpQiNHRBYf
	9AqssqVebHh28Y6o5fawif6wrFcsUJrkfO8/Pn0TfwwVWPi4h7yjB7iVUlmVsKP5PB/Y9z10haz
	NmQccKRz5Cc32DorbdJ8mT3bkf186Vx4/04oXzusWOHqqQKMe8qhD6ySgrA==
X-Received: by 2002:a05:622a:1cca:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4e41e5453cfmr73046441cf.66.1759367028494;
        Wed, 01 Oct 2025 18:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+PPEgu5a9spnGcgbd8IPDdjH3CRYSnDJceqwk4HUzRW0WSjlgTwcpzIm44jNRFI2tTLMX0g==
X-Received: by 2002:a05:622a:1cca:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4e41e5453cfmr73045961cf.66.1759367028031;
        Wed, 01 Oct 2025 18:03:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b140asm337846e87.133.2025.10.01.18.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:03:46 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:03:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 10/17] drm/msm/a6xx: Rebase GMU register offsets
Message-ID: <eicw5g5ozli6tvcsvxdorvd5ymxizidodbrfitqezcezwlzdli@6koxrgnu2lj3>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-10-73530b0700ed@oss.qualcomm.com>
 <s4no2wy3yskk6l6igtx7h4vopaupc3wkmu7nhpnocv3bbs4hqi@uhie6j7xr2pt>
 <edb8b0dd-126b-4ed6-8603-119f1fd52baf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb8b0dd-126b-4ed6-8603-119f1fd52baf@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68ddcf75 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=93h1c-cikf9FHO0Tq-gA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX0MEzBF06NUNJ
 GKub36lSyGBzha1d0h0IvBJRJgD32jnPNASwVMHfrpsbFLgkCqCoHOeOjcIjuBN5IR5xV2l8vzl
 XSXjdO5CNEpov95pAlNz20LW5wpfVeHfb6RUHLDgTuQ6QgFysFLTsCUttBHYvb6NhY15wirbohu
 +Wy6jr3gn7EJL6h9DEbKmSYzQpge8stC3aNO6ey5qhv4GtFzOQUzJytoA1Xip1I/tBKZHqTRHrt
 Th4KmdIYVeY3TaKfZwIwBNQ2OgiPGNtsql7fGiRJMjODImScYRWRmoaRn0AmwHnVca/8J75W9+R
 0Ycq5wurRelHkkRZ1hnK6Qvm5tGsxwmEhOLOaqL4brpBjFFS1lTlWs33kjGzGyarHSJTqStKQh2
 j1aNmYsf4CY5/c1mNOrc5qfnBKaYAw==
X-Proofpoint-ORIG-GUID: 9hWNHXMH-0VW38B-1kxqBcPwp7jP9orm
X-Proofpoint-GUID: 9hWNHXMH-0VW38B-1kxqBcPwp7jP9orm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On Thu, Oct 02, 2025 at 02:52:35AM +0530, Akhil P Oommen wrote:
> 
> 
> On 9/30/2025 12:53 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 11:18:15AM +0530, Akhil P Oommen wrote:
> > > GMU registers are always at a fixed offset from the GPU base address,
> > > a consistency maintained at least within a given architecture generation.
> > > In A8x family, the base address of the GMU has changed, but the offsets
> > > of the gmu registers remain largely the same. To enable reuse of the gmu
> > 
> > I understand the code, but I think I'd very much prefer to see it in the
> > catalog file (with the note on how to calculate it). Reading resources
> > for two different devices sounds too strange to be nice. This way you
> > can keep the offsets for a6xx / a7xx untouched and just add the non-zero
> > offset for a8xx.
> 
> It is not clear to me whether the concern is about the calculation part or
> the xml update part.
> 
> If it is about the former,I think it is okay as we have confidence on the
> layout of both devices. They are not random platform devices.

I'd say, the uncertainity that in future the offset will be the same. As
such, it's much easier (in my opinion) to introduce the variable offset
now.

> Also, we may
> have to do something similar for other gpu/gmu reg ranges too to
> conveniently collect a full coredump.

Don't we collect the full GMU register dump?

> 
> -Akhil
> 
> > 
> > > code for A8x chipsets, update the gmu register offsets to be relative
> > > to the GPU's base address instead of GMU's.
> > > 
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  44 +++-
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  20 +-
> > >   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 248 +++++++++++-----------
> > >   3 files changed, 172 insertions(+), 140 deletions(-)
> > 
> 

-- 
With best wishes
Dmitry

