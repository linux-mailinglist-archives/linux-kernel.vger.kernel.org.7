Return-Path: <linux-kernel+bounces-811421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C9B528E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE19A1C23295
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952926B0BE;
	Thu, 11 Sep 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XpM3/q5R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XpM3/q5R"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD1263C8F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572497; cv=none; b=pTV/vsnJ/sLkQyM0h7N22GmwUUCk2/RSATzfaVzwkxjoGEsRAD/DAwo63jhhonrn6rjDRWzO4PoH5yo294/IYv84mOD4276koDQoPNclQdqOodHifLGZw6diRExb4Xhk1Em7ix63d8SV/sXbk1ox0JbBanr6mJJRz4UAqec0cEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572497; c=relaxed/simple;
	bh=BO+FbOGO6qMDZw/fUhe1xZLLKZquMHFlVR9W13/km1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXnVcG6EHddCDjrqMh7rHjC+bN8XtZLG58Tk0p4v1+aUpizSeZxC7J5WQdPoZawbVev51Vp/AnFbicPPWlZWYl37IMidHOTy3s+Kvn+R24ASFLwqAoxu/Gyed58cF2jIyne5FW4QpuRJydSiDw6mBs4Ccok+9E6PXxkJcYhqwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XpM3/q5R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XpM3/q5R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E8FF3FA79;
	Thu, 11 Sep 2025 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXkgqWs66gRpudwxgsL92xNqmAXfsCj4FMBFkbe3hWM=;
	b=XpM3/q5R+SdDzbT9VLUA+btxLhNcTUiH9doUBxnoNaMUZ7NmbFgxwaMShvs8pBeP6J2rH5
	UbhSylOLpPXY4g+76r9UuD0OXi8zf25rE3zs8hgC5RPDmSIW1GLq5vhEXb87cpObEQleJB
	9FWTk7u/SJcXP7IGylunjStCdQGiEPg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757572491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXkgqWs66gRpudwxgsL92xNqmAXfsCj4FMBFkbe3hWM=;
	b=XpM3/q5R+SdDzbT9VLUA+btxLhNcTUiH9doUBxnoNaMUZ7NmbFgxwaMShvs8pBeP6J2rH5
	UbhSylOLpPXY4g+76r9UuD0OXi8zf25rE3zs8hgC5RPDmSIW1GLq5vhEXb87cpObEQleJB
	9FWTk7u/SJcXP7IGylunjStCdQGiEPg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 044BA1372E;
	Thu, 11 Sep 2025 06:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MVANO4ptwmj+TAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:34:50 +0000
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
Subject: [PATCH 02/14] x86/paravirt: remove some unneeded struct declarations
Date: Thu, 11 Sep 2025 08:34:21 +0200
Message-ID: <20250911063433.13783-3-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
References: <20250911063433.13783-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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
X-Spam-Level: 
X-Spam-Score: -6.80

In paravirt_types.h there are some struct declarations which are not
needed. Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 6 ------
 1 file changed, 6 deletions(-)

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


