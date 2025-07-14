Return-Path: <linux-kernel+bounces-729977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E47BB03E83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E747A3132
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805C242D98;
	Mon, 14 Jul 2025 12:20:28 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3911FAC34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495628; cv=none; b=NrctfVa72o16uTJXkgpYDZ57qjpBU1VCLlkv9r2vekNbiy1Zxml/IteRGSSuPv58OCCfJre9/imB2wXb39gopDUwu3YqpJy//zbRj2908mJ1/mMe1vZw8kNBdrZyriNsUdaAPcQp6SikVl2n5EMRFvEut5iWvwi/2QSExALYIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495628; c=relaxed/simple;
	bh=6/CAIwhBQq2mnNMuhZmGz8OLtrp+Ze4pylV03Zc6zOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CePKLemFeR1aUJQ8LX4Y19Q577EdYAY26+i6Fe7hwLzt4V0jYLkTPjIkH/DQDWI8x30tII6BWHZwK+ANsWu0rEu78Y7bhrcTsEhnzUMA6oyLNSk/fR9Gb7Ti5BNM6PEjERxOOSeFBtiHf+sJaaelyCXN/ANqfbGxBmzWp5Y3WRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 1B44655FE5;
	Mon, 14 Jul 2025 12:20:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5E88620025;
	Mon, 14 Jul 2025 12:20:19 +0000 (UTC)
Date: Mon, 14 Jul 2025 08:20:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250714082033.702160ad@gandalf.local.home>
In-Reply-To: <2025071443-lazily-blabber-3fbd@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
	<20250714075426.36bdda0b@gandalf.local.home>
	<2025071443-lazily-blabber-3fbd@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iqhne1zs5utqykqk1j63fn7zgu45pnpp
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5E88620025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OzynnnP9q4LK8vDWNZzU1gKf7yZbL4hw=
X-HE-Tag: 1752495619-140496
X-HE-Meta: U2FsdGVkX1/KmWgp8A6y1APq8yrx9oLZiMZpmjPeKqwZbxG4CZaTFwXrud/6+C3Djvg6Ut108JXsKH24/jyResPVlOlCPhWYNf95WGZUln4oO+gz56JpbwVPtasBj3IuiQeOz4XJiHUZpPD4yqNsPqu2nLbUNjwriJDYk4agNvMy/CuW6a4UEqE4+Ki8e/Ot2BmmD/4dQChyky6hQen8zvjztIUAKFwJE12N1YWUkcJVUJeF1fnh2y0t8RQxwI8+xLoW2E/M8MXpaHJQ7CA5VNskQYnX8sbIX9i6bHXi/3UgPxZxTtjTRKMnDMTyJRvqoYvwqDd+r9+TeI/Lls7csvQ4bnDW4ecBrPtfv8Gt0dd2RlNxTJRVClTVxXHOd39P

On Mon, 14 Jul 2025 13:59:56 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> The maintainers of the subsystems in which the new code interacts with
> are the reviewers, as always.  Again, nothing unusual here.

What subsystems does it interact with? It is an observer, it doesn't affect
any subsystem. It's basically stand alone. It only needs to use the
tracepoint infrastructure (which BTW, Matiheu is the maintainer of).

Just like perf and ftrace. They are stand alone subsystems where other
subsystems may interact with them, but they don't really interact with
anything else (besides the normal utilities like allocation of memory and
such).

> 
> > Have any suggestions for him, or do you just not care? But you are one of
> > the gate keepers of EXPORT_SYMBOL_GPL() which affects him.  
> 
> This is not the issue at all, sorry Just submit it like normal.

So he could just send a thousand patch series that doesn't touch any other
subsystem? It would have a diffstat that touches nothing but kernel/lttng,
kernel/Makefile and kernel/Kconfig. Who's going to review it? Who's going
to accept it?


-- Steve

