Return-Path: <linux-kernel+bounces-892563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D45C455D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262C63B322E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD12F83AC;
	Mon, 10 Nov 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bsOiD+Co";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bsOiD+Co"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D322F83BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763033; cv=none; b=ekN9hciOYpNUVbQUAXuX79ypx0z1wJHocg6MRjzJQTRxECBfSzFPplK2RCOrAF4rWYUS6yNP9MLmsrDru7/6SpQqi9FfkpaBdyKS6eSfQ+0QdLgYb/ivjYOLBvY2IMIDfbV+M+/GKanhpInWiHPawAJE5X5wCtvttS/JyLeZ0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763033; c=relaxed/simple;
	bh=X0y3ntGNjiF48lqn+isvO6LuxT9mJpoVP3Kji+DFDQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ8vC6pv4mpo+q+cYfJV0CVQ6RYWuf4gimGzC9eRgpEzCTJmpamZmLsX2e27wI3yysM6EWOJY5pbsFU3I8IOfDUoCtkOL5/qXO4nWluAJiXL9/2YAbI6byfJD0VziQAC//r3cT7CI+RRV7udjRWrjvTkuT1iOagpi6KcUj+0OiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bsOiD+Co; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bsOiD+Co; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4506B33683;
	Mon, 10 Nov 2025 08:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762763028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LyxHIh10sONol3annpWE2J2EAH/JvgyQtND7zs4cJs=;
	b=bsOiD+CoCtdk2baf0d7CIZps2GaLT+wQCwxfrmRhE6ROhuGnZxOPZFJsbMveeZE1+AQSGk
	42QWuqS1pmrcEHlZ0GvWC0Tcw5/o2sSMvP6+AL/sXEikizp7EGEMLz9AMqzjw7/eNrAtXU
	L5EBqn3S5iJK5h0UtyIgV1jrHoyL2pI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762763028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LyxHIh10sONol3annpWE2J2EAH/JvgyQtND7zs4cJs=;
	b=bsOiD+CoCtdk2baf0d7CIZps2GaLT+wQCwxfrmRhE6ROhuGnZxOPZFJsbMveeZE1+AQSGk
	42QWuqS1pmrcEHlZ0GvWC0Tcw5/o2sSMvP6+AL/sXEikizp7EGEMLz9AMqzjw7/eNrAtXU
	L5EBqn3S5iJK5h0UtyIgV1jrHoyL2pI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC4A113BAE;
	Mon, 10 Nov 2025 08:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iaEBOBOhEWm0KAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 10 Nov 2025 08:23:47 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 1/3] x86/alternative: Drop not needed test after call of alt_replace_call()
Date: Mon, 10 Nov 2025 09:23:37 +0100
Message-ID: <20251110082339.30144-2-jgross@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

alt_replace_call() will never return a negative value, so testing the
return value to be less than zero can be dropped.

This makes it possible to switch the return type of alt_replace_call()
and the type of insn_buff_sz to unsigned int.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/alternative.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..4f3ea50e41e8 100644
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


