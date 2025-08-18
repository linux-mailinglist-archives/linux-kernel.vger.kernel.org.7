Return-Path: <linux-kernel+bounces-773776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A9B2A936
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F2687CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F22334701;
	Mon, 18 Aug 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zgd5b1vM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4me6+pL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0682C235C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525633; cv=none; b=XMbeWNYMVv6BgDczZreDoJWj6PHHw25Li3MgQvPtq4UG+0TQ1Nj7JGBNkHRgF/MWgYyem9oALJDH5rS6fHFILMd4j5+IOLXW8iDcQxt+hPs5Z5MbhP13jlZMBBKkOsh2WNpW+593oc8LLZGSqt1K72H5Z1TTQ5mrygE3GV/NBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525633; c=relaxed/simple;
	bh=h3swk4qRL3dPDPYDrY625JZC2Ljyge9kIUUw6N3ULas=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UpV/kJ9Y0WygUOVZQdwhe0r9Y754sIQsvG+K1gKJXmf1s5zzT3/L3sqWqRQ/HWBpj/QzbldxDXLuHAnojEtob+J2tOUmmw9HzKJ4MygeVFiNTk7XK/Qx6LbGnJaGG8PNUGzilun7JdKAc+ZALcdwWfoHbDPanoMsbK/K6I9pGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zgd5b1vM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4me6+pL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755525629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aTbuFVV8jFLwr0Bsdcae2y+C+bqr9Jf4zF9r6Ohn9q0=;
	b=Zgd5b1vMD3PTFTsgwm09ETRIVcG0Zp43dF0IN+G0EKK6w+eEVwgOi8DWB+guxKPUg76NrO
	GhQRs0iUKu4mMt6R7OetJeTtjpTB3w3nN1aR4eXMDiMOHN+LhIrIoac+67f5Yau5/74H7b
	GDCRK4qnMUhYY0NWyamLreDAu7yI8p1iDyrlM15MYIXnyg5BA5/uK4xlSa3kc3aJi7JaqI
	O8s2KTUQfsepsWcTQo+9CChbbeah4HVeMR9YmWXpQiw0+88K0XRWLjXwNIVmVr62pFQiVQ
	sL6J62ptinEDqA2dzpLz0GAS8lL1v94M30/MTL7lyYx2fP9xW88aHc7jiB3dfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755525629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aTbuFVV8jFLwr0Bsdcae2y+C+bqr9Jf4zF9r6Ohn9q0=;
	b=v4me6+pLL7sZvn7KXAbK2xKPlksaNxOuo6mRVzFr9yy7EP4i77sgM1N/6GN0jDKRbFSbbq
	7INfAfJmrUzXRHCw==
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, Sean Christopherson
 <seanjc@google.com>, Florian Weimer <fweimer@redhat.com>, Samuel Thibault
 <sthibault@debian.org>
Subject: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <87y0rh63t0.ffs@tglx>
Date: Mon, 18 Aug 2025 16:00:27 +0200
Message-ID: <87frdoybk4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 17 2025 at 23:23, Thomas Gleixner wrote:
> It survives the self test suite after I wasted a day to figure out why
> the selftests reliably segfault on a machine which has debian trixie
> installed. The fix is in the branch.

That's glibc 2.41 FWIW. glibc 2.36 from Debian 12 does not have this
problem.

The fix unfortunately only works with a dynamically linked libc,
statically linked libc fails. The fix is basically a revert of

   3bcbc20942db ("selftests/rseq: Play nice with binaries statically linked
                  against glibc 2.35+")

which introduced these weak libc symbols to make static libc linking work.

I have no idea why this creates havoc, but in GDB I saw that libc
manages to overwrite the TLS of the pthread at some place, but I gave up
decoding it further. If no pthread is created it just works. Removing
this weak muck makes it work too.

It's trivial to reproduce. All it needs is to have in the source:

__weak ptrdiff_t __rseq_offset;

w/o even being referenced and creating a pthread. Reproducer below.

TBH, this interface is a horrible hack. libc should expose a proper
function for querying whether it has registered rseq and return the
parameters in a struct. But well...

Build reproducer with:

# gcc -O2 -Wall -o t test.c
# ./t
Segmentation fault

# gcc -O2 -Wall -o t test.c -static
# ./t
#

Removing the weak __rseq_offset makes the dynamic case work too.

Yours sufficiently grumpy

      tglx

----
#define _GNU_SOURCE
#include <pthread.h>
#include <stddef.h>

#define __weak  __attribute__((__weak__))
__weak ptrdiff_t __rseq_offset;

static void *foo(void *arg)
{
	return NULL;
}

int main(int argc, char **argv)
{
	pthread_t t;

	pthread_create(&t, NULL, foo, NULL);
	pthread_join(t, NULL);
	return 0;
}


