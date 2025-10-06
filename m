Return-Path: <linux-kernel+bounces-843345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776EBBEFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69D93C5AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18EB2D5C95;
	Mon,  6 Oct 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OYpddVwN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A46283FE3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775532; cv=none; b=Q1uxLah8BBz4+xCK2zsn18/9mHrh5a1OeIy93Ua87+Jq8iWX6NGv1JQqzaQZSF1NUONI33YVKVVTLrpUfVYC+lk2sjsHDwssBdpNC+UJxbcA7sTkZe7C7oLAJCobUSeuBp5qPbfQStFd1H/rpLynG/V69csISH5alhDktPHSb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775532; c=relaxed/simple;
	bh=AVECyVvVJT9MHSPO77txhpBax3GTs77J6kzt6LrtzWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXoB/2OkhIu5de8vk4D5QHUg3pw7Ei3po2UNFsj9gSLWXMHXii8fL6pKkKls/6Huzh1f8Vn66NuCcu0RbNRFSsVfm1VOKxxdQti1JA4jJHBtqwttDMUXu8JwOjNahQkUAUpmz6tbhWu/vMJeXOzVyT0bZOZtscuC1D/KGvfx4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OYpddVwN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uO3LfZeIvfpQMnzAlDj+jEBgIyA0tb9id+WZutQ73qM=; b=OYpddVwNDYlsqq3bTvjn0WeQJS
	CuOB+uo0/Jibx79Z4offzhGGznMdVNDkY4u3lrIQdNVKk6f336iGzGSPtctrkcshK2+lkc7sXaADn
	h6W1L97dntAOoDRNg7lGXfDU09T4Tj68Rnpswr7cEWDl0PbNAauzlVe570lYeTpN7wR3XWTOPh/qy
	7v/zTv3ZppL9sgqZ9wq6U6mBs57PTsSjR3kR64vpUpIio/o1bbWmozqmcYG7SmW2oPNiHzFp7lR4P
	sFp2MCCvDJzveHp8TGxMWMA/UQ8M2is2wQvk8wyLb6L6DmxoBaX7ZOGLIZzlUyvNCqZjWyr1kQLZN
	BKzsU+FA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5q08-0000000H5Rq-0KPJ;
	Mon, 06 Oct 2025 18:32:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2B65300212; Mon, 06 Oct 2025 20:31:59 +0200 (CEST)
Date: Mon, 6 Oct 2025 20:31:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrea Righi <righi.andrea@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <20251006183159.GW3245006@noisy.programming.kicks-ass.net>
References: <20251003121421.0cf4372d@gandalf.local.home>
 <aOBCQYxZp05lI6jA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOBCQYxZp05lI6jA@slm.duckdns.org>

On Fri, Oct 03, 2025 at 11:38:09AM -1000, Tejun Heo wrote:
> On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > At our monthly stable meeting, we were talking about documenting non
> > static functions and randomly picked a function to look at. That was
> > task_can_attach(). It was then noticed that it's only used by
> > cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> > reference anything unique to sched/core.c, hence there's no reason that
> > function should be there.
> > 
> > Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> > it a static inline as it is so small.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Peter, if it looks good to you, I can route it through cgroup tree.

Yeah, I suppose so. But there were suggested changes to the Changelog
and actual patch so perhaps wait for v2?

