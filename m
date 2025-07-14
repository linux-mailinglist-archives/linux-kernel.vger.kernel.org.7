Return-Path: <linux-kernel+bounces-729927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E3B03DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C966217C9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9F247281;
	Mon, 14 Jul 2025 11:54:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04D2E3718
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494066; cv=none; b=rKyu+4+DRuJfLk2bG2Gd8zO1dJ+gt9WDuj8W+jIyvYz5deo12FSO+5OrqApthSQazMGH/q00EtPr7chxtStAIXbw1dg+qYvkhJu9BimWqTwfwsZaEoirpTXVggBKSQ2k/XhyQGoXm8ZTR5ABp9jE073cT9H/tgaE0qksRpa6qOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494066; c=relaxed/simple;
	bh=FIZk5guGJuky1lgVw7T7nzyF1yoRfASJtAyhoUEJc1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XB4cJc4Fq6Fh9a9jgma34NxfOuHV+IKorUGNo6s2POw74zGDu4/KKt3e2bjIVZiu8Rsi9Sx+KjB1u4jz4/KoH+1rcwgRvzvdj5o0yrwojBelhVHEfuzjL4ymQQJaMVOOGiYCbNhwPuzEuKYWTbf9GhchTmz5byxolmGIhwYoOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B5D2314013F;
	Mon, 14 Jul 2025 11:54:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1169417;
	Mon, 14 Jul 2025 11:54:11 +0000 (UTC)
Date: Mon, 14 Jul 2025 07:54:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250714075426.36bdda0b@gandalf.local.home>
In-Reply-To: <aHTsOcIUs0ObXCo1@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: otwqtqq743qo6hpxaickjywkywmts43x
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1169417
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19dI3EFRUJ4cjyRMk+fzXDytKBKATOviaQ=
X-HE-Tag: 1752494051-484047
X-HE-Meta: U2FsdGVkX1+jtscyNN/GNuafLjT7xgUsyBvz5u7/bQbuCrfRkQjGXxCgmuh0+AkeOG7hmlchRFWF4GmaR+vchPjk/eY+0mdf1samVCT+g4WNv2dfsN1NkxSvqtZFQpawdJHGQxwNwOoOf6nv29SkfC2X2jof9inoUolZsSb+VfK/qV3EZnqxOO5XFJ14ESa/+Mi18mzT6pwZObueUbsZjIvNv9fJiaVHfjpo18AqC922NKDOzqibs2g2s/w4SNhARcys7Z2SADJ5Wa8OIY4wEN3g54crQHcbqkguvuR3eOWm5k8fYQdtul/Jm19Gtru9YA3Om6Ugep9fiDjFmf3pvJQI6PexV4xjxnXXpvTNElUNCvjF8oqouezSZ9qzdiQN

On Mon, 14 Jul 2025 04:38:33 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jul 14, 2025 at 06:27:24AM -0400, Steven Rostedt wrote:
> > This has nothing to do with Mathieu being a friend. He's a long time Linux
> > kernel contributor and has played a key role in developing a new feature
> > that will help both perf and ftrace, but without the EXPORT_SYMBOL_GPL(),
> > LTTng can't use it. It's basically saying "thank you Mathieu for helping us
> > with this new feature, now go F*** off!"  
> 
> You don't have to be as explicit, but otherwise that's exactly how
> it works.  No one gets a free ride just because they are nice and/or
> contributed something.

Why is that?

And yes, I still consider it draconian.

> 
> The rest of your mail looks just as confused.

Let me rephrase it then.

How would you recommend getting LTTng into the kernel? It's a relatively
large project that has 75K of lines of code with development that lasted
around 20 years.

Should it be one big code drop?

Should Mathieu copy the history of his git tree into the kernel/lttng
directory and suggest a git pull request to Linus?

To break it up now, into reviewable patches would be a huge undertaking.
And who is going to review it? I don't have the time, do you?

Basically, Mathieu has been a good Linux kernel community member, and even
wants his code upstream. But when he's the only one with a stake in getting
it upstream, and it's a long time large project, there's no easy path for
him to do it.

Now he's helped out with a simple feature that lets perf and ftrace get
user space stack traces without the need for frame pointers, and he can't
use it unless his code gets upstream.

Have any suggestions for him, or do you just not care? But you are one of
the gate keepers of EXPORT_SYMBOL_GPL() which affects him.

-- Steve

