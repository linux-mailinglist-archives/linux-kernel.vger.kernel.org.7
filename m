Return-Path: <linux-kernel+bounces-892365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF3C44EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656773B071D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4F20468D;
	Mon, 10 Nov 2025 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xnf4LEcW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0683018C31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750511; cv=none; b=IYeOloevt9IQs6yo6ujpabWGjZLGbBModuwIXKupfwrglEuxsVlvGPoGvie6391Pa7LGyrd66CqoKXyYtpMUFz2NuYjCHNQtF7BhHHM295ZzsTWllKCjDhxVUM4WLdUkVsSGZ6h85+CJmimhBt2i9Fd23E/5e8PMwsFXZ7okK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750511; c=relaxed/simple;
	bh=hEWT5toKGFTCNjd1CnkaLdZS5yW51kDHRv+JJZ5/CBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBH5xXkANBG7J0zxQNqEAEJ+ns9mrcJTZIA+yVVw8TT4Rv4IJbK+Ydl0h7C/oMsFl2vQ1oUIC7MJKfdQQ+M408byuleFZHmIPrso3pbcSpNJixd4X9jwl2EBVOe2gAK/QZKTftxmna/YG8xiOZP8Z8kXkfqP4l/uYDR/5/Yqd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xnf4LEcW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9CvOK4001126;
	Mon, 10 Nov 2025 04:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AlwLYv
	XVGZig8jsGW/jEqPQoVxiyqkoqr+T16+uON1U=; b=Xnf4LEcWiUf3/KS8HuCL++
	w+CXOjS5YXE2Od5feKLa8ENjjnWebXk1BNaVV7Pcl0+hcVz+/Gxk0qJyzWZxfeOQ
	10ig5RkOwB5HGuIQ0By9ZrWDe+TPMIvlSpEtkeyQ5sN/NT8LBYeD9BnYDJmANcn8
	ro0WQzyydT5Lz2HKjK5OOJ3dllYNSKnzDShkmujLu6eeO8WNQf9qNSNtuSrWhIsU
	7u3VA7O9nZXi3u/1Z7fgmw340lwA7zOoHLHHkiMZ3bhi0i0fYV4mw8tMmhjp16kg
	E+vDI/Je1mVYew+eDsTr89pied6JT88SULGpaAzaz3HiHIgUPePNkK0cezhdTGKA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjmfgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:54:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AA4sT2l019719;
	Mon, 10 Nov 2025 04:54:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjmfgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:54:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4p6NJ004770;
	Mon, 10 Nov 2025 04:54:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxm1bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:54:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA4sOap57606626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 04:54:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 195A920040;
	Mon, 10 Nov 2025 04:54:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5838520043;
	Mon, 10 Nov 2025 04:54:20 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 04:54:20 +0000 (GMT)
Message-ID: <b93c9022-2f91-4c5c-9425-878e498e32a7@linux.ibm.com>
Date: Mon, 10 Nov 2025 10:24:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/10] sched/core: Push current task from paravirt
 CPU
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
        jgross@suse.com, pbonzini@redhat.com, seanjc@google.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-8-sshegde@linux.ibm.com>
 <7227822a-0b4a-47cc-af7f-190f6d3b3e07@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <7227822a-0b4a-47cc-af7f-190f6d3b3e07@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LUL6axjhmTsrTMb-PY3S75JNIbbXCtf6
X-Proofpoint-ORIG-GUID: lIhB0GIv6tweDGBYZoxhXgCS46asEnvW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX6IVOEhT1tOB0
 PvK/mh9yP3Yh8PhpSVHhjpMfm5+560OgJdDkJyJ2W+CsiNmuRnu6hLhRy6RXLNcJvup/zN/tkZF
 HJy3dwAL/GdnYpLfRLsuKVEbfMhJ+ORjWFZtmTUhk7EcFnO4zUD9R5IdBNSLyID48hjUUvOqYVk
 DU0fSISBSHa72uDw84ynAA+CYjbgdrUAQA3U+2vyUR7gbqML1B9K/c6AMqu7C24YJdKp2+n0RHb
 HXXfpdBOm33BnSAP9Bg+dG3ZxdLS1erWtk1T6hqsLpdV+72VTJOxi0gcVAFcCGHDnO6tZ4R7vxL
 1EXpXInEiPBqqDz8Gc4sCvWaC3lD5Vf2dr/fIXqUPsFfL+QGeHN7/pK7nFgwIqmFNDwY7x6AFGZ
 0eTCvZPLek1qZU8liupuzbfnbHTjpQ==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69117006 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tyqyR4cfc0q8ooH0uDMA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099


>> +
>> +static DEFINE_PER_CPU(struct cpu_stop_work, pv_push_task_work);
>> +
>> +static int paravirt_push_cpu_stop(void *arg)
>> +{
>> +	struct task_struct *p = arg;
> 
> Can we move all pushable tasks at once instead of just the rq->curr at
> the time of the tick? It can also avoid keeping the reference to "p"
> and only selectively pushing it. Thoughts?
> 
>> +	struct rq *rq = this_rq();
>> +	struct rq_flags rf;
>> +	int cpu;
>> +
>> +	raw_spin_lock_irq(&p->pi_lock);
>> +	rq_lock(rq, &rf);
>> +	rq->push_task_work_done = 0;
>> +
>> +	update_rq_clock(rq);
>> +
>> +	if (task_rq(p) == rq && task_on_rq_queued(p)) {
>> +		cpu = select_fallback_rq(rq->cpu, p);
>> +		rq = __migrate_task(rq, &rf, p, cpu);
>> +	}
>> +
>> +	rq_unlock(rq, &rf);
>> +	raw_spin_unlock_irq(&p->pi_lock);
>> +	put_task_struct(p);
>> +
>> +	return 0;
>> +}
>> +

Got it work by using by using rt.pushable_tasks(RT) and rq->cfs_tasks(CFS).

I don't see any significant benefit by doing this. there is slight improvement in time
it takes to move the tasks out. This could help when there are way too many tasks on rq.
But these days most system are with HZ=1000, that means it is 1ms tick, it shouldn't take
very long to push the current task out. Also, rq lock likely needs to be held across
the loop to ensure loop doesn't get altered by irq etc.

Given the complexity, I prefer the method of pushing the current task out.
---

         /* push the rt tasks out first */
         plist_for_each_entry_safe(p, tmp_p, &orig_rq->rt.pushable_tasks, pushable_tasks) {
                 rq = orig_rq;

                 if (kthread_is_per_cpu(p) ||is_migration_disabled(p))
                         continue;

                 raw_spin_lock_irqsave(&p->pi_lock, flags);
                 rq_lock(rq, &rf);

                 update_rq_clock(rq);

                 if (task_rq(p) == rq && task_on_rq_queued(p)) {
                         cpu = select_fallback_rq(rq->cpu, p);
                         rq = __migrate_task(rq, &rf, p, cpu);
                 }

                 rq_unlock(rq, &rf);
                 raw_spin_unlock_irqrestore(&p->pi_lock, flags);
         }

