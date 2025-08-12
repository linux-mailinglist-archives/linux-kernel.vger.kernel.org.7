Return-Path: <linux-kernel+bounces-764080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9DAB21DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB063A6A31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28642882D3;
	Tue, 12 Aug 2025 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hs0Z0FEh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD626C3B7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978229; cv=none; b=oBp5Lo9v4iKjEF2U9qkHyemFfUAAFa/E7Mnlwmj6P0Nek1ixDnwNnGU1Ia0dgDw+x4IGrl8DMY5KpKVJgKCBhsCbr3tAs67S+BepkYWAGLxGIm+l2WNMDg1RP1TX91v6eoAV+maFOKDg8ogKuNz7J47igCUqx/Yh86cgrQIWFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978229; c=relaxed/simple;
	bh=tJOG9UGC1KS2vzDhLT4V/tFSo5qJ8SWB999TC4doV2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaKuyvbxrnCaDdeeA37fivVfzn4MvcUBwGUrs50iKUa9Ps1PHTEuOLELhnxXkwcChcdR04DYQQaJd6s5G93hN0XXTw1duFruxMKHP5OZZ6Rsd1FDmxF9i5eJp3AcNGePoGR5wfAYxjn5mbFhPdJyqlJgyqWxTzSSXO+TrGlEc0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hs0Z0FEh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C51fCL019036
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vEv5nCd5JEtL1flZjqEInCbJgZ550nvvo3TiB8HuuSY=; b=hs0Z0FEhvaOvvfTg
	NV0kSogdHRCrLxvFuNZaJ5QeOl/HDsOE4tFeC5N4lZI6AIQzHS4ISDd69sjoDuCH
	YqVJ5XD8A02rTJU0bFGdeH3o54BLSTUjbFHYsIrO9AvvnNFbFjtQv084D1VPWSHW
	NYg6ef+Hz1m1ZzTz5pHupxfRcAoGAaPKVtsnE8jasguIUEw0XyJYhlquiYEguz+F
	XgOw8Eeyq/cc90pQewknEB8HOiMzEEH0JdCHaornil0Ngm9x01gW/N06mgErmc0f
	vwFGrBgedkVIo9IwvDMPy2iCuy0QsXVTTqts+mrvLp6uPwi3AUsS4PcaS4kfQ8+w
	Z7RNiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduxygw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:57:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-242ffe6d0afso3536565ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978225; x=1755583025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEv5nCd5JEtL1flZjqEInCbJgZ550nvvo3TiB8HuuSY=;
        b=B/pOFHRbliYL/eFg9U1NmQZgxGAp8E6E6/lTprwn2yHWLIlO07aFbFowRC2/WKeGwo
         O7mQ7vjzT5Z5hbYy4haNIsPQpaiQFhx9btaA7/cI5TKY5lSNXbD3CkBXEIvtTcqY5ihh
         0BigkxLkIi46hPY81tlwEuX4wN/LMhB2hnXzgZOhVh712TJWGZJhjjdaD27rSIrT87dM
         l8jzsE2S1sYZMcAd6FzYrrYZuSjAUYiOn4uRtCKVEjC2MC5DVbtj1hV4QeYzsRfQsl+i
         Ugl4izIY8xkVm9/FI0yeRHSlDFXIDcAI0awIo0H78FePCtA/tGCGqWjFQoBLExdt6SYQ
         FlTw==
X-Forwarded-Encrypted: i=1; AJvYcCU3tuf+N2dLMgPph2hDJ2ZoQmebQNvTpznnxzjhKZK+TO3Intc7tsXfO51G/sGFfENwWctlqzgdGfmnLkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxey9OKxGJciwN2HKKZr4QELCUhT1i6qOtTHy7Gf/8rZNhNtzZG
	2nI1vaPmeuQ+BEoqwYiuqD6k0Q/FAOv7wDJNemEBJLyb89tmdHrBMZ4+3cwG6kbLp4PB26gdFgm
	+NOZrh5SY/oyKfdfER/YZeVjq17ivHHsPRvZmbhnvEV1NUdH5GtFE141N8bsvMM8dTM0=
X-Gm-Gg: ASbGnctjn3xp4GagumbmiMg4aLSUJwYkaU7X4wkiPHAxq9AfqAqmm5wzEHDxfze29kF
	cVn54dOL5SyfAMN/g7877/ZU4tVytCYuoR6kNgF9FWWKpcuWQyir5zZoDjuMPMb0BkiuIg2FLrZ
	2dcwFEeZmC0YcHHIChRIqR7De7qumynimPsqwAAEjO7UCwWGjjCdi3VDgoEkD8ZjJ21viRd0gYf
	DVBrVnsbTkS8Rew5F2gEoDiHTpZIsHoDimjCC3ThP7ZzQMjPmWIG/+kyJA9S7+e44K5ixSVz6q8
	CG9/G3r/Oi1/Lv2kdPj0vx9ycoyaFXufqiW9FckFslTQ0ptEtRX7W1L2i4zrbJBGzUHzPF4=
X-Received: by 2002:a17:902:e545:b0:240:7fcf:ced7 with SMTP id d9443c01a7336-242c20596c4mr261796365ad.21.1754978225067;
        Mon, 11 Aug 2025 22:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFERojaneRpqNViWbpvGH1a8gBIpXR0UabwcFfFfj0BA9yVPsYry01nCaz8ljkh4PoEkyna6A==
X-Received: by 2002:a17:902:e545:b0:240:7fcf:ced7 with SMTP id d9443c01a7336-242c20596c4mr261796045ad.21.1754978224580;
        Mon, 11 Aug 2025 22:57:04 -0700 (PDT)
Received: from [10.206.107.125] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm207795295ad.54.2025.08.11.22.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:57:04 -0700 (PDT)
Message-ID: <78b335f9-7f6d-415b-bf56-5e9dc2c38f3d@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:26:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] misc: fastrpc: Remove kernel-side domain checks
 from capability ioctl
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-4-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20250716132836.1008119-4-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689ad7b2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_YpjYfwp_6jjpJQCciMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uMhoiYzNeVufynS_xuw7lzS6-o0isNG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX8c1DMuoqdSae
 x2ziOBG7iqs6tfDHHmSvFdAZHJAevmRcHBrlX8b7KK/gkigfCLgJihXpf58ROeO4rvlHH57kajj
 PszmQf456vBc/B/jMZCoOJPU8fnpyEsIP8yU/H+qZk0HVNnjgxYuVx0n5YWvRneHKLfRndEjn9o
 qPOGVZTpXvuVc7Lrt49t79qCPBg+wbyTYciJqxOSvYSg8bBch/ee80j482cpAOYI9v2XPfYt2cD
 4rc2TXvzU2VJI5ZmhWe1RCNaEF+rdHM9xcc++tVeS0dSxdY+0SwGgQtDsDZAeX5Qu5ltr4sV5JS
 ryWYbNYLicRThYFcKjfTeGgOM0L67WEwJ4iRz6GW3Q+GbP8rkS9nZthQZrAJ7XsSqpfotK5ffe0
 Har6m5Qp
X-Proofpoint-GUID: uMhoiYzNeVufynS_xuw7lzS6-o0isNG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025



On 7/16/2025 6:58 PM, Ling Xu wrote:
> Domain ID in the uAPI is misleading. Remove checks and log messages
> related to 'domain' field in capability structure. Update UAPI to
> mark the field as unused.
>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c      | 14 +-------------
>  include/uapi/misc/fastrpc.h |  2 +-
>  2 files changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 378923594f02..495ac47e7f90 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1723,7 +1723,6 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  	uint32_t attribute_id = cap->attribute_id;
>  	uint32_t *dsp_attributes;
>  	unsigned long flags;
> -	uint32_t domain = cap->domain;
>  	int err;
>  
>  	spin_lock_irqsave(&cctx->lock, flags);
> @@ -1741,7 +1740,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
>  	if (err == DSP_UNSUPPORTED_API) {
>  		dev_info(&cctx->rpdev->dev,
> -			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
> +			 "Warning: DSP capabilities not supported\n");
>  		kfree(dsp_attributes);
>  		return -EOPNOTSUPP;
>  	} else if (err) {
> @@ -1769,17 +1768,6 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>  		return  -EFAULT;
>  
>  	cap.capability = 0;
> -	if (cap.domain >= FASTRPC_DEV_MAX) {
> -		dev_err(&fl->cctx->rpdev->dev, "Error: Invalid domain id:%d, err:%d\n",
> -			cap.domain, err);
> -		return -ECHRNG;
> -	}
> -
> -	/* Fastrpc Capablities does not support modem domain */
> -	if (cap.domain == MDSP_DOMAIN_ID) {
> -		dev_err(&fl->cctx->rpdev->dev, "Error: modem not supported %d\n", err);
> -		return -ECHRNG;
> -	}
>  
>  	if (cap.attribute_id >= FASTRPC_MAX_DSP_ATTRIBUTES) {
>  		dev_err(&fl->cctx->rpdev->dev, "Error: invalid attribute: %d, err: %d\n",
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index f33d914d8f46..c6e2925f47e6 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -134,7 +134,7 @@ struct fastrpc_mem_unmap {
>  };
>  
>  struct fastrpc_ioctl_capability {
> -	__u32 domain;
> +	__u32 unused; /* deprecated, ignored by the kernel */
>  	__u32 attribute_id;
>  	__u32 capability;   /* dsp capability */
>  	__u32 reserved[4];

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>



