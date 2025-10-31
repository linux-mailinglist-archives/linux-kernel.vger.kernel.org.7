Return-Path: <linux-kernel+bounces-880463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61214C25CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2988C188622B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E16286D7E;
	Fri, 31 Oct 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MZcH3eUy"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96185285CAA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923731; cv=none; b=GdagmNP7PV3HEuLBxqehTyzSTTfxpYg2Wy/ffEfsfBYUnxKQAv7F3qJN+thRQMGyQRfWuK+ExQNauy7hsjis91CHubCPKhqw0u00s7FH1ru4KyF0sOkvryoRhnFmeSoOxmvQa5uI2M2liMUtLTBhnRdkQyZEDhTWfY0YvpWYBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923731; c=relaxed/simple;
	bh=1oYnLbRCoeY9eYtBXIECp+LyBXZRne6+RskDU9KXm3o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGti3Ug24ne4u8bIZ2BqhHcJ1FmWYn4gI3v5FlSa3RWRyeyBPE1+7rBCvfnZ3kRbPNUyiY5FHr3QDbus6lfC3hSsjMFqnLwraGOTqVOsqTlw4jaaZhloRPFaV1XZiCdkh6iH2VW8g9FW2RUzrAHRDgyWU9UEp72gLPGO1f8gIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MZcH3eUy; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VBGfrc332618;
	Fri, 31 Oct 2025 08:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=UHdFApkfoxk84jIiN6ISYuO/8
	QpCtj2sEMRNWbPQwd4=; b=MZcH3eUyizcNj1euCxr2K4UqQFPz+34ltJ1jnoPT4
	9lxKfql6pfLrHPlUxiDZrnIHoxRuIQrVWvwcm+H0s6aStTF3pRGtJxMfGHf1Up9y
	Q2LgDUIlUqqeHZKMhqdWG51yKMIr1DJJgXg9IXjNAN2teKEbcRPc4tzkvff0JprU
	4vhI9vxy1na+pffoOTEZgAeO6xB5N4QwueRtuaW46jmpqFS5Ef5vRALbgtfD9ehr
	sj1wLiiKD1hW5BXfAhRhUXfJWBikEGucQNvVx0BTSVCDtU7HiUrmNai1xruLQf2J
	S9zbCTO1MfRWhNEAWEOT8j2CujEu4V6Y/9J62VY5GNcfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a4v3bgnjy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 08:14:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 31 Oct 2025 08:15:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 31 Oct 2025 08:15:04 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id EC1A13F70B3;
	Fri, 31 Oct 2025 08:14:50 -0700 (PDT)
Date: Fri, 31 Oct 2025 20:44:49 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Tejun Heo <tj@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding work scheduling
Message-ID: <20251031151449.GA555491@kernel-ep2>
References: <aJsoMnkoYYpNzBNu@opensource>
 <aJuNcM-BfznsVDWl@slm.duckdns.org>
 <aJ1eElydTbZfBq5X@opensource>
 <20250814094831.GT4067720@noisy.programming.kicks-ass.net>
 <aKRdeqpzopOC4sKV@opensource>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aKRdeqpzopOC4sKV@opensource>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzNyBTYWx0ZWRfX1wYUGTNspu/U
 Z0vrY4ZwrDg3C/Bk/WLRPdA6l4dj1iM4lYfC7yCYlRcrfdBRg7c6Z+jp1K8YbkGi5I1AHLkZbkn
 CxruAUpBsGtuYd+rQUEC0r3CzvXCAF272McaZs87KNESyHopwQckpgDqYcUSCnfG1I1VMaY6Zuw
 C1M8ZPsyrVgB77Kq/8PgNwmqqvvzKsYdiVNheaemK9HettIeFS6mmVBq4b+ZkaMTcZOK755iu07
 Lp0bg79oiMJ+ml0eijyDIV7D0h8qDgw9ljeLkI8gfhS62Pt6r59zXxQLm368skwCUcLvNeZ1LUJ
 dp6ODvfOh/PjmKvqiWnwC6SMGeNQrZCHeyaCVclVTrRwaMAps4eSsto2uiCNS4nxN154YM1PszI
 lBM8JH3191eaf0speu49IM1Lgn9IPw==
X-Proofpoint-GUID: Q6LNCAp-J1AZTQ6pVcoBV_HUF3JsDmep
X-Proofpoint-ORIG-GUID: Q6LNCAp-J1AZTQ6pVcoBV_HUF3JsDmep
X-Authority-Analysis: v=2.4 cv=Qp9THFyd c=1 sm=1 tr=0 ts=6904d26e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
 a=mh-wHXR_greknYcI6TEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01

Hi Peter,

On 2025-08-19 at 16:48:18, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> Hi Peter,
> 
> On 2025-08-14 at 09:48:31, Peter Zijlstra (peterz@infradead.org) wrote:
> > On Thu, Aug 14, 2025 at 03:54:58AM +0000, Subbaraya Sundeep wrote:
> > > Hi Tejun,
> > > 
> > > On 2025-08-12 at 18:52:32, Tejun Heo (tj@kernel.org) wrote:
> > > > Hello,
> > > > 
> > > > On Tue, Aug 12, 2025 at 11:40:34AM +0000, Subbaraya Sundeep wrote:
> > > > > Hi,
> > > > > 
> > > > > One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
> > > > > see more delay in their applications shutdown time.
> > > > > To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
> > > > > apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
> > > > > During interrupt handler work is queued and messages are processed in work handler.
> > > > > I calculated the latencies (time between work queued and work execution start) of 6.1
> > > > > and 6.16 and below are the observations
> > > > > 
> > > > > 
> > > > > 6.1 mainline
> > > > > ------------
> > > > > Total samples: 4647
> > > > > Min latency: 0.001 ms
> > > > > Max latency: 0.195 ms
> > > > > Total latency: 7.797 ms
> > > > > 
> > > > > Latency Histogram (bucket size = 0.01 ms):
> > > > > 0.00 - 0.01 ms: 4644
> > > > > 0.01 - 0.02 ms: 1
> > > > > 0.03 - 0.04 ms: 1
> > > > > 0.19 - 0.20 ms: 1
> > > > > 
> > > > > ==================
> > > > > 
> > > > > 6.16 mainline
> > > > > -------------
> > > > > Total samples: 4647
> > > > > Min latency: 0.000 ms
> > > > > Max latency: 4.880 ms
> > > > > Total latency: 158.813 ms
> > > > 
> > > > Difficult to tell where the latencies are coming from. Maybe you can use
> > > > something like https://github.com/josefbacik/systing to look further into
> > > > it? All the scheduling events are tracked by default and you should be able
> > > > to add tracepoints and other events relatively easily. You can also set
> > 
> > > Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
> > > or deamons running in background and taking CPU time in between.
> > 
> > Well, something is running. So there must be competing runnable tasks.
> > 
> > > I suspect this has something to do with EEVDF scheduling since this behavior is
> > > seen from 6.6 (please note I may be wrong completly).
> > 
> > EEVDF is stricter in a sense than CFS was, is looks like the workqueue
> > thread just ran out of cycles and is made to wait.
> > 
> I am a complete beginner in this area. If a work function has executed
> thousands of times by a kworker then will it be made to wait a little longer after
> some invocations since kworker has taken too much of CPU time already?
> Or the accounting starts from the moment kworker became runnable from
> sleep state only? Sorry if I am not making any sense but I want to understand
> below:
> 1. kworker sleeping -> waking up and running a function -> sleeping
> 
> Above can be done n number of times and scheduler is always in favor of
> kworker and picks it when it becomes runnable since new runnable task
> Or
> Scheduler knows that CPU has executed kworker thread lot of time
> (runtime of each invocation is tracked) so starts delaying the kworker
> for execution.
> 
> > > Are there any methods or options with which I can bring back CFS scheduling behavior
> > > maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 
> > 
> > We have a lot of knobs; but not one that says: do-what-I-want.
> > 
> > If you push a ton of work into a workqueue and have competing runnable
> > tasks; why do you think it isn't reasonable to have the competing tasks
> > run some of the time?
> > 
> > You can maybe push the slice length up a bit -- it was fixed to the
> > small side of the CFS dynamic slice. But who knows what your workload is
> > doing.
> Workload is like
> 1. userspace writes message in hw shared mbox region
> 2. triggers interrupt to PF
> 3. PF receives interrupt and queues work for processing message and sends response
> 3. userspace polls for response in while(1)
> 
> So on a single cpu system userspace while(1) code and kernel workqueue function
> are competing whereas userspace while(1) code actually depends on workqueue
> function execution in kernel.
> I am doing more experiments and will update you. Thanks for the reply
> and your time.

Sorry for long delay. I suggested customer to use sleep instead of busy loop in
their application then latencies are gone and they are okay with it.

Thanks,
Sundeep
> 
> Sundeep

