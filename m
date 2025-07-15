Return-Path: <linux-kernel+bounces-732072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D9B061C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C001F5C275A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7216F2036E9;
	Tue, 15 Jul 2025 14:35:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296C1FF1B4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590108; cv=none; b=s787Dfm+5JBcxFECc7FdNGFDDwXwwRBWDdazhqF8A1swzWXCaQFfNPtl4pXrA2jYJpsK1Evs1RABB+SL2BDtFBOU4hBAOPQpNL1rsNGwC14IEI4zTyxVzPfyTbRRHEBnakjmeIFskyQImXQaEG0Pxjv4Db5iYWFT8KEcplm9Bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590108; c=relaxed/simple;
	bh=r8tO1lOalXIKlyB59d5zfTu26CljhqrlTCDYWnWvHT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3bI1i6OxYtPPnzFHTIcjE406FrtjMKxVTFYO/w4QoPg9YOcu0HGJoUHJrAG0qLafHtB207xgzV16IuWdLpGO+sFp6DTAiMZ8BUBuM/AmmodXoL5YR7DY7w7H+EyWTcUe01gQWVyG8wV/Vs+b1C2m/3Q5hHvSk03W0YH/DOamtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0CC7E1DA533;
	Tue, 15 Jul 2025 14:34:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 049A02F;
	Tue, 15 Jul 2025 14:34:53 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:34:54 -0400
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
Message-ID: <20250715103454.4e39917e@batman.local.home>
In-Reply-To: <2025071127-reunion-residence-c0f2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
	<20250711091734.5632dcf7@gandalf.local.home>
	<2025071127-reunion-residence-c0f2@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7r1wypx6u15xy6nwgza64uhszqs7t6io
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 049A02F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+pHj7bZiAQuLDelWHdZkjBNreBonh4slc=
X-HE-Tag: 1752590093-610028
X-HE-Meta: U2FsdGVkX1+i/41KjCGp238kOK1HiTcFgjBDM+CUrYwUFBZMZEtEU6aL2RgiDFzTQGYqW563Grd/2LRQfqF082ls3nSYu26iN2o0uwqNilILVjuq+6fmPfbuOX4ScNdjRkONjCCGMxOsJciFK/zm2HbWI3qdBP5PUd/dnQRWiKQZJWAcApIilQ1yvcw/WJbOewSd3NxojGKPgFk8GbUGS9JT6FY3RhfVJJMkkVUw23Iy1L+XteRcNmSn3CSJgf/t/aipw6B+fBIc6qUCUP3xro46taMc/uhw28nqamHhMbaxruXewHfeptAHIruvR86fBYW9jS1GOHLzG6XhFtnQ1DxXhtxG6iUCnzWE2wc+FxxRqRdOVxDoNIMkIvaC+AbUCByL2qZBky2EbfK81qnrCQ==

On Fri, 11 Jul 2025 18:39:40 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> I'll show one real-world example, the USB offload path code, that you
> are using today on your Android phones that saves loads of battery life.
> In older kernels, the hooks/exports needed for that were all over the
> place, it took an engineer years to get this all working for lots of
> different hardware types and merged upstream properly.  They knew that
> they could not just get the upstream developers to export the needed
> functions, they had to get their working code merged in order to be able
> to have it happen.  And they did!

So how did this work? Did they write infrastructure in the core kernel
code with EXPORT_SYMBOL_GPL() to that this new functionality could be
used by other USB drivers?

In doing that, the work is adding functionality to all users inside the
kernel as well as to out of tree modules.

When I said that tracers are different, it comes down to that the
in-tree tracers are never a module. Any new infrastructure they use
will not be exported. There's no way that LTTng can add infrastructure
for perf and ftrace and then use it. So how is it suppose to work to
integrate with the kernel if we do not allow it to access the shared
infrastructure?

If perf and ftrace were modules, there would likely be a lot of
infrastructure functions with EXPORT_SYMBOL_GPL() that LTTng could use
and work to change its infrastructure to use the same infrastructure as
perf and ftrace. But because perf and ftrace are never a module,
there's no way for LTTng to work with the same code.

I explain this in more detail with my reply to Linus in the other
thread that you were Cc'd on.

https://lore.kernel.org/all/20250715052459.0000e119@gandalf.local.home/

-- Steve

