Return-Path: <linux-kernel+bounces-643969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE21AB353A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123863ACD5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE71268C79;
	Mon, 12 May 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjervMdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="biz04SSn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171A267AED;
	Mon, 12 May 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047079; cv=none; b=cAcbYlUf/xbLXbBf+XYuGTCqPjJ7Kxj7HPlA2umRYOH3B1kTqRSQkH1tq+8C9ebtKdFnrnWjlLaG8G6u03GVzk2bs+NTMctJY8knp9QVpTigp5r9EtASRLliNe/wkf3ASru0010GyNLFOX3TS+yVvclMusNkrSnA8WBv/rU8sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047079; c=relaxed/simple;
	bh=qJDv1BXN5yWZ5K4l43v0Q0Y/hBlA52rY2AeOAgH0sp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cvle1q8JENNduP7ebV3oiqzxjacocMWFU60bYShQ6qd5OTaofBFREAQIJOJ7UfnMOSY8+fH79rhgzyKV5Ou4ubpaapU0Ozyf1ExsnTlsyKEfx03vjk8+Ew6cUBBY5ahuuIv+vTS7VecVSlkOIQuqD8ZIFqOb3KZlqX8b424FQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjervMdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=biz04SSn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6cG4CYhJME6IWrbowQEwUqJrs4mnBUYPJ+5/yQExiE=;
	b=RjervMdBpoxjyYNjSSl16DBV9uMfNzNh8eJpgV3ZKuOGkJ8af89zhC1AkQaDy/JFo+lfo1
	q/TAFMXxUL5pMY12iYM1UVYjIh4t8mpFFDmswo0s/PuUYNWUzMWopXda4cBH/12SSGrjIi
	CruljjEkFQR0+WmMrWowPtlxiQApcjleORTwXfKt9ooEHJdod474KobKYbiV6roozerfxf
	weGS0vQyC8NauPng5R9FmoyaFDBC2P39hcexCEH3cod8ggIa9dqarhySt2cBpljJdqaIjt
	Gj0EmU+vbChf+5qMB6aiMnAxTFcyKHoguWKc98hvQtHjWNfaAuyR/TMH1VowAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6cG4CYhJME6IWrbowQEwUqJrs4mnBUYPJ+5/yQExiE=;
	b=biz04SSnyr5sWhnLuUC3AM1xM86CJ1LhTt7k0T239UA+vzcBTsuz8wSRdHAW4LCNGNjtr3
	ZKYtnjNzAqZoJBAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v8 03/22] panic: Add vpanic()
Date: Mon, 12 May 2025 12:50:46 +0200
Message-Id: <c4afd38c4821e90d6a2a0bed4d49b36d7a390019.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vpanic() is useful for implementing runtime verification reactors. Add it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/panic.h |  3 +++
 kernel/panic.c        | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 2494d51707ef..bcca63a02aef 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -3,6 +3,7 @@
 #define _LINUX_PANIC_H
=20
 #include <linux/compiler_attributes.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
=20
 struct pt_regs;
@@ -10,6 +11,8 @@ struct pt_regs;
 extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
+__printf(1, 0)
+void vpanic(const char *fmt, va_list args) __noreturn __cold;
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index a3889f38153d..278eae74bf17 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -277,17 +277,17 @@ static void panic_other_cpus_shutdown(bool crash_kexe=
c)
 }
=20
 /**
- *	panic - halt the system
+ *	vpanic - halt the system
  *	@fmt: The text string to print
+ *	@args: Arguments for the format string
  *
  *	Display a message, then perform cleanups.
  *
  *	This function never returns.
  */
-void panic(const char *fmt, ...)
+void vpanic(const char *fmt, va_list args)
 {
 	static char buf[1024];
-	va_list args;
 	long i, i_next =3D 0, len;
 	int state =3D 0;
 	int old_cpu, this_cpu;
@@ -338,9 +338,7 @@ void panic(const char *fmt, ...)
=20
 	console_verbose();
 	bust_spinlocks(1);
-	va_start(args, fmt);
 	len =3D vscnprintf(buf, sizeof(buf), fmt, args);
-	va_end(args);
=20
 	if (len && buf[len - 1] =3D=3D '\n')
 		buf[len - 1] =3D '\0';
@@ -477,7 +475,17 @@ void panic(const char *fmt, ...)
 		mdelay(PANIC_TIMER_STEP);
 	}
 }
+EXPORT_SYMBOL(vpanic);
=20
+/* Identical to vpanic(), except it takes variadic arguments instead of va=
_list */
+void panic(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vpanic(fmt, args);
+	va_end(args);
+}
 EXPORT_SYMBOL(panic);
=20
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
--=20
2.39.5


