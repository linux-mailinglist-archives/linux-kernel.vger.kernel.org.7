Return-Path: <linux-kernel+bounces-757748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E35B1C63A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F297418C3160
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBA28B3F1;
	Wed,  6 Aug 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHwfoHGk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF828A40F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484344; cv=none; b=AMEd8NORkikbX6QpB37pvAN/nYIB7sZ+8ZA6sloYLggm6h4nhI9/sZk8SmnAoy8bQZDKHQ9FHiuwQP4HcNuPv7x87Jq2y0LmbNO/WmptURzkAZQE3S/cvslke0WWiPDT/fJaBcvELbSxxDYghjEp1as+M7h214IHWxT0Un1U0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484344; c=relaxed/simple;
	bh=FcPEm8lOnxHH1CgNpU25ul24aFVZtNg3k6tJ59RoDms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYq1MihqoVVntDU/2iLz3Bhal5QjQgbArePj4jGks3W7wqdIf/0JiVPGoDOJnVLY+0nW5LIqUkaQdsEg14vGSOzrKut3p1gYrrdAgLeCO47rUaqfKlkEOWi9pVZEj9suAjfzunzzfng1dBQnoopM781ZphNOQxcDqEc8GE7q08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHwfoHGk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuEYNLs8nZHaI3JfCzrkQJfzGXuaVyeyDAxWu+MXIfY=;
	b=RHwfoHGkOxCzhb8Tl6sVLgCqDBJSWZ7Vn4MeSJd9AEEILg3l0ndN9sZJo1QURbuvHgI+Qi
	MFcdhH2dYPcgz2yJvBMtHVdd/CqXDzKc8rKKNlWT1r6t3R/+hmv1C5q/gX6eqk2nWikaun
	0GA2dTjoUwpRnpMZJlYuvuzW9habEx0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-OfrScW-YMkmgWUkUUZWviQ-1; Wed,
 06 Aug 2025 08:45:38 -0400
X-MC-Unique: OfrScW-YMkmgWUkUUZWviQ-1
X-Mimecast-MFC-AGG-ID: OfrScW-YMkmgWUkUUZWviQ_1754484337
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D85A1955D4F;
	Wed,  6 Aug 2025 12:45:36 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com [10.33.192.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 178FD195608F;
	Wed,  6 Aug 2025 12:45:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/headers: Replace __ASSEMBLY__ stragglers with __ASSEMBLER__
Date: Wed,  6 Aug 2025 14:45:32 +0200
Message-ID: <20250806124532.65176-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Huth <thuth@redhat.com>

After converting the __ASSEMBLY__ statements to __ASSEMBLER__ in
commit 24a295e4ef1ca ("x86/headers: Replace __ASSEMBLY__ with
__ASSEMBLER__ in non-UAPI headers"), some new code has been
added that uses __ASSEMBLY__ again. Convert these stragglers, too.

This is a mechanical patch, done with a simple "sed -i" command.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/include/asm/irqflags.h      | 4 ++--
 arch/x86/include/asm/percpu.h        | 2 +-
 arch/x86/include/asm/runtime-const.h | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index b30e5474c18e1..5feaac1d235f0 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -77,7 +77,7 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 #endif
 
 #ifndef CONFIG_PARAVIRT
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -95,7 +95,7 @@ static __always_inline void halt(void)
 {
 	native_halt();
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PARAVIRT */
 
 #ifdef CONFIG_PARAVIRT_XXL
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b0d03b6c279be..abffb3ed9f926 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,7 +20,7 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#else /* !__ASSEMBLY__: */
+#else /* !__ASSEMBLER__: */
 
 #include <linux/args.h>
 #include <linux/build_bug.h>
diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea6..8fcd2612a85c0 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro RUNTIME_CONST_PTR sym reg
 	movq	$0x0123456789abcdef, %\reg
@@ -12,7 +12,7 @@
 	.popsection
 .endm
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
@@ -70,5 +70,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
-- 
2.50.1


