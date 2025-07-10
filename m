Return-Path: <linux-kernel+bounces-725497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81988AFFFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7204884B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A692E54DC;
	Thu, 10 Jul 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bu6kFVZh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRQdM4xD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD92E091B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145220; cv=none; b=pJZrtlfDAS2T9hLQzCZ8mNNaErlIu2cPysMPyxDTC+bAOdDh0NGnM5LHWAWBIJ1SFRhyEsO54shtczKWc4c2i0Pus6khsnu8QpNjNY6N5AiOem42DJxJJtbpwwk/v9sjzHzrvbJJtLZUBM+zBYDPDkEpEbm3N+864XoiaFSsnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145220; c=relaxed/simple;
	bh=+ThNQJN0DbohqGKY+flN4X+Txz1uC7m/vPbBH2exJmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgZ4Bo90oX2DvSgVtKsT1oCfFLlKbQe3feU1Zc6KTLvTGFoPsRqXSP6hPkhknF95u/KtCSxKyPNUcH15qE33Th3S5F1zZ9fF53mXabbn4GN3C6GGC97pfgwmpgz2NCBJt1GyEv5Pfo2JEDvv21nSUGmiuXDgoN+5sNVYDEsoypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bu6kFVZh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRQdM4xD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZuOHQOhHu6YpFOEA+NkXfkqho+ptJIg0qyPO2GsLKM=;
	b=Bu6kFVZhWoTvm10K/ybg4YjV3BSk6UoPyz4paXiNtb+cQVpfc+vlFEeY8MpLpVDK9sESQq
	R1e2xT1E7uTdW07y8XKwWLZqCwr28nSg1RtuyEg+liCz1NO+vsWERJ0QaseIP1NLoe5H5F
	IXYrcQyhm+spq3/O7U0VJT3OB06K32RnN0r90611HXiARBpdQSzPlRJXkZEONtivFf67zf
	HbjfaxClLx+drsFTi+Y8xnq69bjKbYyo9tGLtpgT6C1dubw45Kf662+04XDlWEl3QRUiIm
	fAb76O6CXehz0e1Jkz9LxONn1FbxzkUyVxh5aOdAYmZ6bJO0mACjssg8Bkk1BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZuOHQOhHu6YpFOEA+NkXfkqho+ptJIg0qyPO2GsLKM=;
	b=uRQdM4xDl1hi0bDqkoHE1YxjkTPs07617YeXmqFA/A8EbcIqtX0oFKYlJhwhrAt+QNuq+X
	BiI0xcXs+/IB3UBA==
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
Subject: [PATCH v2 1/6] selftests/futex: Adapt the private hash test to RCU related changes
Date: Thu, 10 Jul 2025 13:00:06 +0200
Message-ID: <20250710110011.384614-2-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The auto scaling on create creation used to automatically assign the new
hash because there was the private hash was unused and could be replaced
right away.

This is already racy because if the private hash is in use by a thread
then the visibile resize will be delayed. With the upcoming change to
wait for a RCU grace period before the hash can be assigned, the test
will always fail.

If the reported number of hash buckets is not updated after an
auto scaling event, block on an acquired lock with a timeout. The timeout
is the delay to wait towards a grace period and locking and a locked
pthread_mutex_t ensure that glibc calls into kernel using futex
operation which will assign new private hash if available.
This will retry every 100ms up to 2 seconds in total.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../futex/functional/futex_priv_hash.c        | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/t=
ools/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc94eb86..625e3be4129c3 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -111,6 +111,30 @@ static void join_max_threads(void)
 	}
 }
=20
+#define SEC_IN_NSEC	1000000000
+#define MSEC_IN_NSEC	1000000
+
+static void futex_dummy_op(void)
+{
+	pthread_mutex_t lock =3D PTHREAD_MUTEX_INITIALIZER;
+	struct timespec timeout;
+	int ret;
+
+	pthread_mutex_lock(&lock);
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_nsec +=3D 100 * MSEC_IN_NSEC;
+	if (timeout.tv_nsec >=3D  SEC_IN_NSEC) {
+		timeout.tv_nsec -=3D SEC_IN_NSEC;
+		timeout.tv_sec++;
+	}
+	ret =3D pthread_mutex_timedlock(&lock, &timeout);
+	if (ret =3D=3D 0)
+		ksft_exit_fail_msg("Succeffuly locked an already locked mutex.\n");
+
+	if (ret !=3D ETIMEDOUT)
+		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", r=
et);
+}
+
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -129,7 +153,7 @@ int main(int argc, char *argv[])
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
 	int use_global_hash =3D 0;
-	int ret;
+	int ret, retry =3D 20;
 	int c;
=20
 	while ((c =3D getopt(argc, argv, "cghv:")) !=3D -1) {
@@ -208,8 +232,24 @@ int main(int argc, char *argv[])
 	 */
 	ksft_print_msg("Online CPUs: %d\n", online_cpus);
 	if (online_cpus > 16) {
+retry_getslots:
 		futex_slotsn =3D futex_hash_slots_get();
 		if (futex_slotsn < 0 || futex_slots1 =3D=3D futex_slotsn) {
+			retry--;
+			/*
+			 * Auto scaling on thread creation can be slightly delayed
+			 * because it waits for a RCU grace period twice. The new
+			 * private hash is assigned upon the first futex operation
+			 * after grace period.
+			 * To cover all this for testing purposes the function
+			 * below will acquire a lock and acquire it again with a
+			 * 100ms timeout which must timeout. This ensures we
+			 * sleep for 100ms and issue a futex operation.
+			 */
+			if (retry > 0) {
+				futex_dummy_op();
+				goto retry_getslots;
+			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
 			ksft_exit_fail_msg(test_msg_auto_inc);
--=20
2.50.0


