Return-Path: <linux-kernel+bounces-876118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C4C1A94B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F04B359657
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E351347BD6;
	Wed, 29 Oct 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8ewNkJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcGrN1Ed"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7A345733
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743356; cv=none; b=BK8Afe9fMPdbIDq7IsAzcUkmMoN6apEU1l6XuWOp3y94VRssoiM62CeCEfw+kDPCuliHjIUbDtaZeTNtUErIL6vVBf82ZYKAPS/z6u9CH2BCuB8sAy5IyDCzquBSk2Ol9eIES02l7dSg4M2C7mRTCDoW1kDOq+/1F2H6iIz+0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743356; c=relaxed/simple;
	bh=zTGPWweK73AU41i88jsUzIZ9nLv6IzSuopRSgYIM/lg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ITmmUO8mHKFQfNK/khYWrIT4MlOCnObka2c65ik2wiH2+7wEb0h7LDrmMaojU4YSB7zLFYOrUqPImGW/iLKPDZ1lvvgWZEiZO7Mw/M3GCtDdeCbQ2sMA99+o3dylgXeVuSTjlG58ZqBUC1v5cqNS9KlBwS0WcBbfJoAVPyCDj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8ewNkJo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcGrN1Ed; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.846126176@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=//MYkp6W10wSvC2KsqJBKOJnN0+hXB2bifiEHMUus8E=;
	b=S8ewNkJoDYa7S1IfqtZFIBbf0Ejelewkcll1Kg38hsgsdIUa+InYVKiFpCLsHkcKjBEhOC
	6KWnUGSFyHHFWX+SUpCY7NTuJg7sr23lmV1QOIdZyqlB4B/uBkosBzkqMHa1J27ug6OO7r
	xbm9sOl3Lm+WA/9rYlzPokAFI4PWinSvq4wIG4mDtPDSpEX58XweOuRVug+hfkG/P79smO
	fT8JouGqkPXwrWc6GxeF2ryCgEWhJMv6igM+Yf0Ay61Jpsf9lhXujohY0TTXMXT6lRqHQR
	Ff9bUUkWhQ5DAzqN2eeaMKxZ7+N3swoQ/CNrnhqrTKte/AG4AUDgexFR+zmWAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=//MYkp6W10wSvC2KsqJBKOJnN0+hXB2bifiEHMUus8E=;
	b=CcGrN1EdfiJKm273BA3k6U8nIX/97gEZhvvBQ1+1HQJNZCqDvmUC4TRGyanM8roCsJnttN
	nffZT2I0ttgHxkCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 09/20] cpumask: Cache num_possible_cpus()
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:10 +0100 (CET)

Reevaluating num_possible_cpus() over and over does not make sense. That
becomes a constant after init as cpu_possible_mask is marked ro_after_init.

Cache the value during initialization and provide that for consumption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
V2: New patch
---
 include/linux/cpumask.h |   10 ++++++++--
 kernel/cpu.c            |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -126,6 +126,7 @@ extern struct cpumask __cpu_dying_mask;
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
 
 extern atomic_t __num_online_cpus;
+extern unsigned int __num_possible_cpus;
 
 extern cpumask_t cpus_booted_once_mask;
 
@@ -1152,13 +1153,13 @@ void init_cpu_possible(const struct cpum
 #define __assign_cpu(cpu, mask, val)	\
 	__assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
 
-#define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
 #define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
 #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
 #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
 #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
 
 void set_cpu_online(unsigned int cpu, bool online);
+void set_cpu_possible(unsigned int cpu, bool possible);
 
 /**
  * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
@@ -1211,7 +1212,12 @@ static __always_inline unsigned int num_
 {
 	return raw_atomic_read(&__num_online_cpus);
 }
-#define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+
+static __always_inline unsigned int num_possible_cpus(void)
+{
+	return __num_possible_cpus;
+}
+
 #define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3108,6 +3108,9 @@ EXPORT_SYMBOL(__cpu_dying_mask);
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
+unsigned int __num_possible_cpus __ro_after_init = NR_CPUS;
+EXPORT_SYMBOL(__num_possible_cpus);
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -3116,6 +3119,7 @@ void init_cpu_present(const struct cpuma
 void init_cpu_possible(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_possible_mask, src);
+	__num_possible_cpus = cpumask_weight(&__cpu_possible_mask);
 }
 
 void set_cpu_online(unsigned int cpu, bool online)
@@ -3139,6 +3143,17 @@ void set_cpu_online(unsigned int cpu, bo
 	}
 }
 
+void set_cpu_possible(unsigned int cpu, bool possible)
+{
+	if (possible) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_possible_mask))
+			__num_possible_cpus++;
+	} else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_possible_mask))
+			__num_possible_cpus--;
+	}
+}
+
 /*
  * Activate the first processor.
  */


