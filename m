Return-Path: <linux-kernel+bounces-750866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5374B16206
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00219565541
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06332D8DD9;
	Wed, 30 Jul 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VafXwCfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84129ACC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883762; cv=none; b=gL1O9pfhL+jl2BcpLw0dcFIB3sbBN56DxSjNkEfZoaKJuM4mdZdn2iEoiTOKSfNcvN74oQxxWX6bkdz+bZ2TVr1/RHRHPiCm0v+0430f4dcJ/XFp2l5z2WNo/8mgEUpOzCvnPLaMxCLVETsRDUsOOxJbfB8w6KCGkpls7CL12iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883762; c=relaxed/simple;
	bh=vHbWvoOmIYH1RNK0i75gyJGgI+X3La7AZbLLGyyjp3A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QNOruE159bJxo2ghjH2V5VtkmkXeCCGWOJzt+zODGzWLWP7CzgY2vKrECP9IMZJ9gqlVOd5p5iuIR0e62JtfGCF3KlviiP91Tut4LnA+ElTnfe1j7LHQLJubmLfFY7ywkCiM4gYfao38Hs1iOedYdUcTWpVhNL4BfKixo6cSrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VafXwCfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6842BC4CEE3;
	Wed, 30 Jul 2025 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753883761;
	bh=vHbWvoOmIYH1RNK0i75gyJGgI+X3La7AZbLLGyyjp3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VafXwCfX/gWzEC/zQRIHGkFZHpBPu4A1ZgdGl9G3K+kv2SM4wf4Rr7HNHEk+YVLLw
	 DT2ZtLI3GbYeC5Y+L6QX32lYB2USbGYhuO5ic6ZXqJhxrU45rAesGnNxQQkkZPc9Jk
	 vosahx0HkqBvTAYJBrdkSWM1g/UiT+UcDX5m2EvMzk+Jz43GSnpUoDpJqj679npW1Z
	 U6QZ3zDiasL7tDCAUmwhjbNhjRBfDtGGpSQW5rMRLinGYn35GQ6gMdJrxCzZBTE406
	 oWOR9HqvsqAPCVYzCW/pI4gieSzwug6I9er2PuhDO2MboTUre6uiuQpmXljF+q4Elm
	 xm/JZzbj2tGUQ==
Date: Wed, 30 Jul 2025 22:55:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] hung_task: Dump blocker task if it is not hung
Message-Id: <20250730225556.d05b77b108c23ce05e9079e5@kernel.org>
In-Reply-To: <x5crxfuhbnlk4pz3lidlwh7y5meoqlkmteedaljeepizbxbvjr@7orhkqjvdpnk>
References: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
	<175386922226.617855.4016966678697742834.stgit@devnote2>
	<x5crxfuhbnlk4pz3lidlwh7y5meoqlkmteedaljeepizbxbvjr@7orhkqjvdpnk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 22:28:45 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (25/07/30 18:53), Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Dump the lock blocker task if it is not hung because if the blocker
> > task is also hung, it should be dumped by the detector. This will
> > de-duplicate the same stackdumps if the blocker task is also blocked
> > by another task (and hung).
> 
> [..]
> 
> >  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > -static void debug_show_blocker(struct task_struct *task)
> > +static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
> >  {
> >  	struct task_struct *g, *t;
> >  	unsigned long owner, blocker, blocker_type;
> > @@ -153,41 +193,21 @@ static void debug_show_blocker(struct task_struct *task)
> >  			       task->comm, task->pid, t->comm, t->pid);
> >  			break;
> >  		}
> > -		sched_show_task(t);
> > +		/* Avoid duplicated task dump, skip if the task is also hung. */
> > +		if (!task_is_hung(t, timeout))
> > +			sched_show_task(t);
> >  		return;
> >  	}
> 
> This patch seems to be against the tree that is significantly
> behind the current linux-next.  Namely it's in conflict with
> linux-next's commit 77da18de55ac6.

Ah, yes. I just used v6.16 for testing. OK, let me update it
against the linux-next.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

