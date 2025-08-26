Return-Path: <linux-kernel+bounces-786858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 753DEB36CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03AB1C429A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E2A24CEE8;
	Tue, 26 Aug 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SZVpr0Nu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SZVpr0Nu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7962367B3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220182; cv=none; b=kYcnFnEK0uDAgPY0eenLCnVTv8hvEdDHQOf1z1Ig9LZWL5BY0aw6/P59IdWifmB9C1YMPWiLtj2/dBgZjctaJ6wpf/M+PKfFimS3N5qxg9hHMziPH18Z0IEtsb+WK/4sMUND0C3p1BJVskSFvYbBth/oWOzJH7+7xrDl62CkfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220182; c=relaxed/simple;
	bh=NAoy/X2CbWPuBpLD+kucbAq+ArlHXXNMidY/RWNHd1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flvJTIMnR9ArbmJdJ3/q4wuMM/hM/tJzQgnRDaEBwfteDt4+nbxDgT1MqeiuZP7Kk659Pr5n3Vy7HRp51rGBOxcDTV/lCZa63IVP42uDZQdCM8cAz/wgAtgfGRh6aVDPAxYU2g8PtsHHs+JBDluxosXkjE3OH9liRXhGpwioNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SZVpr0Nu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SZVpr0Nu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB2EC1F794;
	Tue, 26 Aug 2025 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756220176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyeT+CWQEc6295XsX5Lhn3JbFSy/Dq6+JVixulzziEY=;
	b=SZVpr0NuEHu/33dqsD11Ya+/DUFraXt930BOxCXygh0FsoMbrfaVapmM2I5IT7ImOPRgP5
	hLvC4UitgxiByj5gu1tK/+GMG5JVlVrU79e4gCkTrlDgSwhe5NdNv2X4ygz1KdsgKDFfeB
	8XArM3bblCxJ29aBNZXk42wKvtET/YI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756220176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyeT+CWQEc6295XsX5Lhn3JbFSy/Dq6+JVixulzziEY=;
	b=SZVpr0NuEHu/33dqsD11Ya+/DUFraXt930BOxCXygh0FsoMbrfaVapmM2I5IT7ImOPRgP5
	hLvC4UitgxiByj5gu1tK/+GMG5JVlVrU79e4gCkTrlDgSwhe5NdNv2X4ygz1KdsgKDFfeB
	8XArM3bblCxJ29aBNZXk42wKvtET/YI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5523913A31;
	Tue, 26 Aug 2025 14:56:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwNEExDLrWi1TwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 26 Aug 2025 14:56:16 +0000
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
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 1/3] xen: rework xen_pv_domain()
Date: Tue, 26 Aug 2025 16:56:06 +0200
Message-ID: <20250826145608.10352-2-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826145608.10352-1-jgross@suse.com>
References: <20250826145608.10352-1-jgross@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Rework xen_pv_domain() to no longer use the xen_domain_type variable,
but the artificial X86_FEATURE_XENPV cpu feature.

On non-x86 architectures xen_pv_domain() can be defined as "0".

This has the advantage that a kernel not built with CONFIG_XEN_PV
will be smaller due to dead code elimination.

Set the X86_FEATURE_XENPV feature very early, as xen_pv_domain() is
used rather early, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 2 +-
 include/xen/xen.h           | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 26bbaf4b7330..4806cc28d7ca 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -382,7 +382,6 @@ static bool __init xen_check_xsave(void)
 
 static void __init xen_init_capabilities(void)
 {
-	setup_force_cpu_cap(X86_FEATURE_XENPV);
 	setup_clear_cpu_cap(X86_FEATURE_DCA);
 	setup_clear_cpu_cap(X86_FEATURE_APERFMPERF);
 	setup_clear_cpu_cap(X86_FEATURE_MTRR);
@@ -1402,6 +1401,7 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 			JMP32_INSN_SIZE);
 
 	xen_domain_type = XEN_PV_DOMAIN;
+	setup_force_cpu_cap(X86_FEATURE_XENPV);
 	xen_start_flags = xen_start_info->flags;
 	/* Interrupts are guaranteed to be off initially. */
 	early_boot_irqs_disabled = true;
diff --git a/include/xen/xen.h b/include/xen/xen.h
index a1e5b3f18d69..61854e3f2837 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -22,8 +22,15 @@ extern bool xen_pvh;
 #define xen_pvh			0
 #endif
 
+#ifdef CONFIG_X86
+#include <asm/cpufeature.h>
+
+#define xen_pv_domain()		(cpu_feature_enabled(X86_FEATURE_XENPV))
+#else
+#define xen_pv_domain()		0
+#endif
+
 #define xen_domain()		(xen_domain_type != XEN_NATIVE)
-#define xen_pv_domain()		(xen_domain_type == XEN_PV_DOMAIN)
 #define xen_hvm_domain()	(xen_domain_type == XEN_HVM_DOMAIN)
 #define xen_pvh_domain()	(xen_pvh)
 
-- 
2.43.0


