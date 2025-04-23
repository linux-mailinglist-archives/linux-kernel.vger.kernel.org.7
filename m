Return-Path: <linux-kernel+bounces-615397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93418A97C95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 04:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D48189C3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9912641E8;
	Wed, 23 Apr 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J0nQqqSv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BDD2580CA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374062; cv=none; b=TUZeZpcW4NzUYHgabGTYiUuo3hdMGKtiqTqMpU7y809pdVOOQ56RkOSIifSPXibhKtKKXPx2Qh+2WXFCfFz6UL4rqIkLKqzS7Oc1evhmgYXisQbpD05AlVVY67zE7q9gYULc0NA0JyVc1EcNnSNX2QMfP+UKIqIyoHGBtDYGJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374062; c=relaxed/simple;
	bh=5ANSf0dAy0mRc8QQEzv2Szv0Up/f+xp+iFDK+jF+IZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4Qwb3tZkp/SKGQNGyBmdo8Wn15XfNc+fFFjNf9KMkh95+9klcFKryu4Jv5mDpyKOTEDkaLeUDZKLCQvgbcV92IGW8GRiD8A0itmzXex49xjGpdOYeU6nuDROxp3AOt9WtUlrCNUHXXWHCqfRw2YEMtx/c9hezHRBBbkKx9o4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J0nQqqSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i91Q016163
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 02:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IlWnFHyggt+QPo001qL3ii9DznQukGteQloItUUkzOI=; b=J0nQqqSvy4Inu5+A
	vGVAporgg9Ddy+H4mLy6ucsK5r+dTqnxE3P11aOas8IHFg4BacumqJNDoemnTq7D
	Nh29aMwmG05/rniUigEGdWcMEmriPhvvzHW9P6sYy9CU9OffmDdKFAjz8JAcUIRu
	5RmTt3FmGhWSxBKAh9XEywOGECpfoJy2YbhfrjWWibfkow6d/lNySQ0GbU0jYLWh
	o0WO44Ug0MZW6puAA8dL4OWXIW81aXVd9n0IMU5nJyuirOrUzR9lxUaoSnZNGzJY
	+0KHJMVDoCC/masSRSQzyAZ9D/G+hbarFpd41HLqHff24s50lG/iIo4kiemmgfud
	cVxZuw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3ghtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 02:07:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b073ef14fa7so3318448a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 19:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745374057; x=1745978857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlWnFHyggt+QPo001qL3ii9DznQukGteQloItUUkzOI=;
        b=DJnz1/sZaHTdQRzLZUHC/Y3Ds8RL4rkRJhKn5aPq81U/jDjVG8sd4WTp+w8TV7OJlA
         0gR44cAdrdf2uNXSSV5I9k/phoEC9ev3luHwOVIBNxNkAppAlsDutKgqjVmksBdm1cit
         SffhzdIT+MZ3/1hSeyCgmrQYxwECcHuAD6q5CbEjkIJ/2jYoxdssn7s6OHdKuO9uiF67
         pS+ObjGEPWKlMCeGuNDzJgLTQHl8m+KOFbXF3Tbub65GT6vYHNgomFrduy9F2dTRiq6P
         9ImVgO0gsRCerQJ3D/nvoyr9P5nxn7kDllpRnxHT4A1eWMU2Oe3PCF89Vgw8OywnO5id
         +qAw==
X-Forwarded-Encrypted: i=1; AJvYcCXcwg+cWnqsX44XhkqiRXrb0E3GLYNFdKGya14xt2BzUAXQE7WgGHsmqc2Fi1My2Xr/Dt8QBZaMNuzPeCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeOqq1UwxVkiiF3bynIugkPogvkFkvBrG1TVzzA2ebUtbyGyd
	+QGdobMPCFHhxs+CvgtCXl7Ai6369FMx59OnHwfBIfgeLUaZXNh+cBNHdXcStQNvPCBW81vhfwA
	m78ydQCGSKwVIMlEmNQdTtE7GGd5jGXpPCiMZlyIG8gwT5KvOlXMBj4QeUeh2SUo=
X-Gm-Gg: ASbGnct/f5Z2rf486xikYm9d97UXXgPSSmoi9Z12yYkZSa4UwiYnpIweyaUHNk4Pxg+
	4QaITNNKdzwCrsBA7458IAyTw9RNdK8QTatbc9GCCoqY/eW4gJ6bgWMvGquFxR9Q8w5nOIQwrdl
	pTAKt9kP/cSp8ZNvSxtJMrI3TYu3n47ckF3/k2Ag2wXTTdGRtpnhT7zdGy0s49OBAvvFty0GuKp
	3qXA0kHzjnd3dXNWOfcD9JjblJsyYyJq9vPpu3HADs/CckQyAGCRqxlYy9YRxeZVyX5beDQxNh0
	bh0H4Q+Ir29NvIyyempqbvl+mC09id1VTJ49SGxenrOGFhQYKYmXwouWufj2GvLDioLMq2dO
X-Received: by 2002:a17:902:e847:b0:223:35cb:e421 with SMTP id d9443c01a7336-22c5362087bmr272836965ad.49.1745374057216;
        Tue, 22 Apr 2025 19:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBjSKzHitU5aLA4r5CloLulzEMNbdHigKl7eVk9IICwgD7fbWUwzh5pf8w1MfIfcVjF45Faw==
X-Received: by 2002:a17:902:e847:b0:223:35cb:e421 with SMTP id d9443c01a7336-22c5362087bmr272836505ad.49.1745374056673;
        Tue, 22 Apr 2025 19:07:36 -0700 (PDT)
Received: from [10.133.33.180] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda70esm93022785ad.15.2025.04.22.19.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 19:07:35 -0700 (PDT)
Message-ID: <54a505c9-b313-40f3-a69f-5f99835a510d@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 10:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] coresight: tmc: refactor the tmc-etr mode setting
To: hejunhao <hejunhao3@huawei.com>, suzuki.poulose@arm.com,
        james.clark@arm.com, anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@huawei.com
References: <20250418055820.3689408-1-hejunhao3@huawei.com>
 <20250418055820.3689408-4-hejunhao3@huawei.com>
 <49992acc-076d-429d-ac07-092d2fffbcb8@oss.qualcomm.com>
 <ce34c289-2ffc-426a-8b9e-6c8cc9e5e7bd@huawei.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <ce34c289-2ffc-426a-8b9e-6c8cc9e5e7bd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VzKYT7KfrWMnwRCtx3_9msWnmAfTklpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAxMSBTYWx0ZWRfX0oa55R0fo46/ xwOkThFpA6olrfDi4jt3mzq59sRO1AjCygtWMfuslYZroJeXlIjw8mM+DUjXbnErM0G22l8C/xi PIMhugEgfi3r+tBqf3FzyZm/WlCph+Q3tbXPc3uO85UKz+L+dg4exB1XdhnOgoNNCd1o3FamD0n
 ndPtzgqGxsHhr0ij2rz2jk4l9pSGJBJfjimJBQ39HeApaRDA6XNPA3IRlfKzT9rZcI4c/msAZBp ICFN5wMGF6ZswE1FzpiSvG8KyYDk8UWOUK7ZY2snx4YzKJfTIA6aBNn0EhOy51Xk1PD3ngzydFi 6iuKkEns9MYYmo/A3czMdEa3fuv2rKcj24o15yGGRcC9jo34dBRtWLzBhSpZdYCZulZqnxFErMC
 C4/tJ21yMtUnxHMSkJRYSPUUlz/egkpQQ0BzgjQc62tzXZhkjjBfjSMZavQHGJh4uGN1tJAM
X-Authority-Analysis: v=2.4 cv=ELgG00ZC c=1 sm=1 tr=0 ts=68084b6a cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=BTeA3XvPAAAA:8 a=eMscG2cWfzpx6jt4w84A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=tafbbOV3vt1XuEhzTjGK:22
X-Proofpoint-GUID: VzKYT7KfrWMnwRCtx3_9msWnmAfTklpe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_01,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230011



On 4/22/2025 8:52 PM, hejunhao wrote:
> 
> On 2025/4/18 15:12, Jie Gan wrote:
>>
>>
>> On 4/18/2025 1:58 PM, Junhao He wrote:
>>> When trying to run perf and sysfs mode simultaneously, the WARN_ON()
>>> in tmc_etr_enable_hw() is triggered sometimes:
>>>
>>>   WARNING: CPU: 42 PID: 3911571 at drivers/hwtracing/coresight/ 
>>> coresight-tmc-etr.c:1060 tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc]
>>>   [..snip..]
>>>   Call trace:
>>>    tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc] (P)
>>>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc] (L)
>>>    tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc]
>>>    coresight_enable_path+0x1c8/0x218 [coresight]
>>>    coresight_enable_sysfs+0xa4/0x228 [coresight]
>>>    enable_source_store+0x58/0xa8 [coresight]
>>>    dev_attr_store+0x20/0x40
>>>    sysfs_kf_write+0x4c/0x68
>>>    kernfs_fop_write_iter+0x120/0x1b8
>>>    vfs_write+0x2c8/0x388
>>>    ksys_write+0x74/0x108
>>>    __arm64_sys_write+0x24/0x38
>>>    el0_svc_common.constprop.0+0x64/0x148
>>>    do_el0_svc+0x24/0x38
>>>    el0_svc+0x3c/0x130
>>>    el0t_64_sync_handler+0xc8/0xd0
>>>    el0t_64_sync+0x1ac/0x1b0
>>>   ---[ end trace 0000000000000000 ]---
>>>
>>> Since the sysfs buffer allocation and the hardware enablement is not
>>> in the same critical region, it's possible to race with the perf
>>>
>>> mode:
>>>    [sysfs mode]                   [perf mode]
>>>    tmc_etr_get_sysfs_buffer()
>>>      spin_lock(&drvdata->spinlock)
>>>      [sysfs buffer allocation]
>>>      spin_unlock(&drvdata->spinlock)
>>> spin_lock(&drvdata->spinlock)
>>>                                   tmc_etr_enable_hw()
>>>                                     drvdata->etr_buf = etr_perf->etr_buf
>>> spin_unlock(&drvdata->spinlock)
>>>   spin_lock(&drvdata->spinlock)
>>>   tmc_etr_enable_hw()
>>>     WARN_ON(drvdata->etr_buf) // WARN sicne etr_buf initialized at
>>>                                  the perf side
>>>    spin_unlock(&drvdata->spinlock)
>>>
>>> To resolve this, configure the tmc-etr mode before invoking
>>> `enable_perf()` or sysfs interfaces. Prior to mode configuration,
>>> explicitly check if the tmc-etr sink is already enabled in a
>>> different mode to prevent race conditions between mode transitions.
>>> Furthermore, enforce spinlock protection around the critical
>>> sections to serialize concurrent accesses from sysfs and perf
>>> subsystems.
>>
>> Is any issue observed during this race condition?
>>
>> The etr_buf is checked before assign it to sysfs_buf or perf_buf.
>> In my understanding, the warning raised to indicate the etr already 
>> enabled with sysfs mode or perf mode, so terminate current enable 
>> session, right?
>>
>> Thanks,
>> Jie
>>
> 
> The sysfs task is executing the process to enable tmc-etr and has allocated
> a sysfs_buf. However, the sysfs spinlock does not ensure atomicity of the
> entire enable_etr_sink_sysfs() function execution. In this scenario, the 
> perf
> session may preemptively call tmc_etr_enable_hw() to enable tmc-etr.
> 
> Consequently, during race conditions, perf always prioritizes execution, 
> and
> the sysfs_buf remains un-released, leading to memory leaks. Then this 
> triggers
> a WARN_ON(drvdata->etr_buf) warning.

The pre-allocated sysfs_buf is stored in drvdata->sysfs_buf. And I think 
it's fine to remain unreleased until the ETR is enabled with sysfs mode.
The ETR will not setup a new sysfs_buf if drvdata->sysfs_buf already 
exists. But in other words, it definitely consumes some 
memory(especailly allocated a large size of sysfs_buf) for a while or 
forever if we dont enable the ETR with sysfs mode in the future?

I think this is the issue try to address?

Thanks,
Jie

> 
> This patch also addresses the issue described in [1], simplifying the 
> setup and
> checks for "mode".
> 
> [1] Closes: https://lore.kernel.org/linux-arm- 
> kernel/20241202092419.11777-2-yangyicong@huawei.com/
> 
> Best regards,
> Junhao.
> 
>>>
>>> Fixes: 296b01fd106e ("coresight: Refactor out buffer allocation 
>>> function for ETR")
>>> Reported-by: Yicong Yang <yangyicong@hisilicon.com>
>>> Closes: https://lore.kernel.org/linux-arm- 
>>> kernel/20241202092419.11777-2-yangyicong@huawei.com/
>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>> ---
>>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 77 +++++++++++--------
>>>   1 file changed, 47 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/ 
>>> drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index a48bb85d0e7f..3d94d64cacaa 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -1190,11 +1190,6 @@ static struct etr_buf 
>>> *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>>>           spin_lock_irqsave(&drvdata->spinlock, flags);
>>>       }
>>>   -    if (drvdata->reading || coresight_get_mode(csdev) == 
>>> CS_MODE_PERF) {
>>> -        ret = -EBUSY;
>>> -        goto out;
>>> -    }
>>> -
>>>       /*
>>>        * If we don't have a buffer or it doesn't match the requested 
>>> size,
>>>        * use the buffer allocated above. Otherwise reuse the existing 
>>> buffer.
>>> @@ -1205,7 +1200,6 @@ static struct etr_buf 
>>> *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>>>           drvdata->sysfs_buf = new_buf;
>>>       }
>>>   -out:
>>>       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>>         /* Free memory outside the spinlock if need be */
>>> @@ -1216,7 +1210,7 @@ static struct etr_buf 
>>> *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
>>>     static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>>>   {
>>> -    int ret = 0;
>>> +    int ret;
>>>       unsigned long flags;
>>>       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>       struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
>>> @@ -1226,23 +1220,10 @@ static int tmc_enable_etr_sink_sysfs(struct 
>>> coresight_device *csdev)
>>>         spin_lock_irqsave(&drvdata->spinlock, flags);
>>>   -    /*
>>> -     * In sysFS mode we can have multiple writers per sink. Since this
>>> -     * sink is already enabled no memory is needed and the HW need 
>>> not be
>>> -     * touched, even if the buffer size has changed.
>>> -     */
>>> -    if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
>>> -        csdev->refcnt++;
>>> -        goto out;
>>> -    }
>>> -
>>>       ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
>>> -    if (!ret) {
>>> -        coresight_set_mode(csdev, CS_MODE_SYSFS);
>>> +    if (!ret)
>>>           csdev->refcnt++;
>>> -    }
>>>   -out:
>>>       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>>         if (!ret)
>>> @@ -1652,11 +1633,6 @@ static int tmc_enable_etr_sink_perf(struct 
>>> coresight_device *csdev, void *data)
>>>       struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
>>>         spin_lock_irqsave(&drvdata->spinlock, flags);
>>> -     /* Don't use this sink if it is already claimed by sysFS */
>>> -    if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
>>> -        rc = -EBUSY;
>>> -        goto unlock_out;
>>> -    }
>>>         if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
>>>           rc = -EINVAL;
>>> @@ -1685,7 +1661,6 @@ static int tmc_enable_etr_sink_perf(struct 
>>> coresight_device *csdev, void *data)
>>>       if (!rc) {
>>>           /* Associate with monitored process. */
>>>           drvdata->pid = pid;
>>> -        coresight_set_mode(csdev, CS_MODE_PERF);
>>>           drvdata->perf_buf = etr_perf->etr_buf;
>>>           csdev->refcnt++;
>>>       }
>>> @@ -1698,14 +1673,56 @@ static int tmc_enable_etr_sink_perf(struct 
>>> coresight_device *csdev, void *data)
>>>   static int tmc_enable_etr_sink(struct coresight_device *csdev,
>>>                      enum cs_mode mode, void *data)
>>>   {
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +    enum cs_mode old_mode;
>>> +    int rc;
>>> +
>>> +    scoped_guard(spinlock_irqsave, &drvdata->spinlock) {
>>> +        old_mode = coresight_get_mode(csdev);
>>> +        if (old_mode != CS_MODE_DISABLED && old_mode != mode)
>>> +            return -EBUSY;
>>> +
>>> +        if (drvdata->reading)
>>> +            return -EBUSY;
>>> +
>>> +        /*
>>> +         * In sysFS mode we can have multiple writers per sink. 
>>> Since this
>>> +         * sink is already enabled no memory is needed and the HW 
>>> need not be
>>> +         * touched, even if the buffer size has changed.
>>> +         */
>>> +        if (old_mode == CS_MODE_SYSFS) {
>>> +            csdev->refcnt++;
>>> +            return 0;
>>> +        }
>>> +
>>> +        /*
>>> +         * minor note:
>>> +         * When sysfs-task1 get locked, it setup the mode first. Then
>>> +         * sysfs-task2 gets locked，it will directly return success 
>>> even
>>> +         * when the tmc-etr is not enabled at this moment. Ultimately,
>>> +         * sysfs-task1 will still successfully enable tmc-etr.
>>> +         * This is a transient state and does not cause an anomaly.
>>> +         */
>>> +        coresight_set_mode(csdev, mode);
>>> +    }
>>> +
>>>       switch (mode) {
>>>       case CS_MODE_SYSFS:
>>> -        return tmc_enable_etr_sink_sysfs(csdev);
>>> +        rc = tmc_enable_etr_sink_sysfs(csdev);
>>> +        break;
>>>       case CS_MODE_PERF:
>>> -        return tmc_enable_etr_sink_perf(csdev, data);
>>> +        rc = tmc_enable_etr_sink_perf(csdev, data);
>>> +        break;
>>>       default:
>>> -        return -EINVAL;
>>> +        rc = -EINVAL;
>>>       }
>>> +
>>> +    scoped_guard(spinlock_irqsave, &drvdata->spinlock) {
>>> +        if (rc && old_mode != mode)
>>> +            coresight_set_mode(csdev, old_mode);
>>> +    }
>>> +
>>> +    return rc;
>>>   }
>>>     static int tmc_disable_etr_sink(struct coresight_device *csdev)
>>
>> .
>>
> 


