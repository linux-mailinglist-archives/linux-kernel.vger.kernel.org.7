Return-Path: <linux-kernel+bounces-750537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A625B15DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158653AAD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF527A11E;
	Wed, 30 Jul 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWHXtX7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C58271441
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869666; cv=none; b=TUNnwYIUWkhaUULv8cf4qH1RKLWEG5yiQvgk2gSYlOW4AErXSIr/k7mGkaTo3H/gJCRSrzloDJiHmAxEbPsnY+Hv3rAMWGWDqkkUSKW9GBJ04AMcJfEn+k1bVg0m1qLG5rRX59JpIWUg2cxrl8adBNJf7TrvcYszMavr9sCuH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869666; c=relaxed/simple;
	bh=GkM4OcpDCYwKUXwk+6TKNhhSfhQEcsMWMxk75Z2J1yg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bUZ8XQ2LcqHZ9UAvQqoI/Ilmg+sB9k0iZFhnSQq/apffkflljhsXTCm5GoH6SV3uHDTKuEnmC8OKGQft5nUWRr7bkeGb/GQ5ISYiWNXgDhXoMY3GbJD6XCiago6qMyZipgve5V0oLzPB3eZ2mJzgDAxPf+kgRI0HP+UlkRfqVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWHXtX7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63187C4CEF8;
	Wed, 30 Jul 2025 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753869665;
	bh=GkM4OcpDCYwKUXwk+6TKNhhSfhQEcsMWMxk75Z2J1yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uWHXtX7A04DnyciE1E6z/JKFp34ELX/3N+8491BPx0mbJjGitbDtuzq56TwpOUv5x
	 KoiMtmwuE7+npTmg7Pju3qJNaDSp/Z9xHxlgSI+KIDmfsV0+TDbP0/k9zIkvBGtP99
	 p8dp4dYYj4+dLkMoYoZ5m9QJRXwp1JSrh5o/BtOq9A2ZBlvPoEuQ+zyqxiZ0BS9q5D
	 a66iUENu2QgRSqeVHQb1isHR1OcaxDE/QRtkUMoZbI2oJnitqcQ92TQZfebLXWlALk
	 ObUsM321sv2x5ZVEgoLZY/Ytpj/91JkRURdDMFJHbKoQ0OUgWwHbjG+lpm6F+16vro
	 MmaEtpLMCnHCQ==
Date: Wed, 30 Jul 2025 19:01:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel Granados
 <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>,
 Lance Yang <ioworker0@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250730190100.64042746476687eae2eaa253@kernel.org>
In-Reply-To: <28364352-99b9-405f-831a-000ad090dd12@linux.dev>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
	<tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
	<20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
	<28364352-99b9-405f-831a-000ad090dd12@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 17:36:04 +0800
Lance Yang <lance.yang@linux.dev> wrote:

> 
> 
> On 2025/7/30 16:51, Masami Hiramatsu (Google) wrote:
> > On Wed, 30 Jul 2025 16:59:22 +0900
> > Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> >> One thing that gives me a bit of "inconvenience" is that in certain
> >> cases this significantly increases the amount of stack traces to go
> >> through.  A distilled real life example:
> >> - task T1 acquires lock L1, attempts to acquire L2
> >> - task T2 acquires lock L2, attempts to acquire L3
> >> - task T3 acquires lock L3, attempts to acquire L1
> >>
> >> So we'd now see:
> >> - a backtrace of T1, followed by a backtrace of T2 (owner of L2)
> >> - a backtrace of T2, followed by a backtrace of T3 (owner of L3)
> >> - a backtrace of T3, followed by a backtrace of T1 (owner of L1)
> >>
> >> Notice how each task is backtraced twice.  I wonder if it's worth it
> >> to de-dup the backtraces.  E.g. in
> >>
> >> 	task cat:115 is blocked on a mutex likely owned by task cat:114
> >>
> >> if we know that cat:114 is also blocked on a lock, then we probably
> >> can just say "is blocked on a mutex likely owned by task cat:114" and
> >> continue iterating through tasks.  That "cat:114" will be backtraced
> >> individually later, as it's also blocked on a lock, owned by another
> >> task.
> >>
> >> Does this make any sense?
> > 
> > Hrm, OK. So what about dump the blocker task only if that task is
> > NOT blocked? (because if the task is blocked, it should be dumped
> > afterwards (or already))
> 
> Hmm... I'm concerned about a potential side effect of that logic.
> 
> Consider a simple, non-circular blocking chain like T1 -> T2 -> T3.
> 
> In this scenario, T1, T2, and T3 would all be dumped as hung tasks.
> However, with the proposed rule (dump only if NOT blocked), when the
> detector processes T1, it would see that its blocker (T2) is also
> blocked and would therefore skip printing any blocker information about
> T2.
> 
> The key issue is that we would lose the crucial T1 -> T2 relationship
> information from the log.

I just skip printing T2's stack dump, but still show "T1 is blocked by T2"
so the relationship is still clear.

Thank you,

> 
> While all three tasks would still be dumped, we would no longer be able
> to see the explicit dependency chain. It seems like the blocker tracking
> itself would be broken in this case.
> 
> Thanks,
> Lance
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

