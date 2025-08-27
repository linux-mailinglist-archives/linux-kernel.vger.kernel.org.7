Return-Path: <linux-kernel+bounces-788348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDFB38336
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43B31BA656C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74134352FC3;
	Wed, 27 Aug 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpRyIbxI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPe49t71"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC97192B84
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299624; cv=none; b=UP4E6ldZHl/3FpPmU1F6SIgqB9xGvzkYRHNvhyIUCyfwdT7SE4piet4RPfpSBf8AtcqzHIvK8C+70NKWidcHglQMBQa/2FbUuJy9bKMjr8xGayJ9Gq5cGTczIWr51xLhfLXV5WvNF5pmIYhN4i6Tr6P+1/X+oWYosPNxlSRlKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299624; c=relaxed/simple;
	bh=HZ4zcuznyaYA5mz+3FMVlFtEKIO6itv+bsJUJaHdWUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf0SIDIytXtvLbxbtJNBTDNNoYUAYugSyQwcfmoMliiItfPwNmZLxKrhEtxxTTaPsGyc1ynoWE33nabs4vLdYCKmW6Ma2yAueyvOH0MCli5w6MdRwpBM6JQkirp6j/JFrirF83ujawKF3MyuBx3s8kzbA0G7i0HgwXY5FZ6j5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpRyIbxI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cPe49t71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yt6pNORiBRMKarAJyYXvL7QTT3KKl4VK2drJoxldTRs=;
	b=YpRyIbxITXK3hM4iUFSuX1MrR2itsuStX3jOycoy4jpD9xXMfu3s1ZGoddfpEb/hi4+G+J
	fOUWNq0yelg06sjQb8xss1b16NS+TF6F8wJPe4GDlLD8DIz6PKU/OnwUSqj63Xh7eAY+c2
	El+k9nhuz53YuQmhYYpMbYRkMq/HG+/rNt7xxt/4hffyDUVvukbM+VCooD3aMDX++Roo15
	c35xcRbjyuiLyYI4x69O8XIjBV5Z8D3KPnVrLs25e6lM7gGbwoUkzoBjo/i6aNS1L+oF+4
	VzT1SMbc0oZEahtSATsy/GRr+9b0Ab5WkzM8Oln9UOp1c7aRaXbJscpzy/n7FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yt6pNORiBRMKarAJyYXvL7QTT3KKl4VK2drJoxldTRs=;
	b=cPe49t71HvBt7JlYWs9Hs/9/jONDXbGYxEK44tOOx/2WHfhPtFGLiPRXDrk3eVepMiezEo
	Ps60lk1yc5HMsPAg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] selftests/futex: Fix some futex_numa_mpol subtests
Date: Wed, 27 Aug 2025 15:00:08 +0200
Message-ID: <20250827130011.677600-3-bigeasy@linutronix.de>
In-Reply-To: <20250827130011.677600-1-bigeasy@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Waiman Long <longman@redhat.com>

The "Memory out of range" subtest of futex_numa_mpol assumes that memory
access outside of the mmap'ed area is invalid. That may not be the case
depending on the actual memory layout of the test application. When
that subtest was run on an x86-64 system with latest upstream kernel,
the test passed as an error was returned from futex_wake(). On another
powerpc system, the same subtest failed because futex_wake() returned 0.

  Bail out! futex2_wake(64, 0x86) should fail, but didn't

Looking further into the passed subtest on x86-64, it was found that an
-EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
because the node value test with FLAGS_NUMA set failed with a node value
of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
because the supposed node number wasn't valid. If that memory location
happens to have a very small value (e.g. 0), the test will pass and no
error will be returned.

Since this subtest is non-deterministic, it is dropped unless we
explicitly set a guard page beyond the mmap region.

The other problematic test is the "Memory too small" test. The
futex_wake() function returns the -EINVAL error code because the given
futex address isn't 8-byte aligned, not because only 4 of the 8 bytes
are valid and the other 4 bytes are not. So proper name of this subtest
is changed to "Mis-aligned futex" to reflect the reality.

Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250810222742.290485-1-longman@redhat.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/t=
ools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932a..802c15c821906 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -182,12 +182,10 @@ int main(int argc, char *argv[])
 	if (futex_numa->numa =3D=3D FUTEX_NO_NODE)
 		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
=20
-	ksft_print_msg("Memory too small\n");
+	/* FUTEX2_NUMA futex must be 8-byte aligned */
+	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, 1);
=20
-	ksft_print_msg("Memory out of range\n");
-	test_futex(futex_ptr + mem_size, 1);
-
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
--=20
2.50.1


