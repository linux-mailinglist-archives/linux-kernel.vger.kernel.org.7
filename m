Return-Path: <linux-kernel+bounces-806811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E50B49C13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B930D3B8A55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BD2E0B48;
	Mon,  8 Sep 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S8Q7woBX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xo/MneMZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445C31C572
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367134; cv=none; b=EqwnZrNWSiolDOPlxId3QDcTtM2JA6uU85nhDmZMHlNAhuklzDrubPj7lW9Oi9SUWHrJjZe/nW+V34LvanpclJ63m+1rNGpKMuky34VScIARyeH9u10Bg1qGFhNGrQzCYFhI36AFSt1XTdfVEsrQ16dvNwCaXVQF9DiacY4rY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367134; c=relaxed/simple;
	bh=e8g7UdBhqrXKfk2gzjboAafceUj4gAwYFSFlErrzvSc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uFnQ9bMQV2WTRguaCovBpdZnVPdi7Iuj75KeRew8Ga8tmwGkHW4H5zsKTOXe89Bdy6FKbXsXkha081wbWxefHJThNVnxCZMYHnvnI0dpdTRAMV8Hy0URB97SVvkmHC8RKampYib3I3AwUY+kQWn5YpXkkxNUbxLZUD/nbYnNyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S8Q7woBX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xo/MneMZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.673713522@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NSKUyyV86FuSpvpTInpZTwVe/DTQioaMYANjUCDRIuI=;
	b=S8Q7woBXW9Vglh33wNVMoV/clp/ZiOAOA46CnEZhOUxqwHy9fISqP8Kw7aW9z+PzwTGNHu
	TLmUrgb/OkSncq6cazVy4s/S29yVrh2+cLQssmpKV9snx3U4hXX0PMnAOGxhSyfKJReTsY
	E2eEeUfURIa0KsyWu6X0VzzErm5w4okXdD8wol9NdUUh7o1K16jVLVvjDCgiQTF0Q/8Axf
	R37y7Pm2n/DMDLTyAnzURZDEZHQ0iNSDrC67tzPdSs2YkJTlMMzfAHa10UDdUfCVQu2iDW
	9fajEa2yeP8KHSMHrQ+LETmosqtwDKzu2eBZ/PcIfFeXnyl676zRUvedicKIsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NSKUyyV86FuSpvpTInpZTwVe/DTQioaMYANjUCDRIuI=;
	b=Xo/MneMZ0EDaX93bisjqVsODxJ8VBcykuDzFdfD9Ts2OCMGK66MdMZajcwKdS96Ua1q342
	QwOtdw0qNkXyeSDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 22/36] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:10 +0200 (CEST)

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/entry-common.h |    2 +-
 include/linux/rseq_entry.h   |    9 +++++++++
 kernel/rseq.c                |   19 +++++++++++++------
 3 files changed, 23 insertions(+), 7 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -146,7 +146,7 @@ static __always_inline void syscall_exit
 			local_irq_enable();
 	}
 
-	rseq_syscall(regs);
+	rseq_debug_syscall_return(regs);
 
 	/*
 	 * Do one-time syscall specific work. If these work items are
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -286,9 +286,18 @@ static __always_inline void rseq_exit_to
 	ev->events = 0;
 }
 
+void __rseq_debug_syscall_return(struct pt_regs *regs);
+
+static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+{
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		__rseq_debug_syscall_return(regs);
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 
 #endif /* _LINUX_RSEQ_ENTRY_H */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -470,12 +470,7 @@ void __rseq_handle_notify_resume(struct
 	force_sigsegv(sig);
 }
 
-#ifdef CONFIG_DEBUG_RSEQ
-/*
- * Terminate the process if a syscall is issued within a restartable
- * sequence.
- */
-void rseq_syscall(struct pt_regs *regs)
+void __rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 	u64 csaddr;
@@ -493,6 +488,18 @@ void rseq_syscall(struct pt_regs *regs)
 fail:
 	force_sig(SIGSEGV);
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+/*
+ * Kept around to keep GENERIC_ENTRY=n architectures supported.
+ *
+ * Terminate the process if a syscall is issued within a restartable
+ * sequence.
+ */
+void rseq_syscall(struct pt_regs *regs)
+{
+	__rseq_debug_syscall_return(regs);
+}
 #endif
 
 /*




