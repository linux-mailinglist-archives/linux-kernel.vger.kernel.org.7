Return-Path: <linux-kernel+bounces-775568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2358B2C0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256EE1748FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F130E842;
	Tue, 19 Aug 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CrTQpBQ/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185527A44A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603389; cv=none; b=hVxECRXJGAUA2zhnh3F9FkQIrP5rBLoFrhfdahgcwSMl1gYTaZEweDr/rmwJgKmcPW227w29o/rDcoXgMha2+mbfRX39UjmvbWGHn09j2vzd+prYOYyOLfppSdL6FdBlVrCEBZPPXETEYGcwk4BePgrh4sLpds+39xirLURWxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603389; c=relaxed/simple;
	bh=UJ+m3mf0fpmij/pKpqpNOIZ0kRdrBkPZrblmP60z1+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa3VFuq7zm9xz4DkMzwHvyjyiKmek9DZWnQlyhqvMF3/ipCm0dFkubviMTX4FNFuJoY2huidASin+4PauuXTawqEjxctNvt8cDsU0LBTxR5oXtJpt4WUufWtd7pZ6DVW+M3Za890D9w5+ew+Yr6wOxNCRAh2r2tFvkOSYMs+15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CrTQpBQ/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J7IlJJ006786;
	Tue, 19 Aug 2025 04:36:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EISOL0zLfLb/BnOrkvBsdpF27
	DoIJhs2EM0Pd9mz614=; b=CrTQpBQ//fup6Oa+dVgyfKGfD6W8FgkZ2GmYQYhlQ
	jVGq41W+hd2JrjTm8ncxwENetLRmVD7M08fE5SH29rpFCk7WuQPldR0yY5I49hnv
	/UWGYFMrI4JQoru9Mu5qThZhwktAxvQgPHVGmjLHR+QAUMVgfkpUf06cee86A1F0
	3CJXP46TN+DBAIaVUTSIpv0UAh3vE7Ys+eBmDtkrnqqJH49Q4Anf8DVVaXiFa4HC
	5dCqeyz0gy+DGSA14T5XuvkToJ4Ap/Z3gW5vH75FMcGtesmAtY1yhLQ/cn0FmYVH
	UNi0O6ZiLjET1R3tXLIEl9Y+7cfRsec9uxVhPco6OIwlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48mdx0h6hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 04:36:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 19 Aug 2025 04:36:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 19 Aug 2025 04:36:13 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id 4895B3F7060;
	Tue, 19 Aug 2025 04:36:05 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:36:04 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Tejun Heo <tj@kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding work scheduling
Message-ID: <aKRhpN8ES2kJYtSF@opensource>
References: <aJsoMnkoYYpNzBNu@opensource>
 <aJuNcM-BfznsVDWl@slm.duckdns.org>
 <aJ1eElydTbZfBq5X@opensource>
 <20250814134550.4b64b4ec@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814134550.4b64b4ec@gandalf.local.home>
X-Proofpoint-GUID: AmyuVdud9EMcHOFgeG04dZmWCtIsgjk2
X-Proofpoint-ORIG-GUID: AmyuVdud9EMcHOFgeG04dZmWCtIsgjk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDEwOSBTYWx0ZWRfX/nBDk4Tg/cOB pY1XX1ODKI1ORZ9etQxfPQXfhzanoVdjppqZocvR0uU8odB6aOMTL5BGXS9nlj6FvxRe12FmK3k 1RdZAXaD4GXSoo8aUOMRmF8KDNWn0x2PaDDoAsh2ShxUQWeT4we7GKvuzq/brWEJzqtwRQ4Vkt6
 9nqGhyJHySSJEhulSaOisJSIMbp4kvgP57igAqGeDsOl/1pKQSHxkcTUh2P86piQMWwkpvp36P2 J3mT7tjQ+EmqfHBCy/O0E34MIlW0JyqINdfj1TU2sNWAn02PSnUwoewxVejZpcmlQ0Au4wkPro7 MfcC4dOclFtkjQAKYHebvLUWldVCfArJOagaRcG4SulI23vlEVRkYl/ukOLblUjOs2FJlkyc6Xj
 +rlzXzI9t9lGgVsWCk6+EVUrkWwk3H013ubDQuOOfcUdBnF4NZqcXs4uzvWA1lmyNcz6up/r
X-Authority-Analysis: v=2.4 cv=D4hHKuRj c=1 sm=1 tr=0 ts=68a461aa cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=meVymXHHAAAA:8 a=M5GUcnROAAAA:8 a=dt7d_CYpqsXmH-BrFGkA:9
 a=MLVIlzEZYiiJoUA7:21 a=CjuIK1q_8ugA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

Hi Steven,

On 2025-08-14 at 17:45:50, Steven Rostedt (rostedt@goodmis.org) wrote:
> On Thu, 14 Aug 2025 03:54:58 +0000
> Subbaraya Sundeep <sbhatta@marvell.com> wrote:
> 
> > > Difficult to tell where the latencies are coming from. Maybe you can use
> > > something like https://github.com/josefbacik/systing to look further into
> > > it? All the scheduling events are tracked by default and you should be able
> > > to add tracepoints and other events relatively easily. You can also set  
> 
> > Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
> > or deamons running in background and taking CPU time in between.
> > I will try building systing and running it. 6.16 histogram shows that it
> > is not one high latency event causing overall latency but bunch of small
> > latencies are adding up and causing big latency.
> > I suspect this has something to do with EEVDF scheduling since this behavior is
> > seen from 6.6 (please note I may be wrong completly).
> > Are there any methods or options with which I can bring back CFS scheduling behavior
> > maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 
> 
> You could also use tracefs as that works on busybox:
> 
>  # echo 0 > /sys/kernel/tracing/tracing_on
>  # echo 1 > /sys/kernel/tracing/events/sched/sched_switch/enable
> [ and perhaps even more events ]
>  # echo 1 > /sys/kernel/tracing/tracing_on
>  # <run test>; echo 0 > /sys/kernel/tracing/tracing_on
>  # cat /sys/kernel/tracing/trace

Thank you for tracefs. I use it extensively and using timestamps in trace
data calculated the latencies.
> 
> You could even make it a trace.dat file:
> 
>  # mkdir /tmp/tracing
>  # cp -r /sys/kernel/tracing/events /tmp/tracing/
>  # cp -r /proc/kallsyms /tmp/tracing/
> [ have bs be PAGE_SIZE for your architecture ]
>  # dd bs=4096 if=/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw of=/tmp/tracing/trace0.raw
>  # cd /tmp
>  # tar cvf trace.tar tracing
> 
> Copy trace.tar to a desktop and extract it.
> 
>  $ cd /tmp
>  $ tar xvf trace.tar
> [ Make sure you have the latest trace-cmd installed ]
>  $ trace-cmd restore -t /tmp/tracing/ -k /tmp/tracing/kallsyms -o /tmp/trace.dat /tmp/tracing/trace0.raw 
>  $ trace-cmp report /tmp/trace.dat
> 
> Now you can send us the trace.dat file and we could analyze it more.
> 
> You could also enable more events than just sched_switch, like sched_waking
> and such.
> 
I am on it. Thanks for the commands and your time.

Sundeep
> -- Steve

