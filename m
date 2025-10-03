Return-Path: <linux-kernel+bounces-841782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A3BB8383
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC219E1E46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C54253B73;
	Fri,  3 Oct 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvqOgNPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954396FBF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527491; cv=none; b=gRksY2EG/XyCUezLyWS0F75MYV2yyxm1FfFMuHi0MJ5lpVCk1EIG4KQis9iIcodBq8JOSa9nHIrlZvNDHW/bj0bTHCI0//fE2Li8gcg2Hl94LvSsyHeu/ulJm7WWiR73OBCaVzvl5/bZRUz85hlCDuOMpOAQ7bAV3ugc/fkX9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527491; c=relaxed/simple;
	bh=w0mkoR0veq/TF2vJwisu5Fl3tovESQS3CAoxXGot3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGoBnlGZ4ojUXEubDGJKnIqmECg4xVexGJzGaDT5LI/dsRhtA+dXM1Gowxz9V3A8zijWs5dWrPN+aUf0LOnIcRIGzqnXpQmqlzqiNzI+1YuRxfo2CtqAE2MLw3yv8ET8tVCGqVJClhC8dMhVq1C7my38VoOvN/VgkAB1Iu8KH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvqOgNPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A7FC4CEF5;
	Fri,  3 Oct 2025 21:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527491;
	bh=w0mkoR0veq/TF2vJwisu5Fl3tovESQS3CAoxXGot3/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvqOgNPBQAIhXxuY9xqlK1C5hBaRdioueuQp0C5NTqslq6VToNr90uwpaq3a84WG/
	 TmVbXMuItR0xBhpPIxpQ+3dtSS85C6ATZP0ksowGcxp2aOVHaeD+X3+6U5D0TTqQNg
	 RWSmeIh1Zbm5T1at/9PLSW5QAwcn9z3NSfZLmBTjQTO4PT39rQuSVnBjfkZGhKM168
	 FHKHOkEip3ZA2brI1yY16VkDhf4RIDgKBZLGFLsXxvWJuElWV9PbHRSEF/GhM9vyU7
	 cE1exFkjC0rXeRZcAvu1NXDb3ACmogi92pSwVWkyqJhFjHUqPp5g6pgrWmGOah4P1l
	 mgJlI++Nt0v1g==
Date: Fri, 3 Oct 2025 11:38:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrea Righi <righi.andrea@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <aOBCQYxZp05lI6jA@slm.duckdns.org>
References: <20251003121421.0cf4372d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003121421.0cf4372d@gandalf.local.home>

On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At our monthly stable meeting, we were talking about documenting non
> static functions and randomly picked a function to look at. That was
> task_can_attach(). It was then noticed that it's only used by
> cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> reference anything unique to sched/core.c, hence there's no reason that
> function should be there.
> 
> Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> it a static inline as it is so small.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Peter, if it looks good to you, I can route it through cgroup tree.

Thanks.

-- 
tejun

