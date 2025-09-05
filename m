Return-Path: <linux-kernel+bounces-803385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18113B45E74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1716E0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBCA309EED;
	Fri,  5 Sep 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7WbpnTy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF11306B17
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090582; cv=none; b=Mutwmn5xu6A2UxFP2P1KseLxr1uHzAxT/HBEJXmJ7wq2rTSU2xa1xXDf5457ddi2LYFuvrTuqnWOsg3VEPSHcNW/e/Xf2lD3ON9fvDFxbMyIhU0sfujI1Zlufxdwjr8Ql9SxU4xHS5t3AFkDRhBrm0ISR7tCt4uFGKi0gVXo8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090582; c=relaxed/simple;
	bh=VWbyFdvaSUqfRLDRkm9PlbtB313KqeKRKvFGLA9uaRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DefsIRxe8/x3xrI9O9SkruesvYfE5EFDA+nJRjpCClHLqr+2KKfsXHW1RIHOueNGJCb5jfnI51BkioYRnsMsJGOlU3KQpg6jAZJIHeehV711LzQmjAU9rpPYbDc652MrVP4PWYgNNZrBhxPn/mKfpJXBTuB5hIlXrtZwr0Wqnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7WbpnTy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GDPxN004654
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OgdWpq37y+9vEpO9XaoifcHS
	/4f84Cp4GGDpq5ttRE0=; b=D7WbpnTyRf26cppQG3eC6BVX+g8Up/JQd7Ryv36J
	HXyqMrewsAR1tvSC8CHscrPM3xfnuDVgtzZUKSk+iI5d/6Tym7s9/snSHjx6oe6s
	Wtn8dagecrfbq34Zv76/LVTCJkO3xCO8/t+oLkYB6cyzUJZjTmWxJYXDilrLklhC
	DbnAuVII7iLASKR55ouugd20mMjO+o+yeZeFRFXRBFyFCgc0+LfNx0sGGk1NVlGk
	IMjzQ579PEFVEgt+Wa2JSm1bUvFtQ7a4F4LWnRcpA8fqVnl5xG0xrt0nfUl6Qg+N
	8OVw2px2sbbAbTL1hZ3QV9S3ASvUFFBNKEk94ZcpxjUaXw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbxd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:43:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so27465621cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090579; x=1757695379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgdWpq37y+9vEpO9XaoifcHS/4f84Cp4GGDpq5ttRE0=;
        b=wvO+O2ZOZsQkpukaw7PKsoEDAJxdDyVqr3RLz6llF0QOmUn1+nMDDwIufbdQx5awHV
         vYCLoH8BZ0PuiF9PHBhT+NOeo3tmGFx7Dyb9AJzOw/y9MADcTGiZ0fHloGD3KzmQiYo4
         Bed0w/dDEwYs1/fqbB/wM20Bp8O9Zbz7/Avt3qauWH4ooIK70nvlums4BywbqFsaFtrA
         Lg2WPqXNVZugzd4onk3yIyUVVb2hfdFKufpUfkvh5Wock+8/qfso5fIl4Yxdlk1/OKbg
         XjJ6XB8sZdzbE7gfSNaih/gVlwZwmZXvueGNx1aIIlmAMorW9zqaj3fPYNkYXXTvtv4O
         Fm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbyC06tUQhYKFcmf5x6tf7zBRW5QUQvu5Lt5vOQ1PVxeIlUNUaANkzgjzbtzQjMmFTm1davCSaAlRcAik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvXXE8q38j/qiDiNa4gJ6h8tOSUJhu9/t44G7prQKM+uL2oNv
	0szl1kIrCAb5y1ksDhQqWGYqu9c28FPjz3rKANsAhttUGt/o0ngmduUbBLChFIWLWNscsdRcc1O
	fEf05mK1KC7tUUl/GREEfuzYjY2K+qfxLCJBng/S9P+C2DeHZNtBJR9u90D+CLQhyAn8=
X-Gm-Gg: ASbGncs2bc/jg4cg2c+LOHFxONctUEKbBkUSHNC8BstXWXTp4xP/b7+fStnJx1TnTLP
	2LO0ouzWV81slR2tRuN7c39xyxjIFkY2EGFHopYHq/oskZ7sElEvej5T8YFPnuekrLl13ZBQC/G
	5bA35ZdWgt53DNAhhYR3HYe7rJt8X/SLgC8V+ieI5A2g3J10bFnbSnimlQkgXhIXOqGl4BIV3aF
	1uheXwMjwYrBPejq4Tq3Mw1Ya5FYrC5V9fhYQpTEMZpUsQtUiA7GwwCN0BqGaX1KqxHF6FfBltx
	Z07U0shHNRIa3wlepySlOMboU/hbZpHON5vId7INF4Nbz+dWrZTgIm5GhwWWYLNwUjoi022wO0P
	JzmQQd8GH6mCXAKHsnZAUAwl6R0HC93EzOIiSTzGnBfdTGT2Qxuxq
X-Received: by 2002:a05:622a:1388:b0:4b4:8efa:f9e2 with SMTP id d75a77b69052e-4b48efb085dmr127781461cf.29.1757090579321;
        Fri, 05 Sep 2025 09:42:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHDhaPV+DpUqz0Gpu/izEq6Kzs10bxHEYDUSOPCSB94dwofk5NG2Bs5M2Pj/40aa37D42TuQ==
X-Received: by 2002:a05:622a:1388:b0:4b4:8efa:f9e2 with SMTP id d75a77b69052e-4b48efb085dmr127781021cf.29.1757090578802;
        Fri, 05 Sep 2025 09:42:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c15dsm1869487e87.24.2025.09.05.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:42:57 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:42:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 06/12] ASoC: codecs: wcd: add common helper for wcd
 codecs
Message-ID: <r2vk6rus2ownex4hunrwxutbrbsggmbe7lgiiksetum72y5scn@6kd55k5cdpr4>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-7-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-7-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXwT/u4By+ApXz
 dCmSoPzZw8EWT9X+edaRtEsEs8u8h8ymXvm/nakAoki8c/sWGCVd6Zr82xTCaYb5Rjz/fzSP2xD
 osjNfcjwz9XPJpH8WQtsC/SCYwekf/dBH/dGxFbYaRJzuFCgBDDgN6xK5HIrLibkXwZYb8umooZ
 q3H6hvxvaYWCfCRPDULQU9tiWZnsyn5noyJQkJ2Wu+dkxycYBeRMrqhIDhcrzB8+LMnKOITgYXi
 CivNvAtXZWRM9Z98/bqHXWSs0/GNJoYExn6CLCp9PaTfxMQLxVps8yxmMCRI35XLeWD6P3bWfxH
 MRHxBccarjwMopXYLg7bETig9xQflWIhcDGeuluQDeKxh69WOjAYsMWUaG4OOgd9EYjE4yjxIkx
 7AeV0R3h
X-Proofpoint-GUID: 7nMarOvV1wT2XKhD7lpfUDJERsdKPIPh
X-Proofpoint-ORIG-GUID: 7nMarOvV1wT2XKhD7lpfUDJERsdKPIPh
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bb1314 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=svJh2_vFcTraKgw4RYYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Fri, Sep 05, 2025 at 04:44:24PM +0100, Srinivas Kandagatla wrote:
> All the Qualcomm WCD codecs have most of its code duplicated across all
> these 3/4 drivers. This is an attempt to remove those duplicate
> parts by adding a common helper library for these codecs.
> 
> To start with move all the micbias parsing and voltage settings these
> are identical in WCD934x, WCD937x, WCD938x and WCD939x codec driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/Kconfig      |  8 ++++
>  sound/soc/codecs/Makefile     |  2 +
>  sound/soc/codecs/wcd-common.c | 70 +++++++++++++++++++++++++++
>  sound/soc/codecs/wcd-common.h | 27 +++++++++++
>  sound/soc/codecs/wcd934x.c    | 82 +++++++++----------------------
>  sound/soc/codecs/wcd937x.c    | 75 +++++++----------------------
>  sound/soc/codecs/wcd937x.h    |  6 +--
>  sound/soc/codecs/wcd938x.c    | 88 +++++++---------------------------
>  sound/soc/codecs/wcd939x.c    | 90 +++++++----------------------------
>  9 files changed, 183 insertions(+), 265 deletions(-)
>  create mode 100644 sound/soc/codecs/wcd-common.c
>  create mode 100644 sound/soc/codecs/wcd-common.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

