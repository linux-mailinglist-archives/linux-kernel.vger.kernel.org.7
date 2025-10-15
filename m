Return-Path: <linux-kernel+bounces-854384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A9BDE3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9EF18953B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18831A576;
	Wed, 15 Oct 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aDY/vFae"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB0213E6D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526980; cv=none; b=K3+mulf9BNK5yCvop1cyHZA6n+b3QpjkhTeJKaIEkkDqBK5fBLvJjZCromU6fXGqwdaMGYrSRslWYKDYc/0XVAgbIfsBoAxzIlWWOKEYwei5WyY7eJW3GPY/v5z20KS7wgvg1MZNQbXVd7Zv6efCsMkApNbbena2M16ys4x3uSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526980; c=relaxed/simple;
	bh=0jB1y9zzssyn0/iHmvdVy1f2rouH9wDJMarUi4ghEpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z67eFZtTccVXp54ykaR1WDCajWI5S4TVOetW7W7/0O8WZf+SOgiPR97xflSoQD9FWnRuNHj0Ww5UJ0VT/n1uWwr4BFIAPbLVISbrYy6Zo2pHVh8ucINTFbFnsO3iA+tn0dNZozajWLw9ayGZYSFZ83lc0wjAoWK5ZWmetrfiFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aDY/vFae; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0jB1y9zzssyn0/iHmvdVy1f2rouH9wDJMarUi4ghEpk=; b=aDY/vFaeNazwpT1+ON0f+9omXy
	aCpJ3ZnmpwKw0gvvXYlR4fjHF1iT7AYRT4b0o8+Z58fx7zvHQfB2RjrIIACarhP7/NT6aGlu0Ip5x
	+2gmPkVqw0nHP9pr6xbv4hkoSri1tO1ofmXOHiGVo2eFy8SsQDQfKkB1k29PsRvfHwYo6ynG3RYFq
	hIas4mYnP3wXGZ4P70m5yzodoNLkCeCM5MY7yXI7wRU1PFKxfqTMvSmqHnCRNINPio2iMLlUMrkb+
	tH0GHcHwhB6gRG0leIR0bcqd6LUfVY6NKfQJbWkJZduJvl1B93ed9n94DoFtNj6J2B8YejA0FW/Fy
	PO93/b8w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8zTr-00000005tdx-2i9A;
	Wed, 15 Oct 2025 11:15:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D01530023C; Wed, 15 Oct 2025 13:15:42 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:15:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vern Hao <vernhao@tencent.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/19] sched/fair: Assign preferred LLC ID to processes
Message-ID: <20251015111542.GQ3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <cfa266cd6ea6fa30cbf7b07573992f18f786955e.1760206683.git.tim.c.chen@linux.intel.com>
 <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3df5a8c1-7074-4fcf-adf8-d39137314fd6@intel.com>

On Tue, Oct 14, 2025 at 01:16:16PM +0800, Chen, Yu C wrote:

> The question becomes: how can we figure out the threads that share
> data? Can the kernel detect this, or get the hint from user space?

This needs the PMU, then you can steer using cache-miss ratios. But then
people will hate us for using counters.

> Yes, the numa_group in NUMA load balancing indicates
> that several tasks manipulate the same page, which could be an
> indicator. Besides, if task A frequently wakes up task B, does it
> mean A and B have the potential to share data? Furthermore, if
> task A wakes up B via a pipe, it might also indicate that A has
> something to share with B. I just wonder if we can introduce a
> structure to gather this information together.

The wakeup or pipe relation might be small relative to the working set.
Consider a sharded in memory database, where the query comes in through
the pipe/socket/wakeup. This query is small, but then it needs to go
trawl through its memory to find the answer.

Something we *could* look at -- later -- is an interface to create
thread groups, such that userspace that is clever enough can communicate
this. But then there is the ago old question, will there be sufficient
users to justify the maintenance of said interface.

