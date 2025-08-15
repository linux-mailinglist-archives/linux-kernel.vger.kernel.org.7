Return-Path: <linux-kernel+bounces-770907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668EB28045
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF901C815ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786BB3019B5;
	Fri, 15 Aug 2025 13:01:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC08301473
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262910; cv=none; b=b6OPeG5YRJ+eBlgb50URaO4di7x9LRvU/o3PZnEiKZznFJ7dAHJgDJ/RTzJv/PffhCYK19T01T18ukz4cM1Uz2neUnVoUySsa3+FbeOZwm5oO5nsIUiasvZp+1UpeZjTACTXA34lwPwxlLYEVa3V71UzioF6Km720TNnas1JDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262910; c=relaxed/simple;
	bh=p3ts8SEPNU1vGXzWOXjsQ/TXF02IfEGsUNIFCv8S78c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL3bZIy9C1Ak4eIuJvjjw3clBvRvitg/w2s82e820XRE+NzBfvCi3dGpmehTt6hoMFoaPYJIhSE/sMoUJBVeXJkh4guD6EZ1QUJdziwZ3Db93WU50T1dpGjz9SIzY4XVix4vtkFbh9kntRYNaoRvpICoETKhCd0Pqi1RwEaCRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B7E1691;
	Fri, 15 Aug 2025 06:01:39 -0700 (PDT)
Received: from [172.24.48.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55D33F792;
	Fri, 15 Aug 2025 06:01:42 -0700 (PDT)
Message-ID: <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com>
Date: Fri, 15 Aug 2025 14:01:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Xuewen Yan <xuewen.yan94@gmail.com>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, vdonnefort@google.com, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org
References: <20250812093339.8895-1-xuewen.yan@unisoc.com>
 <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-GB
In-Reply-To: <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.08.25 10:52, Xuewen Yan wrote:
> Hi Dietmar,
> 
> On Thu, Aug 14, 2025 at 4:46 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 12.08.25 10:33, Xuewen Yan wrote:

[...]

>> Can you not mask cpus already early in the pd loop (1) and then profit
>> from (2) in these rare cases?
> 
> I do not think the cpus_ptr chould place before the pd_cap calc,
> because the following scenario should be considered:
> the task's cpus_ptr cpus： 0,1,2,3
> pd's cpus: 0,1,2,3,4,5,6
> the pd's cap = cpu_cap * 6;
> if we cpumask_and(pd'scpus, p->cpus_ptr),
> the cpumask_weight = 4,
> the pd's cap = cpu_cap *4.

Yes, you're right! Missed this one.

>> IIRC, the sd only plays a role here in
>> exclusive cpusets scenarios which I don't thing anybody deploys with EAS?
> 
> I am also wondering if the check for SD's CPUs could be removed...

Still not 100% sure here. I would have to play with cpusets and EAS a
little bit more. Are you thinking that in those cases p->cpus_ptr
already covers the cpuset restriction so that the sd mask isn't necessary?

