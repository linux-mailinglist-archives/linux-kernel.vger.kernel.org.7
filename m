Return-Path: <linux-kernel+bounces-760894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD0B1F1AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1786F1AA86E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9462405E5;
	Sat,  9 Aug 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdaISzC6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E875238C3F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699911; cv=none; b=jdUojSEk9lqSJ2dsQVsT+M7l+DG3GPBjbShWDPPPV6BilX5wN9bd+BihkNu3/zlhyxzMbXOWByhNgf8sl4r/BVcegGzo1lGwVwuSyDAhLUI5Cf0ePM37NVVg7biJCxLmOXA/0ORWurJEHk/0x0dfzUQZ59V8IbUl6zPtaj/4Vo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699911; c=relaxed/simple;
	bh=926dX9L2/JJUd/PVWhA4Ycu4EcbB+uexFLF9GYcID/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr5GXumvtWsN/fTtWZTL8mR4yG7o0T1t+Z3+O2BsJSUpJC/sPYaztBANCFQlQoz3K0i6ddpXsXhB8YRzQIg1nPCHJdPnWn3hNVdSdyDpkai3BNYPSnBDRj+MKD6FWsf337HxcgFn1qrJl7pjAh2baVxyXD79gpjafbziqE5pPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LdaISzC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FARJ4003513
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PTg6UPUR4TJzotk+aFNe0dYyDOUiRVQtN/7jSRoavTs=; b=LdaISzC6Mk0H1f3L
	7wMT0DTVRifFjawkSDKdtlKTtj9B5XZw3HSXv3Qh036YEhFB9Gk6oRvW9wDquURO
	opBBDh8NxQOpZinl0H7xKsxepoD8guczKynrt0ZcqcOdWLA0bz1qlru7VV5X4ggR
	XAAdsAW/428KfD22FTODzhwf4ugbT3kl2aXmzPaoKkBFCfVQRpabZcB/NyZqCdog
	6GuYU7Ia+UgQ06g2Kre+QDz7pB3BsiVxTDYg/N63eBkpU8f5ncGBoJwLBjEUfBu1
	GgaA34FlsmBS43Y2UVpaZDHBxwLrTB2VFFvMlYUFAiGTrVqIvEuJyNs9NY6uxzvg
	XYQYBg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw03p5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:38:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af117ffc70so67143441cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699908; x=1755304708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTg6UPUR4TJzotk+aFNe0dYyDOUiRVQtN/7jSRoavTs=;
        b=S3O5Ou+/7l1ecQktS/JIejHkFyv7frfsHPxZLxTlxLmBETFreYRvag2247WyNdmr1l
         AXL+EgkJwv9WeRvQeL0M9bwoTFLN5ya7LfX7XhWEhBiN9bZCrbz832kbumKZ2gXaE+/r
         hl9mIzMpqZzyKtRj1B2cY3Q8e8sWfBDOkUTI3Z8jrshEC3jSXPzneQJLBx1oyvqSHtSe
         alk9MgHYlQNmetyy05PnEu53h3dpzqEk4ZCDUWPM1OZM+cpJlIfyVo4nqzWtOu1tPOuz
         UAU0Zup2z7smHiBLYnQbMHlIJ7Uk0Nq55DFKo5H+pSlzPnaxr7SP8LiLINETCO2xte/i
         2g6A==
X-Forwarded-Encrypted: i=1; AJvYcCX+TzVSuPB3tCWUWBmQsaeu5Lkn5Ff08+CS5K/9bMYbXG64PJBJ1rMXG13eY8yBdrfATw4DT0kHYwhOskg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VYGkB96/0pgbrZjhimmFZE5UQb0BtXBTJcL02xP3cNkf5DE7
	s8yalkWlbXjYHJDa0r4+b6lLJYhwlONTaL8eL4zQgyzqSM9Hx20NRDsfjlfnqSRBuRmbZH572/O
	++Ra/Gommgk+Ac3SZrWfq2MSqmZ3dGJpJFnKHTg5Le0gnfSIVNpkGKrMawcFPnvfV+is=
X-Gm-Gg: ASbGncsfFy27uusCOOUyItxH/S+/HqIYqB3EzuClkCMG5178l8qlJv2cVk/vz9WTAvs
	q253EFGUHdbHn7ejWM9KKSdpUyDQStBQE671odDOJ8YciRVoUTqbjXjzRsyQg/m0uOEMg6tbV+j
	ZNq/CUeK9Yof1S6JtKZ0zgoopFNew/UAJHkxwa1HR1JDtIKKhYIKdcWld4XbtXL5V1MgZ8iHQil
	W7vaEo0503qiXg0sifdwxYBiOD94CzQAXUaB4gRts2XbDb1DwDo3Xks3j4NUBxflPGSNQXW7XHS
	iY6tkbql3oj6Uo3l2SzxUmuT8HfV9307HVs85rp0bNoi0XxXh8A9ApJ23CyZ6oReGyCsve3ME5V
	kDyWH/1o+TpSYZMtd5Mm4NmZxjI7rKS/dD51ohIGVaOU=
X-Received: by 2002:a05:622a:4088:b0:4b0:8e0a:f095 with SMTP id d75a77b69052e-4b0aed6b5a1mr75846341cf.26.1754699907725;
        Fri, 08 Aug 2025 17:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt0Zzzi3J4BDnMVp/K7JP6Y2aCQjHuVGq6KrsN8qluameirnzlp9r1HdWb2M0KJC5/NMX4mA==
X-Received: by 2002:a05:622a:4088:b0:4b0:8e0a:f095 with SMTP id d75a77b69052e-4b0aed6b5a1mr75845831cf.26.1754699907027;
        Fri, 08 Aug 2025 17:38:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc9af8413sm13671e87.28.2025.08.08.17.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 17:38:24 -0700 (PDT)
Message-ID: <200ee7f2-ac66-4619-9401-220dc578f8d4@oss.qualcomm.com>
Date: Sat, 9 Aug 2025 03:38:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] drm/msm/dp: fix HPD state status bit shift value
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
 <20250808-hpd-refactor-v2-1-7f4e1e741aa3@oss.qualcomm.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-1-7f4e1e741aa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 57NWfoa9GAPyt_aQkZN2jrdWPwERwEZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX3mE5BkRojlXG
 rez6DR2IWOvf9a1q6IWjR/ofeK7jK2PMmfcQ2iqDskK2D6GFWtqFywcDeKPkihSK6BYXejAZtc9
 dS+xOqWba/qMnUbHQ+3DhpDRUrkRhYqtwpC93qJEoa9xTICVPvu59Qv8L19E5qp2N1acYw+M86Y
 +F+IXhjmAxo9mJufvS8LeSqPHthFtrlPhYmteoLI1RZBvfZxgOi7NDiEKFUoVjBc8uN8jSBd2Bu
 DDCwIyycxBrvR4Tzmg/zbgd5lZBFXx3WcXrkqW2Kpay0akh1hBWxKz/LvYNnB+f7OSW8SQw1p/o
 fGttZA4uz5LBcYcXFvU/2TXsO27u15dMLCIZBdTVFGRkBrAVIrLwPlY/PZI6BOL+DWstFefAKrH
 +yqOezdW
X-Proofpoint-ORIG-GUID: 57NWfoa9GAPyt_aQkZN2jrdWPwERwEZ5
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=68969884 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tINfiVESruKu4bDgj1EA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 09/08/2025 03:35, Jessica Zhang wrote:
> The HPD state status is the last 3 bits, not 4 bits of the
> HPD_INT_STATUS register.

Then the mask is incorrect too. Also, I'd suggest using 'most 
significant' instead of 'last'. The latter one might be confusing.

> 
> Fix the bit shift macro so that the correct bits are returned in
> msm_dp_aux_is_link_connected().
> 
> Fixes: 19e52bcb27c2 ("drm/msm/dp: return correct connection status after suspend")
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_reg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 7c44d4e2cf13..b851efc132ea 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -69,7 +69,7 @@
>   #define DP_DP_HPD_REPLUG_INT_ACK		(0x00000004)
>   #define DP_DP_HPD_UNPLUG_INT_ACK		(0x00000008)
>   #define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x0000000F)
> -#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1C)
> +#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1D)
>   
>   #define REG_DP_DP_HPD_INT_MASK			(0x0000000C)
>   #define DP_DP_HPD_PLUG_INT_MASK			(0x00000001)
> 


-- 
With best wishes
Dmitry

