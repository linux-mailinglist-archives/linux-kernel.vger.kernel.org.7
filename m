Return-Path: <linux-kernel+bounces-754216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E6B18FD7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBFC3B8B8A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60BB24EA80;
	Sat,  2 Aug 2025 19:46:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD3210FB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754163995; cv=none; b=qa8euN+uWOvy3yx0TdLw3v1SNIuoYK3V6rrH839x9nVW1drwraErtXZ6j+TWSOshRkmSxBnxSJt5njR2tN9OkIOewHWoytI5om6dv4W9oH723v0iG7YHGv0emXQVjgpQBnmtIIwTg5cgbQ4Aqc//F1qrFUv5z9Vq8ZFrvqdq4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754163995; c=relaxed/simple;
	bh=nwxO1Vt8c+RCnKjOjQkZW+g63Zb7+ATFJlBD/uAvkUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdMc1sqyUdymbPYxiCCdImB7mbJx9HN0UX8g4GqgEhO7rC6UX+qNo6a0kfvKhuMo1ZBVLikfI9U6p4CGaJ0YR1qiUe6HdGaO4gcrOKK7golX4PTs1hUUWk7fkX2jXksYMMCMDl4tHQq7kXZDlsH0zC1wQNBHHdROByg5WTWtERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7F770134C6F;
	Sat,  2 Aug 2025 19:46:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id DCBBE20027;
	Sat,  2 Aug 2025 19:46:21 +0000 (UTC)
Date: Sat, 2 Aug 2025 15:46:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
Message-ID: <20250802154645.52712449@gandalf.local.home>
In-Reply-To: <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
References: <aIcdTI3e04W_RdM_@gmail.com>
	<CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
	<CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qp77fkgqrx4e8nqhhywmaznf6g964wxr
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DCBBE20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pmPA5kD4EUayoBcYplmuElzEkpKs1XAE=
X-HE-Tag: 1754163981-820952
X-HE-Meta: U2FsdGVkX1/5h+zaAWLm7ZJkvzCOLQDmBwrv1eJBSFJEz2CGdEG6dgqB/QEkrSDOY/R6h3HwqAMtBrufzSj6MRi6mIapzmgpmcZW648Kn4xPWdGtZ+PgE4WUX8JgUW/Nbvkv8z2IytZBhkIpkRgdiLj8yjtbKRzrtSkaxyn2fxjnsxlq5sl76w03CZel92pOSEiLAmnRuGy5HDlxKmULRWHWd/BD1Otc2yeeSdYReBspCrUQ+o+JNX+2tofV/Tq5ixT5ZfQHuwTc22Whefcy/GzzWz5CncZkCzf6r5XTk9ESn8koH3N1zUIUTfN2Ft67356duLGlUGfpwS7T3lOM9ctw+KRQ6V/uHZ4c809fgGFVxqgurE+mvpIu8BjVD2b5

On Sat, 2 Aug 2025 11:43:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm not seeing why that would matter, since the seq count should
> become even at some point, but it does mean that the seqcount read
> loop looks like it's an endless kernel loop when it triggers. I don't
> see how that would make a difference, since the seqcount should become
> even on the writer side and the writers shouldn't be preempted and get
> some kind of priority inversion with a reader that doesn't go away,
> but *if* there is some bug in this area, maybe that config is why I'm
> seeing it and others aren't?
> 
> Any ideas, people?

You could try to enable function tracer and stop the trace with the patch
below and see where it happened.

 # echo function > /sys/kernel/tracing/current_tracer
 # echo 1 > /sys/kernel/tracing/tracing_on

After it happens you can take a look at:

  # cat /sys/kernel/tracing/trace

where it would have stopped at the soft lock up. Now the function tracer
will fill up the buffer quickly and it may only have a fraction of a second
worth of data, thus it will not have the locked up task, but it may give
you an idea of what is keeping it from getting out of the read_seq loop.

Note that the function tracer will have a noticeable impact on performance.
But it may open up the race window even wider.

-- Steve

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..7ac934efd8af 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -795,6 +795,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 #ifdef CONFIG_SYSFS
 		++softlockup_count;
 #endif
+		trace_printk("SOFT LOCK UP DETECTED\n");
+		tracing_off();
 
 		/*
 		 * Prevent multiple soft-lockup reports if one cpu is already

