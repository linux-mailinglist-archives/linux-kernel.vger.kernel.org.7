Return-Path: <linux-kernel+bounces-810657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D39B51D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0B1B274B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95E334393;
	Wed, 10 Sep 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jBzG82h5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I7Yr/Ycg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jBzG82h5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I7Yr/Ycg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121718871F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521303; cv=none; b=tPoE8izW2QwLa0a18LubPUp/9bavz+pb3rOduRP2Rqjooi6XTkWIQJsAXcuHpZyH+srMocu+Iyiw/RQMKIBk6NkrX9Ot82bPiQbsjpdgd2aIRCnIJYEM+ustHlvkAI27oKgtcrjBhd16ZkdO+LT2Fn7QOQIr2vcQVyd069DB0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521303; c=relaxed/simple;
	bh=3s2iv5bCAG5HXlN433WWnj2sn+vaY4Ioad2qHQeGPUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDdNU6dIJIFD3boy7aZiR3vbZMTzZgrM6Og5qu+cKJfhyvHrlJj7VhxuXnidoYm6DjsVd55rrROVR7FyP0PAPr3W9CuzYNUbc/6aQhl1CPI7WVN4IxYsmK2U6PmYF0V5dqsPHxPIm+R/OkOiGOBTPlIcXJOncsLr7LDxSi13zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jBzG82h5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I7Yr/Ycg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jBzG82h5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I7Yr/Ycg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69B8F66E1A;
	Wed, 10 Sep 2025 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757521298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0swCQDk/Ohn3JC99L22z/GzKY9wy8JSTP88vXa2Cj+U=;
	b=jBzG82h5v081yjJ7ICbL2jgNZb6QoGpB4dHbUHsUmWa6kxz7YjsfV9pylvCNrWnr9jmr7/
	x/G7aIF/WcwyiThRCcKDgkMtvrAhNsw7ZQiqR22C9yzrk5xU7rSKbkJZuueLJtq+ODPgtx
	cKP7xp9H8dZF8joCiXUnsFcUyJwcGwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757521298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0swCQDk/Ohn3JC99L22z/GzKY9wy8JSTP88vXa2Cj+U=;
	b=I7Yr/YcgXraBe+ayWihNqzkPGL8xpYicg7kx4wblY/XrTFh0EhNTJOgM70EiSv9csOu0WD
	BHlQVt+iZThz66Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jBzG82h5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="I7Yr/Ycg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757521298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0swCQDk/Ohn3JC99L22z/GzKY9wy8JSTP88vXa2Cj+U=;
	b=jBzG82h5v081yjJ7ICbL2jgNZb6QoGpB4dHbUHsUmWa6kxz7YjsfV9pylvCNrWnr9jmr7/
	x/G7aIF/WcwyiThRCcKDgkMtvrAhNsw7ZQiqR22C9yzrk5xU7rSKbkJZuueLJtq+ODPgtx
	cKP7xp9H8dZF8joCiXUnsFcUyJwcGwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757521298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0swCQDk/Ohn3JC99L22z/GzKY9wy8JSTP88vXa2Cj+U=;
	b=I7Yr/YcgXraBe+ayWihNqzkPGL8xpYicg7kx4wblY/XrTFh0EhNTJOgM70EiSv9csOu0WD
	BHlQVt+iZThz66Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B692A13310;
	Wed, 10 Sep 2025 16:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TsBbKZGlwWjCRwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 10 Sep 2025 16:21:37 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH RESEND] x86/split_lock: Warn for bus locks once for each task
Date: Wed, 10 Sep 2025 17:21:26 +0100
Message-ID: <20250910162126.157894-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.51.0
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 69B8F66E1A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Sometimes, it's possible to see long-running services that keep pounding
the bus_lock logic in a long-standing way that does not trigger
ratelimiting, but still floods the dmesg nonetheless, over time.

Fix it by using current->reported_split_lock, which was previously
used for the split_lock handling. In this way, bus_lock #DB's are only
warned once in the dmesg, for each task that hits a bus lock.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
This is already reflected in the documentation for bus lock, as "Warn
once per task and and continues to run.".

Resend since the first mail had accidentally no mailing list in CC.

 arch/x86/kernel/cpu/bus_lock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 981f8b1f0792..71342e6244e3 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -335,8 +335,11 @@ void handle_bus_lock(struct pt_regs *regs)
 		/* Warn on the bus lock. */
 		fallthrough;
 	case sld_warn:
-		pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
+		if (!current->reported_split_lock) {
+			pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, regs->ip);
+			current->reported_split_lock = 1;
+		}
 		break;
 	case sld_fatal:
 		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
-- 
2.51.0


