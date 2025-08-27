Return-Path: <linux-kernel+bounces-788347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A84B38339
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E716C88F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552CC35209F;
	Wed, 27 Aug 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s1m/NoT3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6v8s54U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6F350D5D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299624; cv=none; b=F75Wfbk+SU0vQX0JcfrI4MobwtkR9e883AUgWC3A2nDbEBJaLFV8gFdP/OCkzucXu9LqV8lOED/ElXFrLWH14DQraTFonYFlMHQgNtA3yJWQi3F+08LgAm/PtVi87sdLPWgi0XW1b0ioEMyJeSY4UGcT9yTwvXs0X+siZAzcfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299624; c=relaxed/simple;
	bh=mGHLepCtQCEvWNdCKD1LIrK3CPcYLarbvtrKP78/pJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehxJjsRtCn3WryZDUX026FmM/spmUGp/KxgrigowUJZLRpDiI8QbgEIjZExati3Nl9cRvzXMUgyT2Qh6N5UlLGMXDmZTRvBb7W427sFZA0csqaZb1vdb7PxkuITQMSS/K40GRXHm3lDBEXlhCBRrKPiKf7ZKpELP8ktPGXlSS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s1m/NoT3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6v8s54U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xjtv3RawB4rRYFQ7stZq2BhYBo38SrKDEASGX4ZpU4=;
	b=s1m/NoT321CUGWAFY+3YHhjTwo20ap8v4BAPwz51olr5GTXwIZhMgmRMJG5urGvkgOyKvk
	PZFRnCW+gLqXY5EcIWn4Aw7L3Wk3fjSQ6PR39Dzhs2pdUQ3Bkw12impLP9OfR0veZ7kNcA
	SOUXFf27WpGDqM9HJu57rayqMyg/w2XVwA+zmyGsEhc3RJbd8q7fWeFHPKDuG8ATkNtk5x
	QfI1a/rRyvY/SGvNXvnjiOnnFbS3KoUrfhMcOWeWI1osjHKOscNowpKYu2Pl2owzJtO4WS
	th2Vf9Dc/IBbvGWmii8gM+37USS2+lXod/9ZsoDXh/wIcHVe+djWAFC81CGByA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xjtv3RawB4rRYFQ7stZq2BhYBo38SrKDEASGX4ZpU4=;
	b=C6v8s54U0JlCRICNxOP2EoyCRFI0e6p3fbSmXIgu0Y8YWjQKESYfaZglfAd0rGeAMC/3kI
	2H/XxKfzEWvZ0MAQ==
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
	Nai-Chen Cheng <bleach1827@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] selftests/futex: fix format-security warnings in futex_priv_hash
Date: Wed, 27 Aug 2025 15:00:09 +0200
Message-ID: <20250827130011.677600-4-bigeasy@linutronix.de>
In-Reply-To: <20250827130011.677600-1-bigeasy@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Nai-Chen Cheng <bleach1827@gmail.com>

Fix format-security warnings by using proper format strings when
passing message variables to ksft_exit_fail_msg(),
ksft_test_result_pass(), and ksft_test_result_skip() function.

This prevents potential security issues and eliminates compiler warnings
when building with -Wformat-security.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
Link: https://lore.kernel.org/r/20250812005048.59892-1-bleach1827@gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../selftests/futex/functional/futex_priv_hash.c       | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/t=
ools/testing/selftests/futex/functional/futex_priv_hash.c
index ec032faca6a91..ffd60d03a992b 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -192,10 +192,10 @@ int main(int argc, char *argv[])
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
-		ksft_exit_fail_msg(test_msg_auto_create);
+		ksft_exit_fail_msg("%s", test_msg_auto_create);
 	}
=20
-	ksft_test_result_pass(test_msg_auto_create);
+	ksft_test_result_pass("%s", test_msg_auto_create);
=20
 	online_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
@@ -236,11 +236,11 @@ int main(int argc, char *argv[])
 			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
-			ksft_exit_fail_msg(test_msg_auto_inc);
+			ksft_exit_fail_msg("%s", test_msg_auto_inc);
 		}
-		ksft_test_result_pass(test_msg_auto_inc);
+		ksft_test_result_pass("%s", test_msg_auto_inc);
 	} else {
-		ksft_test_result_skip(test_msg_auto_inc);
+		ksft_test_result_skip("%s", test_msg_auto_inc);
 	}
 	ret =3D pthread_mutex_unlock(&global_lock);
=20
--=20
2.50.1


