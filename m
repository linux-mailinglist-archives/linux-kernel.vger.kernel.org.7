Return-Path: <linux-kernel+bounces-876728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01CC1C292
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92323506132
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29044350A0D;
	Wed, 29 Oct 2025 16:27:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31B3451B4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755269; cv=none; b=RL5sc8ouIxPzSZoCAEoqLvoBsOBqbwuz6/SC2Gpogs4kFhd8Zro/Gfksb9HmIThzDLuQHzy6442JUJIJGSpls2EQmhr+/4R5lYm1yGi/H2ZE3krgGoM7K8JbH6Pvre21qpdsr7ugMGqlRtOnzR5UiNVVX3z3BkwBUqMzlgUpE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755269; c=relaxed/simple;
	bh=Gy66dL+xVuqVhKNh2iCY9YilURQ2/sypJUtSiVlSCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdQ/g/cXmRwGXFhpEla4Vs6aRqZYHjWbq6Ik+PiKNJXk0B3b4+1eCXiwaNMK2W025XzK+CmwatIxlkXa8G/MZVY81MX5XxLMaHPryjCDqktvrDBMYjV0XQ2oV6i+KNT4f0AJpClLBkPLeuxDVufePx25IF2XlrXRXTWinfbRFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id AA16D1408A1;
	Wed, 29 Oct 2025 16:27:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3A85730;
	Wed, 29 Oct 2025 16:27:42 +0000 (UTC)
Date: Wed, 29 Oct 2025 12:28:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 27/31] rseq: Implement fast path for exit to user
Message-ID: <20251029122822.092bc95b@gandalf.local.home>
In-Reply-To: <20251027084307.638929615@linutronix.de>
References: <20251027084220.785525188@linutronix.de>
	<20251027084307.638929615@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: y1a8jorknaroyqsdk6iib1yjrcdnjwnc
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3A85730
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2RyqYGIkuEQvzQnuHSlTMrQocsm58y/M=
X-HE-Tag: 1761755262-99366
X-HE-Meta: U2FsdGVkX195TKOa1nFwJW6ULT7tDIee4PVqVe9KTvKGkR2yqko6D4yVJ98FDNDT4YIzqKGHQvmHzj8MdM46IbckgUs5VJ17JjizMNVcWSru8Ymbkev0pzF3JobKZP72tg2d6+DKeu+y4BORHgs5A42HZXYCPayQR09XDDcdxh0gFog8XSzRPh4CX2h4Y5t+Sj+kgEBBZrJuoAOALC/NmBI0w2Squn6DXd04RajOuygvN7yeKyxM/nfva1p6tYqbaq3D/HqV9jgAimMOSt8lbGWYvZrw+08qbMK18JWAkWpixnh3ByxBDCLTzWETHF06

On Mon, 27 Oct 2025 09:45:17 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Implement the actual logic for handling RSEQ updates in a fast path after
> handling the TIF work and at the point where the task is actually returning
> to user space.
> 
> This is the right point to do that because at this point the CPU and the MM
> CID are stable and cannot longer change due to yet another reschedule.

                "and can no longer change"

> That happens when the task is handling it via TIF_NOTIFY_RESUME in
> resume_user_mode_work(), which is invoked from the exit to user mode work
> loop.
> 
> The function is invoked after the TIF work is handled and runs with
> interrupts disabled, which means it cannot resolve page faults. It
> therefore disables page faults and in case the access to the user space
> memory faults, it:
> 
>   - notes the fail in the event struct
>   - raises TIF_NOTIFY_RESUME
>   - returns false to the caller
> 
> The caller has to go back to the TIF work, which runs with interrupts
> enabled and therefore can resolve the page faults. This happens mostly on
> fork() when the memory is marked COW.
> 
> If the user memory inspection finds invalid data, the function returns
> false as well and sets the fatal flag in the event struct along with
> TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
> and terminate the task with SIGSEGV as documented.
> 
> The initial decision to invoke any of this is based on one flags in the

                                               "based on one flag in"

-- Steve


> event struct: @sched_switch. The decision is in pseudo ASM:
> 
>       load	tsk::event::sched_switch
>       jnz	inspect_user_space
>       mov	$0, tsk::event::events
>       ...
>       leave
> 
> So for the common case where the task was not scheduled out, this really
> boils down to three instructions before going out if the compiler is not
> completely stupid (and yes, some of them are).
> 
> If the condition is true, then it checks, whether CPU ID or MM CID have
> changed. If so, then the CPU/MM IDs have to be updated and are thereby
> cached for the next round. The update unconditionally retrieves the user
> space critical section address to spare another user*begin/end() pair.  If
> that's not zero and tsk::event::user_irq is set, then the critical section
> is analyzed and acted upon. If either zero or the entry came via syscall
> the critical section analysis is skipped.
> 
> If the comparison is false then the critical section has to be analyzed
> because the event flag is then only true when entry from user was by
> interrupt.
> 
> This is provided without the actual hookup to let reviewers focus on the
> implementation details. The hookup happens in the next step.
> 
> Note: As with quite some other optimizations this depends on the generic
> entry infrastructure and is not enabled to be sucked into random
> architecture implementations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

