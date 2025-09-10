Return-Path: <linux-kernel+bounces-811028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDFBB5231E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF40A16286D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AE2F90E9;
	Wed, 10 Sep 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXDapsa8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3E2F8BC5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537719; cv=none; b=iR9U25VoqCYxOZ5speWIbBLVToci0ANGVlQITCfzWKWwRs1ztzGr5YzsSp3W5GSZGG/H3o1vtwPgpXh4nVENUyjJO2IOB6ZbgNuBLwvGru3k1azeJjzRg2p/q4VjuNVu6dH3kV6R0A5jB7E+V3e2iDHExDGx9pHWjfQbrUmlcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537719; c=relaxed/simple;
	bh=3NzwNDgiyd6a6o1jKKrHAuOu0Ceuy2dAHSQb5ma8/h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGi+8jwZyQzOMcHzZMw2kOiyyMY5kHy36vgmGe9lQZ8zh8o8GeI7b6UkIDqgalAQFU6NhumOCtbQGmHpKk39s9CcXgZFNp6VlVXcdmAx1GMwMQIhPCTlLMEXLid0j0uA0HbjB6UosFM1LpL+zt6iTxd4Y6XGBJMZHFCxj5tWIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hXDapsa8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgrpI025110
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u053Z73zkai4Xa8yTebTvs2P
	Y20porEuaLkDE+bAlMY=; b=hXDapsa8K+egvdzRMaEhilqeP0yTemicIzJ0URnN
	wgwkvRdsBx3kxYKkiQ3s1OSx/KfUXHO0+Xmx3ndGS9iJmP79m5ufXz8HUQ2Ub00W
	utwmBv2RzHjZgjgiMd5RCs6cqzRxOjqk5hXRjudiGAvfOIbVX0qt2YZcC9oQMO2v
	9+Hv7SD7QbmaWyHwArB7ep33Xqu/dZeSn9oXyKrAdEkpPo9XCq4hXo8CnuFfgmxv
	uMgRHDw2kKWIeGc4ZqWfh6Jq7uvvmyRZVqdCzGAbnhDvHI9MTNHrEvRNi3RJd89e
	oyPv6e9Jpsmz/SO/UIj+MdQ3i6R/4KwFA2hPNrFgeNvUYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8na5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:55:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f818eea9so1354691cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537714; x=1758142514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u053Z73zkai4Xa8yTebTvs2PY20porEuaLkDE+bAlMY=;
        b=ppra8v/mL/k7YkLG2MLZ7o08+Nbe5N09xRUCUvhu8BnHo1AMmm3pkp/P5eLlPsKPTZ
         bXmOfvmyYCLVmiYDY0yx5rRFeny4t60klG5ZFTNpPMjtovmDSF87PpYT/nS7bDd0o+if
         +QGz93pb+BmnfWv5KEgTkhkK538yzsEOPS26/fSby5btrj9orioBXf+77tuj0OS6YQr/
         dDjMjbJFm1wf6V4ew00fMCcp2BNzqzGemupv7pqgtBDf27WlOXeLRegmsAjUz84BD1GM
         zFgu3wbAK/zfxeOmFTjWH7nyFG+xn+0VQKFlcnNiv7pT71t/s9ob4oZR5ldH99q3XF6r
         58fw==
X-Forwarded-Encrypted: i=1; AJvYcCVQVLSEEReYK1yNL8BqJPBw9fviDFDWm5rF6v/wLbSx5wqOrK/xAJ/Si8OXx+0sDF0sflQQxeeUcloyZS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyokcSNsbhOGtSfWJ7ST8VKfboxu6fds5Lzgk4OfA1/eom/SY+v
	hTUuvWPj4gnL93WEcQkDZWyCltzXqXH6215MvrTnyyh75rBkuahj596y8FEuVLeVvCnoFzyJVwl
	JnRDC94kD5tTfXKgPB+Mr0UPdUDrWDRzqVOFlSrprPaMNXfAn0vWRC4SLOmiT1z6Kfv8=
X-Gm-Gg: ASbGncujSXU5yCVJel5ecJscEWQKNhP1wonhPIEbOTJ88PjTrH6C0c2oWfGbEi4iccY
	FKA6I4SdWCLivS33bE8xolEGzYkLr4wDRfhTAgnyH91cJKtsnSwVbah78p93snG+L17JF9crd9s
	SJInkFgprYf/q712ZCrt3/1BYTxub9WxEjWkBtR+JTdJxMuQACitue8Kv2ae39MWKT1Oc1fAhqp
	LIAe/79wqu1mCltApKUX94M5YZLQ4BFwrAWvKha87qXX5g2+9ISv373DJi+bFBQxt4p4z/oqakI
	kT6teEZQHfmeuoB1Z9jBugzhOUD/OOuWLxNhNk6nfYbnSHQ0lUKwdi4MwAkEVo1YUeMBN+BN3tA
	Lyrt042q08pMMTi+gnlearFYYrAzekmAqhA0+4O7J/hOa38dRvxEE
X-Received: by 2002:a05:622a:17c3:b0:4b5:e606:dc0d with SMTP id d75a77b69052e-4b5f8464f56mr172407801cf.64.1757537714474;
        Wed, 10 Sep 2025 13:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuuiI0Sq3dAwccCIQjFGmfMsKB4O9JNHlu6WabCdhUocfd0ddszBa/a1EYJO1myy3iU8qHCg==
X-Received: by 2002:a05:622a:17c3:b0:4b5:e606:dc0d with SMTP id d75a77b69052e-4b5f8464f56mr172407211cf.64.1757537713811;
        Wed, 10 Sep 2025 13:55:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50332cdsm47364151fa.36.2025.09.10.13.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:55:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 23:55:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] drm/msm: Assorted fixes and changes
Message-ID: <7vs4f2cofte5jkvoh2dzd6hm7pwqaiz4holt7fosjo5uwsavrb@oigtd3lozmgt>
References: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-assorted-sept-1-v2-0-a8bf1ee20792@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXwCQgraIlp0N+
 rwuWbk0xdyBli6sHQkyc3Go6Ye7V1dUC1W/sC+78Scng56veT5rWHWh+SlAv0Oo5UCEo4TIw68U
 Uuh6FpOD+NaBtNXNIJTKRe1ChvYUvHBZIbnqkOzryP8e//5u9Mr5x0AcT6FGuCqIfU7swSSzliA
 uyald6858HGwyvbk15xsNDG86UgADgjEaHE4nNNyd0zAl7OGuvaCG8ZxAyfsn1/FQoYrrkWNwDi
 +PBJ/oHb2CZkyp5IaWRY6ERXCgBxsjH20Lcv7j62y5IQaBQSG4XpKO78BPRcsDViWjJJcgHgDk6
 PQ8I106AIdhZLYznafhJBQo51zxUazRfAVvqdzYrK4PFDbu93Vpp0fukhzkyezR4iHfZpIFH+qk
 g6cxwQIj
X-Proofpoint-ORIG-GUID: xzfvn6aGGqgSWIlB5TWw-4iRDyZ8WoJV
X-Proofpoint-GUID: xzfvn6aGGqgSWIlB5TWw-4iRDyZ8WoJV
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c1e5b4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ui4H84HzkJsvguT1G-cA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Thu, Sep 11, 2025 at 02:14:03AM +0530, Akhil P Oommen wrote:
> A few changes and fixes that were lying in my stack.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Wink-wink

> - Link to v1: https://lore.kernel.org/r/20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com
> 
> ---
> Akhil P Oommen (4):
>       drm/msm: Fix bootup splat with separate_gpu_drm modparam
>       drm/msm/a6xx: Fix GMU firmware parser
>       drm/msm/adreno: Add a modparam to skip GPU
>       drm/msm/a6xx: Add a comment to acd_probe()
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |  9 ++++++++-
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/msm_drv.c              |  1 +
>  include/drm/drm_drv.h                      |  3 ++-
>  4 files changed, 24 insertions(+), 2 deletions(-)
> ---
> base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
> change-id: 20250901-assorted-sept-1-5556f15236b8
> 
> Best regards,
> -- 
> Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

