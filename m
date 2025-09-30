Return-Path: <linux-kernel+bounces-837231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7532BABBF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32113ACFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E032BEFE5;
	Tue, 30 Sep 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k6pVVKk7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k6pVVKk7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7D2BF009
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215900; cv=none; b=EPBVvkRANy1KlWjHhe4ohyw7t9E6/btcd07QPHyWYbqZ2S9AZ9uewbLvdPeOAZ7KnB++zIsxRV/1KSHXqqROIW1DTaaJXzpYtv+vDh2HacD3qqOySPQhqdUZ5J/3mnx4CDFnFjCa7LjYNUPXYLKt3SoyzRnzZs+Vi3ocmhEH+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215900; c=relaxed/simple;
	bh=TcE/NhZ1eGRmnpo5YUdRpOEqLBtad3z7/J5atrh1vjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYFONiF3Xn/luE62/VQHFOTGXCP3tXUPsWBvb4IfoTjN1xURi0qfPqYBY/fwSYIe5nn+eggcwCPrTM55ab+jR+uuAJ9Np+9eovcC690ENQZH6J2R4kv0Aydy4JQq+LNwch8yBMwjXraT7IniBanapTBQvMs3tjE9ZcZKa5nHt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k6pVVKk7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k6pVVKk7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1760B1F83B;
	Tue, 30 Sep 2025 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1LVuMgazC1Onbf9ADrNmOc+JVVm6iLogAHDZnTOsKc=;
	b=k6pVVKk7WIN4jlPSAapwAePey/L92clCe9nPEWdsS3bHebHHHnm6I+q+PURusNJ+X3g71/
	HuclRLExL0WoQsfik7GxLbNVfpCruPD6m4sL7ybtbBCUO9IY9v28tCTLupKwBAoh63iJd9
	kJWhMb4+ffGbCa/RDo7q1VJnTD05Sds=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1LVuMgazC1Onbf9ADrNmOc+JVVm6iLogAHDZnTOsKc=;
	b=k6pVVKk7WIN4jlPSAapwAePey/L92clCe9nPEWdsS3bHebHHHnm6I+q+PURusNJ+X3g71/
	HuclRLExL0WoQsfik7GxLbNVfpCruPD6m4sL7ybtbBCUO9IY9v28tCTLupKwBAoh63iJd9
	kJWhMb4+ffGbCa/RDo7q1VJnTD05Sds=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E35313A3F;
	Tue, 30 Sep 2025 07:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VvYXJRSB22jPRwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Sep 2025 07:04:52 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	llvm@lists.linux.dev
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v2 09/12] x86/msr: Use the alternatives mechanism for WRMSR
Date: Tue, 30 Sep 2025 09:03:53 +0200
Message-ID: <20250930070356.30695-10-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930070356.30695-1-jgross@suse.com>
References: <20250930070356.30695-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,suse.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,gmail.com,google.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

When available use one of the non-serializing WRMSR variants (WRMSRNS
with or without an immediate operand specifying the MSR register) in
__wrmsrq().

For the safe/unsafe variants make __wrmsrq() to be a common base
function instead of duplicating the ALTERNATIVE*() macros. This
requires to let native_wrmsr() use native_wrmsrq() instead of
__wrmsrq(). While changing this, convert native_wrmsr() into an inline
function.

Replace the only call of wsrmsrns() with the now equivalent call to
native_wrmsrq() and remove wsrmsrns().

The paravirt case will be handled later.

Originally-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch, partially taken from "[RFC PATCH v2 21/34] x86/msr: Utilize
  the alternatives mechanism to write MSR" by Xin Li.
---
 arch/x86/include/asm/fred.h |   2 +-
 arch/x86/include/asm/msr.h  | 144 +++++++++++++++++++++++++++---------
 2 files changed, 110 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 12b34d5b2953..8ae4429e5401 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -101,7 +101,7 @@ static __always_inline void fred_update_rsp0(void)
 	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
 
 	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) != rsp0)) {
-		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
+		native_wrmsrq(MSR_IA32_FRED_RSP0, rsp0);
 		__this_cpu_write(fred_rsp0, rsp0);
 	}
 }
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index cf5205300266..19ed780c2a09 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -7,11 +7,11 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
-#include <asm/errno.h>
 #include <asm/cpumask.h>
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/percpu.h>
 
@@ -56,6 +56,36 @@ static inline void do_trace_read_msr(u32 msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 #endif
 
+/* The GNU Assembler (Gas) with Binutils 2.40 adds WRMSRNS support */
+#if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24000
+#define ASM_WRMSRNS		"wrmsrns"
+#else
+#define ASM_WRMSRNS		_ASM_BYTES(0x0f,0x01,0xc6)
+#endif
+
+/* The GNU Assembler (Gas) with Binutils 2.41 adds the .insn directive support */
+#if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24100
+#define ASM_WRMSRNS_IMM			\
+	" .insn VEX.128.F3.M7.W0 0xf6 /0, %[val], %[msr]%{:u32}\n\t"
+#else
+/*
+ * Note, clang also doesn't support the .insn directive.
+ *
+ * The register operand is encoded as %rax because all uses of the immediate
+ * form MSR access instructions reference %rax as the register operand.
+ */
+#define ASM_WRMSRNS_IMM			\
+	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
+#endif
+
+#define PREPARE_RDX_FOR_WRMSR		\
+	"mov %%rax, %%rdx\n\t"		\
+	"shr $0x20, %%rdx\n\t"
+
+#define PREPARE_RCX_RDX_FOR_WRMSR	\
+	"mov %[msr], %%ecx\n\t"		\
+	PREPARE_RDX_FOR_WRMSR
+
 /*
  * Called only from an MSR fault handler, the instruction pointer points to
  * the MSR access instruction that caused the fault.
@@ -93,12 +123,76 @@ static __always_inline u64 __rdmsr(u32 msr)
 	return EAX_EDX_VAL(val, low, high);
 }
 
-static __always_inline void __wrmsrq(u32 msr, u64 val)
+static __always_inline bool __wrmsrq_variable(u32 msr, u64 val, int type)
 {
-	asm volatile("1: wrmsr\n"
-		     "2:\n"
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)) : "memory");
+#ifdef CONFIG_X86_64
+	BUILD_BUG_ON(__builtin_constant_p(msr));
+#endif
+
+	/*
+	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
+	 * DS prefix to avoid a trailing NOP.
+	 */
+	asm_inline volatile goto(
+		"1:\n"
+		ALTERNATIVE("ds wrmsr",
+			    ASM_WRMSRNS,
+			    X86_FEATURE_WRMSRNS)
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])
+
+		:
+		: "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)), [type] "i" (type)
+		: "memory"
+		: badmsr);
+
+	return false;
+
+badmsr:
+	return true;
+}
+
+#ifdef CONFIG_X86_64
+/*
+ * Non-serializing WRMSR or its immediate form, when available.
+ *
+ * Otherwise, it falls back to a serializing WRMSR.
+ */
+static __always_inline bool __wrmsrq_constant(u32 msr, u64 val, int type)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(msr));
+
+	asm_inline volatile goto(
+		"1:\n"
+		ALTERNATIVE_2(PREPARE_RCX_RDX_FOR_WRMSR
+			      "2: ds wrmsr",
+			      PREPARE_RCX_RDX_FOR_WRMSR
+			      ASM_WRMSRNS,
+			      X86_FEATURE_WRMSRNS,
+			      ASM_WRMSRNS_IMM,
+			      X86_FEATURE_MSR_IMM)
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate */
+		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
+
+		:
+		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
+		: "memory", "ecx", "rdx"
+		: badmsr);
+
+	return false;
+
+badmsr:
+	return true;
+}
+#endif
+
+static __always_inline bool __wrmsrq(u32 msr, u64 val, int type)
+{
+#ifdef CONFIG_X86_64
+	if (__builtin_constant_p(msr))
+		return __wrmsrq_constant(msr, val, type);
+#endif
+
+	return __wrmsrq_variable(msr, val, type);
 }
 
 #define native_rdmsr(msr, val1, val2)			\
@@ -113,11 +207,15 @@ static __always_inline u64 native_rdmsrq(u32 msr)
 	return __rdmsr(msr);
 }
 
-#define native_wrmsr(msr, low, high)			\
-	__wrmsrq((msr), (u64)(high) << 32 | (low))
+static __always_inline void native_wrmsrq(u32 msr, u64 val)
+{
+	__wrmsrq(msr, val, EX_TYPE_WRMSR);
+}
 
-#define native_wrmsrq(msr, val)				\
-	__wrmsrq((msr), (val))
+static __always_inline void native_wrmsr(u32 msr, u32 low, u32 high)
+{
+	native_wrmsrq(msr, (u64)high << 32 | low);
+}
 
 static inline u64 native_read_msr(u32 msr)
 {
@@ -149,15 +247,7 @@ static inline void notrace native_write_msr(u32 msr, u64 val)
 /* Can be uninlined because referenced by paravirt */
 static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 {
-	int err;
-
-	asm volatile("1: wrmsr ; xor %[err],%[err]\n"
-		     "2:\n\t"
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_WRMSR_SAFE, %[err])
-		     : [err] "=a" (err)
-		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val >> 32))
-		     : "memory");
-	return err;
+	return __wrmsrq(msr, val, EX_TYPE_WRMSR_SAFE) ? -EIO : 0;
 }
 
 extern int rdmsr_safe_regs(u32 regs[8]);
@@ -176,7 +266,6 @@ static inline u64 native_read_pmc(int counter)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#include <linux/errno.h>
 static __always_inline u64 read_msr(u32 msr)
 {
 	return native_read_msr(msr);
@@ -268,21 +357,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return err;
 }
 
-/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
-#define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
-
-/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
-static __always_inline void wrmsrns(u32 msr, u64 val)
-{
-	/*
-	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
-	 * DS prefix to avoid a trailing NOP.
-	 */
-	asm volatile("1: " ALTERNATIVE("ds wrmsr", ASM_WRMSRNS, X86_FEATURE_WRMSRNS)
-		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
-}
-
 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
 	wrmsrq(msr, (u64)high << 32 | low);
-- 
2.51.0


