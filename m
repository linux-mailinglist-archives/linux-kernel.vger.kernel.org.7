Return-Path: <linux-kernel+bounces-775517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121DFB2C019
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090DC5848A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAD7326D5C;
	Tue, 19 Aug 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BtxU5Nll"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40479F5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602329; cv=none; b=j1VuDnLg9TPct1FK3M9u7rpwaoevGz/lhXcNaROlMup9QTcLi6a4UQE+i10uGoMqTocfBVHXaS65tgJMgXfZiNhQnDW4so3Akm4wZbVu+R6AS9/pfBCo9hnRvJ5Vd28vHpORcHl4d0p+8k+/8ueO/46whlx8hXO5e93xgR5MUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602329; c=relaxed/simple;
	bh=0lF8D5bmnqpXbfl7UDjNxq+tMwiAbY2U4sbn7a/0Hy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKnv8zF77bA1DVixh54Gz7IoH2rXdR0XmjbK8asFX69FIRvZCMOZUf1O9tOL8IDi8rhVnM4sZeuX+gZ4PQwdxE76Ad+tvYOUBmZvvnOwfUFShlXjjC2eXgJm0UaVDLEHPlYq8t9TmMVXwWqd1BopUEq2fG2g3XCKkWG0qX0Z6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BtxU5Nll; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7lfPd013482;
	Tue, 19 Aug 2025 04:18:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=p3bfwEpPFEyzrqACjcaex+OfF
	b7Av7uzgFSar84pTq4=; b=BtxU5NllxaVCJo9Bgum93u/8rOLHMZSzFqzH4noGC
	Ok0eJstAeFBbNBLxJfybU/OCv4y9qb6dX17BBsq2TVlpKnDnA8ayixsuQDh8W0wx
	ELuiOkXrj78X2wkb6ecmLBQOhg+nkBs7eZaHeTWAQaitu3haA5B6FFRkzEhmyJX/
	uKc4vdWO3OZo6HeOLoulD2OzZQHC7ySz1GfdzzMsmrZ3K0ZdO5s7w6SEzMHkJHNh
	j7uk3hYPc7pCjFdencAuIIPwU4GEZgCT6M3nn+3GXT1myvQAiuo9PPI5tTNWg9jW
	Uy/oR14hnjBFPXm4JQSZlp1/Qx0kyFRtD3Tn+k/Mk9Awg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48mn6hgbn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:18:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 Aug 2025 04:18:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 Aug 2025 04:18:27 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id 385113F7051;
	Tue, 19 Aug 2025 04:18:18 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:18:18 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Tejun Heo <tj@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding work scheduling
Message-ID: <aKRdeqpzopOC4sKV@opensource>
References: <aJsoMnkoYYpNzBNu@opensource>
 <aJuNcM-BfznsVDWl@slm.duckdns.org>
 <aJ1eElydTbZfBq5X@opensource>
 <20250814094831.GT4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814094831.GT4067720@noisy.programming.kicks-ass.net>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDEwNiBTYWx0ZWRfX72KVUVwZiVUp KYqSWE6L5T9E6bKeZ9JfqYd2ziQXNhb/9VHGkSZTQR71PWOB0EaJovuWODfMXX7aAQV8qZAvgnH olDRYGLczUnCBW6P0KZMjD0f2BhLSiE3CBFF2eE/MmvwiX+o+WFeoBVlhGQXhp+EbpE3Mi73ihp
 igfWqyx9hJac4PG0TJUAHTyF6u8Emf2glC7g3eY1293sWigCL7wTQOfApFFDOY17+spkjCna82a XtwaS1Bcc+2ufFEteOXtEG2wXdxjttsdzadDvmeV4CGG1AqMl2itZ8zui+gcZPuC6qS8PPFEOyW 0hX2yFOMEiobEHgtdTad1Umgx9b2rn8xSujsOct4BdU6sG0N8Z2gw/NYEZRfE1g+HmIwwwA3Fy9
 zeZGf80Mjjf3LPhh0dqUswS/UvGV7nfmXTOzxTPabkmEnLIBig0A9fFuM3mtKOgbyBw+3DrI
X-Authority-Analysis: v=2.4 cv=W6s4VQWk c=1 sm=1 tr=0 ts=68a45d80 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=COQOnVr6OCEAhJb8B7IA:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: XlO8dV5maz5KSFaJQI7GbOe24H8QT-nM
X-Proofpoint-GUID: XlO8dV5maz5KSFaJQI7GbOe24H8QT-nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01

Hi Peter,

On 2025-08-14 at 09:48:31, Peter Zijlstra (peterz@infradead.org) wrote:
> On Thu, Aug 14, 2025 at 03:54:58AM +0000, Subbaraya Sundeep wrote:
> > Hi Tejun,
> > 
> > On 2025-08-12 at 18:52:32, Tejun Heo (tj@kernel.org) wrote:
> > > Hello,
> > > 
> > > On Tue, Aug 12, 2025 at 11:40:34AM +0000, Subbaraya Sundeep wrote:
> > > > Hi,
> > > > 
> > > > One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
> > > > see more delay in their applications shutdown time.
> > > > To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
> > > > apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
> > > > During interrupt handler work is queued and messages are processed in work handler.
> > > > I calculated the latencies (time between work queued and work execution start) of 6.1
> > > > and 6.16 and below are the observations
> > > > 
> > > > 
> > > > 6.1 mainline
> > > > ------------
> > > > Total samples: 4647
> > > > Min latency: 0.001 ms
> > > > Max latency: 0.195 ms
> > > > Total latency: 7.797 ms
> > > > 
> > > > Latency Histogram (bucket size = 0.01 ms):
> > > > 0.00 - 0.01 ms: 4644
> > > > 0.01 - 0.02 ms: 1
> > > > 0.03 - 0.04 ms: 1
> > > > 0.19 - 0.20 ms: 1
> > > > 
> > > > ==================
> > > > 
> > > > 6.16 mainline
> > > > -------------
> > > > Total samples: 4647
> > > > Min latency: 0.000 ms
> > > > Max latency: 4.880 ms
> > > > Total latency: 158.813 ms
> > > 
> > > Difficult to tell where the latencies are coming from. Maybe you can use
> > > something like https://github.com/josefbacik/systing to look further into
> > > it? All the scheduling events are tracked by default and you should be able
> > > to add tracepoints and other events relatively easily. You can also set
> 
> > Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
> > or deamons running in background and taking CPU time in between.
> 
> Well, something is running. So there must be competing runnable tasks.
> 
> > I suspect this has something to do with EEVDF scheduling since this behavior is
> > seen from 6.6 (please note I may be wrong completly).
> 
> EEVDF is stricter in a sense than CFS was, is looks like the workqueue
> thread just ran out of cycles and is made to wait.
> 
I am a complete beginner in this area. If a work function has executed
thousands of times by a kworker then will it be made to wait a little longer after
some invocations since kworker has taken too much of CPU time already?
Or the accounting starts from the moment kworker became runnable from
sleep state only? Sorry if I am not making any sense but I want to understand
below:
1. kworker sleeping -> waking up and running a function -> sleeping

Above can be done n number of times and scheduler is always in favor of
kworker and picks it when it becomes runnable since new runnable task
Or
Scheduler knows that CPU has executed kworker thread lot of time
(runtime of each invocation is tracked) so starts delaying the kworker
for execution.

> > Are there any methods or options with which I can bring back CFS scheduling behavior
> > maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 
> 
> We have a lot of knobs; but not one that says: do-what-I-want.
> 
> If you push a ton of work into a workqueue and have competing runnable
> tasks; why do you think it isn't reasonable to have the competing tasks
> run some of the time?
> 
> You can maybe push the slice length up a bit -- it was fixed to the
> small side of the CFS dynamic slice. But who knows what your workload is
> doing.
Workload is like
1. userspace writes message in hw shared mbox region
2. triggers interrupt to PF
3. PF receives interrupt and queues work for processing message and sends response
3. userspace polls for response in while(1)

So on a single cpu system userspace while(1) code and kernel workqueue function
are competing whereas userspace while(1) code actually depends on workqueue
function execution in kernel.
I am doing more experiments and will update you. Thanks for the reply
and your time.

Sundeep

