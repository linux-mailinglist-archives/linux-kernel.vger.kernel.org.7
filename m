Return-Path: <linux-kernel+bounces-772636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADAB29526
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F197AB19C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289823D2B6;
	Sun, 17 Aug 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ju1QIPfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rwUftpWj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D82139C9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755465792; cv=none; b=ToedeNZwMfsA03O+4y5x6YMQoR8C2UF4OmeJYsG1Hpp/Q18vx92F5SIA2ZFpWFVQL646QnGO1TPGKXdDQpHc7gFfexYE5DyjaARCgdk03SnMPkzrDBvLRuLQ23hPr5/KKgRHamcNFtpOMYNX0GkaN90nqyztO70KQRz+XdZvZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755465792; c=relaxed/simple;
	bh=JLM6RyBndAJw0GwvW7ZS14BSVdWFgA+Lj1ln6FtFnOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1jm/OTAHMHQmowNbC4LZ/GPGQpNOTXudMgzxJVR51luP9y/s9077EeZTyYYm5/xlf09AXK5seCVgY79DcnkszEBcvNe/LhVDGVGQhAKbkKMOExZKXfzHJVct3Xz5vpTsnE7aVrFj7icTFYqP7zqqP7oYjdGVgYhK6c6VYNHnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ju1QIPfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rwUftpWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755465788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXSjGL2EcyvMAa1DOUKHjPJFqG2gD5J2e+c96wj7Y6w=;
	b=ju1QIPfRcXZnDBfJpXQPI6tm5tcJrWpxMqVnN0EewbW90iZ2WJuz1Js2T/RA/MmeiQ/9f5
	raRMcywgpGTUBQH8spHbygHAC6Y/gH5xD001n8LPXPiZRdMkh1l0CS89QFen6ZAwnBp3Uh
	epQE3Ji2GpFcU71Z/0PwHdlXmbXRR4fcgWphAtssBwMBeHOzRxoJHpBqoYuql9J9hwEJrD
	ejrTkNDesdBVTYplnoBbhvDuszUkkx2Me4nklqrPqFk1vP5zHVfUn4TcF1l0KtvOEYQexn
	dRAGUdDTmsL60noNWPwZLDYLCFNSd5nhvo1402OdtpD+T0FZb1F+Ek/5rAXmxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755465788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXSjGL2EcyvMAa1DOUKHjPJFqG2gD5J2e+c96wj7Y6w=;
	b=rwUftpWjYKEWfQ91nrerqa97faCx6iv8QXvi+q98X/41nNjv28/nGBau4njZ6auzUFq4nI
	3Prliyp/QCnSIVCg==
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
In-Reply-To: <877bz67u3j.ffs@tglx>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk> <877bz67u3j.ffs@tglx>
Date: Sun, 17 Aug 2025 23:23:07 +0200
Message-ID: <87y0rh63t0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 14 2025 at 00:08, Thomas Gleixner wrote:
> On Wed, Aug 13 2025 at 15:36, Jens Axboe wrote:
>> On 8/13/25 3:32 PM, Thomas Gleixner wrote:
>>> Could you give it a test ride to see whether this makes a difference in
>>> your environment?
>>
>> Yep, I'll give a spin.
>
> Appreciated.

Please do not use the git branch I had in the cover letter. I did some
more analysis of this and it's even worse than I thought. Use

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/wip

instead.

I've rewritten the whole pile by now and made it a real fast path
without the TIF_NOTIFY horror show, unless the fast path, which runs
_after_ the TIF work loop faults. So far that happens once for each
fork() as that has to fault in the copy of the user space rseq region.

There are lightweight per CPU stats for the various events, which can be
accessed via

      /sys/kernel/debug/rseq/stat

which exposes a racy sum of them. Here is the output after a reboot and
a full kernel recompile

exit:           85703905    // Total invocations
signal:            34635    // Invocations from signal delivery
slowp:               134    // Slow path via TIF_NOTIFY_RESUME
ids:               70052    // Updates of CPU and MM CID
cs:                    0    // Critical section analysis
clear:                 0    // Clearing of critical section
fixup:                 0    // Fixup of critical section (abort)

Before the rewrite this took more than a million of ID updates and
critical section evaluations even when completely pointless.

So on any syscall or interrupt heavy workload this should be clearly
visible as a difference in the profile.

I'm still not happy about the exit to user fast path decision as it's
two conditionals instead of one, but all attempts to do that lightweight
somewhere else turned out to make stuff worse as I just burdened other
fast path operations, i.e. the scheduler with pointless conditionals.

I'll think about that more, but nevertheless this is way better than the
current horror show.

I also have no real good plan yet how to gradually convert this over,
but I'm way too tired to think about that now.

It survives the self test suite after I wasted a day to figure out why
the selftests reliably segfault on a machine which has debian trixie
installed. The fix is in the branch.

Michael, can you please run your librseq tests against that too? They
have the same segfault problem as the kernel and they lack a run script,
so I couldn't be bothered to test against them. See commit 2bff3a0e5998
in that branch. I'll send out a patch with a proper change log later.

Thanks,

        tglx





