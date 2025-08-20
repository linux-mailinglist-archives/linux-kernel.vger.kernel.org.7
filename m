Return-Path: <linux-kernel+bounces-776704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B927AB2D0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472E31896C20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA614B06C;
	Wed, 20 Aug 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPpeoQhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292113A86C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649699; cv=none; b=QGJC5/BFZavpn4WxF3qU/DTHOI+1h/JomAEWN+qUNfzTOdmREsFweQi97vShmC/nVZpNmpsiF60mtgOYfEiqC44feQyBJYBu3K2bMoUFgRyglUPws/hVOwK67oxI7IQvfgEEg63xJFTW7sL0VV/egkdg+yQnuPu14SR4M3cnzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649699; c=relaxed/simple;
	bh=J8F633pZRCLhIZA3XlxoeqroVq8KLBv0j3OmRyAnJ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwQtTddzigse8qt/+lnkvR1Na4D8meEEzJPz1QwN8JC89vapN3l7+WEEpSKoRS93d68dYUaNmk3cZY8/HOqtMKrZ0vWvw0ehlDnSZKgVEB8WfZmjDBwsU8l5tfePO4RjIWdlq0vaxmJMGEeRQJ6xuPHl4LMDDBI6YLrcJ36tEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPpeoQhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED46C4CEF1;
	Wed, 20 Aug 2025 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755649698;
	bh=J8F633pZRCLhIZA3XlxoeqroVq8KLBv0j3OmRyAnJ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPpeoQhsmSmn5dCKgaGDPDRfR8TDcskOKgmw2e4fIETURMq7lS+oyB62oXyAJjWEc
	 7ikNRisk8qXWUCRjiCIE0F9mbABvvkTF8Tmw18wkhv3TC+YfoNQ8Lz60wmzjAO3B7d
	 EOFrFeLrehHwkT80nBijyrUf60SfFkduP6wBg17ApjUvSsubpOmix9yGGqjz4gz/yN
	 WZnrJo0jr2ZdS42JUaOnlMnvaiWZYJRurJb30WH3huqfba2+0L/sK5uhZZ5heewHR1
	 byycMAo+AxYUIf3TgtzfgpQYigNKRTXfLPWra1OJ9DjpT9qKOPR9eVndUuaZhQnO9q
	 RKtECRKzzJJ6w==
Date: Tue, 19 Aug 2025 14:28:17 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: liuwenfang <liuwenfang@honor.com>, 'David Vernet' <void@manifault.com>,
	'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v4 2/3] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Message-ID: <aKUWoePcNPcnJT1D@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
 <0144ab66963248cf8587c47bf900aabb@honor.com>
 <814bebd2ad844b08993836fd8e7274b8@honor.com>
 <228ebd9e6ed3437996dffe15735a9caa@honor.com>
 <8d64c74118c6440f81bcf5a4ac6b9f00@honor.com>
 <20250819074736.GD3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819074736.GD3245006@noisy.programming.kicks-ass.net>

Hello, Peter.

(cc'ing Joel for the @rf addition to pick_task())

On Tue, Aug 19, 2025 at 09:47:36AM +0200, Peter Zijlstra wrote:
...
> You're now asking for a 3rd call out to do something like:
> 
>   ->balance() -- ready a task for pick
>   ->pick() -- picks a random other task
>   ->put_prev() -- oops, our task didn't get picked, stick it back
> 
> Which is bloody ludicrous. So no. We're not doing this.
> 
> Why can't pick DTRT ?

This is unfortunate, but, given how things are set up right now, I think we
probably need the last one. Taking a step back and also considering the
proposed @rf addition to pick():

- The reason why SCX needs to do most of its dispatch operations in
  balance() is because the kernel side doesn't know which tasks are going to
  execute on which CPU until the task is actually picked for execution, so
  all picking must be preceded by balance() where tasks can be moved across
  rqs.

- There's a gap between balance() and pick_task() where a successful return
  from balance() doesn't guarantee that the corresponding pick() would be
  called. This seems intentional to guarantee that no matter what happens
  during balance(), pick_task() of the highest priority class with a pending
  task is guaranteed to get the CPU.

  This guarantee changes if we add @rf to pick_task() and let it unlock and
  relock. A higher priority task may get queued while the rq lock is
  released and then the lower priority pick_task() may still return a task
  of its own. This should be resolvable although it may not be completely
  trivial. We need to shift clear_tsk_need_resched() before pick_task()'s
  and then make wakeup_preempt() would probalby need more complications to
  guarantee that resched_curr() is not skipped while scheduling is taking
  place.

- SCX's ops.cpu_acquire() and .cpu_release() are to tell the BPF scheduler
  that a CPU is available for running SCX tasks or not. We want to tell the
  BPF side that a CPU became available before its ops.dispatch() is called -
  ie. before balance(). So, IIUC, this is where the problem is. Because
  there's a gap between balance() and pick_task(), the CPU might get taken
  by a higher priority sched class inbetween. If that happens, we need to
  tell the BPF scheduler that it lost the CPU. However, if the previous task
  wasn't a SCX one, there's currently no place to tell so.

  IOW, SCX needs to invoke ops.cpu_released() when a CPU is taken between
  its balance() and pick_task(); however, that can happen when both prev and
  next tasks are !SCX tasks, so it needs something which is always called.

If @rf is added to pick_task() so that we can merge balance() into
pick_task(), that'd be simplify these. SCX wouldn't need balance index
boosting and can handle cpu_acquire/release() within pick_task(). What do
you think?

Thanks.

-- 
tejun

