Return-Path: <linux-kernel+bounces-723087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCACAFE2B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047B83B06B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FC277C82;
	Wed,  9 Jul 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZSBR7BL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D218273D8F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049940; cv=none; b=TRxXH5bi00ENZwkrUUBUGxB7o6Xx3PH364+hlZraE36Y2ImLQ/z0ufSe/GCz/gWGa51c9gEd13elzlJIkHVl9O7KJ7lYitb7u/PGCNcw1e6P37f2MotvSeHw3C9RK0ZKEUiSI3iiAL8Bx9x7CVSKfiePsygpykdshpUIXuScGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049940; c=relaxed/simple;
	bh=DzcH7L60UbeOJ9WOUsF8qxsGcS7+hgTpKAgmlponWSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTwHLagNt0O4PxSwZc5nef2I8HRxQU3TzL8e2563ajLtqtMGP4Ze8us7VrqN34RNRWmTc8rZFa3WoOSQsaFC0C1G6Fp5NU/c905rnViZoywIrK2TYB6766cJBMxHKvJ7gvHltJyx83bkQqJI02eTibifAMnnhvcXPBydVUdiJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZSBR7BL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697hUMh011405
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 08:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AEc/ZNFmxnMuleR9FhMEb0OULDquczMqvJCfIuUAe8U=; b=WZSBR7BLHEagmRl5
	rwWr0YWWaDnIhlQGDUzVVYTUESQ1ALhOfI8h+wBnANG2Atyh4CZQBk17oBrgZxtr
	bOYbddBy1A8xEFGQl/hZfpKsnet0m5TyggaSgRcI9BPg1RMy+72kZriYoRIEuaba
	/kKwLwa5DycQ2FLAOKndTf3+bpPMJ8QFrHbOZrzmWXM4LLx/G3VS29GtYBsAmBA8
	IaHFHqA8OVgel+o/Mjw2zCCB78uDZKzf+3/64FLCdBhRGke7Z0oABVWnLhd2YY10
	CUAfElFQzBdb6f46IpkNT8D8SPXKGSytf7aZhA0ju8mcjnlvueDLSc2s7mkOwTFF
	WwYQIg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9q04p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:32:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38ec062983so3534404a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049937; x=1752654737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEc/ZNFmxnMuleR9FhMEb0OULDquczMqvJCfIuUAe8U=;
        b=ZJJLGcZWNsy2+J6rCgiQF+PRlGg9XOmE6EZc7YPb7vFpaEwH7apQbNSSukFYA7YO3B
         P/ohtxJHY7OOJ3Aj9LCUe8LBA77lplXGn3TxHmIKyFd4+TncYSRfZJYAtP/YAQMInQHU
         Ln6bK7+ueg3EW6g9RwWWi6ti6kAV7z5hIZj+7Yh8m/N5coFfi1igQxR9yuPiXwJzjHxA
         bovrOoWeIHg9o3Rs+tT1cIi13nFhpDBrNbUqba/+cs6xKTouqZesg2U9LSqXPsPOaLbU
         qQ9TJYl9RTmnKgX3nHXADszP/Gj9kJ31hwEpt9z5UvzNY4xvlWEPHTfacIH1IOuR2nBz
         PiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0PgNmTFs5G2plXGcVIvkLI2RGKa7O9rRE3NiYrQcxvGWTeiblb+9d6wMP7M2CGJQuF7qovl14MpF/1sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IIH2td78D97HJu2dtZHOFv/XTs8s7O27GLcc0Ad1FAr0QApc
	hsbklEh5LIW0JtdKib1hinge7Olmtt863e/uEJbrjRoOEnUMvmm47tsHai9b1VrB+Xlsa/SQq6O
	BNjNY7xVX1QGVYEhv0XMdE8JIwWl76EVSerZB7HCnC3+ohJmUBHIAc3gJUVaWFOX48Ik=
X-Gm-Gg: ASbGncuXTN1jlnTAxOm6WwklCTLo5q5eQ/RJhvq/fZZb+o/l7BQjWqGhVzRMF24R7g6
	nror5KSC1PyeMlcpptltATyZiNBGQvhl/ZXnpHPGtccq2Bia66NKQjNW27NsMPCqGOCWV4w2Wrb
	HfITWcRe9/bRwJYYmEb9df8253zNyFlXKzhmGUeL1ao6GblYyb/4uvPSMWbGtRRRLaQNgZUUTh9
	SyYtlIZ+kbEqUoCvTvjLFg6vCSI6/Eu5ouG4Zn53+mFFPG/3D8EyOljDxqu0Z016hS2/DjT4qP+
	aEBk3aWx3KE0LnTTop4qM+5J72HC9kVjDAxh+SiLZJK8znk=
X-Received: by 2002:a05:6a21:9995:b0:225:7617:66ff with SMTP id adf61e73a8af0-22cd7487ecfmr2576728637.20.1752049937304;
        Wed, 09 Jul 2025 01:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF21ezKBzrGdz4BI6Lzw1JTE2T+1doJUN0UmTgSxYTC/KdMGVYc+82ZfcvVJicGxGSuhavU4Q==
X-Received: by 2002:a05:6a21:9995:b0:225:7617:66ff with SMTP id adf61e73a8af0-22cd7487ecfmr2576700637.20.1752049936822;
        Wed, 09 Jul 2025 01:32:16 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417dd7esm15183345b3a.97.2025.07.09.01.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 01:32:16 -0700 (PDT)
Message-ID: <803a7bea-68d6-4973-ad2a-0d8721865831@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 14:02:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: governor: Consider CPU latency tolerance from
 pm_domain_cpu_gov
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com>
 <CAPDyKFrL63Jv4_cUbrjAaU4UtNNDVMpALt41Mu6NbGcAefmWUA@mail.gmail.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAPDyKFrL63Jv4_cUbrjAaU4UtNNDVMpALt41Mu6NbGcAefmWUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ku6zeJz3ujbWzISID1339xIm3sQpDqBT
X-Proofpoint-ORIG-GUID: ku6zeJz3ujbWzISID1339xIm3sQpDqBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA3NSBTYWx0ZWRfXwDNbbA70YYFA
 PZqgjGuYSiGk2HmCcQtEBSbgDyS7TvSu/oF86zzbOjCY+PmhN+JU1RVkg5jWM7k6EQUfNhagjw7
 zYkOLYruwt7ArhtsqIQcxLjC8fcOBzB1JWK0ADy3+36Jux4kgwgZI1XgoMwtAiCMGMBjT2NYcBN
 9Kgu6cRkhuk/+nFPc4MwpiCVZNoIrs0YV21v9tceftp0X1GrSd1xmyAgpu1BsVAMXhFvL2l+974
 jKCeKBkZs9oTUXuBDdZ4oSbsHSzhTPmGbjHR5uS4ebIc1HYzsz6lI8SUDIGVIc8olgpIW3vPwWQ
 g4u+JfPS2PZ7A+13jckRR3IUIebcwaUL+CYsUzrM+OQ8J+0rOEqJShZgegYB0TZ9RykXMThW14g
 cWw3OPi86jm9pK0buGxEd8oQEOqqlspY3pB3EMM3NfAoJ3viA4o9Etj0i0/Dsb32GM8xdmg8
X-Authority-Analysis: v=2.4 cv=BM+zrEQG c=1 sm=1 tr=0 ts=686e2912 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=p3CtfcOl4c16AG3dCFcA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090075



On 7/8/2025 8:11 PM, Ulf Hansson wrote:
> On Tue, 8 Jul 2025 at 07:15, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>>
>>
>> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
>> index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..d5ac4c1b5b5a432f0072209d17379e58ec891202 100644
>> --- a/drivers/pmdomain/governor.c
>> +++ b/drivers/pmdomain/governor.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/pm_domain.h>
>>  #include <linux/pm_qos.h>
>>  #include <linux/hrtimer.h>
>> +#include <linux/cpu.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/ktime.h>
>> @@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>         struct cpuidle_device *dev;
>>         ktime_t domain_wakeup, next_hrtimer;
>>         ktime_t now = ktime_get();
>> +       struct device *device;
> 
> Nitpick: Maybe rename to "cpu_dev" to better distinguish between the
> cpuidle_device *dev, above?

Updated in v2.

> 
>> +       s64 cpu_constraint, global_constraint;
>>         s64 idle_duration_ns;
>>         int cpu, i;
>>
>> @@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>>                 return true;
>>
>> +       global_constraint = cpu_latency_qos_limit();
>>         /*
>>          * Find the next wakeup for any of the online CPUs within the PM domain
>>          * and its subdomains. Note, we only need the genpd->cpus, as it already
>> @@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>                         if (ktime_before(next_hrtimer, domain_wakeup))
>>                                 domain_wakeup = next_hrtimer;
>>                 }
>> +
>> +               device = get_cpu_device(cpu);
>> +               if (device) {
>> +                       cpu_constraint = dev_pm_qos_read_value(device, DEV_PM_QOS_RESUME_LATENCY);
> 
> We should be able to use dev_pm_qos_raw_resume_latency() here, similar
> to how cpuidle_governor_latency_req() does it. I think it's better as
> it avoids acquiring/releasing the spinlock.

Yes, updated to use dev_pm_qos_raw_resume_latency() in v2.

Thanks,
Maulik

