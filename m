Return-Path: <linux-kernel+bounces-726511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E423B00DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64B916BA87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47D23FC74;
	Thu, 10 Jul 2025 21:33:06 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E241E520B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183186; cv=none; b=snoAuxMserDRLc3XzwaguprOxgNdc4KNCDcOuiZNhFCB2w10XEctszExpbE/+bT4oOrWwMi8JLmzDdWjmQ4i6GW5Df9wHNbEY0Rjxud0+qgeTH70geq8hKUgF0Ab4RvgxHsO+bUg6deD+BJXTFX/nD+dvuzQ+QnyIklkxOqRzjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183186; c=relaxed/simple;
	bh=Kd88K6YoKyeXCu6B+S/I6pzQ80lwQj+X54U2LAoOhlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzZl9DDQrmhvW9x16GC9i7vNV40iyHXuRq0Tj7osyIueTE+D3PZgGbPQhahdPuYs6JgEI5wf5NOYSWcvqESeVLd0PJsIZBu2VMFLF13Yca0OHPZk7fpkAaBGpEo1Ka/hqrwv1hERhKRHPr7q09SLA1+/I0H6y7PLaFRZz4poh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 8B18AB6FF1;
	Thu, 10 Jul 2025 21:33:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0E0D82002D;
	Thu, 10 Jul 2025 21:32:57 +0000 (UTC)
Date: Thu, 10 Jul 2025 17:32:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 4/5] unwind: Rename unwind_stacktrace to
 unwind_user_stacktrace
Message-ID: <20250710173257.794d466d@batman.local.home>
In-Reply-To: <20250709174139.4aa32d2c@gandalf.local.home>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-5-mathieu.desnoyers@efficios.com>
	<20250709174139.4aa32d2c@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ezzuri46uqerrnhrqx4tozce16dq16sp
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 0E0D82002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aNrPKpqUKulxO/L4vTre5XltVbYz04Xk=
X-HE-Tag: 1752183177-998424
X-HE-Meta: U2FsdGVkX1/JKrOy+vWO9tVCXTsEtNmuG97HVlMI/dhxOL3oHpa2rQaGkypyJaruxrBpH0oPoRs99tHx+qNcGg0GWgLEmHKXkw1FPD7cTYu4xOuYrt+3hWFd6F7JB/NRJm9yfpWF2s735cJtH+JhpTq6UfcPXie/hbgRFUTfTCJ5Q62Gge100jNukQOLDX/++JOaXM5x2rDUiLChfhPNGPoMm9+p0xppQqgY8j2q/KDGLPXV0m/t2FdTcZPcF1C5UWkCjhPKahbgipDQsTRGUdSoTcnTKq11YfxqNp6JbVg6lfqCbFhgherv49XGXPTXfYiY4XedPmmNPJqJl4W99un1Iycx1NRIaNYTFa/6LIY82nq7DNwC11odBWnRwsQxDFDCn+FPmyqqKGr5Tt+ZJToxBStA4HDytiNbj8XqEZSiDCShSmXTHKz0EoMUZrWB

On Wed, 9 Jul 2025 17:41:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  9 Jul 2025 17:25:51 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > Rename the unwind_stacktrace structure to unwind_user_stacktrace to make
> > it consistent with the rest of the API.  
> 
> We originally had that name, but decided it was too long. As only the
> deferred unwind uses "unwind_" and it is currently only for user space, do
> we really need to have a 22 character structure name? 17 is already big
> enough.
> 
> And say we make an unwind_kernel_stacktrace()? I doubt we ever would, but
> if we did, it would still use the same structure. There's nothing
> inherently user space here (with maybe the exception of the compat type,
> but still).
> 
> And how is this unique to user space? The kernel can have sframes too.
> 
> Actually, I think we should rename "enum unwind_user_type" to
> "enum unwind_type".
> 
> struct unwind_entry {
> 	enum unwind_type	type;
> 	unsigned long		ip;
> };
> 
> As it is only being used for user space now, but it doesn't mean it can't
> be used for the kernel.
> 
> Heck, there's already work to use sframes in kernel code to replace ORC so
> that architectures like ARM64 can have live kernel patching.

Actually, I'm going to leave everything as is. The "struct unwind_user_*"
is only used internally in the user code and is not part of the API of
the infrastructure. The "struct unwind_stackframe" is used in the API
as a parameter. To me, it makes more sense to keep it short than adding
"user" to it and making all the callbacks have a longer name.

I know your patch 5 exposes more, but we'll deal with that when the
time comes.

-- Steve

