Return-Path: <linux-kernel+bounces-868989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E2C06A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A397C3ADA92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B51E491B;
	Fri, 24 Oct 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQkrPTXX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DE1E1E00
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315424; cv=none; b=n3GQBi4FdFhGymjz1VSGitW1oWfi2bAtKqTXA/eeeYQBR2B9VbGxtxu5s5sZ0LUyHTX8zCd3QRij6zVlRWyd07ZFlRg9ii/iBQNJQzxb9IAmFO6pMEwE52bdpPuguWuaZNiu9XXtbpSBhmi/TIfQ0otyzMc9HtMzslnfX2tyIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315424; c=relaxed/simple;
	bh=2Ij8iQMgdRI6jz63h8TIwnWocR2+qoeGSh77xSCZYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJX6Vr6GzcfavabzL9tIpUH7IgY4rHybS1wCuIeN69gwjnTCeRo5iO/N6LdjjE7KWu0qQtqt+m8/gRCtSn0UcXybXpRqRAA/uC/oD6eYmE4V7VvUs7ZR4Jr/Kc1P01St9uCrr0q91Q1M/kTZbKN+ycpO3BEoBEIf7GfDW3lSyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UQkrPTXX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DgRCVOv8qfjt9qvxUoF+noNTQa3sD9SUMVptXl6/21U=; b=UQkrPTXXLbnZS2YqKQFkgeQuVf
	6abn28R04PScRUBTkCzR1d5Qd1Z9xlixgyXOtjeoY46o/6N3enaOA9pAHG8fUIf8JLMWbkMsGvKkr
	4HmPh6mx9fIzPGWv4zjokxFIDZZVL3k1GK5/Fpa1iUddwil7PfYIzjvlk6vTIYR5J3G4SlzsycK78
	b0fbPzYRiy5GHETDppqvKolsMhzG/Oe15xG7HNlxLq8iv3aHRlXEEZI5QGggSJd7Yvd/6cXV1qHn1
	X+yiNtw4QTd9+1UhZyxgK96Rz7r0Gb5DzpvsTcyJcCFnSqyAOkrrJpjnRXkE7RTa18tfRB1qqCy9H
	bpwpiL9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCHjY-00000002JrW-2KP3;
	Fri, 24 Oct 2025 13:21:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78A43300323; Fri, 24 Oct 2025 16:16:57 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:16:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251024141657.GL4068168@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <20251022143140.2ed517e1@gandalf.local.home>
 <20251024141056.GV4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024141056.GV4067720@noisy.programming.kicks-ass.net>

On Fri, Oct 24, 2025 at 04:10:56PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 22, 2025 at 02:31:40PM -0400, Steven Rostedt wrote:
> > On Wed, 24 Sep 2025 09:59:59 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > @@ -100,6 +115,7 @@ static int unwind_user_start(struct unwi
> > >  	state->ip = instruction_pointer(regs);
> > >  	state->sp = user_stack_pointer(regs);
> > >  	state->fp = frame_pointer(regs);
> > > +	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
> > 
> > compat_user_mode() is an architecture function (only defined in arm64 and now x86).
> > 
> > s390 doesn't implement it and regs can't be used to tell if it's compat or
> > not (although Jens tells me the task_struct can).
> 
> I've made this:
> 
> 	state->ws = unwind_user_word_size(regs);

Ooh, how about I do:

	if (!state->ws) {
		state->done = true;
		return -EINVAL; // nobody cares about this return value
	}

> 
> And then every arch will need to implement this. The x86 implementations
> is:
> 
> static inline int unwind_user_word_size(struct pt_regs *regs)
> {
	if (regs->flags & X86_VM_MASK)
		return 0;
> #ifdef CONFIG_X86_64
>        if (!user_64bit_mode(regs))
>                return sizeof(int);
> #endif
>        return sizeof(long);
> }

Then we flat out refuse to unwind VM86, which is slightly different from
the current code (which would still record regs->ip), but meh.

