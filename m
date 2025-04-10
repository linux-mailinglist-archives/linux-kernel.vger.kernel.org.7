Return-Path: <linux-kernel+bounces-598982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F53A84D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470EA19E5418
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424631F12FB;
	Thu, 10 Apr 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZpC/npS2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7E1EE7D3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314581; cv=none; b=WPvoIdRk/B5npP0J1oOWh+8Z8HzdEoSF2o5r79hkK0nsG69nNT2HqxOGrl8xTEOg05Q4nElxLZC35XlmQSDGr8gFKOt1rCHNJ4B1N4jCgnYwXBJ+vRpn/9zhfNsMSqAligxYY0CgPNcuPkPmojIG2T+P+RcfDxsAPCCII/KXiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314581; c=relaxed/simple;
	bh=CVUILzI3yY+5c0lQSYrQru/mE0icI42pipOKpURmQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SltTtBf5e8gzoereU+kDBqXE5LdjChlBXt37pdYLNpfP59vRShQj4tHkV4QGGJoJgeyxtb9AfBGb8mRwqCmldttr3FmDwjow8JuWJeiKPQe/p9A99hFMwARDc1a5Ujq8vGeCjYEg4C86jdP81lfLtzzFYw1BYAeBQ9du4FehR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZpC/npS2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFsSUd030613
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aNhuwxgEqLQlGdQ0sOZNsXWl
	JqoDDoZqwpr4m2bgAv8=; b=ZpC/npS2kfZgcSJsiieah2iW9S2n+3kFAJli3xUZ
	whp5TGslpUiPVsr4vIPkzojf5GmDVamfBFj3b/bnJPSF3DRtwYckKtsl4ZLMSs+b
	jHLQx8rl+XchJtVaBA0gw5NEptWFXndkXcWSeggoGmpWBKLG022/bqS2deXhiRGN
	z2v6m1Vl8ape1N5ibjcx4H5W4llmhrqbXbPL1JD9uFTgpEZwfXStfBeN2+fIBPJd
	SnLMj+oXQSQMdRNEx1BnQ3S0rDL6g2DB+0cQSwlNAFf/gd3UGYg8yLwC+ACv8kEt
	NGeJEc26PIAVNF/63o2zoUWkIAJEST1sOkqGIvyXb5KSVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftqy2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 19:49:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c791987cf6so261273085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 12:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744314578; x=1744919378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNhuwxgEqLQlGdQ0sOZNsXWlJqoDDoZqwpr4m2bgAv8=;
        b=Y7dZOz4vWwNzawBWFeNr+bQPrxSWadnQX4kTxxnrAy5jxe24N3rNp9JQtaukrWcPHJ
         Bfv2tp9JYDd/rldCyk7xVlt+2SvhuoLmFCjJi4xD76AyyRyogZMn0Yu8NjXMj1+vtuBm
         2wyQg70N/DfwaXvNgq7VNHp6CekEM171wT7mocFPHdnkxIwQy0L/uq9F53ati7rIAyxC
         MBNvIL5l6YlcNN3MlN6LyTPaQX63hTiJuVG22fAAmrk1TYLgKypvor5FL6fCfZ4G98+r
         KAzjeeC7YW9e/TM7BcKerugUBIyIeDYQKgUiyl2fPXcryuNrqY7VAoEw5XJHHPeRkS1m
         Q/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzApP6AC0AeeMV7gV32FQQ4+tMroXec2PDiFUyCeOOWY87N1IZsUoY5qpxncv0a6KFQdpJY9jIEOXiIbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULpYPec1JnQtyLvVLh+ST8ChKY5hDYUeJDSH22fp2h82vLfHy
	TWVhAbgF1m+iwsTKRBmuSjxXXQ6e397XyUQn/N9nhii+xaFU2bf+NrbngaM491zKiv6CZJr1gB0
	yozIG2ReTpxjT3OuEgaZ7axJv698Pa/NwIEbbgAcgB1IzVzaHy7dJhb4sHK1S//4=
X-Gm-Gg: ASbGncuIJndCgIk1P8voKWC38n0BXpoJzCUoiNrv0djjqQHExl6Pf4bauJBcezm1bec
	70y8IwBXD1W087DaYOllafsu2NmksJAvq12NAD2NGUgT/fX/bQ7ziQHA0BUJLo6K3r61foEnVRU
	xUszPo6GmFP42NbINthsupqslDzPmyCCp3Q5rM73BrYf3tyxEIM4xymmlcw54oAjN/ihRNZIgn6
	V97CoV8subj4OWqJbm0nVc3orl2m1k7FbyKzhDD/w9LjDcfrP16FjGs+mZvjXSaMslQxg34K5Oj
	LIiU3FHHELvmM0scjQ/JclrSPU2HwJ4YtX6qvxYcMqEnIxWaIiDYTmYfOzKtlFOwsqe/JXKMDaw
	=
X-Received: by 2002:a05:620a:2941:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c7af0f8841mr36836585a.2.1744314577839;
        Thu, 10 Apr 2025 12:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsp+mbswefuSskvfP4MGPlMZhuL5PnvXrRuwIIXDia3tt/3yJFdDa3tlw5fgy10G42iTdrsg==
X-Received: by 2002:a05:620a:2941:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c7af0f8841mr36833885a.2.1744314577477;
        Thu, 10 Apr 2025 12:49:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f4649d86esm5793871fa.14.2025.04.10.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:49:36 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:49:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] Retrieve information about DDR from SMEM
Message-ID: <iebl74rolk2t6xyoedy5p2e7clssh4dvxtpzerykyivrhkao4g@dbmnpia3xtxv>
References: <20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f820d3 cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OxrDjszf_QBMMd4ylzMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 31VMxkPoajRqtZPKdspqjKiureG8eloU
X-Proofpoint-ORIG-GUID: 31VMxkPoajRqtZPKdspqjKiureG8eloU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100143

On Thu, Apr 10, 2025 at 07:43:43PM +0200, Konrad Dybcio wrote:
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
> 
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v2:
> - Avoid checking for < 0 on unsigned types
> - Overwrite Adreno UBWC data to keep the data shared with userspace
>   coherent with what's programmed into the hardware
> - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
>   branches separately
> - Pick up Bjorn's rb on patch 1
> - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com
> 
> ---
> Konrad Dybcio (4):
>       soc: qcom: Expose DDR data from SMEM
>       drm/msm/a5xx: Get HBB dynamically, if available
>       drm/msm/a6xx: Get HBB dynamically, if available
>       drm/msm/mdss: Get HBB dynamically, if available
> 
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  12 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  15 +-
>  drivers/gpu/drm/msm/msm_mdss.c        |  30 ++--

This misses the dpu_hw_sspp.c, which uses ubwc_config from msm_mdss.c
(but the config isn't being updated with the acquired HBB value).

I'd suggest behaving it slightly differntly: can we please have a helper
module (in drivers/soc/qcom) which would return UBWC configuration data.
We can start with HBB values, migrating the rest of UBWC-related flags
one by one.

Also, were you able to solve the issue of the platforms where GPU and
MDSS disagreed upon HBB data?

>  drivers/soc/qcom/Makefile             |   3 +-
>  drivers/soc/qcom/smem.c               |  14 +-
>  drivers/soc/qcom/smem.h               |   9 ++
>  drivers/soc/qcom/smem_dramc.c         | 287 ++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/smem.h         |   4 +
>  8 files changed, 360 insertions(+), 14 deletions(-)
> ---
> base-commit: 46086739de22d72319e37c37a134d32db52e1c5c
> change-id: 20250409-topic-smem_dramc-6467187ac865
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

