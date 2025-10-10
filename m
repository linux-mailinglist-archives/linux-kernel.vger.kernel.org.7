Return-Path: <linux-kernel+bounces-848642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF5BCE3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EA402330
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E842FE05B;
	Fri, 10 Oct 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EixBlhDP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEC2FF15D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120839; cv=none; b=o8xmElRWqUYg8pNSr4fo6QqFbpl5XjbHIAlI7V1PLQxDwGtanUdHKHTyQd9FYbePgn006nbk2KfIQX0rUE9idy2rUIWtb3CRd00V3g1C+JABsrIbTfY6YQ8rt0WPnW9HEQPJciMRYE9viiaECWWdOmL8TbsTx8eLDSKzun5BrA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120839; c=relaxed/simple;
	bh=r32NymUtrf4fMzYCtgBys+4011+Zu1yQaln2k311rMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/fU5eWI3XpoC9TUOaTL/o3B0x46WsXNONt6vMJ3S3rUdVxIe2IdLBiwI/9mLwh1EJnSlhcwe+nec3jukMijVoZac3Mb6ccc669nymvA+sUGBwBZiIgAYB+nYUBFOxFpPJLXHOAqCFZMQkMYvAub+884S0DN5CrsiR+8wuXWivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EixBlhDP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFX0h8001798
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wux/efAeHzCjaBAhhspzOVq9mish0P7Dal7te3lz2Gw=; b=EixBlhDP/KgaxFaK
	wMFeMm1eHoIcmfag8ZS2MDWMvrIqIP+jR9UrlHyAQdju5mX0uR0ri0sRtqDTdD0d
	Tir++onkLRBk9Jd0WgwH2mWpHxsXm2n1jk/ukicezla1H1rMpPT3QT5FHFCKrIXe
	REQbAaw1Crwpe0rlQrGngL1wfhf5K7TXD/zFAQXVcHiIjint0eZR5cCf/qEDFWkM
	lZWCDDoRPOQJ6mdSGKI/ZIMh9PdArZeZmcCBDb0ecBms1qufA5gCnS4fAqGDZ6ne
	cPZoXWWSdhB3Q4A68Frgia6uqrPohyc/TnRauHcHGeh7rr0k+9oMdzv2L5qEbU3G
	f+OSoA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u7bw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:26:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8747323272dso8645556d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120817; x=1760725617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wux/efAeHzCjaBAhhspzOVq9mish0P7Dal7te3lz2Gw=;
        b=B63kTw4jJKzJIvCqaAfzOivv1ptD30mqgitrEG/y+orhCPNL39Qxs2Q1Z4G+0dPdAX
         QcoVY7gSbTNYrNWI/rq9UlaB5LwVgSdN7mQov751Fhk/AB5F3VKDS+IdEk9dSWN+VSul
         syABLUV2KfqaP8UsyR19M8ky5XWBcLltjfRyVd7A/yL+ofg9KOOb1kKj2wJbS7Tn0u1B
         eam1y2ur1ntxghArhlpAoE28Wjh4dFot+ytQ5uVbrpm4rgYbLjL0J1/+0SDd898cug6H
         iZBrAy7RYYF/noJ1MS8DmO21ArKdNNxSJ1/V5fHYjx56zIKaCr7hAsEqE3f/AOQ8UwaE
         myeA==
X-Forwarded-Encrypted: i=1; AJvYcCWswD6B7j+zBWF9PicPZ1DOe7j5ESyV5v207bIhhDulFVBVidmWdVhqktGW7fp4jq2O377P28kft3gWpMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3vX0UgG9nBb06/uVvXJhCySxFVoQ0JdNhBNyP9gIpBNbFZdT
	4MB3nj7wQd+jYvCZ1dqB4CU5HSFvoZJDNeoyIrs+qhbsYdS6yH7tuK6mUA/4fro5BWW0L7ym4hV
	YmTDc2i1ptcteBopJUKYVpk9AZP/lmt+jCDw1KaZDfxyyUH2seQOKMT9KH40KTktFO4w=
X-Gm-Gg: ASbGnctUg9fsm1WNgOfIeOhmwwDDGCoaR9uSeNaVXI4yzWa3EHTYjfHaBbqrQM+POcK
	4FDQrvpZj2TP7NNqWtawKLImlptQDblV7/94a1/14bvyIz+DWyMIXHpNUpkIMC74VqpQA7y0oV2
	ud2xX5oAxpWDzbxz8JuD+Et3DuuincmHSoZTdJKSV5/J6qePssF+XK9Om0QIT9PzFY0tt7VIOI0
	KTPgh52xkgzfnpDGprkzxHZ3xLIw5Tma6OLWAA+PCxHOrDshawdqwxlH98HMJbnckG9EKiE8SXQ
	Xgodyy1AsYE9cKWGIkm88P5o1vCRLLA7BbcNhzOCsz25sj2goBwPCmVjUrcYAR+dIgurFcKSl+m
	4KzAul4wj+a/HRKswnJPYsg==
X-Received: by 2002:a05:6214:4102:b0:773:84c1:396 with SMTP id 6a1803df08f44-87b20ff9b56mr118583256d6.1.1760120816720;
        Fri, 10 Oct 2025 11:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbv3DZ79BE34Kn/wUGZkuQspPjyI7j0FCaMJKAoltlhtem37CFBxGiGcrS2O8G/hsHNEwilQ==
X-Received: by 2002:a05:6214:4102:b0:773:84c1:396 with SMTP id 6a1803df08f44-87b20ff9b56mr118582886d6.1.1760120816054;
        Fri, 10 Oct 2025 11:26:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235dccfsm2882274a12.9.2025.10.10.11.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:26:54 -0700 (PDT)
Message-ID: <3e098e06-0ee6-477b-8a52-7370ed37b36e@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:26:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] drm/msm: Workaround IFPC counters bug
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251010-ifpc_counters_fix-v1-1-9187962b7d20@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-ifpc_counters_fix-v1-1-9187962b7d20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e94ff1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=3vACEWP1_XwkJBBmlSAA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: zvhexk7Uy56_HJDi_rlGPazc_vLJ4YDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/a4o/gPLtegk
 eFOHboYMfVM//X/VYJqZaKX6yvHLg2LSajwarNzIfakBH6O5pvZjWE6rjymvedpjJa0LoJMRHoC
 /xxdmUSVgj3k6CpMnXzMRS2Rc6XTfvvI1zvvB2VNMsH4etk+wzc7h8pt5l725ygdSxJrQ+nwVVj
 dtdZ/vHWifw64sE6cbJMaWrdAo6s0AqX0jfHnyqNXBEg+T2QjeX0AmNEUKHZfod59UcsoSd7qtU
 zoPQ/Dv8g02gUcaE5cnFaP+MOTnzIqecDfy+h5VDgxjW1pAcl0dWt/2MYMoqLSIcqFbKT6sSrC9
 FIRnMuOHk4UIGXIyjN6hF8vstRvHSv1yS2Zfo3d6VbUUyoIMf/lvaYpPlQA6wWbPGKOW/Ngp3GK
 qRDhcRyWYs7atXGf2goevTqBq24WLw==
X-Proofpoint-ORIG-GUID: zvhexk7Uy56_HJDi_rlGPazc_vLJ4YDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/10/25 7:49 PM, Anna Maniscalco wrote:
> When keepalive vote is set to false IFPC will be re-enabled even if the
> perfcounter oob vote is set.
> 
> Workaround this by not setting keepalive vote when sysprof is active.
> 
> ---
> I have little confidence that this is the proper solution hence why
> this is an RFC.
> 
> Hopefully something better can be found.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> index afc5f4aa3b17334027f3c20072cc3f059a9733b7..975b91e2c439f659b7f716cff87f73d389641d91 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -191,7 +191,8 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
>  
>  	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
>  
> -	a6xx_preempt_keepalive_vote(gpu, false);
> +	if (refcount_read(&a6xx_gpu->base.base.sysprof_active) <= 0)

This returns an unsigned type, so you can just do:

if (!refcount_read(..))

Konrad

> +		a6xx_preempt_keepalive_vote(gpu, false);
>  
>  	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
>  
> 
> ---
> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
> change-id: 20251010-ifpc_counters_fix-8bd4470e6351
> 
> Best regards,

