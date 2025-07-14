Return-Path: <linux-kernel+bounces-729938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0BB03DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A06417CAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820A24728C;
	Mon, 14 Jul 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kV3OPMYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A40246BAA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494399; cv=none; b=PejJgjj/P3u9XbbDmJA0B1m1GTqX1N8U3io9esb+MPLip4Na/NRHGoDkDhcassGlLH3Axi+z4ElLP6D1G5IbCD7z8/b+lTpnFgzMrebDdLVfyDgJp686er/Kfdr65vS5KLykwlBcIWtgcV2p7zP+JK6UPPbDV8+mIlZDIlEN7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494399; c=relaxed/simple;
	bh=P0YeL7xnTSDWA1FhH9xFnBFFkFFYsGju9SThgrGgAP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUQtumxVAdE69l0+sYFcJK1SJJsROCUvYIZ6Hx0ABVPOErKIWejHcGCgsiOe6iXkyPC9fIpFzVVjwj2y3HsOrChcBzLzEpeHBLseB7m1IQdP7n8lBD31SnQkr5cfwg5tt8V+WdWqDmddKpXNagXXPej50QPO9tqKoOadpayXlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kV3OPMYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46021C4CEED;
	Mon, 14 Jul 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752494398;
	bh=P0YeL7xnTSDWA1FhH9xFnBFFkFFYsGju9SThgrGgAP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV3OPMYrCo/K+z8oxHuo0NpmSUk/HXEUyHwQAMONJ6vWxkS6gNcXo+vmtANkO9hQz
	 uq9H9B0lrnIhoaM9XplsKFgxp7nBGXxwsTL2RhkZy81AeHT85gf6OM4GtC01byk0fi
	 v8TxgS54z3TJXAXkgPX9e07UJKVknNYxTn26nvG8=
Date: Mon, 14 Jul 2025 13:59:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <2025071443-lazily-blabber-3fbd@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home>
 <aHTsOcIUs0ObXCo1@infradead.org>
 <20250714075426.36bdda0b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714075426.36bdda0b@gandalf.local.home>

On Mon, Jul 14, 2025 at 07:54:26AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 04:38:33 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Jul 14, 2025 at 06:27:24AM -0400, Steven Rostedt wrote:
> > > This has nothing to do with Mathieu being a friend. He's a long time Linux
> > > kernel contributor and has played a key role in developing a new feature
> > > that will help both perf and ftrace, but without the EXPORT_SYMBOL_GPL(),
> > > LTTng can't use it. It's basically saying "thank you Mathieu for helping us
> > > with this new feature, now go F*** off!"  
> > 
> > You don't have to be as explicit, but otherwise that's exactly how
> > it works.  No one gets a free ride just because they are nice and/or
> > contributed something.
> 
> Why is that?
> 
> And yes, I still consider it draconian.
> 
> > 
> > The rest of your mail looks just as confused.
> 
> Let me rephrase it then.
> 
> How would you recommend getting LTTng into the kernel? It's a relatively
> large project that has 75K of lines of code with development that lasted
> around 20 years.

The same exact way any such out-of-tree project gets merged into the
kernel tree.  This isn't unusual, why is anyone confused here?

> To break it up now, into reviewable patches would be a huge undertaking.
> And who is going to review it? I don't have the time, do you?

The maintainers of the subsystems in which the new code interacts with
are the reviewers, as always.  Again, nothing unusual here.

> Have any suggestions for him, or do you just not care? But you are one of
> the gate keepers of EXPORT_SYMBOL_GPL() which affects him.

This is not the issue at all, sorry Just submit it like normal.

I think there's a whole in-kernel document that describes the process :)

thanks,

greg k-h

