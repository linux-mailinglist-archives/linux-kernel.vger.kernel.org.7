Return-Path: <linux-kernel+bounces-879919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33922C24652
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF7C3A80E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0433E34D;
	Fri, 31 Oct 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emvsYM0r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HanSQ3Dh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491032E6B3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905802; cv=none; b=pyqRsLzEeqKGLlQobKR3bPoJNvFSXsvFi8uswOyxv67znfOUBEFR/nHnCrGsw3Pys5O8bftoRCVxr/swnUMLNy4kqjCux1KGIgaUmWQopo/mKQvVDYbJke0Dkf96oh9T42Ttn75D/Q0q8Hd8w+8YzBtaQSCY4oTv0VZSb94papk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905802; c=relaxed/simple;
	bh=I+zSPoBczYe6XLdH3auccJI4SUmw75/b6ug/ZEYJENQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nh7HRLTyrVXlB2qJ92iajGPzrpJeAyRxheOvSpY2Mnq8FXszUMgXY7BzZoF5D0eAG6tDa8SU5a66iCiO5d3QtpDOU7Takf16U37lzOIYis7Z18GY9cGXlyMeapYZJrsr7UBhUqHNo1KCPWWoxJ0kzXSIi2siTMg+CHhZgfECLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emvsYM0r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HanSQ3Dh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8kwXP898142
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7AmVPx9NLKfqh6ryD6Je8jO3b7sS17BtKacKLvRgo4=; b=emvsYM0rekoUKihI
	Sf+KrGGcXBitRQcZM34qVh/XhnaxcPoSqgsqZS0EhdY3yBKrsvxwx8Bme8a13swh
	p7bVVzXrEUeIhArvfOII+PO5t16/Tu7uW0NdlaNLwio3Y7/+O8xtLSHryPaBYu1Z
	Ne5ZHjNj5Ro279acPmYF1QCuucGEMP6Vo6a7WHAtoN/9shhmX+WqpYybJvPb6cJN
	HOwXSDYpBabwz0WMsFMrRUzkME35S0plaZxcjDEeOitMqLnEWCcNvja46DScO/r9
	4X3wJionQbZcWYiuhGjjpbyZT2rj5I0myiVfkni79bdyg+mXZ0DLZyZzRY1yJQXA
	EZ9Yhw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb21qhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:16:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so3547084a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761905799; x=1762510599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7AmVPx9NLKfqh6ryD6Je8jO3b7sS17BtKacKLvRgo4=;
        b=HanSQ3DhOshgU7roXcv4+5/BG5QBS0OybaV/6u3QtMjVmCdpc9l/YfGiDqrQDlA1cS
         xx68WD4jJVTu7yNZiUJC97BXDbYLpZ5uw49feBPnOw913CWlLlWz+ISoywDcs4j9YhxM
         Y6vwT4wih6hG4YQzo/B3KIE2Jfych+nSOVga0FL2qJY1LX+krEF+ovUgqx2bd4U0ngDE
         vQR5Wx/JDQC55t7d4SiaF1kRgchloXUK72pTnf1Hai42OWDWb1XftdcrpharKh3wQLCQ
         ZK4dMJNu0wYyTzeSrNexGiEc0Uh4KM3YulYruM5D8YYAElZJNJ7Rayl9eqcyqkCL6L2a
         Dsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905799; x=1762510599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7AmVPx9NLKfqh6ryD6Je8jO3b7sS17BtKacKLvRgo4=;
        b=uRWT1a4gWTvsC00UFsXhhif9kH48P1YkjWuWTOeecLDquuG8ZquuQZrcP9X9mlaTGx
         powQ3TpSQqlkqcWK2xOzV7TK4ZGAVQr3GI++GLKikuRBXy6g6/A44RP3MpK7YDgXwo1F
         SNLk02OsRMhFhka8429PiQ4ZRp5rhEpjZ5TCN9DVoqduThwR6wqvBwjRfNp/oNEcOYLI
         MrvS7ASIjY88VASTFDTcB/uSEFKXQFRx7E3zMj4a+++6wJNR3SchvQpeQhJCl/sbB0kp
         brvTyVawGsTDWe/5fxg0Q9sJCxG87TvQegId87cNG50H3ISzCVGnd5jojrcK3kOf8pkd
         B0Og==
X-Forwarded-Encrypted: i=1; AJvYcCXoBQ+EEvQeDNfjRNCJnu6FMtfLNRhKKxSYXWWzAF4+q/qMayczUu/96pRN41EhyUHVdfYG9N31Nfbarhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLW1xGX6sC+md1kbXoExZWLQ3foadX6hSLoMRx2aSLuDqAxIB
	iDpAifzL2Xv7TcKj8tJ2spV/JcBEQOEuaTMSJTv7KQ+kv4p+J6EXVbsAaG/dUfmVh0ELrgi6uI2
	4YMPlv6v9qN9Uz9WA9bzxnWbMgFyML1cbnFJEJbjqSxa5N5T9FBmpcuxF52VKQWdYlXE=
X-Gm-Gg: ASbGnctfY3Hw67LUQY6zQ7yhQ4EqxqgQkpuf6fGnvnll39XlFVfWTgxJbRQzu3jSYLz
	gd3WfaVbgV39MjB+tVTCgZyUD6Y+8s5AFHZb+7+mCUVTH3iLe7mbQ8TtcZ7UYYJX3cfbLzJgwm0
	9imO1fyuhhVlwY5fxpTECECnr5vYdp9zwB/+4ne3UHMUdy63yso890SU4I/fg9rt4UmXc8lpDsd
	jkKHb7WO+Yh1LTaSQlAo069dhEJ2f8xF6pvWemVCMIQ/oX1jDzbyU5Kwb0UaakLI8cQZXwhaeyN
	vttXiICARrfBqALz023q0snbFLv/pGXNiW+Nb2DE61nB/Ogtxc1XYplILvY47P8H41eLP4H7UcN
	oBzkwYlU+hDnulIvOXwT7Vl0mv+uiEBKYVytcOjbOggfmxjGhoXXdbqKY7sfC+0zHO6O7GJPu
X-Received: by 2002:a17:903:2309:b0:292:fc65:3579 with SMTP id d9443c01a7336-2951a38ba61mr46020395ad.17.1761905798528;
        Fri, 31 Oct 2025 03:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhyrMNxk7TEEv+lMeAguD4LuRDmTpvDlWzOcHMesO2Q8z0KGWvyZAJ3PLuo8kPjC8ZjNMAeA==
X-Received: by 2002:a17:903:2309:b0:292:fc65:3579 with SMTP id d9443c01a7336-2951a38ba61mr46020015ad.17.1761905797933;
        Fri, 31 Oct 2025 03:16:37 -0700 (PDT)
Received: from [10.133.33.16] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952774570bsm17662115ad.99.2025.10.31.03.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:16:37 -0700 (PDT)
Message-ID: <8c461b2e-7057-4974-bfd4-7215ec2855f1@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 18:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] coresight: Add CPU cluster funnel/replicator/tmc
 support
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, kernel@oss.qualcomm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
 <CAJ9a7VipQh=y0o+6k=fLMMK408E5eGD6vhY2TKBMm+q63NUiWA@mail.gmail.com>
 <7451a3ae-2b3f-4e07-b93c-0507436d0f33@oss.qualcomm.com>
 <CAJ9a7VgxpQ5gTXpaW5pBb+dpZZhXAkrOtxkkiK-KUmvipPm5UQ@mail.gmail.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VgxpQ5gTXpaW5pBb+dpZZhXAkrOtxkkiK-KUmvipPm5UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=69048c87 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=V5Ko9na6anHKu0iFrcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MiBTYWx0ZWRfXzHuz1UNnIm/Q
 E8D+bRCHdrICj0zz/r9uoYsoUM6m8YC0rOeSLnh5jfnXXx1hhzbE0x3lZlNP2tniWy44unUJuul
 srLO/YgxcrLOOOMqt8qDtqjDNeWx13Zes3CgEktV6UvtMN/sFpUTmRyiYJvgC9BUkljxW5BgxW/
 yRxupoIANmZuAsRJxu7abBPp0EL17DXsMD2ZkcaptltwJB+bNwlmItoSPPV7NmL7da827BjSJGS
 SXYuL3V7PhGwRjIkegtFjsXScRFX4JQCoYU1N9yESmEewPGV1Fh8gAiRw4OPN/GeCXMooGEoWP1
 K3hIw/RJCM7DgBzD5TvFUidsOf1DHiIpPYWG9r4JZ7aNGefAB3qZjKe0bERZZrUStOasaESbFM5
 AZFMAXaKO3qTy4K+gVqUEwNwpMCvpw==
X-Proofpoint-GUID: 3Tk07uDIiYW6t8JjynPooqwR-ecIS0cc
X-Proofpoint-ORIG-GUID: 3Tk07uDIiYW6t8JjynPooqwR-ecIS0cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310092



On 10/30/2025 5:58 PM, Mike Leach wrote:
> Hi,
> 
> On Thu, 30 Oct 2025 at 07:51, yuanfang zhang
> <yuanfang.zhang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/29/2025 7:01 PM, Mike Leach wrote:
>>> Hi,
>>>
>>> This entire set seems to initially check the generic power domain for
>>> a list of associated CPUs, then check CPU state for all other
>>> operations.
>>>
>>> Why not simply use the generic power domain state itself, along with
>>> the power up / down notifiers to determine if the registers are safe
>>> to access? If the genpd is powered up then the registers must be safe
>>> to access?
>>>
>>> Regards
>>>
>>> Mike
>>>
>>
>> Hi Mike,
>>
>> Hi,
>>
>> yes, when genpd is powered up then register can be accessed. but have blow problems:
>>
> 
> The point I was making is to use genpd / notifications for determine
> if the device is powered so you know if it is safe to use registers.
> This is different from the faults you mention below in your power
> infrastructure.
> You are reading the dev->pm_domain to extract the cpu map then the
> notfiers and state must also be available. If you could use CPUHP
> notifiers then genpd notifiers would also work.
> However, one issue I do see with this is that there is no code added
> to the driver to associate the dev with the pm_domain which would
> normally be there so I am unclear how this actually works.
> 

Device power domain attach is operation on bus leave code. using smp caller
can wake up the cluster power, and pm_runtime_sync can block cluster power down.
this approach ensures cluster power on after enable.

Power management is operation at cpu source code. when cpu enter LPM, cpu lpm notifier of 
per-cpu source will disable the path and source, disable path will call pm_runtime_put,
after call pm_runtime_put, the cluster can power down. For CPUHP, there is same logic.

Leo's patchs already complete above power management.
https://lore.kernel.org/all/20250915-arm_coresight_power_management_fix-v3-14-ea49e91124ec@arm.com/ 
https://lore.kernel.org/all/20250915-arm_coresight_power_management_fix-v3-31-ea49e91124ec@arm.com/


> Associating a none CPU device with a bunch of CPUs does not seem
> correct. You are altering a generic coresight driver to solve a
> specific platform problem, when other solutions should be used.
> 
sometimes chip configuration will be quite different, that is there will be
a single cluseter / genpd having ALL cpus in it, but those CPUs may be powered
by different CPU rails, so check with CPU makes more sense.

>> 1. pm_runtime_sync can trigger cluster power domian power up notifier but not really
>> power up the cluster, and not able to distinguish whether it is a real power up notifier
>> or triggered by pm_runtime_sync.
>> 2. Using the power up/down notifier cannot actively wake up the cluster power,
>> which results in the components related to this cluster failing to be enabled when the cluster
>> power off.
>> 3. Using the power up/down notifier for register access does not guarantee
>> the correct path enablement sequence.
>>
> 
> Does all this not simply mean that you need to fix your power
> management drivers / configuration so that it works correctly, rather
> than create a poor workaround in unrelated drivers such as the
> coresight devices?
> 

Runtime PM for CPU devices works little different, it is mostly used to manage
hierarchical CPU topology (PSCI OSI mode) to talk with genpd framework to manage
the last CPU handling in cluster.
It doesn’t really send IPI to wakeup CPU device (It don’t have .power_on/.power_off)
callback implemented which gets invoked from .runtime_resume callback.

this part are all upstream code.

thanks,
yuanfang.

> Thanks and  Regards
> 
> 
> 
> Mike
> 
>> thanks,
>> yuanfang
>>
>>> On Tue, 28 Oct 2025 at 06:28, Yuanfang Zhang
>>> <yuanfang.zhang@oss.qualcomm.com> wrote:
>>>>
>>>> This patch series introduces support for CPU cluster local CoreSight components,
>>>> including funnel, replicator, and TMC, which reside inside CPU cluster
>>>> power domains. These components require special handling due to power
>>>> domain constraints.
>>>>
>>>> Unlike system-level CoreSight devices, CPU cluster local components share the
>>>> power domain of the CPU cluster. When the cluster enters low-power mode (LPM),
>>>> the registers of these components become inaccessible. Importantly, `pm_runtime_get`
>>>> calls alone are insufficient to bring the CPU cluster out of LPM, making
>>>> standard register access unreliable in such cases.
>>>>
>>>> To address this, the series introduces:
>>>> - Device tree bindings for CPU cluster local funnel, replicator, and TMC.
>>>> - Introduce a cpumask to record the CPUs belonging to the cluster where the
>>>>   cpu cluster local component resides.
>>>> - Safe register access via smp_call_function_single() on CPUs within the
>>>>   associated cpumask, ensuring the cluster is power-resident during access.
>>>> - Delayed probe support for CPU cluster local components when all CPUs of
>>>>   this CPU cluster are offline, re-probe the component when any CPU in the
>>>>   cluster comes online.
>>>> - Introduce `cs_mode` to link enable interfaces to avoid the use
>>>>   smp_call_function_single() under perf mode.
>>>>
>>>> Patch summary:
>>>> Patch 1: Adds device tree bindings for CPU cluster funnel/replicator/TMC devices.
>>>> Patches 2–3: Add support for CPU cluster funnel.
>>>> Patches 4-6: Add support for CPU cluster replicator.
>>>> Patches 7-10: Add support for CPU cluster TMC.
>>>> Patch 11: Add 'cs_mode' to link enable functions.
>>>> Patches 12-13: Add Coresight nodes for APSS debug block for x1e80100 and
>>>> fix build issue.
>>>>
>>>> Verification:
>>>>
>>>> This series has been verified on sm8750.
>>>>
>>>> Test steps for delay probe:
>>>>
>>>> 1. limit the system to enable at most 6 CPU cores during boot.
>>>> 2. echo 1 >/sys/bus/cpu/devices/cpu6/online.
>>>> 3. check whether ETM6 and ETM7 have been probed.
>>>>
>>>> Test steps for sysfs mode:
>>>>
>>>> echo 1 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
>>>> echo 1 >/sys/bus/coresight/devices/etm0/enable_source
>>>> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
>>>> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
>>>> echo 0 >/sys/bus/coresight/devicse/etm6/enable_source
>>>> echo 0 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
>>>>
>>>> echo 1 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
>>>> echo 1 >/sys/bus/coresight/devcies/etm0/enable_source
>>>> cat /dev/tmc_etf1 >/tmp/etf1.bin
>>>> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
>>>> echo 0 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
>>>>
>>>> echo 1 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
>>>> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
>>>> cat /dev/tmc_etf2 >/tmp/etf2.bin
>>>> echo 0 >/sys/bus/coresight/devices/etm6/enable_source
>>>> echo 0 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
>>>>
>>>> Test steps for sysfs node:
>>>>
>>>> cat /sys/bus/coresight/devices/tmc_etf*/mgmt/*
>>>>
>>>> cat /sys/bus/coresight/devices/funnel*/funnel_ctrl
>>>>
>>>> cat /sys/bus/coresight/devices/replicator*/mgmt/*
>>>>
>>>> Test steps for perf mode:
>>>>
>>>> perf record -a -e cs_etm//k -- sleep 5
>>>>
>>>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>>>> ---
>>>> Yuanfang Zhang (12):
>>>>       dt-bindings: arm: coresight: Add cpu cluster tmc/funnel/replicator support
>>>>       coresight-funnel: Add support for CPU cluster funnel
>>>>       coresight-funnel: Handle delay probe for CPU cluster funnel
>>>>       coresight-replicator: Add support for CPU cluster replicator
>>>>       coresight-replicator: Handle delayed probe for CPU cluster replicator
>>>>       coresight-replicator: Update mgmt_attrs for CPU cluster replicator compatibility
>>>>       coresight-tmc: Add support for CPU cluster ETF and refactor probe flow
>>>>       coresight-tmc-etf: Refactor enable function for CPU cluster ETF support
>>>>       coresight-tmc: Update tmc_mgmt_attrs for CPU cluster TMC compatibility
>>>>       coresight-tmc: Handle delayed probe for CPU cluster TMC
>>>>       coresight: add 'cs_mode' to link enable functions
>>>>       arm64: dts: qcom: x1e80100: add Coresight nodes for APSS debug block
>>>>
>>>>  .../bindings/arm/arm,coresight-dynamic-funnel.yaml |  23 +-
>>>>  .../arm/arm,coresight-dynamic-replicator.yaml      |  22 +-
>>>>  .../devicetree/bindings/arm/arm,coresight-tmc.yaml |  22 +-
>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 885 +++++++++++++++++++++
>>>>  arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  12 +
>>>>  drivers/hwtracing/coresight/coresight-core.c       |   7 +-
>>>>  drivers/hwtracing/coresight/coresight-funnel.c     | 260 +++++-
>>>>  drivers/hwtracing/coresight/coresight-replicator.c | 343 +++++++-
>>>>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 396 +++++++--
>>>>  drivers/hwtracing/coresight/coresight-tmc-etf.c    | 105 ++-
>>>>  drivers/hwtracing/coresight/coresight-tmc.h        |  10 +
>>>>  drivers/hwtracing/coresight/coresight-tnoc.c       |   3 +-
>>>>  drivers/hwtracing/coresight/coresight-tpda.c       |   3 +-
>>>>  include/linux/coresight.h                          |   3 +-
>>>>  14 files changed, 1912 insertions(+), 182 deletions(-)
>>>> ---
>>>> base-commit: 01f96b812526a2c8dcd5c0e510dda37e09ec8bcd
>>>> change-id: 20251016-cpu_cluster_component_pm-ce518f510433
>>>>
>>>> Best regards,
>>>> --
>>>> Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>>>>
>>>
>>>
>>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK


