Return-Path: <linux-kernel+bounces-762370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C8B205AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7272818A25A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25A242D78;
	Mon, 11 Aug 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuQzg8J+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EB22FF2D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908509; cv=none; b=qZjl8k056OGmR6NIVfBeuWH6nWbpXZh/UqsxpeNANWr5HxevKfaDV0B4a9BWQeLB+bVmTd0lqR8apB9VP1mMpHisfldC54mWEjkL8Rs2gOFU3wDXCPpe25IQms3qJ013NGEzA5f6nEdf+wmROpCQO7RInfei/yUOQcPk+lXwHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908509; c=relaxed/simple;
	bh=bmQlxUXXqyRd/mIf8K3AoOou+MqJRLfIh/bynmy2eE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti9TLMtCXG2cNqEggCq/V3RQc4yg2Gqveu1iyPPlYWyX02wutp9CUMUk7VYIAZMT2F0oWEo3q68/DDv6Z5j3UTbv1jngqOACSIuB6mCzrbaTma1w/Is0AQY4ypLTqFncUYvWxINqpaHqPU/GFDbIbdjFf/0LLCSdQOcXFq2mgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TuQzg8J+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dBhU025530
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PE6gchWgUhiQ/wADu4ACCMtr
	JWOkRrEv9QXoDjpuWRo=; b=TuQzg8J+9bNzLvszHl0wheo/9IGGjtChvXLsCwO2
	y73TqgwF55KLwjVWLrhBwLXoggVdelQUYVadf3P9rQ2TlQWKZ8w8SSneV85Ui7lH
	BTwIIkYjfXO6wAbWxelBGfn7KV5OdBcaCuwYBAa+f0L3+M/Bo42bTqJL99e/751s
	GZ32yVAC8gi7Ywwv9hQtlURN4ndCWg5np1NQ3rh9IbLy6j6QJiCZoUVDfntaEVtC
	NXf6yNm5NaUGMWSH7opBibEBjmtgbF0bbcnzEM3NBaQ0lb6F3g8W4/r1qWVstbGS
	rWsMxs1Yo/15XCANUnJj9YB+oem3thraVjryUrp6row0eQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dwb742dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b065932d0bso129397541cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908506; x=1755513306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE6gchWgUhiQ/wADu4ACCMtrJWOkRrEv9QXoDjpuWRo=;
        b=b7HKKXmcj6BCpRMiJnZBFhPTIBwTMdJVChGA+ECz5zuqOBG3PhCv9VwWIcx/9SraFj
         vEcYtlIbpdocw6uoxSziIG0/3eVYAfFDj3QmViU9yVcTWrE6Jcii18J3ZXnvFqMjynTR
         9d9Ohs6ZETtml1lmTk7rmlJ6x/VSo9obOfIt0MgpIyLwXMz6qt/AsenSw6TiYW159BHu
         2588mH/ElFTkGmNslSBtn28WBuAsw53JkN7uViMTkrlmXGxiGiPc62VIwLcEIdun7eZ6
         +dSnj+2Ru/uWHuK8oqFEaGky4HjiKrYfQQXDj2gSrlhANux6nUet1wqlHvb8qwb64pIe
         f12w==
X-Forwarded-Encrypted: i=1; AJvYcCXcjB40bE5k0ZjOR3me5wsHkcE8uFyQL6+1IA7zmWCqArirCUpuCWZBLHxWD8I7P6zBItWOwlNo7U6yo40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TkKHEqfZzNfbPEcYi0SmGmzw8hSymc3DmfJLJYuGjQ7zE4Iv
	gR0P6hxl9ZnYZ54uGAapOahKK3JuEdkTJb75hYg6yBlYimFOwxCLLQAQWcyA/jB4JEM/5C0aGK8
	nZYEVo+QR7BX4Sj9sgTo+qNPe7dGifpwxsj99rvULLsk4YwW+L9bW6CGRWLnfg/O9Gdw=
X-Gm-Gg: ASbGncvF59D+iNBoGRVB0hBZx/XerDVFmvw611cex1ua6kNNLvXte7hSAv3KjvzG4yf
	rWOv0trRqjs8FlojH+q3xNdYnzcQOL6RKw5n3B3gMjbsXPiEqMoeIi5+mpRBrimDaH4Wsih9tGx
	Rd3ikd37bYmSW9Fmd6qSF48+eNdteK/gbOUFQE2kKiozRFqoOAhMQs8cUNBvZkPmlkG7CnyoV6C
	1TDX+M7X5kbGI/yLJUf0KAq2oSaAyc3EtVXfPm6L4lysDOJZVUNKilnnCwt2D/fVXA7fvXt7XY4
	JHF9Ag2IwrRu2Sonr3gQL9zHlXkASRHVCh0VWmRFS1Bgf2T502JeiTyb5Kiy75rkuH3iGL68plq
	2QyCr5NnxW+u4AukDf8wMYDMaymHws/sFkBxEk+oYBdHCnb/HCGiu
X-Received: by 2002:a05:622a:1105:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b0aed4bf82mr177683091cf.26.1754908505870;
        Mon, 11 Aug 2025 03:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5z1smTUet+hX/GcT1aT/9S2JjVbf9QV8q4hC/iCGMx16KAq7C3GFwGhrpRcaCu48ZUqvWAA==
X-Received: by 2002:a05:622a:1105:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b0aed4bf82mr177682791cf.26.1754908505440;
        Mon, 11 Aug 2025 03:35:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cac7626fasm2255259e87.174.2025.08.11.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:35:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:35:03 +0300
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
Subject: Re: [PATCH v2 4/7] drm/msm/dsi_phy_28nm: convert from round_rate()
 to determine_rate()
Message-ID: <2q7yo7ad7xvxkij3jtelrqxxctmaatdyi6zavsfhwq6oga4w2u@woq2yrvdt5u2>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-4-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-4-0fd1f7979c83@redhat.com>
X-Authority-Analysis: v=2.4 cv=K6oiHzWI c=1 sm=1 tr=0 ts=6899c75a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 7ohIBwfD46cv7EmZnN_JjFhEi4S5Avd5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxMyBTYWx0ZWRfX9NHUeHZVXg9W
 U/otT6p0+4b8Nmbcwhkb13X8czHOqeMI8onntVkH2cA7fdDAqs3nFJ0Fm/WFlNqxLxt3KugAZHE
 RmV4GA/O424gWg+yMBj/gwCEVSnsVwafO+HXWokGTX4Nt2CZPUMx+NNagwn5Twb2GAHkFXCY5n9
 1aoTGcRyR6mfXFSTpBnGemFCFf/B5l9f5msGHQMtaUFCc6iVRNOJzsIm1xfs7F+K0utwR8G7ZEI
 ksDyuSgnXBk+MNXlaCViZjdlStvERaq5JZOUZQJ2aoQM3hCucKrJ6k0MzOh6vR6Q6CYlGwP2DYg
 I6cMq2zLFglc4bGQlF7mlsjipwc1IUc9w4Nj1+hoMXjMb0HiLR9c6wBZ7bsYVeMcqoHB6mq6H2i
 Mo6z//Wv
X-Proofpoint-ORIG-GUID: 7ohIBwfD46cv7EmZnN_JjFhEi4S5Avd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090013

On Sun, Aug 10, 2025 at 06:57:28PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

