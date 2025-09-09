Return-Path: <linux-kernel+bounces-807297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55FFB4A2AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EAD18949EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB262303C85;
	Tue,  9 Sep 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aDdEkgDG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A618AFF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400952; cv=none; b=CAgaiGSr/fgdqdUtT+qdWbNZr2OtViDnJuNOHr3XgQ4/bwbHvMWCSgyktFbN5AR633X4QqB/CmZ7sQy3F1/dNC9vvkKzJKjqydYoyGpUv7a3qAozVdN6+hgeLE4sYVkHCz2mOn4gr17tWiltwDYe1TwrQMKbiJDjInhR/95UJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400952; c=relaxed/simple;
	bh=B7pI4xlTWcWxQqubGjaWCKS2H+cGIO63BLIXIThj5+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=o+PhaIlCb2X5CyrW8JhryfrjcVkw3cZ56QWnnT+FEQBBSvfpPRqRhL2tIicMEancoHW5jsp9JtVyRyQSvZ+qhkIWsAFNCCW85NXJ8hpmdIFlfskpUwT0HerfsYXYfJ24StgNkhhreFTvDUMKQP/pqWXFLx8bnq1NwXuxPLNry4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aDdEkgDG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Kkmbs023376;
	Tue, 9 Sep 2025 06:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JvWi/z
	z8sTjmgJ6uXaP9U15BDWa9MqvvAmLOQv2m/9g=; b=aDdEkgDGx6taHCszFAML1s
	iN5O5CQQEIN/7yeuGbZWW6fjZxUN8/QnJa+Uv0yg1HPPyJjUEHYO/HHPrfjSLD8n
	a0XzqWWED45JPeoqPZaAzGRHXlhjxon6OhcR1nK1ZY6oO0QGF7/4NMMPyIb3fVa5
	m7FMF7Co47t/bLw9z7N3beE8rDKFbzKD4mnayQO6eazw3yTEamIAQBgzHmeVImwL
	Fn4gRMrM2d8W9w2/Vp312p5/HtvixJevjoBQixXGi2Sk3Hj0XK3mQe9l9dfALcZQ
	y7HNnkroYDis9wAP+o5rW55vdA9NYIao18CA2xqgd1wbmIwLNheDkKODVYVYLh4A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwnyd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:54:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5896swVO027890;
	Tue, 9 Sep 2025 06:54:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwnyd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:54:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5896CaMf007895;
	Tue, 9 Sep 2025 06:54:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pht39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:54:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5896sqW253215704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 06:54:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FFA2004B;
	Tue,  9 Sep 2025 06:54:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1991D20043;
	Tue,  9 Sep 2025 06:54:43 +0000 (GMT)
Received: from [9.39.30.114] (unknown [9.39.30.114])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 06:54:42 +0000 (GMT)
Message-ID: <5ffe0761-67c0-42ce-be3f-13915aa67080@linux.ibm.com>
Date: Tue, 9 Sep 2025 12:24:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 8/8] powerpc: Enable Generic Entry/Exit for syscalls.
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
 <20250908210235.137300-11-mchauras@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, oleg@redhat.com, kees@kernel.org,
        luto@amacapital.net, wad@chromium.org, deller@gmx.de, ldv@strace.io,
        macro@orcam.me.uk, charlie@rivosinc.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, ankur.a.arora@oracle.com, naveen@kernel.org,
        thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
        tglx@linutronix.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mingo@kernel.org, oliver.upton@linux.dev, mark.barnett@arm.com,
        atrajeev@linux.vnet.ibm.com, rppt@kernel.org, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908210235.137300-11-mchauras@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WEL9yDIFBhSS2rmGXFb8NZNovwgslSlc
X-Proofpoint-ORIG-GUID: T2WwqKP5cJpaxeIU-sjaXsn8QTMCxLmn
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bfcf42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8h6_5FmsKpm8bd2h8w8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXygUFrJFi8E+r
 OZZ3QNKbGO4Yi2YlsovrQIgtCtGLxCqK6efMmuhFEiJl0BuxQiP1o5DWh71u3C9dW6yNsHaSKfB
 xtwZzKCyNtqDJwquCNCm3lQHnlSzJql5GxSL8kNte35dOw5EBYZg2mw9IMwjf5Ytr8m+aYjvQ8e
 5LoffmBWCpxLIc7ycClejQQ0pdNhXZXbIxEy3Dkq45LqPCv2NVIPrgurIfy+xIq5PVvEzUdSGgw
 BXRbfFTSv1rfXACZXRQwhqvAlEeCLTdv5NP3+aCIXKyjNT7+NHAAsLQzXz84dDXj/13QBtAACvH
 2cGfMEGvDLbhh2V85Af+PiZjeLNFx0Dqk+1TdTOmfsTStU2pyVWL165/cxyfWuwcpjqRA+a0IWb
 c0enmJRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 9/9/25 2:32 AM, Mukesh Kumar Chaurasiya wrote:
> Enable the syscall entry and exit path from generic framework.
> 
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> ---

Hi Mukesh.
Thanks for working on this and getting it to better shape.

>   arch/powerpc/Kconfig                    |   1 +
>   arch/powerpc/include/asm/entry-common.h |   2 +-
>   arch/powerpc/kernel/interrupt.c         | 135 +++++++----------------
>   arch/powerpc/kernel/ptrace/ptrace.c     | 141 ------------------------
>   arch/powerpc/kernel/signal.c            |  10 +-
>   arch/powerpc/kernel/syscall.c           | 119 +-------------------
>   6 files changed, 49 insertions(+), 359 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e0c51d7b5638d..e67294a72e4d4 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -199,6 +199,7 @@ config PPC
>   	select GENERIC_CPU_AUTOPROBE
>   	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
>   	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_ENTRY
>   	select GENERIC_GETTIMEOFDAY
>   	select GENERIC_IDLE_POLL_SETUP
>   	select GENERIC_IOREMAP
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index d3f4a12aeafca..8fb74e6aa9560 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -3,7 +3,7 

There could be some of the configs we need to take care while enabling generic entry. Since powerpc
didn't have it earlier, there could areas which needs cleanup. One for example dynamic preemption.
There could be more. Do some git history checks and see.

Issue with dynamic preemption:

ld: kernel/entry/common.o:/home/shrikanth/sched_tip/kernel/entry/common.c:161: multiple definition of `sk_dynamic_irqentry_exit_cond_resched';
arch/powerpc/kernel/interrupt.o:/home/shrikanth/sched_tip/arch/powerpc/kernel/interrupt.c:29: first defined here

Below diff helps to fix and changing preemption modes help. Also verified preempt lazy works too.

---
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 642e22527f9d..e1e0f0da4165 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -25,10 +25,6 @@
  unsigned long global_dbcr0[NR_CPUS];
  #endif
  
-#if defined(CONFIG_PREEMPT_DYNAMIC)
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#endif
-
  #ifdef CONFIG_PPC_BOOK3S_64
  DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
  static inline bool exit_must_hard_disable(void)


----
Though ideal thing is move them to sched/core instead of being in generic code. Like below.
https://lore.kernel.org/all/20250716094745.2232041-1-sshegde@linux.ibm.com/


