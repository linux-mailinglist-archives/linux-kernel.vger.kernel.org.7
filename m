Return-Path: <linux-kernel+bounces-842660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5DBBD420
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5D43B8F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0935D25F995;
	Mon,  6 Oct 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mj0SvOTa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mj0SvOTa"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF322D4C3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736805; cv=none; b=DumksUgDuo7zgFLGbuWpZJrM7/rAYGNtzSGGZj6QtPWcnNND7jxpikftT8Wzxmj/pzE2jyVF8uisGvrD9KsBf8szhMpM2Gu1/sV8ZQ+8BQhTu3nuukJb57dQBsPJzTCVfrbFVf45vEMM6ck2BlZ3Z/EJO2DCf6jIBG4KVWA2IWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736805; c=relaxed/simple;
	bh=zJ2WnAvaR74bN2jwREMyESEBG5oSbLo3KzKkhzpn8zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7HIcSTXAppZfqQb83iHxpiEESvtMZhIWR3kg0c/nh1BzDV1I0NqFntc8VHmnZwoLJS3A8j6Mjahq6tyXNciIaOBkM1ayQfi0a8Jj5KKp9yN7G3/fNZxhliXNg9YL5kNimAg/WKSbPSBthGjfMOnQmbBaQZOIK/wHIPsUZPbBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mj0SvOTa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mj0SvOTa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D837A1F789;
	Mon,  6 Oct 2025 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvM0T1diHWLFh/V+o8K67eUpGrN/UfnAd4xBYpsVxkk=;
	b=Mj0SvOTaiIuBEpCQDoFUpGXaEPQdCLGR3daX6OuudI64Ra6trTD7+IdfsEixk15QUFCvgT
	u1S/J/t7UvHt+0FQjCC2eF78iJmjm1bW7g5177ojixoHO8zoURCy7g9ZExN3zhcntfthPG
	48Ixziy2rUm+DhnmH/OyrvVUV1lk+rI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Mj0SvOTa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvM0T1diHWLFh/V+o8K67eUpGrN/UfnAd4xBYpsVxkk=;
	b=Mj0SvOTaiIuBEpCQDoFUpGXaEPQdCLGR3daX6OuudI64Ra6trTD7+IdfsEixk15QUFCvgT
	u1S/J/t7UvHt+0FQjCC2eF78iJmjm1bW7g5177ojixoHO8zoURCy7g9ZExN3zhcntfthPG
	48Ixziy2rUm+DhnmH/OyrvVUV1lk+rI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBF8313A7E;
	Mon,  6 Oct 2025 07:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MyJwLN9z42hcHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:46:39 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/21] paravirt: Remove asm/paravirt_api_clock.h
Date: Mon,  6 Oct 2025 09:45:50 +0200
Message-ID: <20251006074606.1266-6-jgross@suse.com>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D837A1F789
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[37];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,infradead.org:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,broadcom.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linaro.org,goodmis.org,google.com,suse.de,lists.infradead.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -3.01

All architectures supporting CONFIG_PARAVIRT share the same contents
of asm/paravirt_api_clock.h:

  #include <asm/paravirt.h>

So remove all incarnations of asm/paravirt_api_clock.h and remove the
only place where it is included, as there asm/paravirt.h is included
anyway.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/paravirt_api_clock.h       | 1 -
 arch/arm64/include/asm/paravirt_api_clock.h     | 1 -
 arch/loongarch/include/asm/paravirt_api_clock.h | 1 -
 arch/powerpc/include/asm/paravirt_api_clock.h   | 2 --
 arch/riscv/include/asm/paravirt_api_clock.h     | 1 -
 arch/x86/include/asm/paravirt_api_clock.h       | 1 -
 kernel/sched/sched.h                            | 1 -
 7 files changed, 8 deletions(-)
 delete mode 100644 arch/arm/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/powerpc/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
 delete mode 100644 arch/x86/include/asm/paravirt_api_clock.h

diff --git a/arch/arm/include/asm/paravirt_api_clock.h b/arch/arm/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/arm/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/arm64/include/asm/paravirt_api_clock.h b/arch/arm64/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/arm64/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/loongarch/include/asm/paravirt_api_clock.h b/arch/loongarch/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/loongarch/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/powerpc/include/asm/paravirt_api_clock.h b/arch/powerpc/include/asm/paravirt_api_clock.h
deleted file mode 100644
index d25ca7ac57c7..000000000000
--- a/arch/powerpc/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/paravirt.h>
diff --git a/arch/riscv/include/asm/paravirt_api_clock.h b/arch/riscv/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/riscv/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/arch/x86/include/asm/paravirt_api_clock.h b/arch/x86/include/asm/paravirt_api_clock.h
deleted file mode 100644
index 65ac7cee0dad..000000000000
--- a/arch/x86/include/asm/paravirt_api_clock.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/paravirt.h>
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60..0d0fa13cab5c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -84,7 +84,6 @@ struct cpuidle_state;
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
-# include <asm/paravirt_api_clock.h>
 #endif
 
 #include <asm/barrier.h>
-- 
2.51.0


