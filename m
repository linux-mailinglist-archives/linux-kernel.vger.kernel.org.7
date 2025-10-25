Return-Path: <linux-kernel+bounces-869800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB0C08C49
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529FD1A62CA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4312D9EC4;
	Sat, 25 Oct 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AdMc8W8V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF127E056
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761374631; cv=none; b=svCQnS2RjsRK/DM1QihHhHLoCmRwUWqCiQZa7tTo3xcgmYqa6QnO+jM5TnZMGIDAxaBnkGN2rRWuIBwOmDrV7rRqqaERT9DoCX3+UXCVeWPSDA/YdJ0SVxOfcZRODMaGvxxmbxhhE3+xoSoKdcD3IQBRAtKvQP+oq4a5HzMHVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761374631; c=relaxed/simple;
	bh=o3qOxNAAdDT2JO8f8mlj7edKglafDirmleaNbu3efTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEy2XE7NeuFyMp41gqZ6bqjTPuYnP6tTWldXqRFgc0S2xqF0XjVHoI7bylJ0GL0euudY9Es+UNhTuj7K4aYrQ0gu7W2lDjnxDcQTLR//ImSJyLNM5BoyAggKW1AOB0VmwhCBh10sxy89NtMru2tqadrTqwFKdITTa0QAkOc/ic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AdMc8W8V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P3Plrt128731
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rW95KCIXYm77lQT5s/H08ZE72Q09AtuFEA2lEzgUNd0=; b=AdMc8W8Vzh/h+BH2
	QCh9ZzSpqtijYB9dfBZJplUC/0CXQZZ1Ffo3FM5fNZx8pAQZeDntan0BmHnRpN0+
	FkmPdO/kYjNJYZkoQnHIFXHYr9qOAk7a9+NO6UkNbWB0CbS+tjugMhB4iCTP5nfM
	qvLqv8pkRrz1okCsiF+pyKrD9QupRUkhZ11UNpN+FTSYx1Ff8C387/17Yc9eYX5b
	z5rFfa6g8L+mIRPwzorU3mfLsA+woL4eAoyuqJ/V3F+CK4WJjkIrJ2BGE/ljYWgT
	8eBGIqDYkW9HJR+AnqzhMGT1XGICJkpr4Up5jnsLSD/BLvJKyLXT3bHKD3PBmN/0
	2UYgpQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0pmqg7rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:43:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-79e43c51e6fso1733177b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761374627; x=1761979427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rW95KCIXYm77lQT5s/H08ZE72Q09AtuFEA2lEzgUNd0=;
        b=orFuaMpI07SZukJ07rudOycwAAc6dDgSTIavVasP8pqNr/7fMMw7Pr3I0B0SC9h1CC
         u8aF2Z98ZaSLCwSME/yOc87DV1wkUjHvkk8Nv7AEhe64ykQm/A1S9vbGge79NdQ/TJQP
         qrKODzPwIy0w4H7G6n53aAorC6eb5vlT3PZIeG0WcHPyvcrga+0zso1jm2A85JvJwuBd
         4ST0sz5rCDauWp6ucDogYrU3gghEzV30wNNijucl6WZPJ9z3Z56e/9Iip1mn8S2qETX8
         xG/IUS2qqPma43W5w33ejDaXZ2tIoiXbnTeDqvq0acMhMQF+8yfcQlMxVahbXyW1C3JM
         g91A==
X-Forwarded-Encrypted: i=1; AJvYcCXpNf9/65S0wyB6QokRkD/cirKbmuYWT+iZVqOzI8QK4JfEMRyghsA13/WCTHCTGitPfhV74Yzbk/5Jh+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sCsRuZCHuvb6OLJxzY83upiOXL9J6/gG0cf4tn3ia21s2CX+
	dVnK4LTzN824AtX3Etlaf8ldK8wPPQyN/00BtPKTRoHX/YEyhCVqKn1IAbEr6a6Xm1JAWeqMQNM
	4FiVboDuRm/e3QCvTXfWCs0RhFEOAyMkXngs+72JjGRwmUN3v0s8/Q4c52VFb+dggsc8=
X-Gm-Gg: ASbGncsclsCiQXZlyazTmJLZQdXZvpeJGhiMWdujYwSkWvxR4KeLFj8z2/gLljl+7EL
	bxHHh1TMaoRFTBtKiX4+0raesIunpuy8Gw8E/aTjgravIdSguqygJY/KEON0ped3Qlzx3MGn9vn
	vOnVklO/kl1gxilWqj6XNxvQsfucskXLuy72H8+dOodvonyMIWjSBkFamJaGnXkaH9W+wdyu3Xm
	LamuVTf0Qk36FVl4uCN0mJCkM/n5no5LVAqtxCTWjzfFh6b/S3gmAECjn9EW6EAL3c1Dd9XgJ+Y
	lv7rvplH3VSqkLgSM2CfhNsy8Cfm+dGMz6K/cxV3ldabjaZGmuu51K7H3s9jCtHkM0vzCbEpg/t
	PADHpgBoPvHxQ8A4w3nJGCJ8+I4EkWakiI9e20Q82rwdipfn2A2TlvQx7YsZsnqmqFwIspA==
X-Received: by 2002:a05:6a00:130f:b0:7a2:7c48:e34a with SMTP id d2e1a72fcca58-7a284df334fmr5617579b3a.13.1761374627427;
        Fri, 24 Oct 2025 23:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZXhT6VMXsGA0fysoTMea19bLbQ0XNApkgVNTxxLn7c0e0mqfhvK0ksJX0fTpMq8/a7jWdSg==
X-Received: by 2002:a05:6a00:130f:b0:7a2:7c48:e34a with SMTP id d2e1a72fcca58-7a284df334fmr5617564b3a.13.1761374626928;
        Fri, 24 Oct 2025 23:43:46 -0700 (PDT)
Received: from [10.133.33.201] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414011acdsm1243730b3a.13.2025.10.24.23.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 23:43:46 -0700 (PDT)
Message-ID: <8c5e4101-721b-45f1-aa53-5eb35bb5f3b1@oss.qualcomm.com>
Date: Sat, 25 Oct 2025 14:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Recheck the rt task's on rq state after
 double_lock_balance()
To: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-arm-msm@vger.kernel.org
Cc: kernel@oss.qualcomm.com, linux-kernel@vger.kernel.org
References: <20251009-recheck_rt_task_enqueue_state-v1-1-5f9c96d3c4fd@oss.qualcomm.com>
 <xhsmhqzuxlolh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
In-Reply-To: <xhsmhqzuxlolh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: dswVNqgVOKEMUohfYo85IsNaua2I18-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA1OCBTYWx0ZWRfX415zmeE2IVXF
 EhtjwWoafPAc1A4Uftw2wil31FzlCtScsU9Wjk7dU4FJsB+hVj6e8dvZIQKXKxJba8EIADpwcgI
 VnfwrXyIhEjsZ7wU9XiYgtcxeR9UeMFwEes+UXaPNZ1n+6UJp32iA62v6+tH/qJxbdUQkpBqGez
 7rZSK6xMEXftf6XXMucbq4XED/OOYx8/FMm1E6JKBWCAqdwtSjLXAIHil0ksG/eT1wtevwY3GNv
 JGqTS2ewduXu6hUtoxTLnnH9yv0Zy4BXaaILy60iKeQRy1FNBtae+eBkROfqnXPmgvvReATfhWT
 cspAPoxNdUZgeJuq+jyyNsO4eJmsaC/ribXwSu8EmxGqR05Hg+DAHEwZcaNC9+d8g2Kr61n8e6Y
 zv5jyGbUvGk7k/XgYf59w0j2b1fbJg==
X-Authority-Analysis: v=2.4 cv=Vf76/Vp9 c=1 sm=1 tr=0 ts=68fc71a4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=pYh2eYpCFDsFtdU7aq0A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: dswVNqgVOKEMUohfYo85IsNaua2I18-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510250058


On 10/20/2025 8:55 PM, 'Valentin Schneider' via kernel wrote:
> On 09/10/25 00:23, Tengfei Fan wrote:
>> Recheck whether next_task is still in the runqueue of this_rq after
>> locking this_rq and lowest_rq via double_lock_balance() in
>> push_rt_task(). This is necessary because double_lock_balance() first
>> releases this_rq->lock and then attempts to acquire both this_rq->lock
>> and lowest_rq->lock, during which next_task may have already been
>> removed from this_rq's runqueue, leading to a double dequeue issue.
>>
>> The double dequeue issue can occur in the following scenario:
>> 1. Core0 call stack:
>>          autoremove_wake_function
>>          default_wake_function
>>          try_to_wake_up
>>          ttwu_do_activate
>>          task_woken_rt
>>          push_rt_task
>>          move_queued_task_locked
>>          dequeue_task
>>          __wake_up
>>
>> 2. Execution flow on Core0, Core1 and Core2(Core0, Core1 and Core2 are
>>     contending for Core1's rq->lock):
>>     - Core1: enqueue next_task on Core1
>>     - Core0: lock Core1's rq->lock
>>              next_task = pick_next_pushable_task()
>>              unlock Core1's rq->lock via double_lock_balance()
>>     - Core1: lock Core1's rq->lock
>>              next_task = pick_next_task()
>>              unlock Core1's rq->lock
>>     - Core2: lock Core1's rq->lock in migration thread
>>     - Core1: running next_task
>>     - Core2: unlock Core1's rq->lock
>>     - Core1: lock Core1's rq->lock
>>              switches out and dequeue next_task
>>              unlock Core1's rq->lock
>>     - Core0: relock Core1's rq->lock from double_lock_balance()
>>              try to relock Core1's rq->lock from double_lock_balance()
>>              but next_task has been dequeued from Core1, causing the issue
>>
>> Signed-off-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
>> ---
>>   kernel/sched/rt.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 7936d4333731..b4e44317a5de 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2037,6 +2037,14 @@ static int push_rt_task(struct rq *rq, bool pull)
>>   		goto retry;
>>   	}
>>   
>> +	/* Within find_lock_lowest_rq(), it's possible to first unlock the
>> +	 * rq->lock of the runqueue containing next_task, and the re->lock
>> +	 * it. During this window, the state of next_task might have change.
>> +	 */
>> +	if (unlikely(rq != task_rq(next_task) ||
>> +		     !task_on_rq_queued(next_task)))
>> +		goto out;
>> +
> Isn't this already covered by find_lock_lowest_rq()?

Yes, this logic is already included in find_lock_lowest_rq(). 
Previously, we were missing the following patch.

https://lore.kernel.org/r/20250225180553.167995-1-harshit@nutanix.com

We will recheck whether our case has already been resolved by this patch.


>
> if @next_task migrates during the double_lock_balance(), we'll see that
> it's no longer the next highest priority pushable task of its original rq
> (it won't be in that pushable list at all actually):
>
>    static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>    {
>            [...]
>            if (double_lock_balance(rq, lowest_rq)) {
>                    if (unlikely(is_migration_disabled(task) ||
>                                 !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
>                                 task != pick_next_pushable_task(rq))) {
>
>                            double_unlock_balance(rq, lowest_rq);
>                            lowest_rq = NULL;
>                            break;
>                    }
>            }
>    }
>
> Plus:
>
>    static int push_rt_task(struct rq *rq, bool pull)
>    {
>            [...]
>            if (!lowest_rq) {
>                    struct task_struct *task;
>                    task = pick_next_pushable_task(rq);
>                    [...]
>                    put_task_struct(next_task);
>                    next_task = task;
>                    goto retry;
>            }
>    }
>
> AFAICT in the scenario you described, we'd just retry with another next
> pushable task.
I think this is just a different handling approach. At the time, our 
concern was that retrying might introduce an infinite loop.
>
>>   	move_queued_task_locked(rq, lowest_rq, next_task);
>>   	resched_curr(lowest_rq);
>>   	ret = 1;
>>
>> ---
>> base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
>> change-id: 20251008-recheck_rt_task_enqueue_state-e159aa6a2749
>>
>> Best regards,
>> -- 
>> Tengfei Fan <tengfei.fan@oss.qualcomm.com>

-- 
Thx and BRs,
Tengfei Fan


