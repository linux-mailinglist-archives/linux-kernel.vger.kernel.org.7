Return-Path: <linux-kernel+bounces-864483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603EBFAE29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59232353968
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314C1309F01;
	Wed, 22 Oct 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L7RZBvqq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F41309DD2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121586; cv=none; b=qjcJ2A1FYKsL5inpwbLZ4SIem7uReEmryXb6/Lm6e/vRknqZ0a/y5r9LPyDfYD3cDv7Q09ZKWnVzMldPLJHn0NoNCA+t95UYkvUQMkAivchQavVSgjn9NZVkrtyRkyJIFCFaCrG60Hm406PwbYTsdgCmD/s/W1ckhM4A6Le6gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121586; c=relaxed/simple;
	bh=OjSFWd5IeYVCIuTO3u+coX4LgQCEMO4vdaQs51VHS4c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=L3CMiMhpneAocp3BuFVf6cDCBmSkNZDKImP2dAHTVU0TRqBTHXLhBsHgeCNRafPzaxdVpjNC1WPQXSAc/yOhE0yaepoJW8poXLfz6jYu2D75k7BixTrl3KLrSpHtza7xVta48UXzmdYcsKZo/28nZ4epMaPCqdGrZWk6zucbtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L7RZBvqq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LLRIV1026091;
	Wed, 22 Oct 2025 08:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hHGdoX
	qZF7p6UDhW/i+tZoTr2H6F6ejSfwgRGcZOc5c=; b=L7RZBvqqbpnqWUNDB01Z3E
	rngskuawqQClfBRtjEzgW0d6HpLehjpsPJ+gGBzxl0o7yzMGp7Ly7Z6RZqEXvNrw
	gYKnAGiMnIvDgYh3inKc1AsQFQn4RENkRM7m4cTrHOAUiSi6O827nUv5yqiFC2fD
	ToFCGFTYlAd7S+xDnPs+ncHnDh2ak5Twg3pqs9vJUhJ0UCYGWLlluIVytSs5kFjA
	MbsfI53BwW96krPWmNOaTJSZbF4sCn1Phjj1h/SuycKmAxrzNK5ssqeZzY0bEV/T
	0rm7Rp/yd/JeKd6GOHMVyRGMTIsWjt66rWWO3WyzIMJXXqjGO5bqDzNqa2rryPTA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326uk7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:26:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7kOMc024686;
	Wed, 22 Oct 2025 08:26:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjy7xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:26:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M8Q8xq31654550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:26:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9049C58065;
	Wed, 22 Oct 2025 08:26:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F56858056;
	Wed, 22 Oct 2025 08:26:06 +0000 (GMT)
Received: from [9.61.248.143] (unknown [9.61.248.143])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 08:26:05 +0000 (GMT)
Message-ID: <d718ee80-d97e-4f0f-b1f2-692626a19b1d@linux.ibm.com>
Date: Wed, 22 Oct 2025 13:56:04 +0530
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
        Naveen N Rao <naveen@kernel.org>
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
In-Reply-To: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f89523 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=X1xm8aspWHkySpns4nUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9s8ifp2QaYSY
 CByUZt9PumhdzLOI60y53WVLdcLEBs5znyEBD2LisChdT8PRy+oc+L373U+rmBqFBv7xAit+ghV
 rnFXaMC3WGulA7xJ/72/Hen6lO7fesMCZ/pY820HV9f/iQ2HbFHHVOaeXG0YXy7t/zoBNme8LTn
 FcL/8yOtWdy8wIZzDd5k6GuFGUtwl9WqfOBByntxVB93k/OH0n9LyJLZKRJ1ajkyFUFzUKgdGHn
 kgpguB+o5tDqRyb0vh69Smk365qHkNlwAYSCC/UBNlJjIk978fuR5hxfKYYig4XB+CSzJJ22Y2i
 1bwtzHf6Q0+DMXeDYLLqei9EpqK/puKcv88yBt3VsVcDfJ8I2gZpBal/Z+xLsBHnPwJp2kciYbt
 GSAyIQAwhwIl/IVoS6P8Heiz1UKQug==
X-Proofpoint-GUID: LXwn_AOwU_brLL-RRXisZ0RQKSQPJm8z
X-Proofpoint-ORIG-GUID: LXwn_AOwU_brLL-RRXisZ0RQKSQPJm8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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

Pasting the traces in more legible form.


[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
[    0.000000] stackdepot hash table entries: 1048576 (order: 8, 
16777216 bytes, linear)
[    0.000000] stackdepot: allocating space for 8191 stack pools via 
memblock
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=48, Nodes=32
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: arch/powerpc/kernel/trace/ftrace.c:234 at 
ftrace_init_ool_stub+0x188/0x3f4, CPU#0: swapper/0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 
6.18.0-rc2-next-20251022+ #1 VOLUNTARY
[    0.000000] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.000000] NIP:  c000000000092430 LR: c000000000092414 CTR: 
0000000000000000
[    0.000000] REGS: c000000004ba7a70 TRAP: 0700   Not tainted 
(6.18.0-rc2-next-20251022+)
[    0.000000] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
44022224  XER: 00000001
[    0.000000] CFAR: c0000000008d7114 IRQMASK: 3
[    0.000000] GPR00: c000000000508de0 c000000004ba7d10 c00000000248a400 
c000000004ce9720
[    0.000000] GPR04: c000000007335df8 00000000000000c0 c000000000092414 
0000000000000000
[    0.000000] GPR08: 0000000000000003 0000000000000001 0000000000000000 
0000000000002000
[    0.000000] GPR12: c00e0000008ce3a6 c0000000050b0000 0000000000000003 
0000000000000001
[    0.000000] GPR16: c000000007335df8 0000000000000000 c0000000045a8ac0 
c000000004c2d450
[    0.000000] GPR20: c0000000070e0108 c0000000070e0110 0000000000000013 
000000000000c869
[    0.000000] GPR24: c000000004ce9720 000000000000393f c000000007335e08 
c000000001879a78
[    0.000000] GPR28: c000000001a10230 0000000000003940 0000000000000000 
c000000007335df8
[    0.000000] NIP [c000000000092430] ftrace_init_ool_stub+0x188/0x3f4
[    0.000000] LR [c000000000092414] ftrace_init_ool_stub+0x16c/0x3f4
[    0.000000] Call Trace:
[    0.000000] [c000000004ba7d10] [c0000000000925c0] 
ftrace_init_ool_stub+0x318/0x3f4 (unreliable)
[    0.000000] [c000000004ba7de0] [c000000000508de0] 
ftrace_process_locs+0x364/0x8e0
[    0.000000] [c000000004ba7ee0] [c000000003060908] ftrace_init+0x68/0x1c8
[    0.000000] [c000000004ba7f50] [c00000000300ee6c] 
start_kernel+0x1e4/0x4fc
[    0.000000] [c000000004ba7fe0] [c00000000000e9a0] 
start_here_common+0x1c/0x20
[    0.000000] Code: 1d290018 7f9c4a14 3bbd0001 7f03c378 48844ca5 
60000000 39400000 7f9dc800 39200001 7c1dc800 93b80000 7d29575e 
<0b090000> 4181005c 7fe3fb78 3b3c0008
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] ------------[ ftrace bug ]------------
[    0.000000] ftrace failed to modify
[    0.000000] [<c000000001879a78>] ip6mr_vif_seq_stop+0x0/0x8
[    0.000000]  actual:   00:00:00:60
[    0.000000] Initializing ftrace call sites
[    0.000000] ftrace record flags: 0
[    0.000000]  (0)
[    0.000000]  expected tramp: c000000000093490
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: kernel/trace/ftrace.c:2209 at 
ftrace_bug+0x168/0x49c, CPU#0: swapper/0
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G   W        
    6.18.0-rc2-next-20251022+ #1 VOLUNTARY
[    0.000000] Tainted: [W]=WARN
[    0.000000] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[    0.000000] NIP:  c000000000508748 LR: c000000000508744 CTR: 
0000000000000000
[    0.000000] REGS: c000000004ba7a90 TRAP: 0700   Tainted: G   W        
     (6.18.0-rc2-next-20251022+)
[    0.000000] MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 
28028220  XER: 00000001
[    0.000000] CFAR: c0000000003880f8 IRQMASK: 3
[    0.000000] GPR00: c000000000508744 c000000004ba7d30 c00000000248a400 
0000000000000022
[    0.000000] GPR04: 0000000000000004 0000000000000000 c00000000027abec 
0000000000000001
[    0.000000] GPR08: 0000000000000001 0000000000000000 0000000000000000 
a80e000000000000
[    0.000000] GPR12: c00e00000081c5d8 c0000000050b0000 0000000000000003 
0000000000000001
[    0.000000] GPR16: c000000007335df8 0000000000000000 c0000000045a8ac0 
c000000004c2d450
[    0.000000] GPR20: c0000000070e0108 c0000000070e0110 0000000000000013 
000000000000c869
[    0.000000] GPR24: 0000000000000000 0000000000000000 000000000000b93f 
0000000000000000
[    0.000000] GPR28: c000000001879a78 c000000001b93d20 c000000007335df8 
c000000007335e00
[    0.000000] NIP [c000000000508748] ftrace_bug+0x168/0x49c
[    0.000000] LR [c000000000508744] ftrace_bug+0x164/0x49c
[    0.000000] Call Trace:
[    0.000000] [c000000004ba7d30] [c000000000508744] 
ftrace_bug+0x164/0x49c (unreliable)
[    0.000000] [c000000004ba7de0] [c000000000508dfc] 
ftrace_process_locs+0x380/0x8e0
[    0.000000] [c000000004ba7ee0] [c000000003060908] ftrace_init+0x68/0x1c8
[    0.000000] [c000000004ba7f50] [c00000000300ee6c] 
start_kernel+0x1e4/0x4fc
[    0.000000] [c000000004ba7fe0] [c00000000000e9a0] 
start_here_common+0x1c/0x20
[    0.000000] Code: 7fe3fb78 483cea79 60000000 e93e0008 75290800 
40820164 7fc3f378 4bfffa19 7c641b78 387d0fe0 4be7f975 60000000 
<0fe00000> 39000001 3ce2027a 3d22fdc1
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] ftrace: allocating 51305 entries in 19 pages
[    0.000000] ftrace: allocated 19 pages with 3 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.

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
>
>
> Regards,
>
> Venkat.
>

