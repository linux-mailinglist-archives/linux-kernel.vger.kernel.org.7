Return-Path: <linux-kernel+bounces-842670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32FEBBD465
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4163B9A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E2261B80;
	Mon,  6 Oct 2025 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Krt6Sl8L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Krt6Sl8L"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283CD25A2A5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736865; cv=none; b=SZst3EZCEkym9Tp9JRfT01/as4GVUv3i/40KrMuB5cxHiLAcT222d+Z/WUZA4Ap5AI5/vba23JM9ePgPEbcb3ofn8oczLPUdN6iCkLjHaTs3XkO0fxHIZxNvxA0ZS1lqkrGtjSrC60Pg3470VWcOhoEH9rWQQO2aB8H69Yzm7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736865; c=relaxed/simple;
	bh=iM+q3BKB2DcI3eSxAwpfnjLqEsbHfU3TXdUhciHRuYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MebLqDDkGunRG4wWQalSvwU8z8P7b/mOS3jM/uYhNjLgrdFwV1vzEe2uVyoDoX25hNCvQ8WhOqSDSSQjwYjpj3Hhq3fDmu1Yncp8+6u56zn0Oz3wpF50TjNiQwEyEZ1rfyVWZ6r6SkHg9OP2pFZLyfVeNS3z7fFz+pePudIAE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Krt6Sl8L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Krt6Sl8L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3353A336CB;
	Mon,  6 Oct 2025 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+lJl3JITVnZ5PvoaijHvwhkZFrh8LSJFU4Q15RV3Uk=;
	b=Krt6Sl8LhmPm5LkSxK8hqI/EN9rfY6cBrSO40Ndi9ngd2i1GKt5FWDAOED/pIZJ0ua5mxU
	pkpPKGFH9WS8vdrhb1LwsPTh2FTGs0LL6S//lq4+rUmgN6is5P+jRClreZQS4myGlu9omD
	QVbEWNxqk25gg4qTBlU2H3s9+Xpko1k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+lJl3JITVnZ5PvoaijHvwhkZFrh8LSJFU4Q15RV3Uk=;
	b=Krt6Sl8LhmPm5LkSxK8hqI/EN9rfY6cBrSO40Ndi9ngd2i1GKt5FWDAOED/pIZJ0ua5mxU
	pkpPKGFH9WS8vdrhb1LwsPTh2FTGs0LL6S//lq4+rUmgN6is5P+jRClreZQS4myGlu9omD
	QVbEWNxqk25gg4qTBlU2H3s9+Xpko1k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF1913A7E;
	Mon,  6 Oct 2025 07:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v6vfKxx042iuHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:47:40 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 15/21] x86/xen: Drop xen_irq_ops
Date: Mon,  6 Oct 2025 09:46:00 +0200
Message-ID: <20251006074606.1266-16-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
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
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Instead of having a pre-filled array xen_irq_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/xen/irq.c    | 20 +++++++-------------
 tools/objtool/check.c |  1 -
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 39982f955cfe..d8678c3d3971 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -40,20 +40,14 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
 
-static const typeof(pv_ops) xen_irq_ops __initconst = {
-	.irq = {
-		/* Initial interrupt flag handling only called while interrupts off. */
-		.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0),
-		.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop),
-		.irq_enable = __PV_IS_CALLEE_SAVE(BUG_func),
-
-		.safe_halt = xen_safe_halt,
-		.halt = xen_halt,
-	},
-};
-
 void __init xen_init_irq_ops(void)
 {
-	pv_ops.irq = xen_irq_ops.irq;
+	/* Initial interrupt flag handling only called while interrupts off. */
+	pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0);
+	pv_ops.irq.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop);
+	pv_ops.irq.irq_enable = __PV_IS_CALLEE_SAVE(BUG_func);
+	pv_ops.irq.safe_halt = xen_safe_halt;
+	pv_ops.irq.halt = xen_halt;
+
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a72059fcbc83..d66eb37ff294 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -593,7 +593,6 @@ static int init_pv_ops(struct objtool_file *file)
 	static const char *pv_ops_tables[] = {
 		"pv_ops",
 		"xen_cpu_ops",
-		"xen_irq_ops",
 		"xen_mmu_ops",
 		NULL,
 	};
-- 
2.51.0


