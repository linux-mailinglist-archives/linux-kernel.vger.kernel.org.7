Return-Path: <linux-kernel+bounces-865009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA8BFC089
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62136625AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107053491EB;
	Wed, 22 Oct 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/zASjt2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fBCefB5b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CD8348898
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137734; cv=none; b=ZsmEzQioiZdhKFLYbfjBHFqKRJ5/UOE4U9ct1Adk8bkxz9Ru3wzB8GEYv8tgYSpaqHd8oygTriAgNhHSAkWA9DhwbRP1ZPKezLmQgYRYrtgxGxKTPcQx+vGsSC0oQPuXi0qDHmPrgsAv8WlzuPfMXmqVQqP3VESfXYYFygIvwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137734; c=relaxed/simple;
	bh=qzcYv3Fx0pUG5kkasfl8Z10bwB0vkmf5ZryCYVPmIPI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Sh9hjgKVRHmSSAcNm2UUr1dxSkFzuxv8pIJXcTyjuXSHTgoCb9KL44BcENJFaVriy6vx6f+51fbF9Gc3OPd9CknozrG0/6dYw+rTO0MFkABcp/YWdWvr/XFa2fpOHhmxvbuWDc7SxB7LxwhTLyKny3ETHsTptQ72MDtFZQrcBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/zASjt2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fBCefB5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.967170782@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wONNCeIqy4BcniWfIGuVA9uUPJUNPBq8TskX/3SruDw=;
	b=u/zASjt2Ltb/wjtQStWrr2lIfv5hEYtesPfglOHDMS2yntdZLOhA51g7jVszPqgGj4YuYa
	b8r6d4xzg6Q7jjbO+Lie/b7cbiGmp4zKtMJrSjywLGdx1VvNUgO0qkM/y2HWjjnjmz21Ul
	9FYo3rPo2iqRRt6pcKSP1aMhne7YkV3fnw0RWV6+B323JRSzQytvfEc5IoeJTSvgjzN18y
	OpMdwLM+0mMOrILaPW3vcCnleJY7a14eQYp3FOxFx2DDlz0TGboJ6261S3EIt9VTS1z4Ht
	DO9ehdhqh/UQRsgzZqDO1pMTWBS5bAO4/RvYNYviQYtBM+mtVTYQBTctvQq2dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wONNCeIqy4BcniWfIGuVA9uUPJUNPBq8TskX/3SruDw=;
	b=fBCefB5bCiUnabfB4p2T/A+ZK0Fa+w7xipFMNkgUFv4CiYIqsdLk4CEF27ddJna9/WSJ3a
	SB3WGoxIKVZMCxCQ==
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
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 09/20] cpumask: Cache num_possible_cpus()
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:30 +0200 (CEST)

Reevaluating num_possible_cpus() over and over does not make sense. That
becomes a constant after init as cpu_possible_mask is marked ro_after_init.

Cache the value during initialization and provide that for consumption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yury Norov <yury.norov@gmail.com>
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


