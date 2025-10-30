Return-Path: <linux-kernel+bounces-877739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9321C1EE64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C2B3ACD24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86D2F5A1E;
	Thu, 30 Oct 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyx8e05W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ey37S8po"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6117AE11
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811408; cv=none; b=aITSzrfp/D44rEKcD9mlQ/d5laOiLEcNI1nPmt8A0jE6oGLz7TjwHC7IZ7BXPHYSbeftKE7WeVp8sSYfmoNxdQIs58Dsm0h+XkcqFGXyau3B2GE4tV9n6ST3l1yBCQkg3P6NFUVpzrHR//i52HM0LfAvnDtqTH5oV+xwYGgIwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811408; c=relaxed/simple;
	bh=FfnDB75K6otOIxPpYHozJdUXlGSkBVYM5hSC39+0SoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mghO06z2QgxzxQmH7ieOJ8csDWMTGBs0mYQouar5LWOQ29vE0gMsZ6gnbuqyERgTM3LqIpA9RolOPAG2HHTATvHjoi4US+vYB28RQZWwxruUmC+dcQdGafcsBVNE4uGyP9bgnCk8kEQRbOTmbXCAgs+eZgnE39ifTZ9mvTJGPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyx8e05W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ey37S8po; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U0iK2w1994518
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcncODsbtT/7GjIUkjz2LRYFmMcQthooEGiM4DSrffA=; b=cyx8e05WnxRBwgfw
	exRBlP5QlJ1O6c9fi0iOiLb9tvTW2Mf324u44AQqJKols4lewipUG4fATOi9y6Gl
	4an5GeAmZoCVtib3H8aM7zsvVC79I0lYKjaM4JlOEMCjnq81vRVrEfr6jT9LoLig
	1CXEsRJlCE4sTdYUygslR3tQVrc4Dn6gK1SF309zmrw9vivZWiBh+kVrgiaJDOTP
	0mxOeGTgD2kQVFCUZSILqJBPP9pWTIdFcV5bJwqM1edOB9Cebd7m686nRrHG4HLD
	DRH+7uzrrRO7j9kLXi8lkPmLEyB5uf8xlAegTDNdy6OH+s8ACD9IsMYxx8ySd/qf
	L+OuLw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr7110s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:03:25 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c52c6ddeb4so2433945a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761811405; x=1762416205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcncODsbtT/7GjIUkjz2LRYFmMcQthooEGiM4DSrffA=;
        b=ey37S8poTiuwRrZFVoa7oSb3bv+2IO3jFzgRoenvGHhKtMYHN4E9bovBfx/ptr6Evq
         JtobYh2iLK0J44B7WsMIxDuikA8Zq/3tzeeBRhfeFHyc+yvg5N0QnsyIMkY3QNSLpvcm
         H7Zn9BHjFcGdwH6pslGIWy37xbC7KBCQayCwjmcgljQbJHh9wk2asMf78BuHlGK8cXtw
         V4W+58aeVlUvzxClCYYtEjr/1PE1QFPVleozjVFIJ3LUR425GAV2tSf/NUvsrXApR8oQ
         B/NgUDwlBvjhs1MnEp7EHigAGDgbgdef1Ekx7Y6PlsZz/lAlsi8a2p+Ce1ij2A0pksA4
         Uw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811405; x=1762416205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcncODsbtT/7GjIUkjz2LRYFmMcQthooEGiM4DSrffA=;
        b=iy5HubMsWbwxbSF93QBxhl6hE/2QeI9LLhjk5FixNovrb9aEm9D42O0vzfQZaJbOb8
         k3AJ6JdovJsWaPmtD9nL8zh470swxagE0qc6rFUn2oFDJwQ14G4FYtkaH6v6xxVou4GO
         3Axsy94+NfJGcIUdL4TGOCOBl0hapZ6cY3lstXtMdOw1gNep9T47kDfSqWC7Ru0Uif8f
         N+PDXGDDvgzc6aGzSYiqRXCDOCMXO+XXwXNJ3DCOtJIC3MJ6RWfS8s7oRE5spL/8acJh
         Lo/Igi0S1l/cSwTOY7ryhcqnBku1KqUigHVEUbM4HWT0ac/XZPr/l7WqFBfG5tp/ifOW
         bcsw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ06oijWj3cyFgsXwy50EfV7UaOPIoWIJFQvNvBwW4siimiYZddZXArUXFSCdUM6MC8I16D73WMl9rURg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhCy6ncknj5qdaAqkkvM+Xo4eKuKEK97Y1wxT+HBpiuhmHaXG
	7QCI+x43Oqe1SGHWEcFDZg0V3lqahUM5Uzza6uj0D5CanHnclBMd4lV5q8XNn37Krc1BueJm10A
	wKi36ytKpS+J17N2I4v/U3ZtidSDRcWjM1zDGg+3qO27PPrpzw6V3cEJULhshJbKU+FU=
X-Gm-Gg: ASbGnctGl4WTp2CPSRjGnXf3Yd/xkS+1w10MBeEIdyCh+i0tifpVvcn95LpHUAZGdu3
	+aLm50htMJoeIcCr1YAkn5rvfVi7nHRvT//ilWVOecXtsOe21lhBmlYVX3zBC9+n6ysWnuOLs/1
	QINcYzGoq28yQo2XHglT/lv0Izt9QigTbZWx9+UHdzPYsnZfcAItnTvY1AsNb6ycgGp4OGOhugu
	I9jdwc89BkIko+D2OOZYAa/1fnUHHT0YZmjcHVIa+i+n28izeu41/QELbNCu6JUTpszQ3zBtAaK
	ehgSMAE76AwZ0z0UNSPcEg17+9xkhM7KCZZVC3z9oqy9klukqFQUm7gpxkvqLbAoEkvEf54URmn
	MyGsRQCGcnk4cmca0sMgJgdtF6Y3eHTUEZ1FYGqAy7TUW/Crdc0wnXGd/0aWf7YqhWll67JmyIg
	==
X-Received: by 2002:a17:90b:2d47:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-3404ac69f33mr2679916a91.13.1761810712591;
        Thu, 30 Oct 2025 00:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzKJe1UiPLX/c5XJWRrXE7vIIVW3HA3Z3R5jK4wS0osT1fw6s5ES3OfZ7Gi+U6xWT5LUGFvQ==
X-Received: by 2002:a17:90b:2d47:b0:32d:e027:9b26 with SMTP id 98e67ed59e1d1-3404ac69f33mr2679880a91.13.1761810711983;
        Thu, 30 Oct 2025 00:51:51 -0700 (PDT)
Received: from [10.133.33.133] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050980cd2sm1614729a91.3.2025.10.30.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:51:51 -0700 (PDT)
Message-ID: <7451a3ae-2b3f-4e07-b93c-0507436d0f33@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 15:51:46 +0800
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
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <CAJ9a7VipQh=y0o+6k=fLMMK408E5eGD6vhY2TKBMm+q63NUiWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2NCBTYWx0ZWRfX3Agmc10gTxTj
 gzi2c8yrtZ4PVRo9IDRJ5fzKmsMEHWAbAqGE2R6NE+PALzC1lA8hrblwdwOl3V2+ckKeV16thTL
 Z4YQWRV2wxNZOUlTXZSpthyHVQutx5Dow6SOPXazhJKRFll/cX6ONL8IRjIhfuWNh056+EOGGfN
 KqU9zA/IyMFB2vkYuVigLH8pjrU17RNiqmdFniY7F58srzTdKqmksQhih/H29//RDgOd83cDULg
 xgkANnJIZDpsUQfjuJNQOXbrAv8DiUA5oltg9fjc8GO8t+a3vYoHTAdPtMlxWSP2ym+CXH1QDAk
 mqKCqx49nwmnqEvTpsokfigDvK1oK4jPNjIC5EqL1VzvVRjl/YvPmkdFGNR7e6nTqdNE5Z1poe1
 EoO2MjQGVFmImZt5IkKv4UYusK5a+A==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=69031bcd cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2kWKyKxqX19wIr5gW_MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: Ja2Bb-NJt8k6MuNAeN_LrnPXkjJIpGHL
X-Proofpoint-GUID: Ja2Bb-NJt8k6MuNAeN_LrnPXkjJIpGHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300064



On 10/29/2025 7:01 PM, Mike Leach wrote:
> Hi,
> 
> This entire set seems to initially check the generic power domain for
> a list of associated CPUs, then check CPU state for all other
> operations.
> 
> Why not simply use the generic power domain state itself, along with
> the power up / down notifiers to determine if the registers are safe
> to access? If the genpd is powered up then the registers must be safe
> to access?
> 
> Regards
> 
> Mike
> 

Hi Mike,

Hi,

yes, when genpd is powered up then register can be accessed. but have blow problems:

1. pm_runtime_sync can trigger cluster power domian power up notifier but not really
power up the cluster, and not able to distinguish whether it is a real power up notifier
or triggered by pm_runtime_sync.
2. Using the power up/down notifier cannot actively wake up the cluster power,
which results in the components related to this cluster failing to be enabled when the cluster
power off.
3. Using the power up/down notifier for register access does not guarantee
the correct path enablement sequence.

thanks,
yuanfang

> On Tue, 28 Oct 2025 at 06:28, Yuanfang Zhang
> <yuanfang.zhang@oss.qualcomm.com> wrote:
>>
>> This patch series introduces support for CPU cluster local CoreSight components,
>> including funnel, replicator, and TMC, which reside inside CPU cluster
>> power domains. These components require special handling due to power
>> domain constraints.
>>
>> Unlike system-level CoreSight devices, CPU cluster local components share the
>> power domain of the CPU cluster. When the cluster enters low-power mode (LPM),
>> the registers of these components become inaccessible. Importantly, `pm_runtime_get`
>> calls alone are insufficient to bring the CPU cluster out of LPM, making
>> standard register access unreliable in such cases.
>>
>> To address this, the series introduces:
>> - Device tree bindings for CPU cluster local funnel, replicator, and TMC.
>> - Introduce a cpumask to record the CPUs belonging to the cluster where the
>>   cpu cluster local component resides.
>> - Safe register access via smp_call_function_single() on CPUs within the
>>   associated cpumask, ensuring the cluster is power-resident during access.
>> - Delayed probe support for CPU cluster local components when all CPUs of
>>   this CPU cluster are offline, re-probe the component when any CPU in the
>>   cluster comes online.
>> - Introduce `cs_mode` to link enable interfaces to avoid the use
>>   smp_call_function_single() under perf mode.
>>
>> Patch summary:
>> Patch 1: Adds device tree bindings for CPU cluster funnel/replicator/TMC devices.
>> Patches 2–3: Add support for CPU cluster funnel.
>> Patches 4-6: Add support for CPU cluster replicator.
>> Patches 7-10: Add support for CPU cluster TMC.
>> Patch 11: Add 'cs_mode' to link enable functions.
>> Patches 12-13: Add Coresight nodes for APSS debug block for x1e80100 and
>> fix build issue.
>>
>> Verification:
>>
>> This series has been verified on sm8750.
>>
>> Test steps for delay probe:
>>
>> 1. limit the system to enable at most 6 CPU cores during boot.
>> 2. echo 1 >/sys/bus/cpu/devices/cpu6/online.
>> 3. check whether ETM6 and ETM7 have been probed.
>>
>> Test steps for sysfs mode:
>>
>> echo 1 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
>> echo 1 >/sys/bus/coresight/devices/etm0/enable_source
>> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
>> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
>> echo 0 >/sys/bus/coresight/devicse/etm6/enable_source
>> echo 0 >/sys/bus/coresight/devices/tmc_etf0/enable_sink
>>
>> echo 1 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
>> echo 1 >/sys/bus/coresight/devcies/etm0/enable_source
>> cat /dev/tmc_etf1 >/tmp/etf1.bin
>> echo 0 >/sys/bus/coresight/devices/etm0/enable_source
>> echo 0 >/sys/bus/coresight/devices/tmc_etf1/enable_sink
>>
>> echo 1 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
>> echo 1 >/sys/bus/coresight/devices/etm6/enable_source
>> cat /dev/tmc_etf2 >/tmp/etf2.bin
>> echo 0 >/sys/bus/coresight/devices/etm6/enable_source
>> echo 0 >/sys/bus/coresight/devices/tmc_etf2/enable_sink
>>
>> Test steps for sysfs node:
>>
>> cat /sys/bus/coresight/devices/tmc_etf*/mgmt/*
>>
>> cat /sys/bus/coresight/devices/funnel*/funnel_ctrl
>>
>> cat /sys/bus/coresight/devices/replicator*/mgmt/*
>>
>> Test steps for perf mode:
>>
>> perf record -a -e cs_etm//k -- sleep 5
>>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>> Yuanfang Zhang (12):
>>       dt-bindings: arm: coresight: Add cpu cluster tmc/funnel/replicator support
>>       coresight-funnel: Add support for CPU cluster funnel
>>       coresight-funnel: Handle delay probe for CPU cluster funnel
>>       coresight-replicator: Add support for CPU cluster replicator
>>       coresight-replicator: Handle delayed probe for CPU cluster replicator
>>       coresight-replicator: Update mgmt_attrs for CPU cluster replicator compatibility
>>       coresight-tmc: Add support for CPU cluster ETF and refactor probe flow
>>       coresight-tmc-etf: Refactor enable function for CPU cluster ETF support
>>       coresight-tmc: Update tmc_mgmt_attrs for CPU cluster TMC compatibility
>>       coresight-tmc: Handle delayed probe for CPU cluster TMC
>>       coresight: add 'cs_mode' to link enable functions
>>       arm64: dts: qcom: x1e80100: add Coresight nodes for APSS debug block
>>
>>  .../bindings/arm/arm,coresight-dynamic-funnel.yaml |  23 +-
>>  .../arm/arm,coresight-dynamic-replicator.yaml      |  22 +-
>>  .../devicetree/bindings/arm/arm,coresight-tmc.yaml |  22 +-
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 885 +++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/x1p42100.dtsi             |  12 +
>>  drivers/hwtracing/coresight/coresight-core.c       |   7 +-
>>  drivers/hwtracing/coresight/coresight-funnel.c     | 260 +++++-
>>  drivers/hwtracing/coresight/coresight-replicator.c | 343 +++++++-
>>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 396 +++++++--
>>  drivers/hwtracing/coresight/coresight-tmc-etf.c    | 105 ++-
>>  drivers/hwtracing/coresight/coresight-tmc.h        |  10 +
>>  drivers/hwtracing/coresight/coresight-tnoc.c       |   3 +-
>>  drivers/hwtracing/coresight/coresight-tpda.c       |   3 +-
>>  include/linux/coresight.h                          |   3 +-
>>  14 files changed, 1912 insertions(+), 182 deletions(-)
>> ---
>> base-commit: 01f96b812526a2c8dcd5c0e510dda37e09ec8bcd
>> change-id: 20251016-cpu_cluster_component_pm-ce518f510433
>>
>> Best regards,
>> --
>> Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>>
> 
> 


