Return-Path: <linux-kernel+bounces-760898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4AB1F1C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AE1587619
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59826E6EE;
	Sat,  9 Aug 2025 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLXlz1SE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F9263F41
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700831; cv=none; b=a0fozJI9j0PdZrKMkkVilF17891L9xZl3DEz4gfmduF/P1Go2mukPp4SelAz6KQwl+nOR6AKGv0O4KsukkGE9/lFEE4dKOUwhzxp+zeBPVDqw7V6ynkVqSasWmFB0a3Yg8xIbSasEm4XTOsPEml+2GMB1kQ0dLaaKoY1oLgZ+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700831; c=relaxed/simple;
	bh=Bv6JkW55cNcrl0AQNi/EbRH2BwSHIMCsy0q0CzcSEzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g588HMmpKtfpQqs/rHB2aYeTCZoPVnfyLY+oM9YwgF8BhLr59hJh4+qdP6e45UURd0mvKGJn5iiG646NNKuJpl5Db3TRqLrCIewAsCleWJ9HzqIlU9gNVcXIfIc8vQDRHxVsjgPz1CTJHktS2AJfTasHu3AIOykr6u1FaO1bJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLXlz1SE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FSHJx002159
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJPnKcSRwQJ8Ja2LLFPMkF9M1PcIo3OLlDB6PIjUtdc=; b=HLXlz1SEAR4T5o9c
	Ili+g7sGiDniKXSyg/oaYrmFhcSPXFQqQGxqHTKJN6IVXAv7PndcOuZVdl/r3k8J
	M3LH88+1PoUQbDulBWiVRDJdRbQ0gtEhKvNViEQ+FChBiIS3fCQ6MpdhYbW7MIvI
	1wxnR164tQ5GRjFYzK1XbiU98MRMo+St8/GYU89q2PdKpBCDz23T94P055R8ee82
	E7jfOKKCfVQXSGnRf8MqRVm6Drcn9P3kY9mJn7mixYyHx+UCfK6O+3r5YFiepTiC
	XXaJjHmfZaP3qQD0ze0j12LINEF11qCgYgS5doLFpVkotUHHa+A42uxAyEsF04gg
	UUixvg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw3bd4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:53:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so4420284a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754700827; x=1755305627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJPnKcSRwQJ8Ja2LLFPMkF9M1PcIo3OLlDB6PIjUtdc=;
        b=C3gnF8qJZ5xJcxDWZbXjO84yKXpi/ulHGtcfkTMUMwIA3CcU5QX/UZPPSGiFqsDiqd
         0gKuWxkW8Ah9rdd8CbM3v+HzD0Xy5WE51wOiCAOgk7/oFvqL6CHAEuYvjqlWshGaPeV3
         mJpT+A0uzrReM5MtQbtQMewxmoDtD2ljiHA/pCG1oCRvAHzwE1BpiClzB6oe12BH0aPZ
         pkb30pRVXNlS+hpM+n3PSJFZwgl5NRGB7VSZNTaVXjeisGNZtp8H7iqAcvofxH5wZlS0
         WQuQqnbb+GcLy4m0T7/XmW6WnwfOc9FxRFkxHDtr5PwBG4kBJmyo68q8C5XxckAxC5An
         EtCw==
X-Forwarded-Encrypted: i=1; AJvYcCX7EFSwl78FnjSeonN2SQ8kScmgd8aiwHRIrF9ZRe4jrj2jtr4pLEs7LIqrU5oqZcRlguxUY2ROC5eLLpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKYlwVoBca/L7GFTdLNzqhNKTm5wVAvrSXW1rI2wlm+ebgyqC
	2jihQN8LPjtH7mP5/ZGN0Ckpv9v1vs1rT0gc66UQ6QqUCbKQSmVn/duEdj5F/8It6Emx5cHwZqc
	qb8BeVe8tDqLtf65NvN9rj9eU4lydQyrEW0pFYc7iA52N8CmzAnEUob3zuEOfQZpoEHw=
X-Gm-Gg: ASbGncvQnWjRq29e2PJhjAT1aGK7LAmxTg4o4jl0s+hrEigiJxik7wgAdAfAjRR0990
	RvlNkgwza066QJXHjifXiKCd2SQKYj63RJ053vJJ1DRlB+8sft+PGRKJAp22gir/vbT4Ff/G8Wh
	nRt566pPpz5f5l1BTEU4q+dAdAmSA96snpXBLUbGn0BXNC6VGMEfJx6uQUXi+bhBGoVOX7yjYfv
	xPyqgqK/Slc+x8AY9nR8+6alw+ovqRVM1vcW46y6ZAl5jKPj/UTrHhmp4mYvmAdxlsSDF0DtA4I
	toyRklka3NIOt4fYahLefjP3OqfIdeqgxO8HFuFZwoez2IaQqyLR+uXpoV2dRce4MOYRdkBfE/1
	2AzLqgvjxRr76fT1Plcq2QA==
X-Received: by 2002:a17:90b:1fcc:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-32183e33936mr8167791a91.16.1754700827113;
        Fri, 08 Aug 2025 17:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRItAF80pITRrQiGf1tG4sDOi7TzqLz8/4xo7Al3rN4HvKGf5QUP1Fab2OCCqbCNxWsx8ag==
X-Received: by 2002:a17:90b:1fcc:b0:31f:762c:bc40 with SMTP id 98e67ed59e1d1-32183e33936mr8167763a91.16.1754700826572;
        Fri, 08 Aug 2025 17:53:46 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a77576sm13938214a91.2.2025.08.08.17.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 17:53:46 -0700 (PDT)
Message-ID: <4941c486-ccff-40bd-9b4b-9b84a0c028e4@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 17:53:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] drm/msm/dp: Move link training to
 atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
 <20250808-hpd-refactor-v2-4-7f4e1e741aa3@oss.qualcomm.com>
 <e217fb72-36e4-4222-b5da-9608af57c665@oss.qualcomm.com>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <e217fb72-36e4-4222-b5da-9608af57c665@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX8lozyRjgzRGg
 XSiVIehQbtHKxW2DPgTnzBYSoptpj+3Q5N8EAG2Z4So07z3gD981EejcPhKDMKO8GOnWkOYxST4
 4xz31GwO8FVCTw23lMquce/Nu2qTVo667Pg3GL4jhLP7JK/GMJg+l7P5g7lBqRiMFuAe77Akav2
 Sbz+IITbvvQyezS4ZCHSJYUyBcUiFVqsdUpEcEpH5TMP01wczOrgLeCvBPGBQXSQrzgeVpdXnBK
 WLknnEQQXbHEzcjLSS4cT0BjJ/TAtyHAdE2r61wPv3RhBtcZv8iCDQPExIfF+eTF/L5kyDAioCw
 rLP82pb9Buw+rte4Cnw+oAXd+6axfDSs5v2Lqr1Av/JfKWR7GclOgYYBv8EDptnDZpMV8PtJG6i
 zM6d95qT
X-Authority-Analysis: v=2.4 cv=J8Cq7BnS c=1 sm=1 tr=0 ts=68969c1c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=YAZOsL1__VChtR82wIAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: vhOj4NwgNfeXOhgcHTPpJe0uyUln--_B
X-Proofpoint-ORIG-GUID: vhOj4NwgNfeXOhgcHTPpJe0uyUln--_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008



On 8/8/2025 5:45 PM, Dmitry Baryshkov wrote:
> On 09/08/2025 03:35, Jessica Zhang wrote:
>> Currently, the DP link training is being done during HPD. Move
>> link training to atomic_enable() in accordance with the atomic_enable()
>> documentation.
>>
>> Link disabling is already done in atomic_post_disable() (as part of the
>> dp_ctrl_off_link_stream() helper).
>>
>> Finally, call the plug/unplug handlers directly in hpd_notify() instead
>> of queueing them in the event thread so that they aren't preempted by
>> other events.
> 
> This feels like two unrelated changes.

Hi Dmitry,

Ack. Would it make more sense to squash the hpd_notify part with the IRQ 
thread change?

Thanks,

Jessica Zhang

> 
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/ 
>> msm/dp/dp_display.c
>> index e2556de99894..c849befe58f0 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -427,11 +427,6 @@ static int msm_dp_display_process_hpd_high(struct 
>> msm_dp_display_private *dp)
>>       msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>       msm_dp_link_reset_phy_params_vx_px(dp->link);
>> -    rc = msm_dp_ctrl_on_link(dp->ctrl);
>> -    if (rc) {
>> -        DRM_ERROR("failed to complete DP link training\n");
>> -        goto end;
>> -    }
>>       msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>> @@ -1680,6 +1675,12 @@ void msm_dp_bridge_atomic_enable(struct 
>> drm_bridge *drm_bridge,
>>           force_link_train = true;
>>       }
>> +    rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
>> +    if (rc) {
>> +        DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> +        dp->connector->state->link_status = DRM_LINK_STATUS_BAD;
>> +    }
>> +
>>       msm_dp_display_enable(msm_dp_display, force_link_train);
>>       rc = msm_dp_display_post_enable(dp);
>> @@ -1839,7 +1840,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge 
>> *bridge,
>>           return;
>>       if (!msm_dp_display->link_ready && status == 
>> connector_status_connected)
>> -        msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>> +        msm_dp_hpd_plug_handle(dp, 0);
>>       else if (msm_dp_display->link_ready && status == 
>> connector_status_disconnected)
>> -        msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>> +        msm_dp_hpd_unplug_handle(dp, 0);
>>   }
>>
> 
> 


