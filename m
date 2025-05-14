Return-Path: <linux-kernel+bounces-647522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7AEAB697F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE41819E6A43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018D2741A2;
	Wed, 14 May 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kd7csBhW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o71gfT01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C1262D27
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220880; cv=none; b=c5hHQ9UMbWU5qgM4Or7fqUyyjkJR6ZbobiMV9KjW2ZU4z9H5MHYkH6X5rGmtDFLoEQxBREITevepZBzHwWvND6u2QGOJQFoSps0P0r3PfEwj6YBgpLpP9l0mCpR1epzxbdKKiWdfrYkmu1o5RFvvwV8mCYxVSIvqW4xdltcfNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220880; c=relaxed/simple;
	bh=lPSEk3wUUElPEHAQ7MziHYylsTAKs/rmIfSOGUye8kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axEvC1wjBUpj39lW5UALQe+Wof7413nJ6FH3AoPw6eNxiXqTXZ2xKtZvpRoczQes70r2c5zDfV89UwEP3WaGgVB1OO1YDcT3pFAN9HGR6i471L86MyBRYNc1CAJAEKMxgJQFSoPrXCTsFojUAipFplZGxO6dMyHzj72UpsHDF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kd7csBhW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o71gfT01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747220876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xslvri7PeNrCEs1KrVV6+pQBrviWFITMmrv7pJl4bJc=;
	b=Kd7csBhWekY8l46d+QGXmRGXaHFdmzJ8mKdPVcCqyIpCPSoRl/vg/uLbm9CyWSNEb1gpBH
	FKwf1fvrKIhxdUQn+KtmLUKpZQ6JqPZmwL+IgSZXwe6jDB8TO3CV/dTxop8ckM0aroQ1ID
	4o9jW1fpgXJl6/Am3s3HsrVC4aQETVkA250GyMK/oB4npoKk7ldhjBg9JPmVFoo85p/xUs
	0RZEAch6pSM1UYi9e427/mtaFrjpEpPHXv/aGGj3vDNUuKhtEze7VZPethjj9v/IZHMdt4
	mExkEj0vDCDNBS7WaGpsTzpfzK5n2bdg9rauxc6RShLNEUBfU6/OjbwE0fOiTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747220876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xslvri7PeNrCEs1KrVV6+pQBrviWFITMmrv7pJl4bJc=;
	b=o71gfT0106du9YZguoUEM+iC3gI5v2AOG1CNieng8fn0a5MUc8ni4zPANQ7yXyUTpPSE4p
	x9t71rdCtfqYElAQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/2] local_lock: Move this_cpu_ptr() notation from internal to main header
Date: Wed, 14 May 2025 13:07:48 +0200
Message-ID: <20250514110750.852919-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While looking at what needs extra locks for PREEMPT_RT in order to rid
of the lock in local_bh_disable() I stumbled uppon two users which need
to lock the structure but the pointer is no longer per_cpu.

Patch #1 moves this_cpu_ptr() from the internal header to the main on in
         order to free the name space and have the __ prefix function to
	 do the same but without the this_cpu_ptr(). So
	   local_lock_nested_bh()   -> on per-CPU memory
	   __local_lock_nested_bh() -> on local memory.

         This change has been made to all local_lock*() functions.

Patch #2 is an example why it is needed. In a nutshell the per-CPU
         memory is allocated via alloc_percpu() and then the memory is
	 passed to queue_work_on(). The worker then retrieves the
	 structure via container_of(). No more per-CPU memory.

I attached #2 as an example and would route via crypto once #1 is
accepted. The user user I identified is nf_set_pipapo which is doing
something similar. This makes two users in total.

Sebastian Andrzej Siewior (2):
  local_lock: Move this_cpu_ptr() notation from internal to main header.
  cryptd: Use nested-BH locking for cryptd_cpu_queue

 crypto/cryptd.c                     |  6 ++++++
 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
 3 files changed, 31 insertions(+), 25 deletions(-)

--=20
2.49.0


