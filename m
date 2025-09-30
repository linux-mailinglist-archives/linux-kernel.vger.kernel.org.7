Return-Path: <linux-kernel+bounces-837232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A409BABBED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE56D1C1432
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816342C11C0;
	Tue, 30 Sep 2025 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ac6Ns3BG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mdjOZfn3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401D2BF015
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215903; cv=none; b=CnyXhE8SCnCubNfgsxyYAkX5b3YGLDWk1vfemp7ll65f2tfIp1AwRlGKr5IURHAIR+7XexpGIihnoOJk/oLvHVIPdN8Dni90Dc6gU4qpPvzP9CVTwJOCc/ln2fgZD9+BmbJ+9xk9wpre8tbhHw8yMkshwK+Io5kJkX2P9U7ie8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215903; c=relaxed/simple;
	bh=/IFvLdmIX8BDFoHD122++2YqQJYtKvBqnRop4BCtQc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOr4Qnlt+ugH52JdCTtsG9UPYSM5yZAWjWdn0YFj0SCmOJ8c5n5G0UJ7EFLcw/50iYjIKauy7cqg/VS5U3uHYkw6KjH/1KqXGF30lfyegZVvnmH/6lRz+FsMT5kA528T/2oH87WEX9UPbICioukT7t900x12zRD7dFwSXUFzPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ac6Ns3BG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mdjOZfn3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D75F2336FF;
	Tue, 30 Sep 2025 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZm0DnA6KdLtON2UgVBMrVDAI2zIvqlTqbr+n8W7AZc=;
	b=Ac6Ns3BGPRP9+BHlragN+B33IvyJQdFzRCKmVaXGVLp2rXq6cWUi8fM4u1Gq24Cw3Ml8rE
	/e+xx1RxAYXY9VoXFzbe1KvLw9XMi7K/xorf6+DInvuc3lxoI5oJ2qtyGHK2J1qKh4HnB8
	IOUvA2yHDhRNInrzu8QK2tIN6S6yTxg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZm0DnA6KdLtON2UgVBMrVDAI2zIvqlTqbr+n8W7AZc=;
	b=mdjOZfn3bHNMs0I5wtj5G7KL+vnM1Fong4JLmM6RuK9uzkG1fuyK6T7XB6JfPs7pdCPYLR
	3GbkUD9acTzL9QAdf5xQzfA2wJZ1fZ0M0kpi4k3D3LqvE4mowYWSsAEuw/lnNM734IApwL
	VpIb2JIBMuM4LwjH785oUljHUKvgJQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5AE13A3F;
	Tue, 30 Sep 2025 07:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6nhWIRqB22jWRwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Sep 2025 07:04:58 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 10/12] x86/msr: Use the alternatives mechanism for RDMSR
Date: Tue, 30 Sep 2025 09:03:54 +0200
Message-ID: <20250930070356.30695-11-jgross@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,zytor.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

When available use the immediate variant of RDMSR in __rdmsr().

For the safe/unsafe variants make __rdmsr() to be a common base
function instead of duplicating the ALTERNATIVE*() macros.

Modify native_rdmsr() and native_read_msr() to use native_rdmsrq().

The paravirt case will be handled later.

Originally-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch, partially taken from "[RFC PATCH v2 22/34] x86/msr: Utilize
  the alternatives mechanism to read MSR" by Xin Li
---
 arch/x86/include/asm/msr.h | 116 ++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 19ed780c2a09..cc592611e333 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -65,6 +65,8 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 
 /* The GNU Assembler (Gas) with Binutils 2.41 adds the .insn directive support */
 #if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24100
+#define ASM_RDMSR_IMM			\
+	" .insn VEX.128.F2.M7.W0 0xf6 /0, %[msr]%{:u32}, %[val]\n\t"
 #define ASM_WRMSRNS_IMM			\
 	" .insn VEX.128.F3.M7.W0 0xf6 /0, %[val], %[msr]%{:u32}\n\t"
 #else
@@ -74,10 +76,17 @@ static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
  * The register operand is encoded as %rax because all uses of the immediate
  * form MSR access instructions reference %rax as the register operand.
  */
+#define ASM_RDMSR_IMM			\
+	" .byte 0xc4,0xe7,0x7b,0xf6,0xc0; .long %c[msr]"
 #define ASM_WRMSRNS_IMM			\
 	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
 #endif
 
+#define RDMSR_AND_SAVE_RESULT		\
+	"rdmsr\n\t"			\
+	"shl $0x20, %%rdx\n\t"		\
+	"or %%rdx, %%rax\n\t"
+
 #define PREPARE_RDX_FOR_WRMSR		\
 	"mov %%rax, %%rdx\n\t"		\
 	"shr $0x20, %%rdx\n\t"
@@ -111,16 +120,76 @@ static __always_inline bool is_msr_imm_insn(void *ip)
  * think of extending them - you will be slapped with a stinking trout or a frozen
  * shark will reach you, wherever you are! You've been warned.
  */
-static __always_inline u64 __rdmsr(u32 msr)
+static __always_inline bool __rdmsrq_variable(u32 msr, u64 *val, int type)
+ {
+#ifdef CONFIG_X86_64
+	BUILD_BUG_ON(__builtin_constant_p(msr));
+
+	asm_inline volatile goto(
+		"1:\n"
+		RDMSR_AND_SAVE_RESULT
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For RDMSR */
+
+		: [val] "=a" (*val)
+		: "c" (msr), [type] "i" (type)
+		: "rdx"
+		: badmsr);
+#else
+	asm_inline volatile goto(
+		"1: rdmsr\n\t"
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For RDMSR */
+
+		: "=A" (*val)
+		: "c" (msr), [type] "i" (type)
+		:
+		: badmsr);
+#endif
+
+	return false;
+
+badmsr:
+	*val = 0;
+
+	return true;
+}
+
+#ifdef CONFIG_X86_64
+static __always_inline bool __rdmsrq_constant(u32 msr, u64 *val, int type)
 {
-	EAX_EDX_DECLARE_ARGS(val, low, high);
+	BUILD_BUG_ON(!__builtin_constant_p(msr));
 
-	asm volatile("1: rdmsr\n"
-		     "2:\n"
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR)
-		     : EAX_EDX_RET(val, low, high) : "c" (msr));
+	asm_inline volatile goto(
+		"1:\n"
+		ALTERNATIVE("mov %[msr], %%ecx\n\t"
+			    "2:\n"
+			    RDMSR_AND_SAVE_RESULT,
+			    ASM_RDMSR_IMM,
+			    X86_FEATURE_MSR_IMM)
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For RDMSR immediate */
+		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For RDMSR */
+
+		: [val] "=a" (*val)
+		: [msr] "i" (msr), [type] "i" (type)
+		: "ecx", "rdx"
+		: badmsr);
 
-	return EAX_EDX_VAL(val, low, high);
+	return false;
+
+badmsr:
+	*val = 0;
+
+	return true;
+}
+#endif
+
+static __always_inline bool __rdmsr(u32 msr, u64 *val, int type)
+{
+#ifdef CONFIG_X86_64
+	if (__builtin_constant_p(msr))
+		return __rdmsrq_constant(msr, val, type);
+#endif
+
+	return __rdmsrq_variable(msr, val, type);
 }
 
 static __always_inline bool __wrmsrq_variable(u32 msr, u64 val, int type)
@@ -195,18 +264,22 @@ static __always_inline bool __wrmsrq(u32 msr, u64 val, int type)
 	return __wrmsrq_variable(msr, val, type);
 }
 
+static __always_inline u64 native_rdmsrq(u32 msr)
+{
+	u64 val;
+
+	__rdmsr(msr, &val, EX_TYPE_RDMSR);
+
+	return val;
+}
+
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
-	u64 __val = __rdmsr((msr));			\
+	u64 __val = native_rdmsrq((msr));		\
 	(void)((val1) = (u32)__val);			\
 	(void)((val2) = (u32)(__val >> 32));		\
 } while (0)
 
-static __always_inline u64 native_rdmsrq(u32 msr)
-{
-	return __rdmsr(msr);
-}
-
 static __always_inline void native_wrmsrq(u32 msr, u64 val)
 {
 	__wrmsrq(msr, val, EX_TYPE_WRMSR);
@@ -219,23 +292,12 @@ static __always_inline void native_wrmsr(u32 msr, u32 low, u32 high)
 
 static inline u64 native_read_msr(u32 msr)
 {
-	return __rdmsr(msr);
+	return native_rdmsrq(msr);
 }
 
-static inline int native_read_msr_safe(u32 msr, u64 *p)
+static inline int native_read_msr_safe(u32 msr, u64 *val)
 {
-	int err;
-	EAX_EDX_DECLARE_ARGS(val, low, high);
-
-	asm volatile("1: rdmsr ; xor %[err],%[err]\n"
-		     "2:\n\t"
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
-		     : [err] "=r" (err), EAX_EDX_RET(val, low, high)
-		     : "c" (msr));
-
-	*p = EAX_EDX_VAL(val, low, high);
-
-	return err;
+	return __rdmsr(msr, val, EX_TYPE_RDMSR_SAFE) ? -EIO : 0;
 }
 
 /* Can be uninlined because referenced by paravirt */
-- 
2.51.0


