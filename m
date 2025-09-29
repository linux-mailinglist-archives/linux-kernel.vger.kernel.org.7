Return-Path: <linux-kernel+bounces-836214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F6BA9054
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F033C43A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648163009F0;
	Mon, 29 Sep 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KXFFZXtr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KXFFZXtr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0772E8DF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145401; cv=none; b=GQQD51qS/giwWZpcFu04+O9j80t9YDmRd8vyNgF7GIKBv+Ak0RbZR0jclhS2gT37mmCiOBE6l+QQGaDTOyVehtQP6j+uAW7JPsMzqYRevKMoF69XW7A981J72d/VTk8fbAmgxJ1Lpm3YsSOuOwPKAUk4iBIdurJ6hFfVjfraBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145401; c=relaxed/simple;
	bh=Q0RMUIfZ1lLbI+KfFiVh8RSH+tZlHw8ZsERa9sIO9Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8rfCEQXjmp0uxclbvYL7LLpwq7JNEL4b35L4KNA7fOs8RVy8xny0RKoXwHEatkyTKnHFgVF9JiXHmf64iNUioujhVTdCQLFamA5INQTGtYCk2cDWfDRzE01rThVwxPpwQsZoRcxL1oOYKFq0PZfSyBE1yQC557oramk9JNYHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KXFFZXtr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KXFFZXtr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 262383183F;
	Mon, 29 Sep 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FNZgeYfwwNy9v4xrRjT/JVmGNGOcSlyg7nziKLf/8=;
	b=KXFFZXtrlMUh/Lac3n8bMcX2tG2VT7BmCNCIzAKcvP215xcFu7whX/FHHbIf0cB0xmrCcF
	ibujnyqktUX0ReNfEpuyOhyo77e7SSaFw97tWFsQ7lj+3MNl5+g0ZC6czX8L//J0+tiL2e
	3yZyPJNirL6K5VQ4EejN1ucdv1coVjA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759145396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FNZgeYfwwNy9v4xrRjT/JVmGNGOcSlyg7nziKLf/8=;
	b=KXFFZXtrlMUh/Lac3n8bMcX2tG2VT7BmCNCIzAKcvP215xcFu7whX/FHHbIf0cB0xmrCcF
	ibujnyqktUX0ReNfEpuyOhyo77e7SSaFw97tWFsQ7lj+3MNl5+g0ZC6czX8L//J0+tiL2e
	3yZyPJNirL6K5VQ4EejN1ucdv1coVjA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA9CE13782;
	Mon, 29 Sep 2025 11:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5jrxM7Nt2mhFcAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Sep 2025 11:29:55 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] x86/alternative: Drop not needed test after call of alt_replace_call()
Date: Mon, 29 Sep 2025 13:29:45 +0200
Message-ID: <20250929112947.27267-2-jgross@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

alt_replace_call() will never return a negative value, so testing the
return value to be less than zero can be dropped.

This makes it possible to switch the return type of alt_replace_call()
and the type of insn_buff_sz to unsigned int.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/alternative.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7bde68247b5f..05d3dbe7104e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(BUG_func);
  * Rewrite the "call BUG_func" replacement to point to the target of the
  * indirect pv_ops call "call *disp(%ip)".
  */
-static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+static unsigned int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 {
 	void *target, *bug = &BUG_func;
 	s32 disp;
@@ -643,7 +643,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * order.
 	 */
 	for (a = start; a < end; a++) {
-		int insn_buff_sz = 0;
+		unsigned int insn_buff_sz = 0;
 
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
@@ -683,11 +683,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
-		if (a->flags & ALT_FLAG_DIRECT_CALL) {
+		if (a->flags & ALT_FLAG_DIRECT_CALL)
 			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
-			if (insn_buff_sz < 0)
-				continue;
-		}
 
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
-- 
2.51.0


