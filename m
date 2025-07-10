Return-Path: <linux-kernel+bounces-725500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FCAFFFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF276121E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AE2E763B;
	Thu, 10 Jul 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2R43D/Sc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XonZpfzO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7C2E62C4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145225; cv=none; b=VkfteS3mF/m5OmrJ4dEXv3IWN+cUt99uf00AD9cIk/ftRqVdoU6zINbs3cA4nxP54/Vc0yQ0XSYuiCY8XAhIDeQW9h7RDdRaRq3hwR1EJpP5VwHJsd924IIdIcZFJ9lG2A8vDBxfKAnioFv2HtB0OwV2845sLAv/ZR/cr0HY+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145225; c=relaxed/simple;
	bh=e4ieNbDVNJ0oF2cnKbpogHX+yYl740cXCeM2pfaBda8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA8FOTxGLjjeCQtc71o/iOPHDZhIoCwwkxrFhvUR6zmIPheW3Pz2+wEOZM5aNPVy3aSQXg4b7l9t3JqN4psvAZQl8yufgoA8qaEIT/xVztpYEpksX0kN7R2fPijz0n9vQ3fC6e8SAjJU0wGKNU/KNlPbCrt9mEMdOMM2/TePFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2R43D/Sc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XonZpfzO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfg2x8ebG/45Q4P97HTsPAZQeWvS2FnAOtMP+WryIsU=;
	b=2R43D/ScYNzfDoNLCQwiLy3moy0z6yIU3CpZaoOfIfRIaSUvQBbKxOKlgC+xRSgXbzY++R
	ubKrTvnII2ae0fSxxGt7c6CYGdYM4pxbtCoNwyHIP4m4ReJ4LofO4Lx94jEwWZOoD1cjOb
	alI5+CYkhjG4QsVA8LIjpD4wT5lfbB8TOvOqi3W0TRwoqIkcD8e1ptDmvuSx1SAmTRglI/
	a9rn5D0DTv41gmDSwcZmz0rKppQp9sSgTSoAXQ5WszTuMYMauV9RcxVuZKisbp3mU4lChB
	fMxKK2Wnxi5z9L//D9U7tja3GZJl28yMxB3/UA0KgbmCcETACOs6TeMYOY1XSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfg2x8ebG/45Q4P97HTsPAZQeWvS2FnAOtMP+WryIsU=;
	b=XonZpfzODvg33RjJXhMQlvxGCnmHjz5eoncmw1g7UnyyC9w24ApxEIqrM1sXf5dfiOu5tX
	XnQqFEyL2yP4cWBw==
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
Subject: [PATCH v2 5/6] selftests/futex: Remove support for IMMUTABLE
Date: Thu, 10 Jul 2025 13:00:10 +0200
Message-ID: <20250710110011.384614-6-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Testing for the IMMUTABLE part of the futex interface is not needed
after the removal of the interface.

Remove support for IMMUTABLE from the sefltest.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../futex/functional/futex_priv_hash.c        | 71 ++++++-------------
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/t=
ools/testing/selftests/futex/functional/futex_priv_hash.c
index 625e3be4129c3..a9cedc365102e 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -26,14 +26,12 @@ static int counter;
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 #endif
=20
-static int futex_hash_slots_set(unsigned int slots, int flags)
+static int futex_hash_slots_set(unsigned int slots)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, flags);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, 0);
 }
=20
 static int futex_hash_slots_get(void)
@@ -41,16 +39,11 @@ static int futex_hash_slots_get(void)
 	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
 }
=20
-static int futex_hash_immutable_get(void)
-{
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-}
-
 static void futex_hash_slots_set_verify(int slots)
 {
 	int ret;
=20
-	ret =3D futex_hash_slots_set(slots, 0);
+	ret =3D futex_hash_slots_set(slots);
 	if (ret !=3D 0) {
 		ksft_test_result_fail("Failed to set slots to %d: %m\n", slots);
 		ksft_finished();
@@ -64,13 +57,13 @@ static void futex_hash_slots_set_verify(int slots)
 	ksft_test_result_pass("SET and GET slots %d passed\n", slots);
 }
=20
-static void futex_hash_slots_set_must_fail(int slots, int flags)
+static void futex_hash_slots_set_must_fail(int slots)
 {
 	int ret;
=20
-	ret =3D futex_hash_slots_set(slots, flags);
-	ksft_test_result(ret < 0, "futex_hash_slots_set(%d, %d)\n",
-			 slots, flags);
+	ret =3D futex_hash_slots_set(slots);
+	ksft_test_result(ret < 0, "futex_hash_slots_set(%d)\n",
+			 slots);
 }
=20
 static void *thread_return_fn(void *arg)
@@ -152,18 +145,14 @@ int main(int argc, char *argv[])
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
-	int use_global_hash =3D 0;
 	int ret, retry =3D 20;
 	int c;
=20
-	while ((c =3D getopt(argc, argv, "cghv:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
 			break;
-		case 'g':
-			use_global_hash =3D 1;
-			break;
 		case 'h':
 			usage(basename(argv[0]));
 			exit(0);
@@ -178,7 +167,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(22);
+	ksft_set_plan(21);
=20
 	ret =3D pthread_mutexattr_init(&mutex_attr_pi);
 	ret |=3D pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHER=
IT);
@@ -191,10 +180,6 @@ int main(int argc, char *argv[])
 	if (ret !=3D 0)
 		ksft_exit_fail_msg("futex_hash_slots_get() failed: %d, %m\n", ret);
=20
-	ret =3D futex_hash_immutable_get();
-	if (ret !=3D 0)
-		ksft_exit_fail_msg("futex_hash_immutable_get() failed: %d, %m\n", ret);
-
 	ksft_test_result_pass("Basic get slots and immutable status.\n");
 	ret =3D pthread_create(&threads[0], NULL, thread_return_fn, NULL);
 	if (ret !=3D 0)
@@ -267,7 +252,7 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_verify(32);
 	futex_hash_slots_set_verify(16);
=20
-	ret =3D futex_hash_slots_set(15, 0);
+	ret =3D futex_hash_slots_set(15);
 	ksft_test_result(ret < 0, "Use 15 slots\n");
=20
 	futex_hash_slots_set_verify(2);
@@ -285,28 +270,23 @@ int main(int argc, char *argv[])
 	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting,=
 got %d\n",
 			 ret);
=20
-	futex_hash_slots_set_must_fail(1 << 29, 0);
+	futex_hash_slots_set_must_fail(1 << 29);
+	futex_hash_slots_set_verify(4);
=20
 	/*
-	 * Once the private hash has been made immutable or global hash has been =
requested,
-	 * then this requested can not be undone.
+	 * Once the global hash has been requested, then this requested can not
+	 * be undone.
 	 */
-	if (use_global_hash) {
-		ret =3D futex_hash_slots_set(0, 0);
-		ksft_test_result(ret =3D=3D 0, "Global hash request\n");
-	} else {
-		ret =3D futex_hash_slots_set(4, FH_FLAG_IMMUTABLE);
-		ksft_test_result(ret =3D=3D 0, "Immutable resize to 4\n");
-	}
+	ret =3D futex_hash_slots_set(0);
+	ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	if (ret !=3D 0)
 		goto out;
=20
-	futex_hash_slots_set_must_fail(4, 0);
-	futex_hash_slots_set_must_fail(4, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(8, 0);
-	futex_hash_slots_set_must_fail(8, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(0, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(6, FH_FLAG_IMMUTABLE);
+	futex_hash_slots_set_must_fail(4);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(0);
+	futex_hash_slots_set_must_fail(6);
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 	if (ret !=3D 0) {
@@ -317,14 +297,7 @@ int main(int argc, char *argv[])
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	if (use_global_hash) {
-		ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
-	} else {
-		ksft_test_result(ret =3D=3D 4, "Continue to use the 4 hash buckets\n");
-	}
-
-	ret =3D futex_hash_immutable_get();
-	ksft_test_result(ret =3D=3D 1, "Hash reports to be immutable\n");
+	ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
=20
 out:
 	ksft_finished();
--=20
2.50.0


