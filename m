Return-Path: <linux-kernel+bounces-817799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60892B586B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162BF3B8B56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1CF2C0F66;
	Mon, 15 Sep 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hN6WDuWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLU9r9US"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42132BFC70
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971599; cv=none; b=Mg6B2IMXQmOQt8VI9xn84HWxWZ/l9MvgHg1bQQ78pD33iYSapgbAwTYwiQSjaEHNpnOFiWMKGni+k0nHIIWHeTU8CwLPUCjpTGbAPlYSnNUqs4o5c14DDuNW12QPHnO6LlTmk2f6rgGof1pJIXqyThIbKcez9Whw9ZqvdfyP5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971599; c=relaxed/simple;
	bh=YhFEwzEIvubuo0TNT6znatq/ife0AtZ62ONaCKwn3+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcusZiBdoT7A+KX1lQt1icOwkCCJqOVWCQ1uxLHf4D7K4VgCKSmAQFdnVjOTwpweL01/QJ7fzXnA/sTVDWMlpA/95lsYl1DMnry8wzPmNh/t/qg+QTp/fqhwkhs7R8+rAGHP3GTlunG8P+qA9pqu8it/pA76pDDSTXb48W0dtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hN6WDuWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLU9r9US; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVEKX7jrb4owN8sB6DCMvwUlGC8C6fTvdYmspEO00rM=;
	b=hN6WDuWdrtJBylV74OUWQzpcFboZDp6VI9PKswJ23pZbBpWZAc+ZIM8t7qWic51OhHa00f
	kIUv6v2JikaN7AXHipyFn90M2a7eCZkVZDuPbnOTzjCqu5DIuGBeUhykTYsTu5iZ/y51UN
	eegoIO4G1xxSQDdQ1CPmYgQEz4GPpxRopuLeMpDmkljFBZb0UIntpoSW2hXtaqGzm36sa3
	ubtc2uGWYhfAOmmvJ9kb30IL23DNFOTBJxfuecr5rAFH2+AWfLj5aUbEen38wbUaFruFm+
	nj8sJF9WPNf9/Pc1FCrf6RxX1NBnr1JTcluzmTA3Dj2ivsmhqJUfang0mMZnKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757971595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVEKX7jrb4owN8sB6DCMvwUlGC8C6fTvdYmspEO00rM=;
	b=uLU9r9USnVX/p13/HXZZ6uN2IONFQCDBvkuGuqLTh5X2AJRuXaWGxJShujnnO/+hdWEcOc
	Nd5A2K8g9O+mZGAQ==
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
Subject: [PATCH v2 1/3] selftest/futex: Make the error check more precise for futex_numa_mpol
Date: Mon, 15 Sep 2025 23:26:28 +0200
Message-ID: <20250915212630.965328-2-bigeasy@linutronix.de>
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

Instead of just checking if the syscall failed as expected, check as
well if the returned error code matches the expected error code.

[ bigeasy: reword the commmit message ]

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../futex/functional/futex_numa_mpol.c        | 36 +++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/t=
ools/testing/selftests/futex/functional/futex_numa_mpol.c
index 802c15c821906..dd7b05e8cda45 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -77,7 +77,7 @@ static void join_max_threads(void)
 	}
 }
=20
-static void __test_futex(void *futex_ptr, int must_fail, unsigned int fute=
x_flags)
+static void __test_futex(void *futex_ptr, int err_value, unsigned int fute=
x_flags)
 {
 	int to_wake, ret, i, need_exit =3D 0;
=20
@@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
=20
 	do {
 		ret =3D futex2_wake(futex_ptr, to_wake, futex_flags);
-		if (must_fail) {
-			if (ret < 0)
-				break;
-			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
-					   to_wake, futex_flags);
+
+		if (err_value) {
+			if (ret >=3D 0)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
+						   to_wake, futex_flags);
+
+			if (errno !=3D err_value)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected error was %d, but r=
eturned %d (%s)\n",
+						   to_wake, futex_flags, err_value, errno, strerror(errno));
+
+			break;
 		}
 		if (ret < 0) {
 			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
@@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int must_fa=
il, unsigned int futex_flag
 	join_max_threads();
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
-		if (must_fail && thread_args[i].result !=3D -1) {
+		if (err_value && thread_args[i].result !=3D -1) {
 			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
 				       i, thread_args[i].result);
 			need_exit =3D 1;
 		}
-		if (!must_fail && thread_args[i].result !=3D 0) {
+		if (!err_value && thread_args[i].result !=3D 0) {
 			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
 			need_exit =3D 1;
 		}
@@ -120,14 +126,14 @@ static void __test_futex(void *futex_ptr, int must_fa=
il, unsigned int futex_flag
 		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
 }
=20
-static void test_futex(void *futex_ptr, int must_fail)
+static void test_futex(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int must_fail)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA | FUTEX2_MPOL);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG |=
 FUTEX2_NUMA | FUTEX2_MPOL);
 }
=20
 static void usage(char *prog)
@@ -184,16 +190,16 @@ int main(int argc, char *argv[])
=20
 	/* FUTEX2_NUMA futex must be 8-byte aligned */
 	ksft_print_msg("Mis-aligned futex\n");
-	test_futex(futex_ptr + mem_size - 4, 1);
+	test_futex(futex_ptr + mem_size - 4, EINVAL);
=20
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_NONE);
 	ksft_print_msg("Memory, no access\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
 	ksft_print_msg("Memory back to RW\n");
--=20
2.51.0


