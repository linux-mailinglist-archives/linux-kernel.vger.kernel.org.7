Return-Path: <linux-kernel+bounces-838933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5EBB0738
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B438C4C0F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E304E2ECE9A;
	Wed,  1 Oct 2025 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N4FIDRd2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F2ECEAC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324677; cv=none; b=Lka21z70G8j+rpO9OE8SIoktfPkNcbJuCN0LRGXtPe8yUvEeLb0NhfnLnE53UOT/LbErwLM3uvRWY1nQJlh0tgBt2wxX4DXQosLZFfwfDFEttYNKGVKVPaHUiBp3oxiHafMlPG1lGlBxeGFAQAEhLdc2xFRATzyRIoSrCROMMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324677; c=relaxed/simple;
	bh=p6Sayqqd2zhgUHb4VCONJK2LH04ksZOZBx9B82RJizQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/K6h/4AOrplN9sa2wr17HLxNR7L0lUPTe9dFZ3erNK7LR3BjXnzxDtl6KlCpPt3KL1QytAPwF9lu5el/w4ca/2rbzDixGRCHP33Xk1jPR5sPK0zWN8GqtBmSSm//l6OMJRxYwBwf7idX5VWpyAa/N+ITSFDJSq61Hua7OVuDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N4FIDRd2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E8kzoy6QofB6dAgP+yMKbxfNz5D8bf+8F1qEp238yNo=; b=N4FIDRd2oMaNkMPxH81S+p3idM
	pEsOrEugE0N3i9pecJIM/P8wD0oEpNfT2TyQ2yGTxybfL/LYUfzbfpVmR7qScMLM7fkeXowFE7duJ
	lnspF5fjPvSRMYMLNS4lcIE1INwAaYdBSN1DUBtKz1miLuTDCH2nxo7ttZo3oTP+T/eI+8/XylIqH
	ebuj+o7UomPyVL6A6bID8ZXRoeQV9t4mOwILJY8yoGJzEgtuuKDo+uDHIsP31Im26ZHCPNiE+37jY
	4uxUSadraEwS/NS8N6dfe09Sz+IRbGi9j3AoXWyaIw6DYxAW6ImYnwuQe8hc8kca8eMLxZ8fkkBmV
	a8vb1VRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3who-0000000DZQf-4ACq;
	Wed, 01 Oct 2025 13:17:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B95BB300328; Wed, 01 Oct 2025 15:17:15 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:17:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 07/28] sched: Add helper function to decide
 whether to allow cache aware scheduling
Message-ID: <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>

On Sat, Aug 09, 2025 at 01:03:10PM +0800, Chen Yu wrote:
> From: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Cache-aware scheduling is designed to aggregate threads into their
> preferred LLC, either via the task wake up path or the load balancing
> path. One side effect is that when the preferred LLC is saturated,
> more threads will continue to be stacked on it, degrading the workload's
> latency. A strategy is needed to prevent this aggregation from going too
> far such that the preferred LLC is too overloaded.

So one of the ideas was to extend the preferred llc number to a mask.
Update the preferred mask with (nr_threads / llc_size) bits, indicating
the that many top llc as sorted by occupancy.



