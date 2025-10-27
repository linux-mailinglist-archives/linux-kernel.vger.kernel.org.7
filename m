Return-Path: <linux-kernel+bounces-870834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597FDC0BCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5BF188B731
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835F246770;
	Mon, 27 Oct 2025 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oRJFo7xy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED822F389
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541912; cv=none; b=BapEiLUxwUITwGgwnNyWroDr42vjNo3Tqcne2Xf/kYMMBlrIVCA+Kn6Mc++7BnusYRthCyoo4AOw6GwObaNMcQFWQKrT/q+2IqlEQEeQ/D2JabfFH7k+DEDd9KvTa9rL+ncdaU1fB/28ZiXPBZjYp2baFI8s38G8ISzNfa3UvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541912; c=relaxed/simple;
	bh=noMKfFaQO+gVw+gglb4mfTbz7dugyklYlM9VDAcONRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7YFKbDIHX7QKRcUZDRvIxA2T6AmMGpJKp2VGyMKifQiZ6b577JNf7/FK7321NuuwzfUEsM4V293nQnCjgdzQavch7x//whVVjz0tXn7Y8235UvPLLvIy4+SLYWFckDVOspiOyAxIFyz5uzMT03rmbIjlhE0R3JeTfxKtMihWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oRJFo7xy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QKkB4w030560;
	Mon, 27 Oct 2025 05:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2/nC74
	uSUqMlsUvRH3XfkivYLhm7VQUsnl3hzHfOKfs=; b=oRJFo7xyXmi9wxxkrhWW7W
	keffUwm02wpvJWNDcB14JgNvZiZJg/Whuye0hzP5Etwo+ZaqbW/1PEWh+hG376ok
	w/EFPulUA1w++ApGMTujTciIOH/dwnHC5LfuKp2Fc6q01rk05OkhliU45yV0Tr2+
	umYaVmZu4E+P/frVE4OyZmWT6yLqP7Xlxot/iR2bCx0sxY8FK9x4CKaBC0rRIF6O
	k20L6nX7Epn/CIzEKc8uJ3Eq1dpPG5JMd2wuE2ied2gEQBwFUiA4TgxOfChKyXd0
	9k2lEkiauy09JNbokI0b45c6ydvJjghtpZgs0nWNosRbEmO4BmXzq5DmC8yQMXbg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrw4xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:11:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59R52BjG029945;
	Mon, 27 Oct 2025 05:11:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrw4xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:11:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R2ef5q030103;
	Mon, 27 Oct 2025 05:11:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a19vmbwuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:11:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R5B62e42205694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 05:11:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAD4920043;
	Mon, 27 Oct 2025 05:11:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B004920040;
	Mon, 27 Oct 2025 05:11:03 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 05:11:03 +0000 (GMT)
Message-ID: <9076c353-a22b-4c38-bd30-fb10eb0ae851@linux.ibm.com>
Date: Mon, 27 Oct 2025 10:41:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 16/20] sched/mmcid: Provide new scheduler CID mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20251022104005.907410538@linutronix.de>
 <20251022110556.399477196@linutronix.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251022110556.399477196@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q0rtEQYVrEhu4ceqO9Z2MDfWqcBHrNec
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68fefeee cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p9TLJcio2fSzq28u2DUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX3zzevpRDf43H
 UyAsAKmLIsxnGEJjPUGCcY729+Nv74FExM2YRwnGZDUEeokyNPoWqEx6Pej3to1j1cUqx+BJMyU
 ucZz+sGUfZO31l2c5xxMOiv89/d8rDTFp5La0cRq5SszN3YL5poDvFXw/zz5X3JIHPvRD34neZP
 QvgfWRMooFPtqMKiSEkYegBX8EkMkXCC8RkTaniiiu5eev4C0GQ1eUeqDXU+l39pgVelnIRsUuk
 /KGToatt1yUAtET7S+DofdklwLqihovznngXsfwZEfVOlHv4yxIN9NdDHdv/8Ugt4x811ExNURu
 zyZ8M+dUVIMan/C/M9sMdp8lhtAs3mmfp3WaExAVgipHBa3712OTxS+aJT9SByvaMcZ6CoT0zDw
 LYnNU62vddx1BbitCOGBF6te1GJOrA==
X-Proofpoint-GUID: qK5GAvC7aqLbEZxtu7KdVcHcqgwN6XjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010


Hi Thomas,

On 10/22/25 6:25 PM, Thomas Gleixner wrote:
> The MM CID management has two fundamental requirements:
> 
>    1) It has to guarantee that at no given point in time the same CID is
>       used by concurrent tasks in userspace.
> 
>    2) The CID space must not exceed the number of possible CPUs in a
>       system. While most allocators (glibc, tcmalloc, jemalloc) do not
>       care about that, there seems to be at least some LTTng library
>       depending on it.
> 
> The CID space compaction itself is not a functional correctness
> requirement, it is only a useful optimization mechanism to reduce the
> memory foot print in unused user space pools.
> 

Just wondering, if there is no user space request for CID, this whole mechanism
should be under a static check to avoid any overhead?

(Trying to understand this change. Very interesting. ignore if this is not applicable)

> The optimal CID space is:
> 
>      min(nr_tasks, nr_cpus_allowed);
> 
> Where @nr_tasks is the number of actual user space threads associated to
> the mm and @nr_cpus_allowed is the superset of all task affinities. It is
> growth only as it would be insane to take a racy snapshot of all task
> affinities when the affinity of one task changes just do redo it 2
> milliseconds later when the next task changes it's affinity.
> 
> That means that as long as the number of tasks is lower or equal than the
> number of CPUs allowed, each task owns a CID. If the number of tasks
> exceeds the number of CPUs allowed it switches to per CPU mode, where the
> CPUs own the CIDs and the tasks borrow them as long as they are scheduled
> in.
> 
> For transition periods CIDs can go beyond the optimal space as long as they
> don't go beyond the number of possible CPUs.
> 
> The current upstream implementation tries to keep the CID with the task
> even in overcommit situations, which complicates task migration. It also
> has to do the CID space consolidation work from a task work in the exit to
> user space path. As that work is assigned to a random task related to a MM
> this can inflict unwanted exit latencies.
> 
> Implement the context switch parts of a strict ownership mechanism to
> address this.
> 
> This removes most of the work from the task which schedules out. Only
> during transitioning from per CPU to per task ownership it is required to
> drop the CID when leaving the CPU to prevent CID space exhaustion. Other
> than that scheduling out is just a single check and branch.
> 
> The task which schedules in has to check whether:
> 
>      1) The ownership mode changed
>      2) The CID is within the optimal CID space
> 
> In stable situations this results in zero work. The only short disruption
> is when ownership mode changes or when the associated CID is not in the
> optimal CID space. The latter only happens when tasks exit and therefore
> the optimal CID space shrinks.
> 
> That mechanism is strictly optimized for the common case where no change
> happens. The only case where it actually causes a temporary one time spike
> is on mode changes when and only when a lot of tasks related to a MM
> schedule exactly at the same time and have eventually to compete on
> allocating a CID from the bitmap.
> 
> In the sysbench test case which triggered the spinlock contention in the
> initial CID code, __schedule() drops significantly in perf top on a 128
> Core (256 threads) machine when running sysbench with 255 threads, which
> fits into the task mode limit of 256 together with the parent thread:
> 
>    Upstream  rseq/perf branch  +CID rework
>    0.42%     0.37%             0.32%          [k] __schedule
> 
> Increasing the number of threads to 256, which puts the test process into
> per CPU mode looks about the same.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

[...]   
> +static inline unsigned int __mm_get_cid(struct mm_struct *mm, unsigned int max_cids)
> +{
> +	unsigned int cid = find_first_zero_bit(mm_cidmask(mm), max_cids);
> +
> +	if (cid >= max_cids)
> +		return MM_CID_UNSET;
> +	if (test_and_set_bit(cid, mm_cidmask(mm)))
> +		return MM_CID_UNSET;
> +	return cid;
> +}
> +
> +static inline unsigned int mm_get_cid(struct mm_struct *mm)
> +{
> +	unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
> +
> +	for (; cid == MM_CID_UNSET; cpu_relax())

This triggers an compile error on ppc64le.

In file included from ./include/vdso/processor.h:10,
                  from ./arch/powerpc/include/asm/processor.h:9,
                  from ./include/linux/sched.h:13,
                  from ./include/linux/sched/affinity.h:1,
                  from kernel/sched/sched.h:8,
                  from kernel/sched/rq-offsets.c:5:
kernel/sched/sched.h: In function ‘mm_get_cid’:
./arch/powerpc/include/asm/vdso/processor.h:26:9: error: expected expression before ‘asm’
    26 |         asm volatile(ASM_FTR_IFCLR(                                     \
       |         ^~~
kernel/sched/sched.h:3615:37: note: in expansion of macro ‘cpu_relax’
  3615 |         for (; cid == MM_CID_UNSET; cpu_relax())


+linux-ppc dev.


Moving it into a while seems to make compiling happy.
Need to see why, but thought of informing fist.

  kernel/sched/sched.h | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50bc0eb08a66..8a6ad4fc9534 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3612,8 +3612,11 @@ static inline unsigned int mm_get_cid(struct mm_struct *mm)
  {
  	unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
  
-	for (; cid == MM_CID_UNSET; cpu_relax())
-		cid = __mm_get_cid(mm, num_possible_cpus());
+	while(1) {
+		if (cid == MM_CID_UNSET)
+			break;
+		cpu_relax();
+	}
  
  	return cid;
  }




> +		cid = __mm_get_cid(mm, num_possible_cpus());
> +
> +	return cid;
> +}
> +

