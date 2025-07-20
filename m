Return-Path: <linux-kernel+bounces-738388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6879DB0B7C9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF5B18867F8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35238B;
	Sun, 20 Jul 2025 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDJ2UluZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890001C32
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037203; cv=none; b=sxm+2G+j0DnfBEF30Imxz4XvasLk4fimUXrn2IjifgPpLVDt5W3pWQc5tBrSd9pkzY95Aq15/UEuUAJXBEHe8L/lTQcxSRgFWNvo7P0tj/sgRN0p5RiRITmB6lJdP1R7JjgKE60x6XbbGamw/d7dUBenPN4cJrjoupcgEA80QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037203; c=relaxed/simple;
	bh=xe85K8u8R7ec7oH/qcfbzLwjEDGcnx+m/nS5Ljgx0zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3jES/XYQpDbduiZMrJELVhWsF4hzid4gX5Nxh1ugNUUEhSzbWwylQPGxkAn2EDaoF+eG1r+pEAsWxh0Zw689WHXwSz+hOU4lYIOOW63KuC3jV/vCgeK/rsABj5q13ZZkO+AuLzQZgUuWvjzmLceVSYm7PbJLYHwn58pF9qPLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDJ2UluZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K8uqZC029708
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XqD9lpozTVEoNik4tz86rDe0
	5zofNC5gW8zKCBwUz6I=; b=eDJ2UluZYmn48okM5vCKIkoHwvuc49tTs43Pfp1w
	hUul0WGhBHMWlK+XbjBiLBiN2SMUMZMocmM6AiRYLK6MUNUlA0dTgbozL2mJs7Vi
	EoIoi1qDTBrv7Cq1xMXMk5e0IDWFtAdsOcfMzKeaHYSGsaD8tep7XnBcrnq+rI1v
	RTYgl2fcbuxzT6DCW31A9KHSqEheETzjbUqBEfTXbnu3XLGMu0c3+XtA1SDWK7Za
	dH6ktLvfQZFXYvCQHhLFFKZMHOsaycEDqA4wwg9n4aSKzuZESuZ1ORpVtscHfRPi
	cI5LYryNh4xfmINPfTdQAqt8UZmjTZE+QFXKRkCxn/CJmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rtmn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:46:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33af599bcso603401985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753037201; x=1753642001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqD9lpozTVEoNik4tz86rDe05zofNC5gW8zKCBwUz6I=;
        b=BXC/3aDJor77Oxz/ziTkqKNh/X5ntXlH2O7b6+mKNlXhThHmT46r6Uikne1w7wlbLX
         81nUijdm6PVU1BdShgjThsVeljGveXe4IXBtJocxiprKQPTvD6a5CqCSS5BEV18SzNOZ
         /AE6Mzaj/ksirxAnbuccXt5GSQ1kcLYSOE6l0bUuDX3T/c78MfCviBegjI7AtGxzGqMQ
         K0bLTigtqsCUf4XyNN7H2P60vy4PIWZaew30oB9b7Icb8LFAy+H0/JSqkLcZHjNRGYDT
         l+qpB6BLxjPaAa+XjTMKbb1VQsY1S6Etsk8zlM4voFVo5OlP/gDTE/hndtc2SoY7o+LC
         QIwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYoXwsVgxhXHdbgZInAEU7Acy0FR0begalFP2Y5KBGMUS83uQwwjopQ6RiALh3BttGkDBU3JCGLx28PLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BKXlnEcYaM6lf3h6ApmNPNlGC0nozEn40EQ9V3NiPdin7ey8
	rKzSOcR5tuXeCmVkD+DbyYZGFW2cP8d01/BRmh371xK2zogBnmhIjnPKhEZ9JHR9SrWWJoz5mVR
	gApTLsdJVXkwRTa4hdbn/QC6/DDLy6zcxNmJJtu+pm4S+bTH3Npc/1+CP1UCQxOwethw=
X-Gm-Gg: ASbGncuWWUj2ykd/ESOkiCdHX7npevNosXxLZldI9Lj/HDYmtSQAcbwuhBHNo6YThtc
	Z5jCW5pfSq5+xbOMKoFklCeOAYfzcf8pfQDMGNSgefJ0N1qBAzbhxgu6kUwPAZMk6JLVxT6eDSN
	osXJkvpDWbHygCJYUoa7x0MvpQX/xEzycVNzTWdTLsHkso6yYwcyg7XlHvtzzxgXQIeHbAkLvp6
	4V2Wn2o1Pf7KmcJC0RY0KB09xEOusJu0D0s6wJ12a4LxMGtTj+98t1G8jc4qbmYknUfcPKEbzNq
	yuFUT/ItRJhzBHSipjffBkL3RukROi2PTDvtw8GHY27SQdVuiB7Jn3wGeRVsK/J8Kxhq8KVm/LM
	OMcJ+3one2NZ2SyMNHHxKwRUVJxxKO7SSOcygqpftUEEOpWE2uAk6
X-Received: by 2002:a05:620a:55ba:b0:7d5:f350:e533 with SMTP id af79cd13be357-7e34d9ac1a4mr1437151985a.29.1753037200480;
        Sun, 20 Jul 2025 11:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7R3w+LrCtL6Ou3WXRvuqFrSDZrluf4DC7QzbddwvwqrYR7HJsloDPSpllSxyamfEHt540MA==
X-Received: by 2002:a05:620a:55ba:b0:7d5:f350:e533 with SMTP id af79cd13be357-7e34d9ac1a4mr1437150185a.29.1753037200070;
        Sun, 20 Jul 2025 11:46:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b87asm1229044e87.11.2025.07.20.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:46:39 -0700 (PDT)
Date: Sun, 20 Jul 2025 21:46:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] drm/msm: a6xx: Fix gx_is_on check for a7x family
Message-ID: <z3ob2cbxuerf2djwm7xzmujr2xwmwq3agpxrhnyds2ciztl52h@nqqljjocqmis>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720-ifpc-support-v1-3-9347aa5bcbd6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE4MCBTYWx0ZWRfX5V0/RF+5HbBw
 JMUg7By3/DITCkO2nzoSmE8Q0sfo0MxJohGUNadns0KkKwSTX6ic7GHEDfiQwWVLY2L6B5FiiBM
 EZRlJXrMiFQygLpqO1i2p6EbOMCUWXTtATGgyszfTG6pimOefK2IAjk/g7LlTN36zong5P6NUAy
 eMRZLdgZRSPF04YuG5eXmj1H7jD16oFT8hSEM6Z68OGyqkI5G3h9R0s9mno+9Jn7FjZ8p+AUUF8
 mzqKTSRpcXIVWazXCd6ua1OVX16TX+V0tcymBeq83HMrm+MVxmE4DBGfXbyfA05bw16LfqELyVO
 SmwaLP7tIFFffVo6y3x/cZ1nqYaIyQx0KYbOcUGnKUx0k0eSSN+H0AzT4if5INt9k09CThwGuMl
 Df8vla7pLWFXVdPCYqrwr52IXZPuaAMm6rnm6tl2c13Sd1qijcRcXohdE8iu5cXHqgjU6YoY
X-Proofpoint-ORIG-GUID: Jdma9EUuMqAolQc2Rvcox83de9llClKf
X-Proofpoint-GUID: Jdma9EUuMqAolQc2Rvcox83de9llClKf
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687d3991 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=OsTS_Kn-1Yu-Ke3AYpAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=693 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200180

On Sun, Jul 20, 2025 at 05:46:04PM +0530, Akhil P Oommen wrote:
> Bitfield definition for REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS register is
> different in A7XX family. Check the correct bits to see if GX is
> collapsed on A7XX series.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Missing Fixes tag

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

-- 
With best wishes
Dmitry

