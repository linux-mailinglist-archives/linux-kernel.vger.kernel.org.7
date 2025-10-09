Return-Path: <linux-kernel+bounces-846740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BCBBC8E31
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AD41A62102
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC22E0B74;
	Thu,  9 Oct 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gK9cb2Ow"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFD2C21F3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010354; cv=none; b=U5O2d9tMQI5RM0mqjDiD5TBup8BxfAmLURHu2BuGnofKDBSC4s7gGX2BuxD5Qwtu4F9djdRcjJLzg4UaLGYRleICLNsV3kLgsf/1OH6NMs2r5aPpF1uCNOkwDLPJ4dBF7PsB+4DX5i/QjWle2Fb9s0fyV7jALriL0Y3X1CbWNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010354; c=relaxed/simple;
	bh=RREagaIhlDmjWhyL2A8hFEgT3PLR0bmVwfCx3XHnwY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMBJ6ZxYyKHjbvMpQRK1ufYsg/RdQo28TORnQ5bT5JIVk59dAyv+8zG5i0VbUiMiGVFwePeqRi4AqoZxkF1+XLt1jV58Uis5plNyIKWfqnKNMoaB1iPjCWrbFOqVZ+q+CfBaIq1xhnH1vZOjmuMa46nHMHKWJBeaJQRzpIn9xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gK9cb2Ow; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gf1jLXHTxoeSbzVBkLguUM5LsdnFXAESpHCj/ZJkIas=; b=gK9cb2OwTRG9doGyD8wrOi8A4n
	Lft+n3/IyJnfYM43lfBIValYWXSe0qrwYZmu+8iwQ5qiVz0BADjzEb7/xClJVYouLZa8wilIrDLI6
	5g4b9vnVRgbMUXunFVIm9kQMOucV4jrG5codnXv3tMtzDPBFXwDRBjITBsNN++uF91kuRwl0x7Zsp
	kcMnJosXCvysOUC+dQmYIAKB3EgZPUz19rq/qTWD5VetEkfdTWrVifnQvrQw4OZfTB16q/3vD/C3z
	/+HCZW3VY4Lk77jTOYTacAwiuCXbNqUUNAE5P8kKwQCzTCrBq0RYlUSSJfGSxklLykeeoTllBjdbF
	4/MWNdJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6p5b-00000001QHt-1lgD;
	Thu, 09 Oct 2025 11:45:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02978300342; Thu, 09 Oct 2025 13:45:43 +0200 (CEST)
Date: Thu, 9 Oct 2025 13:45:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v22 2/6] sched/locking: Add blocked_on_state to provide
 necessary tri-state for proxy return-migration
Message-ID: <20251009114542.GC4068168@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-3-jstultz@google.com>
 <20251008112603.GU3419281@noisy.programming.kicks-ass.net>
 <CANDhNCpSNyOkcuUZvpZK5FQhL8oxQEax2wUStdRAV_ns2z7n_A@mail.gmail.com>
 <20251009114302.GI3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009114302.GI3245006@noisy.programming.kicks-ass.net>

On Thu, Oct 09, 2025 at 01:43:02PM +0200, Peter Zijlstra wrote:
>  - we should probably have something like:
> 
> 	next = pick_next_task();
> 	rq_set_donor(next)
> 	if (unlikely(task_is_blocked()) {
> 		...
> 	}
> +	WARN_ON_ONCE(next->__state);
> 
>    at all times the task we end up picking should be in RUNNABLE state.

Pfff.. PREEMPT won't like that. Ignore this.

