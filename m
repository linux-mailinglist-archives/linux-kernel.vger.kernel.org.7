Return-Path: <linux-kernel+bounces-892565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EED00C455DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D1E4E9004
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA682F83C5;
	Mon, 10 Nov 2025 08:24:06 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E002F83BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763045; cv=none; b=s7zw5kGJMQLYtVG1Thkz4UCcHLaA0gqmLbsXLdlKyOzJjZPqzejmO4XiYX3dVlqR9VhEIkNnYIcB+pUfFxSj1BWxMWw5y8abKogySuzRFrGUoVb2u3qisuF4ZouevrOG9Mfw8Ovv1aJ9cBjlaEi3FW5Rx10Koz8CTx3n5AmYGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763045; c=relaxed/simple;
	bh=hzcNUVlKrn0SacGprxhEDaO7OPDQ8G1+yBQ2Ae9sGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAYg5w4djmX1cOAOYXoxcyo7ClbtUkz4SA8GzIBM9oQZi3XZvUnauY8Gu1xv2SdKJCKplipVNc++KKXIq3YvtcO99ftfdb0aWAkBrtgeKLlkkHALKH5Tnjd4WboVtIv74GD6Xvx7o4chblHoKx7l6sAUpHXE452y3s9mgEcag+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A135533727;
	Mon, 10 Nov 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F1B713BAE;
	Mon, 10 Nov 2025 08:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nsXVFR+hEWnNKAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Nov 2025 08:23:59 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 3/3] x86/alternative: Patch a single alternative location only once
Date: Mon, 10 Nov 2025 09:23:39 +0100
Message-ID: <20251110082339.30144-4-jgross@suse.com>
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
X-Rspamd-Queue-Id: A135533727
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

Instead of patching a single location potentially multiple times in
case of nested ALTERNATIVE()s, do the patching only after having
evaluated all alt_instr instances for that location.

This has multiple advantages:

- In case of replacing an indirect with a direct call using the
  ALT_FLAG_DIRECT_CALL flag, there is no longer the need to have that
  instance before any other instances at the same location (the
  original instruction is needed for finding the target of the direct
  call).
  This issue has been hit when trying to do paravirt patching similar
  to the following:
    ALTERNATIVE_2(PARAVIRT_CALL,    // indirect call
                  instr, feature,   // native instruction
                  ALT_CALL_INSTR, X86_FEATURE_XENPV)  // Xen function
  In case "feature" was true, "instr" replaced the indirect call. Under
  Xen PV the patching to have a direct call failed, as the original
  indirect call was no longer there to find the call target.

- In case of nested ALTERNATIVE()s there is no intermediate replacement
  visible. This avoids any problems in case e.g. an interrupt is
  happening between the single instances and the patched location is
  used during handling the interrupt.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- complete rework (Boris Petkov)
V3:
- rebase to added patch 2
---
 arch/x86/kernel/alternative.c | 59 ++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 248e5f212a2b..1d8dbf5521e9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -610,10 +610,10 @@ struct patch_site {
 	u8 len;
 };
 
-static void __init_or_module analyze_patch_site(struct patch_site *ps,
-						struct alt_instr *p, struct alt_instr *end)
+static struct alt_instr * __init_or_module analyze_patch_site(
+	struct patch_site *ps, struct alt_instr *p, struct alt_instr *end)
 {
-	struct alt_instr *r;
+	struct alt_instr *r = NULL;
 	u8 buff_sz;
 	u8 *repl;
 
@@ -622,48 +622,54 @@ static void __init_or_module analyze_patch_site(struct patch_site *ps,
 	 * more padding. To ensure consistent patching find the max padding for
 	 * all alt_instr entries for this site (nested alternatives result in
 	 * consecutive entries).
+	 * Find the last alt_instr eligible for patching at the site.
 	 */
 	ps->instr = instr_va(p);
-	ps->len = p->instrlen;
-	for (r = p+1; r < end && instr_va(r) == ps->instr; r++) {
-		ps->len = max(ps->len, r->instrlen);
-		p->instrlen = r->instrlen = ps->len;
+	ps->len = 0;
+	for (; p < end && instr_va(p) == ps->instr; p++) {
+		ps->len = max(ps->len, p->instrlen);
+
+		BUG_ON(p->cpuid >= (NCAPINTS + NBUGINTS) * 32);
+		/*
+		 * Patch if either:
+		 * - feature is present
+		 * - feature not present but ALT_FLAG_NOT is set to mean,
+		 *   patch if feature is *NOT* present.
+		 */
+		if (!boot_cpu_has(p->cpuid) != !(p->flags & ALT_FLAG_NOT))
+			r = p;
 	}
 
 	BUG_ON(ps->len > sizeof(ps->buff));
-	BUG_ON(p->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
-	/*
-	 * Patch if either:
-	 * - feature is present
-	 * - feature not present but ALT_FLAG_NOT is set to mean,
-	 *   patch if feature is *NOT* present.
-	 */
-	if (!boot_cpu_has(p->cpuid) == !(p->flags & ALT_FLAG_NOT)) {
+	if (!r) {
+		/* Nothing to patch, use original instruction. */
 		memcpy(ps->buff, ps->instr, ps->len);
-		return;
+		return p;
 	}
 
-	repl = (u8 *)&p->repl_offset + p->repl_offset;
+	repl = (u8 *)&r->repl_offset + r->repl_offset;
 	DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
-		p->cpuid >> 5, p->cpuid & 0x1f,
+		r->cpuid >> 5, r->cpuid & 0x1f,
 		ps->instr, ps->instr, ps->len,
-		repl, p->replacementlen, p->flags);
+		repl, r->replacementlen, r->flags);
 
-	memcpy(ps->buff, repl, p->replacementlen);
-	buff_sz = p->replacementlen;
+	memcpy(ps->buff, repl, r->replacementlen);
+	buff_sz = r->replacementlen;
 
-	if (p->flags & ALT_FLAG_DIRECT_CALL)
-		buff_sz = alt_replace_call(ps->instr, ps->buff, p);
+	if (r->flags & ALT_FLAG_DIRECT_CALL)
+		buff_sz = alt_replace_call(ps->instr, ps->buff, r);
 
 	for (; buff_sz < ps->len; buff_sz++)
 		ps->buff[buff_sz] = 0x90;
 
-	__apply_relocation(ps->buff, ps->instr, ps->len, repl, p->replacementlen);
+	__apply_relocation(ps->buff, ps->instr, ps->len, repl, r->replacementlen);
 
 	DUMP_BYTES(ALT, ps->instr, ps->len, "%px:   old_insn: ", ps->instr);
 	DUMP_BYTES(ALT, repl, p->replacementlen, "%px:   rpl_insn: ", repl);
 	DUMP_BYTES(ALT, ps->buff, ps->len, "%px: final_insn: ", ps->instr);
+
+	return p;
 }
 
 /*
@@ -702,10 +708,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * So be careful if you want to change the scan order to any other
 	 * order.
 	 */
-	for (a = start; a < end; a++) {
+	a = start;
+	while (a < end) {
 		struct patch_site ps;
 
-		analyze_patch_site(&ps, a, end);
+		a = analyze_patch_site(&ps, a, end);
 
 		optimize_nops(ps.instr, ps.buff, ps.len);
 		text_poke_early(ps.instr, ps.buff, ps.len);
-- 
2.51.0


