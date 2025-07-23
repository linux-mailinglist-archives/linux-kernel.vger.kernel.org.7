Return-Path: <linux-kernel+bounces-742313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFAB0EFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C181458396F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A7428C864;
	Wed, 23 Jul 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdeZnmv5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA42749E9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266468; cv=none; b=WEjIOw8lGcsEFQE5p9uDPcPjdF4KtGRLgtpSnnm17BYrjwQmsaKbEcaDfPncu8Vc5nBmMPk0/V+6UMK0ndc15Ejlxin2g8H2i1UeTNV7Mh2a7+VweKiPuPjoOwbR3rwfCnb1jXuLEnZoQSDtMi1T+hdWgiREd0W45FnzZ/xd9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266468; c=relaxed/simple;
	bh=92/HpnvzHRv6YdBFuz4zwvFu/3h/vM8wbCKiLV0rCxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2DaP2I+DLlP6dSZFYe6rnDV6BWj/aPF8sS4hPx22jnXQg6ZndHJ7VpEBV0jG3hI87B0E4fYTL63INSRgdssSwULs8SwdivW0SEVcm04FGp9OqGpi2KuF9ioXqLLqArTuOdO/I4dP1+a32VxX45RL0LDFWjfbCGfyNps9HLJuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdeZnmv5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9MCHu011400
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ADPEX257lqLR7aZspkqZLx5E5CPI+QZpWMnfs3fbuRI=; b=JdeZnmv59F6s3ybT
	mj/FzWcRtRL7AR38Xeel4YhTE3aoxfIBO6yRr1VYw+jXs1Wetl0N/h/2xqSRMx5l
	xUDssShPLP8Waqh7FtemfFjAzkM7JbswAqU3YX+/EsXJDOaeqw9Mp2FVPxp5f+1Y
	FWIQkJhI5FoIkhu/dGGAwDKiX4+z2jRrf/Omt9tXVYX48zzZufwZfJdWqNIoA0EX
	aimVtxzmKM0qixrZcxLzbY2MmRylj58rj2kqzBV2POpuQ5nC/ObOImkKiF0qDt2T
	JNm/Zw7dvxZ4dSi5o9bmXO0C4PrqHTusGZY0bFZSBMyAyddofVkW9l4N+9rTnZOY
	/WNkQw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3httmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:27:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fd5e07066eso19752036d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266450; x=1753871250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADPEX257lqLR7aZspkqZLx5E5CPI+QZpWMnfs3fbuRI=;
        b=CkSYS7Bg56a4sLQprTRv5EkFWn0PDNDDhurs8Tx09rkqVrn99uajLvMKHOGQJam/mX
         UcHHb8aISf8EVoCAYbGZDNz38Rl+iKzKECT57s/cuM6Z+GUUh1CMxG5qAqC6g8HCQLoD
         Nf4s/0Q1/sa2+nzjWZVXCK9Ve3D2ijtSB36piJj1j2vumerIBz14KHEzRwJC0LJMao1X
         rj92HjrkEbjYtXLSO+T9IWBraxKkAGAp05p/nylmTn9MAxaCPaGcDSVesTXEypt/eRXn
         h6taBfzsxEdIby1CVbDc7yarz3maZBFMh6D9U5uyFeKJtEvlHcD3gv9xrwgWwTkVUvQO
         OvmA==
X-Forwarded-Encrypted: i=1; AJvYcCWQevOBKVACUc5VhVSrA9ZPvA2LQUhj56KJ0F9gkytFaheJex1SKHs+kRGWrj9SK7dDc3Is2CwZTdhb16Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39d1dFtBWFfMb1X+kQ01ieQfpA6M3JBuEi3oJNVIFOE/3Q1aK
	qpB8eDyz8/3NOWnX4IyZ0vsYBLIWjCXXWsedvP8TJ8lnITvldsrHO1RPD+cqE2BNeH91Fn4LNiU
	BBYK9Mg3aZf7n6F4UXDhmX2z0Bx9jqS1nAmBestGVJOg2Tyw8ditQC4IAusKJanLF2sA=
X-Gm-Gg: ASbGncsuMEsyNtPtpP7JDKUym4cjKZ4EBm4WMe2mnEvNj9VpWdGX/wQudMdfuGqOyU8
	LklP7tRwwkqebtOPPUxk1r5r1VVRZhHjxB6alZ0g1/Po0HeyC+bt8+WSYvBFY6FK7WFXFVEDVe5
	KhSWJg4ScQ8OvlIGyHjA/v89frq4xs7WiKOd1eb8TvflliFdQTk44GFUum+R/zvqiJBVJ7fa1rq
	/C3VbSRAgP4P2xBEB7p/ejm6w/PcZPN+RW9euk+NJW/qOsnfuMo+sJK97dWB5hBpmdOLf7sxV87
	hvPzIlU2Tt2hVhYYJSg6p+e8/+1FUywEIOJMlEM2Kl1x+JedYZ7vqVE1BHu5jIa6t66S/PXz6CZ
	dgPnEZR7ZkF+ofolmpw==
X-Received: by 2002:a05:620a:9157:b0:7e3:31c2:2808 with SMTP id af79cd13be357-7e62a1635c2mr84741385a.5.1753266449898;
        Wed, 23 Jul 2025 03:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlbBqrpR3KQ18lK2XKRLKljilp74CSPk27LxST7ZbUN/lfUZkp9SSjf53wAC8c/dVC+rHKMw==
X-Received: by 2002:a05:620a:9157:b0:7e3:31c2:2808 with SMTP id af79cd13be357-7e62a1635c2mr84739285a.5.1753266449263;
        Wed, 23 Jul 2025 03:27:29 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907759bsm8191624a12.54.2025.07.23.03.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:27:28 -0700 (PDT)
Message-ID: <5471754b-5dec-4107-96d6-a6075328d824@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] drm/msm: Add support for IFPC
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-11-9347aa5bcbd6@oss.qualcomm.com>
 <k653qq6a4xkvwadeum5kbr7cheje773vobehpzq33ec44vyxjj@vi3ekv4jwext>
 <6472bc1a-9546-4cb1-85b9-d826f76ba9f4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6472bc1a-9546-4cb1-85b9-d826f76ba9f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880b921 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=JXpgR7ONGPNzM5tbrfUA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OCBTYWx0ZWRfX43W/8yWPP4J/
 z2g1ufMYCpTgiJpDeapwe6GbQymsvgpbS+3aFhOKnOZIftlJtuJJtFLML1px8Z3ToiKAMVDVU1M
 1ObXlJXeg+r4NX/VZb9iJZsVjZFt7dHdnHJVtI6S95wk7toVSxpPYBs0XL+qpRllcrwivblHWJP
 w3v5lDaoyFc9jFMfY54KngWpb1sSa8eHyj3LA/t6INDQ6j1Qc0jJ3pcbIeUlyBwYrCto4YQjqOn
 aJR8zWMpepFgIHOmI9yIPfeg5Ec+FN2vGau0htG2BwZVek5uIVE64P69PMcISRnmKoHAvOxnY18
 I2y+SUxMtJzsSp19gBWqTKXWwgJCvQXLOhmUoCBzF3Zi0OCEXiYp3le5GywOSDcw3sSOzu15b79
 3URKQpFTYpE9zhd5k4Sw0qosV2o/M3zh3oiWfp+aRRKbSnJmHblS85aNXH7MODMixJzrCyIO
X-Proofpoint-GUID: ka4H3rlbpXqJDuP5iWZtn1o22cF95YgZ
X-Proofpoint-ORIG-GUID: ka4H3rlbpXqJDuP5iWZtn1o22cF95YgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230088

On 7/22/25 11:27 PM, Akhil P Oommen wrote:
> On 7/22/2025 7:19 PM, Dmitry Baryshkov wrote:
>> On Sun, Jul 20, 2025 at 05:46:12PM +0530, Akhil P Oommen wrote:
>>> Add a new quirk to denote IFPC (Inter-Frame Power Collapse) support
>>> for a gpu. Based on this flag send the feature ctrl hfi message to
>>> GMU to enable IFPC support.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---

[...]

>>> +static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
>>> +{
>>> +	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
>>> +		return 0;
>>> +
>>> +	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, 0x1680);
>>
>> magic number?
>>
> 
> Let me check.

techpack-graphics/adreno_a6xx_gmu.c:
537:#define A6X_GMU_LONG_IFPC_HYST      FIELD_PREP(GENMASK(15, 0), 0x1680)
541:#define A6X_GMU_LONG_IFPC_HYST_FLOOR        FIELD_PREP(GENMASK(15, 0), 0x0F00)

(same value for a7/a8)

0x0f00 is 3840, which smells oddly like the XO clock rate (possibly mul/div2)

(38.4 MHz or 19.2) / 3840 is (1000 or 500) (ms? us? cycles?) and the other one is
(333 or 667) - without any further information I'd estimate this is some sort of
scheduler tuning

Konrad

