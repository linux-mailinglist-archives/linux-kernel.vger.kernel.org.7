Return-Path: <linux-kernel+bounces-758290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98750B1CD48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73583BCFB5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C721B9C0;
	Wed,  6 Aug 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vODXZITt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HNjk4ppw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B55219300
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511178; cv=none; b=CqcEKoboF9XiKP3ioQ9Nmp8TEvFQ2WEoVzP4zveF5wDy0AhL0Yyh24Z0kK92p9cmvvCztL40hXfIOC6wwe6J3fmfiP/N2rtCTE6Kd69CHmaVCJ2GSsnD5pqJkmmjJswgzNF0APGs4wpOMQj9Ae3T7tIKScOZVGtbOqZ3csCmSIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511178; c=relaxed/simple;
	bh=aPyOP/WLcpYI92MGiSkESKjOPS5qHwF5cvvzSVgQWV0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=XNlmB5TpExO9zXXOAv7568Frfzg/mUhz4EO6gTbc1p4C0XbNqeEqfqPUj86oU+wQA6E3O5tIuPPv1ggl/TU53ULSBBwBKCI9cetmbm2LyNJp/z5b8Xg5XIg+/PFZ0tytaBdCZt3R8vDRLxPi45RX3xfMUQReYQBQ02dG3HqvNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vODXZITt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HNjk4ppw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806195624.880096284@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qJwWmVnLsQrpxtQyltYCZCwOTpwKJErr0sAA2X8l2q0=;
	b=vODXZITtQLr2XVdEXjvqsKF5OvtXW5+nyA0cakaa8kNFJ2pig+/94Ow6xyMwCr2OBp7Mci
	hnaJrWgswF0w0lq0YGvH6wRbkeLLhq77ZW/Nph41GsD6qFOcG5VQuWyC6jlOUcasJt/1OD
	To52XufliVzho2EPKpQ08Ywy56JOYkpB+ZWrbhEkzEKlAN64IC3Gs6t25XnrPvh96Mfwk3
	zjkdatVQYz8Bn4OicMFMJ056hAr0rLWWo5FeLjShXEyDojtTocd5BpNCAT8doTiZNt9nW3
	soQ9nzyw4+0kpEGMdV+SKR47Ai4wCOpaNyZnmvly4W8x2EHWg1MtWjWBZmNHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=qJwWmVnLsQrpxtQyltYCZCwOTpwKJErr0sAA2X8l2q0=;
	b=HNjk4ppw2dQgQurEjJ6sPnxqr1QfjiOAsZDizA2EVfd6we56ICqmyCfRSM93WlT2mA0Dlb
	8aXrkYqG9eBR4dAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 0/6] perf: Convert mmap() related reference counts to
 refcount_t
Date: Wed,  6 Aug 2025 22:12:52 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

It turned out that converting the code as is does not work as the
allocation code ends up doing a refcount_inc() for the first allocation,
which causes refcount_t sanity checks to emit a UAF warning.

The reason is that the code is sharing functionality at the wrong level and
ends up being overly complicated for no reason. That's what inevitable led
to the refcount leak problems.

Address this by splitting the ringbuffer and the AUX buffer mapping and
allocation parts out into seperate functions, which handle the reference
counts in a sane way.

That not only simplifies the code and makes it halfways comprehensible, but
also allows to convert the mmap() related reference counts to refcount_t.

It survives lightweight testing with perf and passes the perf/mmap
selftest.

The series applies on top of Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git perf/refcounts

Thanks,

	tglx
---
 include/linux/perf_event.h  |    2 
 kernel/events/core.c        |  361 ++++++++++++++++++++++----------------------
 kernel/events/internal.h    |    4 
 kernel/events/ring_buffer.c |    2 
 4 files changed, 185 insertions(+), 184 deletions(-)

