Return-Path: <linux-kernel+bounces-720046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E37AFB638
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134CF1620A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0242E172D;
	Mon,  7 Jul 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2eX4RYSq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH0KFYuI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA52BD003
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898997; cv=none; b=meZWUDVsu2hWhvgkosPqZn6evh5DOgKnyJfrU5SCBaXPP2A6DG6PErLk3Pcqgudtl4w31qHmjQ5KenirXN3FBNdyL2BeE0RSTTG5kVQWJJpYqz0/7YXCaJesSEhYzGnawFyzIqu1QjHxDifWCgEUPrc22yzeK+o0DeQ6o/B8caY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898997; c=relaxed/simple;
	bh=ySN3IGPUH+v7e9U5lCxAVJ3MoLm0PADu3ghbduR7DKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppyr8hHrEBSK1Idjxe7xRJH1bgkYmQ43bZ7PgTNeTZxIX6GlyVq0RJOe+9U82tzGRQ5IcFs4jSnQuvDPONiZsUeBgwCLXaYywI8m1dMxL3Q26qFnpFZNmbPRWtE3cChOS01GdVK79HVxJ1HkguTiz0BxeYNOsuuhRAInUXfOuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2eX4RYSq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH0KFYuI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHGi2Z6OPIJ5p7McK8oBTflMeJCBgNq0gbXegoXbuGE=;
	b=2eX4RYSqGjV/7uflYqxCMiCpj4vMdQeakbuWrF1MCfjryZDCk08vS9oDf1A+ilrDJQivQA
	hKboxnSbRBJxTa3mgvwLJ86GGmv4GEls3UIfRUuf4DIQViPrx6JaOyQxzFNHbtXIlbVHBf
	9VfeZ4858ukQ5e+1Nvmy08cbP7Nh7YZUsMg9ZlaJmpGJAl0b2y9qzFNLRsiym+WPwV5gzm
	JaPu0q8rrrOSInCJNyMC8odBUJsf0uZqv1uLcvrAbWps6LYOJreyZrW2cgeJO1/g9CpljV
	QoitWn+LAwn7Bn+aEYyeVxfuBkQVqjaO95eFdiJENZ1mpF71dNGzQIXjHG++7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHGi2Z6OPIJ5p7McK8oBTflMeJCBgNq0gbXegoXbuGE=;
	b=WH0KFYuILpYAxnbmniyxgk0cFbIvLdzfk3sWeMGkcgwa6agkvYYGQNLVVkmVDtVJ+5f+JV
	UxrtPVKJ9GZlVlCw==
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
Subject: [PATCH 3/3] futex: Make futex_private_hash_get() static
Date: Mon,  7 Jul 2025 16:36:23 +0200
Message-ID: <20250707143623.70325-4-bigeasy@linutronix.de>
In-Reply-To: <20250707143623.70325-1-bigeasy@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_private_hash_get() is not used outside if its compilation unit.
Make it static.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c  | 2 +-
 kernel/futex/futex.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b578a536a4fe2..f184d92ed7264 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -143,7 +143,7 @@ static inline bool futex_key_is_private(union futex_key=
 *key)
 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
=20
-bool futex_private_hash_get(struct futex_private_hash *fph)
+static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
 	if (fph->immutable)
 		return true;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617212eed..c74eac572acd7 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -228,14 +228,12 @@ extern void futex_hash_get(struct futex_hash_bucket *=
hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
=20
 extern struct futex_private_hash *futex_private_hash(void);
-extern bool futex_private_hash_get(struct futex_private_hash *fph);
 extern void futex_private_hash_put(struct futex_private_hash *fph);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
 static inline struct futex_private_hash *futex_private_hash(void) { return=
 NULL; }
-static inline bool futex_private_hash_get(void) { return false; }
 static inline void futex_private_hash_put(struct futex_private_hash *fph) =
{ }
 #endif
=20
--=20
2.50.0


