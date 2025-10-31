Return-Path: <linux-kernel+bounces-880775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C5C26881
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA66E3B2E38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEEC350A06;
	Fri, 31 Oct 2025 18:11:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC320C463
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934301; cv=none; b=SxbZfO3AOgZEzWmugh1JfpNRSmIgIkfVCZu8N9EBr/hKBMLhfkv22Aooxth8khOvs/ORcvTqUq99KC7fFl6tkDLMzOxJUXzijxmRcYSBrTnx1b/DI2ls4IGgycn1S7NLfspNs4UY9vxwAmnm7LYvTN2JhXhsOZ4bO7qZuA+7J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934301; c=relaxed/simple;
	bh=Ocs1LIGoQLo0z5g0j/XDTnhDfuWfTKP304ubqCd81CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYsucHzM4HD82lN2K6Llkx1g2XZgj99AeRCiRftkNu5uYvy75AnAPk/EP2FMDxpQspOx80/sYC08LzWxQtHrvMM1yPOGlWJLAJ0uuwzC0jrymBYykbcysn3b/jQXHJZp86+ukgsI5kPdQ2Q8iKRHZrA4ITasvMGntQbzg/psquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 640341595;
	Fri, 31 Oct 2025 11:11:30 -0700 (PDT)
Received: from [10.57.37.29] (unknown [10.57.37.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039003F8C6;
	Fri, 31 Oct 2025 11:11:34 -0700 (PDT)
Message-ID: <fb34c6d2-291e-4b03-bfd8-372a6cd464ba@arm.com>
Date: Fri, 31 Oct 2025 18:11:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Shubhang Kaushik <sh@gentwo.org>,
 Shijie Huang <Shijie.Huang@amperecomputing.com>,
 Frank Wang <zwang@amperecomputing.com>
Cc: Christopher Lameter <cl@gentwo.org>, Adam Li
 <adam.li@amperecomputing.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
 <394a9798-06e4-4e61-b081-eeecbc67a22d@arm.com>
 <MW6PR01MB8368CC4C901DBAF9BE19579EF5F8A@MW6PR01MB8368.prod.exchangelabs.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <MW6PR01MB8368CC4C901DBAF9BE19579EF5F8A@MW6PR01MB8368.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 16:59, Shubhang Kaushik OS wrote:
> Yes, I agree that EAS approach is not suitable in this case as they require a heterogenous CPU topology.
> The issue is that the existing checks are for a completely idle CPU, whereas `cpu_overutilized` implies
> the CPU is busy but not yet overloaded. I ventured into EAS as this `cpu_overutilized` relies on
> `sched_energy_enabled()` being active. The point I wanted to convey is that - we still need a `cpu_busy?`
> check to make use of the cache locality - for SMP systems. Would appreciate some pointers on the same lines..

So the main issue is that with existing code if a CPU is "overloaded" isn't all that well defined.
For EAS we know if !rd->overloaded => all CPUs are !cpu_overutilized(). We could just pick any where
the task still fits (and we do).
For SMP what 'overloaded' will actually mean depends on the rest of the system (or at least domain). 


> Regards,
> Shubhang
> [sip]

