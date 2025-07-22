Return-Path: <linux-kernel+bounces-741436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89887B0E411
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A911BAA0FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6D284B51;
	Tue, 22 Jul 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7LkkL52"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE422FF59
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212200; cv=none; b=qRYC6X3n9M72MSV+fvwKiSimOsam2sAMsrpAYjLGYPB8JyJJM/L3S9Teh5yLBcos55Lgh89edvWctVFCZwrQ93cHGYWEHf7K06TV1Ccf1xYQzSbELNCpwwpS+l4XOnneFwUQmJtjn99eN/UEjIxUiYPAtQ/wwDIuNpE1ysAjVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212200; c=relaxed/simple;
	bh=Pc+h1H+E8xxMtQSsFjUW0wc/6IGU/hjboocuEOxYosM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbBXGU0/huaTaDtWztO6GpOZOZ4Nd7Ccx8k9C2BzvZlLtBVn4h8L5Ijs1AwryjW7ninqmINRYyVXxGkNYpjOxTo05vbn8goIItu0WJfWLE/WOxHcESI5Jx97CUQOwIbmMC1jRvdAGVjlmODbSy9BgZcB1E0yv+ZBKB1U27C9D44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7LkkL52; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEdxDD012849
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y6OxZtp9vvZax/Q2qqYgpUgRGF5sEqL1kmgDnxhJH5c=; b=P7LkkL52ERTbjHsM
	LLHB4s9DlE2TsSs+B4PA8dwpR6Yx4ivpDYflwu+p+Wk/49kTHe+bGho87QCGVty9
	8pmGkd8M3cx1kpOOQ9wHWb5ODpfmKg3DvTcuiyArX1fxU44wmQ4JuO/IKsnQm1fS
	RtSBvCpxvI5OvR1g/AWZvbTPpnOiKof6eaOg8FdXCDdb3PgPu367Sr6BytaTJkN/
	YpVannprLo7ORZ8TvRuOAlP0qgZfMUUMxTDc4Musv3kpV9oGcbgwpy0QOqKFqLex
	z762B31vkHmx03C3wN+HsXAkZtDbtuYxMGUCsDcTCgkW3+KAHH9atn7757kvhYk1
	40j9Vg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3enes6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:23:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso8777840b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212196; x=1753816996;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6OxZtp9vvZax/Q2qqYgpUgRGF5sEqL1kmgDnxhJH5c=;
        b=ZzLto6rQsTW7H16ak/zLQNOOlTZM8tCvr9xNgVi7jJ7HmwKMUh0agOmEEPPOvjwHMT
         OIr6xNT5eeIZTcYC2uzlcTSwW5uJA6NDYcaij3Vl9Dq82XzSlMlOm/lyHnUg7LrQP26C
         mI+kIMurBHqImsX7gUUPNiW9ppOm9n3M9YcMUEvplXpwQSlOaY1S/5qHwpEbQCXFpd0m
         LR5P6Sj5bOsO4cwnufHus0EQi/D49vNYnzU9DnaNj1KpF6VDA3AmWr93UTS/+r3NoQnG
         WQf9BdRF7FjF+AV5wlLuuHS1jMW5QsAaGk044vak9VlbhGU00n1Y7g0d2GOKKjcfgwB3
         jA8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtzAWPIV7T362m8A1hEgkpfOrRl0ycd1H53dnnXqr58aIClwDLLqeg0QsoWTmeVx74n9qy/WyLI5ULYnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+WahEx0OdLzaske9K2lyRVZWYlUYNgRHbd11hoeAZcQMQwPs
	nsOa1a+uxYUmkX/VCPzuM739o9+/xl2UvRM5DE/dMqH8KQMaYclM59f/iE4/47Hiqn5wCNjldS6
	sKYNn7xlbEKRjyosaYF6NO0/4RS6YHA8Jr1hYuKW88O9wnCsJzPAcLmyvbxvFKyqFQyU=
X-Gm-Gg: ASbGncsXnJyJcHerCLI1o8ZsaiF0nikH058BvBjm1NVHTGlGHPJ/7UR2pX0CkW2tkr7
	nxkfliu615c7GZ3Uq882X3Jz8i61e5QEqhCzR1/6NGQLjSpPGN3Z5qw/dlpyM6b/ekhmw55mG3E
	8DTn5wUxHfpwf74LZ5ifC6DkY1J8MvZHIAekiRsW3fMGDYghig0Ybt3jtP/LQ1rdVohyPyJeoGN
	1wVgWv8vt5frQTAyI+D7U5zO9aXmEdmZwclS2RKBa0+91xlrRu9kNXX9kqjle+Y9Zypfa3FhXk+
	2oBdFftM0zQYbunCijkWTD+/NAyOiADA38elQM/y7Pb/2HfdDbx60iA3XOFUVgvx
X-Received: by 2002:a05:6a00:1909:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-76034c4da07mr691862b3a.8.1753212196502;
        Tue, 22 Jul 2025 12:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZto37mgHShkAsmIcFVd1Yhzk4xGY6Lskz4Tb57kthENKf/xIJ68iAYMK1aJLYGAgBaOdIuA==
X-Received: by 2002:a05:6a00:1909:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-76034c4da07mr691818b3a.8.1753212195961;
        Tue, 22 Jul 2025 12:23:15 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.235.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569f5sm8187912b3a.80.2025.07.22.12.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:23:15 -0700 (PDT)
Message-ID: <800f8c9d-5586-46a7-aa83-dfb3b97633e0@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 00:53:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm: Skip devfreq IDLE when possible
To: rob.clark@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-12-9347aa5bcbd6@oss.qualcomm.com>
 <vng6tut4sv3zfbwogsb74omqsbqutpeskqdnezbs4ftsanqyb4@nv35r7mqmcva>
 <CACSVV01EhWWohUDQ8n=FQeDuaDcgmYnMBJDMJ8D1Gist1NR4QQ@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV01EhWWohUDQ8n=FQeDuaDcgmYnMBJDMJ8D1Gist1NR4QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zuuUmF728pUUwk6D93rLq6Y8RxWdYEoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE2NiBTYWx0ZWRfXycGC/IMUbRoM
 u+aAlIq/8QPGGW1RLIj/xL5F2ZeMPsjydHkXyoaChuhgiU4kx+TkeyMEpB5OMCyY2xle/5oBqF/
 kakZdUbUrD12civ4BJ8Wm1UBTTs3+tLRzdJrUmxybQPpJexUoxrdyuqAXFlsd7Yvp1lppacG4uy
 W04pLAgTDoH+h6rqZiKfDjXqgNptfXBQr+7z+SHL/62DRvZ/V3j/Cyhu4gQVygFC3giIiA0HDz6
 9YrK4xiOL5k91fQDLKbH53IQLBd572XNjEOc90p4/Q7MBWvGAFGQGklQQfaXSSAZuOY4nJ649ET
 w2amAmg9Y8wFHjPfSLKB9Y8N+ZoL5URKaxiKhwmPhuXd5kaw54K4Tj6P/ItvnsCVWg1MEpmrJv1
 TN2sbXURh+6zK0h+Jb7DiTLsZP5tIM7X9K5nG2FPBZIORfFfjVJF82N9CHi6gq51oixunPG2
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687fe525 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=4dphQItTPUswyQvINXrzgA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=blXxefCSwbONkpe3GJMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: zuuUmF728pUUwk6D93rLq6Y8RxWdYEoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220166

On 7/22/2025 9:08 PM, Rob Clark wrote:
> On Tue, Jul 22, 2025 at 6:50 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Sun, Jul 20, 2025 at 05:46:13PM +0530, Akhil P Oommen wrote:
>>> When IFPC is supported, devfreq idling is redundant and adds
>>> unnecessary pm suspend/wake latency. So skip it when IFPC is
>>> supported.
>>
>> With this in place we have a dummy devfreq instance which does nothing.
>> Wouldn't it be better to skip registering devfreq if IFPC is supported
>> on the platform?
> 
> devfreq is still scaling the freq.  What is being bypassed is
> essentially a CPU based version of IFPC (because on sc7180 we didn't
> have IFPC
> 
> Currently only a618 and 7c3 enable gpu_clamp_to_idle.. if at some
> point those grew IFPC support we could remove the trickery to drop GPU
> to min freq when it is idle altogether.

There are 2 functionalities here:
1. Clamp-to-idle: enabled only on a618/7c3
2. boost-after-idle: Enabled for all GPUs.

With this patch, we are skipping both when IFPC is supported. In the
absence of latency due to clamp-to-idle, do you think a618 (relatively
weaker GPU) would require boost-after-idle to keep with the
UI/composition workload for its typical configuration (1080p@60hz)? If
yes, I should probably create a quirk to disable boost-after-idle for
premium tier GPUs, instead of tying it to IFPC feature.

-Akhil.

> 
> BR,
> -R
> 
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> index 2e1d5c3432728cde15d91f69da22bb915588fe86..53ef2add5047e7d6b6371af949cab36ce8409372 100644
>>> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
>>> @@ -4,6 +4,7 @@
>>>   * Author: Rob Clark <robdclark@gmail.com>
>>>   */
>>>
>>> +#include "adreno/adreno_gpu.h"
>>>  #include "msm_gpu.h"
>>>  #include "msm_gpu_trace.h"
>>>
>>> @@ -300,6 +301,8 @@ void msm_devfreq_active(struct msm_gpu *gpu)
>>>       if (!has_devfreq(gpu))
>>>               return;
>>>
>>> +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
>>> +             return;
>>>       /*
>>>        * Cancel any pending transition to idle frequency:
>>>        */
>>> @@ -370,6 +373,9 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
>>>       if (!has_devfreq(gpu))
>>>               return;
>>>
>>> +     if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
>>> +             return;
>>> +
>>>       msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
>>>                              HRTIMER_MODE_REL);
>>>  }
>>>
>>> --
>>> 2.50.1
>>>
>>
>> --
>> With best wishes
>> Dmitry


