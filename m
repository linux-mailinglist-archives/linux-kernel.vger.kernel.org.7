Return-Path: <linux-kernel+bounces-730069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F19B03FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CCB3AA1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E5149C7B;
	Mon, 14 Jul 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Rgf0gvm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7424A07A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499611; cv=none; b=L460QOFflUf5Mo2kWYsgx/zO41YnDYhVVXe07yygmamgH1Egv8Jh2X3/Gn4TGWLFo37a7numz4zJkuhJa8ierZ6bkZXEWJpYADebcTNwvtL2YsFprCyC6XOLlt5tYDuKJs1ybxAC5FpAI0zUbB2JGe273rHtMVv0GzVYOfKWW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499611; c=relaxed/simple;
	bh=2b+rRup0PKDhiumihPWe24espSaqxfUVAV0o8v0wTAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrIpOlltkHem/DUXdObhz6oeq47Vj5c+aO+8CzWK+S9iuCDYKP92Wt2bNSS5EW+f20UVO1Dprt9Vl73cI3X37y259Nit7f2Ldok+4C4XrE0ys7nqjwiQhERZOH5/q1tONVXgWkctwSnuXEu0RQQZtge1L0QXdpte5iXmva+ilJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Rgf0gvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F32FC4CEF0;
	Mon, 14 Jul 2025 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752499610;
	bh=2b+rRup0PKDhiumihPWe24espSaqxfUVAV0o8v0wTAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Rgf0gvmMhlhtV6fHgBpoJRve7WC1GtnvEKs2hsk3KboQmxpH5TKhlC2JbWQuV/7M
	 EOTcTSFC3Sq7C7EzRVAYYhIKvRhYEbVxK8yYr/Qcc8sChazh/vYg9dolQ+y1Le9GS/
	 NrwaY3MPlhX/JowN/9A/0mL1NEtQdIK7Zght9M/Y=
Date: Mon, 14 Jul 2025 15:26:47 +0200
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
Message-ID: <2025071419-negligent-balcony-84c5@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home>
 <aHTsOcIUs0ObXCo1@infradead.org>
 <20250714075426.36bdda0b@gandalf.local.home>
 <2025071443-lazily-blabber-3fbd@gregkh>
 <20250714082033.702160ad@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714082033.702160ad@gandalf.local.home>

On Mon, Jul 14, 2025 at 08:20:33AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 13:59:56 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > The maintainers of the subsystems in which the new code interacts with
> > are the reviewers, as always.  Again, nothing unusual here.
> 
> What subsystems does it interact with? It is an observer, it doesn't affect
> any subsystem. It's basically stand alone. It only needs to use the
> tracepoint infrastructure (which BTW, Matiheu is the maintainer of).
> 
> Just like perf and ftrace. They are stand alone subsystems where other
> subsystems may interact with them, but they don't really interact with
> anything else (besides the normal utilities like allocation of memory and
> such).
> 
> > 
> > > Have any suggestions for him, or do you just not care? But you are one of
> > > the gate keepers of EXPORT_SYMBOL_GPL() which affects him.  
> > 
> > This is not the issue at all, sorry Just submit it like normal.
> 
> So he could just send a thousand patch series that doesn't touch any other
> subsystem? It would have a diffstat that touches nothing but kernel/lttng,
> kernel/Makefile and kernel/Kconfig. Who's going to review it? Who's going
> to accept it?

Again, this is all things that we all know how to do and aren't new.
Get someone in a subsystem relevant to it to review a patch series that
adds the needed files to the kernel in a way that they can actually be
reviewed.

As it seems that we do have other tracing/perf developers already, start
with them and go forward to see what they say.

good luck!

greg k-h

