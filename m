Return-Path: <linux-kernel+bounces-720743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DAAFBFED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3EA4A6F92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F71239594;
	Tue,  8 Jul 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrWmDdTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EE220F24;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937840; cv=none; b=SBhcbbCJNL6i6HSD6KHXYRhiZLcdV5V80sGv1PLw0PmE7Ebrj6K4JPNOIGsodIXaHWZ9XzKjVr38tmvkvUKgQOJvbVdFpzUt3igde1AGw4zrhsSkEPLabE2jW71Fo0hvP94fkfTOW6sqpcz3G58cEkB6eyfaDLw/ykMD2wyHFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937840; c=relaxed/simple;
	bh=q9368biQbKFkdqwUJGMNR4U7z4DEcx2lmBxRY3YPNYQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TRzUJ5syFxmYz7pfb/oYfJLA0nhcKJb+UIfCU8I+u+YjyMvpYfrszDP8uBdCPvtg5QxTus5X+gyOsLJ9DEMLFfqMAS9ffxhsDnX7ZdZ5z3wgDH1K1W5oZJmdjf0yiR8He5z5ZYD+MGMTpv+JLVXjMyYLXr1P2224M5XbBM5jQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrWmDdTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D74C4CEF4;
	Tue,  8 Jul 2025 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751937839;
	bh=q9368biQbKFkdqwUJGMNR4U7z4DEcx2lmBxRY3YPNYQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=RrWmDdTdfrCR/QR7S1cFvpBywbUn+9TgIi+j7JfOTMojWG99WrGBMxhw0ZwEtPN8b
	 Z4pTIPhJxGhY9UhwUCsO7GavdwJVt4xbIsyvKJQSSaWQVDlYn6GoXicKIcVkBO2Cbx
	 5U9pnOwMp6RnRKi7FDUV0mqCjqdXADZ6adLUSxWqYc38d6X0tefQYiV8y3PgXBdm8l
	 QJafTD0Xmh/hSOAjXG/4DuojtsuOeLYiQpvzPrvIjzqb4iEcUb1r0TrJXEpuknQBm+
	 lSxEussR+H2ZhLbdYDCJM+SB8mqBot7pxjDNGINtvpd5gFK2SJG7jSfXkTyxsFKhuq
	 hplvDN8jDzx9w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYx3w-00000000BvS-00qE;
	Mon, 07 Jul 2025 21:24:00 -0400
Message-ID: <20250708012359.853818537@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 21:22:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 13/14] unwind_user/x86: Enable frame pointer unwinding on x86
References: <20250708012239.268642741@kernel.org>
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
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 11 +++++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..5862433c81e1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,6 +302,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
new file mode 100644
index 000000000000..8597857bf896
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_UNWIND_USER_H
+#define _ASM_X86_UNWIND_USER_H
+
+#define ARCH_INIT_USER_FP_FRAME							\
+	.cfa_off	= (s32)sizeof(long) *  2,				\
+	.ra_off		= (s32)sizeof(long) * -1,				\
+	.fp_off		= (s32)sizeof(long) * -2,				\
+	.use_fp		= true,
+
+#endif /* _ASM_X86_UNWIND_USER_H */
-- 
2.47.2



