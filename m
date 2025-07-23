Return-Path: <linux-kernel+bounces-743127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33534B0FAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260491C83921
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766EE1C863B;
	Wed, 23 Jul 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elUwVCTn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FD229B1F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298898; cv=none; b=orJm0NOANWW6Qlu8jKXOtzHevsiL0E89Ogox7SQ6gDWqMiBNHkeV3Cl3EXLLbZ+QN03zzWrAbe6TDMO0fcy/lZWptbS/ZGfFlIf4SuX93Evsidsw3I6pWr9fDBnq2O21z4oHi43RIc1DPpXseQEfNkPjAtbIKDz02JtnmkbVfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298898; c=relaxed/simple;
	bh=0qY1Fauhy6lPKi6mWyF0ofZO2VKxRTnNbqGXT538BTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9lWcXE2+B3aShZipBZvcqZWRryzCjQfDcOZQl9zZIvdmPM4LQE7ZDXdF+oAXnbRdQAUgd0jZ3//eQzDE6oA5GWUNp+LJMGCtn2HDvG5uy7Il2/ndtukggAfVnt4pNyzICpsuNg/Fk+CtDIMc0SWJSYFrrVX+ldn84eSZDUPx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elUwVCTn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHmEcG032283
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dEPpLzKeqJu3UReNaIbyKoLWpwho+WecEv4aP5Gr93U=; b=elUwVCTnep5AeAwR
	IfdVXJzHyJ2j2YgDwvf1rBvHu/pxSLcxLziXZCTqqiJ9dI/AT6ToBgaOshOrpn+L
	txNNOcZj3Y3xqR7XHI7Pahh2yCvF9jgxjw1i1SoNbHBXMsy7SFFjaeyXAn6k4BKN
	Su2tXNx9Nw4tyrJmd1mNtBbILBr41h+t8Z99oUwGFeANTHrhxnytVFqduPV5eVZ5
	2o2odGpxZb7gDxdBDTp4Q8RGJewtZNPx27ZxxQmQ4an6kXeN65b2TB2i/t5N3OlV
	8AJxOh+HLUTcgLhF53DVLiOa6Y/JsbFPT3hYNkcHTc98NDBkrx1dwLuY+Sw1hgGx
	xhibXw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1dnbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:28:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748e1e474f8so369459b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753298895; x=1753903695;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEPpLzKeqJu3UReNaIbyKoLWpwho+WecEv4aP5Gr93U=;
        b=OG8lb5fbCvmKytNzk79SmFhb5yjf0n+BvcYtkPSwpqeIh509xkC72IZ542McNN8Pei
         gdTWu8kLn/eDrSqf+NYZctRjSVCPzdyb7akb5mmYbeUjLY2xXQe7vJakN1BxK/y6vyc3
         /Uttrjs/bnUyW61erk2CjgQ7sVtrPJ5jISE97qw6uw2b2fMOlLpq4fFKz7QMTIr6Lvt8
         pSOKw9w5vb4cMLSSzD9E0Zu+m/J8AuDNtftU3olIHohcVrL4fOWGjE8oVjWYh78dewXp
         CYdd5QK8CXoC7JYKesjh01rcw77ghxIC9iMsh/KiKaoNL1GuRxmqBk5fWhXYgE8Ev+fJ
         Q3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUiP2l+AwfZoBLdBL/LU8GkQjM5WcAi1qC0jdMvBD0ALQqFOVyvmEj3UFBDfiiqRmvsx+sFZ7mPBdSXTKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7SoT0JM27VqG2a1oVUEBVQ6Yr2wmupjk0ZLSiCWROM2L6lcC
	pTdp6QSaqocZll4L6nODZnFYg+9ZJF5Y13RfcZDJ3bTm/JOczzAy6i4DZCbYhLcaGEuH25KHWiI
	DZFxjhyte24BKBqGipPje5FXvWLiUybJCoMkGGv2hyQ612ZOJcN0Hlxn6OrHNq65PBOc=
X-Gm-Gg: ASbGncuEfkQ3vwPQd1LrfwNnyQlE8j2ZjgmTMMsIJOc/lde3tXPoZFsuRYRfbogzrNo
	DSKcLaQ8qbHqTi1a3IfwvIC1SZvi3JX3mhE+AVIUnWqPfbLuCJiTJQP0iQjNxKfaqg0Hhzyqvyb
	EvUDViCkfDAy/pWbPeEC4BeM46vfAPx6/rYAX+dcOtiKCVC9FnVPpBfeTOSZMJSkzwMSsel09K7
	nJhtAj3GzwtHdd5sft2mHWx47GnyaoNKK+8QnJZaBoiGQ/vIwTbBwnNUrNBPZ9XKrp7vvU/PfwG
	cuRvmy/mAN+2GD2feqQt1LhTNJ+yON17KdADHKXqBbVxsopCDkZfeUncOxwyZ/uK
X-Received: by 2002:a05:6a00:92a7:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-760353f2759mr5979862b3a.16.1753298894794;
        Wed, 23 Jul 2025 12:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1De95jDWxBiK1YfH4dGSVrP8HoJa9rCXrriSg+jAMFq+zrcKp1RL82O1tROQaZFGCKLlpkQ==
X-Received: by 2002:a05:6a00:92a7:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-760353f2759mr5979825b3a.16.1753298894278;
        Wed, 23 Jul 2025 12:28:14 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb974ca5sm9973140b3a.131.2025.07.23.12.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 12:28:13 -0700 (PDT)
Message-ID: <002eb889-87cb-4b8c-98fb-6826c6977868@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 00:58:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/msm/a6xx: Poll additional DRV status
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-4-9347aa5bcbd6@oss.qualcomm.com>
 <9778efad-e9a8-4934-9b70-b0429bcfe63e@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9778efad-e9a8-4934-9b70-b0429bcfe63e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hlCsdJ3jJidHDbh1ADvX0kUXQ0BU1IUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE2NSBTYWx0ZWRfXx1d7BLGTUDev
 mUteCInNFrJoZ517bXIXajLjQISJ6crFve5oYZsN3k/R3COkQg1SBM3Skc4rPMBYuOEafRMktOh
 fGcKLcMr8KcNdLOTRFzwx8d+NBSm1NAR5oH8WI151ALGQLyZac+xJg68zro2gDG2EvRhOqKa1a+
 dtJqA6m5tGM1XS91/B6Y/A+0TzIFUULB7z67WZvfSXJ5ogpua96x8ZwBrYt7wKxEDGVYLE6BtM8
 ed1bvx9rZ6+rjqZ5diIHWoMt+JGAM6J4zCLt7iggb656mSLP8wDUCcDDfd0i5UurtdXvLcjVGtx
 BeXS79S9Mn1+YgO0GsoWeJO+GPCj5Jj8Xl5vbeXNcwDeFUqbEzHT6ncd/Q694gx9BJbGuunicjq
 G/ooeDJFYF+KhL7+QqSkn5kg5OfuwQYLMUs5E/Ji+gdcEA++cJvjsFZbXr64qNqXEo1Crz+P
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688137d0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=f35hG6qQLWE-6-FZ_2MA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: hlCsdJ3jJidHDbh1ADvX0kUXQ0BU1IUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230165

On 7/23/2025 3:31 PM, Konrad Dybcio wrote:
> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>> A7XX_GEN2 generation has additional TCS slots. Poll the respective
>> DRV status registers before pm suspend.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 790ef2f94a0b0cd40433d7edb6a89e4f04408bf5..3bebb6dd7059782ceca29f2efd2acee24d3fc930 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -987,6 +987,22 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>>  		val, (val & 1), 100, 10000);
>>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>>  		val, (val & 1), 100, 1000);

1000us here is a typo and I copied the same mistake below. I will update
all of these timeout values to a common 10000us in the next revision.

>> +
>> +	if (!adreno_is_a740_family(adreno_gpu))
>> +		return;
>> +
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS4_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS5_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS6_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS7_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 1000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS8_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 10000);
>> +	gmu_poll_timeout_rscc(gmu, REG_A7XX_RSCC_TCS9_DRV0_STATUS + seqmem_off,
>> +		val, (val & 1), 100, 1000);
> 
> FWIW there are places downstream where it polls for 1 ms
> (gen7_gmu_pwrctrl_suspend) / 2 ms (gen7_gmu_power_off) ms (as opposed
> to 1 or 10 ms here), but the timeouts are all the same across registers
> (unlike TCS3 and TCS9 above)
> 
> Ultimately it's a timeout, so a value too big shouldn't matter, but
> let's make sure the other threshold is ok

They are fine. We can try to reduce the timeout 2ms in a separate patch
outside of this series.

-Akhil.

> 
> Konrad


