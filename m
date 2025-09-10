Return-Path: <linux-kernel+bounces-810935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60391B521AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0550D3B0DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4292EF643;
	Wed, 10 Sep 2025 20:20:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F02DFA3A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535623; cv=none; b=kxCiINuR6KF/l+gi52YEblbvJL2RSXhZ3jg6W8976RRP5RIPcEoS4810Nhllvvjee9LzfBL2O2TQduJSUvYS/bLK7GhDYJ0L4ZtU2Jt8dcdmf/9XxaT8FZcdPLQPQSda/gvtVdhqkT/q3pnZsR2KukJOP4KKYVn6yRhtbgc8VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535623; c=relaxed/simple;
	bh=bYXC5sjeXcjMByBjPSh5y70l/K1Ba5xSu11vvzc58UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4H2a65djMjQa6Zo92f9I+7p6XmSZczQ05J9awEZVJkNc10OB86Ry5VhR5Q04xSmi1IeH5TQYVwEqXyxj0OBm+e8PK1axxKl0sqcVUwmGoaLEwY5uMCOyI9QBPK60tOXREZuzjpPY3G8mB6sangUicbhrlb2JyF8D1aj9fDjtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B260F118AC1;
	Wed, 10 Sep 2025 20:20:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 2FFAF20027;
	Wed, 10 Sep 2025 20:20:16 +0000 (UTC)
Date: Wed, 10 Sep 2025 16:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guenter Roeck <linux@roeck-us.net>, Luo Gengkun
 <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Qianfeng Rong
 <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>,
 Wang Liang <wangliang74@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250910162106.6624752c@gandalf.local.home>
In-Reply-To: <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
References: <20250909162155.76756fe3@gandalf.local.home>
	<CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
	<CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2FFAF20027
X-Stat-Signature: uc6o9ccimge7mgd4jekz7z5zt6okijmy
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18YXzntmMwNWk10vvhy/e8SGP7/f1op618=
X-HE-Tag: 1757535616-80459
X-HE-Meta: U2FsdGVkX18WD03ca8Tp384Jb17cQFXOBzCm9OuIWz/Vv4dNM9fuXoqPboz8Co8sC1+GP2DW+49UoY0Cotb3Wz/tHcjk/zlwJpxwgvFRKnWnNpPR6aQ0NRxMxnh5nNVKaLA6m88UymaN8qofWGFV1X/TFZyS6TvVhZWMUFfmGI0NlAdxQsMLYioFMiJjium64NDfYY5c89vvz0UN5ghcUv+Wv5CfFVmXvtNxjTzcWMNqb6tF6Zz/2KuAr6bn9PO03wipfzbqtp73bQmiknsUDd3pwxorQHhHmxuwRtqL3/okwe7GCh93tA6zUpzicT9YR/ya2b4hkID1A0qtgkUcvwbI5fa9KUxT0mCchr5g/dCrrI9rv//mmHm/pmdsPpJL

On Wed, 10 Sep 2025 12:37:50 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 10 Sept 2025 at 12:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > In this case, the appropriate coding is to typically surround it with
> > a pagefault_{disable,enable}() pattern to let the page faulting code
> > know to not actually do the fault.  
> 
> Btw, I say "typically", because you don't have to do that. The page
> fault code uses
> 
>         if (faulthandler_disabled() ..)
> 
> to decide if it should handle the fault or not, and that checks not
> just if page faults are explicitly disabled, but also checks -
> surprise surprise - "in_atomic()".
> 
> So just being in an explicitly atomic context automatically means that
> __copy_from_user_inatomic() is atomic.
> 
> Which makes me wonder if there is something entirely wrong.
> 
> Because the explanation for this in commit 3d62ab32df06 ("tracing: Fix
> tracing_marker may trigger page fault during preempt_disable") talks
> about the task being preempted in between the
> 
>   ring_buffer_lock_reserve
>   ring_buffer_unlock_commit
> 
> and it sounds like maybe the tracing code isn't disabling preemption
> for the whole sequence?
> 
> Because "in_atomic()" does check the preempt count, and so just being
> non-preemptible should already have disabled page faults.
> 
> Maybe the page fault just ends up being expensive enough that it
> exposes preemption being more *likely* just because the window now is
> much wider.
> 
> Alternatively, this is perhaps an arm64-specific bug where the page
> fault disabling doesn't honor the preemption disable of
> faulthandler_disabled()?
> 
> I did *not* go through the whole arm64 page faulting code: that commit
> talks about do_mem_abort() which is done as part of the common arm64
> fault handling, and if that then doesn't honor
> faulthandler_disabled(), then honestly, that perf fix isn't actually
> fixing anything either. It would still do the same reschedule even
> with an explicit "pagefault_disable()/enable()" if
> faulthandler_disabled() simply isn't honored properly.
> 
> Adding Catalin and Will to the participants to see if they have input
> on that whole do_mem_abort() angle.
> 

We figured out in the discussion that the user that triggered this had
CONFIG_PREEMPT_NONE, where in_atomic() always returns false.

-- Steve

