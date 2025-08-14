Return-Path: <linux-kernel+bounces-769398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC04B26DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FE958864F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2230E855;
	Thu, 14 Aug 2025 17:45:13 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC230E0EB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193513; cv=none; b=W5LwkZyMq02RaeoWUGDyNxCvbUPMz2DbxcxDNpfC7DOqpok3bymts0vhoPbdXTHzJa1ErGEZWPB8cMkI59peT/KDaQ68avQTimLXF9x0DPdcKo5hk+FHzWm3sIHSzMBt6o+hKH9ta5ESeltF3yMcrpzDrHi8KiGY9whpIR0IyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193513; c=relaxed/simple;
	bh=ye665OHhEj8eMVpg3jz0Cy8eJCdH71iWC6LtiWDIAd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmbOtbhIEwWQYNlZ+bsJ/u2L0/8Qm7OAHqkO3hPNW65Cn2l3a1olL7eWZkHMrFxJcxtnk8Qi7GtnsuALzeV6sZVmxB4RFadxevEU2i3rXqlBaEN/0P6I3Vc0YWcTOwlbIvKw3VtEh78BgEpn9BUuwZppPthMggeG+kkx2obkVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A9781834EA;
	Thu, 14 Aug 2025 17:45:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 26A3020028;
	Thu, 14 Aug 2025 17:45:01 +0000 (UTC)
Date: Thu, 14 Aug 2025 13:45:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Tejun Heo <tj@kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
 <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
 <dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <jiangshanlai@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: Query regarding work scheduling
Message-ID: <20250814134550.4b64b4ec@gandalf.local.home>
In-Reply-To: <aJ1eElydTbZfBq5X@opensource>
References: <aJsoMnkoYYpNzBNu@opensource>
	<aJuNcM-BfznsVDWl@slm.duckdns.org>
	<aJ1eElydTbZfBq5X@opensource>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 26A3020028
X-Stat-Signature: skr6qcfwfhegazybsqjg8otxdx8jsoz6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Zd9o4hEb8pGNahhfTLszo7EngprtAtPw=
X-HE-Tag: 1755193501-227626
X-HE-Meta: U2FsdGVkX19+Xui8NpOik1DvnhBtReDCDJp8D+sQQpTNJ8uNj00Lp+av3BJzzZjit8ZQ22QEdvLMQTsJmNf5gKV4g/mMIEG7pAkZ6Mjk2YBTErzPTgwv9VP4PAwgpH9jnGrfPgvKhgg4TrCOkW15qtiMI589k36Nn8pZX9jJAdTSWIwHxJgFyyQKLGBnmaiHxQ33eYpb8C+/cHDWnHWoNFIniX0k+BHnONBF96H8FUyIjRl3spifZFnrJ9LMitElZ4k4qNRdNwuPhmlL1MvKYabnhYqs4XUyHXSUl3hYhxJd/U3svfs5FwgAN6eu1aNGIP3dekTJwylguE4gopXb+LloeEWf1YKtDXr4hQyinZNfFrKS0ULd0bZj8FU4y4SYMTEvqYYs8H+/z2V8bW8zjIs2um9vfk64ep0AmX58G9BbNC+YEjZyVQ==

On Thu, 14 Aug 2025 03:54:58 +0000
Subbaraya Sundeep <sbhatta@marvell.com> wrote:

> > Difficult to tell where the latencies are coming from. Maybe you can use
> > something like https://github.com/josefbacik/systing to look further into
> > it? All the scheduling events are tracked by default and you should be able
> > to add tracepoints and other events relatively easily. You can also set  

> Thanks for the reply. I am using simple busybox to avoid overhead of any other apps
> or deamons running in background and taking CPU time in between.
> I will try building systing and running it. 6.16 histogram shows that it
> is not one high latency event causing overall latency but bunch of small
> latencies are adding up and causing big latency.
> I suspect this has something to do with EEVDF scheduling since this behavior is
> seen from 6.6 (please note I may be wrong completly).
> Are there any methods or options with which I can bring back CFS scheduling behavior
> maybe with the knobs in /sys/kernel/debug/sched/features as a quick check? 

You could also use tracefs as that works on busybox:

 # echo 0 > /sys/kernel/tracing/tracing_on
 # echo 1 > /sys/kernel/tracing/events/sched/sched_switch/enable
[ and perhaps even more events ]
 # echo 1 > /sys/kernel/tracing/tracing_on
 # <run test>; echo 0 > /sys/kernel/tracing/tracing_on
 # cat /sys/kernel/tracing/trace

You could even make it a trace.dat file:

 # mkdir /tmp/tracing
 # cp -r /sys/kernel/tracing/events /tmp/tracing/
 # cp -r /proc/kallsyms /tmp/tracing/
[ have bs be PAGE_SIZE for your architecture ]
 # dd bs=4096 if=/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw of=/tmp/tracing/trace0.raw
 # cd /tmp
 # tar cvf trace.tar tracing

Copy trace.tar to a desktop and extract it.

 $ cd /tmp
 $ tar xvf trace.tar
[ Make sure you have the latest trace-cmd installed ]
 $ trace-cmd restore -t /tmp/tracing/ -k /tmp/tracing/kallsyms -o /tmp/trace.dat /tmp/tracing/trace0.raw 
 $ trace-cmp report /tmp/trace.dat

Now you can send us the trace.dat file and we could analyze it more.

You could also enable more events than just sched_switch, like sched_waking
and such.

-- Steve

