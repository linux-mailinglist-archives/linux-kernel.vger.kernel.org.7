Return-Path: <linux-kernel+bounces-738204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A596B0B5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F24F18942B3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED2209F45;
	Sun, 20 Jul 2025 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gu3RLpw+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GqEkUvzw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF21E7C2E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013103; cv=none; b=JoswO7rSdKS1mJkoBNJBr8Baj6f+zskyYchjshCQzaABQ2VgdDceiPs63uL6/kKhHTNEGuq+e/ljqu3O1WnmeDKVv4BUS74u75evV+gfPaee65sR6CSWqykFqcKPTFSKkGk8MI8EF57fcqXbHp/FcbWoAQtUYLOs0umu9lIC7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013103; c=relaxed/simple;
	bh=0kp3NbuZqk7QpgL4nCJPw9bWrbp4V0I5ACbU5aPxiyk=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=KeiYVw++sbZ8JpRN5YCXMD4B1iduZ7QmtrPjy22n5ZB6EFujuPdzXcUw0rOr7ZX87FWsd8Eq1Rt5VGvq21v3rvYefV7AP388Az5x9a38dGrtSctwchcqrcgPiZV1ojkEqXrRp/GtQZqWYsbgIXBx6L8k/N/NCXum2N8ENHrijLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gu3RLpw+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GqEkUvzw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753013100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=MtaJZERBYx++DdM2Y0k78LYeW5BZLhrJv8g3UO0z0vA=;
	b=Gu3RLpw+GJ6EjqhLb14n2BzX1u73ra4LthcXy47b4P3zh+VxMEJ/ojPuoWZw+pLVPl9NHY
	T+N5TLG5LAhbxyVpZAR3sNE6gWS3naG9qjGCnObkRjPiBCecdE0s88VCZ6m0aQtu+0quIK
	OU57OIZpt0LLtXWdzjdgwLZeiXbDEyFLhe1I4MCu2HMgesZXmrNUM2rTiM+ob0uTfFobIC
	rbeW89JXeZ2AS3CE30+K/uJXyFOf3F6dzr78ZEFrsDDmfznJH4xQq5FU12ApDxb8rQ+cj1
	NAzHFY5YqpTx0yCHG38BTVFFAz25Kipddxf7C3pH3eKTVNHSDbwapWUaZahbSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753013100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=MtaJZERBYx++DdM2Y0k78LYeW5BZLhrJv8g3UO0z0vA=;
	b=GqEkUvzwYj03HpdJyMq7uozWqEjDqXLIgwQ/z3tdAN5bcDObH52ulV365+UO7vJwUSKEfE
	ItkqxpTo+lT+6HAA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v6.16-rc7
References: <175301303546.263023.1426155806374119244.tglx@xen13>
Message-ID: <175301303716.263023.8607719725649129120.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Jul 2025 14:04:59 +0200 (CEST)

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
5-07-20

up to:  36569780b0d6: sched: Change nr_uninterruptible type to unsigned long

A single fix for the scheduler. A recent commit changed the runqueue
counter nr_uninterruptible to an unsigned int. Due to the fact that the
counters are not updated on migration of a uninterruptble task to a
different CPU, these counters can exceed INT_MAX. The counter is cast to
long in the load average calculation, which means that the cast expands
into negative space resulting in bogus load average values. Convert it back
to unsigned long to fix this.

Thanks,

	tglx

------------------>
Aruna Ramakrishna (1):
      sched: Change nr_uninterruptible type to unsigned long


 kernel/sched/loadavg.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b856a2..52ca8e268cfc 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta =3D 0;
=20
 	nr_active =3D this_rq->nr_running - adjust;
-	nr_active +=3D (int)this_rq->nr_uninterruptible;
+	nr_active +=3D (long)this_rq->nr_uninterruptible;
=20
 	if (nr_active !=3D this_rq->calc_load_active) {
 		delta =3D nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295..83e3aa917142 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1149,7 +1149,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned int		nr_uninterruptible;
+	unsigned long 		nr_uninterruptible;
=20
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */


