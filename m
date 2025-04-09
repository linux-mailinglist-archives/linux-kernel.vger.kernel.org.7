Return-Path: <linux-kernel+bounces-596372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144D7A82AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F57A6296
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB015263F4E;
	Wed,  9 Apr 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ObUY/g/I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F04267721
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213225; cv=none; b=XdxNyRhtLgG+1Mlka50uHNzR1DODv7hHZAQtwietQKd6t9U0YydQH5ADsYhXDStleOFN7+3vboD/9Co99rDbaUpvmVBFeP/Um/wqtkrsUVIYZS1d956f7s7jUp8W+Aq+qUj0xCmcGFPe/MFJqAdg87iBhm3ywAnhfSvVZc7EEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213225; c=relaxed/simple;
	bh=sr5q1zh9NSGY7PcWnFatTToY1SiCtDSZEZ2M8GV9h0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4dwqlLR4Yb8Y1wqDPpbipcILIPShvTMFgbneXLU1uRP79/vIYod+n1gi2qkDnUsXwsP7iBNMH0tLIiL3Kp+EB+NlG6zBVNAxa3GJ8S+nsgzpwBauRB8FNrr0cuEiVxNte14SQQ/4ioEHZk93jmCJXzLx6S1Jjp9LlG9IXgCr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ObUY/g/I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398Alou027501
	for <linux-kernel@vger.kernel.org>; Wed, 9 Apr 2025 15:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9BPk28PAc9fisqkhvrEcPgWYuoMztzSJu7m7KRysU8=; b=ObUY/g/IZ0oO6wDD
	z6B3BmhNGOD2unIq3FYwV22xMwQXQmQgA7dbEF3FgKdNBj77UpJ7/LF3IYR+lVxD
	uDxkDFLyUrSvm0ON0ukXup0Sxv606DVfH8SaZOPa7wVRFFBsvrrTcyL3scT1mXLg
	qkZfYYHZkrSQQeCexNGm/Jfq2eC1CZjJmwmTcwFdQvT9bGwUQ/4R/SfKK6I9Qyjm
	QEtTImpBUop7Grl/3EH9lL0irgqgKcfLbgkmXIYKjV8bIUdpuRClO78Mgc2encsm
	Mk4z4hSgvgF9QHUR18j6xJ1NT7jF8IlJTMI8nrGU+MPm20mS5oGzZKvGR1QyYTjv
	dT53Qw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrkygg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 15:40:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ece59c3108so15096106d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Apr 2025 08:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213222; x=1744818022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9BPk28PAc9fisqkhvrEcPgWYuoMztzSJu7m7KRysU8=;
        b=CWHxtaOZFK/oAIOpaM47U7rw75LPg1+dpcFLEVAS3oWq/42lHG7V260jfLWmw1EDAq
         z2eJJzqyQyuz+lXO9/e5Lz1Gfvmn8c4Wiv1qmD+RqAYCHMXkEGXYpkNihRR6WmZobQE3
         aqMYfCDaLyDoQWpSEEjQHW+fiu3W+PYQa7vpLin6f6h2VMmbkYyYRZQro95hmYTzb3Z6
         bYP2m3J3rDxnWYLfTbfP490tj0aVyYpiEaVma3AMy7UdlxFZcFWr2Pvnm8yKPfLZhu0q
         h0LwRKSxuJVIhm2pX/6gAKvfphHEDptCZMt7hoFX/XjEo1poO+MotGG4Wgy9O+TrSAIT
         RA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXABOcTyzpqnTU9X3otzaL6mpS1OnP8lWPiCGajkKh540dQJA7Om6ttz+VeWMOddkWcV3TaHsNZt0JfWs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30/ORejIQxuM3IsSGDrTDREfUToQIGMdL5ih4VEqXVt93jgts
	qBbsngEXdSUxAK+WSEtE7ihTagyRHbN3Wu14e+xgxrgn75QLF4OBIMIlQ4XKHTtcKdidlQK2frO
	9pbHK7mVw/VFuOcyeR8x8BSNnlHX6B4SIVrZ4Im70Ep5lmHFGjvT+LOE9YslVqmk=
X-Gm-Gg: ASbGncv0guRqtMJUweaGnOz8hX+DdxE/I7qPRV0Im1V1Ci7cXUPJirWO2Q+UVeHgqeV
	KzJn7ww7CqhbHLqpVP5OlG8O+eEKzhJf6tSu5G+4n2cN7wBcKyOX0TOtKo6DmuWe4AQ1/VdpfuK
	Z0CFo1QvQqvBSWc5FDrlF9y+d8NFfk3lUnTyoUbtIhlaEayLXPlSll6XFfV7IQxcD/5aohzKeti
	q4dtWJHxuJ0Wg9iej5Wu7kODm4TWi3gClYd9YezvV5SBgkaWsNRSo4PqgflDXANAQ3Tb1fFFzlj
	ORwDTp9ovQ9EOImVy/2f+qaF582lUFFYhT0YEa2dj7D9HkuaZyosY7gWoeXotiBuaA==
X-Received: by 2002:a05:620a:2845:b0:7c0:9ac5:7f96 with SMTP id af79cd13be357-7c79cb32476mr192357585a.0.1744213221729;
        Wed, 09 Apr 2025 08:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0y2JAYIsBZUZsxYlHzS9wyRxq0XZG+P+f9vATezBrv2Np+gMPt+9chspODJu7JrDLBQu+kA==
X-Received: by 2002:a05:620a:2845:b0:7c0:9ac5:7f96 with SMTP id af79cd13be357-7c79cb32476mr192355385a.0.1744213221343;
        Wed, 09 Apr 2025 08:40:21 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbd34dbcsm922827a12.66.2025.04.09.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:40:20 -0700 (PDT)
Message-ID: <9a12e042-487b-4937-a583-709f0c37ab12@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 17:40:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/msm/a6xx: Get HBB dynamically, if available
To: Connor Abbott <cwabbott0@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <20250409-topic-smem_dramc-v1-3-94d505cd5593@oss.qualcomm.com>
 <CACu1E7GMf0Mx2ZX_t76h+b1CPin49LGix7c5uvoWaJZC3dKyOw@mail.gmail.com>
 <c2dac38b-bbe5-4cd1-9d33-b4bba629d54b@oss.qualcomm.com>
 <CACu1E7F71M0Z5KUdArRYbLEMXoS3jQEtp=0-4LEYFRysOsYZfA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACu1E7F71M0Z5KUdArRYbLEMXoS3jQEtp=0-4LEYFRysOsYZfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c5KT6jbE4Al61YKIGlEvb0RX7wWjewqd
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f694e6 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RexmrgqQAhuxw17nEtEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: c5KT6jbE4Al61YKIGlEvb0RX7wWjewqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090099

On 4/9/25 5:30 PM, Connor Abbott wrote:
> On Wed, Apr 9, 2025 at 11:22 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/9/25 5:12 PM, Connor Abbott wrote:
>>> On Wed, Apr 9, 2025 at 10:48 AM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>>>
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The Highest Bank address Bit value can change based on memory type used.
>>>>
>>>> Attempt to retrieve it dynamically, and fall back to a reasonable
>>>> default (the one used prior to this change) on error.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 22 ++++++++++++++++------
>>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> index 06465bc2d0b4b128cddfcfcaf1fe4252632b6777..0cc397378c99db35315209d0265ad9223e8b55c7 100644
>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>> @@ -13,6 +13,7 @@
>>>>  #include <linux/firmware/qcom/qcom_scm.h>
>>>>  #include <linux/pm_domain.h>
>>>>  #include <linux/soc/qcom/llcc-qcom.h>
>>>> +#include <linux/soc/qcom/smem.h>
>>>>
>>>>  #define GPU_PAS_ID 13
>>>>
>>>> @@ -669,17 +670,22 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
>>>>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>>>>  {
>>>>         struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>>> +       u32 hbb = qcom_smem_dram_get_hbb();
>>>> +       u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;
>>>> +       u32 level2_swizzling_dis = !(adreno_gpu->ubwc_config.ubwc_swizzle & 2);
>>>> +       u32 hbb_hi, hbb_lo;
>>>> +
>>>>         /*
>>>>          * We subtract 13 from the highest bank bit (13 is the minimum value
>>>>          * allowed by hw) and write the lowest two bits of the remaining value
>>>>          * as hbb_lo and the one above it as hbb_hi to the hardware.
>>>>          */
>>>> -       BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
>>>> -       u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
>>>> -       u32 hbb_hi = hbb >> 2;
>>>> -       u32 hbb_lo = hbb & 3;
>>>> -       u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;
>>>> -       u32 level2_swizzling_dis = !(adreno_gpu->ubwc_config.ubwc_swizzle & 2);
>>>> +       if (hbb < 0)
>>>> +               hbb = adreno_gpu->ubwc_config.highest_bank_bit;
>>>
>>> No. The value we expose to userspace must match what we program.
>>> You'll break VK_EXT_host_image_copy otherwise.
>>
>> I didn't know that was exposed to userspace.
>>
>> The value must be altered either way - ultimately, the hardware must
>> receive the correct information. ubwc_config doesn't seem to be const,
>> so I can edit it there if you like it better.
>>
>> Konrad
> 
> Yes, you should be calling qcom_smem_dram_get_hbb() in
> a6xx_calc_ubwc_config(). You can already see there's a TODO there to
> plug it in.

Does this look good instead?

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0cc397378c99..ae8dbc250e6a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -588,6 +588,8 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 
 static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 {
+       u8 hbb;
+
        gpu->ubwc_config.rgb565_predicator = 0;
        gpu->ubwc_config.uavflagprd_inv = 0;
        gpu->ubwc_config.min_acc_len = 0;
@@ -636,7 +638,6 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
            adreno_is_a690(gpu) ||
            adreno_is_a730(gpu) ||
            adreno_is_a740_family(gpu)) {
-               /* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
                gpu->ubwc_config.highest_bank_bit = 16;
                gpu->ubwc_config.amsbc = 1;
                gpu->ubwc_config.rgb565_predicator = 1;
@@ -665,6 +666,13 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
                gpu->ubwc_config.highest_bank_bit = 14;
                gpu->ubwc_config.min_acc_len = 1;
        }
+
+       /* Attempt to retrieve HBB data from SMEM, keep the above defaults in case of error */
+       hbb = qcom_smem_dram_get_hbb();
+       if (hbb < 0)
+               return;
+
+       gpu->ubwc_config.highest_bank_bit = hbb;
 }
 
 static void a6xx_set_ubwc_config(struct msm_gpu *gpu)


Konrad

