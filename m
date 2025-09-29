Return-Path: <linux-kernel+bounces-836216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7629BA905B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98327189E5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20F3002C0;
	Mon, 29 Sep 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ck1404zp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ck1404zp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C43002A1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145415; cv=none; b=b6zcqRKh7fFG1RHmg9CX5cFwSRsufH0yE0HOJoQ1/AQS6HJsivAK4ROijgGbFUYkaqMKPNxWAm00E2hWbqxqHCvYcvYRReY9KOyxF75vVhG91sIbFdB6Ihgj/WAE+syOYSsD7xhSsrHMbrH8L4ZqG0e20KVc5b6anYnVyJ5VWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145415; c=relaxed/simple;
	bh=Ert/PyLXTU+1PrSLcE29tHWI73rVMIEE04cTleIo+as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz/KXsqThaiD/ejDD+jKWcAYcfmzn4fGXB7TH/cnzCPtn+6zAnVPrf8hnY/5mM7pWI4+zUtgHW/HAppQdPz43gK90iDwNZ1Hd2gdfu9yJfw8px/rM7Q6XAHtsHHtnZM4Ldr88jKDa0axEIaMh/uO3VCEbVXYtoPm5adj6GgZDlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ck1404zp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ck1404zp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAF9A31863;
	Mon, 29 Sep 2025 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5pJdfVVyxk9Zhe1m3GkIXtRWmbwvjHnx8uLJu12sw8=;
	b=ck1404zpFdrHhJsfrUk+B1jM7VaEHOrw5FfgRh4yS+MruaiTgiXuY6tWqqfpE69/9E4scd
	aVMMyrFRfRw0hd8Eiy9tMPyEcwsc2UVBgIreH2LRu0Z4NMtZwQYEtD4xMarBAjbkKQhsnb
	tmVEPN4vGIgk+qiUjEl/NkNxZTF4Wok=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5pJdfVVyxk9Zhe1m3GkIXtRWmbwvjHnx8uLJu12sw8=;
	b=ck1404zpFdrHhJsfrUk+B1jM7VaEHOrw5FfgRh4yS+MruaiTgiXuY6tWqqfpE69/9E4scd
	aVMMyrFRfRw0hd8Eiy9tMPyEcwsc2UVBgIreH2LRu0Z4NMtZwQYEtD4xMarBAjbkKQhsnb
	tmVEPN4vGIgk+qiUjEl/NkNxZTF4Wok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6928913782;
	Mon, 29 Sep 2025 11:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HQg/GL9t2miDcAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Sep 2025 11:30:07 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] x86/alternative: Patch a single alternative location only once
Date: Mon, 29 Sep 2025 13:29:47 +0200
Message-ID: <20250929112947.27267-4-jgross@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
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

- In case of nested ALTERNATIVE()s there is no intermediate replacement
  visible. This avoids any problems in case e.g. an interrupt is
  happening between the single instances and the patched location is
  used during handling the interrupt.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/alternative.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 735cc017f2d3..ccf07131cd47 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -648,6 +648,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr;
 	struct alt_instr *a, *b;
+	unsigned int instances = 0;
+	bool patched = false;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
@@ -677,9 +679,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 * padding for all alt_instr entries for this site (nested
 		 * alternatives result in consecutive entries).
 		 */
-		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
-			u8 len = max(a->instrlen, b->instrlen);
-			a->instrlen = b->instrlen = len;
+		if (!instances) {
+			for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
+				u8 len = max(a->instrlen, b->instrlen);
+				a->instrlen = b->instrlen = len;
+			}
+			instances = b - a;
+			patched = false;
 		}
 
 		instr = instr_va(a);
@@ -692,14 +698,19 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 * - feature not present but ALT_FLAG_NOT is set to mean,
 		 *   patch if feature is *NOT* present.
 		 */
-		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, instr, a->instrlen);
-			optimize_nops(instr, insn_buff, a->instrlen);
-		} else {
+		if (!boot_cpu_has(a->cpuid) != !(a->flags & ALT_FLAG_NOT)) {
 			apply_one_alternative(instr, insn_buff, a);
+			patched = true;
 		}
 
-		text_poke_early(instr, insn_buff, a->instrlen);
+		instances--;
+		if (!instances) {
+			if (!patched) {
+				memcpy(insn_buff, instr, a->instrlen);
+				optimize_nops(instr, insn_buff, a->instrlen);
+			}
+			text_poke_early(instr, insn_buff, a->instrlen);
+		}
 	}
 
 	kasan_enable_current();
-- 
2.51.0


