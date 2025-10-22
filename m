Return-Path: <linux-kernel+bounces-864888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC254BFBC70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858813A2325
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70F32D42B;
	Wed, 22 Oct 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qCgmSQ05"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DA340295
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134810; cv=none; b=sg4L7ib4gwxbGEtpQ4xEr5NRtgXhrSoU89lLGp3QUH+llr9uXg/uuBAYzHWevcGGxvvoTw1IPfriB1rWaP24sLVyZE4lKT5zMPSY0EWVeIvdpiqmbGdzSj8zbx4ijPrWQCx8kops0ztWskmQyVRChvzwcjxYUE2UIQXXfUDKJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134810; c=relaxed/simple;
	bh=6ToLZN6Per3zIg9egW1jnqnxgAC72pOmWThZYYRSLgs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=dmHreLI1BVEIk+MKbHEhZeWKDslCeN83CGLVxefeLKcjQOrI3qxXH31JU8Xo6xbh8cT364MaAtzMb45ZEqQZrbGS9aJNt+GNjWaRR2DzLdjpswSo+5AI52NJo4Mc10WJiXhUUnjT2NuTbyruVMVlbn68sUvgB4Gfr1sljfu4akQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qCgmSQ05; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAaYBJ007202;
	Wed, 22 Oct 2025 12:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DMR8lY
	E8gQv8hEnfGmilkbQb1K3aIne19QZ3pLAx+bI=; b=qCgmSQ05ndF39EltRk76SU
	clOUXant6Oxo1WlC0FMCUBKCypqfI/W8AEwnGc0EpCw4Akfdr1AKXYu4x3m9U8Iv
	iMWtEidilKiPaGlRh1XGcxQCsgFUg+xU0P31ecNI0wnvc/zm4gYjidxo7QSMClcU
	W83PLuItVQdioPtc4MjePwywF7xXLWexGcykvr7qzdVZ7xIlU0BTKgP8RuqfvBy1
	BcxL0QKG7IFVa5UF71yrO+8Cb+fy7RzxMRnDcB+vDhOkkbODn9qV9j8OIESisHiJ
	O0ASffoAex/pOjevFznsZhsZl2fFHO41/l44YR2ZL6HInFKklQ2yo5Jj0bsnY5SQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vu32j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 12:06:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9XR3K014663;
	Wed, 22 Oct 2025 12:06:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s8cv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 12:06:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MC6Noq31130078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 12:06:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FF2058067;
	Wed, 22 Oct 2025 12:06:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE04D5805D;
	Wed, 22 Oct 2025 12:06:19 +0000 (GMT)
Received: from [9.61.242.79] (unknown [9.61.242.79])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 12:06:19 +0000 (GMT)
Message-ID: <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
Date: Wed, 22 Oct 2025 17:36:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, joe.lawrence@redhat.com,
        Naveen N Rao <naveen@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, pmladek@suse.com,
        joe.lawrence@redhat.com, jpoimboe@kernel.org
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
In-Reply-To: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: keqvlewBiuYZ2A82tzhj-9Agrz9et0hh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4USRp1RFENlv
 T6EcI6UWWiSV4UCUHNubHgn55jxqw81onxGxTG4QY4wnpUAAjrX6tXSNnMMySVe1kV1RP8C8i2N
 TRxnXEnuub71GrBsddbG4SvUUmvRhyIWCYs5ySOaAxvw9eGm4THwkEN7ZJ1KIQ6tUQSNtxbb7ju
 hTKwgVGBuecPZckjZmqFreRG42G2/qe0uDKlRc8G9LrqcYT7uUJMA/GBAlrWlKBKxJbh8Xlu5yN
 gHy7dq+Fqlnm6acTZ+F996RV5NFiGPURP3ed/WL/27uYL5QhUteicNL+4K9n+2/thU7EyX8EuXh
 MFRjfTU1MQgWx1gmq7xt1xkJrj98PWKe1SBfRtZzW/b1KHpBeYTxJXmeq1Oay1HttWAbBLaEhwT
 e09t5fxfJ79fZRaT5A2IiW/BeBg6Xg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8c8c1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=HLoz0p-YUXpcMqrYuV8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: keqvlewBiuYZ2A82tzhj-9Agrz9et0hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
>
> IBM CI has reported kernel boot warnings with next-20251022 kernel. I 
> see there are couple of warnings hit and eventually system boots to 
> emergency mode.
>
>
> Traces:
>
>
> [    0.000000] stackdepot: allocating space for 8191 stack pools via 
> memblock
> [    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=48, 
> Nodes=32
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: arch/powerpc/kernel/trace/ftrace.c:234 at 
> ftrace_init_ool_stub+0x188/0x3f4, CPU#0: swapper/0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 
> 6.18.0-rc2-next-20251022+ #1 VOLUNTARY
> [    0.000000] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.000000] NIP:  c000000000092430 LR: c000000000092414 CTR: 
> 0000000000000000
> [    0.000000] REGS: c000000004ba7a70 TRAP: 0700   Not tainted 
> (6.18.0-rc2-next-20251022+)
> [    0.000000] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
> 44022224  XER: 00000001
> [    0.000000] CFAR: c0000000008d7114 IRQMASK: 3
> [    0.000000] GPR00: c000000000508de0 c000000004ba7d10 
> c00000000248a400 c000000004ce9720
> [    0.000000] GPR04: c000000007335df8 00000000000000c0 
> c000000000092414 0000000000000000
> [    0.000000] GPR08: 0000000000000003 0000000000000001 
> 0000000000000000 0000000000002000
> [    0.000000] GPR12: c00e0000008ce3a6 c0000000050b0000 
> 0000000000000003 0000000000000001
> [    0.000000] GPR16: c000000007335df8 0000000000000000 
> c0000000045a8ac0 c000000004c2d450
> [    0.000000] GPR20: c0000000070e0108 c0000000070e0110 
> 0000000000000013 000000000000c869
> [    0.000000] GPR24: c000000004ce9720 000000000000393f 
> c000000007335e08 c000000001879a78
> [    0.000000] GPR28: c000000001a10230 0000000000003940 
> 0000000000000000 c000000007335df8
> [    0.000000] NIP [c000000000092430] ftrace_init_ool_stub+0x188/0x3f4
> [    0.000000] LR [c000000000092414] ftrace_init_ool_stub+0x16c/0x3f4
> [    0.000000] Call Trace:
> [    0.000000] [c000000004ba7d10] [c0000000000925c0] 
> ftrace_init_ool_stub+0x318/0x3f4 (unreliable)
> [    0.000000] [c000000004ba7de0] [c000000000508de0] 
> ftrace_process_locs+0x364/0x8e0
> [    0.000000] [c000000004ba7ee0] [c000000003060908] 
> ftrace_init+0x68/0x1c8
> [    0.000000] [c000000004ba7f50] [c00000000300ee6c] 
> start_kernel+0x1e4/0x4fc
> [    0.000000] [c000000004ba7fe0] [c00000000000e9a0] 
> start_here_common+0x1c/0x20
> [    0.000000] Code: 1d290018 7f9c4a14 3bbd0001 7f03c378 48844ca5 
> 60000000 39400000 7f9dc800 39200001 7c1dc800 93b80000 7d29575e 
> <0b090000> 4181005c 7fe3fb78 3b3c0008
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] ------------[ ftrace bug ]------------
> [    0.000000] ftrace failed to modify
> [    0.000000] [<c000000001879a78>] ip6mr_vif_seq_stop+0x0/0x8
> [    0.000000]  actual:   00:00:00:60
> [    0.000000] Initializing ftrace call sites
> [    0.000000] ftrace record flags: 0
> [    0.000000]  (0)
> [    0.000000]  expected tramp: c000000000093490
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: kernel/trace/ftrace.c:2209 at 
> ftrace_bug+0x168/0x49c, CPU#0: swapper/0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G   W       
>    6.18.0-rc2-next-20251022+ #1 VOLUNTARY
> [    0.000000] Tainted: [W]=WARN
> [    0.000000] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    0.000000] NIP:  c000000000508748 LR: c000000000508744 CTR: 
> 0000000000000000
> [    0.000000] REGS: c000000004ba7a90 TRAP: 0700   Tainted: G   W     
>       (6.18.0-rc2-next-20251022+)
> [    0.000000] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
> 28028220  XER: 00000001
> [    0.000000] CFAR: c0000000003880f8 IRQMASK: 3
> [    0.000000] GPR00: c000000000508744 c000000004ba7d30 
> c00000000248a400 0000000000000022
> [    0.000000] GPR04: 0000000000000004 0000000000000000 
> c00000000027abec 0000000000000001
> [    0.000000] GPR08: 0000000000000001 0000000000000000 
> 0000000000000000 a80e000000000000
> [    0.000000] GPR12: c00e00000081c5d8 c0000000050b0000 
> 0000000000000003 0000000000000001
> [    0.000000] GPR16: c000000007335df8 0000000000000000 
> c0000000045a8ac0 c000000004c2d450
> [    0.000000] GPR20: c0000000070e0108 c0000000070e0110 
> 0000000000000013 000000000000c869
> [    0.000000] GPR24: 0000000000000000 0000000000000000 
> 000000000000b93f 0000000000000000
> [    0.000000] GPR28: c000000001879a78 c000000001b93d20 
> c000000007335df8 c000000007335e00
> [    0.000000] NIP [c000000000508748] ftrace_bug+0x168/0x49c
> [    0.000000] LR [c000000000508744] ftrace_bug+0x164/0x49c
> [    0.000000] Call Trace:
> [    0.000000] [c000000004ba7d30] [c000000000508744] 
> ftrace_bug+0x164/0x49c (unreliable)
> [    0.000000] [c000000004ba7de0] [c000000000508dfc] 
> ftrace_process_locs+0x380/0x8e0
> [    0.000000] [c000000004ba7ee0] [c000000003060908] 
> ftrace_init+0x68/0x1c8
> [    0.000000] [c000000004ba7f50] [c00000000300ee6c] 
> start_kernel+0x1e4/0x4fc
> [    0.000000] [c000000004ba7fe0] [c00000000000e9a0] 
> start_here_common+0x1c/0x20
> [    0.000000] Code: 7fe3fb78 483cea79 60000000 e93e0008 75290800 
> 40820164 7fc3f378 4bfffa19 7c641b78 387d0fe0 4be7f975 60000000 
> <0fe00000> 39000001 3ce2027a 3d22fdc1
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] ftrace: allocating 51305 entries in 19 pages
>
>
>
> Attached is the config file.
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


I did bisection and its pointing to below commit as the first bad commit.


6717e8f91db71641cb52855ed14c7900972ed0bc (kbuild: Remove 'kmod_' prefix 
from __KBUILD_MODNAME) is the first bad commit.


But there seems to be two seperate issue.


1. Kernel boot warnings

2. Kernel booting into emergency mode.


With the identified first bad commit, is casuing the kernel to boot to 
emergency mode. I reverted the bad commit and built the kernel, then 
kernel is booting fine, but with boot warnings.


Reagrds,

Venkat.

>
>
> Regards,
>
> Venkat.
>

