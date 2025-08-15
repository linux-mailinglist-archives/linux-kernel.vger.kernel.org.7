Return-Path: <linux-kernel+bounces-770712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1E7B27E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078E317F29D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFC279DC4;
	Fri, 15 Aug 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uz8acyX0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286CDBA3F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253113; cv=none; b=nQ4UMDutC9pXqeFChUqdAGImnY4TYDVTAlIfH+x2x6gzz0a8V/6SozJ38dLJtmNHd+1SRtXgYQCJBbUVaALBJfCWDrSdvW/uXo7F0+x4FhHRkIIb3Gf9Dp7ksLnYDz+34gWtJjEAlybRYLRJGe8h3RgB8tww3jDPyXZdlaMWMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253113; c=relaxed/simple;
	bh=GvGtAivNt6lNuAkWYyJNjHOOxDdbe3Szepvv+eX90s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPhiBfrvB7UAGzbflD+ApzVkUdQRw+OrxA/nZVkQkSa+4LJLo04oCCCCQKCZingIWwybb+aqVElnRrlQER8HW+8ZyWcJvfecF5FEXT/4CpDLHAR93Qx7e1wiDT1CAyQFnW6Cro9pee+ndFd/0Sh4d25gSCcxSehw1Pl/zcQgp/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uz8acyX0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9limT023922
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nkcN9xNp+sxK8SUydyYfA1YJAO6QcCBGUaMWWTlm45k=; b=Uz8acyX0ZDHgiAD5
	9ULv2krDRPsJ5BvE8S6bLmBeN89i35K+1pckjumiQG6qEGkkZlaDS9Wok8Hyq3cH
	ECofX26Wf50YNxhKubTnNX31CFlgs/a213OPJmoTdRwu2rKgt4dLz9K0s382kzcz
	ZNeEoH04RwstAXlO1CoGopaFSga4oLUlv726wm+27bMD7CU4xBdsUzubRCSMk5VM
	6Dg7D/guwm7BZgxHdZmFGC1BENnP3SjTf0psxtZFtSKRL4e2ZUkEA+RzUAEJswUx
	p7cVERkrwLADqucqyTX9aj+nrnvn8OG3Qg9X3RF9Gz0qfNW/6cKTpChIIezma3/K
	T0vRZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbp00n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:18:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581187c6so21486425ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755253110; x=1755857910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkcN9xNp+sxK8SUydyYfA1YJAO6QcCBGUaMWWTlm45k=;
        b=g/UPQz5FHalEc95olod8VJlZ4XlFd10RrqbPa10wmKrdYh0I1Yq4DIgwa1/4ROmWz+
         wwB7bZvl7OCKDTAHPexcrgE0ok4zmesZZZseiETw4hcGoCKmW7Q/Rd1qXGsGT6XZW8hR
         b5OYSBdKOAMhdEYppDM6Ix3I/+BJ3Tq38l/dUbpcqK5tGi/eP32OeVzcbmNS+IL2SQSw
         Ez3zd2pDGOZnhlorsvf+Vl2OwHkHmfgxlJXBqxH982mriKO4gvMKD+GF25piY0wWIE8L
         NW9AC3/mwo8O28e0sSylQdpMpQwvAxFTbeh/NQRWwakeyRcGmLBgNMu6HI0jMVx74pL7
         EVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX90PNkIkAWFMwQhX6AeNZ35OO5j6dDQmHOlkXpm3wBRoRIWxtTFx+j6macxQJ1P7So8+j/EVSpVN4jPcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNJ9o5WYLuADwL7lTZ+sn4laia06KrwvWK4ZhtdysDgTtKcpv
	uiZuFxDLykuhA7+bN6DZP+wUhLGr3ppDEWMhE+dNZ3fU99w87DutOViTET74b+8E5uT9VWXOwXP
	bGUHMv2xtqBMTF7TQU+WX2ggE3nD2g7+O5CTIxkthOqmoK8C4CZR4m1HJa5SjS0kukl0=
X-Gm-Gg: ASbGncuQKzbOlJQqsOQlF61Dx0FZfyA7XhJDpTslZQzd1+65fyPSEdNiEpl8Oj50Z/3
	AOxSXBYgnIN6+ZTL4E6jBCzlOsXL0/Y9+ECBWoo65WJ9CyluM7ZxD6t8y2ZSiqG4Wm5bdY4Zrf7
	TtjQ7Fc5G1wKARS1HoWHg+eWmMo5WWur2d5GCD/LxL6stnMO6dfRmGH4Ug8xUlA3n41OF4gCii/
	8gVovrsHhZcL35YVCv6Edw+RyKWQ+wiHkmobUVR48y0ZLxxESTRE8y22rIAEdAf0HynTUzmhLCB
	NtMfOQsu+dBivwcfr5N/N9vGHZsxLAc3BkHz/tO7w1A3p7i4RBq/EOXZM7S1kdwtgv+K9WhfUwR
	mg34UC3Hgk0E8PeuRP6SGYIPR8N+HZg==
X-Received: by 2002:a17:902:e802:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-2446d72c7ddmr25484285ad.22.1755253110316;
        Fri, 15 Aug 2025 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLGSVA4oboqCPDlxlxV8Rz6meLx7vGhc5Ltsz1YKdMnJIkDwXWAhPp0AD9SXUCbA0Em9aS9w==
X-Received: by 2002:a17:902:e802:b0:23e:3bdf:e3bd with SMTP id d9443c01a7336-2446d72c7ddmr25483875ad.22.1755253109788;
        Fri, 15 Aug 2025 03:18:29 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d552945sm10799465ad.139.2025.08.15.03.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:18:29 -0700 (PDT)
Message-ID: <4813cd95-a176-4f2c-b45e-2b83e2e5d533@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 18:18:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Save cpu id locally to avoid repeated
 smp_processor_id() calls
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250814140141.2655087-1-zhongqiu.han@oss.qualcomm.com>
 <20250814142641.GX4067720@noisy.programming.kicks-ass.net>
 <9b69aa55-997d-498d-ba9e-fd20e7fca5dc@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <9b69aa55-997d-498d-ba9e-fd20e7fca5dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689f0977 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WYi-qWocwg_FbHcLqzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX1uSazMljY14b
 TsbxC2w25zPR+n1taZDmsUSXzIAiudEir5L46K1hgjdZetQ2K9iOB35mF5FAPaJmdezXMTSOnFn
 ro0orvza+czJxERA9F1tNyv8Q9+iUzqWLaVqavxJlgUFStdRdGIf2O3RomkQW2rXjcXJHKfZ1af
 VN8ggSiHcvpjJbdEqP54uIdpjv9lpQ+hOvL0jmWZ0Wmx8X/ugzxDwuR+ANV2yZK6N0Sjovxm85m
 zdC3QexFu9ouMCOiG0nmi9mQsrJ4moUpGKS2ZT19D6mrtVHdTqFxMWxeRs1EK0euD95nxJyl1re
 rMWZMoo0o/e4ogNLQlCiFf4FAJvUeRnTr7z0zmdO7hIOeKTp/8kf9qv2wH7Vtwt8xpt769GIUzX
 ISC0H20s
X-Proofpoint-ORIG-GUID: pxuug5K2foxx_vQ1hMXgs229DyTacTSZ
X-Proofpoint-GUID: pxuug5K2foxx_vQ1hMXgs229DyTacTSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Sorry just resend as sending tolinux-kernel@vger.kernel.org failed.


在 2025/8/15 18:01, Zhongqiu Han 写道:
     
在 2025/8/14 22:26, Peter Zijlstra 写道:
> On Thu, Aug 14, 2025 at 10:01:41PM +0800, Zhongqiu Han wrote:
>> Avoid repeated smp_processor_id() by saving cpu id in a local variable.
>>
>> - find_new_ilb(): func called with interrupts disabled.
>> - sched_cfs_period_timer(): cpu id saved after raw_spin_lock_irqsave().
>>
>> This improves clarity and reduces overhead without changing functionality.
Hi Peter,
Thanks for your review~
> No, this makes things actively worse. It:
>
>   - violates coding style by declaring a variable in the middle of code
>   - fetches the CPU number even if its never used (hopefully the compiler
>     can optimize this for you)
>   - moves error path logic into the normal code path
Acked, I regret my oversight and sincerely apologize for the inconvenience
it may have caused.
>> Signed-off-by: Zhongqiu Han<zhongqiu.han@oss.qualcomm.com>
>> ---
>>   kernel/sched/fair.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e256793b9a08..60a9830fb8a4 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6401,6 +6401,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>>   	int count = 0;
>>   
>>   	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>> +	int cpu = smp_processor_id();
>> +
>>   	for (;;) {
>>   		overrun = hrtimer_forward_now(timer, cfs_b->period);
>>   		if (!overrun)
>> @@ -6424,13 +6426,13 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>>   
>>   				pr_warn_ratelimited(
>>   	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
>> -					smp_processor_id(),
>> +					cpu,
>>   					div_u64(new, NSEC_PER_USEC),
>>   					div_u64(cfs_b->quota, NSEC_PER_USEC));
>>   			} else {
>>   				pr_warn_ratelimited(
>>   	"cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
>> -					smp_processor_id(),
>> +					cpu,
>>   					div_u64(old, NSEC_PER_USEC),
>>   					div_u64(cfs_b->quota, NSEC_PER_USEC));
>>   			}
>> @@ -12195,12 +12197,13 @@ static inline int find_new_ilb(void)
>>   {
>>   	const struct cpumask *hk_mask;
>>   	int ilb_cpu;
>> +	int this_cpu = smp_processor_id();
> This again violates coding style.
May I know is the coding style issue caused by the naming of "this"_cpu?
Should I just use "int cpu = smp_processor_id();"


>>   	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
>>   
>>   	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
>>   
>> -		if (ilb_cpu == smp_processor_id())
>> +		if (ilb_cpu == this_cpu)
>>   			continue;
> And have you checked if the compiler did this lift for you? It can
> generally lift loads out of loops.
I compared the compiler behavior on ARM64 and x86, and found that
both architectures apply a small optimization. The short summary is:


For ARM64:
The instruction count is reduced, eliminating one ldr instruction.

Before Patch:
	if (ilb_cpu == smp_processor_id())
b9401303        ldr     w3, [x24, #16]
6b14007f        cmp     w3, w20
54000080        b.eq    ffff8000800af6f4 <sched_balance_trigger+0x144>

After Patch:
	if (ilb_cpu == cpu)
6b14033f        cmp     w25, w20
54000080        b.eq    ffff8000800b7240 <sched_balance_trigger+0x150>

For X86:
The instruction becomes simpler, as it no longer needs to access memory
and instead directly accesses a register

Before Patch:
	if (ilb_cpu == smp_processor_id())
65 39 1d 00 00 00 00    cmp    %ebx,%gs:0x0(%rip)
74 ca                   je     11def <sched_balance_trigger+0xff>
    

After Patch:
	if (ilb_cpu == cpu)
41 39 dd                cmp    %ebx,%r13d
74 ce                   je     11df7 <sched_balance_trigger+0x107>


However, there is a slight chance that this loop might not be entered
even once:
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask)

May I know whether this optimization is still regarded as worthwhile?
Thanks a lot~



The details reference info is:

ARM64 before Patch:

hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
52800040        mov     w0, #0x2                        // #2
94004ad1        bl      ffff8000800c21e8 <housekeeping_cpumask>
aa0003f7        mov     x23, x0
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
52800003        mov     w3, #0x0                        // #0
b9417302        ldr     w2, [x24, #368]
d5384118        mrs     x24, sp_el0
return _find_next_and_bit(addr1, addr2, size, offset);
f9402260        ldr     x0, [x19, #64]
2a0203e2        mov     w2, w2
93407c63        sxtw    x3, w3
aa1703e1        mov     x1, x23
9419b7cc        bl      ffff80008071d5f8 <_find_next_and_bit>
aa0003f4        mov     x20, x0
b94002a2        ldr     w2, [x21]
6b02001f        cmp     w0, w2
54000b02        b.cs    ffff8000800af838 <sched_balance_trigger+0x288>
	if (ilb_cpu == smp_processor_id())
b9401303        ldr     w3, [x24, #16]
6b14007f        cmp     w3, w20
54000080        b.eq    ffff8000800af6f4 <sched_balance_trigger+0x144>


ARM64 after Patch:

int cpu = smp_processor_id();
b9401019        ldr     w25, [x0, #16]
hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
52800040        mov     w0, #0x2                        // #2
94004b4b        bl      ffff8000800c9f20 <housekeeping_cpumask>
aa0003f7        mov     x23, x0
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
b94dd302        ldr     w2, [x24, #3536]
52800003        mov     w3, #0x0                        // #0
d503201f        nop
return _find_next_and_bit(addr1, addr2, size, offset);
f9402260        ldr     x0, [x19, #64]
2a0203e2        mov     w2, w2
93407c63        sxtw    x3, w3
aa1703e1        mov     x1, x23
9419f83e        bl      ffff800080735310 <_find_next_and_bit>
aa0003f4        mov     x20, x0
b94002a2        ldr     w2, [x21]
6b02001f        cmp     w0, w2
54000a82        b.cs    ffff8000800b7378 <sched_balance_trigger+0x288>
         if (ilb_cpu == cpu)
6b14033f        cmp     w25, w20
54000080        b.eq    ffff8000800b7240 <sched_balance_trigger+0x150>




X86 before Patch:

hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
bf 02 00 00 00          mov    $0x2,%edi
e8 00 00 00 00          call   11de8 <sched_balance_trigger+0xf8>
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
31 c9                   xor    %ecx,%ecx
hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
49 89 c4                mov    %rax,%r12
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
eb 03                   jmp    11df2 <sched_balance_trigger+0x102>
8d 4b 01                lea    0x1(%rbx),%ecx
8b 15 00 00 00 00       mov    0x0(%rip),%edx
48 63 c9                movslq %ecx,%rcx
return _find_next_and_bit(addr1, addr2, size, offset);
4c 89 e6                mov    %r12,%rsi
48 c7 c7 00 00 00 00    mov    $0x0,%rdi
e8 00 00 00 00          call   11e0a <sched_balance_trigger+0x11a>
3b 05 00 00 00 00       cmp    0x0(%rip),%eax
48 89 c3                mov    %rax,%rbx
41 89 c5                mov    %eax,%r13d
0f 83 44 ff ff ff       jae    11d60 <sched_balance_trigger+0x70>
	if (ilb_cpu == smp_processor_id())
65 39 1d 00 00 00 00    cmp    %ebx,%gs:0x0(%rip)
74 ca                   je     11def <sched_balance_trigger+0xff>

  

X86 after Patch:

hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
bf 02 00 00 00          mov    $0x2,%edi
int cpu = smp_processor_id();
65 44 8b 2d 00 00 00    mov    %gs:0x0(%rip),%r13d
00
hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
e8 00 00 00 00          call   11df0 <sched_balance_trigger+0x100>
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
31 c9                   xor    %ecx,%ecx
hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
49 89 c4                mov    %rax,%r12
for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
eb 03                   jmp    11dfa <sched_balance_trigger+0x10a>
8d 4b 01                lea    0x1(%rbx),%ecx
8b 15 00 00 00 00       mov    0x0(%rip),%edx
48 63 c9                movslq %ecx,%rcx
return _find_next_and_bit(addr1, addr2, size, offset);
4c 89 e6                mov    %r12,%rsi
48 c7 c7 00 00 00 00    mov    $0x0,%rdi
e8 00 00 00 00          call   11e12 <sched_balance_trigger+0x122>
3b 05 00 00 00 00       cmp    0x0(%rip),%eax
48 89 c3                mov    %rax,%rbx
41 89 c6                mov    %eax,%r14d
0f 83 3c ff ff ff       jae    11d60 <sched_balance_trigger+0x70>
	if (ilb_cpu == cpu)
41 39 dd                cmp    %ebx,%r13d
74 ce                   je     11df7 <sched_balance_trigger+0x107>
>>   		if (idle_cpu(ilb_cpu))
>> -- 
>> 2.43.0
Thx and BRs,
Zhongqiu Han


