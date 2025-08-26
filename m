Return-Path: <linux-kernel+bounces-786746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9176BB36744
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C13D1888F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339CC34DCC4;
	Tue, 26 Aug 2025 13:56:13 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94B258A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216572; cv=none; b=PJPlaiBgAMiMB0/fNSdGv5bovDRQ2vL2LIXgh4h3c3RxCN8W6H5HfEppp7fWGINx/qHsu3Cjjc72GkJJ2kfq/+cbPa/Hk7bp0QV231nWG9Ye0aQ0MJ5yDNCjvM8fly5P4fUdFWDXA2cPHMLHP8zEFRk6rND/Lx3GcTFScB1cD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216572; c=relaxed/simple;
	bh=o0UuzVJewgDzlKHo7yZ+pvGPkU7yerKDou21wYPPAD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aetj+IIKRTdWG/TO9gXU64KHiBHczf40YdTnvti14hbkFQYGFK+wifxGF8LP2GRXqdLYikJBoWBW1zz9fcop5OJsLy1IIgNxbeSTrb8mXWtpjifsJlcwH6z8KYpRQyujwMUgm6q9dieGI2mPbdDmXVz+lPkA3r+Q+dpDF6T8uTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D52731A011C;
	Tue, 26 Aug 2025 13:56:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id EA48920025;
	Tue, 26 Aug 2025 13:55:59 +0000 (UTC)
Date: Tue, 26 Aug 2025 09:56:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: cuiguoqi <cuiguoqi@kylinos.cn>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 guoqi0226@163.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing
 non-atomic fetch_and_set
Message-ID: <20250826095615.14259d90@gandalf.local.home>
In-Reply-To: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
References: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w4pinidjhh34uu1g5ofxywfautqk9kot
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EA48920025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19u/wdqUBFa1SVm8m6A2koo1y9aRX3EoJ4=
X-HE-Tag: 1756216559-355501
X-HE-Meta: U2FsdGVkX18VH7mlupTCmtU4NsLFoZEpBFhDZfNbGRFx0pkbGyMOkMNdmGk0Rc345QynEBDkiQo4yxhRZRdr7ezSsDFTudtOg8SKJaTqMFw9MXoA3r11YwDmRWvZITF3WajT+Y+4zVODf9YbvHk1YtKnqhpdZGEUaTzx+8v0fA0apJlHjIiEm2u+8KytN8KaWNYgI2yc+RAvGkPfWH8Ladhqz161YVf6CaQnv3s5fFhTw2qGEnG6if+RxK4LD5oaewXfQzMcBm5GGEp4xll1+WFCWYcaLIw8/8uMlpYmYKRfspSwJTFN/C74V26/elSf

On Tue, 26 Aug 2025 19:08:33 +0800
cuiguoqi <cuiguoqi@kylinos.cn> wrote:

> @@ -7078,11 +7078,11 @@ const struct sched_class *__setscheduler_class(struct task_struct *p, int prio)
>   * name such that if someone were to implement this function we get to compare
>   * notes.
>   */
> -#define fetch_and_set(x, v) ({ int _x = (x); (x) = (v); _x; })
>  
>  void rt_mutex_pre_schedule(void)
>  {
> -	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
> +	lockdep_assert(!current->sched_rt_mutex);
> +	current->sched_rt_mutex = 1;
>  	sched_submit_work(current);
>  }
>  
> @@ -7095,7 +7095,9 @@ void rt_mutex_schedule(void)
>  void rt_mutex_post_schedule(void)
>  {
>  	sched_update_worker(current);
> -	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
> +	lockdep_assert(current->sched_rt_mutex);
> +	current->sched_rt_mutex = 0;
> +
>  }

Honestly, without adding a READ_ONCE() or barrier() I don't see how your
change would prevent the compiler from making the code any different?

It may have "fixed" your issue because the compiler may have done things
differently, but this change doesn't guarantee anything.

Also, could you show an example of how current->sched_rt_mutex could be
corrupted?

-- Steve

