Return-Path: <linux-kernel+bounces-725499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6CAFFFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC765C030F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E352E718D;
	Thu, 10 Jul 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCz3wxg6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGMuwvcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B202E6122
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145224; cv=none; b=bawQsOhnzylLNjwAOoq13bwWUtemDrN+2MpnJxadZ1NuBfgJpvFTzPMHW7cqywd059vr5c4ufu4GZoSzqykXABbTuGxCL8IhRCqKZjzHWulNpI8ulxE6yfxcygK99aH12h8Yv5vMfxki6XeakLtqlfmrNTmAHPu8n5r7l4IUiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145224; c=relaxed/simple;
	bh=2JB2xgvJ7VqhxKwXaxp9lQ9EPS6UzCrzIlxS0TeU8G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ5SfnM7ENPysSIJYLPTrzJo1tdQOJqviSuyqivGaq5zqm0FBn0qItM+fBXqD1t5GFtuLzXdyxA3vsJPMdeQmrfQPbRxxOaoaquqPMHrFyB8ZzDNMuxyNmwgIjAcc+8kumlUQJFXWKrTWjwP64Ofs9ICZZS5LMXbIRacaISx03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCz3wxg6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fGMuwvcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdUl88rznqHl5m+a4vcX9da19I7kSaXVW1otRUuqpt8=;
	b=GCz3wxg6as4JuZ6xk+nxH20PIl3ubKhUt6oBmHhD6cLzzB2yYK9iM5DIqUSAryrtsiouoj
	9LNMilknizMA0VLfidGQjvjWy0T2HiipOIAS5mq/3+Xia+pdl0nSZj+TVQuICidVWTkhGH
	Qf178sMuIMnwyZI2ouOAq7uiGUBVJK5yl6FxTVIJ5C2CFFlTzLa5Q0oGLTllOWGtR/BFcm
	ytL/mvPKP1XE5wNa5CXhSE4xaQSgZxqwk1X0yw3eYsju8reLrd9yX0gEhy+2IqthIiibii
	S5Ersf5FcbRxVOuth0C3GZUGIo6uhUQfa3Vq9sVTNy2n7M3koChKK+mnJyqmuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdUl88rznqHl5m+a4vcX9da19I7kSaXVW1otRUuqpt8=;
	b=fGMuwvcbve0W9FE1TT8lvubAAzE41JnVcpIrXwnC1wE/5pBuZmuAHq5EnknzrWooyX7VA6
	aSKPzUE0czI6SVAQ==
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
Subject: [PATCH v2 4/6] futex: Remove support for IMMUTABLE
Date: Thu, 10 Jul 2025 13:00:09 +0200
Message-ID: <20250710110011.384614-5-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The FH_FLAG_IMMUTABLE flag was meant to avoid the reference counting on
the private hash and so to avoid the performance regression on big
machines.
With the switch to per-CPU counter this is no longer needed. That flag
was never useable on any released kernel.

Remove any support for IMMUTABLE while preserve the flags argument and
enforce it to be zero.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/uapi/linux/prctl.h |  2 --
 kernel/futex/core.c        | 36 +++---------------------------------
 2 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559a..3b93fb906e3c5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1981574a459d5..d9bb5567af0c5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -69,7 +69,6 @@ struct futex_private_hash {
 	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
-	bool		immutable;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -145,15 +144,11 @@ static inline bool futex_key_is_private(union futex_k=
ey *key)
=20
 static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
-	if (fph->immutable)
-		return true;
 	return futex_ref_get(fph);
 }
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	if (fph->immutable)
-		return;
 	if (futex_ref_put(fph))
 		wake_up_var(fph->mm);
 }
@@ -1530,7 +1525,6 @@ static void futex_hash_bucket_init(struct futex_hash_=
bucket *fhb,
 }
=20
 #define FH_CUSTOM	0x01
-#define FH_IMMUTABLE	0x02
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
=20
@@ -1800,7 +1794,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
 	 */
 	scoped_guard(rcu) {
 		fph =3D rcu_dereference(mm->futex_phash);
-		if (fph && (!fph->hash_mask || fph->immutable)) {
+		if (fph && !fph->hash_mask) {
 			if (custom)
 				return -EBUSY;
 			return 0;
@@ -1814,7 +1808,6 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
=20
 	fph->hash_mask =3D hash_slots ? hash_slots - 1 : 0;
 	fph->custom =3D custom;
-	fph->immutable =3D !!(flags & FH_IMMUTABLE);
 	fph->mm =3D mm;
=20
 	for (i =3D 0; i < hash_slots; i++)
@@ -1838,7 +1831,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
 		mm->futex_phash_new =3D NULL;
=20
 		if (fph) {
-			if (cur && (!cur->hash_mask || cur->immutable)) {
+			if (cur && !cur->hash_mask) {
 				/*
 				 * If two threads simultaneously request the global
 				 * hash then the first one performs the switch,
@@ -1931,19 +1924,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
-static int futex_hash_get_immutable(void)
-{
-	struct futex_private_hash *fph;
-
-	guard(rcu)();
-	fph =3D rcu_dereference(current->mm->futex_phash);
-	if (fph && fph->immutable)
-		return 1;
-	if (fph && !fph->hash_mask)
-		return 1;
-	return 0;
-}
-
 #else
=20
 static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
@@ -1956,10 +1936,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
-static int futex_hash_get_immutable(void)
-{
-	return 0;
-}
 #endif
=20
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long=
 arg4)
@@ -1969,10 +1945,8 @@ int futex_hash_prctl(unsigned long arg2, unsigned lo=
ng arg3, unsigned long arg4)
=20
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		if (arg4 & ~FH_FLAG_IMMUTABLE)
+		if (arg4)
 			return -EINVAL;
-		if (arg4 & FH_FLAG_IMMUTABLE)
-			flags |=3D FH_IMMUTABLE;
 		ret =3D futex_hash_allocate(arg3, flags);
 		break;
=20
@@ -1980,10 +1954,6 @@ int futex_hash_prctl(unsigned long arg2, unsigned lo=
ng arg3, unsigned long arg4)
 		ret =3D futex_hash_get_slots();
 		break;
=20
-	case PR_FUTEX_HASH_GET_IMMUTABLE:
-		ret =3D futex_hash_get_immutable();
-		break;
-
 	default:
 		ret =3D -EINVAL;
 		break;
--=20
2.50.0


