Return-Path: <linux-kernel+bounces-837230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6FABABBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874081888119
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACC92BEC43;
	Tue, 30 Sep 2025 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TdHByD1K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M9kVM9BV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05532BE620
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215892; cv=none; b=g9jxas2WsKx0+uikD7U+mZJAG9C9v10rsioFjGtF0bQUGkEzo5yd6ldY4cpRYIrdNLkC0ACjM8J+T4R+kRQFOCKw7Pao5bGmsWFLKxPqs1L+PGnK40XCoPGyOCzKhE/i8Vx5J18N3XZoPXl6Swv9DVwwYeK37IADQ+VVGJ0DwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215892; c=relaxed/simple;
	bh=2btrxefdF4Q1zNspVlgbxPl0NsoD/LlIuiuyOKZXiE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmrZF6Qg+phCeeThoxLDB7019XKPbPwOPNlvALzt43yseowm8RBQI5GtMFVzMQB3E4cqrUl082tSmI5MKn+vfAhiCZ5VznxbHUSbxORkOz6EMF5Ve0LaQ85cRkGWL88mIUjTqrhrUxHY+ziagDaBhA+aiJYwRtjAAEZp/OWCuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TdHByD1K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M9kVM9BV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 387941F7A1;
	Tue, 30 Sep 2025 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klTuaYwceM5pQDhHUjQjBczV/l6B7KGMatMdzB4iS/M=;
	b=TdHByD1Kv7M84qNdnMljJrwPkH6/M+T8wMWWadnKi/T+gqe/mgcltZr24PhxVQCn1+9HWA
	R9gK9OIwkbre4kYyGfKO77y2ymQQJtIyC9ch120v5F3PwKTrB+TAOzZOMcFgir5qEmtK9o
	Sad0qlvp9SypA1M1jj9WL2MTWFPLQkA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klTuaYwceM5pQDhHUjQjBczV/l6B7KGMatMdzB4iS/M=;
	b=M9kVM9BVkIaStY5mG502QcigzjaN4gGBuFkmHrso3xn/Aoa5l+Xy5CHnoKI6I8/2xOp30y
	m1VjKLZs224Gn/Zu0foZqEW6xqaMHF5nvM3hiJj3xaYdCA8aD1C+kLrnh6YuFJ/NJhyGB2
	Q++GNlB5Rze3ABUN8bK8sCuQOnrrPyw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D910713A3F;
	Tue, 30 Sep 2025 07:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k2OCMw6B22i+RwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Sep 2025 07:04:46 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 08/12] x86/extable: Add support for immediate form MSR instructions
Date: Tue, 30 Sep 2025 09:03:52 +0200
Message-ID: <20250930070356.30695-9-jgross@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

From: "Xin Li (Intel)" <xin@zytor.com>

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch, taken from the RFC v2 MSR refactor series by Xin Li
---
 arch/x86/include/asm/msr.h | 18 ++++++++++++++++++
 arch/x86/mm/extable.c      | 39 +++++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 71f41af11591..cf5205300266 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -56,6 +56,24 @@ static inline void do_trace_read_msr(u32 msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 #endif
 
+/*
+ * Called only from an MSR fault handler, the instruction pointer points to
+ * the MSR access instruction that caused the fault.
+ */
+static __always_inline bool is_msr_imm_insn(void *ip)
+{
+	/*
+	 * A full decoder for immediate form MSR instructions appears excessive.
+	 */
+#ifdef CONFIG_X86_64
+	const u8 msr_imm_insn_prefix[] = { 0xc4, 0xe7 };
+
+	return !memcmp(ip, msr_imm_insn_prefix, sizeof(msr_imm_insn_prefix));
+#else
+	return false;
+#endif
+}
+
 /*
  * __rdmsr() and __wrmsr() are the two primitives which are the bare minimum MSR
  * accessors and should not have any tracing or other functionality piggybacking
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 2fdc1f1f5adb..c021e4dbc69d 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -166,23 +166,52 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 static bool ex_handler_msr(const struct exception_table_entry *fixup,
 			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
+	bool imm_insn = is_msr_imm_insn((void *)regs->ip);
+	u32 msr;
+
+	if (imm_insn)
+		/*
+		 * The 32-bit immediate specifying a MSR is encoded into
+		 * byte 5 ~ 8 of an immediate form MSR instruction.
+		 */
+		msr = *(u32 *)(regs->ip + 5);
+	else
+		msr = (u32)regs->cx;
+
 	if (__ONCE_LITE_IF(!safe && wrmsr)) {
-		pr_warn("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-			(unsigned int)regs->cx, (unsigned int)regs->dx,
-			(unsigned int)regs->ax,  regs->ip, (void *)regs->ip);
+		/*
+		 * To maintain consistency with existing RDMSR and WRMSR(NS) instructions,
+		 * the register operand for immediate form MSR instructions is ALWAYS
+		 * encoded as RAX in <asm/msr.h> for reading or writing the MSR value.
+		 */
+		u64 msr_val = regs->ax;
+
+		if (!imm_insn) {
+			/*
+			 * On processors that support the Intel 64 architecture, the
+			 * high-order 32 bits of each of RAX and RDX are ignored.
+			 */
+			msr_val &= 0xffffffff;
+			msr_val |= (u64)regs->dx << 32;
+		}
+
+		pr_warn("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%016llx) at rIP: 0x%lx (%pS)\n",
+			msr, msr_val, regs->ip, (void *)regs->ip);
 		show_stack_regs(regs);
 	}
 
 	if (__ONCE_LITE_IF(!safe && !wrmsr)) {
 		pr_warn("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
-			(unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+			msr, regs->ip, (void *)regs->ip);
 		show_stack_regs(regs);
 	}
 
 	if (!wrmsr) {
 		/* Pretend that the read succeeded and returned 0. */
 		regs->ax = 0;
-		regs->dx = 0;
+
+		if (!imm_insn)
+			regs->dx = 0;
 	}
 
 	if (safe)
-- 
2.51.0


