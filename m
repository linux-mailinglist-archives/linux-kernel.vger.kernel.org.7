Return-Path: <linux-kernel+bounces-725496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F091AFFFF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983FA5C14A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AF2E54AD;
	Thu, 10 Jul 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKVyXKsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmPoe4qO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460522E0937
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145220; cv=none; b=Rl8IZ7CO7iVR69dn9RPYu3A1B6+xzY7iBh6tryukusAJAvy4I5as35Dx8I38OoWn8R8n212TGrWZOo+x/xnzf+QzDpzNjWpigq0WBmACVJu6I1NlQFmE2kyDyVtoiJV8LZ3STYALD2QnMFRBsrafFx77ZqLDh3VlVTooP/TkUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145220; c=relaxed/simple;
	bh=zoQcxiQn5CX5waZb1SoMGVD5PXot1RDtbj5z6HDb6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JRaVNqNaYu2FvasKCvFwNRYKuhPhVbpBxY3ftdelzB6RysoSJapj8Kl5xI43x5nhrf4SxSWUvdj+22jzLGRMbHJ8kGQIv+XWooRMP8z4vrEPv1z/CMW2vSEJVFjgivlaujX64ZZvhaoW05hP/sqzEHqbaNdxoRe2nEjVllkqAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKVyXKsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmPoe4qO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ah2/AINaMzthGxZV+T0/NUrwy8+v7yatwCmqcan2fGM=;
	b=ZKVyXKskLVWogFdLA5l0+GXd/IayC2n+zgB1DTEQUKEXN9XdByP6IAGvv0IJWkotg5r/i6
	hwOlPTjVSm29c4dzU93v4mXrQ/lsefB4x0p1yu+aKTlGBkscYuzK/7fw32cv5QHRDlnHhe
	gh0lpvi2sSVhjns0OxeB7c5fRXrx17Vh6rTqYjHFQKmJkM7itjeNhUktVVqa0NZWxW52Ue
	gTytSRjJd1vNgVe6JFNOXOVwAy5RrwA8cbJ+EVGYghGY5m63qAsPTYBwxfCmuWZzjcPWX2
	ikv6C8MZt1++wCCacrVbZbOT3FGHfCuu6QqbL0FKZJAo004N535iiupgdYJL8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ah2/AINaMzthGxZV+T0/NUrwy8+v7yatwCmqcan2fGM=;
	b=gmPoe4qOjUHhqOBW/eX3YqWJfA5tbEolG/ErBTJCVmx4+L8Zud2ZQUq8m2PzERfPfPUkvb
	oJKfUUOYWrjuimBg==
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
Subject: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Date: Thu, 10 Jul 2025 13:00:05 +0200
Message-ID: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I picked up PeterZ futex patch from
    https://lore.kernel.org/all/20250624190118.GB1490279@noisy.programming.=
kicks-ass.net/

and I am posting it here it now so it can be staged for v6.17.

This survived a few days on my machine and compile robot reported that
is passes its tests.

v1=E2=80=A6v2 https://lore.kernel.org/all/20250707143623.70325-1-bigeasy@li=
nutronix.de
 - Removed the IMMUTABLE bits
 - There was a race if the application exits while the RCU callback is
   pending. Stuffed with mmget()/ mmput_async().

Changes since its initial posting:
- A patch description has been added
- The testuite is "fixed" slightly different and has been split out
- futex_mm_init() is fixed up.
- The guard(preempt) has been replaced with guard(rcu) since there is
  no reason to disable preemption.

Since it was not yet released, should we rip out the IMMUTABLE bits and
just stick with GET/SET slots?

Peter Zijlstra (1):
  futex: Use RCU-based per-CPU reference counting instead of rcuref_t

Sebastian Andrzej Siewior (5):
  selftests/futex: Adapt the private hash test to RCU related changes
  futex: Make futex_private_hash_get() static
  futex: Remove support for IMMUTABLE
  selftests/futex: Remove support for IMMUTABLE
  perf bench futex: Remove support for IMMUTABLE

 include/linux/futex.h                         |  16 +-
 include/linux/mm_types.h                      |   5 +
 include/linux/sched/mm.h                      |   2 +-
 include/uapi/linux/prctl.h                    |   2 -
 init/Kconfig                                  |   4 -
 kernel/fork.c                                 |   8 +-
 kernel/futex/core.c                           | 281 ++++++++++++++----
 kernel/futex/futex.h                          |   2 -
 tools/include/uapi/linux/prctl.h              |   2 -
 tools/perf/bench/futex-hash.c                 |   1 -
 tools/perf/bench/futex-lock-pi.c              |   1 -
 tools/perf/bench/futex-requeue.c              |   1 -
 tools/perf/bench/futex-wake-parallel.c        |   1 -
 tools/perf/bench/futex-wake.c                 |   1 -
 tools/perf/bench/futex.c                      |  21 +-
 tools/perf/bench/futex.h                      |   1 -
 .../trace/beauty/include/uapi/linux/prctl.h   |   2 -
 .../futex/functional/futex_priv_hash.c        | 113 +++----
 18 files changed, 315 insertions(+), 149 deletions(-)

--=20
2.50.0


