Return-Path: <linux-kernel+bounces-653558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5498ABBB22
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6693AEBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096227932E;
	Mon, 19 May 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zDQg9nOP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGy0XyOL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E612277000;
	Mon, 19 May 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650484; cv=none; b=Tm8mO7k3x5assu4kzYs9MpCON+swZNRWdrGhfBaQwoQedycYvzvL9eUBLMvfhDH1AZ/rltCfsLzYs8I5ynnzWsWZfaFZK33rgFeah2O07w62WIKjotTLEQP9MrJS09FGYHgA66cSx2UsIphsfUmzRRUiADHLmYmnRHBf+OFsGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650484; c=relaxed/simple;
	bh=A4EJCMnwn1nvmjlAmIL8RCldwVes+eDt/ZK/Lm5Mnow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqH8tHrr/5aLjBQaa5GVcnSinXdpOIdjkE4yVP/u77lq9JZFETCNBHMx0MhEsnfvp+y+AWZHsfN9Nx1Cm5ij0o7rUqKsdU3StedlTolwx0Zr4+6U7cACPwvVCwuoq/+ggWnIVzZkrUs9a2nQSz2OWQqAQ1vZIEuJW0vuVAxL7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zDQg9nOP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGy0XyOL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwFkxej4QZC7RTlNI207kU5RD71foXihmtUnBoEIdew=;
	b=zDQg9nOPYH4TwsxtZOLIUpOB9ObB0xKrCfYR94kRZDjR8R06nmWIRx1Yq+KQbd+HpTp0xZ
	DMil9hP9PH6Dxktu+PpZYF7BoAAcMJf1N3Dd8JymUtoUE/Po8WAA2tkVOH323yhjv593sC
	W3vwzs/X7Y4wa7W5g4xyt29CnTQboP650Z6saZ/4PO6lNv4G882DJAAJ/tLyuKfzl+NcbL
	K+hh6hddg8qnDxNtU9luZYL/GAQZ4UgX/qzcSirLkNf52ThCIn99Y41IYU//fIpB2BBJA5
	QQu6v5CqlNN2T4IMt4/Z3tsKmOqfzmjBY10F1WU7Ze3Ax+JAvSDDcLFWzuoCdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwFkxej4QZC7RTlNI207kU5RD71foXihmtUnBoEIdew=;
	b=sGy0XyOLyIJmG1TnAiqd8jYX3xU4zazf5KPq63/vgR3gVGvfxmxPJjKF/1Az9/IeSRGX3f
	uilY69snl0/fAlCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v9 16/22] x86/tracing, x86/mm: Move page fault tracepoints to generic
Date: Mon, 19 May 2025 12:27:34 +0200
Message-Id: <b631a2818c9761c2e8c873f1c6898d7ad673599d.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Page fault trace points are interesting for other architectures as well.
Move them to be generic.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/mm/Makefile                                |  2 --
 arch/x86/mm/fault.c                                 |  2 +-
 .../asm/trace =3D> include/trace/events}/exceptions.h | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)
 rename {arch/x86/include/asm/trace =3D> include/trace/events}/exceptions.h=
 (79%)

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5be5a0..629a8bf12219 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -34,8 +34,6 @@ obj-y				+=3D pat/
 CFLAGS_physaddr.o		:=3D -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:=3D -fno-stack-protector
=20
-CFLAGS_fault.o :=3D -I $(src)/../include/asm/trace
-
 obj-$(CONFIG_X86_32)		+=3D pgtable_32.o iomap_32.o
=20
 obj-$(CONFIG_HUGETLB_PAGE)	+=3D hugetlbpage.o
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7e3e51fa1f95..ad4cb1502316 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -38,7 +38,7 @@
 #include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
=20
 #define CREATE_TRACE_POINTS
-#include <asm/trace/exceptions.h>
+#include <trace/events/exceptions.h>
=20
 /*
  * Returns 0 if mmiotrace is disabled, or if the fault is not
diff --git a/arch/x86/include/asm/trace/exceptions.h b/include/trace/events=
/exceptions.h
similarity index 79%
rename from arch/x86/include/asm/trace/exceptions.h
rename to include/trace/events/exceptions.h
index 34bc8214a2d7..a631f8de8917 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/include/trace/events/exceptions.h
@@ -7,7 +7,7 @@
=20
 #include <linux/tracepoint.h>
=20
-DECLARE_EVENT_CLASS(x86_exceptions,
+DECLARE_EVENT_CLASS(exceptions,
=20
 	TP_PROTO(unsigned long address, struct pt_regs *regs,
 		 unsigned long error_code),
@@ -22,7 +22,7 @@ DECLARE_EVENT_CLASS(x86_exceptions,
=20
 	TP_fast_assign(
 		__entry->address =3D address;
-		__entry->ip =3D regs->ip;
+		__entry->ip =3D instruction_pointer(regs);
 		__entry->error_code =3D error_code;
 	),
=20
@@ -30,18 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
=20
-DEFINE_EVENT(x86_exceptions, page_fault_user,
+DEFINE_EVENT(exceptions, page_fault_user,
 	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
 	TP_ARGS(address, regs, error_code));
-
-DEFINE_EVENT(x86_exceptions, page_fault_kernel,
+DEFINE_EVENT(exceptions, page_fault_kernel,
 	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
 	TP_ARGS(address, regs, error_code));
=20
-#undef TRACE_INCLUDE_PATH
-#undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE exceptions
 #endif /*  _TRACE_PAGE_FAULT_H */
=20
 /* This part must be outside protection */
--=20
2.39.5


