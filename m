Return-Path: <linux-kernel+bounces-877541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C96C1E637
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A48B3B45FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F0236435;
	Thu, 30 Oct 2025 05:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RRXoKRX4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729312C544
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800473; cv=none; b=KpMR2POaW+C1aduj9/X2Rodm1VlQv+gJr1Lb9+mS2IIRfbCskO9AKiBhFt1qxxxpRlgEDG7jHPcXOqzhTYsDGzhQySMiDjcriIUIX0emJ7E/ysYN1opsMxS16j1RcPepNL+OU9DHEfvDvhJlUhhb1UvKmGinSmfBdJdPVacVhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800473; c=relaxed/simple;
	bh=nmHqVMRvhwYZ0YW8FBWfrR2OgnADF50tPDs5GxkGwHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRhWBFO/4auK/DZqJjFS212pTOImlJ34SQapRRja8wDLIOjfF+xELzFllO8r1Qv+BYGD2y0u3WbaQcgV0Xd8rXzMSXa0iC+bO5bGI/SSRpHBrHcvQaFm+7fvnFIAcFczDHfEf2s5RIvNscapv1/hS0/X50qJbeIi+UmRcdmXcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RRXoKRX4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMTYxE025859;
	Thu, 30 Oct 2025 05:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b85VS+
	Teztlfh94+bl7lJc5oJYQXfdAGlbe8pOlKBYs=; b=RRXoKRX4iZ7EQONP8PjCdh
	4esmfglieFxtUHW1eNbmYhvg6IY7c+GcWWm6Notznnym/vc/rfZ/8gL7SVOSpdVI
	aTUctF3LVN8FSQdtRf5UV+9K+EyLhUtTAlRwEgAHd2J91yAi+za2swUx5xA8S0G/
	ehhQcNmUIpe1yKfuJ02EywTYz6NekG4ri/A3yEJinnD5mHRid1XFJuAwd60sAuDU
	RlkbomqcW7UbzGKmN5TjhRr1c+F9Po0uq/+DrfEFxTboeu4O2e305/lpwcAr1dwv
	7wBCpAeJF5mbSuz1PRhPiV24N2j1vE50lbLrSUf+wea3rBZK8TScrrNPNJ3aEOLg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acpkwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 05:00:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U4vGYP009255;
	Thu, 30 Oct 2025 05:00:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acpkw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 05:00:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U15ngC030770;
	Thu, 30 Oct 2025 05:00:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwpu0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 05:00:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U50Rwl43843872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 05:00:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904CB2004B;
	Thu, 30 Oct 2025 05:00:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E150320040;
	Thu, 30 Oct 2025 05:00:24 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 05:00:24 +0000 (GMT)
Message-ID: <47e73026-390e-40d6-a860-10e9378a3bf3@linux.ibm.com>
Date: Thu, 30 Oct 2025 10:30:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/20] sched: Rewrite MM CID management
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>
References: <20251029123717.886619142@linutronix.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251029123717.886619142@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=6902f0ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=udgFBETrgBENN_4LT0MA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yP__Yzo8qxkYxoYennLcMScZC--xfovT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX8kB1ZW8wyS84
 9nwOaaJBYgK+qYvU9ycyGgjC8DDZVfulQ4Mlli6F5RGlwPlg79ZfZXHM/3sgULoyNnD6EKdrJ7B
 JZSX3Sr2sij85vBbxIWO0NDN4aYZoOYBwtafN4CBSoaJ0O8E055NnHIM3w9lABHd3FSaYtSHf7o
 K6GLQ7kpUnotJNoIyrIPAXh6CgtLKHXlVN+SE432vTNww7C1Mc1E2pH1LK+WpcKdLsV5rmh5YKl
 2ViPb+CYt/++2q5w6nQ1/9cmRAmX49zKwROxwK3kp84A967ZNMlbiCb//Ax51mlAj6zRKnqYMWX
 Y3ltmtL+E9uPEoTXP01eq92d/eolflA53sPgzKTMFbNz7crjUur1h7yrfOdizZUqiPX+hTOJiin
 Lpes9dBRkXDgr5/PsFfLEtwjtU7z9g==
X-Proofpoint-GUID: an5nJ-mvVRemeTaf71pnzIFL50L2piFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Thomas.

On 10/29/25 6:38 PM, Thomas Gleixner wrote:
> This is a follow up on V2 series which can be found here:
> 
>      https://lore.kernel.org/20251022104005.907410538@linutronix.de
> 
> The V1 cover letter contains a detailed analyisis of the issues:
> 
>      https://lore.kernel.org/20251015164952.694882104@linutronix.de
> 
> TLDR: The CID management is way to complex and adds significant overhead
> into scheduler hotpaths.
> 
> The series rewrites MM CID management in a more simplistic way which
> focusses on low overhead in the scheduler while maintaining per task CIDs
> as long as the number of threads is not exceeding the number of possible
> CPUs.
> 
> The series is based on the V6 series of the rseq rewrite:
> 
>      https://lore.kernel.org/20251027084220.785525188@linutronix.de
> 
> which is also available from git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
> 
> The series on top of the tip core/rseq branch is available from git as
> well:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid
> 
> Changes vs. V2:
> 
>     - Rename to cpumask/bitmap_weighted_or() - Yury
> 
>     - Zero the bitmap with length of bitmap_size(nr_possible_cpus()) -
>       Shrikanth
>     
>     - Move cpu_relax() out of for() as that fails to build when cpu_relax()
>       is a macro. - Shrikanth
> 
>     - Picked up Reviewed/Acked-by tags where appropriate
> 
> Thanks,
> 
> 	tglx
> ---
> Thomas Gleixner (20):
>        sched/mmcid: Revert the complex CID management
>        sched/mmcid: Use proper data structures
>        sched/mmcid: Cacheline align MM CID storage
>        sched: Fixup whitespace damage
>        sched/mmcid: Move scheduler code out of global header
>        sched/mmcid: Prevent pointless work in mm_update_cpus_allowed()
>        cpumask: Introduce cpumask_weighted_or()
>        sched/mmcid: Use cpumask_weighted_or()
>        cpumask: Cache num_possible_cpus()
>        sched/mmcid: Convert mm CID mask to a bitmap
>        signal: Move MMCID exit out of sighand lock
>        sched/mmcid: Move initialization out of line
>        sched/mmcid: Provide precomputed maximal value
>        sched/mmcid: Serialize sched_mm_cid_fork()/exit() with a mutex
>        sched/mmcid: Introduce per task/CPU ownership infrastrcuture
>        sched/mmcid: Provide new scheduler CID mechanism
>        sched/mmcid: Provide CID ownership mode fixup functions
>        irqwork: Move data struct to a types header
>        sched/mmcid: Implement deferred mode change
>        sched/mmcid: Switch over to the new mechanism
> 
>   include/linux/bitmap.h         |   15
>   include/linux/cpumask.h        |   26 +
>   include/linux/irq_work.h       |    9
>   include/linux/irq_work_types.h |   14
>   include/linux/mm_types.h       |  125 ------
>   include/linux/rseq.h           |   27 -
>   include/linux/rseq_types.h     |   71 +++
>   include/linux/sched.h          |   19
>   init/init_task.c               |    3
>   kernel/cpu.c                   |   15
>   kernel/exit.c                  |    1
>   kernel/fork.c                  |    7
>   kernel/sched/core.c            |  815 +++++++++++++++++++----------------------
>   kernel/sched/sched.h           |  395 ++++++++-----------
>   kernel/signal.c                |    2
>   lib/bitmap.c                   |    6
>   16 files changed, 727 insertions(+), 823 deletions(-)
> 
> 

I am running into crash at boot on power10 pseries.
Thought of putting it here first. Me trying to figure out why.

I am using your tree.
git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git

commit 789ff6e7cc5aa423473eb135f94812fe77b8aeab (HEAD -> rseq/cid, origin/rseq/cid)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Oct 14 10:51:04 2025 +0200

     sched/mmcid: Switch over to the new mechanism


Oops: Kernel access of bad area, sig: 7 [#3]
LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
Modules linked in: drm drm_panel_orientation_quirks xfs sd_mod sg ibmvscsi ibmveth scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 96 UID: 0 PID: 0 Comm: swapper/96 Tainted: G      D W           6.18.0-rc3+ #4 PREEMPT(lazy)
Tainted: [D]=DIE, [W]=WARN
NIP [c0000000001b5c10] mm_cid_switch_to+0x58/0x52c
LR [c000000001117c84] __schedule+0x4bc/0x760
Call Trace:
[c00000668367fde0] [c0000000001b53c8] __pick_next_task+0x60/0x2ac (unreliable)
[c00000668367fe40] [c000000001117a14] __schedule+0x24c/0x760
[c00000668367fee0] [c0000000011183d0] schedule_idle+0x3c/0x64
[c00000668367ff10] [c0000000001f2470] do_idle+0x15c/0x1ac
[c00000668367ff60] [c0000000001f2788] cpu_startup_entry+0x4c/0x50
[c00000668367ff90] [c00000000005ef20] start_secondary+0x284/0x288
[c00000668367ffe0] [c00000000000e158] start_secondary_prolog+0x10/0x14


