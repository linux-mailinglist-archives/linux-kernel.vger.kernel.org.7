Return-Path: <linux-kernel+bounces-773945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D364B2ACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAB188CEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5D256C61;
	Mon, 18 Aug 2025 15:24:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36524CEE8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530671; cv=none; b=MxxnZAw0h0B9QEYjVKRpvnIO+bq/drtjxmFIXSpCJi00q+Fi3peUQwONK5WJHBuoJchibQsigXD42tKtFQJS5Adn44dVK5ZZ5vCIA+0USsDhilF/X8WnPeTOUNRTKH65GBT4mpWn9vW9TFsxuKbPAmH1/mqL7+qF57VH+8ZO9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530671; c=relaxed/simple;
	bh=ysUsvQk2nCmmYBwKtgoCb1F2gzQ6qL4Oc+YOwT35yJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/cPGfwQhchGqh9PAdKiY8ul7T+AeH3UOc4YO0g7R4tfPbJYU3yyw72X7LwvI8JSjb6slEjFXpc3aINTU+0wduxLwHYPPdMoGggd8Vs53sxB0sdZKjnp8NwT7szU37fReSp4PcCO+bzB0pCIH3TdX23IgA47o7sqTfS+umvZaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2321596;
	Mon, 18 Aug 2025 08:24:20 -0700 (PDT)
Received: from [172.24.48.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01803F738;
	Mon, 18 Aug 2025 08:24:23 -0700 (PDT)
Message-ID: <e3861092-71d3-4f36-8013-d721f60c1392@arm.com>
Date: Mon, 18 Aug 2025 16:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20250812093339.8895-1-xuewen.yan@unisoc.com>
 <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
 <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com>
 <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.08.25 12:05, Xuewen Yan wrote:
> On Fri, Aug 15, 2025 at 9:01 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 14.08.25 10:52, Xuewen Yan wrote:
>>> Hi Dietmar,
>>>
>>> On Thu, Aug 14, 2025 at 4:46 PM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 12.08.25 10:33, Xuewen Yan wrote:
>>
>> [...]
>>
>>>> Can you not mask cpus already early in the pd loop (1) and then profit
>>>> from (2) in these rare cases?
>>>
>>> I do not think the cpus_ptr chould place before the pd_cap calc,
>>> because the following scenario should be considered:
>>> the task's cpus_ptr cpus： 0,1,2,3
>>> pd's cpus: 0,1,2,3,4,5,6
>>> the pd's cap = cpu_cap * 6;
>>> if we cpumask_and(pd'scpus, p->cpus_ptr),
>>> the cpumask_weight = 4,
>>> the pd's cap = cpu_cap *4.
>>
>> Yes, you're right! Missed this one.
>>
>>>> IIRC, the sd only plays a role here in
>>>> exclusive cpusets scenarios which I don't thing anybody deploys with EAS?
>>>
>>> I am also wondering if the check for SD's CPUs could be removed...
>>
>> Still not 100% sure here. I would have to play with cpusets and EAS a
>> little bit more. Are you thinking that in those cases p->cpus_ptr
>> already covers the cpuset restriction so that the sd mask isn't necessary?
> 
> I am not familiar with cpuset, so I can't guarantee this. Similarly, I
> also need to learn more about cpuset and cpu topology before I can
> answer this question.

Looks like we do need also the sd cpumask here.

Consider this tri-gear system:

#  cat /sys/devices/system/cpu/cpu*/cpu_capacity
160
160
160
160
498
498
1024
1024

and 2 exclusive cpusets cs1={0-1,4,6} and cs2={2-3,5,7}, so EAS is
possible in all 3 root_domains (/, /cs1, /cs2):

...
[   74.691104] CPU1 attaching sched-domain(s):
[   74.691180]  domain-0: span=0-1 level=MC
[   74.691244]   groups: 1:{ span=1 cap=159 }, 0:{ span=0 cap=155 }
[   74.693453]   domain-1: span=0-1,4,6 level=PKG
[   74.693534]    groups: 0:{ span=0-1 cap=314 }, 4:{ span=4 cap=496 },
6:{ span=6 cap=986 }
...
[   74.697890] root domain span: 0-1,4,6
[   74.697994] root_domain 2-3,5,7: pd6:{ cpus=6-7 nr_pstate=4 } pd4:{
cpus=4-5 nr_pstate=4 } pd0:{ cpus=0-3 nr_pstate=4 }
[   74.698922] root_domain 0-1,4,6: pd6:{ cpus=6-7 nr_pstate=4 } pd4:{
cpus=4-5 nr_pstate=4 } pd0:{ cpus=0-3 nr_pstate=4 }


  sd = rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));


Tasks running in '/' only have the sd to reduce the CPU affinity correctly.

...
[001] 5290.935663: select_task_rq_fair: kworker/u33:3 382 prev_cpu=0
[001] 5290.935696: select_task_rq_fair: kworker/u33:3 382 prev_cpu=0
pd=6-7 online=0-7 sd=0-1,4,6 cpus_ptr=0-7
[001] 5290.935753: select_task_rq_fair: kworker/u33:3 382 prev_cpu=0
pd=4-5 online=0-7 sd=0-1,4,6 cpus_ptr=0-7
[001] 5290.935779: select_task_rq_fair: kworker/u33:3 382 prev_cpu=0
pd=0-3 online=0-7 sd=0-1,4,6 cpus_ptr=0-7
...

