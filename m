Return-Path: <linux-kernel+bounces-868359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30657C0508F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC64FE316
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4A304BA0;
	Fri, 24 Oct 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUkslnkf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214812FC88C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294347; cv=none; b=CtYWGv3kOkI+VtoVWQ0APDeydKgma7Pt4lMSjVhPnnp8ivk2JUvmAwvc+4bdRvRfAawglq5ikqASQHdU15bi9siHyTTOTHC8rShsx1fWY/aJb3LqnxJOLShfYnT45aAWO5m4vnGmJ367nSo37SSdtHJyHFhBB1LNxsRqMulBqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294347; c=relaxed/simple;
	bh=E7zeYVVmFvhW1ndlkeDBNUjUXWjpEg18PRaOiWsdM74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf9gCjPMMAgWYJfM5UZqQ30C8zJMThOKSOaJXm6p5ghm5jy5lmmyrCU6bkXdw9LPjzi7pchxst3HBZOXPSsmAzN2IscA0SRbBbjjOW6pLcAH6B7Cn73KWxz9W9JcoMC1tPkvC0Fn0eCYp7czpKH5lEaswN4MG7xtwEcLrTLl0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUkslnkf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FXFi017764
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jdAXb6CKtoslz8rOMdweyKEHfUeOU56uL0LiJsSPWPI=; b=bUkslnkfZ+zKjWD3
	xEKasxWnyQDdsbf+ocktVoq0NM5SgjxNNtoW3p6a5gkXvTkncfJmXLQ8SCIHagLY
	68oeG6yWadr9FqUoqrwKPOPZNbKSoeEY6H0jpJTnCSNhLQzhi2FiITrTVtCYI5dt
	wix3ZERCsXDi1apjr2DDXyjtrOFDDUhYreJe4jmvKLqMp0s+nyB+1nj3PQRHdcwh
	8CfwDRUAKr2QTRSEjeHMw+tp3qalzkDE7HkRdBunj/b11J5o9JVNeYrbOZiaUns6
	qIfDRQOyIR/twoWVR2oa7Ux77Nxukcuqlqp1lEz7tr/0CBFK8aC71BSKFIGctApV
	7OeYrA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49yp6k2kbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:25:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1453702a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294343; x=1761899143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdAXb6CKtoslz8rOMdweyKEHfUeOU56uL0LiJsSPWPI=;
        b=Ka97E3HzelIiaKlwH29BWzSX03xzSBN6JqQ3HKysNRP3an9lRWjQGSB9MwrM/Jv8D7
         cEuAcRTGqGIV05WG/74lguUb8ZpJm4lWt+za0X1cXWtZes7PoaCcDjOuXm6bRJHkyxwE
         bdPiP4W/KIve+z9rzm8Tvrgkf9HLba8s53BclOtk5YAUXfVI/BPT431PTGv8yf/u6Yua
         a6Dki5cWgTVZkkdnX2N9Q2cJWCT9ROsVEnvnr7g3ksASzrBxdX4oslqLdUA73OZMH0KZ
         Menl/7q4WtLEljlkze6OgQ0MtiPzwuolhclYJHu1Km207WuX4XkkEvX6N6IH0PPIkg7J
         H78A==
X-Forwarded-Encrypted: i=1; AJvYcCUAbLCZKQhGQivTRGGZyODwf0r+hD+mLhDtMsxlfXoK4KPPIzfjEPUC8ex6GMfimXTDRZOACYxE1tUDsA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNtn+pAH1WZUFEs2QaE4eNkyjGIqFKWsjXkrxFcpXSNOsOjpi
	78trC2T10uxOJe3xKzMXUKHMO/T3I62YfutQdOXCbayL4hpxapPIo7WYp40eQJE/8YWHcJ/38Er
	EcAYs/LFV/uAjKMdk89sLMbHUXhoQeDWeNlcuAbFJA157XPkBE/Tu1h1Cs/aHab4PtF4=
X-Gm-Gg: ASbGnctgVKEEiPY7U6Hl6QXufgn7fVgH/YRB3zmjwdxiA63Rln+2M7C/gcSxv+eyfxG
	/7H2tul6uaukzDlghdaD/L8NvnwrVd7P2Epgsidmt1WOIBjGsccm+mGyiGhMr25hEwjIGi2ILeO
	IdWqgN62NOCzeslVrzH4XdAU0tYeZdvIsOtevyiMnYSf/oEVpvbB077JOzj3AYTSWSEqj9xbKj1
	9VdRMiGX6RIsP9VzgrzdqyTPwY4OTLyrdv25L+hwNh+P76JbBHENCe0cAETqT74NZ5Mwe3uWHN0
	jipQuwwGwugFOwWy0rVFekSxhXjTrVKQxeQRbiYEm7fj0niY285sMBa6yob606G0uNDyMHnE6RQ
	/0XasqJ9eQ7TtNsp5V/eWQzAPEEbRKgjkxq9gnRtkNCS6vGgKLl8Un0jAKDdXc8TnK6oaVac=
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-33bcf8f9960mr33488458a91.30.1761294343368;
        Fri, 24 Oct 2025 01:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYV/FCwYX9tS8U6kKBTVyor5rLjLfnnwea1GwR3xiBSD0YIK+MZz2x9FXtenrxqNSokfUdAQ==
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-33bcf8f9960mr33488435a91.30.1761294342896;
        Fri, 24 Oct 2025 01:25:42 -0700 (PDT)
Received: from [10.133.33.181] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37b0csm4989973a91.3.2025.10.24.01.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:25:42 -0700 (PDT)
Message-ID: <f1195632-d973-4339-a89d-e1e62b98015d@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 16:25:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: Lukasz Luba <lukasz.luba@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, christian.loehle@arm.com,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org, james.morse@arm.com,
        Dave.Martin@arm.com, reinette.chatre@intel.com, tony.luck@intel.com,
        pavel@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
 <eb9abe9d-3d12-4bf1-85da-deb38b8da321@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <eb9abe9d-3d12-4bf1-85da-deb38b8da321@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMSBTYWx0ZWRfX/1ryizUo2vDZ
 lmsy4GToJC3HIsWAyxiyvX7cgElzlXA92mfCV/+xcCXCTVuFQBRLS4N4Oii7DoAOnYzpBwmybiJ
 Ux40jfyoWlxDBJlEkpaZzAmD3Nm0XV8Oju7dZdc3XVGUQpaTM2hEh5S7GMWeOc6OqK/yj9PE3mZ
 uitPG0sNljjeI9asFhsYpnknZEdIsOYqbo3RBr67xj4LNZG1yIZcJ7FEKN2MLNAXtTxWiASgMGr
 DyK1hk0MYAyZRTAf28Pl6tcUy6QQ7K5u4jMHjTqX7vRjJ6gIlieTfPx+qI8BV1y4W1OnrtJq36Z
 i5E2mqu7+Yf8d2ObBY7jYamoV6JR1FjREPIUsWKPlWG04ZFuw7VvW1UiCE3VsUq3LMUlXLpNyZu
 xOHhL3QN++z9l8WTIeQM7SiRNrCwig==
X-Proofpoint-GUID: TwEAZUxAjfT0nNOs1QS1frJQMhWIzAGT
X-Authority-Analysis: v=2.4 cv=bL8b4f+Z c=1 sm=1 tr=0 ts=68fb3808 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bKoICc7jPwMaGVlQe5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: TwEAZUxAjfT0nNOs1QS1frJQMhWIzAGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230131

On 10/23/2025 9:09 PM, Lukasz Luba wrote:
> Hi Zhongqui,
> 
> My apologies for being a bit late with my comments...
> 
> On 7/21/25 13:40, Zhongqiu Han wrote:
>> Hi all,
>>
>> This patch series introduces support for CPU affinity-based latency
>> constraints in the PM QoS framework. The motivation is to allow
>> finer-grained power management by enabling latency QoS requests to target
>> specific CPUs, rather than applying system-wide constraints.
>>
>> The current PM QoS framework supports global and per-device CPU latency
>> constraints. However, in many real-world scenarios, such as IRQ affinity
>> or CPU-bound kernel threads, only a subset of CPUs are
>> performance-critical. Applying global constraints in such cases
>> unnecessarily prevents other CPUs from entering deeper C-states, leading
>> to increased power consumption.
>>
>> This series addresses that limitation by introducing a new interface that
>> allows latency constraints to be applied to a CPU mask. This is
>> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
>> embedded systems where power efficiency is critical for example:
>>
>>                          driver A       rt kthread B      module C
>>    CPU IDs (mask):         0-3              2-5              6-7
>>    target latency(us):     20               30               100
>>                            |                |                |
>>                            v                v                v
>>                            +---------------------------------+
>>                            |        PM  QoS  Framework       |
>>                            +---------------------------------+
>>                            |                |                |
>>                            v                v                v
>>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>>    runtime latency(us):   20             20, 30             100
>>
>> The current implementation includes only cpu_affinity_latency_qos_add()
>> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
>> planned for future submission, along with PM QoS optimizations in the UFS
>> subsystem.
>>
>> Patch1 introduces the core support for CPU affinity latency QoS in the PM
>> QoS framework.
>>
>> Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the global
>> CPU PM QoS interface. This change addresses issues in existing code 
>> and is
>> not related to the new interface introduced in this patch series.
>>
>> Patch3 adds documentation for the new interface.
>>
>> Patch4 fixes a minor documentation issue related to the return type of
>> cpu_latency_qos_request_active(). This change addresses issues in 
>> existing
>> doc and is not related to the new interface introduced in this patch
>> series.
>>
>> Patch5 updates the resctrl pseudo-locking logic to use the new CPU
>> affinity latency QoS helpers, improving clarity and consistency. The only
>> functional and beneficial change is that the new interface actively wakes
>> up CPUs whose latency QoS values have changed, ensuring the latency limit
>> takes effect immediately.
> 
> Could you describe a bit more the big picture of this proposed design,
> please?
> 
> Ideally with some graph of connected frameworks & drivers and how they
> are going to work together.

Hi Lukasz,
Thank you very much for your review and discussion~

I will describe you one big picture if needed, please allow me
illustrate a simple scenario using pseudo code first:

Suppose there is a USB driver. This driver uses the kernel existing
cpu_latency_qos_* interfaces to boost its IRQ execution efficiency. Its
IRQ affinity is set to core0 and core1 according to DTS config, and the
affinity of its threaded IRQ (bottom half) is also set to CPU0 and CPU1.


=================================================================
Using the kernel existing cpu_latency_qos_* interfaces:
=================================================================
static int dwc3_sample_probe(struct platform_device *pdev)
{
   cpu_latency_qos_add_request(&foo->pm_qos_req,DEFAULT_VALUE);
   xxxx;
   ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
   xxxx;
}

static irqreturn_t foo_dwc3_pwr_irq(int irq, void *dev)
{
   xxxx;
   cpu_latency_qos_update_request(&foo->pm_qos_req, 0);

   /*.... process interrupt ....*/

   cpu_latency_qos_update_request(&foo->pm_qos_req, DEFAULT_VALUE);

   return IRQ_HANDLED;

}


The number of IRQ executions on each CPU:
==================================================================
IRQ  HWIRQ   affinity CPU0    CPU1   CPU2 CPU3 CPU4 CPU5 CPU6 CPU7
320  0xb0    0x3      9782468 415472  0    0    0    0    0    0
==================================================================

==================================================================
Process: irq/320-dwc3, [affinity: 0x3]  cpu:1    pid:5250   ppid:2
==================================================================


 From the code, we can see that the USB module using the kernel existing
cpu_latency_qos_* interfaces sets the CPU latency to 0, which prevents
all CPUs from entering idle states—even C1. During operation, the USB
IRQs is triggered 9,782,468 times on CPU0, and each time it runs, all
CPUs are blocked from entering deeper C-states. However, only CPU0, CPU1
are actually involved in handling the IRQ and its threaded bottom half.
It will cause unnecessary power consumption on other CPUs.
(Please note, due to the simplicity of the pseudocode, I did not show
how the IRQ bottom-half thread is synchronized to restrict CPU idle
states via PM QoS. In reality, it's clear that we can also apply a CPU
latency limit to the bottom-half thread.)


If we use current patch series API cpu_affinity_latency_qos_xxx, such
as:

=================================================================
Using current patch series cpu_affinity_latency_qos_* interfaces:
=================================================================
static int dwc3_sample_probe(struct platform_device *pdev)
{
   cpu_affinity_latency_qos_add(&foo->pm_qos_req,DEFAULT_VALUE, mask);
   xxxx;
   ret = devm_request_threaded_irq(xxx,xxx,foo_dwc3_pwr_irq, ....)
   xxxx;
}

We can only constrain the CPU latency PM QoS on CPU0 and CPU1 in order
to save power.

> 
> E.g.:
> 1. what are the other components in the kernel which would use this
> feature?

1.Drivers such as Audio, USB, and UFS, which currently rely on the
kernel's global CPU Latency PM QoS interface, but only require latency
constraints on a subset of CPUs, can leverage this new interface to
achieve improved power efficiency.

2.I’m considering supporting this feature in userspace.
Once implemented, userspace threads—such as mobile gaming threads that
aim to constrain CPU latency and are already bound to big cores—will be
able to use the API to help save power.

> 2. is there also a user-space interface planned for it so a HAL in
> the middle-ware would configure these "short-wake-up-CPU"?

Yes, I am considering to support userspace on patch V3.

> 3. Is it possible to view/debug from the user-space which component
> requested this setting for some subsets of cpus?

I'm uncertain whether we should provide the ability to inspect
which components are applying constraints on CPU latency. However,
what I do want to ensure is that—similar to the existing /dev
cpu_dma_latency interface in the current kernel—I can offer per-CPU
level latency value setting and querying.



> 
> Regards,
> Lukasz
> 
> 


-- 
Thx and BRs,
Zhongqiu Han

