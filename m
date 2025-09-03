Return-Path: <linux-kernel+bounces-798241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5BB41B08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D4C1899431
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1F277CA4;
	Wed,  3 Sep 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WwU6NwPX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WwU6NwPX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96A2DAFB0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893870; cv=none; b=cBti0uDV0Nl0AyzoLihFmg9rMO9sE/Bc9OcMEd2YRglw7q54GeTG5U4v5T460JwX79Ka5kofJB/er6deM6duT02vVN2kioW0fi2mPixzis115qvz+mfEcGrAsnvY2ftFmUV2gK9JSbUpIVe5uEIe6AOGskZXSs8/kjZGQ1atRbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893870; c=relaxed/simple;
	bh=ZL8Xi+kOXTtPn8QwdiGgDgKsdF1yNtO8Uu26fcqKlUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpzNMQ0yy2SAXugQ/Ttmsma4RZg5hYby2++QiSjDgw6ugPRvyZqJs2BjalJ+tZXa8Uaqh7W3GZktDiX/VlKnaxSVHmtJ/PynB5t8llLp5CordxV9GHw1KdBd0+HworLT1MyLYobyOWz3U2lcpI0Gm2oU+QS1zwa9gxFExX3DCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WwU6NwPX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WwU6NwPX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::12bd])
	by smtp-out2.suse.de (Postfix) with ESMTP id 202E31F456;
	Wed,  3 Sep 2025 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756893866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gihWC4HK9+f2rzVQ0Oi9hOnorwW/l6eP52gOtYB8VpQ=;
	b=WwU6NwPXaOVvrhxVTy/krh5R+ozaBvc6I8xIBd0ICZRe9t5HDUfVV6+XXb4ThZJpU05wbs
	KIauAV3QgpkY9R/oeQEU3Qlc0Q7gutZCtkdqgHstfQPqMfRRQvi1PHEHC3YX0+fFQCf83K
	YmqQ09HOu1JKakt/K2MnFQzZZSKZQxA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WwU6NwPX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756893866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gihWC4HK9+f2rzVQ0Oi9hOnorwW/l6eP52gOtYB8VpQ=;
	b=WwU6NwPXaOVvrhxVTy/krh5R+ozaBvc6I8xIBd0ICZRe9t5HDUfVV6+XXb4ThZJpU05wbs
	KIauAV3QgpkY9R/oeQEU3Qlc0Q7gutZCtkdqgHstfQPqMfRRQvi1PHEHC3YX0+fFQCf83K
	YmqQ09HOu1JKakt/K2MnFQzZZSKZQxA=
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] panic: Remove redundant panic-cpu backtrace
Date: Wed,  3 Sep 2025 12:04:18 +0200
Message-ID: <20250903100418.410026-1-pmladek@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.71 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	NEURAL_SPAM_SHORT(2.99)[0.996];
	BAYES_HAM(-2.97)[99.86%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[pathway.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[pathway.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DIRECT_TO_MX(0.00)[git-send-email 2.50.1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[]
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 202E31F456
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.71
X-Spam: Yes

From: Sergey Senozhatsky <senozhatsky@chromium.org>

Backtraces from all CPUs are printed during panic() when
SYS_INFO_ALL_CPU_BT is set. It shows the backtrace for
the panic-CPU even when it has already been explicitly
printed before.

Do not change the legacy code which prints the backtrace
in various context, for example, as part of Oops report,
right after panic message. It will always be visible in
the crash dump.

Instead, remember when the backtrace was printed, and skip
it when dumping the optional backtraces on all CPUs.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://lore.kernel.org/r/20250731030314.3818040-1-senozhatsky@chromium.org
[pmladek@suse.com: Handle situations when the backtrace was not printed for the panic CPU.]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Hi,

I resend my proposal [1] as a proper patch.

Changes against v1:

  - Handle situations when the backtrace was not printed for
    the panic CPU.

[1] https://lore.kernel.org/all/aJs7p_UjPIfb_XYd@pathway/

kernel/panic.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..e3cec9bc05ef 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -67,6 +67,7 @@ static unsigned int warn_limit __read_mostly;
 static bool panic_console_replay;
 
 bool panic_triggering_all_cpu_backtrace;
+bool panic_this_cpu_backtrace_printed;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -328,6 +329,19 @@ void check_panic_on_warn(const char *origin)
 		      origin, limit);
 }
 
+static void panic_trigger_all_cpu_backtrace(void)
+{
+	/* Temporary allow non-panic CPUs to write their backtraces. */
+	panic_triggering_all_cpu_backtrace = true;
+
+	if (panic_this_cpu_backtrace_printed)
+		trigger_allbutcpu_cpu_backtrace(raw_smp_processor_id());
+	else
+		trigger_all_cpu_backtrace();
+
+	panic_triggering_all_cpu_backtrace = false;
+}
+
 /*
  * Helper that triggers the NMI backtrace (if set in panic_print)
  * and then performs the secondary CPUs shutdown - we cannot have
@@ -335,12 +349,8 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_CPU_BT) {
-		/* Temporary allow non-panic CPUs to write their backtraces. */
-		panic_triggering_all_cpu_backtrace = true;
-		trigger_all_cpu_backtrace();
-		panic_triggering_all_cpu_backtrace = false;
-	}
+	if (panic_print & SYS_INFO_ALL_CPU_BT)
+		panic_trigger_all_cpu_backtrace();
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
@@ -422,13 +432,15 @@ void vpanic(const char *fmt, va_list args)
 		buf[len - 1] = '\0';
 
 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
-#ifdef CONFIG_DEBUG_BUGVERBOSE
 	/*
 	 * Avoid nested stack-dumping if a panic occurs during oops processing
 	 */
-	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
+	if (test_taint(TAINT_DIE) || oops_in_progress > 1) {
+		panic_this_cpu_backtrace_printed = true;
+	} else if (IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) {
 		dump_stack();
-#endif
+		panic_this_cpu_backtrace_printed = true;
+	}
 
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all
-- 
2.50.1


