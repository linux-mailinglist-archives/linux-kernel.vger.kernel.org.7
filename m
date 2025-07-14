Return-Path: <linux-kernel+bounces-730613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E727B046F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3134A44FD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4A267713;
	Mon, 14 Jul 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DIIEsO4I"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB9266EE6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515699; cv=none; b=GwDnrng9JNduUh03YBh1Yag+HT+NYfy6a99jeA8bKJlMeSdQnBg/F9cWEXp6j9Bye2G7TV1r1RaTWFo+/uLps6Xq41n94VZbclZlJ/EFjzgJRXrbRF+vPIKiWYFuq2VGqIRZL7q4YdHQO7893/p+7oLqkFKHkJcJ4ITFZY6q5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515699; c=relaxed/simple;
	bh=pg1YBiSHpDuyRVtex2aVCqbMAoM5OOsJMM5CKWlCDDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaCy4ldwt9yuEuupXSCIMSTJ0d89xJFy4ymhq/u3XuxqNlqn/KPgbc8J12CH2bbs1VnWV1rB1bWuOKY2WC6VFB7BI2tu0+JZphNtQunuqwTJ9+TmbNqcGwVVcUOOI+binemD3uaxL+kTSUShA9gtBdZMUsFe3F5igtWGfOMecvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DIIEsO4I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDDBWD027341;
	Mon, 14 Jul 2025 17:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U3xqp+
	l4cxuc7XXP6umAs8/qOEzrVNYfnfN7JQuZcE8=; b=DIIEsO4I3aZvUh6mM+rM3N
	dFZGK3OOj0XVBSYtdpUHVwn38ocnPPoXk3eL5PmCmIUBN6sd8WQUKyBV4NyD99OM
	fPlOyfO/h9OBrYOhJN2tZsLycH3/SIIHy7dAHIzncDNreIllLFEBPgG+DcXCh93l
	4cQJyMRrTOIdeLE1HAiCpPUlfB0P/mmKviFoVWZafRTEzjn0i6QGaXHemfIEc7nx
	KGgbnmdrik0OZNpc5ZgN19FvnOdZP3PXsBGmS9GTWpStw4iUw/YQPnYD+uekSyVb
	QxqkbFNJ8FWa9oTvD7sHMYrp2ziMK1Kt3Ac+MrNcGu2UjZFMfx6dmczB7krfx+fw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tty1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:54:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56EHVBwK015968;
	Mon, 14 Jul 2025 17:54:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tty1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:54:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EHTImN008154;
	Mon, 14 Jul 2025 17:54:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0f321-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 17:54:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EHsdFc16318770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 17:54:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647AE2004B;
	Mon, 14 Jul 2025 17:54:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 216DF20040;
	Mon, 14 Jul 2025 17:54:37 +0000 (GMT)
Received: from [9.124.219.62] (unknown [9.124.219.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 17:54:36 +0000 (GMT)
Message-ID: <c6c0c135-9d8f-4d9d-8fc5-bc703cac9bdb@linux.ibm.com>
Date: Mon, 14 Jul 2025 23:24:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clm@meta.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
 <20250708190201.GE477119@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250708190201.GE477119@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68754462 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=irdw4SRykOf8dQUZ3u4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0_5iLtn0nfm_dy4KhjaXynSfPyHdEFZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMiBTYWx0ZWRfX8srkMG/mFrxs oPxcrVQ8aCM6FLKYAzqlLSwJUARsytBYSxu3olD2JsSzEZqQI+kevJ8DSQ5EELpWIVBFhaDxwlg QI8kTmHZV+D4rkPmR7uM4OVYAs4soOHOsYmhLNwHgkrqg3cqYef+9HUVoDVs0H4rgi97ZD4V5dc
 owS4AlxA0Ch8F0kaqtGWyLM0Mki/bDiNdKwnoi8et6I0fHFL/1CKkKzZPPyolKg4IhclABnv3We mkvF2LMI3Yo5EozU9ElfLBj7MX5m9IXmrhkeLEZbNfr62P5uFogpngGlA2gN1jKBPNK5kdxFUAS yQ6OHa8JKoKBipVlGEbt3G32PU7kit8pyE4J/HpghzTeIDi+wsIj7YKfVyEL72/8MvkZZ+zHU7R
 WFQwylGt4hgExGyxewCNvo1urDluLVUJxks1/oZxvaQ+drqd/Vb33Vr8szpiPPQc2EqPzLB1
X-Proofpoint-ORIG-GUID: ftKuyZ9mRd4OQxvowLfjJMrsEXx7sPiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=898
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140112



On 7/9/25 00:32, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 11:49:17PM +0530, Shrikanth Hegde wrote:
> 
>> Git bisect points to
>> # first bad commit: [dc968ba0544889883d0912360dd72d90f674c140] sched: Add ttwu_queue support for delayed tasks
> 
> Moo.. Are IPIs particularly expensive on your platform?
> 
> The 5 cores makes me think this is a partition of sorts, but IIRC the
> power LPAR stuff was fixed physical, so routing interrupts shouldn't be
> much more expensive vs native hardware.
> 
Some more data from the regression. I am looking at rps numbers
while running ./schbench -L -m 4 -M auto -t 64 -n 0 -r 5 -i 5.
All the data is from an LPAR(VM) with 5 cores.


echo TTWU_QUEUE_DELAYED > features
average rps: 970491.00

echo NO_TTWU_QUEUE_DELAYED > features
current rps: 1555456.78

So below data points are with feature enabled or disabled with series applied + clm's patch.
-------------------------------------------------------
./hardirqs

TTWU_QUEUE_DELAYED
HARDIRQ                    TOTAL_usecs
env2                               816
IPI-2                          1421603       << IPI are less compared to with feature.


NO_TTWU_QUEUE_DELAYED
HARDIRQ                    TOTAL_usecs
ibmvscsi                             8
env2                               266
IPI-2                          6489980

-------------------------------------------------------

Disabled all the idle states. Regression still exits.

-------------------------------------------------------

See this warning everytime i run schbench:  This happens with PATCH 12/12 only.

It is triggering this warning. Some clock update is getting messed up?

1637 static inline void assert_clock_updated(struct rq *rq)
1638 {
1639         /*
1640          * The only reason for not seeing a clock update since the
1641          * last rq_pin_lock() is if we're currently skipping updates.
1642          */
1643         WARN_ON_ONCE(rq->clock_update_flags < RQCF_ACT_SKIP);
1644 }
  

WARNING: kernel/sched/sched.h:1643 at update_load_avg+0x424/0x48c, CPU#6: swapper/6/0
CPU: 6 UID: 0 PID: 0 Comm: swapper/6 Kdump: loaded Not tainted 6.16.0-rc4+ #276 PREEMPT(voluntary)
NIP:  c0000000001cea60 LR: c0000000001d7254 CTR: c0000000001d77b0
REGS: c000000003a674c0 TRAP: 0700   Not tainted  (6.16.0-rc4+)
MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 28008208  XER: 20040000
CFAR: c0000000001ce68c IRQMASK: 3
GPR00: c0000000001d7254 c000000003a67760 c000000001bc8100 c000000061915400
GPR04: c00000008c80f480 0000000000000005 c000000003a679b0 0000000000000000
GPR08: 0000000000000001 0000000000000000 c0000003ff14d480 0000000000004000
GPR12: c0000000001d77b0 c0000003ffff7880 0000000000000000 000000002eef18c0
GPR16: 0000000000000006 0000000000000006 0000000000000008 c000000002ca2468
GPR20: 0000000000000000 0000000000000004 0000000000000009 0000000000000001
GPR24: 0000000000000000 0000000000000001 0000000000000001 c0000003ff14d480
GPR28: 0000000000000001 0000000000000005 c00000008c80f480 c000000061915400
NIP [c0000000001cea60] update_load_avg+0x424/0x48c
LR [c0000000001d7254] enqueue_entity+0x5c/0x5b8
Call Trace:
[c000000003a67760] [c000000003a677d0] 0xc000000003a677d0 (unreliable)
[c000000003a677d0] [c0000000001d7254] enqueue_entity+0x5c/0x5b8
[c000000003a67880] [c0000000001d7918] enqueue_task_fair+0x168/0x7d8
[c000000003a678f0] [c0000000001b9554] enqueue_task+0x5c/0x1c8
[c000000003a67930] [c0000000001c3f40] ttwu_do_activate+0x98/0x2fc
[c000000003a67980] [c0000000001c4460] sched_ttwu_pending+0x2bc/0x72c
[c000000003a67a60] [c0000000002c16ac] __flush_smp_call_function_queue+0x1a0/0x750
[c000000003a67b10] [c00000000005e1c4] smp_ipi_demux_relaxed+0xec/0xf4
[c000000003a67b50] [c000000000057dd4] doorbell_exception+0xe0/0x25c
[c000000003a67b90] [c0000000000383d0] __replay_soft_interrupts+0xf0/0x154
[c000000003a67d40] [c000000000038684] arch_local_irq_restore.part.0+0x1cc/0x214
[c000000003a67d90] [c0000000001b6ec8] finish_task_switch.isra.0+0xb4/0x2f8
[c000000003a67e30] [c00000000110fb9c] __schedule+0x294/0x83c
[c000000003a67ee0] [c0000000011105f0] schedule_idle+0x3c/0x64
[c000000003a67f10] [c0000000001f27f0] do_idle+0x15c/0x1ac
[c000000003a67f60] [c0000000001f2b08] cpu_startup_entry+0x4c/0x50
[c000000003a67f90] [c00000000005ede0] start_secondary+0x284/0x288
[c000000003a67fe0] [c00000000000e058] start_secondary_prolog+0x10/0x14

----------------------------------------------------------------

perf stat -a:  ( idle states enabled)

TTWU_QUEUE_DELAYED:

         13,612,930      context-switches                 #    0.000 /sec
            912,737      cpu-migrations                   #    0.000 /sec
              1,245      page-faults                      #    0.000 /sec
    449,817,741,085      cycles
    137,051,199,092      instructions                     #    0.30  insn per cycle
     25,789,965,217      branches                         #    0.000 /sec
        286,202,628      branch-misses                    #    1.11% of all branches

NO_TTWU_QUEUE_DELAYED:

         24,782,786      context-switches                 #    0.000 /sec
          4,697,384      cpu-migrations                   #    0.000 /sec
              1,250      page-faults                      #    0.000 /sec
    701,934,506,023      cycles
    220,728,025,829      instructions                     #    0.31  insn per cycle
     40,271,327,989      branches                         #    0.000 /sec
        474,496,395      branch-misses                    #    1.18% of all branches

both cycles and instructions are low.

-------------------------------------------------------------------

perf stat -a:  ( idle states disabled)

TTWU_QUEUE_DELAYED:
            
         15,402,193      context-switches                 #    0.000 /sec
          1,237,128      cpu-migrations                   #    0.000 /sec
              1,245      page-faults                      #    0.000 /sec
    781,215,992,865      cycles
    149,112,303,840      instructions                     #    0.19  insn per cycle
     28,240,010,182      branches                         #    0.000 /sec
        294,485,795      branch-misses                    #    1.04% of all branches

NO_TTWU_QUEUE_DELAYED:

         25,332,898      context-switches                 #    0.000 /sec
          4,756,682      cpu-migrations                   #    0.000 /sec
              1,256      page-faults                      #    0.000 /sec
    781,318,730,494      cycles
    220,536,732,094      instructions                     #    0.28  insn per cycle
     40,424,495,545      branches                         #    0.000 /sec
        446,724,952      branch-misses                    #    1.11% of all branches

Since idle states are disabled, cycles are always spent on CPU. so cycles are more or less, while instruction
differs. Does it mean with feature enabled, is there a lock(maybe rq) for too long?

--------------------------------------------------------------------

Will try to gather more into why is this happening.

