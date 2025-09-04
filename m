Return-Path: <linux-kernel+bounces-801767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E16B44995
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EB016E3CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB475346A14;
	Thu,  4 Sep 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oT6mI6dM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+RhOkcJw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016334A33E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024497; cv=none; b=KdLtt2LY9MyY0XwqguKctM8gNQaWWbgfKHq7D1zyRh5ep8cjIy50V7I63VecAopIFTW7wDaStbBfMhZHzcwgav93gzx2xEP7+wxoDvRNzg4WS7lEGbeZlQiQBcAnbOCv4BvBREg7QhslAOsTnWI2teqDuWexzb/Pp0NJZJE/Ri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024497; c=relaxed/simple;
	bh=idnemD5Smqj2fqgK3kd8RGUZA0i77cquvlbmg+aJvuc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Knt/VOb3eR9rbmz73uEg2x8ew6owaPEy73O/5SVNznYu8W94vb3du2j8RJMcxN7HliypdNmiDnT6wcDSkhMcI6t+NW5GDZOaOv2a0+CRsoBuxVIFu8dI9Mg+wJmy/b5vxUzg/mAPgoS0nJnh/aae3XvuC3iH3r8cHCxA/FlXo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oT6mI6dM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+RhOkcJw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.103436339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KQeoIGYfqggUnusPasXjuw542cxf4ZnWphmxh0+lZYc=;
	b=oT6mI6dMvnkiiv3YPcGalNfSiXfE2znYV8q3lP973fC+QglhlQ69PYjcjGrwxXFJmZeRpA
	N2Bza+nBq2Y+pJSjVpPCwyUOexPNf+lM4IRIyY7/6uvqCtFmE76B3zfvX3/YFmZovLHPVy
	/Mzfu7EgBEOWyK8uCseEwLcUG1UAsREJuQ3a8G6btA24a9TdIYnZEuTsRDmfSKoVnmtbpA
	ZLHqmBA8WV6Lya2foYPX+rVzOwHOW66VKt7z1+X7Tm7HhGQdWEhhEmvoRoAQOggH0QG86J
	OZzre6gRz87I9JDJ32rDu8Pd5syTUm8Lnjc8YluLAPIwx6LgDyk7Wecc/snzqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=KQeoIGYfqggUnusPasXjuw542cxf4ZnWphmxh0+lZYc=;
	b=+RhOkcJwCQZykp4Wd5paJCLdtmvpUNHkThmLlmvcevwbXAZUWGd7/T4PX9ay0PcpyCwHTj
	jUQdR9P1tWiaVvBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V3 31/37] asm-generic: Provide generic TIF infrastructure
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:32 +0200 (CEST)

Common TIF bits do not have to be defined by every architecture. They can
be defined in a generic header.

That allows adding generic TIF bits without chasing a gazillion of
architecture headers, which is again a unjustified burden on anyone who
works on generic infrastructure as it always needs a boat load of work to
keep existing architecture code working when adding new stuff.

While it is not as horrible as the ignorance of the generic entry
infrastructure, it is a welcome mechanism to make architecture people
rethink their approach of just leaching generic improvements into
architecture code and thereby making it accumulatingly harder to maintain
and improve generic code. It's about time that this changes.

Provide the infrastructure and split the TIF space in half, 16 generic and
16 architecture specific bits.

This could probably be extended by TIF_SINGLESTEP and BLOCKSTEP, but those
are only used in architecture specific code. So leave them alone for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

---
 arch/Kconfig                          |    4 ++
 include/asm-generic/thread_info_tif.h |   48 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1730,6 +1730,10 @@ config ARCH_VMLINUX_NEEDS_RELOCS
 	  relocations preserved. This is used by some architectures to
 	  construct bespoke relocation tables for KASLR.
 
+# Select if architecture uses the common generic TIF bits
+config HAVE_GENERIC_TIF_BITS
+       bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
--- /dev/null
+++ b/include/asm-generic/thread_info_tif.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_THREAD_INFO_TIF_H_
+#define _ASM_GENERIC_THREAD_INFO_TIF_H_
+
+#include <vdso/bits.h>
+
+/* Bits 16-31 are reserved for architecture specific purposes */
+
+#define TIF_NOTIFY_RESUME	0	// callback before returning to user
+#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
+
+#define TIF_SIGPENDING		1	// signal pending
+#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
+
+#define TIF_NOTIFY_SIGNAL	2	// signal notifications exist
+#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
+
+#define TIF_MEMDIE		3	// is terminating due to OOM killer
+#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
+
+#define TIF_NEED_RESCHED	4	// rescheduling necessary
+#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
+
+#ifdef HAVE_TIF_NEED_RESCHED_LAZY
+# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
+# define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
+#endif
+
+#ifdef HAVE_TIF_POLLING_NRFLAG
+# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
+# define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
+#endif
+
+#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
+#define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
+
+#define TIF_UPROBE		8	// breakpointed or singlestepping
+#define _TIF_UPROBE		BIT(TIF_UPROBE)
+
+#define TIF_PATCH_PENDING	9	// pending live patching update
+#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
+
+#ifdef HAVE_TIF_RESTORE_SIGMASK
+# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
+# define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
+#endif
+
+#endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */


