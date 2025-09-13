Return-Path: <linux-kernel+bounces-815184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B53B560EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C98C1BC0BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3AC2EC570;
	Sat, 13 Sep 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQ4fS3cW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5A1D554
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767872; cv=none; b=gmtw5QqpdOUVkaHvioJjsXp45kvmdMKctCxEXVNQM8qauZPiYRBxhOl04+aSw3RB0TR3blLkyQxb6hRapSPya4C3npv1RuMyg0XO51Wk5CfQ3LWrkTaVq50LDR7WDGhi9ppyg3/hohSt0nTes3wyZlC4aFiG2prHqZkYFZBeaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767872; c=relaxed/simple;
	bh=dYkIGX+3hTqp+9w+BJqKOhhiX5tlMxf4Znu4vdT4lXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CFDAyXuMaDCS0qclYE6cFmEoKezbHocbsP6ykVgAA7+1xLrHQNJeliWzjGczCKg9MxDg3SBm6HJ/X11BQLpYgyjLFj9itxsDDhajLSRkFRnNyVk0Di6vCNod47bZmUqt78EFL7Y4NKMpmOYt2HH6GqVtOaqwFQw85LcGLGrcg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQ4fS3cW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DC7CTR000690;
	Sat, 13 Sep 2025 12:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eHKQUK
	1a6RKI9LHM8vfvOCzZgoYDipoBWlQQoIofHPU=; b=CQ4fS3cW5CC4g4ZLyLolKz
	tcXG6PAAZOkYMirle/UTUexdCFZKod9zPGIs8S5r8biugiLKm5nqahsDxtQr8gkH
	7kEASl+jQPM5+R2KmyoX4hRKj0+cmJKzf+l5xJ/gvp4AIt/MHnfWJsPtsxI0BdvY
	fKtnr/JkiGiq0vRe6dgZrRumEKLmuXKAVbeSkxM/kdMVlvbeyM1oPfXNTNkxpp7b
	KIWH+mifQiO9DWnYARTXBcc443Dzv8YyoV6d5YMECIgLv2U3BdktTMFTsWhD+9ja
	CuNJVUvpWNdSJW0IlTOsZrrn/KwDt9sSOxDp8fe5JC8hmJ2BAGK7lXVxZT39aP0g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 495098sb99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 12:50:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58DCoRjR014564;
	Sat, 13 Sep 2025 12:50:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 495098sb97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 12:50:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58D6sN9W020499;
	Sat, 13 Sep 2025 12:50:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1fjy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Sep 2025 12:50:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58DCoMfp60621128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 12:50:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 707B620040;
	Sat, 13 Sep 2025 12:50:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48BD420043;
	Sat, 13 Sep 2025 12:50:09 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Sep 2025 12:50:08 +0000 (GMT)
Message-ID: <da3c9140-5f5e-4ee4-901c-40615ba66ddc@linux.ibm.com>
Date: Sat, 13 Sep 2025 18:20:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 1/8] powerpc: rename arch_irq_disabled_regs
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
 <20250908210235.137300-3-mchauras@linux.ibm.com>
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
In-Reply-To: <20250908210235.137300-3-mchauras@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oJ8Tc1hXOsFSvw6aD81l7UMxT1LEu8xE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfX9ivmZpx6qCLg
 d9JYWpsf6odieFNLoq4PhwKFppBARNKA0Ao8e2SmoMHHjtQ36MEKk8CNMTrHzsu+3mbXJcdO/B5
 kKN6kkX0VZz1C4CEJtFI8SefTzEy7aJyYJpBls7W+C/h0XHd/yvOdpHdZE4sHLgJfVXEDEKyUw2
 1cHfLJYgw+WEMIe0dTQByY08S7bqxWlhokihoGPiW1bq94C3vOQSWNO7AqhAait3uiWLoWIMZ+d
 fRoZTWZQPLXWmTH9EzNcA1e0qIXYV5i7KS5vbfZ3VQou4TNc7bw6hxFX1NOWdEeuw3/4hH2qoEl
 M4u/S69aI8FjkUBg0w6jiOcFk7ilC4JkVTH1MLA4NgWmGEttvVcS10o3HTzx0KpTZcl3aG1Tf86
 b91lknpN
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=68c56894 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=EMCJoJpcfyXvlZZbmCIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PmcFKcihEBTyyE1LkGluWdzud84WRqxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020



On 9/9/25 2:32 AM, Mukesh Kumar Chaurasiya wrote:
> Renaming arch_irq_disabled_regs to regs_irqs_disabled to be used
> commonly in generic entry exit framework and ppc arch code.
> 
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_irq.h    |  4 ++--
>   arch/powerpc/include/asm/interrupt.h | 12 ++++++------
>   arch/powerpc/kernel/interrupt.c      |  4 ++--
>   arch/powerpc/kernel/syscall.c        |  2 +-
>   arch/powerpc/kernel/traps.c          |  2 +-
>   arch/powerpc/kernel/watchdog.c       |  2 +-
>   arch/powerpc/perf/core-book3s.c      |  2 +-
>   7 files changed, 14 insertions(+), 14 deletions(-)
> 
...

>   		return 0;
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 8b0081441f85d..f7518b7e30554 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2482,7 +2482,7 @@ static void __perf_event_interrupt(struct pt_regs *regs)
>   	 * will trigger a PMI after waking up from idle. Since counter values are _not_
>   	 * saved/restored in idle path, can lead to below "Can't find PMC" message.
>   	 */
> -	if (unlikely(!found) && !arch_irq_disabled_regs(regs))
> +	if (unlikely(!found) && !regs_irqs_disabled(regs))
>   		printk_ratelimited(KERN_WARNING "Can't find PMC that caused IRQ\n");
>   
>   	/*


Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

