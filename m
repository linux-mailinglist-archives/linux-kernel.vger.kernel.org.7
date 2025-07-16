Return-Path: <linux-kernel+bounces-734064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350EB07CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FB67AAB26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50AE29A300;
	Wed, 16 Jul 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="L3B1MJn5"
Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A3293C60
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690008; cv=none; b=MYx9e5MvZQqNP4ai1Dhght9NGm7y2Rydci3PN0vpZRxTyNseBv0o+nlgnLT5034nrhrAyDs5+igA9pBmMDhxDbczHl8mU40uJ4sdiSAdgsYm9Kv6ZQq4RT+SyWeJZa8Sbsrf/J+/oiIeM0l3+9+N5cELfLwDd9vRrvMD5S8rctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690008; c=relaxed/simple;
	bh=UXDq76QcHfQcob22kc3Ti66fdIyDj1Elb1GfW4AzB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMI4Lq892XoCWnRImCmkUJRc+oVBCn/rR5YnwRFPC3hutGbSQGS1kbEBjvneLCXCMbeRnvk5ZuEowfBpEcRojDbfuNEozFwqjzrHERY4jg1BBj0I1o4wYYIuwZjpG5OL4lxAJn2oxquZDr4NEZy7PZ/bPDsSqsDhpjJPaberz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=L3B1MJn5; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 18FCBA0005;
	Wed, 16 Jul 2025 18:19:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=w0MYgwTmMLKpGiMa0739mReOceioqC+7wOwm6DcGSdU=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:to:in-reply-to:date:cc:subject:mime-version:message-id:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752689995; v=1;
	b=L3B1MJn5rJF47ONjcpoHdYpsLe13LSw1oGk0QpZ8fD5EfSg/TJHDPV7inrk1libVzl1kH62x
	7g848EKbLwBqOZZXst4Mavn5Tu/ZhX/UYS2pjX+WcOqaz7Xkv4DCooJsDw3OMENNKZUt/5ObaZX
	/FgnCnmCG4rR3rq9Hd4VHHF8=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 37FEFA0002;
	Wed, 16 Jul 2025 18:19:55 +0000 (UTC)
Date: Wed, 16 Jul 2025 19:19:53 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Chris Mason <clm@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server
 handling
Message-ID: <khfhrdrxesp645dy7hphefvovhfarjke2qn5nvldyjavhg2j7p@vbv3jsskhc2j>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.465086194@infradead.org>
 <22aju4edxl4hf7tihzl6672cg234eam5kcgazxbf2ga5thsmm6@l2wwkn2wth7r>
 <3c67ae44-5244-4341-9edd-04a93b1cb290@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3c67ae44-5244-4341-9edd-04a93b1cb290@meta.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752689995890563792.2206.3876445093170258710@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=FN3hx/os c=1 sm=1 tr=0 ts=6877ed4b
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
	a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8 a=98rf8SrY6nUp-J8-n5cA:9
	a=PUjeQqilurYA:10 a=gKebqoRLp9LExxC7YDUY:22

On Tue, Jul 15, 2025 at 10:55:03AM -0400, Chris Mason wrote:
> On 7/14/25 6:56 PM, Mel Gorman wrote:
> > On Wed, Jul 02, 2025 at 01:49:26PM +0200, Peter Zijlstra wrote:
> >> Chris reported that commit 5f6bd380c7bd ("sched/rt: Remove default
> >> bandwidth control") caused a significant dip in his favourite
> >> benchmark of the day. Simply disabling dl_server cured things.
> >>
> > 
> > Unrelated to the patch but I've been doing a bit of arcology recently
> > finding the motivation for various decisions and paragraphs like this
> > have been painful (most recent was figuring out why a decision was made
> > for 2.6.32). If the load was described, can you add a Link: tag?  If the
> > workload is proprietary, cannot be described or would be impractical to
> > independently created than can that be stated here instead?
> > 
> 
> Hi Mel,
> 
> "benchmark of the day" is pretty accurate, since I usually just bash on
> schbench until I see roughly the same problem that I'm debugging from
> production.  This time, it was actually a networking benchmark (uperf),
> but setup for that is more involved.
> 
> This other thread describes the load, with links to schbench and command
> line:
> 
> https://lore.kernel.org/lkml/20250626144017.1510594-2-clm@fb.com/
> 
> The short version:
> 
> https://github.com/masoncl/schbench.git
> schbench -L -m 4 -M auto -t 256 -n 0 -r 0 -s 0
> 
> - 4 CPUs waking up all the other CPUs constantly
>   - (pretending to be network irqs)

Ok, so the 4 CPUs are a simulation of network traffic arriving that can be
delivered to any CPU. Sounds similar to MSIX where interrupts can arrive
on any CPU and I'm guessing you're not doing any packet steering in the
"real" workload. I'm also guessing there is nothing special about "4"
other than it was enough threads to keep the SUT active even if the worker
tasks did no work.

> - 1024 total worker threads spread over the other CPUs

Ok.

> - all the workers immediately going idle after waking

So 0 think time to stress a corner case.

> - single socket machine with ~250 cores and HT.
> 

To be 100% sure, 250 cores + HT is 500 logical CPUs correct? Using 1024 would
appear to be an attempt to simulate strict deadlines for minimal processing
of data received from the network while processors are saturated. IIUC,
the workload would stress wakeup preemption, LB and finding an idle CPU
decisions while ensuring EEVDF rules are adhered to.

> The basic recipe for the regression is as many CPUs as possible going in
> and out of idle.
> 
> (I know you're really asking for these details in the commit or in the
> comments, but hopefully this is useful for Link:'ing)
> 

Yes it is. Because even adding this will capture the specific benchmark
for future reference -- at least as long as lore lives.

Link: https://lore.kernel.org/r/3c67ae44-5244-4341-9edd-04a93b1cb290@meta.com

Do you mind adding this or ensure it makes it to the final changelog?
It's not a big deal, just a preference. Historically there was no push
for something like this but most recent history was dominated by CFS.
There were a lot of subtle heuristics there that are hard to replicate in
EEVDF without violating the intent of EEVDF.

I had seen that schbench invocation and I was 99% certain it was the
"favourite benchmark of the day".  The pattern seems reasonable as a
microbench favouring latency over throughput for fast dispatching of work
from network ingress to backend processing. Thats enough to name a mmtests
configuration based on the existing schbench implementation. Maybe something
like schbench-fakenet-fastdispatch.  This sort of pattern is not even that
unique as such as IO-intensive workloads may also exhibit a similar pattern,
particularly if XFS is the filesystem. That is a reasonable scenario
whether DL is involved or not.

Thanks Chris.

-- 
Mel Gorman
SUSE Labs

