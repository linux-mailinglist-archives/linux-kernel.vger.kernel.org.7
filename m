Return-Path: <linux-kernel+bounces-821078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E575B8052F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE141C246C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1D33B46A;
	Wed, 17 Sep 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z1ZcHFU3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z1ZcHFU3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC72330D31
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120864; cv=none; b=W04fkzScwht8rHDydfB7AGaxpifa7agapiJY97U2LRaQmyIM6aiW5iAeGBNneEpNEwewbX0J7MHLX7khfqkkNADfu1qfRdiTD+q77MvIrM/JL/ePCr/GRCcy8AOMW/neg8STSqN7viRZQSRrNroZ/8AcdfCH1nRb92CjFqJQOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120864; c=relaxed/simple;
	bh=KhS2hR8yS4ddPWKetGb5Mg/+66yHTxjFfkIrs4V1taA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBbDxXjJa956d/f04mnHfCYkgBukvrNUHmvwdM0JIaygOSUl9xu+RjUpmzxbg5JMqqz0rcZqLKGHYglf/4B5fMDeUGCJm+8scWeekN0W9X0X33DQBkue3I66b2Cno+5QiDp/8Fxkr8Xko40SmRP3MFiyRw7P582EvQyIRW4rjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z1ZcHFU3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z1ZcHFU3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2C612221C;
	Wed, 17 Sep 2025 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88n5mUbHShWHoW/2+l8tGp7eL9ycecbkhiJbnud3hQM=;
	b=Z1ZcHFU33ZfTpl++gUxPtbyoGWZByO9aLOxMssnBf3Sqiq4h/vOC95unL5UnvdxIUqzYKx
	kXGg3lE8ILOjYvLhdO26CzGkamUJSlEhP5CtxeFCf6bQwVOf1yHxbcqlNZ5aBQk3aM0156
	ksZ95NDp3+7cRPmWMA91EzVzbc2iRrs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88n5mUbHShWHoW/2+l8tGp7eL9ycecbkhiJbnud3hQM=;
	b=Z1ZcHFU33ZfTpl++gUxPtbyoGWZByO9aLOxMssnBf3Sqiq4h/vOC95unL5UnvdxIUqzYKx
	kXGg3lE8ILOjYvLhdO26CzGkamUJSlEhP5CtxeFCf6bQwVOf1yHxbcqlNZ5aBQk3aM0156
	ksZ95NDp3+7cRPmWMA91EzVzbc2iRrs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69AEC1368D;
	Wed, 17 Sep 2025 14:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXhdGJnLymiJEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:54:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 19/21] x86/paravirt: Allow pv-calls outside paravirt.h
Date: Wed, 17 Sep 2025 16:52:18 +0200
Message-ID: <20250917145220.31064-20-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
References: <20250917145220.31064-1-jgross@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

In order to prepare for defining paravirt functions outside of
paravirt.h, don't #undef the paravirt call macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 62399f5d037d..ba6b14b6f36a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -588,22 +588,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 }
 #endif
 
-
-/* Make sure as little as possible of this mess escapes. */
-#undef PARAVIRT_CALL
-#undef __PVOP_CALL
-#undef __PVOP_VCALL
-#undef PVOP_VCALL0
-#undef PVOP_CALL0
-#undef PVOP_VCALL1
-#undef PVOP_CALL1
-#undef PVOP_VCALL2
-#undef PVOP_CALL2
-#undef PVOP_VCALL3
-#undef PVOP_CALL3
-#undef PVOP_VCALL4
-#undef PVOP_CALL4
-
 void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLER__ */
-- 
2.51.0


