Return-Path: <linux-kernel+bounces-815727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB3B56A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F00217D6F9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4052DCF56;
	Sun, 14 Sep 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRBRmLgz"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A752DCBF2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865468; cv=none; b=j0qQWeE0NW/cORNS7idSXFkCx5WRjePI2EXEq/MgRUbCXLHNfgHL1KxmekJIWg/pFTAR96pG3fqHKmd3VuTaiC47RIKI5FMOSDOuNgQ+dDGOWFTEsiBBW+qjMvncecZrRGe4/kmMC32Wp+hOtN4jrt3KBcuf0jTdW6Erigom+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865468; c=relaxed/simple;
	bh=OW9H3G7kCOMhcU87Zcmzqh32zJnsRj6fi7PQv+wQNF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3AOJZn2jfk4pkhRHGrj3yVdMXzX8rPtWpGckV2YQTk0EpPhfkVxE8ztBnvJWUG+TB3Y189QWYkJwfo563uWCRftet4Aq25Ct/hOzZMuAmhyDI4cQRKKRGhGW22w9F29LiKci4m47sjc56SKu2bP4oSbVFa5047Ts7WUfSvHNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRBRmLgz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSESnP/sa4r5ORTRPvhvwWnuR1/omMMQhE1G5EL1OGY=;
	b=eRBRmLgz90KDAPM3nHVnlptGr/DOz3C2oljh5urH05dvikN1YhhfoxdXGJQpTC9wpTutzF
	kAOaaloPs6nb2yJZN3q+Tc0w+5oi9P5+nhVDMQHAsA2m3mBXHWHj2GRDovUPzkGdjqSW0l
	YI/GRjpLLR3rDm6qYCL84dDKvQW7B/8=
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
Subject: [PATCH v3 1/7] um: Turn signals_* into thread-local variables
Date: Sun, 14 Sep 2025 23:56:52 +0800
Message-Id: <20250914155658.1028790-2-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
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


