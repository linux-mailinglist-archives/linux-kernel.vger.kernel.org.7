Return-Path: <linux-kernel+bounces-720043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F6CAFB636
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6D016200F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFB2D8373;
	Mon,  7 Jul 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rSUpSOiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDpZmRHp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A51A238C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898995; cv=none; b=QX3tEwa4dWdvAU6xpqFWR3rQQXtbtColubsigCYjv+4Gow3tJ8tSH+SJ5J+/To1Bhs60H3QSSjIzxD9Z62rSQEwly0PyCPtMRSkQ5OsQU+wcF5XHRQnjcM3EYpvK//K9JyahzRz3h2W0R0hz1IMK+kSbQtYltuAP5dN6KjfaOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898995; c=relaxed/simple;
	bh=AHT3Ije64A05HYpvMTBUqwCa/x9nhxWshUIbcOMyHPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P87D1BUGR7n6CvWlKzPZz6KZINv/kCEO1zGzn8DXnHzbw2Aq/RnhncoeOSwRtFeJ8pIcMNPZZ68SDC7afNKsYk1BDpddzI/lNpPtqh7uRxdbCIMD8uMrLqva2gEEzBpm5SEPUImoYuPLMzTnhVJn4MtM9ItR8mbZkpbmVF/OJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rSUpSOiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDpZmRHp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X63aqwWxRBosj9h3pCUQKpUANFMA5wv7gkWrXg0MZiA=;
	b=rSUpSOiWgLAK7FdqjOFnWm4YR0z/NXIfTwhDi2uVNDZuNVGwZ8QYY5SRYW/U06NQ0hejp1
	4AC99Gqe6GTnSmPURgoEtJgR4VKx0kjvGGM1QEfThgndkI3Rexce7Os1zqi03GlNff+yla
	jIfFX4oo1RYcKtPvZuZQg80OaDghnJYgOJqpt/Wxv8HGlQBvxOeZHtO+exqRQa4BjNR1X1
	5imzolb2ckj/fiu16hrKQ+WF5Anb5MvFErndjxRSYnc2OTBOPCAeWltELmCZUHy4FWqnUl
	OfYNqi0UZnFKoP65R8sjJzY4xeN1ovhK9BN4pp2zxCGhJ89fewWCf5rE/A5XIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X63aqwWxRBosj9h3pCUQKpUANFMA5wv7gkWrXg0MZiA=;
	b=VDpZmRHpezUPrazThhAo96kStyKy61kcxjab+D9lXRvJ8QroyK+roMaDQ3GFjMMgz0hf4a
	X50mmJDjZgeIjlCQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/3] futex: Use RCU-based per-CPU reference counting
Date: Mon,  7 Jul 2025 16:36:20 +0200
Message-ID: <20250707143623.70325-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I picked up PeterZ futex patch from
    https://lore.kernel.org/all/20250624190118.GB1490279@noisy.programming.=
kicks-ass.net/
=20
and I am posting it here it now so it can be staged for v6.17.

Changes since its initial posting:
- A patch description has been added
- The testuite is "fixed" slightly different and has been split out
- futex_mm_init() is fixed up.
- The guard(preempt) has been replaced with guard(rcu) since there is
  no reason to disable preemption.

Since it was not yet released, should we rip out the IMMUTABLE bits and
just stick with GET/SET slots?

Sebastian

--------

Peter Zijlstra (1):
  futex: Use RCU-based per-CPU reference counting instead of rcuref_t

Sebastian Andrzej Siewior (2):
  selftests/futex: Adapt the private hash test to RCU related changes
  futex: Make futex_private_hash_get() static

 include/linux/futex.h                         |  14 +-
 include/linux/mm_types.h                      |   5 +
 init/Kconfig                                  |   4 -
 kernel/fork.c                                 |   6 +-
 kernel/futex/core.c                           | 239 ++++++++++++++++--
 kernel/futex/futex.h                          |   2 -
 .../futex/functional/futex_priv_hash.c        |  42 ++-
 7 files changed, 276 insertions(+), 36 deletions(-)

--=20
2.50.0


