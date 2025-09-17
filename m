Return-Path: <linux-kernel+bounces-821060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A4B80442
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63963B9B73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14A330D2E;
	Wed, 17 Sep 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Aso0mjqe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Aso0mjqe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12332E755
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120761; cv=none; b=Kjncelb73udATr0Md+bDOIDXFv88BS1QkN3ED4ND/i0sHLax/ltP21htnVyDuWJZ4Zkw32fnvJlxjozGaG4eQdg89+CBdX/IazN9C8GSn2YlEKT8OtpmFBgcPi4cMkvCglti2XD0ffaxmHvhbbjJchNZrF+vzFXAmhHvot6amOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120761; c=relaxed/simple;
	bh=g6CC2FNONPR3UeWxokL84H2jZirpeaEVDeHT3iFcdRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBr8HYVBq/H2bYMb0KxhsxqdTDvv4agVwxlE44T5RZ8zMyejbeC7nVLpmftf3E3iK6eKuSaGzTsaIONwr6S315N4MEophah/5NCPCcVVvZADppEKOIDCKRkIJ4iHoSF9cmLwE3eQmsmz6feUPT+xsmD/f2I/lxSOPcODWb1ACaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Aso0mjqe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Aso0mjqe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54B9122A58;
	Wed, 17 Sep 2025 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WKL5nxiqi8IWA0cDJreLzHyLS3vd1A/8uXASUDXU6U=;
	b=Aso0mjqeGiG2YmefE7AbbLVI4YZttNhpnk7gvyQ6zCSUSG57eRGJ2HrCFlvqKyiaYvfi2a
	w98ykxv9u/sURglZHykb03fsIq0H6CYFGw5BmcfclcJiE8GXox8NUbz+VUzYr/fxO+WH7R
	zu5ZQ9zFx1/pIdYjDgrQ/6Q9sjagSiU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WKL5nxiqi8IWA0cDJreLzHyLS3vd1A/8uXASUDXU6U=;
	b=Aso0mjqeGiG2YmefE7AbbLVI4YZttNhpnk7gvyQ6zCSUSG57eRGJ2HrCFlvqKyiaYvfi2a
	w98ykxv9u/sURglZHykb03fsIq0H6CYFGw5BmcfclcJiE8GXox8NUbz+VUzYr/fxO+WH7R
	zu5ZQ9zFx1/pIdYjDgrQ/6Q9sjagSiU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4E2B1368D;
	Wed, 17 Sep 2025 14:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2DdeNjPLymjREgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:52:35 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v2 02/21] x86/paravirt: Remove some unneeded struct declarations
Date: Wed, 17 Sep 2025 16:52:01 +0200
Message-ID: <20250917145220.31064-3-jgross@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

In paravirt_types.h iand paravirt.h there are some struct declarations
which are not needed. Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V2:
- remove mm_struct from paravirt.h, too
---
 arch/x86/include/asm/paravirt.h       | 4 ----
 arch/x86/include/asm/paravirt_types.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b5e59a7ba0d0..612b3df65b1b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,10 +6,6 @@
 
 #include <asm/paravirt_types.h>
 
-#ifndef __ASSEMBLER__
-struct mm_struct;
-#endif
-
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 37a8627d8277..84cc8c95713b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -11,16 +11,11 @@
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
-struct page;
 struct thread_struct;
-struct desc_ptr;
-struct tss_struct;
 struct mm_struct;
-struct desc_struct;
 struct task_struct;
 struct cpumask;
 struct flush_tlb_info;
-struct mmu_gather;
 struct vm_area_struct;
 
 /*
@@ -205,7 +200,6 @@ struct pv_mmu_ops {
 #endif
 } __no_randomize_layout;
 
-struct arch_spinlock;
 #ifdef CONFIG_SMP
 #include <asm/spinlock_types.h>
 #endif
-- 
2.51.0


