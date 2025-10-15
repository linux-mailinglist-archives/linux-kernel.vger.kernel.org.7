Return-Path: <linux-kernel+bounces-854185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CFEBDDC89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A342B3BBE46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C031A7E6;
	Wed, 15 Oct 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mRR7EaZp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mRR7EaZp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00522F5327
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520611; cv=none; b=raP161iop+BhrIf75m5w44PbswYZLTUnjznahmB9olY2I5519Gc8mkyCPoaStPxB/OCMKcSXrEwUfUwqzN8+eohiCecEm9l5MauugpxoT3sA6eK1a4YrV1Nz1B2F6CIyY7/aiV5hxaFF3P/Hxpqp7GNq5nfgFxeyA4JTLpNJkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520611; c=relaxed/simple;
	bh=wrhpakM3EA3vatQkFcL9T1H1rOF2pKB+mvTK4/4UR9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osNiRz/R4vaR9kg4xPQ0dtbxMVrVkve4/b9/txqtKT/7ErKs7WDzl+7MaZXK4dYUO0v5cyieTcvIgyBXi7V6Jb+tqIYkxnMFc4omqEKFwFwLFQEQ9pZ8R64QzBngr8sdi8qlfugztxTj8cMIKcTu7SQecLYXTJfd2wnmavlP798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mRR7EaZp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mRR7EaZp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDBC833855;
	Wed, 15 Oct 2025 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760520605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gpEERhK8jG/YR1bvfMUP9xCBX8lbZrdwM+iekrJ1DaY=;
	b=mRR7EaZpgEziOtqjmo/AWUXO+aYq12BkdcXe54jBuQV5fdY2iGhAG9LBpFd0nFF31+66JO
	oU0VRLZ7YevvT8QdoGdIsKw7q4vfnHludhmpYa/68yWHX+zlaOV1Ex/o7fdOhI1woFmcpH
	Nw4lrSc7lkzZKGl/vny0mfBVOb63CVk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760520605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gpEERhK8jG/YR1bvfMUP9xCBX8lbZrdwM+iekrJ1DaY=;
	b=mRR7EaZpgEziOtqjmo/AWUXO+aYq12BkdcXe54jBuQV5fdY2iGhAG9LBpFd0nFF31+66JO
	oU0VRLZ7YevvT8QdoGdIsKw7q4vfnHludhmpYa/68yWHX+zlaOV1Ex/o7fdOhI1woFmcpH
	Nw4lrSc7lkzZKGl/vny0mfBVOb63CVk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7070313A42;
	Wed, 15 Oct 2025 09:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3JP6GZ1p72gdTAAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 15 Oct 2025 09:30:05 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/alternative: Patch a single alternative location only once
Date: Wed, 15 Oct 2025 11:30:01 +0200
Message-ID: <20251015093001.14840-1-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
---
 arch/x86/kernel/alternative.c | 63 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4f3ea50e41e8..b6b2fa59eaa9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -642,57 +642,62 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * So be careful if you want to change the scan order to any other
 	 * order.
 	 */
-	for (a = start; a < end; a++) {
+	for (a = start; a < end; a = b) {
 		unsigned int insn_buff_sz = 0;
+		struct alt_instr *p = NULL;
+		u8 len = 0;
 
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
 		 * add more padding. To ensure consistent patching find the max
 		 * padding for all alt_instr entries for this site (nested
 		 * alternatives result in consecutive entries).
+		 * Find the last alt_instr eligible for patching at the site.
 		 */
-		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
-			u8 len = max(a->instrlen, b->instrlen);
-			a->instrlen = b->instrlen = len;
+		for (b = a; b < end && instr_va(b) == instr_va(a); b++) {
+			len = max(len, b->instrlen);
+
+			BUG_ON(b->cpuid >= (NCAPINTS + NBUGINTS) * 32);
+			/*
+			 * Patch if either:
+			 * - feature is present
+			 * - feature not present but ALT_FLAG_NOT is set to mean,
+			 *   patch if feature is *NOT* present.
+			 */
+			if (!boot_cpu_has(b->cpuid) != !(b->flags & ALT_FLAG_NOT))
+				p = b;
 		}
 
 		instr = instr_va(a);
-		replacement = (u8 *)&a->repl_offset + a->repl_offset;
-		BUG_ON(a->instrlen > sizeof(insn_buff));
-		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
+		BUG_ON(len > sizeof(insn_buff));
 
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
+		if (!p) {
+			memcpy(insn_buff, instr, len);
+			optimize_nops(instr, insn_buff, len);
+			text_poke_early(instr, insn_buff, len);
 			continue;
 		}
 
+		replacement = (u8 *)&p->repl_offset + p->repl_offset;
 		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
-			instr, instr, a->instrlen,
-			replacement, a->replacementlen, a->flags);
+			p->cpuid >> 5,
+			p->cpuid & 0x1f,
+			instr, instr, len,
+			replacement, p->replacementlen, p->flags);
 
-		memcpy(insn_buff, replacement, a->replacementlen);
-		insn_buff_sz = a->replacementlen;
+		memcpy(insn_buff, replacement, p->replacementlen);
+		insn_buff_sz = p->replacementlen;
 
-		if (a->flags & ALT_FLAG_DIRECT_CALL)
-			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+		if (p->flags & ALT_FLAG_DIRECT_CALL)
+			insn_buff_sz = alt_replace_call(instr, insn_buff, p);
 
-		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
+		for (; insn_buff_sz < len; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
-		text_poke_apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
+		text_poke_apply_relocation(insn_buff, instr, len, replacement, p->replacementlen);
 
-		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
-		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
+		DUMP_BYTES(ALT, instr, len, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, replacement, p->replacementlen, "%px:   rpl_insn: ", replacement);
 		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
-- 
2.51.0


