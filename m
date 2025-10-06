Return-Path: <linux-kernel+bounces-843372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CABBF0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A94E8010
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217E2DCC1C;
	Mon,  6 Oct 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNYBmD9K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5722A4E9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777192; cv=none; b=ujmSsmabG24rL1M0tBVT2uq0gRx4QYCaNqspQ1Y8HnwH4STNhAT5ftLBUHS6RGABc4bU2B/G302NXYpEcV9+ALVQFqSMzffjfKNQTk1CI8n0HugUnGta5gfNsEUTj5LCPhnfJq9Z3+HZdFBgV1IpIMOd9q4IcYsvrNyVqfwUVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777192; c=relaxed/simple;
	bh=yvfLhufYAm86IBe/XFMt8s8Nmn2RNwkEQZpuARODMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u664H8j4vrPndt9NEGcuw8T1vruIuoC2bWZcX1h/OQf0f9Pe0gqRxiv0vbXy1u3c9g4s56Ow4VcwW967i+QJi5fLXuZ6QmDCPiT4GtDIpENAbRnMed+BZ+vnlTH7Kmgr3Sk8EAQ2gd+93pj/bQbs05CIdNRupw7nE6otABX6T24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNYBmD9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800C7C4CEF5;
	Mon,  6 Oct 2025 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759777191;
	bh=yvfLhufYAm86IBe/XFMt8s8Nmn2RNwkEQZpuARODMcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNYBmD9KUvq7M93nAzXdpnZ+6r6Vaa0TU60CSD0kFCNIwLjsdJgU3J62YOD9FKBEe
	 HC3jQPpU1i8PK6E0sQ/ELJdR0kIUJX26KBKcpy5ghbjz9BjY9vlauEWZ4ahEs2bYTJ
	 gOESn4ygWt9CSsVCmnrKovYsXsINbk3lqQHZuz2eJiYNGTgkCSn2o4G3I10aRZc5Ls
	 QQdBs34HFbd1mcP1Eci3UEB82K5c8GhiZdkoTnBJjpTuExJn5NFOHXAoOiKRhvCmnA
	 tle7qVih9zaJqa75ILceOJYzjyvT9y8C0ENB4NCCpvtGxCXvxrWItPjYTQizs98USu
	 lbuaD3z/hiU5A==
Date: Mon, 6 Oct 2025 08:59:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aOQRpvRrXJDONnh1@slm.duckdns.org>
References: <20251003121421.0cf4372d@gandalf.local.home>
 <aOBCQYxZp05lI6jA@slm.duckdns.org>
 <20251006183159.GW3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006183159.GW3245006@noisy.programming.kicks-ass.net>

On Mon, Oct 06, 2025 at 08:31:59PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 03, 2025 at 11:38:09AM -1000, Tejun Heo wrote:
> > On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > At our monthly stable meeting, we were talking about documenting non
> > > static functions and randomly picked a function to look at. That was
> > > task_can_attach(). It was then noticed that it's only used by
> > > cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> > > reference anything unique to sched/core.c, hence there's no reason that
> > > function should be there.
> > > 
> > > Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> > > it a static inline as it is so small.
> > > 
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Peter, if it looks good to you, I can route it through cgroup tree.
> 
> Yeah, I suppose so. But there were suggested changes to the Changelog
> and actual patch so perhaps wait for v2?

Yeah, will wait for v2 and then apply it.

Thanks.

-- 
tejun

