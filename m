Return-Path: <linux-kernel+bounces-817798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC92B586B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F641B23D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08262C028B;
	Mon, 15 Sep 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtRIcnc8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2t7BfZc0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899252C027A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971599; cv=none; b=l5gOpGu6G+JbT88vGN/toviEcJSjqo6tWAdaBbqkJXzjQPRa3X49zZsnC1J3ni89RaYHUCBgEPu6DVDK++snAZH20D6070+Nu1Pon/+7hiO1uQm/+bo7TGzC8NsxNuuIP5KJlriHGzUHXKFK1iP1LPb6ev8+gCsFa7e0/vgjkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971599; c=relaxed/simple;
	bh=RcMD9vg5oTlZQkJ4Fd/QSiglAf0gmMZoJQ6DcNhuFgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l48HlrLf/W9EjnpIW9XXm/RYu/TX0cPg52kCgu2et48cVT1qQikS+pZoq6vqezPosTKM6VToZ9t2/8pM+LGGTnGSUfgpbPsbDOEREbstU3QQarNmRBKo6NNjs+rEDTeau1Drh812qKhvQxJA9wNYThvSDKSlA/KUY+0+t+nahls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtRIcnc8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2t7BfZc0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nT/1NUrkIw2D/vynHl81wBogxtmdsKj0QnGXnt7lss=;
	b=PtRIcnc86sqaLZKNUpIRQSQG947gNhlpZNU1FGpApdf9gb/k4EDelfxS4qQYZX8VYONhGg
	5SCCaxvlsadNH0cPWA2iCyjRXCW79+GKQFoJQbp0/LkaE0TLgi+snZe1grbLOzV/CpTbjf
	Jah+F+hWXlyFWrF3+7pjUFcBplTK4xB8dVipn7E2gFi/IZ4SjYuJSaufITlG3OtA248Xd3
	OAKEy3x/rS8OdNzE7/xH6gPLxx3PNoENb0hWNtsgGKFSn0Q5B4vI9VtkY1BU76DiBcodKj
	8c7apNHcKtwk7BLeRBhbu1qd8eUcJu4LUvDazqMjmR3KeOQJlgdKVNCyHk6QRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nT/1NUrkIw2D/vynHl81wBogxtmdsKj0QnGXnt7lss=;
	b=2t7BfZc0sAEX5mXN2w3xYnzpGoZpFD9pXrSxa3ZtTacaDUM5Ix/dJoMZ0VsDZzwlfeRxlX
	c+Z4qmFR5S1yrtDw==
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
Subject: [PATCH v2 2/3] selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest
Date: Mon, 15 Sep 2025 23:26:29 +0200
Message-ID: <20250915212630.965328-3-bigeasy@linutronix.de>
In-Reply-To: <20250915212630.965328-1-bigeasy@linutronix.de>
References: <20250915212630.965328-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Commit d8e2f919997 ("selftests/futex: Fix some futex_numa_mpol
subtests") removed the "Memory out of range" subtest due to it being
dependent on the memory layout of the test process having an invalid
memory address just after the `*futex_ptr` allocated memory.

Reintroduce this test and make it deterministic, by allocation two
memory pages and marking the second one with PROT_NONE.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../testing/selftests/futex/functional/futex_numa_mpol.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/t=
ools/testing/selftests/futex/functional/futex_numa_mpol.c
index dd7b05e8cda45..5f4e3111269c3 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -174,10 +174,13 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
-	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | =
MAP_ANONYMOUS, 0, 0);
+	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVAT=
E | MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr =3D=3D MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
=20
+	/* Create an invalid memory region for the "Memory out of range" test */
+	mprotect(futex_ptr + mem_size, mem_size, PROT_NONE);
+
 	futex_numa =3D futex_ptr;
=20
 	ksft_print_msg("Regular test\n");
@@ -192,6 +195,9 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, EINVAL);
=20
+	ksft_print_msg("Memory out of range\n");
+	test_futex(futex_ptr + mem_size, EFAULT);
+
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
--=20
2.51.0


