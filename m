Return-Path: <linux-kernel+bounces-753902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D9B189AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89603AA656C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82341241673;
	Fri,  1 Aug 2025 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o07yc4Li"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A622A4DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092740; cv=none; b=LnFvLJ+l+bvQbQz4Mflq7hOsJP8LCytSx7KQ1fG4Hz+FElqnUIhEjylwdk7t7gYkj7EuqWdIBEW3Lp9SCqaiVV+SGVX0zhod2jIuJsuvVxq0RBusGSxmC7UQkoK5EStEP6hzGJjR/0Rng/nq7TwhvP3NtuvET6MdyoMPA8TsWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092740; c=relaxed/simple;
	bh=+2n+5mKKJyn6pwbw4cuuyFzV70cIuy5ALlq5+ukAC24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y21QqvrwVBEYVJ8IqsNvcB97yo2hjsrWTSi8rScFo1oYK6JMjSIdh9/XHUaaqSG0s1L1QCUcucts573qVRZ3GKCP/9E4JCclM6yQZTvmZE3AJ2CavQ3qko04smabgp8CbkikJ1JISYh00f4eskm6919GK7enGFwZlfduTQP9uV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o07yc4Li; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571LfaUX028250
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 23:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJil9fuANTIpmKQE7cP4cPGJ+csBLlaXLdFVNl5IgEY=; b=o07yc4LiXSNMEQ0m
	tPDQtTL9RKOocu7P/FqueYPSICyprAmwRxEO1PpDp3wZBie5R28tFQA/JcOhmbDi
	Fl1a5SRYUKy8/7LKsBp35BZISo7WN7qQHh68eCQmOx/v9FDCf3uo8lhxObDy9spF
	hMBTocTUEY4TIfIhvBayY9jAa/oHlow2IGFHABxhTWIl2/EfDVrOOXR9dzu2VUVf
	/a+JfVVphcxWsIwUuSr577sD+CQthPSeXG1UdkYl/SrwMLzTEW79t7gHcnaK7hee
	yPvuiWwmhH+qxzdU8kfDV4AVa2B2NFqZDB8f2cXIhAnRMpyrCU4/NdOvFUT8+Nmy
	DAp7Pg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwgj0fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 23:58:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bd2543889so2629308b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 16:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754092737; x=1754697537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJil9fuANTIpmKQE7cP4cPGJ+csBLlaXLdFVNl5IgEY=;
        b=vQXV7LI0HtgNmdA1LwIZHo3m1By2b7o7LKWGWDnmxGDndAw+HdlLR3Sm1pAdyq1aDI
         vA2xzoLTP13L1wu2Jjzo06gbofTjrUlNTm4LX8dZwtpCd9DZ+J6ypEwSSPS9kWy+9Paq
         KSPOhQ45Gm/V2wUnL/1kxWLh6mTFd8zXVHTASucuqst2VkZ6ZML9QcrEL+vcvGK8vmTy
         hv40g7rTQD+o2BUltKc8SnnaoDB9Y5ru7jQfrMp/MGz9fzOMfl6OSJ64JYxd6/KUwSyh
         cqmwYeNa46sX0jKqNuvttv1lFPvxRtyWQOxtat6GPIyLmzCxiyINMUeAK636cK+OtBx6
         QdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDv7nyTiHQYdVmgkU5tJ95GmVUGmWCiHp7obGiRBzSYvUqVbdLRSDGelnCGKqmqT1r6kEaDbGD1iiPMvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJPU6obtm3lpt8q4ij7u4ny3hBT2uDiIWF2B8CsCu3q+lKP6v
	Ih++QIUKcIny7FTz756H0yT1zUSoRZutQrAdFpqB6qm7VI8R/nNvRbfrIyBE+ApFTzDue5otq8y
	KPzs3/ZoU6druhoimff2qifFinkxsUg9MRLmatYG6D4O0E43nJU217jztPrmGtmzgsTs=
X-Gm-Gg: ASbGncu71j09iqQhaW2yYe0akWiMsvKDDBNpe0W5qEdb4yci4qrSE44AiF6nN9OTg7+
	PrLIGcX0kEUxeyFRVI3R9X6//y2mj/CyicVB5bkEElYVHW4ZP0UAU5CRdHrDpFoiJqHfRJD0fce
	HgFtQVf4ohGhzXFqAFSyMMrKXfwzV/+/8CunPOJXMYE9t1wTqEt5S61x5XdqJcC5h6w3sTNIo/Z
	haRno3TPQ1dzb7PVD94X9Z9CJdigB9ew4Md7d0ONctEdIyvxOiyUTnS3AHBoPJAjY6hb+tgSlF0
	6zlgEjrtGWP0+Q5bFEBOvYPCG9YiSNu84OWzLgEX6CmZtYyuvju7koLE9awZ7XCqK3uz/eoZyGm
	MaF9aOCqE8A6UYUIgDUJxzQ==
X-Received: by 2002:a05:6a00:2ea4:b0:76a:d724:d712 with SMTP id d2e1a72fcca58-76bec302327mr1651997b3a.3.1754092737422;
        Fri, 01 Aug 2025 16:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTfKbPm8IV20xoihIcyGu1iRejGkZ8MwdHaIanUdy4YR9la0eA1aJYMT5RSic/HhKvru8Tzg==
X-Received: by 2002:a05:6a00:2ea4:b0:76a:d724:d712 with SMTP id d2e1a72fcca58-76bec302327mr1651981b3a.3.1754092736990;
        Fri, 01 Aug 2025 16:58:56 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd02csm4934867b3a.62.2025.08.01.16.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 16:58:56 -0700 (PDT)
Message-ID: <a085fb45-91e2-4827-b8e9-8af90796cc49@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 16:58:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] drm/msm/dp: Move link training to atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-18-33cbac823f34@oss.qualcomm.com>
 <cofa377vptj7on637u3c3mnxndplcmaegsb5h6idinz5wrvm6s@toylno4uapq4>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <cofa377vptj7on637u3c3mnxndplcmaegsb5h6idinz5wrvm6s@toylno4uapq4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688d54c2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=yJ1ceeCYH-zBWwCu-X0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: yKIz58mHkUocPLhYchQeE5MCUC_2Py7g
X-Proofpoint-GUID: yKIz58mHkUocPLhYchQeE5MCUC_2Py7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5NCBTYWx0ZWRfX9un/7vC963GI
 UFnbJvVji3v+gPFho4kWoJDvuNwXm9c93v5SL03NIEk3PZUdKuf7pmdSCegsI4r04KkATpfX7xo
 J4l7CGlEpBHHdf3nIJjYd5VKVbwY7URLBS+WrnsdCK7SORjIoGS8m/hiwRVz8gxNVH8w3SkM6F7
 ehZcOUT88WiKQzoKgTPwxXZY574kAyI1r3p+6uz+a0bG3tClaI+6yrx4Wmbhh8pIhcuDVKZcVl/
 7D/gwR8WB5KO3EjBy+veIla5dkLPnIdqkiU/CyNtqaVnKH0EsEo6JaC8qDgKSWVEllzk8Fq09z5
 sQq6UJF6Sr6Ax7jFUWCFWAIYnQ+HDcQjsTzPmaHwgp9sLdy9kUuDXxrISOImuPx7iOlfrvleYjH
 a0L3HrvCzBPusTqW/MRMam/e6KGKFOcpT66m41EUV17xoWoeGrvzKlmYs52ySmelrDWCk0eH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010194



On 7/14/2025 4:54 AM, Dmitry Baryshkov wrote:
> On Fri, Jul 11, 2025 at 05:58:23PM -0700, Jessica Zhang wrote:
>> Currently, the DP link training is being done during HPD. Move
>> link training to atomic_enable() in accordance with the atomic_enable()
>> documentation.
>>
>> In addition, don't disable the link until atomic_post_disable() (as part
>> of the dp_ctrl_off[_link_stream]() helpers).
>>
>> Since the link training is moved to a later part of the enable sequence,
>> change the bridge detect() to return true when the display is physically
>> connected instead of when the link is ready.
> 
> These two parts should be patch #2 in the series.
> 
>>
>> Finally, call the plug/unplug handlers directly in hpd_notify() instead
>> of queueing them in the event thread so that they aren't preempted by
>> other events.
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
>>   drivers/gpu/drm/msm/dp/dp_drm.c     |  6 +++---
>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 87f2750a99ca..32e1ee40c2c3 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -410,11 +410,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>>   
>>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
>> -	if (rc) {
>> -		DRM_ERROR("failed to complete DP link training\n");
>> -		goto end;
>> -	}
>>   
>>   	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>>   
>> @@ -1561,6 +1556,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>   		force_link_train = true;
>>   	}
>>   
>> +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
>> +	if (rc) {
>> +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>> +		dp->connector->state->link_status = DRM_LINK_STATUS_BAD;
>> +	}
>> +
>>   	msm_dp_display_enable(msm_dp_display, force_link_train);
>>   
>>   	rc = msm_dp_display_post_enable(dp);
>> @@ -1706,7 +1707,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>>   		return;
>>   
>>   	if (!msm_dp_display->link_ready && status == connector_status_connected)
>> -		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
>> +		msm_dp_hpd_plug_handle(dp, 0);
>>   	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
>> -		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
>> +		msm_dp_hpd_unplug_handle(dp, 0);
> 
> This chunk should be separated from this patch. I'd ask to drop
> EV_HPD_PLUG_INT / EV_HPD_UNPLUG_INT completely and call DRM functions
> all over the place instead. You can do it in a single patch, which comes
> after this one.

Hi Dmitry,

Sure I can split this into a separate patch.

Is the goal here to remove the event queue entirely?

I can drop EV_USER_NOTIFICATION, but I'm not sure if I can completely 
drop EV_HPD_[UN]PLUG_INT entirely without major refactor of the 
plug/unplug handlers since they are used for the HPD IRQ handling.

Thanks,

Jessica Zhang

> 
>>   }
> 


