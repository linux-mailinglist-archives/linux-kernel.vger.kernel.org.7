Return-Path: <linux-kernel+bounces-868982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3515C06A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD281C225EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211931D743;
	Fri, 24 Oct 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LyFuUqRk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EB186E40
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315063; cv=none; b=Sivo++zF1UjMd++JYvZgsrTKz3Gn+LGnQc5DlESy/lFN1XDMm07p5d3U7fHbtLrHRPSAYzF1bRnLHAV1fWgu2JhURUmmyiWyiRtz+LR2aZI+EAWZZhU0TJ7MkvcAoP9U18Z2TydfYyMsObWTZFVs49AnR3myisXTb86586MTqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315063; c=relaxed/simple;
	bh=1h6CkkGF4+mfHvGDigYb52v/DwUUA2fb8PUDtKWd9s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYLvMQmJKA1/zO/aT6TSy+f2fZbL7vmV61FZqG5HOAcN0ryZZg2iBizSKKsqTdY1j82SYIqU9arBO+Mc6OfxFRk1xwbpADb9/M7GS5uFoabQrsSpCzWwodctcsPGfToLQjNy41eoz9ur6OEJuwJCvrGStgUfHIOAVbXspzKMpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LyFuUqRk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BcNlBw5cX+K1QD79dZZjRY3X4TNSuVVjsErLmNltpBo=; b=LyFuUqRkFgbYw1ajWNC2aGtvhI
	vJFQzSPx53lr8SyPNVW72ynpEJ5MgBwCX3rVzuhMUmbbJXHcJIYJIf6LjiZ1ATGmWsQJStiAVUepp
	Pwto5asg3JMi4rWv9S/NkJ7eMA9AJHcTKQp2qx1UAuWO/LYlqLsGp3Nn18rS+kLcHR/OCDkQlgiD3
	bvmDjlYhayfgj9bakn6X6AMhTZAOMfv8tgRJ6sjV4SOwO5+B0lUFnnGTDJQ6q7gt4E0sf4Q2amUSO
	1MuI4mhbLpIdWEgxTy8AC5vlftAKw2qfOAZncvypzmQbF5slUw77GNIt4xlzsXtMWamdQzlnoXX2y
	dWRlDxCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCIVM-00000002S3x-1O0D;
	Fri, 24 Oct 2025 14:10:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A544030039F; Fri, 24 Oct 2025 16:10:56 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:10:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
Message-ID: <20251024141056.GV4067720@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <20251022143140.2ed517e1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022143140.2ed517e1@gandalf.local.home>

On Wed, Oct 22, 2025 at 02:31:40PM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 09:59:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > @@ -100,6 +115,7 @@ static int unwind_user_start(struct unwi
> >  	state->ip = instruction_pointer(regs);
> >  	state->sp = user_stack_pointer(regs);
> >  	state->fp = frame_pointer(regs);
> > +	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
> 
> compat_user_mode() is an architecture function (only defined in arm64 and now x86).
> 
> s390 doesn't implement it and regs can't be used to tell if it's compat or
> not (although Jens tells me the task_struct can).

I've made this:

	state->ws = unwind_user_word_size(regs);

And then every arch will need to implement this. The x86 implementations
is:

static inline int unwind_user_word_size(struct pt_regs *regs)
{
#ifdef CONFIG_X86_64
       if (!user_64bit_mode(regs))
               return sizeof(int);
#endif
       return sizeof(long);
}


