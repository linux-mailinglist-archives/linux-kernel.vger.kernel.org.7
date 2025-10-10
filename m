Return-Path: <linux-kernel+bounces-848490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12CBCDE16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054DD546832
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E826B765;
	Fri, 10 Oct 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6Yuy9Fz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A4258ECB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111244; cv=none; b=gKyJIkGXFHlvu9TBldaNSqgvypP0oqJsxWGyPg0Nr0IHKND6DFnM+mfO67javmfD3tBddtGiXiNiPQtuVh0x5up4hRweC+unGyLsGcwAiMngiyhJdga/B8iTRMzQr3M9DkYYpa4MBFcTdMXsQsGQKCZ4grT2fb6whHoLrcvJSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111244; c=relaxed/simple;
	bh=z9azdQ3tAjj8W6CUyGNM0oLwsd5ab0jCguNokgHO0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYhmw2hCfRF0raf5eNdV4JffMlhJTcmErunUY72Y4mpGsUpd5ql+whAyABSQVWKJotPJnVkRGUMQ7VpBL+ZVuWjwx/n96xDoFLDtyHoMW36b6+WaqNC5m02wSeND+G06JhheJFvBiOlARkvx+kqUZXkR1L0fpQ1dDTbPw/wMTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6Yuy9Fz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUsWRA0PhCMnZLZEkKPa9puqLJ49gF+6GXOwWTaFVY4=;
	b=g6Yuy9FzV4ez408BW1bfCJS7bjXjx46dHRckiRu9y0gZuRBJpD1fWzNmxrGM5amYO3swuo
	c3pkKLF+K2xWhrAluIwEPe5lP0E8gGdw/TSNM2zKu+n2Wooztb5Ez1PoDFbbb9BoaoWIfK
	xSd/PGPv9nzaxhKe9eh1OuRNfLIUnnc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-ZEfMxigJNYmrubTlAi7LkQ-1; Fri,
 10 Oct 2025 11:47:20 -0400
X-MC-Unique: ZEfMxigJNYmrubTlAi7LkQ-1
X-Mimecast-MFC-AGG-ID: ZEfMxigJNYmrubTlAi7LkQ_1760111235
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B87F195608C;
	Fri, 10 Oct 2025 15:47:15 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B7571800576;
	Fri, 10 Oct 2025 15:47:00 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v6 25/29] x86/mm: Make INVPCID type macros available to assembly
Date: Fri, 10 Oct 2025 17:38:35 +0200
Message-ID: <20251010153839.151763-26-vschneid@redhat.com>
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A later commit will introduce a pure-assembly INVPCID invocation, allow
assembly files to get the type definitions.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/invpcid.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
index 734482afbf81d..27ae75c2d7fed 100644
--- a/arch/x86/include/asm/invpcid.h
+++ b/arch/x86/include/asm/invpcid.h
@@ -2,6 +2,13 @@
 #ifndef _ASM_X86_INVPCID
 #define _ASM_X86_INVPCID
 
+#define INVPCID_TYPE_INDIV_ADDR		0
+#define INVPCID_TYPE_SINGLE_CTXT	1
+#define INVPCID_TYPE_ALL_INCL_GLOBAL	2
+#define INVPCID_TYPE_ALL_NON_GLOBAL	3
+
+#ifndef __ASSEMBLER__
+
 static inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
@@ -17,11 +24,6 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 		     :: [desc] "m" (desc), [type] "r" (type) : "memory");
 }
 
-#define INVPCID_TYPE_INDIV_ADDR		0
-#define INVPCID_TYPE_SINGLE_CTXT	1
-#define INVPCID_TYPE_ALL_INCL_GLOBAL	2
-#define INVPCID_TYPE_ALL_NON_GLOBAL	3
-
 /* Flush all mappings for a given pcid and addr, not including globals. */
 static inline void invpcid_flush_one(unsigned long pcid,
 				     unsigned long addr)
@@ -47,4 +49,6 @@ static inline void invpcid_flush_all_nonglobals(void)
 	__invpcid(0, 0, INVPCID_TYPE_ALL_NON_GLOBAL);
 }
 
+#endif /* __ASSEMBLER__ */
+
 #endif /* _ASM_X86_INVPCID */
-- 
2.51.0


