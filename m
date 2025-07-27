Return-Path: <linux-kernel+bounces-747312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB928B13248
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF65F1895508
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CE254AE1;
	Sun, 27 Jul 2025 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASliJ6u+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHh1bvu7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE295250BEC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655886; cv=none; b=H4j0pbO7MqQPZHEhX0eNUVId/iKoGdO1S4NpSPVzqv6VDgUgQ+u3axYKJqSfZ8LQUCmWUktvpnt6WxJA+xDcn8lHRJfmZe5OaXZJtlhRWRyk3FrEQbLsxAsmhy+575MQckQJ4IbDQQXQIHYZ2BCqFRpQkeITxCTbVQW1MPS/UEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655886; c=relaxed/simple;
	bh=T/IIUL96kiLy8AMYm36YLMdb0hzl6dsxxj1pwY6eys4=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=tcC4chqnm4sAuu9zP5Yhi4mUlOYV8cEXr8ZKSStEoNFARR7Bf4wbewyMnnJFxMQC3pw1VL45O1OEfM93cytmmqsfuEAfL5aVHcWR9wdSGtk+Kv/7dssEIFfSEvqJrUoigrS3AG3xZ3WXWSmaTNSCpR6tS5GJZLzqjQKHLOBIYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASliJ6u+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHh1bvu7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753655882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Y8MremY+fJ+HhtN+II7DQPvZxlH/5mDzkk3UusrFDko=;
	b=ASliJ6u+Pzg8BRbs7IA8E+hNgD4Si18poUaHTQC2uMq/TF9kEYgJHvsztmC1vAhRMd/VX/
	HVC3esQyAwXXGhB3o2ICst2bv5Cn6McE+AyQlqY0bg8B22HgtaI2eqIpDVWy48Fw3qu0iD
	nFnGGTPNNP95H4T1cKXJQWBrOYHyga6dt7U4Y7Aj2FcQF4ZP72Yz/SNkd6jb5kFvk/+gui
	NFSh4EI1QleQKw4zUNC9L1bxh2EEzGzyBWkmTE9FEbeV3S2Pq86+Q2iHMCysPQNBTpWQi7
	EKtJQij9BlEFgK+XRj/s3Xkmeaw/cH6WzVh4deyZXsLwrMDXdHtmCX6AkHuxPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753655882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=Y8MremY+fJ+HhtN+II7DQPvZxlH/5mDzkk3UusrFDko=;
	b=CHh1bvu7iu5dYJ40URLiCpFRaRuEkLKaOfc7+EkFXFtVkneAmcs2Sno2eK0A8zSqwBnqkp
	soNQIAgyDNbnvcCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.17-rc1
References: <175365567943.581055.6806236199247802443.tglx@xen13>
Message-ID: <175365569020.581055.14574926495650428382.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 00:38:02 +0200 (CEST)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2025=
-07-27

up to:  bfa788dc2dda: clocksource: Use cpumask_next_wrap() in clocksource_wat=
chdog()

Updates for the timer core:

 - Simplify the logic in the timer migration code

 - Simplify the clocksource code by utilizing the more modern cpumask+*()
   interfaces

Thanks,

	tglx

------------------>
Petr Tesarik (1):
      timers/migration: Clean up the loop in tmigr_quick_check()

Yury Norov [NVIDIA] (2):
      clocksource: Use cpumask_any_but() in clocksource_verify_choose_cpus()
      clocksource: Use cpumask_next_wrap() in clocksource_watchdog()


 kernel/time/clocksource.c     |  8 ++------
 kernel/time/timer_migration.c | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 6a8bc7da9062..e400fe150f9d 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -323,9 +323,7 @@ static void clocksource_verify_choose_cpus(void)
 		return;
=20
 	/* Make sure to select at least one CPU other than the current CPU. */
-	cpu =3D cpumask_first(cpu_online_mask);
-	if (cpu =3D=3D smp_processor_id())
-		cpu =3D cpumask_next(cpu, cpu_online_mask);
+	cpu =3D cpumask_any_but(cpu_online_mask, smp_processor_id());
 	if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids))
 		return;
 	cpumask_set_cpu(cpu, &cpus_chosen);
@@ -589,9 +587,7 @@ static void clocksource_watchdog(struct timer_list *unuse=
d)
 	 * Cycle through CPUs to check if the CPUs stay synchronized
 	 * to each other.
 	 */
-	next_cpu =3D cpumask_next(raw_smp_processor_id(), cpu_online_mask);
-	if (next_cpu >=3D nr_cpu_ids)
-		next_cpu =3D cpumask_first(cpu_online_mask);
+	next_cpu =3D cpumask_next_wrap(raw_smp_processor_id(), cpu_online_mask);
=20
 	/*
 	 * Arm timer if not already pending: could race with concurrent
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2f6330831f08..c0c54dc5314c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1405,23 +1405,20 @@ u64 tmigr_quick_check(u64 nextevt)
 		return KTIME_MAX;
=20
 	do {
-		if (!tmigr_check_lonely(group)) {
+		if (!tmigr_check_lonely(group))
 			return KTIME_MAX;
-		} else {
-			/*
-			 * Since current CPU is active, events may not be sorted
-			 * from bottom to the top because the CPU's event is ignored
-			 * up to the top and its sibling's events not propagated upwards.
-			 * Thus keep track of the lowest observed expiry.
-			 */
-			nextevt =3D min_t(u64, nextevt, READ_ONCE(group->next_expiry));
-			if (!group->parent)
-				return nextevt;
-		}
+
+		/*
+		 * Since current CPU is active, events may not be sorted
+		 * from bottom to the top because the CPU's event is ignored
+		 * up to the top and its sibling's events not propagated upwards.
+		 * Thus keep track of the lowest observed expiry.
+		 */
+		nextevt =3D min_t(u64, nextevt, READ_ONCE(group->next_expiry));
 		group =3D group->parent;
 	} while (group);
=20
-	return KTIME_MAX;
+	return nextevt;
 }
=20
 /*


