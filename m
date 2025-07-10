Return-Path: <linux-kernel+bounces-725498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2778AFFFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226B25A8667
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7F52E7189;
	Thu, 10 Jul 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjEHAozQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WP2XrRDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC32E612B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145224; cv=none; b=EKe/6xRpr6P246ggeQsX0w2XwpfqaB1QQsv/d9+dqzcL/5a/BoesBcWOjMf9BA1tLj5esVyaQc8KN8/jKuPaQoKcYUbcvb+uQ8wDpbArttTbkiOKsjCcAHjUTe7G+2olszSe/648MEF4IbnvAvsyzGZKgRQ6ZZbRJFjM+S+TAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145224; c=relaxed/simple;
	bh=s6jWx3Ex1yAyBoRqDEmWyRcOriaDM0svhfJKXBjf6to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0nGrFUSJFAL1WEz7NvwhilsZntCkNnqCn8E39DISD8BZyjvXD4JsrXFtckmYsZspH3MVgRHiYNx6NnemQwT0Ot1vN2McF9KMPiC/8Uz4/yKop6iSIaXwHUmBxlPr6SxbU1kyT54undE86FnqN0jCuJghFFlxw7lWV/+HFAzQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xjEHAozQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WP2XrRDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blSukIN3CoYZ/Bhr2rxv9xJ99pcqaxJAXiP83jewurM=;
	b=xjEHAozQ4GkiFgvheajjqN4vsaekaSVnO85YmGLn3F0vPG4NXP6FuGYP3HzeOCxpYOUdYd
	/Kt2bLJ1eSGu/OyIe+PTXs1CjdH9VkWw6iJBbLHAlPvTVqbumrPO29bTl8kthwGZH/l9o2
	AbYqUPm033wN3MDbixFlZJS4bNH1ZQb7vBrFA7vjFu+1x3VmOCLLsreM+eqX24gDAgbxUk
	5ywd1tA2RA/ukTzIqWdswnYeohTDohfa5ElAIVHtsh7gocDCTGCUy0Ltkf9Wi8sQ0zZT0d
	MjYi8/fWWA9y0CIBZmFNQnigwMHMtwEePqobIaE+jubXenev/+58pcY+U6VWmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blSukIN3CoYZ/Bhr2rxv9xJ99pcqaxJAXiP83jewurM=;
	b=WP2XrRDZcq/C01sJM08/rK2KpK8ysJ6QD1k35qPTpX7heKL6Zm7ClTiHDDihudRHjkQMyP
	mC6gsTOHgfiVwpDg==
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
Subject: [PATCH v2 3/6] futex: Make futex_private_hash_get() static
Date: Thu, 10 Jul 2025 13:00:08 +0200
Message-ID: <20250710110011.384614-4-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
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
index 1dcb4c8a2585d..1981574a459d5 100644
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


