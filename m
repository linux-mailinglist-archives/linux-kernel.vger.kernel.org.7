Return-Path: <linux-kernel+bounces-730149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC66FB040B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60983174CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C95E2566E7;
	Mon, 14 Jul 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pw9Nhdcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE902561AE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501378; cv=none; b=D3O2HSIz88JT+I9omp5da03UOhj74rLH5gBZ2ssP8RmptlEPrDlY0/RaD1QuT6cOpfccT2JpzA44mreq+vSVjVH1Htp5jGaZlKVDkGv2ohyMsEeP5QdW+BsBNjAjDpZiawFYpepWavK41QSQ6p+iL0MDMxktxiyjfiJ1v4aa5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501378; c=relaxed/simple;
	bh=qj9v9dfzED58+mSLZ2RvU2Lt3MAK+e/SoCAM3E4j+LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvlxc/IsKqnzPeSdXB7TzpHiZgTitSZ2JE89S9AMOsb9l71o/i15886Pp0i0wXw/D5UTEtdvqXnNumg9AbHGTioX4hxyOLn+fjUB5xUa46D15wPGEmEkYxxNu2qsZElrUEJKI0ITZMrSUcIUYRCh8A7tTIQof6lE2+K6pND4rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pw9Nhdcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65499C4CEF6;
	Mon, 14 Jul 2025 13:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752501377;
	bh=qj9v9dfzED58+mSLZ2RvU2Lt3MAK+e/SoCAM3E4j+LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pw9NhdcvqUgntRdlhBsOhAg++1iK0TVDOa/5TUK8a471dvdgrQn63tsHaN+pjuOkB
	 HIXPGKm2EOgr9PF5NJM0N/PwTbztKKFOEgcGDB8CeAqAvU4HxsRAMMn/Wv+1KnxGXm
	 SCU91mr/Qp5BB4VZ7Qwvv4iXDFEwIeOEoTrlNAts=
Date: Mon, 14 Jul 2025 15:56:14 +0200
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
Message-ID: <2025071435-disorder-obliged-b74e@gregkh>
References: <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
 <aHSmIa3uffj5vW-m@infradead.org>
 <20250714062724.6febd9fb@gandalf.local.home>
 <aHTsOcIUs0ObXCo1@infradead.org>
 <20250714075426.36bdda0b@gandalf.local.home>
 <2025071443-lazily-blabber-3fbd@gregkh>
 <20250714082033.702160ad@gandalf.local.home>
 <2025071419-negligent-balcony-84c5@gregkh>
 <20250714093547.62159c19@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714093547.62159c19@gandalf.local.home>

On Mon, Jul 14, 2025 at 09:35:47AM -0400, Steven Rostedt wrote:
> On Mon, 14 Jul 2025 15:26:47 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > As it seems that we do have other tracing/perf developers already, start
> > with them and go forward to see what they say.
> 
> We tried that. I don't have the time and I'm sure the perf folks don't
> care. I advocate for LTTng because of the support that Mathieu has given
> us.

When was this last tried?  If you don't have time, then the fault is on
you, not us :)

> The only other option is to allow LTTng to have access to a couple of
> functions that Mathieu helped develop. Otherwise it's forcing me to say
> "Thank you Mathieu for all your work, now go F*** off!".
> 
> Which appears to be the only option :-(

Stop making this false argument please, we aren't telling anyone
anything different from what we have always been saying for decades now.

Again, we don't export symbols for when there are no in-tree users.
That's it.

lttng not getting merged because you don't have time to review it should
not make the above rule somehow invalid.

sorry,

greg k-h

