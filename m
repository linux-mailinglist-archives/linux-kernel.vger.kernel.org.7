Return-Path: <linux-kernel+bounces-729809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBFB03BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1164C17AA11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69211244661;
	Mon, 14 Jul 2025 10:27:24 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3D242D99
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488844; cv=none; b=M+DlQAxoC0hd7eihlQtDE6Pihrvu5wRw+yYTRQ0WAHTiCpMhoFUWurqDxZM3+iepFo769WnnqJ31XQ/bmPNp0OzWyjj92I1577ZQKBlgsxi5nWpHviaKUn9ltSEQ7czMCAvQjiDQ4MF/jC0tyx9xS3oMLDnP1Dj0biTsRB323A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488844; c=relaxed/simple;
	bh=f859ImdpSudKeNW1SzWr5v9y2JT4OEGZRmj8f/rUPqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO4lYCrLc4Oj6Ij0l2m92KVBmsooQa2nHWr0E6ZwGaY7kuLn9wuLDdGCMkKBJaLaDMiaFWC+UII5JupT1PPEp9NbM1EjtlLToa6KMaPXdmeeXhB0IvMJK2bImJGFl4rqUy47EVC2x5Hv0E7txlEz7UHxJKltKEYHr/SXvBjCH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A94001CECC7;
	Mon, 14 Jul 2025 10:27:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 32DEB20025;
	Mon, 14 Jul 2025 10:27:10 +0000 (UTC)
Date: Mon, 14 Jul 2025 06:27:24 -0400
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
Message-ID: <20250714062724.6febd9fb@gandalf.local.home>
In-Reply-To: <aHSmIa3uffj5vW-m@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 32DEB20025
X-Stat-Signature: 5qx5ek55mhyn7n675zawxk8zhbzg8bb7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18O29vn19TQ9DkBZJ68uISE+kXJHJzJkEI=
X-HE-Tag: 1752488830-25392
X-HE-Meta: U2FsdGVkX184+gBKiABvkn1oq2sQKAAZrP3lEarukBPpxTbeh/BtWNKCKOXxNjDrLePW4aS/24VAhlT4wFQPQXlSDIsI68eKHe55LYHJ6uY2QSYR+MbUCafcQWJzPFx9qTmH6kq/wpfNBe3chX+pssx6Wtn6qpiyPEj1pa/D1ouek4aSPTrLqeq5zVWXcjn+HI/iYRHmeUlHoNv3YC5ZwPp5ImQY4GKiS17V7bs05HDW+Nl1ZJkGJ//GU6MsdJpLKFfcrCaiio3Ytry1N0C6wmaqyZ2/4NsrNCPkW11TY5HNSMVESAPvHOZO1o/wXOBDd39ztBo4JUQ0T1UXi2ytCzevM2jWTss+bFej4YV1z2f00cUsqy2FSUc3k/+0D1gNJstUwg5Mhj+Pj/ryFwNet93UxGUMH1f5

On Sun, 13 Jul 2025 23:39:29 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jul 11, 2025 at 06:57:42AM -0400, Steven Rostedt wrote:
> > I want to bring up this discussion. I understand there's a policy not to
> > add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kern=
el
> > proper. My question is, does this policy have to be draconian? =20
>=20
> Yes.  Making exception for friends and family is like Austrian law

This has nothing to do with Mathieu being a friend. He's a long time Linux
kernel contributor and has played a key role in developing a new feature
that will help both perf and ftrace, but without the EXPORT_SYMBOL_GPL(),
LTTng can't use it. It's basically saying "thank you Mathieu for helping us
with this new feature, now go F*** off!"

> enforcement and thus errodes the whole principle.  If you think lttng
> is useful help ustreaming it.

That's the entire point. I have no stake in LTTng getting upstream. I just
sympathize with Mathieu as he has been very helpful in improving ftrace. To
me, open source software should work with each other.

Now, I would not block LTTng from getting upstream. I had a conversation
with Mathieu to discuss why it failed last time, and that's because we went
with the approach of trying to merge the features of ftrace and LTTng where
it made sense, and that became way more work than either of us had, and we
found no real benefit from it (besides getting LTTng upstream). It would
require at least 3 or 4 full months of manpower which I don't have time for.

=46rom what Mathieu told me, LTTng's kernel module is 75K SLOC, with 20 years
of development. It already has its own ecosystem. The only practical way
for it to get upstream is if it were to become its own subsystem (like
kernel/lttng).

Who's going to review 75K of SLOC? I don't have the time to. The only
reason I would want LTTng in the kernel is to officially welcome Mathieu
into our community. Other than that, I have no need for LTTng.

What would you recommend Mathieu to do? He's been helping us for several
years and the work he does helps perf and ftrace and other parts of the
kernel (he's helped improve RCU). But to get LTTng upstream, it would take
a massive amount of work. And Mathieu has tried before without success. Why
should he spend all this time to break up the code into reviewable portions
without anyone willing to review it?

As I mentioned before, Mathieu is at a bit of a disadvantage. His customers
are non-kernel developers. But he needs the interest of kernel developers
to review his code. But he can't find anyone willing to do that. He doesn't
want to waste his time trying spending months of work to get LTTng upstream
if there's no guarantee that it will be accepted.

Would be willing to review his work?

-- Steve

