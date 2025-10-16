Return-Path: <linux-kernel+bounces-855706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FCBE2084
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311B8542830
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD3304BA4;
	Thu, 16 Oct 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LyEFWXOz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E82FF676
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600984; cv=none; b=TBNQ+nEZRDBLtZVgD5PxP5SjMgcfstBldOzSJUskg9gZIvnLSFj54UyxA49mmWnk4qqD3iOWMcvjewmNaJdXpuLZXEGawuILLIan6H+T3lpj8ytPpcFONGYDmqoZWV38R3QNpqMeOSEeIvcGfglU5SvJputAKiG8zSVF1OwWrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600984; c=relaxed/simple;
	bh=+42X6Jt0ZlmPQYKjaggSb7OrPhEm4TKDTZYPl6pulxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgtVeJjAGniXtRrwM1JAYuinvPyd8xOZ3rD0mupUrhTw/+LrUSJR7rboPTCIA30Cea2ezPckhGSeCA2LMHyGVFPDymRFHFysCcrmgufXrsSbOaSMToWcgE3kso2QnxoKuGUqnAEPXe6RPsEQG75txjOrfyLJJikkSeoCqu+y1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LyEFWXOz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nfFkhXWP9diqTEchi78XXkPpQcFavLqxkFIdYcY18sQ=; b=LyEFWXOzl+7NsQz/hchGBvHRgv
	2/NCzNAnxaxmnTzx+r2chOt+Xh7+Vaqg5AZxoca06R54lIoiUnVhNMJiaupb5MrQmhMqMtGL7CDLW
	DU4x+2PHygAtpDdv4Wn/E1U0F/0/Fup+XvEE37danYsCxethHwYaBIiZLX1xrUHcfCey8RSMPOEyt
	MYw4iwEdE0OkGquCPNhMfWGmcI/Asy/AS9WaHe9kRWDvZBSpXqBLKCvvz3x9IFYf3maVmJ5nSOBDg
	1LgvwCTRoDeCvJ4mtFvAZt+KjVlzR8F3vMGW+KaU1F/AxO+8JuBLtmO1KoLj84eI61EFuJLI3i9Ph
	aNS6ceYA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Ijb-0000000GZD8-1H5v;
	Thu, 16 Oct 2025 07:49:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86DEC3001D4; Thu, 16 Oct 2025 09:49:15 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:49:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
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
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC
 preference counter
Message-ID: <20251016074915.GA3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
 <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>

On Wed, Oct 15, 2025 at 01:41:42PM -0700, Tim Chen wrote:

> > > +	/* avoid negative counter */
> > > +	if (rq->nr_pref_llc[pref_llc] > 0)
> > > +		--rq->nr_pref_llc[pref_llc];
> > 
> > How!? Also, please use post increment/decrement operators.
> 
> Will change the rq->nr_pref_llc[pref_llc] <= 0 to a warning instead,
> and update the decrement to post operator.

That WARN will still add code. Note how none of the nr_*_running
decrements have checks on. You fundamentally cannot remove a task from
the runqueue that hasn't first been enqueued.

If you get mis-matches something is *very* busted.


