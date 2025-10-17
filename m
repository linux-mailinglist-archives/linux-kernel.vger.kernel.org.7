Return-Path: <linux-kernel+bounces-857475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3153BE6E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECE8C502B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA63112CB;
	Fri, 17 Oct 2025 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yav/K8eh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQMnoWrD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BA30FC3D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684979; cv=none; b=ID6HD1JoyXWpNJvLjR9y06QEU0p++wzkYagzfHyqE8/NncqjKxif+a0OqKKVE68+ayma52+qJAK3Hp3wQZZF2aZdyCsdxHXUAHNrs+TxvuLpdI7XBOAxRyexqzTiF+UxMd3Q31o6CsjBkw5nqM/WnteMjU9Jcg14Y6X2uh2PNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684979; c=relaxed/simple;
	bh=f4M4ZGxNY9KJh+InZWlAsvskChCp3KlZueoR08JMaMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQYLBQkcit1O9M3FVZGtDQF0yPPgXOkEXslx3XT9IRAuguA6h782xjPEg/rMuz983qq//hXJWQeo570rnGGvuINSEulC+0tNVmjMRjLQulzasr0jT7yw6AUw+lEinMRgkp38oQuLgd7PDhXoZDW7owA1J4tBca+I4JXnWtuLQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yav/K8eh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQMnoWrD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760684974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUZDppqQSMV9nszQEkeds6D+H5TF+M7+nwoiVM/wHvA=;
	b=Yav/K8ehHPQun2kWH7TU52fbFQR8mCmduYczInvynsKjIeNkVlkisB0Mr+wUhTLIXCuehp
	FRaU2G6Of3IsMQuGZUrDAXn7cctkM+P4eA9wTs1mvLEyR7JMDuQ6lA3DI9oHkukU5q8UcQ
	tjPsNAh3Mq0+YJQZs50C5WmaRnVj+JBpjnWNX6aY2kNcz/OoHqtSnPapWfp4tbro9CLn4B
	21fCE2Kz8PgzgqubJhm7lzuRMk3s3tMhRc0e0F3S4nyQhWl6sH3rCVQTFoZO0rI1CjDxHk
	rzcTp33+EGpgl8SYgOKzUEUeLHNrUM4ptMDYbllh+jR+EnentfGdD+ZWYzG2Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760684974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUZDppqQSMV9nszQEkeds6D+H5TF+M7+nwoiVM/wHvA=;
	b=wQMnoWrDMB2rPFWnnIylINkgRatjYqXLIqw1ehgCqMXXYznYnH1GLwz8vlGSSVnwaQFW7/
	a9RCu6yJ7Xpj7GCQ==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 00/19] sched: Rewrite MM CID management
In-Reply-To: <20251015164952.694882104@linutronix.de>
References: <20251015164952.694882104@linutronix.de>
Date: Fri, 17 Oct 2025 09:09:33 +0200
Message-ID: <877bwu0zte.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 15 2025 at 19:29, Thomas Gleixner wrote:
>    Thread create teardown
>
>      I wrote a micro benchmark, which spawns pools which each create
>      threads and let the threads die after creation. The 32 pools/ 32
>      threads case triggers the ownership mode change case in both
>      directions. The source is appended at the end of this mail.
>
>      I initialy wrote it to stress the mode change mechanics, but then I
>      noticed the massive difference when I ran it on upstream:
>
> 		8 pools / 8 threads	32 pools / 32 threads
>
>      v6.17	  23666 thr/sec	       16161 thr/sec
>      +rseq/perf	  23656 thr/sec	 0%    16196 thr/sec	 0%	
>      +cid rework  32025 thr/sec	 +35%  21004 thr/sec	+30%
>
>      Both v6.17 and v6.17 + rseq/perf show this in perf top:
>
>       14.62%  [kernel]     [k] update_sd_lb_stats.constprop.0
>       13.08%  [kernel]     [k] native_queued_spin_lock_slowpath
>        4.66%  [kernel]     [k] osq_lock
>        3.06%  [kernel]     [k] _find_next_and_bit
>        2.21%  [kernel]     [k] __schedule
>        2.16%  [kernel]     [k] sched_balance_rq
>
>     with the CID rewrite this becomes:
>
>      13.48%  [kernel]      [k] native_queued_spin_lock_slowpath
>       8.98%  [kernel]      [k] update_sd_lb_stats.constprop.0
>       5.16%  [kernel]      [k] osq_lock
>       2.28%  [kernel]      [k] _find_next_and_bit
>       2.11%  [kernel]      [k] __schedule
>       1.75%  [kernel]      [k] psi_group_change
>       ...
>       1.32%  [kernel]      [k] sched_balance_rq
>
>    I haven't been able to understand that massive difference yet.

Looked deeper into it and it turns out that the problem is caused by the
upstream MM_CID implmementation. The extra work in the task migration
code increases rq lock hold time enough to cause that.

When I make CONFIG_SCHED_MM_CID a real knob and disable it on top of
rseq/perf then it becomes on par with the rewritten CID code. Toggling
it on top of the CID rewrite series does not really make a difference.

Thanks,

        tglx

