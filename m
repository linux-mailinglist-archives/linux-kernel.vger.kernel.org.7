Return-Path: <linux-kernel+bounces-836215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761BBA905A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB71E3A4F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA543002AC;
	Mon, 29 Sep 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OaTkYi1M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OaTkYi1M"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5163002A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145409; cv=none; b=kzgeHBu+N09pkB1vka0DkzJ8ufn38c64TH8cKa1QnPLiqnoLrU+Ur42IEz2ZBXJSR4P0ZRJfApigTV5yy12aSuaSkT0jG5EqkzBBwKiwpZVFDzlA7sSIq7eyF4hqnPfZ5HEvS5VxxmwEyeR6N0QpoXTkSczJM9RFlwz4uFtxoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145409; c=relaxed/simple;
	bh=996yjX/e8fwqrXO79tWt4OSnuI0Dfs/ap51rrZd0Lmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3gy6DTkka973T5or4Ar2gztvcMEwtObLXz2JpfVbcyjLzhyBjKP7cRpEtGWonIWvqI46/gSduWqgpbUDeJBmd2EumdtkWA/zJQcjGP2YWOUOPsO8iTMZBknY2rlCAZnYtxLGBBwuVawaH/zQrixykDamIWLsq6NZO9fEUvAtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OaTkYi1M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OaTkYi1M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F410F3184A;
	Mon, 29 Sep 2025 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CV8kD4z8bPQT5dyMv9OmeX+3SSTb+6IeBhpyFSMHzsQ=;
	b=OaTkYi1M0rdgT8sxJ7ZmAdHsCIl0RuvNW8optTdKZ0/2AsKYu9r/+O1XeXmSqDCImgLZa7
	iPWdRvG6TuDCVug27pyDzGBVmC0PI3Wq59Q5XQHYctsU1T71RBgKRgfX9f7JQe99kQvDKA
	Hg6fvicBpM678mCsgCWCLiXPNIRMEQI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OaTkYi1M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CV8kD4z8bPQT5dyMv9OmeX+3SSTb+6IeBhpyFSMHzsQ=;
	b=OaTkYi1M0rdgT8sxJ7ZmAdHsCIl0RuvNW8optTdKZ0/2AsKYu9r/+O1XeXmSqDCImgLZa7
	iPWdRvG6TuDCVug27pyDzGBVmC0PI3Wq59Q5XQHYctsU1T71RBgKRgfX9f7JQe99kQvDKA
	Hg6fvicBpM678mCsgCWCLiXPNIRMEQI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A099C13782;
	Mon, 29 Sep 2025 11:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AfaTJblt2mhxcAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Sep 2025 11:30:01 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] x86/alternative: Refactor apply_alternatives()
Date: Mon, 29 Sep 2025 13:29:46 +0200
Message-ID: <20250929112947.27267-3-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929112947.27267-1-jgross@suse.com>
References: <20250929112947.27267-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: F410F3184A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Refactor apply_alternatives() by splitting out patching of a single
alt_instr instance into a sub-function.

Keep the final text_poke_early() call in apply_alternatives() in
order to prepare merging multiple alternative patching instances of
the same location.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/alternative.c | 60 +++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 05d3dbe7104e..735cc017f2d3 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -604,6 +604,34 @@ static inline u8 * instr_va(struct alt_instr *i)
 	return (u8 *)&i->instr_offset + i->instr_offset;
 }
 
+static void __init_or_module apply_one_alternative(u8 *instr, u8 *insn_buff,
+						   struct alt_instr *a)
+{
+	u8 *replacement = (u8 *)&a->repl_offset + a->repl_offset;
+	unsigned int insn_buff_sz;
+
+	DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
+		a->cpuid >> 5,
+		a->cpuid & 0x1f,
+		instr, instr, a->instrlen,
+		replacement, a->replacementlen, a->flags);
+
+	memcpy(insn_buff, replacement, a->replacementlen);
+	insn_buff_sz = a->replacementlen;
+
+	if (a->flags & ALT_FLAG_DIRECT_CALL)
+		insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+
+	for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+		insn_buff[insn_buff_sz] = 0x90;
+
+	text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+
+	DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
+	DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+	DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -618,7 +646,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 						  struct alt_instr *end)
 {
 	u8 insn_buff[MAX_PATCH_LEN];
-	u8 *instr, *replacement;
+	u8 *instr;
 	struct alt_instr *a, *b;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
@@ -643,8 +671,6 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * order.
 	 */
 	for (a = start; a < end; a++) {
-		unsigned int insn_buff_sz = 0;
-
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
 		 * add more padding. To ensure consistent patching find the max
@@ -657,7 +683,6 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		}
 
 		instr = instr_va(a);
-		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
@@ -670,32 +695,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
 			memcpy(insn_buff, instr, a->instrlen);
 			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(instr, insn_buff, a->instrlen);
-			continue;
+		} else {
+			apply_one_alternative(instr, insn_buff, a);
 		}
 
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
-
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
-		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
-
-		text_poke_early(instr, insn_buff, insn_buff_sz);
+		text_poke_early(instr, insn_buff, a->instrlen);
 	}
 
 	kasan_enable_current();
-- 
2.51.0


