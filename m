Return-Path: <linux-kernel+bounces-870715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2241C0B85E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAA214E921A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306B2200110;
	Mon, 27 Oct 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkM9ai0l"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213991E9906
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524322; cv=none; b=crCNw6ftT0OH4z6eQzWhaYyTfFav6oXOd1iaPIzIN1RAyRpaQQJWHenrLSPHM8FtORtKvszjOZYcEDyite0vy5XaBXTy7aXMMMRk6nA7r2nWaaQ6MJA6M3AJO/hvSpKwpvc4IQ17wUfeau++WR5yBbGQFRy1i/BRzZsBPkHfhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524322; c=relaxed/simple;
	bh=OW9H3G7kCOMhcU87Zcmzqh32zJnsRj6fi7PQv+wQNF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHTgmhHnvElfxmhwz7hJ7SUUoW2EHOmBNmdYuUaH6WeBkwa48KgxLT7phIg59O4MCsLSJskxnJkKO4QYVp4d1jl0xCg1KUZp57NOXtYVK9mFXWqW/L3PlICTGLGWJcxrdZ+oZuCZOQQU0BD0sDjYpl6SKwXoX9bXvKMP4eL4qYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkM9ai0l; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSESnP/sa4r5ORTRPvhvwWnuR1/omMMQhE1G5EL1OGY=;
	b=fkM9ai0lAa8UqXU+xcEiedv2Dy6vnBO1C1mJVEKWzCGSI7MY2MvmP2rwe7J/q8lQ7bFS1i
	P15rgxxVVWTFotoWX/3l9p318D36F0tco8fAr/iJk3R/AOVV+gRzAxdoxIFupdVgbsaAHC
	A1dOckJIKXHLkKV9X2CRN9hLK1hV0bo=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v4 2/8] um: Turn signals_* into thread-local variables
Date: Mon, 27 Oct 2025 08:18:09 +0800
Message-Id: <20251027001815.1666872-3-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Turn signals_enabled, signals_pending and signals_active into
thread-local variables. This enables us to control and track
signals independently on each CPU thread. This is a preparation
for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/irqflags.h   |  4 ++--
 arch/um/include/shared/longjmp.h |  3 +--
 arch/um/include/shared/os.h      |  1 +
 arch/um/kernel/ksyms.c           |  2 +-
 arch/um/os-Linux/signal.c        | 11 ++++++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 1e69ef5bc35e..31e49e0894c5 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -2,7 +2,7 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-extern int signals_enabled;
+int um_get_signals(void);
 int um_set_signals(int enable);
 void block_signals(void);
 void unblock_signals(void);
@@ -10,7 +10,7 @@ void unblock_signals(void);
 #define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
-	return signals_enabled;
+	return um_get_signals();
 }
 
 #define arch_local_irq_restore arch_local_irq_restore
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index 8863319039f3..c53e43d980c8 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -5,7 +5,6 @@
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
-extern int signals_enabled;
 extern int setjmp(jmp_buf);
 extern void longjmp(jmp_buf, int);
 
@@ -15,7 +14,7 @@ extern void longjmp(jmp_buf, int);
 
 #define UML_SETJMP(buf) ({				\
 	int n, enable;					\
-	enable = *(volatile int *)&signals_enabled;	\
+	enable = um_get_signals();			\
 	n = setjmp(*buf);				\
 	if(n != 0)					\
 		um_set_signals_trace(enable);		\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..324d4eed3385 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -243,6 +243,7 @@ extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
 extern void block_signals(void);
 extern void unblock_signals(void);
+extern int um_get_signals(void);
 extern int um_set_signals(int enable);
 extern int um_set_signals_trace(int enable);
 extern void deliver_alarm(void);
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index f2fb77da08cf..96314c31e61c 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -6,8 +6,8 @@
 #include <linux/module.h>
 #include <os.h>
 
+EXPORT_SYMBOL(um_get_signals);
 EXPORT_SYMBOL(um_set_signals);
-EXPORT_SYMBOL(signals_enabled);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 11f07f498270..58da8c6ece98 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -68,12 +68,12 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGCHLD_BIT 2
 #define SIGCHLD_MASK (1 << SIGCHLD_BIT)
 
-int signals_enabled;
+static __thread int signals_enabled;
 #if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 static int signals_blocked, signals_blocked_pending;
 #endif
-static unsigned int signals_pending;
-static unsigned int signals_active = 0;
+static __thread unsigned int signals_pending;
+static __thread unsigned int signals_active;
 
 static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -342,6 +342,11 @@ void unblock_signals(void)
 	}
 }
 
+int um_get_signals(void)
+{
+	return signals_enabled;
+}
+
 int um_set_signals(int enable)
 {
 	int ret;
-- 
2.34.1


