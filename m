Return-Path: <linux-kernel+bounces-652388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA82ABAAD6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049087AC6DD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD820ADCF;
	Sat, 17 May 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWcU8T1m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="og4+uu82"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42A2066F7
	for <linux-kernel@vger.kernel.org>; Sat, 17 May 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747494903; cv=none; b=g2i8NhzSDdUBIjN5MNFiitCtPeaMFJmuEZ06SzeYZ/KIqxoTn+/Ahavr6OK5p1PbVwOhv+nKgVq5oO3pREzffjFXwcRm7MkK+UiwMfxbmGkz/5W5/3vOu5AfQFHVnnbrywwjypoP9VvYnh7+cTSr/K/s+sUw5xtS8l75AuBLZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747494903; c=relaxed/simple;
	bh=j/BzPvwStte+u580GD3gncn95b2rBkz0AAqHpk6bJBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvtDZMCcAvtM0C09d368ikPOLYsNVMC6BbCbWbaSaXf2X1CWUYK4pgxiz0osan6uLDeYFTVJ5mbJFk4XL2qtHvFuSAeep9OxAghG+qqVZVydCpH4uOaVaPEmYRApHlWxh2LK6GbGosyH3bCUMa0KG1zq6n1Uatr7c5sX78TcsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWcU8T1m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=og4+uu82; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747494900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuFsKmSU09nElHvJf8RpcCbmx97tu90mrN0WgRIDs1o=;
	b=sWcU8T1mYTcRg85jYjJqMtJAWIgT/JRVzucc7XbXbVZpYgBbL4MoKyddYakADNLfm6ZWcg
	2jG0rLT0gYv0iXuADswPdtopQ1Sx7gOu4mzzIZdeEeLvVNsVFXOfKbWj3slN4vB2nJ0Eim
	7jGm+trjgivh2C5RwPfznxXPm/xvSilQ4FjEO3nVV1k7BAdu07eQvMXVjxTZYDkhHHkuoI
	cWOMYMOYJQRB68gLXxsel8mjfHdTs3lASlD8J2POs1IVY4YEmWKandeot7JilaFCKMsBhA
	SDZbm9tMhjmVmTQCzWaHra6y3v/ywiLk7JBanUT5KMYxhVH8GKY1pStoEYFyBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747494900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuFsKmSU09nElHvJf8RpcCbmx97tu90mrN0WgRIDs1o=;
	b=og4+uu82dJ53pqzfbqw0nYZCoYojp3u3cAgMg2pZK/PWyW+ItuE9UNBIZSIktvcNHzIJCp
	H604cMpvKnK8J8Ag==
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
Subject: [PATCH v2 3/5] futex: Use RCU_INIT_POINTER() in futex_mm_init().
Date: Sat, 17 May 2025 17:14:53 +0200
Message-ID: <20250517151455.1065363-4-bigeasy@linutronix.de>
In-Reply-To: <20250517151455.1065363-1-bigeasy@linutronix.de>
References: <20250517151455.1065363-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need for an explicit NULL pointer initialisation plus a
comment why it is okay. RCU_INIT_POINTER() can be used for NULL
initialisations and it is documented.

This has been build tested with gcc version 9.3.0 (Debian 9.3.0-22) on a
x86-64 defconfig.

Fixes: 094ac8cff7858 ("futex: Relax the rcu_assign_pointer() assignment of =
mm->futex_phash in futex_mm_init()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 168ffd5996b48..005b040c4791b 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -88,14 +88,7 @@ void futex_hash_free(struct mm_struct *mm);
=20
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	/*
-	 * No need for rcu_assign_pointer() here, as we can rely on
-	 * tasklist_lock write-ordering in copy_process(), before
-	 * the task's MM becomes visible and the ->futex_phash
-	 * becomes externally observable:
-	 */
-	mm->futex_phash =3D NULL;
-
+	RCU_INIT_POINTER(mm->futex_phash, NULL);
 	mutex_init(&mm->futex_hash_lock);
 }
=20
--=20
2.49.0


