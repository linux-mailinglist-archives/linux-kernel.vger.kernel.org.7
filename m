Return-Path: <linux-kernel+bounces-810505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA8B51B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DDC1884D73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1C31DD93;
	Wed, 10 Sep 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PTAN7E6a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RBkyf4AU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PTAN7E6a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RBkyf4AU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229055464E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517918; cv=none; b=geJLGk68kuMpraZqIQLAlCtTqNZgviVuvLk4EPbN36eRdrIYue4ZrmrX73WJaqzoiKrkefur4wDSDSMJ9UhNuY/SlwiYnGHeoFmjvBs8fQ70qhC3Fl7dPhgZcG71tScBI8DDouSvZW/wwh+j5qSzWADH8TMgpCm3EL760OTxUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517918; c=relaxed/simple;
	bh=0/qXKEtiQYlwCA7VcjGc9Hz66/v2P6i7382d35lfhM4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifLrjJlF3k5rJghywRZLnlnvJ57H2LAcUuQgqZGVW92Vj+LnW+YCfZ/bVjneIdSAXu/JDL54+b987c48yszp5yoiEhRJaaG/2SbwQZXT/E5HHvxSxxNzchssA/R6aVKBj+VtloVYwSeGs8yprTtyw2QCQivrWtRpe18obgxmtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PTAN7E6a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RBkyf4AU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PTAN7E6a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RBkyf4AU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69F4B3860B;
	Wed, 10 Sep 2025 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757517914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YcUcvdFrQ2ayFwyzcqhwFNl1qTUwgQFOMdRA4aMHF0=;
	b=PTAN7E6ao2Zaa/hWc4sdJlbP7QwNUsfl+P9juekiBp1axHD/IhSgwosKsyB6lPoS8enk2c
	v04EKlzzXUNujDDrt/YXz5b+5wVduTaQEOVWPfgIT/uPMZQbn3uVVKR4beQ+tZgt+bW+v4
	Oo0BcjR5++TubzsPaxxThU1gT0dkSAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757517914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YcUcvdFrQ2ayFwyzcqhwFNl1qTUwgQFOMdRA4aMHF0=;
	b=RBkyf4AULhWmRUBBj40c1wLB7Qa3PAaG19vF5nAlbGENqNZsypODEKW+xxyqXn3y7k/sUI
	FSJrO0LCvyy2YEAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757517914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YcUcvdFrQ2ayFwyzcqhwFNl1qTUwgQFOMdRA4aMHF0=;
	b=PTAN7E6ao2Zaa/hWc4sdJlbP7QwNUsfl+P9juekiBp1axHD/IhSgwosKsyB6lPoS8enk2c
	v04EKlzzXUNujDDrt/YXz5b+5wVduTaQEOVWPfgIT/uPMZQbn3uVVKR4beQ+tZgt+bW+v4
	Oo0BcjR5++TubzsPaxxThU1gT0dkSAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757517914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1YcUcvdFrQ2ayFwyzcqhwFNl1qTUwgQFOMdRA4aMHF0=;
	b=RBkyf4AULhWmRUBBj40c1wLB7Qa3PAaG19vF5nAlbGENqNZsypODEKW+xxyqXn3y7k/sUI
	FSJrO0LCvyy2YEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D7A13301;
	Wed, 10 Sep 2025 15:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +5XFE1qYwWgvNgAAD6G6ig
	(envelope-from <fvogt@suse.de>); Wed, 10 Sep 2025 15:25:14 +0000
From: Fabian Vogt <fvogt@suse.de>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, Marvin Friedrich <marvin.friedrich@suse.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: [PATCH] riscv: kprobes: Fix probe address validation
Date: Wed, 10 Sep 2025 17:25:13 +0200
Message-ID: <6191817.lOV4Wx5bFT@fvogt-thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30

When adding a kprobe such as "p:probe/tcp_sendmsg _text+15392192",
arch_check_kprobe would start iterating all instructions starting from
_text until the probed address. Not only is this very inefficient, but
literal values in there (e.g. left by function patching) are
misinterpreted in a way that causes a desync.

Fix this by doing it like x86: start the iteration at the closest
preceding symbol instead of the given starting point.

Fixes: 87f48c7ccc73 ("riscv: kprobe: Fixup kernel panic when probing an illegal position")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Signed-off-by: Marvin Friedrich <marvin.friedrich@suse.com>
---
 arch/riscv/kernel/probes/kprobes.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index c0738d6c6498..8723390c7cad 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -49,10 +49,15 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 	post_kprobe_handler(p, kcb, regs);
 }
 
-static bool __kprobes arch_check_kprobe(struct kprobe *p)
+static bool __kprobes arch_check_kprobe(unsigned long addr)
 {
-	unsigned long tmp  = (unsigned long)p->addr - p->offset;
-	unsigned long addr = (unsigned long)p->addr;
+	unsigned long tmp, offset;
+
+	/* start iterating at the closest preceding symbol */
+	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
+		return false;
+
+	tmp = addr - offset;
 
 	while (tmp <= addr) {
 		if (tmp == addr)
@@ -71,7 +76,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if ((unsigned long)insn & 0x1)
 		return -EILSEQ;
 
-	if (!arch_check_kprobe(p))
+	if (!arch_check_kprobe((unsigned long)p->addr))
 		return -EILSEQ;
 
 	/* copy instruction */
-- 
2.51.0





