Return-Path: <linux-kernel+bounces-788349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C9B3833A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14719361F31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65E3568F6;
	Wed, 27 Aug 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wvpqKMtu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRx2PEIe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FA350D68
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299625; cv=none; b=cFXnxzApOe5XlgoHsUuhTUV3s963FfvVxRgIBGtTOxq8SVL/44EdphO5hBsIlqVEK6zX0PETKQc6ANTdPTsk0U2TjzHGTDMonVSWmybe4oGOlWW84ikdC0Se0PufytMQqredsiOSNfIubxLIW1NiHzBqknA/wcH0RydTjtMt99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299625; c=relaxed/simple;
	bh=O3AhWn94wsXGAp86y1AsA0NZFEADYxt/dkM7qJD6TzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OO96fa+1ax6NfSYvVsgh1sgmidmmMg6pT1dVqo9mSSCmELyR6/Qpbo51BGJHXhsD0Q8TKG+vMNQoLFYXBKb6oY7MTywgJ1l1uVAee7Ue2Sl/3xPACgrnioOKLhIPsloX8tw5JJ4mCAvVu2MHjLWMu+RDe0B5z7GvYzHWyF7wO9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wvpqKMtu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRx2PEIe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB6FFSOhPnIA8CFfbKPevdZs4Nwx7FbW8ef3Pc1GPAk=;
	b=wvpqKMtugebNKK6XrT4f8aORyqfmYIwhNgAN2xahlpwkEh0NP2rCPAvhuCFEyQlpxrc8py
	bDz4q0thn/T5iHfbM7wmvQiKl4N4JGMcZ9IxJkkMfUIQhlkYwRRLyxDcgvLJDCLvS9L/hI
	mVqovdXT3slm3odeJvLosXGhrFgbqTCjPX9/PaX4IuJGDOytBajGPIjLdEFIyoy3lX1ew8
	Kg2pCliGxMPbzNW+WjSDpmvqDyw3P/9zHHkXvKujlG+985jlx6yVscZgD1jrDMYJIMPMEG
	6p3JP6SYOZhyV7C0ZywEm2AmulYOfjsLYE0gQ0wesBdk/FvnyU9FCfbZPRCSCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB6FFSOhPnIA8CFfbKPevdZs4Nwx7FbW8ef3Pc1GPAk=;
	b=jRx2PEIeXPdiaPdQwGB41BkVu3WK613RVV9FPtXZftJPPFzC8Qssc9rLQeFvH0mtvvFgSG
	KTZAc433pC9yukAg==
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
	Gopi Krishna Menon <krishnagopi487@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] selftests/futex: fix typos and grammar in futex_priv_hash
Date: Wed, 27 Aug 2025 15:00:10 +0200
Message-ID: <20250827130011.677600-5-bigeasy@linutronix.de>
In-Reply-To: <20250827130011.677600-1-bigeasy@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gopi Krishna Menon <krishnagopi487@gmail.com>

Fix multiple typos and small grammar issues in help text,
comments and test messages in futex_priv_hash test.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
Link: https://lore.kernel.org/r/20250819155755.4665-1-krishnagopi487@gmail.=
com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../testing/selftests/futex/functional/futex_priv_hash.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/t=
ools/testing/selftests/futex/functional/futex_priv_hash.c
index ffd60d03a992b..95f01603a6813 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -188,7 +188,7 @@ int main(int argc, char *argv[])
 	if (ret !=3D 0)
 		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
=20
-	/* First thread, has to initialiaze private hash */
+	/* First thread, has to initialize private hash */
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
@@ -256,17 +256,17 @@ int main(int argc, char *argv[])
=20
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	ksft_test_result(counter =3D=3D MAX_THREADS, "Created of waited for %d of=
 %d threads\n",
+	ksft_test_result(counter =3D=3D MAX_THREADS, "Created and waited for %d o=
f %d threads\n",
 			 counter, MAX_THREADS);
 	counter =3D 0;
-	/* Once the user set something, auto reisze must be disabled */
+	/* Once the user set something, auto resize must be disabled */
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
=20
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting,=
 got %d\n",
+	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manual setting,=
 got %d\n",
 			 ret);
=20
 	futex_hash_slots_set_must_fail(1 << 29);
--=20
2.50.1


