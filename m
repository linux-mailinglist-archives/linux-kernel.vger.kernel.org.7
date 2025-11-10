Return-Path: <linux-kernel+bounces-892564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFDC455D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F89B3B4069
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB462F83C5;
	Mon, 10 Nov 2025 08:24:00 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19292F83BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763039; cv=none; b=XaH6/pawy+jPoCXQawY+3mZGCirBZTBsSltkf7YxGK/X0agA/KXeF1DoNNQFm98nypL1H/aw9YGjZ1oYGNSPPxD6O+v7cXKzVbkMP/IDRWOHQygwcE2PuIMrj4AuMVePqgZog28dpLMhVxuHRBHhorm6/9pY5EgBs6oyNS8ipKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763039; c=relaxed/simple;
	bh=vmHwJz6mjiKdp1rmuzrLHYxRLC0eullr+g7yc8mXu28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbjRJ1kqdw24D2YWeEEOltkrIXg/AxawFrlZ4hCTDgF1d/qZvYRKOw/qF2U9Br9/+2e99LkwdwEHRbUsQU9CMqsmI8228YmWyA6KQBiwVCOiIO7WJyQsusiXaXe6kY0cl/1VYi6oFdgyxjSSseprCkLxM/D0YwdpEN0Ra0XLYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01FA033724;
	Mon, 10 Nov 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB1C513BAE;
	Mon, 10 Nov 2025 08:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3RNKBmhEWnBKAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Nov 2025 08:23:53 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/3] x86/alternative: Use a helper function for patching alternatives
Date: Mon, 10 Nov 2025 09:23:38 +0100
Message-ID: <20251110082339.30144-3-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110082339.30144-1-jgross@suse.com>
References: <20251110082339.30144-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 01FA033724
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Tidy up apply_alternatives() by moving the main patching action of a
single alternative instance into a helper function.

As the original instruction is being patched with optimized padding
NOPs even in case no replacement instruction has been selected, do
the main patching action in the main loop. This requires to use
__apply_relocation() instead of text_poke_apply_relocation() in
order to have only a single call of optimize_nops(), resulting in a
more transparent coding (the question why optimize_nops() isn't
being called in all cases has come up more than once in the past).

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 arch/x86/kernel/alternative.c | 121 +++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4f3ea50e41e8..248e5f212a2b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -604,6 +604,68 @@ static inline u8 * instr_va(struct alt_instr *i)
 	return (u8 *)&i->instr_offset + i->instr_offset;
 }
 
+struct patch_site {
+	u8 *instr;
+	u8 buff[MAX_PATCH_LEN];
+	u8 len;
+};
+
+static void __init_or_module analyze_patch_site(struct patch_site *ps,
+						struct alt_instr *p, struct alt_instr *end)
+{
+	struct alt_instr *r;
+	u8 buff_sz;
+	u8 *repl;
+
+	/*
+	 * In case of nested ALTERNATIVE()s the outer alternative might add
+	 * more padding. To ensure consistent patching find the max padding for
+	 * all alt_instr entries for this site (nested alternatives result in
+	 * consecutive entries).
+	 */
+	ps->instr = instr_va(p);
+	ps->len = p->instrlen;
+	for (r = p+1; r < end && instr_va(r) == ps->instr; r++) {
+		ps->len = max(ps->len, r->instrlen);
+		p->instrlen = r->instrlen = ps->len;
+	}
+
+	BUG_ON(ps->len > sizeof(ps->buff));
+	BUG_ON(p->cpuid >= (NCAPINTS + NBUGINTS) * 32);
+
+	/*
+	 * Patch if either:
+	 * - feature is present
+	 * - feature not present but ALT_FLAG_NOT is set to mean,
+	 *   patch if feature is *NOT* present.
+	 */
+	if (!boot_cpu_has(p->cpuid) == !(p->flags & ALT_FLAG_NOT)) {
+		memcpy(ps->buff, ps->instr, ps->len);
+		return;
+	}
+
+	repl = (u8 *)&p->repl_offset + p->repl_offset;
+	DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
+		p->cpuid >> 5, p->cpuid & 0x1f,
+		ps->instr, ps->instr, ps->len,
+		repl, p->replacementlen, p->flags);
+
+	memcpy(ps->buff, repl, p->replacementlen);
+	buff_sz = p->replacementlen;
+
+	if (p->flags & ALT_FLAG_DIRECT_CALL)
+		buff_sz = alt_replace_call(ps->instr, ps->buff, p);
+
+	for (; buff_sz < ps->len; buff_sz++)
+		ps->buff[buff_sz] = 0x90;
+
+	__apply_relocation(ps->buff, ps->instr, ps->len, repl, p->replacementlen);
+
+	DUMP_BYTES(ALT, ps->instr, ps->len, "%px:   old_insn: ", ps->instr);
+	DUMP_BYTES(ALT, repl, p->replacementlen, "%px:   rpl_insn: ", repl);
+	DUMP_BYTES(ALT, ps->buff, ps->len, "%px: final_insn: ", ps->instr);
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -617,9 +679,7 @@ static inline u8 * instr_va(struct alt_instr *i)
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
-	u8 insn_buff[MAX_PATCH_LEN];
-	u8 *instr, *replacement;
-	struct alt_instr *a, *b;
+	struct alt_instr *a;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
@@ -643,59 +703,12 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * order.
 	 */
 	for (a = start; a < end; a++) {
-		unsigned int insn_buff_sz = 0;
-
-		/*
-		 * In case of nested ALTERNATIVE()s the outer alternative might
-		 * add more padding. To ensure consistent patching find the max
-		 * padding for all alt_instr entries for this site (nested
-		 * alternatives result in consecutive entries).
-		 */
-		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
-			u8 len = max(a->instrlen, b->instrlen);
-			a->instrlen = b->instrlen = len;
-		}
-
-		instr = instr_va(a);
-		replacement = (u8 *)&a->repl_offset + a->repl_offset;
-		BUG_ON(a->instrlen > sizeof(insn_buff));
-		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
-
-		/*
-		 * Patch if either:
-		 * - feature is present
-		 * - feature not present but ALT_FLAG_NOT is set to mean,
-		 *   patch if feature is *NOT* present.
-		 */
-		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, instr, a->instrlen);
-			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(instr, insn_buff, a->instrlen);
-			continue;
-		}
-
-		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->flags);
-
-		memcpy(insn_buff, replacement, a->replacementlen);
-		insn_buff_sz = a->replacementlen;
-
-		if (a->flags & ALT_FLAG_DIRECT_CALL)
-			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
-
-		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
-			insn_buff[insn_buff_sz] = 0x90;
-
-		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+		struct patch_site ps;
 
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
-		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+		analyze_patch_site(&ps, a, end);
 
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		optimize_nops(ps.instr, ps.buff, ps.len);
+		text_poke_early(ps.instr, ps.buff, ps.len);
 	}
 
 	kasan_enable_current();
-- 
2.51.0


