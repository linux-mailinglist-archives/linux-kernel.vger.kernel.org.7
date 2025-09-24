Return-Path: <linux-kernel+bounces-830101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A0B98BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D13C2A4C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5E286D7C;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="linmzOvp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F782820BF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=Z8mIC6LNa320T6qNMmKPHyRDI98grELsFayBMU1Z3M6GyXw/QTr8FClzPNhzlxTKEaGNsfPnZd6FybxKsMD9D79Nhzl7cmcG0AzeZCETUguLaS5tYiWGwVgxalKd7+8Pc8bcxHkqTg6T+3NDLV+UHdR9oHTUJ/HvPXnDAhnkJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=mMYz/jRaxEwW2AvWbm0WouE6h6lhAUYSUz3rEKpsCR8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gK+TfWeDZ4mKMbcqZz1XF6aczXgnrbIMvLxEe5suEi4bSChOtbmW4vgorObZJgdg2GkoC9yFmk9nwyybfZOzc1zETPEOTfBDnM2iLJ6sNbVZ8noGSO6to0tdXrOc3e18fE5vYofHNOqyUtrPoPqnTFF9Mwp+bkLStKxyzamOLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=linmzOvp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=aAwEGCLjQRMZ+6UxkwaJXWq/gpjUiVoYTtJddsNEc+s=; b=linmzOvpJioo68Z0V2+XBSGj9v
	ixp+ZHp0JrEpxlRZyvlG6M/iXLML32hwKWFY0Lup4Y4tabNj7yi67hYyfHGTcB5w77asvu9WQX2Gx
	xBVfcsa1oeT5me0BlxmSkT/rXE2hVJ70y40KAYP3jiWM4zyO992D+ffUqsomIUXEBJ4jIEt1hXmu0
	aI9zJjMR1c+jLlLddomzlm8wczwijqf+UBbIDjUOJ1vQCWyEpYU4r0VJbUsGzxyIyaSA1LF3lQwVP
	2AG3pUbpFhI74xHTB7JZMMCv9WUPkVdklI5xHD3RQDWgA3dYDcf6b3ZH0vZ6dajzI6r3bkkk2CimZ
	YohumDzg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEM-2YeO;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3268430301A; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.736377571@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 10:00:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 12/12] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
unwind_user interfaces can be used.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/ptrace.h      |    9 +++++++++
 arch/x86/include/asm/unwind_user.h |   11 +++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -297,6 +297,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -255,6 +255,15 @@ static inline bool any_64bit_mode(struct
 #endif
 }
 
+static inline bool compat_user_mode(struct pt_regs *regs)
+{
+#ifdef CONFIG_X86_64
+	return !user_64bit_mode(regs);
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_X86_64
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME				\
+	.cfa_off	=  2,				\
+	.ra_off		= -1,				\
+	.fp_off		= -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */



