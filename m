Return-Path: <linux-kernel+bounces-836054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2931BA8A08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE363C0ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAA22C1786;
	Mon, 29 Sep 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E7AF1SVu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MuTV11rY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CA2C11F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138149; cv=none; b=oBOczOzwcpvjQT4Oi/llX1/UrD4oj5MceNJxam8Qdd/dWN6p6OeJsZwbs5sKTgoAEuX96dzkDq6E9AFX+rJxJA+2YygXVslq1Qg7tR2ZMIokuucWHlkCvX7sBAqJ35U2TVz4bQLEJYB+WZRi7liGqLGXLN+pq3CXW3+hFytQtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138149; c=relaxed/simple;
	bh=Jzzh4d7uoV+mKZMhXhm7w3tNgkDSF+irEJ06BS5hU64=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=YM74LsR9DGd958OdaCl/eZvWAg4wwY/9a/aHl8vHFAn5WN7oOncsNQOJzCC0LndWRB4rw/pn46523mktSrIY4Bql3+MKPV1o9lW8H0qbAn04Cyc2HhgPdmApBlJ7wtcGiNKC6KCRiNH0/jyadz5Z1jtWdTU8APPT61/S4JNGJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E7AF1SVu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MuTV11rY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=/hZeaiajUvor1p2Prf31ED5rFlBlwV1iQTSaXJGudOY=;
	b=E7AF1SVuisij7xNwl/ZPIqJvruFXdmueQ9qAApgdxHUmDPtA5zVB/pnONdQs+S4zqZjFMG
	WfdlTRj3DgxfKozXwK0axlfHeFicfBFvfUkuu8Eto3p9orXypxGsi2JGelWDS28rlEnPE3
	i9cTjwOSKOAzLEUm3iU01UfjB3oQ+IM9UCsi2DYOTKpwLTLq/vng7nNqHoezJ8sEhWnItK
	s8+cb95j6y5p2Nb6b6bDH72gMtb+ToEttUl10MIcydN4VWxKGMNkzYaulLi25ZTfwPS+yY
	wHPy4NXUU8ezJJgC09m4MDCUeRPYsU5jR7UlJJuj70uaHRGy2lIUewMYHWhC1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=/hZeaiajUvor1p2Prf31ED5rFlBlwV1iQTSaXJGudOY=;
	b=MuTV11rYBLqpe93kHFoD07BHkG3R1q9Y2rvbzKEUm8S10SCOcsH9UszI8pU4LGNL7AL1+U
	pk1qTA1z5fnXKSDA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913808486.495041.3091230048959079390.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:04 +0200 (CEST)

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2025-09=
-29

up to:  ccf09357ffef: smp: Fix up and expand the smp_call_function_many() ker=
neldoc

An update of the stale smp_call_function_many() documentation to bring it
back in sync with the actual implementation.

Thanks,

	tglx

------------------>
Rafael J. Wysocki (1):
      smp: Fix up and expand the smp_call_function_many() kerneldoc


 kernel/smp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 56f83aa58ec8..02f52291fae4 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -884,16 +884,15 @@ static void smp_call_function_many_cond(const struct cp=
umask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
+ *
+ * @func is not called on the local CPU even if @mask contains it.  Consider
+ * using on_each_cpu_cond_mask() instead if this is not desirable.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)


