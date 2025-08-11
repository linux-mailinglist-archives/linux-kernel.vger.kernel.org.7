Return-Path: <linux-kernel+bounces-762371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F773B205AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B389317B7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385125CC63;
	Mon, 11 Aug 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iabp8jC3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109422FF2D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908536; cv=none; b=VXrYalCiHaR389UM4S0HLyxCJF+T5nFKVH2Sn6BXtHcnPxerxLtKZws0zD5mjQImGNdV/XdywutqBLb88SJqYPDLq0urDBRqjtScZ6RTYpoSYRuzmMHeBd3qOOicWGGs40ZYVy3CQMeiHVEMXR7q8wjkNkvF1lpv5KeKKGfnI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908536; c=relaxed/simple;
	bh=U+O2YmiUaM5zrBR2yEMYBT03LRa2SmNuFAgb0DjKNA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he/pM80JQiBgCXoK4ITrR0O419E+2AIB7J4mmu847D52+L0Ift46gOL7ZIcxMNTyqZOMaxTjJP5GkqgKLGXkImlH9Cj9tJyw6z4/kCM8Hy9gPuXBJNmbgTyQBDn2+91MBJNajwMcfqmPGQbbbgjCEBYtuccG8NWlz48NugUPZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iabp8jC3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9qM019056
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3nfN60jdUBtaQs39UNaxVpig
	z5/FB/TFepwaJ8bZmqU=; b=Iabp8jC37l+5c1heoHBD+T5SrH7/okVsULQROKRB
	4CBkj/JSZHMqZ54QQXeKxOrXHgbXoGBTBdDjtNoQM1iopYSgO5Kg3/rUdb+GyHoJ
	Zy/PeLma5V2wHjNIQwvYYaeu8RQnFBuFf9xDlPa55UVmVazVug9oUJpEx+QIGIcp
	FFI6oYnM0VaYO4I/vbi7rCii9D7n041roc5P361r663yV1C3YHwoC199KRuO1KIu
	VK5l9p3LnDvx+xpZlohvUh7wp/b516RQBrqA/poieFDWyyf3mqE/RLRLR8yOeion
	gnrszwMY/4JnQCl6Ni4juj+H7xV8NGGqda2WU1e260uNOA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:35:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af2237e4beso96724241cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908533; x=1755513333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nfN60jdUBtaQs39UNaxVpigz5/FB/TFepwaJ8bZmqU=;
        b=ZPvxRp6d75HnNsl+kNgslGUp4LXbhwnORHp3z/8eh60BBavej0MYcygzCf7nLqihmx
         GDubsrCqs+kEi/e0TI+BdOu18c4bvdXTXr+toNDwuIRcx6OmVQLYMYli1BzRcH7bzOxi
         Eusae9WHbaujRDJb2MjYUn6IniP7COBqzsnr5gNcWjWtuBEECo4xijZYQaDRLaYdlZEf
         +DqX2mDxJX3fijWCJZAa38prKKMZFbPIk1WM5fOlkjz4lHJOCxS5Rh9W3wApBmYmighd
         yvsu/9SqNBT8/0CpH0Gb/AEfvGAz7JqM6+WMy6P2m+MKcNooeN4jMnfVnxXia4Utp27S
         n0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUJXPTR1x6w0s7/FcThsisM+xUH4ADyf2oMuC4PCkxYMfS8pSzFmxVoqUeJRdnwerrfMZxVv3dnyfD5Vqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqpkxh6/X1XuYjENM/VL+LWQotlq/gJvVWkTrYRUg6NFj3r5pD
	r0555GTdh1ZMxeW2/U/H2esPte6QWkaZMz/loCn8hv7rJhtThM8YcZYesZrBodU/LLCjr2dszUU
	Qk3f6+IHncU2MlK+Lld6Gy9ce7XTWq1efooyWlQ1aql2vj84cNMprI7uY3ohKi1feau0=
X-Gm-Gg: ASbGncufdvT8FmE0W8RMnAI2yAvdJSGR8aH22ObNHFoF4zke5wXt+XsQaaHzt8phRe6
	eU5fR4aP7C8anZYpah4bnZLIiSeASS29lkhJD4bDSYfiFQbKT3EkaKWw7jVhe+5EjIXK/XUcDjY
	I1YA9QGY4QWptKNty6M53FCT0HScu0znFPwwW/wxhg5j6k9Iq+mqjop+MaJUz3tuUR873jg8rRv
	wSFxSkSsL6Jp+FAdMzbgqMnPWuUhuX8jeBQ2CS/3N9V/ZjzAuIY9kzc7Sy/1Ghw8OpGSBQdHj8u
	hDNSgveMywL8Zk0pWiCYm6CbseWz1fp5/CyNbiWI/eYRaC/9pSkscqmOtoakMY3r+bIP8Sabv43
	yG2xJuUyaF5tNhadzeNAqzANIlYKxtIdhnC4Q+4G60eQI1baYm1wF
X-Received: by 2002:a05:622a:13c7:b0:4ab:3963:c650 with SMTP id d75a77b69052e-4b0a0718816mr236623711cf.10.1754908533247;
        Mon, 11 Aug 2025 03:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEyahsxVGaRdWMce+qoZBor8nKFhSp+X072mklH4pqlqFsX+5NaNxsNkaIEI2fGWy6wHtVUA==
X-Received: by 2002:a05:622a:13c7:b0:4ab:3963:c650 with SMTP id d75a77b69052e-4b0a0718816mr236623311cf.10.1754908532801;
        Mon, 11 Aug 2025 03:35:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55c9c847db8sm2272681e87.84.2025.08.11.03.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:35:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:35:30 +0300
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
Subject: Re: [PATCH v2 5/7] drm/msm/dsi_phy_7nm: convert from round_rate() to
 determine_rate()
Message-ID: <pem6b4hf5gzo7jbo46asminbqqrnkhcx3nwsvstv76ntmeasfr@sgckrdc5s6og>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-5-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-5-0fd1f7979c83@redhat.com>
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899c776 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: pwSh_o86-xMyFtS8SU4lQBETyECeaVsA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX5PZqw3bWp4N1
 MVZn8VebTDqCGXq2DdAR/zBfo1mLcgsv1hajxGlaFKCbL8TNmX+k5AR/ufVesqypzn32mqDXVEr
 WirZNlS66Nq945R5gnRnp8dNwXS+4MfrEAZBEAsQnLjstCAEnpOqWJyIYFlcYBBGdAWosO0oonN
 75iDsSOpgzfurBV8OM+AeOXck1v3iL0Z1JGKemyDEMbCNLeee9fP/GQiB99k/JTRLj4PJ0i7hq5
 YVw2hmWqxtIb4K2afZCb/KU2zseO5luq40HcKEkkaHng1UKXwVXT5csilrkreO006/4GogMWFWR
 aNFH0KLll9zvogw7yrsOhl62kyJ+DlQChKvPJdY4NxjB/d4sEGIRGRm+v6zVWQX3AB82whHWmSx
 eKchJ6wb
X-Proofpoint-GUID: pwSh_o86-xMyFtS8SU4lQBETyECeaVsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On Sun, Aug 10, 2025 at 06:57:29PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

